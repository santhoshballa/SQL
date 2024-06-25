/*
drop table #ELIG
SELECT * INTO #ELIG FROM (
SELECT a.*
FROM elig.mstrEligBenefitdata a
WHERE a.IsActive = 1  and FORMAT(GETDATE(), 'yyyy-MM-dd') between BenefitStartDate and BenefitEndDate
--AND datasource = 'ELIG_FLBLUE'
--Order by a.CreateDate desc
) a
*/


SELECT 

-- TOP 1000 
 --MedicareID,

DataSource, insCarrierID, insHealthPlanID, RecordEffDate, RecordEndDate, BenefitStartDate, BenefitEndDate, 
Language, 
CASE	WHEN (LANGUAGE = 'CR') THEN 'Croatian'
		WHEN (LANGUAGE = 'EN') THEN 'English'
		WHEN (LANGUAGE = 'ES') THEN 'Spanish'
		WHEN (LANGUAGE = 'FR') THEN 'French'
		WHEN (LANGUAGE = 'OT') THEN 'Others'
		WHEN (LANGUAGE = 'PT') THEN 'Portuguese' 
		WHEN (LANGUAGE = 'RU') THEN 'Russian'
	ELSE 'NONE'
	END AS LANGUAGE_F
,Gender

,CASE	 WHEN (Gender = 'M') THEN 'Male'
		 WHEN (Gender = 'F') THEN 'Female'
		 ELSE 'Others'
		 END AS Gender_C

,DOB
,CASE	WHEN (YEAR(DOB) >= 1900 AND YEAR(DOB) <= 1909) THEN '1900 - 1909'
		WHEN (YEAR(DOB) >= 1910 AND YEAR(DOB) <= 1919) THEN '1910 - 1919'
		WHEN (YEAR(DOB) >= 1920 AND YEAR(DOB) <= 1929) THEN '1920 - 1929'
		WHEN (YEAR(DOB) >= 1930 AND YEAR(DOB) <= 1939) THEN '1930 - 1939'
		WHEN (YEAR(DOB) >= 1940 AND YEAR(DOB) <= 1949) THEN '1940 - 1949'
		WHEN (YEAR(DOB) >= 1950 AND YEAR(DOB) <= 1959) THEN '1950 - 1959'
		WHEN (YEAR(DOB) >= 1960 AND YEAR(DOB) <= 1969) THEN '1960 - 1969'
		WHEN (YEAR(DOB) >= 1970 AND YEAR(DOB) <= 1979) THEN '1970 - 1979'
		WHEN (YEAR(DOB) >= 1980 AND YEAR(DOB) <= 1989) THEN '1980 - 1989'
		WHEN (YEAR(DOB) >= 1990 AND YEAR(DOB) <= 1999) THEN '1990 - 1999'
		WHEN (YEAR(DOB) >= 2000 AND YEAR(DOB) <= 2009) THEN '2000 - 2009'
		WHEN (YEAR(DOB) >= 2010 AND YEAR(DOB) <= 2019) THEN '2010 - 2019'
		WHEN (YEAR(DOB) >= 2020 AND YEAR(DOB) <= 2029) THEN '2020 - 2029'
		END AS DOB_C

,CASE	WHEN (YEAR(DOB) >= 1900 AND YEAR(DOB) <= 1909) THEN '0'
		WHEN (YEAR(DOB) >= 1910 AND YEAR(DOB) <= 1919) THEN '1'
		WHEN (YEAR(DOB) >= 1920 AND YEAR(DOB) <= 1929) THEN '2'
		WHEN (YEAR(DOB) >= 1930 AND YEAR(DOB) <= 1939) THEN '3'
		WHEN (YEAR(DOB) >= 1940 AND YEAR(DOB) <= 1949) THEN '4'
		WHEN (YEAR(DOB) >= 1950 AND YEAR(DOB) <= 1959) THEN '5'
		WHEN (YEAR(DOB) >= 1960 AND YEAR(DOB) <= 1969) THEN '6'
		WHEN (YEAR(DOB) >= 1970 AND YEAR(DOB) <= 1979) THEN '7'
		WHEN (YEAR(DOB) >= 1980 AND YEAR(DOB) <= 1989) THEN '8'
		WHEN (YEAR(DOB) >= 1990 AND YEAR(DOB) <= 1999) THEN '9'
		WHEN (YEAR(DOB) >= 2000 AND YEAR(DOB) <= 2009) THEN '10'
		WHEN (YEAR(DOB) >= 2010 AND YEAR(DOB) <= 2019) THEN '11'
		WHEN (YEAR(DOB) >= 2020 AND YEAR(DOB) <= 2029) THEN '12'
		END AS DOB_B

,(YEAR(GETDATE()) - YEAR(DOB)) as AGE

,CASE	WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 0 and 10		THEN 'A|0 - 10'
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 10 and 20	THEN 'B|10 - 20' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 20 and 30	THEN 'C|20 - 30' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 30 and 40	THEN 'D|30 - 40' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 40 and 50	THEN 'E|40 - 50' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 50 and 60	THEN 'F|50 - 60' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 60 and 70	THEN 'G|60 - 70' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 70 and 80	THEN 'H|70 - 80' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 80 and 90	THEN 'I|80 - 90' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 90 and 100	THEN 'J|90 - 100' 
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) between 100 and 110	THEN 'K|100 - 110'
		WHEN (YEAR(GETDATE()) - YEAR(DOB)) > 110				THEN 'L|110 - 150' 
		END AGE_B
		
,City,upper(City) as CITY_U, State
,ZipCode, 

CASE WHEN (LEN(SUBSTRING(Zipcode,0,6)) = 5) THEN (SUBSTRING(Zipcode,0,6))
	 ELSE NULL
	 END as ZipCode5

,CreateDate 
,FORMAT(CreateDate, 'yyyy-MM-dd') AS CreateDate_F
,1 as 'Count'
from #ELIG 

where 1=1 
--and datasource = 'ELIG_FLBLUE' 
order by CreateDate desc

/*
select distinct state from #ELIG
select * from #ELIG where city like '%saint%'
select distinct language from #ELIG
select firstname, lastname, language from #ELIG where language  = 'OT'
select firstname, lastname, language from #ELIG where language  = 'RU'
select firstname, lastname, language from #ELIG where language  = 'CR'

select * from #ELIG where firstname like 'LIDIYA'

SELECT Language, COUNT(*) AS MemberCount FROM #ELIG GROUP BY language

select * from information_schema.columns where column_name like 'language' order by table_schema
*/

-- SELECT * FROM #ELIG WHERE ZipCode like '8062%'
--select distinct gender from #ELIG