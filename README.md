# Notes-Project
A full stack Notes application. Frontend is written in swift and the backend is written in javascript.

I am using express js to make the backend api, and am using npm jsonwebtoken for authentication. 
I am using a mysql database and raw sql queries to store all of my relational data.
This api is relatively simple, only allowing for CRUD operations.


Things to be added in the future...
- Redis Caching
- Use AWS S3 to allow for image uploads.
- Different methods of sorting notes. (e.g by due date, urgency, crated date.)
- Minor UI bug fixes (Logging out does not always refresh frontend state)
