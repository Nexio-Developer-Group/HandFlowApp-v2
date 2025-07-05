const express = require('express');
const { body } = require('express-validator');
const validate = require('../middleware/validateRequest');
const auth = require('../controller/auth.controller');
const authMiddleware = require('../middleware/auth');

const router = express.Router();

router.post('/register', [
  body('username').isAlphanumeric(),
  body('email').isEmail(),
  body('mobile').isMobilePhone(),
  body('password').isLength({ min: 8 })
], validate, auth.register);

router.post('/login', [
  body('identifier').notEmpty(),
  body('password').notEmpty()
], validate, auth.login);

router.post('/forgot-password', [
  body('identifier').isEmail()
], validate, auth.forgotPassword);

router.post('/reset-password', [
  body('identifier').isEmail(),
  body('otp').isLength({ min: 6 }),
  body('newPassword').isLength({ min: 8 })
], validate, auth.resetPassword);

router.get('/protected', authMiddleware, (req, res) => {
  res.json({ message: 'Access granted to protected route', user: req.user });
});

module.exports = router;
