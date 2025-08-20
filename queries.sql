show tables

DROP TABLE Students;
DROP TABLE Courses;
DROP TABLE Professors;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Age INT CHECK (Age >= 18),
    Major VARCHAR(50) DEFAULT 'Undeclared'
);
 
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    StartDate DATE
);
 
CREATE TABLE Professors (
    ProfessorID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Department VARCHAR(50)
);
 
-- Insert Students
INSERT INTO Students (Name, Age, Major)
VALUES
('Alice Johnson', 20, 'Computer Science'),
('Bob Smith', 19, 'Mathematics'),
('Charlie Brown', 22, DEFAULT);
 
-- Insert Courses
INSERT INTO Courses (CourseID, CourseName, Credits, StartDate)
VALUES
(101, 'Database Systems', 3, '2025-09-01'),
(102, 'Data Structures', 4, '2025-09-05'),
(103, 'Calculus I', 4, '2025-09-10');
 
-- Insert Professors
INSERT INTO Professors (ProfessorID, Name, Department)
VALUES
(201, 'Dr. Williams', 'Computer Science'),
(202, 'Dr. Taylor', 'Mathematics'),
(203, 'Dr. Smith', 'Engineering');

show tables

SELECT * FROM Students
ORDER BY Age

ALTER TABLE Students
ADD COLUMN testCol VARCHAR(50);

ALTER TABLE Students
DROP COLUMN testCol

SELECT *
FROM Students;

CREATE VIEW testView AS (
    SELECT *
    FROM Students
    WHERE Age > 19
);

SELECT *
FROM testView;