/*
The clientcodes table and the eligibility table has 10 datasources for Molina, There is only one datasource available in the master.members table for Molina. It is ('ELIG_MLNA')
The datasource in the clientcodes and the eligibility table are
('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')

*/

--Molina datasource in master.members is 'ELIG_MLNA'
select * from master.members
where datasource in ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')

select * from insurance.InsuranceCarriers where InsuranceCarrierName like '%molina%'

select * from master.members where datasource like '%MLNA%'
select * from elig.clientCodes where DataSource like '%MLNA%'

select * from auth.UserProfiles where FirstName like '%Aniru%'
select * from information_schema.columns where TABLE_NAME like '%UserProfiles%'


/*
ID	ClientCode	ClientName	DataSource	InsuranceCarrierID	InsuranceHealthPlanID	EligStartDate	isActive	CreateDate	CreateUser	ModifyDate	ModifyUser	MasterDataSource	RptClientName
66	H474	Molina MC	ELIG_MLNA_MC	380	NULL	2022-01-01	1	2021-09-03 15:55:18.883	sdaggubati	2021-09-03 15:55:18.883	sdaggubati	ELIG_MLNA	Molina
124	H474_KY	Molina MC KY	ELIG_MLNA_MC_KY	380	NULL	2022-01-01	1	2022-03-08 18:02:37.450	appuser	2022-03-08 18:02:37.450	appuser	ELIG_MLNA	NULL
110	H474_NV	Molina NV	ELIG_MLNA_NV	400	NULL	2022-01-01	1	2021-12-30 16:37:12.267	appuser	2021-12-30 16:37:12.267	appuser	ELIG_MLNA	Molina NV
67	H475	Molina MMP	ELIG_MLNA_MMP	380	NULL	2022-01-01	1	2021-09-03 15:55:18.883	sdaggubati	2021-09-03 15:55:18.883	sdaggubati	ELIG_MLNA	Molina
114	H475_CA	Molina MMP CA	ELIG_MLNA_MMP_CA	380	NULL	2022-01-01	1	2022-01-05 19:27:03.353	appuser	2022-01-05 19:27:03.353	appuser	ELIG_MLNA	Molina
115	H475_IL	Molina MMP IL	ELIG_MLNA_MMP_IL	380	NULL	2022-01-01	1	2022-01-05 21:34:12.633	appuser	2022-01-05 21:34:12.633	appuser	ELIG_MLNA	Molina
116	H475_MI	Molina MMP MI	ELIG_MLNA_MMP_MI	380	NULL	2022-01-01	1	2022-01-05 21:42:12.280	appuser	2022-01-05 21:42:12.280	appuser	ELIG_MLNA	Molina
117	H475_OH	Molina MMP OH	ELIG_MLNA_MMP_OH	380	NULL	2022-01-01	1	2022-01-05 21:48:30.910	appuser	2022-01-05 21:48:30.910	appuser	ELIG_MLNA	Molina
118	H475_SC	Molina MMP SC	ELIG_MLNA_MMP_SC	380	NULL	2022-01-01	1	2022-01-05 21:53:22.623	appuser	2022-01-05 21:53:22.623	appuser	ELIG_MLNA	Molina
119	H475_TX	Molina MMP TX	ELIG_MLNA_MMP_TX	380	NULL	2022-01-01	1	2022-01-05 21:55:43.763	appuser	2022-01-05 21:55:43.763	appuser	ELIG_MLNA	Molina
*/

-- All these datasources exist in the eligibility
select distinct datasource  from elig.mstrEligBenefitData where datasource in ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')
select distinct datasource from elig.mstrEligBenefitData where datasource like '%MLNA%'

/*
ELIG_MLNA_MMP_MI
ELIG_MLNA_MC_KY
ELIG_MLNA_MMP_SC
ELIG_MLNA_MMP_IL
ELIG_MLNA_MMP_CA
ELIG_MLNA_MMP_TX
ELIG_MLNA_MMP
ELIG_MLNA_MC
ELIG_MLNA_NV
ELIG_MLNA_MMP_OH

*/


-- Just one datasource exists for Moline in the masters.members
-- ('ELIG_MLNA')

select distinct datasource from master.Members
select * from  bireports.eventNames

