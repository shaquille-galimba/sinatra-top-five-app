#	User Stories

##	Users will be able to...
	- sign up, log in, and log out off the app.
	- create a topic and a list of their 5 favorite things on that topic.
	- read all the list they made
	- edit only their own lists
	- delete only their own lists

#	Wireframing

##	Models will be
	- User
	- Topic
	- List

## User

###	Attributes
	- name
	- username
	- password (password_digest)

###	Association
	- has many Lists
	- has many Topics through Lists


## Topic

###	Attributes
	- name


###	Association
	- has many Lists
	- has many Users through Lists


## List

### Attributes
	- content
	- user_id
	-	topic_id

### Association
	- belongs to a User
	- belongs to a Topic
