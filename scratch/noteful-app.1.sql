DROP TABLE IF EXISTS notes;

CREATE TABLE notes (
  id serial PRIMARY KEY,
  title text NOT NULL,
  content text,
  created timestamp DEFAULT now()
);

ALTER SEQUENCE notes_id_seq RESTART WITH 1000;

INSERT INTO notes (title, content) VALUES 
  (
    '5 life lessons learned from cats',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor'
  ),
  (
    'What the government doesn''t want you to know about cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestib'
  ),
  (
    'The most boring article about cats you''ll ever read',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incid'
  ),
  (
    '7 things lady gaga has in common with cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestibulum ma'
  ),
  (
    'The most incredible article about cats you''ll ever read',
    'Lorem ipsum dolor sit amet, boring consectetur adipiscing elit, sed do eiusmod tempor i'
  ),
  (
    '10 ways cats can help you live to 100',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestibulum '
  ),
  (
    '9 reasons you can blame the recession on cats',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt u'
  ),
  (
    '10 ways marketers are making you addicted to cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestibulum mattis u'
  ),
  (
    '11 ways investing in cats can make you a millionaire',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut lab'
  ),
  (
    'Why you should forget everything you learned about cats',
    'Posuere sollicitudin aliquam ultrices sagittis orci a. Feugiat sed lectus vestibulum mattis ullam'
  );

SELECT * FROM notes;