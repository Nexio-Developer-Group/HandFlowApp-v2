const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema({
  userId: { type: String, unique: true, required: true },
  username: { type: String, unique: true, required: true },
  email: { type: String, unique: true, required: true },
  mobile: { type: String, unique: true, required: true },
  password: { type: String, required: true },
  otp: { type: String },
  otpExpires: { type: Date },
});

module.exports = mongoose.model('User', UserSchema);
