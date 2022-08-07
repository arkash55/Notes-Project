require('dotenv').config({path: '../.env'});
const {app, server} = require('./server-setup/app-config');
const express = require('express');
const morgan = require('morgan');
const db = require('./server-setup/sql-db/database');
const redis_client = require('./services/redis-cache').redis_client;
const user_router = require('./routes/user_routes');
const notes_router = require('./routes/note_routes');
const port = process.env.PORT || 4000;





//listen to server
server.listen(port, () => {
    console.log(`Connected to server, listening at port ${port}`);
});




//middleware
app.use(express.json());
app.use(morgan('tiny'));



//http routing
app.use('/user', user_router);
app.use('/note',notes_router);










