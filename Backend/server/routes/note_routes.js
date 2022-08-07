const app = require('../server-setup/app-config').app;
const express = require('express');
const router = express.Router();
const NotesController = require('../controllers/note_controller').NotesController;
const jwtAuthentication = require('../Middleware/jwt-authentication').jwtAuthentication;

module.exports = router;


router.post('/create-note', jwtAuthentication, NotesController.createNote);
router.get('/get-notes/:id',jwtAuthentication, NotesController.getUserNotes);
router.get('/get-urgent-notes/:id',jwtAuthentication, NotesController.getUserUrgentNotes);
router.patch('/update-note',jwtAuthentication, NotesController.updateNote);






