const jwt = require('jsonwebtoken');



const generate_access_token = (id) => {
    return new Promise((resolve, reject) => {
        jwt.sign({id: id}, process.env.ACCESS_TOKEN_SECRET, {expiresIn: "7d"}, (err, token) => {
            if (!err) {
                resolve(token);
            } else {
                reject(err);
            }
        })
    })
};



const generate_refresh_token = (user_id) => {
    return new Promise((resolve, reject) => {
        jwt.sign({id:user_id}, process.env.REFRESH_TOKEN_SECRET, {expiresIn: "180 days"}, (err, token) => {
            if (!err) {
                resolve(token);
                return
            }
            reject(err);
            return
        })
    })


};





module.exports = {
    generate_access_token,
    generate_refresh_token,
}