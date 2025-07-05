const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const User = require('../models/User');
const generateOTP = require('../utils/generateOTP');
const { sendOTPViaEmail } = require('../utils/sendOTP');
const { default: mongoose } = require('mongoose');

exports.register = async ({ username, email, mobile, password }) => {
  const userExists = await User.findOne({ $or: [{ username }, { email }, { mobile }] });
  if (userExists) throw new Error('Username, email or mobile already exists.');
  const hash = await bcrypt.hash(password, 12);
    const userId = new mongoose.Types.ObjectId().toString();
  await User.create({userId, username, email, mobile, password: hash });
  const user = await User.findOne({userId: userId});
  const token = jwt.sign({ id: user.userId }, process.env.JWT_SECRET, { expiresIn: '1d' });
  return token;

};

exports.login = async (identifier, password) => {
  const user = await User.findOne({ $or: [{ email: identifier }, { mobile: identifier }] });
  if (!user || !(await bcrypt.compare(password, user.password))) throw new Error('Invalid credentials');
  const token = jwt.sign({ id: user.userId }, process.env.JWT_SECRET, { expiresIn: '1d' });
  return token;
};

exports.sendResetOTP = async ({ identifier }) => {
  const user = await User.findOne({ email: identifier });
  if (!user) throw new Error('User not found');
  const otp = generateOTP();
  user.otp = await bcrypt.hash(otp, 10);
  user.otpExpires = Date.now() + parseInt(process.env.OTP_EXPIRY_MINUTES) * 60 * 1000;
  await user.save();
  await sendOTPViaEmail(user.email, otp);
};

exports.verifyOTPAndReset = async ({ identifier, otp, newPassword }) => {
  const user = await User.findOne({ email: identifier });
  if (!user || !user.otpExpires || Date.now() > user.otpExpires) throw new Error('Invalid or expired OTP');
  const isMatch = await bcrypt.compare(otp, user.otp);
  if (!isMatch) throw new Error('Incorrect OTP');
  user.password = await bcrypt.hash(newPassword, 12);
  user.otp = null;
  user.otpExpires = null;
  await user.save();
};