# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app
- I'm using Sinatra to build my app.
- [x] Use ActiveRecord for storing information in a database
- Already using ActiveRecord for storing information into a sqlite3 database.
- [x] Include more than one model class (e.g. User, Post, Category)
- I have 3 model class; User, Topic, and List.
- [x] Include at least one has_many relationship on your User model (e.g. User has_many Posts)
- I have 2 has_many relationship on my User model namely topics and lists.
- [x] Include at least one belongs_to relationship on another model (e.g. Post belongs_to User)
- The List model belongs to a user and it also belongs to a topic.
- [x] Include user accounts with unique login attribute (username or email)
- I use username for a unique login attribute.
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying
- I can create, read, update, and delete my own list if I am logged in.
- [x] Ensure that users can't modify content created by other users
- Users can only modify and delete their own content.
- [x] Include user input validations
- Users can't create a list nor update one if any of the field is left blank.
- [ ] BONUS - not required - Display validation failures to user with error message (example form URL e.g. /posts/new)
- [ ] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
