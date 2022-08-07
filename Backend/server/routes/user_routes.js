const express = require('express');
const router = express.Router();
module.exports = router

const controller = require('../controllers/user_controller')
const UserController = new controller;

const jwtAuthentication = require('../Middleware/jwt-authentication').jwtAuthentication;

//user routes
router.get('/get-users',jwtAuthentication, UserController.getAllUsers);
router.get('/get-user/:id', UserController.getUserDetail);
router.post('/register', UserController.createUser);
router.post('/login', UserController.login_user);
router.post('/logout', UserController.logout_user);
router.post('/new-token', UserController.new_access_token);

