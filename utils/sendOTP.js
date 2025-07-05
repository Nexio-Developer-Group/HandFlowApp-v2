const nodemailer = require('nodemailer');


const transporter = nodemailer.createTransport({
  host: "smtp.gmail.com",
  port: 465,
  secure: true, // use SSL
  auth: {
    user: process.env.EMAIL_USER,
    pass: process.env.EMAIL_PASS,
  },
});

console.log("EMAIL_USER:", process.env.EMAIL_USER);
console.log("EMAIL_PASS:", process.env.EMAIL_PASS ? "✅ Loaded" : "❌ Not Loaded");


// ✅ Add this block to test connection:
transporter.verify((error, success) => {
  if (error) {
    console.error("Transport error:", error);
  } else {
    console.log("Email transporter connected!");
  }
});

const sendOTPViaEmail = async (email, otp) => {
  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: email,
    subject: 'Your OTP Code',
    html: `<p>Your OTP is <b>${otp}</b>. It is valid for ${process.env.OTP_EXPIRY_MINUTES} minutes.</p>`
  };
  await transporter.sendMail(mailOptions);
};

module.exports = { sendOTPViaEmail };
