--1.Total employees
select count(*) as TotalEmployees
from hr_attrition;

--2.showing attrition split (meaning how many left vs how many stayed)
select Attrition, count(*) as EmployeeCount
from hr_attrition
group by Attrition;

--3.calculating attrition rate percentage
select
 round(
	(sum(case when Attrition = "Yes" then 1 else 0 end) * 100.0)/count(*),2) as AttritionRatePercent
from hr_attrition;

--4a.attrition count by Department
select Department, count(*) as EmployeeLeft
from hr_attrition
where Attrition = "Yes"
group by Department
order by EmployeeLeft DESC;

--4b.attrition rate by Department
select Department,
	round(
		(sum(case when Attrition = "Yes" then 1 else 0 end) * 100.0)/count(*),2) as AttritionRatePercent
from hr_attrition
group by Department
order by AttritionRatePercent DESC;

--5a.Compare avg salary (left vs stayed)
select Attrition,round(avg(MonthlyIncome),2) as AverageMonthlyIncome
from hr_attrition
group by Attrition;

--5b.Salary bands
select 
	case 
		when MonthlyIncome < 3000 then "Low"
		when MonthlyIncome between 3000 and 7000 then "Medium"
		else "High"
	end as SalaryBand,
	count(*) as TotalEmployee,
	sum(case when Attrition="Yes" then 1 else 0 end) as EmployeeLeft
from hr_attrition
group by SalaryBand;

--5c.Attrition rate by salary band
select 
	case 
		when MonthlyIncome < 3000 then "Low"
		when MonthlyIncome between 3000 and 7000 then "Medium"
		else "High"
	end as SalaryBand,
	round(
		sum(case when Attrition = "Yes" then 1 else 0 end)*100/count(*),
		2) as AttritionRatePercent
from hr_attrition
group by SalaryBand
order by AttritionRatePercent DESC;

--6a.Attrition rate by years at company
select 
	case 
		when YearsAtCompany<2 then "0-2 years"
		when YearsAtCompany between 3 and 5 then "3-5 years"
		when YearsAtCompany between 6 and 10 then "6-10 years"
		else "10+ years"
	end as ExperienceGroup,
	round(
		sum(case when Attrition="Yes" then 1 else 0 end)*100.0/count(*),2) as AttritionRatePercent
from hr_attrition
group by ExperienceGroup
order by AttritionRatePercent DESC;

--6b. Attrition rate by age group
select 
	case 
		when Age<30 then "Under 30"
		when Age between 30 and 40 then "30-40"
		when Age between 41 and 50 then "41-50"
		else "50+"
	end as AgeGroup,
	round(
		sum(case when Attrition="Yes" then 1 else 0 end)*100.0/count(*),2) as AttritionRatePercent
from hr_attrition
group by AgeGroup
order by AttritionRatePercent DESC;


