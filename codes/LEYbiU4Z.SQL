PRAGMA FOREIGN_KEYS = ON;

CREATE TABLE IF NOT EXISTS users(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(22) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    сreated_at DATETIME NOT NULL,
    updated_at DATEIME NOT NULL
);

CREATE TABLE IF NOT EXISTS profiles(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INREGER NOT NULL,
    name VARCHAR(255),
    last_name VARCHAR(255),
    photo_path VARCHAR(255),
    about TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TRIGGER new_profile AFTER INSERT ON users
    FOR EACH ROW
    BEGIN
        INSERT INTO profiles(user_id) VALUES (NEW.id);
END;