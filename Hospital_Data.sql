CREATE DATABASE Hospital_Data;

USE Hospital_Data;
CREATE TABLE Hospital_Data (
    Hospital_Name VARCHAR(100),
    Location VARCHAR(100),
    Department VARCHAR(100),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Medical_Expenses DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE 'C:/Users/vinay/Downloads/Hospital_Data_dates_filled.csv'
INTO TABLE Hospital_Data
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Hospital_Name,Location,Department,Doctors_Count,Patients_Count,Admission_Date,Discharge_Date,Medical_Expenses);

SELECT * FROM Hospital_Data;
DROP TABLE Hospital_Data;
-- 1. Total Number of Patients 
-- o Write an SQL query to find the total number of patients across all hospitals. 
SELECT SUM(patients_count)AS 'Total Patient'
FROM Hospital_Data;

-- 2. Average Number of Doctors per Hospital 
-- o Retrieve the average count of doctors available in each hospital. 
SELECT AVG(Doctors_Count)
FROM Hospital_Data
GROUP BY Hospital_Name;

-- 3. Top 3 Departments with the Highest Number of Patients 
-- o Find the top 3 hospital departments that have the highest number of patients. 
SELECT Department, SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients DESC
LIMIT 3;

-- 4. Hospital with the Maximum Medical Expenses 
-- o Identify the hospital that recorded the highest medical expenses.
 SELECT * 
 FROM Hospital_Data
 ORDER BY Medical_Expenses DESC
 LIMIT 1;
 
-- 5. Daily Average Medical Expenses 
-- o Calculate the average medical expenses per day for each hospital. 
SELECT Hospital_Name, AVG(Medical_Expenses/ NULLIF(DATEDIFF(Discharge_Date,Admission_Date),0)) AS Average_Daily_Expenses
FROM Hospital_Data
GROUP BY Hospital_Name;

-- 6. Longest Hospital Stay 
-- o Find the patient with the longest stay by calculating the difference between Discharge Date and Admission Date.
SELECT Hospital_Name,Location,Department,Admission_Date,Discharge_Date,
		DATEDIFF(Discharge_Date,Admission_Date) AS 'Stay_Days'
FROM Hospital_data
ORDER BY Stay_Days DESC
LIMIT 1;
 
-- 7. Total Patients Treated Per City 
-- o Count the total number of patients treated in each city. 
SELECT * FROM Hospital_Data;
SELECT 
    Location,
    SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Location
ORDER BY Total_Patients DESC;
-- 8. Average Length of Stay Per Department 
-- o Calculate the average number of days patients spend in each department. 
SELECT department,
		AVG(DATEDIFF(Discharge_Date,Admission_Date)) AS Avg_days
FROM Hospital_Data
GROUP BY department
ORDER BY Avg_days DESC;

-- 9. Identify the Department with the Lowest Number of Patients 
-- o Find the department with the least number of patients.
SELECT 
    Department,
    SUM(Patients_Count) AS Total_Patients
FROM Hospital_Data
GROUP BY Department
ORDER BY Total_Patients ASC
LIMIT 1;
 
-- 10. Monthly Medical Expenses Report 
-- • Group the data by month and calculate the total medical expenses for each month. 
SELECT YEAR(Admission_Date) AS Year,
	   MONTH(Admission_Date) AS MONTH,
       SUM(Medical_Expenses) AS Total_Medical_Expenses
FROM Hospital_Data
GROUP BY YEAR(Admission_Date),MONTH(Admission_Date)
ORDER BY YEAR,MONTH;