const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'ova2consultancy@gmail.com',
    pass: 'qkzuriarvgqettxq',
  },
});

module.exports = transporter;
