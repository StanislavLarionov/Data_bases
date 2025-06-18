-- creating database
CREATE DATABASE library
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LOCALE_PROVIDER = 'libc'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- adding tables
CREATE TABLE public.authors
(
    "id" serial NOT NULL,
    "name" character varying(50) NOT NULL,
    "surname" character varying(50),
    "about" text,
    PRIMARY KEY ("id")
);

ALTER TABLE IF EXISTS public.authors
    OWNER to postgres;


CREATE TABLE public.readers
(
    "id" serial NOT NULL,
    "name" character varying(50) NOT NULL,
    "surname" character varying(50),
    PRIMARY KEY ("id")
);

ALTER TABLE IF EXISTS public.readers
    OWNER to postgres;


CREATE TABLE public.books
(
    "id" serial NOT NULL,
    "title" character varying(100) NOT NULL,
    "author" integer NOT NULL,
    "year" integer NOT NULL,
    "reader" integer,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("author")
        REFERENCES public.authors ("id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID,
    FOREIGN KEY ("reader")
        REFERENCES public.readers ("id") MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
        NOT VALID
);

ALTER TABLE IF EXISTS public.books
    OWNER to postgres;

-- adding data
INSERT INTO authors (name, surname, about)
VALUES 
('Stephen', 'King', 'Stephen Edwin King (born September 21, 1947) is an American author. Widely known for his horror novels, he has been crowned the "King of Horror". He has also explored other genres, among them suspense, crime, science-fiction, fantasy and mystery. Though known primarily for his novels, he has written approximately 200 short stories, most of which have been published in collections'),
('Kate', 'DiCamillo', 'Katrina Elizabeth DiCamillo (born March 25, 1964) is an American children''s fiction author. She has published over 25 novels, including Because of Winn-Dixie, The Tiger Rising, The Tale of Despereaux, The Miraculous Journey of Edward Tulane, The Magician''s Elephant, the Mercy Watson series, and Flora & Ulysses. Her books have sold around 37 million copies. '),
('Dan', 'Brown', 'Daniel Gerhard Brown (born June 22, 1964) is an American author best known for his thriller novels, including the Robert Langdon novels Angels & Demons (2000), The Da Vinci Code (2003), The Lost Symbol (2009), Inferno (2013), and Origin (2017). His novels are treasure hunts that usually take place over a period of 24 hours. They feature recurring themes of cryptography, art, and conspiracy theories.');

INSERT INTO readers (name, surname)
VALUES
('Maksym', 'Dashkovskyi'),
('Bob', 'Snail'),
('Anne', 'Smith');

INSERT INTO books (title, year, author, reader)
VALUES
('Carrie', 1974, 1, 2),
('The Miraculous Journey of Edward Tulane', 2006, 2, 1),
('Inferno', 2013, 3, 3);

-- reading data
SELECT * FROM readers;
SELECT * FROM authors;
SELECT * FROM books;

-- updating data
UPDATE books
SET reader = 1 
WHERE id = 3;

-- deleting data
DELETE FROM readers
WHERE id = 3
