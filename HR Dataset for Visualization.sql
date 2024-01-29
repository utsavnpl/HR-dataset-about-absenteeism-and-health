--we create a join table first

select * 
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on 
a.Reason_for_absence = r.Number;

--Find the healthiest employee
select * 
from Absenteeism_at_work
where Social_drinker = 0
and Social_smoker = 0
and Body_mass_index < 25 and 
Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours) from Absenteeism_at_work)

-- compensation rate increase for non-smokers budget $983,221 so .68 increase per hour / 1414.4 per year 
select count (*) as nonsmokers
from Absenteeism_at_work
where Social_smoker = 0

-- optimise the query 
select 
a.ID,
r.Reason,
Month_of_absence,
Body_mass_index,
Case when Body_mass_index < 18.5 then 'Underweight'
	 when Body_mass_index between 18.5 and 25 then 'Healthy Weight'
	 when Body_mass_index between 25 and 30  then 'Overweight'
	 when Body_mass_index <30 then 'obese'
	 Else 'Unknown' end as BMI_Category,
CASE WHEN Month_of_absence in (12,1,2) Then 'WINTER'
	 WHEN Month_of_absence in (3,4,5) Then 'SPRING'
	 WHEN Month_of_absence in (6,7,8) Then 'SUMMER'
	 WHEN Month_of_absence in (9,10,11) Then 'FALL'
	 ELSE 'Unknown' End as Season_Names,
Month_of_absence,
Day_of_the_week,
Transportation_expense
from Absenteeism_at_work a
left join compensation b
on a.ID = b.ID
left join Reasons r on 
a.Reason_for_absence = r.Number;

-- We are using this optimized query in POWER BI to build the dashboard for the HR Department to distribute the compensation 