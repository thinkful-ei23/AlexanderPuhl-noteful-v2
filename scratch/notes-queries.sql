-- Put a -a flag to echo out the commands.
SELECT * FROM notes;

SELECT * FROM notes LIMIT 5;

SELECT * FROM notes ORDER BY id ASC;
SELECT * FROM notes ORDER BY title ASC;
SELECT * FROM notes ORDER BY date ASC;

SELECT * FROM notes ORDER BY id DESC;
SELECT * FROM notes ORDER BY title DESC;
SELECT * FROM notes ORDER BY date DESC;

SELECT * FROM notes WHERE title = '5 life lessons learned from cats';

SELECT * FROM notes WHERE title LIKE 'What the government%';

UPDATE notes SET title = 'updated1', content = 'blah blah' WHERE id = 1;

INSERT INTO notes 'Fake title';

DELETE from notes WHERE id = 2;

SELECT * FROM notes;