
select*from[dbo].[crimes]

--1 Populating empty fields 

select count(shooting), SHOOTING from [dbo].[crimes] group by SHOOTING

select*from[dbo].[crimes] where  Long=' '

update [dbo].[crimes] set DISTRICT= NULL where DISTRICT=' '

update [dbo].[crimes] set REPORTING_AREA= NULL where REPORTING_AREA=' '

update [dbo].[crimes] set shooting= 'N' where SHOOTING=' '

update [dbo].[crimes] set UCR_PART= NULL where UCR_PART=' '

update [dbo].[crimes] set STREET= NULL where STREET=' '

update [dbo].[crimes] set  lat=(select SUBSTRING(location,2,10) ) where lat=' '

update [dbo].[crimes] set Long=(select SUBSTRING(location,14,13)) where long=' '

--Populate UCR_PART with NULL values 
select distinct ucr_part from[dbo].[crimes]
select*from [dbo].[crimes] where UCR_PART is null

select distinct r1.OFFENSE_CODE,r2.OFFENSE_CODE,r1.OFFENSE_DESCRIPTION,r2.OFFENSE_DESCRIPTION,r1.UCR_PART,r2.UCR_PART
from [dbo].[crimes] r1 
join[dbo].[crimes]  r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.OFFENSE_DESCRIPTION=r2.OFFENSE_DESCRIPTION  where
r1.UCR_PART is null

update r1
set UCR_PART = isnull (r1.ucr_part,r2.ucr_part) from [dbo].[crimes] r1 
join[dbo].[crimes]  r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.OFFENSE_DESCRIPTION=r2.OFFENSE_DESCRIPTION  where
r1.UCR_PART is null


select  count(*),offense_description,OFFENSE_CODE,OFFENSE_CODE_GROUP from[dbo].[crimes] group by 
OFFENSE_DESCRIPTION,OFFENSE_CODE,OFFENSE_CODE_GROUP  order by 4

select  count(*),offense_description,OFFENSE_CODE,OFFENSE_CODE_GROUP,UCR_PART from[dbo].[crimes] group by 
OFFENSE_DESCRIPTION,OFFENSE_CODE,OFFENSE_CODE_GROUP,UCR_PART  having ucr_part ='Part Two' order by 4

select  count(*),OFFENSE_CODE_GROUP,OFFENSE_DESCRIPTION,offense_code, UCR_PART from[dbo].[crimes] group by 
ucr_part,OFFENSE_CODE_GROUP,OFFENSE_DESCRIPTION,offense_code having UCR_PART like'%three%' order  by 2

select count(*), offense_code_group,offense_description, UCR_PART from [dbo].[crimes]group by 
offense_description,OFFENSE_CODE_GROUP,UCR_PART  order by 1 desc

select count(distinct offense_code_group),UCR_PART from[dbo].[crimes] group by UCR_PART



--Populating district with null values 
select*from [dbo].[crimes] where district is null--1765

select  r1.STREET,r2.STREET,r1.REPORTING_AREA,r2.REPORTING_AREA,r1.DISTRICT,r2.DISTRICT,r1.Location,r2.Location
from  [dbo].[crimes]r1 
join [dbo].[crimes] r2 
on r1.REPORTING_AREA=r2.REPORTING_AREA and r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.location=r2.location and r1.street=r2.street where
r1.DISTRICT is null and r2.DISTRICT is not null  and r1.REPORTING_AREA!=' ' and r1.Location not like '%0000%'

update r1
set district = isnull (r1.district,r2.district) from  [dbo].[crimes]r1 
join [dbo].[crimes] r2 
on r1.REPORTING_AREA=r2.REPORTING_AREA and r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.location=r2.location and r1.street=r2.street where
r1.DISTRICT is null and r2.DISTRICT is not null  and r1.REPORTING_AREA!=' ' and r1.Location not like '%0000%'



select distinct r1.STREET,r2.STREET,r1.REPORTING_AREA,r2.REPORTING_AREA,r1.DISTRICT,r2.DISTRICT,r1.Location,r2.Location
from[dbo].[crimes]  r1 
join  [dbo].[crimes]r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.STREET=r2.STREET  where
r1.DISTRICT is null  and r1.Location=r2.Location and r1.Location not like '%0000%'

