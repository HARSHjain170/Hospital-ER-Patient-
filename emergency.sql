use hospital_db;
select count(*) from hospital_db.hospital_cleaned_data;
-- Display all patient records.
select * from hospital_cleaned_data;
-- Display only Patient ID, Gender, and Age.
select Patient_Id,Patient_Gender,Patient_Age from hospital_cleaned_data;
-- Find the total number of patients.
select count(*) as total_Patients from hospital_cleaned_data;
-- Count the number of male and female patients.
select Patient_Gender ,count(*)as total_patients from hospital_cleaned_data group by Patient_Gender;
-- Find the average patient age.
select round(avg(Patient_Age),2 )as avg_age from hospital_cleaned_data;
-- Find the minimum and maximum patient age.
select min(Patient_Age) as min_age , max(Patient_Age) as max_age from hospital_cleaned_data;
-- Count patients for each race.
select Patient_Race ,count(*) as total_Patient from hospital_cleaned_data group by Patient_Race order by total_Patient Desc;
-- Count patients admitted to the hospital. O means Not Admitted and  1 means Admitted 
select Patient_Admission_Flag,
count(*) as Admitted_Patient 
from hospital_cleaned_data 
group by Patient_Admission_Flag 
having Patient_Admission_Flag = 1;
-- Count patients who were not admitted.
select Patient_Admission_Flag,count(*) as Patient_Not_admitted
from hospital_cleaned_data where Patient_Admission_Flag = 0 group by Patient_Admission_Flag
;
-- Calculate the admission percentage.
select 
count(*) as total_patient,
sum(Patient_Admission_Flag) admitted_patient,
round(avg(Patient_Admission_Flag)*100,2) admission_percentage 
from hospital_cleaned_data;
-- Count patients referred to each department.
select Department_Referral,
count(*) as total_patient 
from hospital_cleaned_data 
group by Department_Referral;
-- Find the average patient satisfaction score.
select round(avg(Patient_Satisfaction_Score),2) as avg_satisfactio_Score 
from hospital_cleaned_data;
-- Display patients older than 60 years.
select * from hospital_cleaned_data where Patient_Age > 60;
-- Display patients younger than 18 years.
select * from hospital_cleaned_data where Patient_Age < 18;
-- Find patients with a satisfaction score greater than 8.
select * from hospital_cleaned_data where Patient_Satisfaction_Score >8;
-- Find patients whose department referral is "Cardiology".
select * from hospital_cleaned_data where Department_Referral = 'Cardiology';
-- Count patients admitted each month.
select monthname(Patient_Admission_Date) as Months ,count(*) as total_patients 
from hospital_cleaned_data 
group by monthname(Patient_Admission_Date),month(Patient_Admission_Date) 
order by month(Patient_Admission_Date);
-- Display patients ordered by age (highest to lowest).
select * from hospital_cleaned_data order by Patient_Age Desc;
-- Count the number of unique races.
select Count(Distinct Patient_Race) as Unique_Races from hospital_cleaned_data;
-- Count the number of unique referral departments.
select Count(Distinct Department_Referral) as Unique_Depart from hospital_cleaned_data;
-- Which department received the highest number of referrals?
select Department_Referral, count(*) as total_Referral from hospital_cleaned_data group by Department_Referral order by total_Referral Desc limit 1;
-- Which department received the fewest referrals?
select Department_Referral, count(*) as total_Referral from hospital_cleaned_data group by Department_Referral order by total_Referral Asc limit 1;
-- What is the average satisfaction score for each department?
select Department_Referral,
round(avg(Patient_Satisfaction_Score),2) as avg_Satis_Score 
from hospital_cleaned_data 
group by Department_Referral 
order by avg_Satis_Score desc;
-- Which gender has the highest admission rate?
select Patient_Gender, 
round(avg(Patient_Admission_Flag)*100,2) as Admission_rate 
from hospital_cleaned_data  
group by Patient_Gender 
order by Admission_rate Desc limit 1 ;
-- Which race has the highest admission rate?
select Patient_Race,
round(avg(Patient_Admission_Flag)*100,2) as admission_rate 
from hospital_cleaned_data group by Patient_Race  
order by admission_rate desc limit 1;
-- Which age group visits the ER most frequently? 
select Age_grp,count(*) as total_patient 
from hospital_cleaned_data 
group by Age_grp 
order by total_patient desc limit 1;
-- How many patients visited each month? 
select 
monthname(Patient_Admission_Date) as months, 
count(*) as total_patients 
from hospital_cleaned_data 
group by monthname(Patient_Admission_Date), 
month(Patient_Admission_Date)  
order by month(Patient_Admission_Date) asc ;
-- Which month had the highest patient volume?
select monthname(Patient_Admission_Date) as months ,
count(*) as total_patient 
from hospital_cleaned_data 
group by monthname(Patient_Admission_Date) 
order by total_patient Desc limit 1;
-- Which month had the lowest patient volume?
SELECT monthname(Patient_Admission_Date) as month , 
count(*) as total_patient from hospital_cleaned_data
group by monthname(Patient_Admission_Date) 
order by total_patient asc limit 1;
-- Find the average age of admitted patients.
select round(avg(Patient_Age),2) as avg_age 
from  hospital_cleaned_data 
where Patient_Admission_Flag = 1;
-- Find the average age of non-admitted patients.
select round(avg(Patient_Age),2) as avg_age 
from hospital_cleaned_data 
where Patient_Admission_Flag = 0;
-- Calculate the average satisfaction score by gender.
select Patient_Gender,
round(avg(Patient_Satisfaction_Score),2) as avg_satis 
from hospital_cleaned_data group by Patient_Gender;
-- Calculate the average satisfaction score by race.
select Patient_Race,
round(avg(Patient_Satisfaction_Score),2) as avg_satis 
from hospital_cleaned_data group by Patient_Race 
order by avg_satis desc ;
-- Find the top five departments by patient count.
select Department_Referral,count(*) as total_patient 
from hospital_cleaned_data group by Department_Referral 
order by total_patient desc limit 5 ;
-- Calculate the percentage of patients in each race.
select Department_Referral,
round(avg(Patient_Admission_Flag)*100,2) as Percentage_In_dept 
from hospital_cleaned_data 
group by Department_Referral 
order by Percentage_In_dept desc;
-- Count referrals by gender.
select Patient_Gender ,count(*) as total_patient 
from hospital_cleaned_data 
where Department_Referral != 'No Referral' 
group by Patient_Gender;
-- Count referrals by admission status.
select Patient_Admission_Flag ,count(*) as total_patient from hospital_cleaned_data group by Patient_Admission_Flag;
-- Find the average age for each department.
select Department_Referral,round(avg(Patient_Age),2) as Avg_Age from hospital_cleaned_data group by Department_Referral order by Avg_Age Desc;
-- Which department has the highest average patient age?
select Department_Referral,
round(avg(Patient_Age),2) as avg_age 
from hospital_cleaned_data 
group by Department_Referral 
order by avg_age Desc limit 1;
-- Which department has the youngest patients on average?
Select Department_Referral,
round(avg(Patient_Age),2) as avg_age 
from hospital_cleaned_data 
group by Department_Referral 
order by avg_age ASC limit 1;
-- Count admissions by weekday.
select dayname(Patient_Admission_Date) as weekdays,
count(*) as total_Patients 
from hospital_cleaned_data 
group by dayname(Patient_Admission_Date),
 weekday(Patient_Admission_Date)
