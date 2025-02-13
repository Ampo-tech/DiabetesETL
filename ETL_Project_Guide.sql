/*
1) Show completed mart schema
2) Test		queries to show no data in fact table
3) Execution of SSIS package
4) Test query showing data populated in the fact table
5) Show test queries - showing working join to the dimensions
6) Show at least one error trapping node
7) SSIS Package is organized and Presented 
8) Show lookup table structure used for the dimensional table(s) builds 
*/

CREATE DATABASE Diabetes

GO

CREATE TABLE dim.gender (
	GenderID INT IDENTITY(1000,1) NOT NULL,
	GenderName nvarchar(10) NOT NULL
)

ALTER TABLE dim.gender
ADD CONSTRAINT pk_gender PRIMARY KEY(GenderID)


CREATE TABLE dim.ethnicity (
	EthnicityID INT IDENTITY(100,1) NOT NULL,
	EthnicityName nvarchar(10) NOT NULL
)

ALTER TABLE dim.ethnicity
ADD CONSTRAINT pk_ethnicity PRIMARY KEY(EthnicityID)

CREATE TABLE fact.diabetes(
	GenderID int NOT NULL,
	EthnicityID int NOT NULL,
	Age bigint NOT NULL,
	Income bigint NOT NULL,
	BMI float NOT NULL,
	Blood_Pressure float NOT NULL,
	Cholesterol float NOT NULL,
	Exercise_Hours_Per_Week float NOT NULL,
	Alcohol_Consumption_Per_Week bigint NOT NULL,
	Smoking_Status nvarchar(10) NOT NULL,
	Family_History_Diabetes bigint NOT NULL,
	Glucose_Level float NOT NULL,
	HbA1c float NOT NULL,
	Insulin_Resistance float NOT NULL,
	Heart_Disease_History bigint NOT NULL,
	Physical_Activity_Level nvarchar(20) NOT NULL,
	Fast_Food_Intake_Per_Week bigint NOT NULL,
	Processed_Food_Intake_Per_Week bigint NOT NULL,
	Daily_Caloric_Intake bigint NOT NULL,
	Sleep_Hours_Per_Night float NOT NULL,
	Stress_Level nvarchar(20) NOT NULL,
	Medication_Use bigint NOT NULL,
	Diabetes_Diagnosis bigint NOT NULL,
	LastLoad datetime NULL
) 


ALTER TABLE fact.diabetes  
ADD  CONSTRAINT FK_Ethnicity FOREIGN KEY(EthnicityID)
REFERENCES dim.ethnicity (EthnicityID)
GO


ALTER TABLE fact.diabetes 
ADD  CONSTRAINT FK_Gender FOREIGN KEY(GenderID)
REFERENCES dim.gender (GenderID)
GO

SELECT *
FROM dim.gender

SELECT *
FROM dim.ethnicity


TRUNCATE TABLE fact.diabetes

SELECT *
FROM fact.diabetes

-- Fact table loading after two ETL runs
-- including supporting data from the dimension tables

SELECT GenderName,
       EthnicityName,
	   Age,
	   Income,
	   BMI,
	   Blood_Pressure,
	   Cholesterol,
	   Diabetes_Diagnosis
FROM fact.diabetes fd
LEFT OUTER JOIN dim.gender dg
ON dg.GenderID = fd.GenderID
LEFT OUTER JOIN dim.ethnicity de
ON de.EthnicityID = fd.EthnicityID


-- Test for errors

SELECT *
FROM error.diabetes
ORDER BY LastLoad DESC