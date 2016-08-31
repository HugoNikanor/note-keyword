-- This file is more of a dumping ground for
-- commands that might prove to be useful
---- DO NOT ACTUALLY RUN THIS FILE! ----


-- THIS SHOULD NOT BE USED, IT WAS FOR A TEST ONLY
insert into keywords_bindings (keyword_id, note_id)
	select keywords.id, notes.id 
	from keywords, notes;

-- reference, for when keywords dissapear.
-- A keyword removal from a note could be checked by searching for database 
-- entries not present in the keywords file
delete from keyword_bindings where note_id = 1;
