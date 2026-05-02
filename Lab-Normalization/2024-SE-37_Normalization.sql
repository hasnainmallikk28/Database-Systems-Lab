
-- HOSPITAL DATABASE NORMALIZATION

/* 
   DELIVERABLE 1: FUNCTIONAL DEPENDENCIES & CANDIDATE KEY
   ------------------------------------------------------------
   FD1: VisitID -> VisitDate, PatientID, DoctorID, Diagnosis, Fee
   FD2: PatientID -> PatientName, PatientPhone
   FD3: DoctorID -> DoctorName, Specialty, DeptName
   FD4: DeptName -> DeptHead

   Candidate Key: VisitID (Uniquely identifies each consultation)
*/

-- SETUP: Database Creation
CREATE DATABASE hospital_lab_db;
USE hospital_lab_db;

-- ------------------------------------------------------------
-- DELIVERABLE 2: FIRST NORMAL FORM (1NF)
-- ------------------------------------------------------------
-- Requirement: Atomic values, no repeating groups, unique rows.

CREATE TABLE Hospital_1NF (
    VisitID      VARCHAR(10) PRIMARY KEY,
    VisitDate    DATE,
    PatientID    VARCHAR(10),
    PatientName  VARCHAR(50),
    PatientPhone VARCHAR(20),
    DoctorID     VARCHAR(10),
    DoctorName   VARCHAR(50),
    Specialty    VARCHAR(50),
    DeptName     VARCHAR(50),
    DeptHead     VARCHAR(50),
    Diagnosis    VARCHAR(100),
    Fee          INT
);

INSERT INTO Hospital_1NF VALUES
('V-9001', '2026-04-10', 'P-201', 'Hassan',  '0300-1112233', 'D-30', 'Dr. Imran', 'Cardiology',   'Heart Care',  'Dr. Tariq', 'Hypertension', 2500),
('V-9002', '2026-04-10', 'P-202', 'Mehreen', '0301-4445566', 'D-31', 'Dr. Asma',  'Dermatology',  'Skin Clinic', 'Dr. Asma',  'Eczema',       2000),
('V-9003', '2026-04-11', 'P-201', 'Hassan',  '0300-1112233', 'D-31', 'Dr. Asma',  'Dermatology',  'Skin Clinic', 'Dr. Asma',  'Allergy',      2000),
('V-9004', '2026-04-12', 'P-203', 'Junaid',  '0302-7778899', 'D-30', 'Dr. Imran', 'Cardiology',   'Heart Care',  'Dr. Tariq', 'Arrhythmia',   3000);

-- ------------------------------------------------------------
-- DELIVERABLE 3: SECOND NORMAL FORM (2NF)
-- ------------------------------------------------------------
-- Justification: 2NF requires 1NF and no partial dependencies.
-- Since the Primary Key (VisitID) is a single attribute (not composite), 
-- partial dependencies are impossible. The 1NF table is already in 2NF.

-- ------------------------------------------------------------
-- DELIVERABLE 4: THIRD NORMAL FORM (3NF)
-- ------------------------------------------------------------
-- Requirement: 2NF and no transitive dependencies.
-- Decomposition into 4 normalized tables: Patient, Department, Doctor, and Visit.

-- 1. Patient Table: Stores unique patient details
CREATE TABLE Patient (
    PatientID    VARCHAR(10) PRIMARY KEY,
    PatientName  VARCHAR(50),
    PatientPhone VARCHAR(20)
);

-- 2. Department Table: Stores unique department details
CREATE TABLE Department (
    DeptName VARCHAR(50) PRIMARY KEY,
    DeptHead VARCHAR(50)
);

-- 3. Doctor Table: Stores unique doctor details (Links to Department)
CREATE TABLE Doctor (
    DoctorID   VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty  VARCHAR(50),
    DeptName   VARCHAR(50),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- 4. Visit Table: Stores specific transaction data (Links to Patient and Doctor)
CREATE TABLE Visit (
    VisitID    VARCHAR(10) PRIMARY KEY,
    VisitDate  DATE,
    Diagnosis  VARCHAR(100),
    Fee        INT,
    PatientID  VARCHAR(10),
    DoctorID   VARCHAR(10),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID) 
        ON UPDATE CASCADE ON DELETE RESTRICT,
    FOREIGN KEY (DoctorID)  REFERENCES Doctor(DoctorID) 
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- Populating 3NF Tables
INSERT INTO Patient VALUES 
('P-201', 'Hassan',  '0300-1112233'),
('P-202', 'Mehreen', '0301-4445566'),
('P-203', 'Junaid',  '0302-7778899');

INSERT INTO Department VALUES 
('Heart Care',  'Dr. Tariq'),
('Skin Clinic', 'Dr. Asma');

INSERT INTO Doctor VALUES 
('D-30', 'Dr. Imran', 'Cardiology',  'Heart Care'),
('D-31', 'Dr. Asma',  'Dermatology', 'Skin Clinic');

INSERT INTO Visit VALUES 
('V-9001', '2026-04-10', 'Hypertension', 2500, 'P-201', 'D-30'),
('V-9002', '2026-04-10', 'Eczema',       2000, 'P-202', 'D-31'),
('V-9003', '2026-04-11', 'Allergy',      2000, 'P-201', 'D-31'),
('V-9004', '2026-04-12', 'Arrhythmia',   3000, 'P-203', 'D-30');

-- ------------------------------------------------------------
-- DELIVERABLE 5: VERIFICATION QUERY
-- ------------------------------------------------------------
-- Single SELECT query to recreate original Table 8.1

SELECT v.VisitID, v.VisitDate, p.PatientID, p.PatientName, p.PatientPhone, 
       d.DoctorID, d.DoctorName, d.Specialty, dep.DeptName, dep.DeptHead, 
       v.Diagnosis, v.Fee
FROM Visit v
JOIN Patient p ON v.PatientID = p.PatientID
JOIN Doctor d ON v.DoctorID = d.DoctorID
JOIN Department dep ON d.DeptName = dep.DeptName
ORDER BY v.VisitID;

-- ------------------------------------------------------------
-- DELIVERABLE 6: ANOMALIES ELIMINATED
-- ------------------------------------------------------------
/* 
   - Insertion Anomaly: New doctors or departments can be added without a visit.
   - Update Anomaly: Changes to department heads are made in one row, preventing inconsistency.
   - Deletion Anomaly: Deleting a visit record no longer loses patient or doctor profiles.
*/