update r1
set district = isnull (r1.district,r2.district) from[dbo].[crimes]  r1 
join  [dbo].[crimes] r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.STREET=r2.STREET  where
r1.DISTRICT is null  and r1.Location=r2.Location and r1.Location not like '%0000%'


--Populating street with null value
select*from [dbo].[crimes] where STREET is null--10871
select distinct r1.STREET,r2.STREET,r1.REPORTING_AREA,r2.REPORTING_AREA,r1.DISTRICT,r2.DISTRICT,r1.Location,r2.Location
from[dbo].[crimes]  r1 
join  [dbo].[crimes]r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.Location=r2.Location and r1.STREET<>r2.STREET  where
 r1.STREET is null and r1.Location not like '%000%'

  update r1
set STREET = isnull (r1.STREET,r2.STREET) from[dbo].[crimes]  r1 
join  [dbo].[crimes]r2 
on  r1.INCIDENT_NUMBER<>r2.INCIDENT_NUMBER and r1.Location=r2.Location  where
 r1.STREET is null

 

--Populating reporting area with null value
select*from [dbo].[crimes] where REPORTING_AREA is null--20250
select distinct r1.STREET,r2.STREET,r1.REPORTING_AREA,r2.REPORTING_AREA,r1.DISTRICT,r2.DISTRICT,r1.Location,r2.Location
from[dbo].[crimes]  r1 
join  [dbo].[crimes]r2 
on  r1.REPORTING_AREA<>r2.REPORTING_AREA and r2.Location=r1.Location 
where r1.REPORTING_AREA is null


 update r1
set reporting_area = isnull (r1.REPORTING_AREA,r2.REPORTING_AREA) from[dbo].[crimes]  r1 
join  [dbo].[crimes]r2 
on  r1.REPORTING_AREA<>r2.REPORTING_AREA and r2.Location=r1.Location 
where r1.REPORTING_AREA is null




--2 find duplicate values

--CHECK 1NF

SELECT*FROM[dbo].[crimes] 

SELECT COUNT(*)FROM[dbo].[crimes] 

---319073

SELECT COUNT(*) FROM (	SELECT DISTINCT*FROM [dbo].[crimes]) AS ABC;

---319073

--ANOTHER WATY TO CHECK FOR DUPLICATES
SELECT *,
	ROW_NUMBER() OVER(
PARTITION BY [INCIDENT_NUMBER],
			[OFFENSE_CODE],
			[REPORTING_AREA],
			[OCCURRED_ON_DATE]
		ORDER BY
		[INCIDENT_NUMBER]
		) row_num
FROM [dbo].[crimes]
ORDER BY[INCIDENT_NUMBER] 


WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
PARTITION BY [INCIDENT_NUMBER],
			[OFFENSE_CODE],
			[REPORTING_AREA],
			[OCCURRED_ON_DATE]
		ORDER BY
		[INCIDENT_NUMBER]
		) row_num
FROM [dbo].[crimes]
--ORDER BY[INCIDENT_NUMBER] 
)
Select*
From RowNUMCTE
Where row_num>1
Order by[INCIDENT_NUMBER] 

SELECT*FROM[dbo].[crimes] WHERE [INCIDENT_NUMBER]='I110694557-00'

--I110694557-00--I130194606-00----I172090479--I152026775-00

--Remove duplicates
WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER(
PARTITION BY [INCIDENT_NUMBER],
			[OFFENSE_CODE],
			[REPORTING_AREA],
			[OCCURRED_ON_DATE]
		ORDER BY
		[INCIDENT_NUMBER]
		) row_num
FROM [dbo].[crimes]
--ORDER BY[INCIDENT_NUMBER] 
)
DELETE
From RowNUMCTE
Where row_num>1
--Order by[INCIDENT_NUMBER] 


--3 Standarize date format

Select OCCURRED_ON_DATE, CONVERT(DATE, OCCURRED_ON_DATE)
From [dbo].[crimes]


update [dbo].[crimes]
set OCCURRED_ON_DATE  = CONVERT(DATE, OCCURRED_ON_DATE)

select*from[dbo].[crimes]where DISTRICT is null and STREET is null and location not like '%0000%'


select UCR_PART,offense_description, count(*) from[dbo].[crimes] group by UCR_PART,OFFENSE_DESCRIPTION having OFFENSE_DESCRIPTION like '%drugs%'