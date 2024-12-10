const express = require('express');
const { protect } = require('../middleware/auth_middleware.js');
const { viewProfile, editProfile } = require('../controllers/userController.js');

const router = express.Router();

router.get('/profile', protect, viewProfile);
router.put('/profile', protect, editProfile);

module.exports = router;
