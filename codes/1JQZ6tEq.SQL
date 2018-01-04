CREATE TABLE Tbl_Courses(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    courseName varchar(50) NOT NULL,
    courseDescr varchar(250),
    courseHours INTEGER,
    courseSem INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Tbl_Students(
    id INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY,
    firstName varchar(50),
    lastName varchar(50),
    semester INTEGER NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE Tbl_StudentCourse(
    studentId INTEGER NOT NULL,
    courseId INTEGER NOT NULL,
    mark INTEGER NOT NULL,
    FOREIGN KEY (studentId) REFERENCES Tbl_Students(id),
    FOREIGN KEY (courseId) REFERENCES Tbl_Courses(id),
    PRIMARY KEY(studentId, courseId)
);