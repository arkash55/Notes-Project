const db = require('../server-setup/sql-db/database')
const redis_client = require('../services/redis-cache').redis_client




class NotesController {

    static getUserNotes = async (req, res) => {
        const user_id = req.params['id'];
        const query = `SELECT * FROM NOTES_TABLE WHERE user_id = ${user_id}`;
        db.query(query, async (err, results) => {
            if (!err) {
                return res.json(results).status(200);
            } else {
                return res.send('Unable to get user notes: ' + err).status(400);
            }
        })
    }

    static getUserUrgentNotes = async (req, res) => {
        const uid = req.params.id;
        const query = `SELECT * FROM NOTES_TABLE WHERE user_id = ${uid} AND urgency = 3`;
        db.query(query, async (err, results) => {
            if (err) {return res.status(400).json(err)};
            return res.status(200).json(results);
        })
    }

    static createNote = (req, res) => {
        const query = 'INSERT INTO NOTES_TABLE(user_id, title, body, note_type, urgency, done_by_date) VALUES (?,?,?,?,?,?)'
        let note = req.body
        let note_data = [req.user_id, note['title'],note['body'],note['note_type'],note['urgency'],note['done_by_date']]
        db.query(query, note_data, (err, results) => {
            if (!err) {
                note['id'] = results.insertId;
                return res.status(201).json(note);
            } else {
                console.log(err)
                return res.status(400).json(err);
            }
        })
    };


    //update note
    static updateNote = (req, res) => {
        let note = req.body
        let note_data = [note['title'],note['body'],note['note_type'],note['urgency'],note['done_by_date']]
        const query = `UPDATE NOTES_TABLE SET (Title, body, note_type, urgency, done_by_date) VALUES (?,?,?,?,?) WHERE id = ${note.id}`;
        db.query(query, note, (err, results) => {
            if (err) {return res.status(400).json(err)};
            return res.status(201).json(results);
        })
    }

}



module.exports = {NotesController};