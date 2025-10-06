CREATE TABLE hospital (
  hospitalname	VARCHAR(100),
location	VARCHAR(100),
department	VARCHAR(100),
doctorscount	INT,
patientscount	INT,
admissiondate	DATE,
dischargedate	DATE,
medicalexpenses	VARCHAR(100)
);

ALTER TABLE hospital
ALTER COLUMN medicalexpenses NUMERIC(10,2);
 
SELECT * FROM hospital;

-- Q1. Total Number of Patients 
   -- Write an SQL query to find the total number of patients across all hospitals. 
SELECT SUM(patientscount) AS Total_Patient 
FROM hospital;

-- Q2. Average Number of Doctors per Hospital 
  -- Retrieve the average count of doctors available in each hospital.
SELECT hospitalname,AVG(doctorscount) AS Avg_Doctor
FROM hospital
GROUP BY hospitalname;

-- Q3.Top 3 Departments with the Highest Number of Patients 
  -- Find the top 3 hospital departments that have the highest number of patients.
SELECT department,MAX(patientscount) AS Highest_patient
FROM hospital
GROUP BY department
ORDER BY Highest_patient DESC LIMIT 3;

--Q4. Hospital with the Maximum Medical Expenses 
 -- Identify the hospital that recorded the highest medical expenses. 
SELECT hospitalname,MAX(medicalexpenses) AS Max_medicalExp 
FROM hospital
GROUP BY hospitalname;

-- Q5.Daily Average Medical Expenses 
    -- Calculate the average medical expenses per day for each hospital.

SELECT hospitalname,admissiondate, ROUND(AVG(CAST(medicalexpenses AS NUMERIC)),2) AS Avg_Exp
FROM hospital
GROUP BY hospitalname,admissiondate;

-- Q6. Longest Hospital Stay 
-- Find the patient with the longest stay by calculating the difference between 
-- Discharge Date and Admission Date. 

SELECT patientscount, MAX(dischargedate-admissiondate) AS Stay_days
FROM hospital
GROUP BY patientscount
ORDER BY Stay_days DESC LIMIT 1;

-- Q7. Total Patients Treated Per City 
-- Count the total number of patients treated in each city.
SELECT location,SUM(patientscount) AS Total_patients
FROM hospital
GROUP BY location
ORDER BY Total_patients DESC ;

-- Q8.Average Length of Stay Per Department 
 -- Calculate the average number of days patients spend in each department. 
 SELECT department,ROUND(AVG(dischargedate-admissiondate),2) AS Avg_spend_days
 FROM hospital
 GROUP BY department;

 -- Q9.Identify the Department with the Lowest Number of Patients 
  -- Find the department with the least number of patients. 
  SELECT department, SUM(patientscount) AS Total_patient
  FROM hospital
  GROUP BY department
  ORDER BY Total_patient ASC LIMIT 1;

-- Q10. Monthly Medical Expenses Report 
 -- Group the data by month and calculate the total medical expenses for each month.
  
SELECT 
    EXTRACT(MONTH FROM admissiondate) AS month_num,
    TO_CHAR(admissiondate, 'Month') AS month_name,
    SUM(CAST(medicalexpenses AS NUMERIC)) AS total_medical_expenses
FROM hospital
GROUP BY month_num, month_name
ORDER BY month_num;