DECLARE @StartDate DATE = '03-01-2022' ;
DECLARE @EndDate DATE = '06-30-2022';
select @StartDate,@EndDate

IF OBJECT_ID('tempdb..#RS_HF_Audit1') IS NOT NULL DROP TABLE #RS_HF_Audit1

select Callbound, callingnumber, z2.FirstName, z2.LastName, z2.DataSource,z2.MedicareID, CallDate, CallTime, CategoryoftheCall, CallEndSummary, MemberNHMemberId,nhlinkid,agentuserprofilename, 
Cast(NULL as bigint) as MasterMemberID, Cast(NULL as bigint) as HealthPlanID, Cast(NULL as nvarchar) as MemberInsuranceID

into #RS_HF_Audit1 from (
              select 
              CONVERT(varchar, CAST(c.createdate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE),111) CallDate,
              CONVERT(varchar, CAST(c.createdate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS TIME),108) CallTime,
              Callbound, callingNumber,
              e1.CombinedName CategoryoftheCall,
              c.MemberNHMemberId,
              c.CallEndSummary ,
			  agentuserprofilename
              from CallCenter.CallConversations c
              inner join callcenter.CallPageEvents cp  on (c.CallConversationId = cp.CallConversationId)
              inner join bireports.eventNames e1 on (e1.EventId = cp.EventId)
              where 1 = 1
            --  and CAST(c.createdate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) between cast('20210808' as date) and cast('20210808' as date)
			  and CAST(c.createdate AS DATE) between '03-01-2022' AND '06-30-2022'
              and exists (select 1 from master.Members m where m.NHMemberID = c.MemberNHMemberId and m.DataSource in ('ELIG_MLNA'))
              and exists (select 1 from jobs.Events e where e.EventId = cp.EventId and EventTriggerBy = 'DISPOSITION')
              and c.AgentUserProfileName not in ('rsareddy','mnanduri','sraghavendran','ZPerlmanCC','awrenn','SDaggubati','skapa','spotiigari', 'sballa','AChowlur', 'VJoshi' )
                           ) z
						inner join master.members z1 on (z.MemberNHMemberId = z1.NHMemberID)
						inner join (
                           select distinct LastName, FirstName, MedicareID, MasterMemberID, DataSource From elig.mstrEligBenefitData where DataSource in ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')
                           and getdate() between RecordEffDate and RecordEndDate
                     ) z2 on (z2.MasterMemberID = z1.MemberID )


--alter table #RS_HF_Audit1 add mastermemberid bigint, healthplanid  bigint,MemberInsuranceId varchar

--select * from #RS_HF_Audit1

update t 
set t.MasterMemberID = s.memberid
from #RS_HF_Audit1 t
inner join master.members s on (t.Membernhmemberid = s.nhmemberid)

update t
set t.healthplanid = s.inshealthplanid
--t.MemberInsuranceId = s.nhlinkid
from #RS_HF_Audit1 t
inner join (select  distinct mastermemberid , max(inshealthplanid) inshealthplanid,nhlinkid from elig.mstrEligBenefitData
where datasource in ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')
group by mastermemberid ,nhlinkid) s on (t.mastermemberid = s.mastermemberid)



select MemberNHMemberId,nhlinkid as MemberInsuranceId,Callbound, Callingnumber, a.DataSource, a.FirstName, a.LastName
, MedicareID, substring(HealthPlanNumber,1,5) ContractID, substring(HealthPlanNumber,7,3) PLANID,  CallDate
, CallTime, CategoryoftheCall, CallEndSummary,a.agentuserprofilename,x.ProfileIDFirstname,x.ProfileIDLastname
,'03-01-2022' as startDate,'06-30-2022' as enddate
from #RS_HF_Audit1 a
inner join elig.BenefitCrossWalk b on (b.insurancehealthplanid= a.healthplanid and b.InsuranceCarrierId in (380, 138, 400 ))
left join (
     select userprofileid userprofileid,
	        username      ProfileIDUsername,
	        firstname     ProfileIDfirstname,
			lastname      ProfileIDlastname
			from auth.UserProfiles
			where 1=1 )x on a.agentuserprofilename = x.ProfileIDUsername
where 1 = 1