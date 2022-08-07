const redis = require('redis');
const db = require('../server-setup/sql-db/database');
const redis_url = process.env.REDIS_URL || 'redis://127.0.0.1:6379'

//create redis client
const redis_client = redis.createClient(redis_url);

// redis_client.connect();
// no need to connect at the moment, come back later

redis_client.on('connect', () => {
    console.log('Connected to redis server');
})


redis_client.on('error', (err) => {
    throw `${err}`;
})







module.exports = {redis_client};