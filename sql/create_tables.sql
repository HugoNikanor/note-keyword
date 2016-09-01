-- group_id is used as a unique identifier when adding records.
-- It allows me to add a mix of good and bad (as in duplicate)
-- records and then retrive them all
-- It's a LONG becouse I used the current time in ms for it, this
-- should possibly be changed...
CREATE TABLE keywords
(
	id INT NOT NULL AUTO_INCREMENT,
	name varchar(128) NOT NULL,
	group_id LONG,

	UNIQUE (name),
	PRIMARY KEY (id)
);

CREATE TABLE courses
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(16) NOT NULL,

	UNIQUE (name),
	PRIMARY KEY (id)
);

CREATE TABLE notes
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(128),
	date varchar(16) NOT NULL,
	course_id INT NOT NULL,

	UNIQUE (date, course_id),
	PRIMARY KEY (id)
);

CREATE TABLE keyword_bindings
(
	id INT NOT NULL AUTO_INCREMENT,
	keyword_id INT NOT NULL,
	note_id INT NOT NULL,

	UNIQUE (keyword_id, note_id),
	PRIMARY KEY (id)
);
