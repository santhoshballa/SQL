

declare @NHMemberID Varchar(50);
set @NHMemberID = 'NH201901327383 '--NH201800500702

--select * From [vsdatamig].[ULT_NH_ELG_DATA] where nhmemberid = @NHMemberID

-- Master Member Info
select 'Master.Members' TableName,
[MemberID],[NHMemberID],[FirstName],[MiddleInitial],[LastName], cast([DateOfBirth] as date) [DateOfBirth],[Gender],[IsActive],[Title],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser], datasource,NHLinkID
 From master.members where nhmemberid = @NHMemberID

 -- Address
 select 'Master.Addresses' TableName,
Id,[AddressTypeCode],[Address1],[Address2],[City],[State],[ZipCode],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],IsPreferredaddress
  From [Master].[Addresses]
  where memberid in (select memberid From master.members where nhmemberid = @NHMemberID)
  order by ID

 --Insurances
select 'Master.MemberInsurances' TableName,id,
[ID] MemberInsuranceID, mi.DataSource,
mi.InsuranceCarrierID,
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = mi.[InsuranceCarrierID] ), 
mi.InsuranceHealthPlanID,
HealthPlanName = (select HealthPlanName from [Insurance].[InsuranceHealthPlans] ihp where ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID ) , 
[InsuranceType],
cast([InsuranceEffectiveDate] as date) InsuranceEffectiveDate,
cast([InsuranceEndDate] as date) InsuranceEndDate, 
[IsActive],
[CreateDate],
[CreateUser],
[ModifyDate],
[ModifyUser]
 from  [Master].[MemberInsurances] mi where memberid in (select memberid From master.members where nhmemberid = @NHMemberID)
 order by mi.ID

 -- Insurance Details
SELECT 'Master.MemberInsuranceDetails' TableName,id,
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
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances] 
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE nhmemberid = @NHMemberID))
order by ID

--Phone Numbers
select 'Master.PhoneNumbers' TableName, [MemberID],[PhoneTypeCode],[PhoneNbr],[CreateDate],[CreateUser],[ModifyDate], [ModifyUser] 
From [Master].[PhoneNumbers]
where memberid in (select memberid From master.members where nhmemberid = @NHMemberID)

-- Call History
SELECT 'callcenter.callconversations' TableName,
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
order by MemberChartId


select * from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where nhmemberid = @NHMemberID
))
order by MemberChartDataId

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