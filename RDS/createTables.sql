CREATE DATABASE IF NOT EXISTS discordapp;

USE discordapp;

DROP TABLE IF EXISTS track_key_words;
DROP TABLE IF EXISTS tracks;
DROP TABLE IF EXISTS users;

CREATE TABLE users
(
    id int not null AUTO_INCREMENT,
    discordname varchar(64) not null,

    PRIMARY KEY (id)
);

CREATE TABLE tracks
(
    id int not null AUTO_INCREMENT,
    setterid int not null,
    targetid int not null,
    notification_to varchar(256) not null,   -- where the discord bot should notify
    notification_style varchar(64) not null, -- how the user wants the search (ml, keyword, or boths)
    PRIMARY KEY (id),
    FOREIGN KEY (setterid) REFERENCES users(id),
    FOREIGN KEY (targetid) REFERENCES users(id)
);

CREATE TABLE track_key_words
(
    id int not null AUTO_INCREMENT,
    trackid int not null,
    keyword varchar(64) not null,

    PRIMARY KEY (id),
    FOREIGN KEY (trackid) REFERENCES tracks(id)
);

-- Create users
DROP USER IF EXISTS 'discord-read-only';
DROP USER IF EXISTS 'discord-read-write';

CREATE USER 'discord-read-only' IDENTIFIED BY 'abc123!!';
CREATE USER 'discord-read-write' IDENTIFIED BY 'def456!!';

GRANT SELECT, SHOW VIEW ON discordapp.* 
      TO 'discord-read-only';
GRANT SELECT, SHOW VIEW, INSERT, UPDATE, DELETE, DROP, CREATE, ALTER ON discordapp.* 
      TO 'discord-read-write';
      
FLUSH PRIVILEGES;