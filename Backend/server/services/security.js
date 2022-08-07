const crypto = require('crypto-js');
const db = require('../server-setup/sql-db/database');
const jwt = require('jsonwebtoken');


//method to salt a password (return password and salt)
const secure_password = (password) => {

    if (typeof password !== 'string') {
        throw 'Parameter must be a string';
    }

    let salt = crypto.lib.WordArray.random(32).toString();
    const salted_password = password.concat(salt);
    const hashed_password = crypto.SHA256(salted_password).toString();

    return {
        hashed_pword: hashed_password,
        salt: salt
    }
};





const register_user = (user_data) => {
    const query = 'INSERT INTO USERS_TABLE(email, username, first_name, last_name, p_hash, p_salt) VALUES (?,?,?,?,?,?)';
    
    return new Promise((resolve, reject) => {
        db.query(query, user_data, (err, results) => {
            if (!err) {
                resolve(results.insertId);
            } else {
                reject(err);
            }
        })
    })
};




const check_user_exists = (email) => {
    const query = `SELECT p_salt, p_hash FROM USERS_TABLE WHERE email= "${email}"`;
    return new Promise((resolve, reject) => {
        db.query(query, (err, results) => {
            if (!err)  {
                resolve(results);
            } else {
                reject(err);
            }
        })
    })
}




//method to check if user exists, and then verify details
const verify_details = (user_obj, password) => {
    let salted_password = password.concat(user_obj['p_salt']);
    let hashed_password = crypto.SHA256(salted_password).toString();
    return (hashed_password === user_obj['p_hash']) ? true : false;
}


//method to get user info if user details are verfied
const get_user_info = (email) => {
   const query = `SELECT id, username, first_name, last_name, email FROM USERS_TABLE WHERE email="${email}"`
   return new Promise((resolve, reject) => {
       db.query(query, (err, results) => {
           if (!err) {
               const user_obj = {
                   id: results[0]['id'],
                   username: results[0]['username'],
                   email: results[0]['email'],
                   first_name: results[0]['first_name'],
                   last_name: results[0]['last_name'],
               }
               resolve(user_obj);
           } else {
               reject('Could not query db for user info');
           }
       })
   })
};




//method to check if token has been blacklisted
const checkBlackListToken = (token) => {
    let query = `SELECT token FROM BLACKLISTED_REFRESH_TOKEN WHERE token="${token}"`;
    return new Promise((resolve, reject) => {
      db.query(query, (err, results) => {
        if (!err) {
          if (results.length === 0) {
            resolve(true);
          }
          resolve(false);
        } else {
          reject(err);
        }
      })
    })
  }
  




module.exports = {
    secure_password: secure_password,
    check_user_exists: check_user_exists,
    verify_details: verify_details,
    get_user_info: get_user_info,
    register_user: register_user,
    checkBlackListToken: checkBlackListToken
}

