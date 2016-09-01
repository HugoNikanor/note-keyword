-- Returns a table with:
-- + keyword name
-- + note date
-- + note name
-- + course name
-- This should possibly be extended to give a link to the note and the course
select 
	-- keyword_bindings.id, 
	keywords.name as keyword,
	notes.date,
	notes.name as note_name,
	upper(courses.name) as course_name
from keyword_bindings
	join keywords
		on keyword_bindings.keyword_id = keywords.id
	join notes
		on keyword_bindings.note_id = notes.id
	join courses
		on notes.course_id = courses.id;
