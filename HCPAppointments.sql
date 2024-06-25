
select distinct
A.*
,o.OrderID
,CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) as OrderCreateDate
,JSON_VALUE(o.MemberData,'$.firstName') as MemberfirstName
,JSON_VALUE(o.MemberData,'$.lastName') as MemberlastName
,JSON_VALUE(o.MemberData,'$.insurance.nhMemberId') nhMemberId

,pp.ProviderId
,x.HCPId
,L.LocationId
,o.OrderType
from orders.orders o with (nolock) 
inner join [dbo].[File2] A
on (a.[NPINumber   ]=(JSON_VALUE(ProviderData,'$.hcp.npiNumber')))
 LEFT JOIN provider.ProviderProfiles pp with (nolock) ON
 (pp.ProviderId=CAST(JSON_VALUE(o.ProviderData,'$.providerId') AS INT))
LEFT JOIN provider.locations l with (nolock) ON (l.LocationId = CAST(JSON_VALUE(o.ProviderData,'$.address.locationId') AS INT))
left join provider.HCPProviderProfile x on a.[NPINumber   ]=x.NPINumber
where CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) > '12/31/2020'
and o.OrderType='NEW'
order by OrderID


---------------------------------------------
select * from [dbo].[File2]
select distinct [NPINumber   ] from [dbo].[File1]

select distinct
A.*
,o.OrderID
,CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) as OrderCreateDate
,JSON_VALUE(o.MemberData,'$.firstName') as MemberfirstName
,JSON_VALUE(o.MemberData,'$.lastName') as MemberlastName
,JSON_VALUE(o.MemberData,'$.insurance.nhMemberId') nhMemberId

,pp.ProviderId
,L.LocationId
,x.HCPId
from [dbo].[File1] A 
left join orders.orders o with (nolock) 
on (a.[NPINumber   ]=(JSON_VALUE(ProviderData,'$.hcp.npiNumber')))
 LEFT JOIN provider.ProviderProfiles pp with (nolock) ON
 (pp.ProviderId=CAST(JSON_VALUE(o.ProviderData,'$.providerId') AS INT))
LEFT JOIN provider.locations l with (nolock) ON (l.LocationId = CAST(JSON_VALUE(o.ProviderData,'$.address.locationId') AS INT))
left join provider.HCPProviderProfile x on a.[NPINumber   ]=x.NPINumber
where CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) > '12/31/2020'
and o.OrderType='NEW'
order by OrderID




--2017----

select distinct
A.*
,o.OrderID
,CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) as OrderCreateDate
,JSON_VALUE(o.MemberData,'$.firstName') as MemberfirstName
,JSON_VALUE(o.MemberData,'$.lastName') as MemberlastName
,JSON_VALUE(o.MemberData,'$.insurance.nhMemberId') nhMemberId

,pp.ProviderId
,L.LocationId
,x.HCPId
from [dbo].[File2] A 
left join orders.orders o with (nolock) on o.OrderType='NEW' and CAST(o.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) > '12/31/2020'
and (a.[NPINumber   ]=(JSON_VALUE(ProviderData,'$.hcp.npiNumber')))
 LEFT JOIN provider.ProviderProfiles pp with (nolock) ON
 (pp.ProviderId=CAST(JSON_VALUE(o.ProviderData,'$.providerId') AS INT))
LEFT JOIN provider.locations l with (nolock) ON (l.LocationId = CAST(JSON_VALUE(o.ProviderData,'$.address.locationId') AS INT))
left join provider.HCPProviderProfile x on a.[NPINumber   ]=x.NPINumber
order by OrderID
-------------------------------------------------------------------

DROP TABLE IF EXISTS #temp_appt


SELECT DISTINCT memberchartdataid, MemberChartID, NHMemberID, FirstName,LastName, MemberProfileID
,  AppointmentStatus, CreateDate, AppointmentDate
, ProviderID, LocationID, HCPUserProfileID

INTO #temp_appt 
FROM (
              SELECT mcd.memberchartdataid, mc.MemberChartID, mp.NHMemberID, mp.MemberProfileID,
			   mp.FirstName,mp.LastName
              ,at.AppointmentTypeId,AppointmentTypeName, ma.AppointmentStatus,  ma.isactive IsActive, 
              CAST(ma.createdate AT TIME ZONE 'UTC'   AT TIME ZONE 'Eastern Standard Time' AS DATE) CreateDate,
              CAST(ma.StartDate AS DATE) AppointmentDate,
              JSON_VALUE(mcd.processData, '$.providerId') ProviderID , 
              JSON_VALUE(mcd.processData, '$.locationId')  LocationID , 
              JSON_VALUE(mcd.processData, '$.HCPUserProfileId') HCPUserProfileID
   
              FROM [provider].[MemberAppointments] ma
              LEFT OUTER JOIN [provider].[AppointmentTypes] at ON (at.AppointmentTypeID = ma.AppointmentTypeID)
              LEFT OUTER JOIN [provider].[MemberChartData] mcd ON (ma.MemberChartDataID = mcd.MemberChartDataID)
              LEFT OUTER JOIN [provider].[MemberCharts] mc ON (mc.MemberChartID = mcd.MemberChartID)
              LEFT OUTER JOIN provider.MemberProfiles mp ON (mp.memberprofileid = mc.memberprofileid)
              WHERE 1 = 1
              AND ma.AppointmentStatus NOT IN ('Cancel','Cancelled')
              AND at.AppointmentTypeName IN ('Testing')
              AND ma.isactive = 1
              AND ( CAST(ma.createdate AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' AS DATE) > cast('20201231' as date)
                 OR CAST(ma.StartDate AS DATE) > cast('20201231' as date))
             
) f
WHERE 1 = 1
--------------------------------------------------------------
 select  A.*
  ,d.NHMemberId
 ,d.AppointmentDate
 ,d.FirstName As MemebrFirstName
 ,d.LastName  AS MemberLastName
 ,d.ProviderID
 ,d.LocationID
 ,b.HCPId
 
 from [dbo].[File2] A
 left join provider.HCPProviderProfile  B
 on A.[NPINumber   ]=B.NPINumber
 left join provider.providerusers C
 on b.HCPId=c.HCPId
 left join #temp_appt d on c.UserProfileId =d.HCPUserProfileID and c.ProviderId=d.ProviderID



  select  distinct A.*
  ,d.NHMemberId
 ,d.AppointmentDate
 ,d.FirstName As MemebrFirstName
 ,d.LastName  AS MemberLastName
 ,d.ProviderID
 ,d.LocationID
 ,b.HCPId
 
 from [dbo].[File1] A
 left join provider.HCPProviderProfile  B
 on A.[NPINumber   ]=B.NPINumber
 inner join provider.providerusers C
 on b.HCPId=c.HCPId
 inner join #temp_appt d on c.UserProfileId =d.HCPUserProfileID and c.ProviderId=d.ProviderID


 