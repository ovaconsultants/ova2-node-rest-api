const transporter = require('../nodemailer-config');

// Service function for sending emails
const sendEmailService = async ({ to, subject, text, html }) => {
  const mailOptions = {
    from: process.env.GMAIL_USER,
    to,
    subject,
    text,
    html,
  };

  return transporter.sendMail(mailOptions);
};

module.exports = { sendEmailService };
