const express = require('express');
const { body, validationResult } = require('express-validator');
const router = express.Router();

const spotifyController = require('../controllers/spotifyController');

// Validation rules for adding a new song
const songValidationRules = [
    body('title').notEmpty().withMessage('Title is required'),
    body('artist').notEmpty().withMessage('Artist is required'),
    body('duration').notEmpty().withMessage('Duration is required'),
    body('album').notEmpty().withMessage('Album is required'),
    // Add other validation rules as needed
];

router.get('/test', (req, res) => {
    res.json({ message: "Test route is working!" });

// ... (other code remains unchanged)
});

// ... (other code remains unchanged)

// Middleware to check for validation errors
const validate = (req, res, next) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        return res.status(400).json({ errors: errors.array() });

// ... (other code remains unchanged)
    }
    next();
};

router.get('/songs', (req, res, next) => {
    console.log("GET /songs route hit");
    // Modify to handle filtering based on searchTerm if necessary
    spotifyController.getSongs(req, res, next);
});

// ... (other code remains unchanged)

router.post('/songs/add', songValidationRules, validate, (req, res, next) => {
    console.log("POST /songs/add route hit");
    spotifyController.addSong(req, res, next);
});

// ... (other code remains unchanged)

router.put('/songs/update/:id', songValidationRules, validate, (req, res, next) => {
    console.log("PUT /songs/update/:id route hit");
    spotifyController.updateSong(req, res);
});

// ... (other code remains unchanged)

router.delete('/songs/delete/:id', (req, res, next) => {
    console.log("DELETE /songs/delete/:id route hit");
    spotifyController.softDeleteSong(req, res);
});

// ... (other code remains unchanged)

router.get('/exportData', (req, res, next) => {
    console.log("GET /exportData route hit");
    spotifyController.exportSongsData(req, res, next);
});

// ... (other code remains unchanged)

module.exports = router;
