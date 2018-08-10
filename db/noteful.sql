-- psql -U dev -d noteful-app -f ./db/noteful.sql


DROP TABLE IF EXISTS notes_tags;
DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS notes;
DROP TABLE IF EXISTS folders;

CREATE TABLE folders (
    id serial PRIMARY KEY,
    name text NOT NULL UNIQUE
);
ALTER SEQUENCE folders_id_seq RESTART WITH 100;

CREATE TABLE notes (
  id serial PRIMARY KEY,
  title text NOT NULL,
  content text,
  created timestamp DEFAULT now()
  -- folder_id int REFERENCES folders(id) ON DELETE SET NULL;
);

ALTER SEQUENCE notes_id_seq RESTART WITH 1000;

-- If you delete a folder then set folder_id to null on related notes
-- IOW, delete a folder and move the notes to "uncategorized"
ALTER TABLE notes ADD COLUMN folder_id int REFERENCES folders(id) ON DELETE SET NULL;

-- Prevent folders from being deleted if are referenced by any note
-- IOW, only empty folder can be deleted
-- ALTER TABLE notes ADD COLUMN folder_id int REFERENCES folders(id) ON DELETE RESTRICT;

-- If you delete a folder then delete all notes that reference the folder
-- IOW, delete a folder and all the notes in it
-- ALTER TABLE notes ADD COLUMN folder_id int REFERENCES folders(id) ON DELETE CASCADE;




CREATE TABLE tags (
  id serial PRIMARY KEY,
  name text NOT NULL UNIQUE
);


CREATE TABLE notes_tags (
  note_id INTEGER NOT NULL REFERENCES notes ON DELETE CASCADE,
  tag_id INTEGER NOT NULL REFERENCES tags ON DELETE CASCADE
);



INSERT INTO folders (name) VALUES
  ('Archive'),
  ('Drafts'),
  ('Personal'),
  ('Work');

INSERT INTO notes (title, content, folder_id) VALUES
  (
    '5 life lessons learned from cats',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmodllit anim id est laborum.'
    , 101
  ),
  (
    'What the government doesn''t want you to know about cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectusd. Aliquam faucibus purus in massa tempor nec feugiat nisl.'
  , 101
  ),
  (
    'The most boring article about cats you''ll ever read',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor int mollit anim id est laborum.'
  , 102
  ),
  (
    '7 things lady gaga has in common with cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectu Aliquam faucibus purus in massa tempor nec feugiat nisl.'
  , 103
  ),
  (
    'The most incredible article about cats you''ll ever read',
    'Lorem ipsum dolor sit amet, boring consectetur adipiscing elit, sed do eicia deserunt mollit anim id est laborum.'
  , 100
  ),
  (
    '10 ways cats can help you live to 100',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestiucibus purus in massa tempor nec feugiat nisl.'
  , NULL
  ),
  (
    '9 reasons you can blame the recession on cats',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboui officia deserunt mollit anim id est laborum.'
  , 101
  ),
  (
    '10 ways marketers are making you addicted to cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestibeifend. Aliquam faucibus purus in massa tempor nec feugiat nisl.'
  , 101
  ),
  (
    '11 ways investing in cats can make you a millionaire',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor inia deserunt mollit anim id est laborum.'
    , NULL
  ),
  (
    'Why you should forget everything you learned about cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vebus purus in massa tempor nec feugiat nisl.'
  , NULL
  );

INSERT INTO tags (name) VALUES
('To do'),
('To get'),
('Reminder');


INSERT INTO notes_tags (note_id, tag_id) VALUES
(
  1000,
  1
),
(
  1000,
  2
),
(
  1000,
  3
),
(
  1001,
  2
),
(
  1002,
  3
);

-- -- get all notes
-- SELECT * FROM notes;

-- -- get all folders
-- SELECT * FROM folders;

-- -- get all notes with folders
-- SELECT * FROM notes
-- INNER JOIN folders ON notes.folder_id = folders.id;

-- -- get all notes, show folders if they exists otherwise null
-- SELECT folder_id as folderId FROM notes
-- LEFT JOIN folders ON notes.folder_id = folders.id;