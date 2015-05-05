.headers on
.mode column

DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS questions_likes;

CREATE TABLE users(
  id INTEGER PRIMARY KEY autoincrement,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);
CREATE TABLE questions_follows(
  id INTEGER PRIMARY KEY autoincrement,
  user_id integer NOT NULL references users(id),
  question_id integer NOT NULL references questions(id)
);

CREATE TABLE questions(
  id INTEGER PRIMARY KEY autoincrement,
  title string NOT NULL,
  body VARCHAR(255) NOT NULL,
  author_id integer NOT NULL references users(id)
);
CREATE TABLE replies(
  id INTEGER PRIMARY KEY autoincrement,
  question_id integer NOT NULL references questions(id),
  parent_id integer references replies(id),
  author_id integer NOT NULL references users(id),
  body VARCHAR(255) NOT NULL
);
CREATE TABLE questions_likes(
  id INTEGER PRIMARY KEY autoincrement,
  user_id integer NOT NULL references users(id),
  question_id integer NOT NULL references questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Garrett', 'Simpson'),
  ('Michael', 'Wagner'),
  ('Bob', 'Dole'),
  ('Barack', 'Obama');

INSERT INTO
  questions (title, body, author_id)
VALUES
  ('Help', 'I dont know how to do anything', 1),
  ('directions', 'how do i get to the gym', 2),
  ('politics', 'why does congress hate me', 3),
  ('meta', 'who is bob dole?', 4);

INSERT INTO
  replies (question_id, parent_id, author_id, body)
VALUES
  (1, NULL, 2, 'read a book'),
  (1, 1, 3, 'go to school'),
  (1, 2, 1, 'those are good suggestions');

INSERT INTO
  questions_follows (user_id, question_id)
VALUES
  (2, 1),
  (1, 1),
  (3, 1);

INSERT INTO
  questions_likes (user_id, question_id)
VALUES
  (2, 1),
  (3, 1);
