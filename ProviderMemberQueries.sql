
declare @NHMemberID Varchar(50);
set @NHMemberID = 'NH202211340133'


IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp
(NHMemberID varchar(20))


--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210405617') -- ticket # 58265
insert into #NHMemberIDTemp (NHMemberID) values ('NH202211340133') -- has the benefit


-- Provider Member Info
select 'Provider.MemberProfiles' TableName,
[MemberProfileID],[NHMemberID],[FirstName],[LastName],MiddleName, cast([DateOfBirth] as date) [DateOfBirth]
,[InsuranceCarriersId],[InsuranceHealthPlansId],[Gender],[IsActive]
,[CreateDate],[CreateUser],[ModifyDate],[ModifyUser]
From Provider.memberProfiles where NHMemberid in (select NHMemberID from #NHMemberIDTemp )


--Address
select 'Provider.MemberLocations' TableName,
AddressTypeCode,[Address1],[Address2],[City],[State],[ZipCode],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser]
From [provider].[MemberLocations]
where memberprofileID in (select memberprofileID From Provider.memberProfiles where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))

  --select * from  [provider].[MemberProgramDetails] where memberprofileid in (
  --select memberprofileid From Provider.memberProfiles where nhmemberid = @NHMemberID
  --)
--Insurances
select 'Provider.MemberInsurances' TableName,
MemberInsuranceID, 
memberprofileid,
mi.DataSource,
mi.[InsuranceCarrierID],
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = mi.[InsuranceCarrierID] ), 
mi.InsuranceHealthPlanID,
HealthPlanName = (select HealthPlanName from [Insurance].[InsuranceHealthPlans] ihp where ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID ) , 
[InsuranceType],
cast([InsuranceEffectiveDate] as date) InsuranceEffectiveDate ,
cast([InsuranceEndDate] as date) InsuranceEndDate,
[IsActive],
[CreateDate],
[CreateUser],
[ModifyDate],
[ModifyUser]
from [provider].[MemberInsurances] mi where memberprofileID in (select memberprofileID From Provider.memberProfiles where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))
order by mi.MemberInsuranceID

  --select * From Provider.MemberInsuranceDetails isInsuranceEligibilityVerified
-- Insurance Details
SELECT 'Provider.MemberInsuranceDetails' as TableName, *
FROM [provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (
							SELECT MemberInsuranceID FROM [provider].[MemberInsurances] 
                                                               WHERE memberprofileID IN ( 
																						  SELECT memberprofileID FROM Provider.memberProfiles 
                                                                                          WHERE NHMemberid in (select NHMemberID from #NHMemberIDTemp)
																						)
						   )
order by MemberInsuranceID

-- Insurance Verification only when eligibility is absent
select 'InsuranceVerification' as Query,'provider.IVQueue' as TableName,  IsActive, * from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp )

--Phone Numbers
select *--'Provider.MemberPhoneNumbers' TableName,[memberprofileID],[PhoneNumber],[AreaCode],[CountryCode],[CreateDate],[CreateUser],[ModifyDate], [ModifyUser] 
From [provider].[MemberPhoneNumbers]
where memberprofileID in (select memberprofileID From Provider.memberProfiles where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))

--Member Appointments

select 'Provider.MemberAppointments' TableName, [MemberAppointmentId]--,MemberProfileId
,[AppointmentStatus],[IsActive], [StartDate] AppointmentDate, cast([StartTime] as time) AppointmentTime,[Confirmed]
,(select AppointmentTypeName from [provider].[AppointmentTypes] where [AppointmentTypeId] = ma.[AppointmentTypeId]) ApmtType
--,(select l.[Address1]+', ' +  l.City +' '+ l.State+' '+l.zip  from [provider].[Locations] l where l.LocationId =ma.[LocationId]) Location
--,(select ProviderName from Provider.ProviderProfiles where Providerid= ma.[ProviderId]) Provider
--,(select Username from [auth].[UserProfiles] where Userprofileid= ma.UserProfileID) HCP
,[CreateDate],[CreateUser],[ModifyDate],[ModifyUser]
from [provider].[MemberAppointments] ma
where 1 = 1
and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))))
--

--Member Appointments History
/*
select 'Provider.MemberAppointments_History' TableName,[MemberAppointmentId]
,[AppointmentStatus],[StartDate],cast([StartTime] as time) AppointmentTime,[Confirmed]
,(select AppointmentTypeName from [provider].[AppointmentTypes] where [AppointmentTypeId] = ma.[AppointmentTypeId]) ApmtType
,(select l.[Address1]+', ' +  l.City +' '+ l.State+' '+l.zip  from [provider].[Locations] l where l.LocationId =ma.[LocationId]) Location
,(select ProviderName from Provider.ProviderProfiles where Providerid= ma.[ProviderId]) Provider
,(select Username from [auth].[UserProfiles] where Userprofileid= ma.UserProfileID) HCP
,[CreateDate],[CreateUser],[IsActive],[ModifyDate],[ModifyUser]
from [provider].[MemberAppointments_History] ma
where MemberProfileId  in (select memberprofileID From Provider.memberProfiles where nhmemberid = @NHMemberID)
--and [StartDate] >  getdate() --and getdate()+30
--and createuser <> 'System'
--and [MemberAppointmentId] > 4122
--order by [IsActive], MemberProfileId desc
*/