order by weekday(Patient_Admission_Date);
-- Count admissions by year.
select year(Patient_Admission_Date) as Years,
count(*) as total_patients 
from hospital_cleaned_data 
group by year(Patient_Admission_Date);
-- Compare admitted vs non-admitted patients by age group.
select Age_grp,Patient_Admission_Flag,
count(*) as total_Patients 
from hospital_cleaned_data 
group by Age_grp,Patient_Admission_Flag 
order by total_Patients;
-- Find departments with more than 500 referrals.
select Department_Referral,
count(*) as total_patient 
from hospital_cleaned_data 
group by Department_Referral 
having total_patient > 500;
-- List departments where average satisfaction is above 5.
select Department_Referral ,
round(avg(Patient_Satisfaction_Score),2) as avg_satis_score 
from hospital_cleaned_data 
group by Department_Referral 
having avg_satis_score > 5;
-- Rank departments by referral count.
select Department_Referral,
count(*) as total_patient,
rank() over(order by  count(*) desc) as ranks 
from hospital_cleaned_data group by Department_Referral;
-- Rank races by patient volume.
select Patient_Race,
count(*) as total_patients,
rank()over(order by count(*)desc)as Rank_Races 
from hospital_cleaned_data group by Patient_Race;
-- Rank months by patient visits.
select monthname(Patient_Admission_Date) as months ,
count(*) as total_visits ,
rank() Over(order by count(*) desc) as month_rank 
from hospital_cleaned_data 
group by monthname(Patient_Admission_Date),
month(Patient_Admission_Date);
-- Find the top 3 departments with the highest average satisfaction.
select Department_Referral,
round(avg(Patient_Satisfaction_Score),2) as avg_satisfaction_score,
rank() over(order by avg(Patient_Satisfaction_Score) desc) as top_3 
from hospital_cleaned_data group by  Department_Referral limit 3;
-- Find the bottom 3 departments by satisfaction.
select Department_Referral,
round(avg(Patient_Satisfaction_Score),2) as avg_satis,
rank() over(order by avg(Patient_Satisfaction_Score) ASC) as bottom_3
from hospital_cleaned_data group by Department_Referral limit 3;
-- Find the top 5 oldest admitted patients.
select *,
rank() over(order  by Patient_Age DESC) as rank_patient 
from hospital_cleaned_data 
where Patient_Admission_Flag = 1 
order by Patient_Age DESC limit 5;
-- Identify patients whose age is above the overall average.
select * from hospital_cleaned_data 
where Patient_Age > 
(select avg(Patient_Age)  
from hospital_cleaned_data);
--  Compare each department's average age with the hospital average.
select Department_Referral ,round(avg(PAtient_age),2) as department_age,(select round(avg(Patient_Age),2) 
from hospital_cleaned_data ) 
from hospital_cleaned_data
group by Department_Referral;
-- Find departments where admission rate exceeds the hospital average.
select Department_Referral ,round(avg(Patient_Admission_Flag),2) as department_exceeds 
from hospital_cleaned_data group by Department_Referral having department_exceeds >
(select avg(Patient_Admission_Flag) from hospital_cleaned_data);
-- Calculate cumulative patient admissions by month.
with monthly_visits as (
select monthname(Patient_Admission_Date) as months,month(Patient_Admission_Date) as month_no ,count(*) as total_patients 
from hospital_cleaned_data group by months,month(Patient_Admission_Date) 
)
select *,sum(total_patients) over(order by month_no) as running_total from monthly_visits ;
-- Calculate month-over-month growth in patient visits.
with mom as (
select month(Patient_Admission_Date) as month_no,
monthname(Patient_Admission_Date) as month_name, 
count(*) patient_visits 
from hospital_cleaned_data group by
monthname(Patient_Admission_Date), month(Patient_Admission_Date) 
order by month(Patient_Admission_Date) asc)
select *,
lag(patient_visits) over(order by month_no) previous_month,patient_visits- 
lag(patient_visits) over(order by month_no) growth  from mom;
-- Find patients whose satisfaction score is higher than the department average.
select * from hospital_cleaned_data h where Patient_Satisfaction_Score > 
(select avg(Patient_Satisfaction_Score)  from hospital_cleaned_data  where Department_Referral = h.Department_Referral );

