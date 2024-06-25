-- Check the insurance carrier and the data source of the client
-- The original query--
select * from elig.clientCodes where ClientName like '%Molina%'
select * from elig.clientcodes where InsuranceCarrierID in (138, 380, 400)
select * from insurance.insuranceCarriers where  InsuranceCarrierID in (138, 380, 400)
select * from elig.clientCodes where dataSource = 'ELIG_CCOK'


DECLARE @StartDate DATE = '03-01-2022' ;
DECLARE @EndDate DATE = '06-30-2022';
select @StartDate,@EndDate

IF OBJECT_ID('tempdb..#RS_HF_Audit1') IS NOT NULL DROP TABLE #RS_HF_Audit1

select Callbound, callingnumber, z2.FirstName, z2.LastName, MedicareID, CallDate, CallTime, CategoryoftheCall, CallEndSummary, MemberNHMemberId,nhlinkid,agentuserprofilename, 
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
			  and CAST(c.createdate AS DATE) between  @StartDate AND @EndDate
              and exists (select 1 from master.Members m where m.NHMemberID = c.MemberNHMemberId and m.DataSource = 'ELIG_CCOK')
              and exists (select 1 from jobs.Events e where e.EventId = cp.EventId and EventTriggerBy = 'DISPOSITION')
              and c.AgentUserProfileName not in ('rsareddy','mnanduri','sraghavendran','ZPerlmanCC','awrenn','SDaggubati','skapa','spotiigari', 'sballa')
                           ) z
						inner join master.members z1 on (z.MemberNHMemberId = z1.NHMemberID)
						inner join (
                           select distinct LastName, FirstName,MedicareID,MasterMemberID From elig.mstrEligBenefitData where DataSource = 'ELIG_CCOK'
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
where datasource = 'ELIG_CCOK'
group by mastermemberid ,nhlinkid) s on (t.mastermemberid = s.mastermemberid)



select MemberNHMemberId,nhlinkid as MemberInsuranceId,Callbound, Callingnumber, a.FirstName, a.LastName
, MedicareID, substring(HealthPlanNumber,1,5) ContractID, substring(HealthPlanNumber,7,3) PLANID,  CallDate
, CallTime, CategoryoftheCall, CallEndSummary,a.agentuserprofilename,x.ProfileIDFirstname,x.ProfileIDLastname
,@StartDate startDate,@EndDate enddate
from #RS_HF_Audit1 a
inner join elig.BenefitCrossWalk b on (b.insurancehealthplanid= a.healthplanid and b.InsuranceCarrierId = 275 )
left join (
     select userprofileid userprofileid,
	        username      ProfileIDUsername,
	        firstname     ProfileIDfirstname,
			lastname      ProfileIDlastname
			from auth.UserProfiles
			where 1=1 )x on a.agentuserprofilename = x.ProfileIDUsername
where 1 = 1

--and healthplanid is null
--order by MemberNHMemberId
GO

-- The original query--

--select distinct agentuserprofilename from #RS_HF_Audit1 order by 1

-- ('ELIG_MOL','ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')


-- Check the insurance carrier and the data source of the client
select * from elig.clientCodes where ClientName like '%Molina%'
select * from elig.clientcodes where InsuranceCarrierID in (138, 380, 400)

select * from insurance.insuranceCarriers where  InsuranceCarrierID in (138, 380, 400)

select * from elig.clientCodes where dataSource in  ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')

DECLARE @StartDate DATE = '03-01-2022' ;
DECLARE @EndDate DATE = '06-30-2022';
select @StartDate,@EndDate

IF OBJECT_ID('tempdb..#RS_HF_Audit1') IS NOT NULL DROP TABLE #RS_HF_Audit1

select Callbound, callingnumber, z2.FirstName, z2.LastName, MedicareID, CallDate, CallTime, CategoryoftheCall, CallEndSummary, MemberNHMemberId,nhlinkid,agentuserprofilename, 
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
			  and CAST(c.createdate AS DATE) between  @StartDate AND @EndDate
              and exists (select 1 from master.Members m where m.NHMemberID = c.MemberNHMemberId and m.DataSource in ('ELIG_MOL','ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX'))
              and exists (select 1 from jobs.Events e where e.EventId = cp.EventId and EventTriggerBy = 'DISPOSITION')
              and c.AgentUserProfileName not in ('rsareddy','mnanduri','sraghavendran','ZPerlmanCC','awrenn','SDaggubati','skapa','spotiigari', 'sballa')
                           ) z
						inner join master.members z1 on (z.MemberNHMemberId = z1.NHMemberID)
						inner join (
                           select distinct LastName, FirstName,MedicareID,MasterMemberID From elig.mstrEligBenefitData where DataSource in ('ELIG_MOL','ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')
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
where datasource in  ('ELIG_MLNA_MC','ELIG_MLNA_MC_KY','ELIG_MLNA_NV','ELIG_MLNA_MMP','ELIG_MLNA_MMP_CA','ELIG_MLNA_MMP_IL','ELIG_MLNA_MMP_MI','ELIG_MLNA_MMP_OH','ELIG_MLNA_MMP_SC','ELIG_MLNA_MMP_TX')
group by mastermemberid ,nhlinkid) s on (t.mastermemberid = s.mastermemberid)


select MemberNHMemberId,nhlinkid as MemberInsuranceId,Callbound, Callingnumber, a.FirstName, a.LastName
, MedicareID, substring(HealthPlanNumber,1,5) ContractID, substring(HealthPlanNumber,7,3) PLANID,  CallDate
, CallTime, CategoryoftheCall, CallEndSummary,a.agentuserprofilename,x.ProfileIDFirstname,x.ProfileIDLastname
,@StartDate startDate,@EndDate enddate
from #RS_HF_Audit1 a
inner join elig.BenefitCrossWalk b on (b.insurancehealthplanid= a.healthplanid and b.InsuranceCarrierId = 275 )
left join (
     select userprofileid userprofileid,
	        username      ProfileIDUsername,
	        firstname     ProfileIDfirstname,
			lastname      ProfileIDlastname
			from auth.UserProfiles
			where 1=1 )x on a.agentuserprofilename = x.ProfileIDUsername
where 1 = 1

--and healthplanid is null
--order by MemberNHMemberId
GO

