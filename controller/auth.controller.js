const authService = require('../services/auth.service');

exports.register = async (req, res, next) => {
  try {
    const token = await authService.register(req.body);
    res.status(201).json({ message: 'User registered successfully', token });
  } catch (error) {
    next(error);
  }
};

exports.login = async (req, res, next) => {
  try {
    const token = await authService.login(req.body.identifier, req.body.password);
    res.status(200).json({ token });
  } catch (error) {
    next(error);
  }
};

exports.forgotPassword = async (req, res, next) => {
  try {
    await authService.sendResetOTP(req.body);
    res.status(200).json({ message: 'OTP sent to registered email' });
  } catch (error) {
    next(error);
  }
};

exports.resetPassword = async (req, res, next) => {
  try {
    await authService.verifyOTPAndReset(req.body);
    res.status(200).json({ message: 'Password updated successfully' });
  } catch (error) {
    next(error);
  }
};