-- Find departments with the highest proportion of admitted patients.
select Department_Referral , 
round(avg(Patient_Admission_Flag),2) as admission_proportion 
from hospital_cleaned_data group by Department_Referral order by admission_proportion desc;
-- Calculate the contribution (%) of each department to total referrals.
select Department_Referral,
count(*) as total_referral,
round(count(*)*100/(select count(*) from hospital_cleaned_data),2) contribution 
from hospital_cleaned_data
group by Department_Referral;
-- Identify duplicate Patient IDs (if any).\
select Patient_Id,
count(*) as duplicate_count 
from hospital_cleaned_data 
group by Patient_Id 
having count(*) > 1;
-- Find patients admitted on weekends.
select * from hospital_cleaned_data 
where dayname(Patient_Admission_Date) 
IN ('Saturday','Sunday');
-- Identify the busiest quarter.
select quarter(Patient_Admission_Date) as Quater,
count(*) as total_patient 
from hospital_cleaned_data 
group by Quater 
order by total_patient DESC limit 1;
-- 
SELECT

COUNT(*) Total_Patients,

SUM(Patient_Admission_Flag) Total_Admissions,

ROUND(AVG(Patient_Age),2) Avg_Age,

ROUND(AVG(Patient_Satisfaction_Score),2) Avg_Satisfaction,

COUNT(DISTINCT Department_Referral) Departments,

COUNT(DISTINCT Patient_Race) Races,

ROUND(AVG(Patient_Admission_Flag)*100,2) Admission_Rate

FROM hospital_cleaned_data;


select* from hospital_cleaned_data;
 

SELECT @@hostname;
SELECT @@port;
SELECT DATABASE();
SELECT VERSION();

SELECT user, host, plugin
FROM mysql.user;
ALTER USER 'root'@'localhost'
IDENTIFIED WITH mysql_native_password BY '1234';
FLUSH PRIVILEGES;
SHOW PLUGINS;
CREATE USER 'powerbi'@'localhost'
IDENTIFIED WITH mysql_native_password BY '1234';
GRANT ALL PRIVILEGES
ON hospital_db.*
TO 'powerbi'@'localhost';
FLUSH PRIVILEGES;
SELECT user, host, plugin
FROM mysql.user
WHERE user='powerbi';

