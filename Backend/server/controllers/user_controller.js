const db = require('../server-setup/sql-db/database');
const jwt = require('jsonwebtoken');

const secure_password = require('../services/security').secure_password;
const verify_details = require('../services/security').verify_details;
const check_user_exists = require('../services/security').check_user_exists;
const get_user_info = require('../services/security').get_user_info;
const generate_access_token = require('../services/jwt').generate_access_token;
const generate_refresh_token = require('../services/jwt').generate_refresh_token;
const register_user = require('../services/security').register_user;
const checkBlackListToken = require('../services/security').checkBlackListToken;

const redis_client = require('../services/redis-cache').redis_client;
const { json } = require('express');



class UserController {


    getAllUsers = async (req, res) => {
        const query = 'SELECT id, username, email, first_name, last_name FROM USERS_TABLE';
        db.query(query, async (error, results) => {
            if (error != null) return res.status(400).json(err);
            return res.status(200).json(results);
        });
    };


   
    getUserDetail = async (req, res) => {
        const user_id = req.params['id'];
        const query = `SELECT id, email, username, first_name, last_name FROM USERS_TABLE WHERE id = ${user_id}`

        db.query(query, async (error, results) => {
            if (error != null) return res.status(400).json(err);
            return res.status(200).json(results[0]); 
        })

    };



    createUser = async(req, res) => {
        let user = req.body;
        
        const pass_obj = secure_password(user.password);
        let user_data = [user['email'], user['username'], user['first_name'], user['last_name'], pass_obj.hashed_pword, pass_obj.salt]

        let user_exists = await check_user_exists(user['email']);
        if (user_exists.length === 0) {
            try {
                let user_id = await register_user(user_data);
                let access_token = await generate_access_token(user_id);
                let refresh_token = await generate_refresh_token(user_id);
                delete user['password'];
                user['id'] = user_id;
                user['refresh_token'] = refresh_token;
                user['access_token'] = access_token;
                return res.status(201).json(user);
            } catch(error) {
                return res.status(400).json(error);
            }   
        } else {
            return res.status(422).json("Email is already associated with an account");
        }

 
    };





    login_user = async(req, res) => {
        //check user creditials exist and match
        let email = req.body['email'];
        let password = req.body['password'];
        let user_arr = await check_user_exists(email);
        if (user_arr.length === 1) {
            //user exists verify details
            if (verify_details(user_arr[0], password)) {
                let user_obj = await get_user_info(email);
                let access_token = await generate_access_token(user_obj['id']);
                let refresh_token = await generate_refresh_token(user_obj['id']);
                user_obj['access_token'] = access_token;
                user_obj['refresh_token'] = refresh_token;
                res.status(200).json(user_obj);
            } else {
                res.status(401).json('Incorrect password');
            }
        } else {
            
            res.status(404).json('User does not exist');
        }
    };





    new_access_token = async(req, res) => {
        let auth_header = req.headers['authorization'];
        let refresh_token = auth_header && auth_header.split(' ')[1];
        if (refresh_token === null) return res.status(400).send('Missing refresh token');

        //check if refresh token is blacklisted
            let token_not_blacklisted = await checkBlackListToken(refresh_token).catch((err) => {
                throw err;
            })
            if (token_not_blacklisted !== true) return res.status(401).json('Refresh token has been blacklisted');


        //get user_id from refresh token
        let user_id = jwt.verify(refresh_token, process.env.REFRESH_TOKEN_SECRET, (err, payload) => {
            if (!err) {
                return payload['id'];
            }
            res.status(403).send(err);
        })
        
        //put user id in the payload of the new access token
        try {
            let access_token = await generate_access_token(user_id);
            res.status(200).json({
                access_token: access_token
            })
        } catch(error) {
            res.status(400).send(error);
        }
    };





    logout_user = async(req, res) => {
        let auth_header = req.headers['authorization'];
        let refresh_token = [auth_header && auth_header.split(' ')[1]];
        let query = 'INSERT INTO BLACKLISTED_REFRESH_TOKEN(token) VALUES (?)'

        db.query(query, refresh_token, (err) => {
            if (!err) {
                return res.status(200).json('User successfully logged out');
            }
            return res.status(400).json(err);
        })
    };




}





module.exports = UserController;


