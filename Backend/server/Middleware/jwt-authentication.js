const jwt = require('jsonwebtoken');
const db = require('../server-setup/sql-db/database');


const jwtAuthentication = (req, res, next) => {
    let auth_header = req.headers['authorization'];
    let access_token = auth_header && auth_header.split(' ')[1]

    //check if token exists
    if (access_token === null) return res.status(401).json('No access token provided');


    jwt.verify(access_token, process.env.ACCESS_TOKEN_SECRET, (err, data) => {
    if (!err) {
      //req is a dictionary. Create a user_id key for req then set its value to the users uid
      req.user_id = data['id'];
      next();
    } else {
      return res.status(401).json(err);
    }
  })
};




module.exports = {
    jwtAuthentication,
}