
declare @NHMemberID Varchar(50);
set @NHMemberID = 'NH201901327383'

-- Provider Member Info
select 'Provider.MemberProfiles' TableName,
[MemberProfileID],[NHMemberID],[FirstName],[LastName],MiddleName, cast([DateOfBirth] as date) [DateOfBirth]
,[InsuranceCarriersId],[InsuranceHealthPlansId],[Gender],[IsActive]
,[CreateDate],[CreateUser],[ModifyDate],[ModifyUser]
From Provider.memberProfiles where nhmemberid = @NHMemberID


--Address
select 'Provider.MemberLocations' TableName,
AddressTypeCode,[Address1],[Address2],[City],[State],[ZipCode],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser]
From [provider].[MemberLocations]
  where memberprofileID in (select memberprofileID From Provider.memberProfiles where nhmemberid = @NHMemberID)

  --select * from  [provider].[MemberProgramDetails] where memberprofileid in (
  --select memberprofileid From Provider.memberProfiles where nhmemberid = @NHMemberID
  --)
--Insurances
select 'Provider.MemberInsurances' TableName,
 MemberInsuranceID, memberprofileid,mi.DataSource,mi.[InsuranceCarrierID],
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
from [provider].[MemberInsurances] mi where memberprofileID in (select memberprofileID From Provider.memberProfiles where nhmemberid = @NHMemberID)
order by mi.MemberInsuranceID

  --select * From Provider.MemberInsuranceDetails isInsuranceEligibilityVerified
-- Insurance Details
SELECT 'Provider.MemberInsuranceDetails' TableName,
  MemberInsuranceID,
  [GroupNbr],
  [InsuranceNbr],
  [InsurerInsuranceNbr],
  [OTCCardNumber],
  [OTCSerialNumber],
  [IsActive],
  isInsuranceEligibilityVerified,
  [PatientName],
  [PrimaryInsuredName],
  [PrimaryInsuredRelationShip],
  [CreateDate],
  [CreateUser],
  [ModifyDate],
  [ModifyUser]
 FROM [provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT MemberInsuranceID FROM [provider].[MemberInsurances] 
                                                               WHERE memberprofileID IN (SELECT memberprofileID FROM Provider.memberProfiles 
                                                                                                                        WHERE nhmemberid = @NHMemberID))
order by MemberInsuranceID
--Phone Numbers
select *--'Provider.MemberPhoneNumbers' TableName,[memberprofileID],[PhoneNumber],[AreaCode],[CountryCode],[CreateDate],[CreateUser],[ModifyDate], [ModifyUser] 
From [provider].[MemberPhoneNumbers]
where memberprofileID in (select memberprofileID From Provider.memberProfiles where nhmemberid = @NHMemberID)

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
where nhmemberid = @NHMemberID)))
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
WHERE membernhmemberid = @NHMemberID
ORDER BY cc.[CallConversationId] DESC



--Check appointments----

select * from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where nhmemberid = @NHMemberID
)



select * from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where nhmemberid = @NHMemberID
))


select *
from [provider].[MemberAppointments] ma
where 1 = 1
and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where nhmemberid = @nhmemberid
))
 )order by 1 desc
 select *
from [provider].[MemberAppointments_History] ma
where 1 = 1
and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where nhmemberid =@nhmemberid
))
 )order by 2 desc

--Check orders----------


select * from orders.orders where nhmemberid =@nhmemberid
order by OrderID
