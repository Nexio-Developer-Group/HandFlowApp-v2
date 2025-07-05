const express = require('express');
const cors= require('cors');
const dotenv = require('dotenv');
// Load env vars
dotenv.config();
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
const connectDB = require('./config/db');
const authRoutes = require('./routes/auth.routes');



// DB connection
connectDB();

const app = express();
app.use(cors());
app.use(express.urlencoded({ extended: true }));

// Middlewares
app.use(helmet());
app.use(express.json());

// Rate Limiting
app.use(rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // Limit each IP to 100 requests per `window`
}));

// Routes
app.use('/api/auth', authRoutes);

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: err.message });
});

module.exports = app;