-- Call History
SELECT 'Provider.callconversations' TableName,
  cc.[CallConversationId],
  [AgentUserProfileName],
  [CallBound],
  [StartTime],
  [EndTime],
  [CallEndSummary],
  [CallerNumber],
  [CallingNumber],
  EventCreateDate,
  EventCreateUser,
  EventName,
  ReferenceIDsData
FROM callcenter.callconversations cc
LEFT OUTER JOIN (SELECT
					  callconversationid,
					  createDate EventCreateDate,
					  createUser EventCreateUser,
					  EventName = (SELECT EventName FROM [CallCenter].[Events] ce WHERE ce.ID = cpe.eventID AND EventTriggerBy = 'DISPOSITION'), 
					  ReferenceIDsData
					FROM callcenter.callpageevents cpe
					WHERE 1 = 1 AND EXISTS (SELECT 1 FROM [CallCenter].[Events] ce1 WHERE ce1.ID = cpe.eventid AND EventTriggerBy = 'DISPOSITION')
					) e
  ON (e.callconversationid = cc.callconversationid)
WHERE membernhmemberid in (select NHMemberID from #NHMemberIDTemp )
ORDER BY cc.[CallConversationId] DESC



--Check appointments----

select 'provider.MemberCharts' as TableName, * from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
)


select 'provider.MemberChartData' as TableName, * from [provider].[MemberChartData]
where memberchartid in ( select memberchartid from [provider].[MemberCharts] 
						 where memberprofileid in ( select memberprofileid from [provider].[MemberProfiles] 
													where NHMemberid in ( select NHMemberID from #NHMemberIDTemp )
												   )
	                    )

select 'provider.MemberAppointments' as TableName, * 
from [provider].[MemberAppointments] ma
where 1 = 1 and memberchartdataid in ( select memberchartdataid from [provider].[MemberChartData] 
									   where memberchartid in ( select memberchartid from [provider].[MemberCharts]
																where memberprofileid in ( select memberprofileid from [provider].[MemberProfiles] 
																						   where NHMemberid in ( select NHMemberID from #NHMemberIDTemp )
																					     )
															   )
									 ) 
order by 1 desc

select 'provider.MemberAppointments_History' as TableName, *
from [provider].[MemberAppointments_History] ma
where 1 = 1 and memberchartdataid in ( select memberchartdataid from [provider].[MemberChartData] 
									   where memberchartid in ( select memberchartid from [provider].[MemberCharts] 
															   where memberprofileid in ( select memberprofileid from [provider].[MemberProfiles]
																						  where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
																						)
															 )
								    )
order by 2 desc
--Check orders----------



select 'Orders.Orders' as TableName, * from orders.orders where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
order by OrderID


select * from Member.MemberCards where NHMemberId in  (select NHMemberID from #NHMemberIDTemp )


/*

select * from Provider.MemberInsurancedetails where MemberInsuranceID in (307350,381719)

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107098791')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106779994')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106978675')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202001969506')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106978675')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106810032')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005443975')  -- # 42965
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106765843')  -- # 42877
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004745183')  -- # 42655
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106774922')  --# 42874
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002414895')  --# 42823

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002837977')  -- #42701 -- call center, no orders
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002580388')  -- #42701 --in the request, right one elig
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002210527') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002414895')  -- #42823 --

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004832037')    -- #43449 --
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202006133690') --43390
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002536714')  -- 43194
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002853330') -- 45071 Deborah Khan --done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002853294') -- 45071 Arif Khan
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002842861') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005150188') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005154556') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005366365') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002206426') --  # 44703
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002720411') -- # 44674
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901284507') -- # 43486
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202004786359') -- # 44418
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005392999') -- for Fitting Fee Appointment Date Marjorie Demorast
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005628125') -- for Fitting Fee Appointment Date Marjorie Demorast
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005628125') -- issue
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005611816') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106993779') -- no issue
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005628129') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106567498') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107193500') 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202005618695') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005667747') --  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005613703')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005953463')  -- joseph miceli
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107509081')  -- Guadalupe Palacios
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005607846')  -- Guadalupe Palacios
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202106659150')
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107377752')  -- Andy Chung S
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002198929')  -- Gennaro Parise -- 53616
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107339288')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901393855')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106659150')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901393855')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002175427')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002175427')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002177883')  -- ticket #

*/

