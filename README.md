# Notes-Project
A full stack Notes application. Frontend is written in swift and the backend is written in javascript.


The Frontend...
- MVC design pattern.
- UI designed using a combination of programatic code and storyboard.
- Used protocols and delegates to pass information between view controllers.
- Vigorous error handling system
- TypeAliases, Structs and Enums used to keep code more maintainable and DRY.
- Used Cocoapods to access different utilities.


The Backend...

- REST API created with express js
- Authentication implmented using json-web-tokens. ("npm jsonwebtoken")
- Implemented hashing and salting algorithms to store sensitive data with the aid of an cryptography package. ("npm crypto-js")
- Used a mysql database with raw sql queries to store and manage relation data.


Things to be added in the future...
- Redis Caching
- Use AWS S3 to allow for image uploads.
- Different methods of sorting notes. (e.g by due date, urgency, crated date.)
- Minor UI bug fixes (Logging out does not always refresh frontend state)
