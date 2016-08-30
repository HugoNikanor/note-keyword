CREATE TABLE keywords
(
	id INT NOT NULL AUTO_INCREMENT,
	-- possibly make the name unique
	name varchar(128) NOT NULL,

	PRIMARY KEY (id)
);

CREATE TABLE courses
(
	id INT NOT NULL AUTO_INCREMENT,
	-- possibly make the course unique
	name VARCHAR(16) NOT NULL,

	-- maybe add institution, since that would allow for url's to be contructed
	--  from the data, otherwise just the url to the course could be added 

	PRIMARY KEY (id)
);

CREATE TABLE notes
(
	id INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(128),
	date varchar(16),
	course_id INT NOT NULL,

	-- Maybe have an optional url or sub-url for material relevant to this note,
	-- probably constructed by taking the base url from the courses table and 
	-- concatenating the sub-url from this table

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
