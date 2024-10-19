const { sendEmailService } = require('../services/emailService');

// Controller function to handle email sending
const sendEmail = async (req, res) => {
  const { to, subject, text, html } = req.body;

  try {
    const info = await sendEmailService({ to, subject, text, html });
    res.status(200).json({ message: 'Email sent successfully!', info });
  } catch (error) {
    res.status(500).json({ message: 'Failed to send email', error });
  }
};

module.exports = { sendEmail };
