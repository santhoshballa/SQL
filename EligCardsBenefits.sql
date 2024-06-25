
IF OBJECT_ID('tempdb..#MemberCards') IS NOT NULL DROP TABLE #MemberCards
select * into #MemberCards from 
(
select
m.Datasource as DataSource_Member
,e.datasource as DataSource_Elig
,'Member.MemberCards' as TableName_MemberCards
,a.NHMemberID as NHMemberID_MemberCards
,a.InsuranceCarrierID as InsuranceCarrierID
,a.InsuranceHealthPlanID
,a.CardNumber, a.Last4, a.CardReferenceNumber, a.CardVendor, a.IsCardValId, a.IsActive, a.ClientCarrierId

,'Insurance.InsuranceCarrierID' as TableName_InsuranceCarrier
,b.insuranceCarrierID as Insurance_InsuranceCarrierID
,b.InsuranceCarrierName as Insurance_InsuranceCarrierName

 ,'Insurance.InsuranceHealthPlan' as TableName_INsuranceHealthPlan
,c.InsuranceHealthPlanID as HealthPlan_InsuranceHealthPlanID
,c.HealthPlanName as HealthPlan_HealthPlanName

,m.MemberID, m.NHMemberID, m.FirstName, m.LastName
,e.BenefitStartDate, e.BenefitEndDate, e.SubscriberID, e.NHLinkID, e.MasterMemberID


from 
Member.MemberCards a 
join insurance.InsuranceCarriers b on a.InsuranceCarrierID = b.InsuranceCarrierID
join insurance.InsuranceHealthPlans c on a.InsuranceHealthPlanID = c.InsuranceHealthPlanID
left join master.members m on a.NHMemberID = m.NHMemberID
left join elig.mstrEligBenefitData e on (m.NHlinkID = e.NHLinkID and e.isActive =1)


--filters
where 1=1 and
getdate() between  e.BenefitStartDate and  e.BenefitEndDate
--and a.InsuranceCarrierID = 258
--and b.InsuranceCarrierName like '%NationsOTC%Program%'
--and a.InsuranceHealthPlanID = 2433
--and c.HealthPlanName like '%Medicare%'
--and a.IsActive = 1
--and a.NHMemberID = 'NH202002457094'
) a



--select * from #MemberCards order by Datasource_Member, CardNumber
-- select distinct datasource_Member, datasource_Elig from #MemberCards


IF OBJECT_ID('tempdb..#Benefits') IS NOT NULL DROP TABLE #Benefits
select * into #Benefits from (

select a.Carrier, a.PlanName, a.ContactPBP, b.[Benfit Value], b.[Benfit Type], b.[No of Reset Months], b.[Benfit Source], b.[Wallet Code]
              ,b.[Benfit Cat]
              ,b.[Member Copay]
, b.[Benfit Reset], b.[FREQ TYPE], b.BenfitFORTYPE, b.BenefitRuleData
,b.[Contract Effective From], b.[Contract Effective To]
, b.[Contract Rule Effective From], b.[Contract Rule Effective To],
a.InsuranceHealthPlanID
,b.HealthPlanContractID
              ,b.ContractRuleId
              ,b.BenefitRuleDataId
              ,a.InsuranceCarrierID
from (
select ic.InsuranceCarrierName  Carrier
,ihp.HealthPlanName PlanName
,ihp.HealthPlanNumber ContactPBP
,ihp.InsuranceHealthPlanID
,ic.InsuranceCarrierID
From insurance.InsuranceCarriers ic
inner join insurance.InsuranceHealthPlans ihp on (ic.InsuranceCarrierID = ihp.InsuranceCarrierID)
where ic.IsActive = 1
and ihp.IsActive = 1
--and ic.InsuranceCarrierID = 62
--and ihp.InsuranceHealthPlanID in (532)
) a
left outer join (
              select
              ic.InsuranceCarrierName  Carrier
              ,ihp.HealthPlanName PlanName
              ,ihp.HealthPlanNumber ContactPBP
              ,JSON_VALUE(BenefitRuleData, '$.BENCAT')        [Benfit Cat]
              ,JSON_VALUE(BenefitRuleData, '$.BENCATVALUE')    [Benfit Value]
              ,JSON_VALUE(BenefitRuleData, '$.BENTYPE')        [Benfit Type]
              ,JSON_VALUE(BenefitRuleData, '$.BENBEHV')        [Benfit Reset]
              ,JSON_VALUE(BenefitRuleData, '$.BENFREQMONTHS') [No of Reset Months]
              ,JSON_VALUE(BenefitRuleData, '$.BENFREQTYPE')    [FREQ TYPE]
              ,JSON_VALUE(BenefitRuleData, '$.BENFORTYPE')     [BenfitFORTYPE]
              ,JSON_VALUE(BenefitRuleData, '$.BENVALUESRC')    [Benfit Source]
              ,JSON_VALUE(BenefitRuleData, '$.WALCODE')        [Wallet Code]
              ,JSON_VALUE(BenefitRuleData, '$.APPLYMEMBERCOPAY')        [Member Copay]
              ,cast(hpc.EffectiveFromDate as date) as [Contract Effective From]
              ,cast(hpc.EffectiveToDate as date) as [Contract Effective To]
              ,cast(cr.EffectiveFrom as date) as [Contract Rule Effective From]
              ,cast(cr.EffectiveTo as date) as [Contract Rule Effective To]
              ,br.BenefitRuleData
              ,ihp.InsuranceHealthPlanID
              ,ihp.IsActive
              ,hpc.HealthPlanContractID
              ,cr.ContractRuleId
              ,cr.BenefitRuleDataId
              ,ihp.InsuranceCarrierID
            
              From insurance.InsuranceCarriers ic
              inner join insurance.InsuranceHealthPlans ihp on (ic.InsuranceCarrierID = ihp.InsuranceCarrierID)
              left outer join insurance.HealthPlanContracts hpc on (ihp.InsuranceHealthPlanID = hpc.InsuranceHealthPlanID and hpc.IsActive = 1 and cast(getdate() as date) between cast(hpc.EffectiveFromDate as date) and cast(hpc.EffectiveToDate as date))
              left outer join insurance.ContractRules cr on (cr.HealthPlanContractId = hpc.HealthPlanContractId and cr.IsActive=1 and cast(getdate() as date) between cast(cr.EffectiveFrom as date) and cast(cr.EffectiveTo as date))
              left outer join rulesengine.BenefitRulesData br on (cr.BenefitRuleDataId = br.BenefitRuleDataId and br.IsActive = 1) --and br.BenefitRuleId = 2)
              where 1=1
              --and ic.InsuranceCarrierID in (62)
              --and ic.InsuranceCarrierID = 532
              and ic.IsActive = 1
              and ihp.IsActive =1
) b on (a.InsuranceCarrierID = b.InsuranceCarrierID and a.InsuranceHealthPlanID = b.InsuranceHealthPlanID ) --and b.[Benfit Type] = 'HA' )
--where a.InsuranceCarrierID = 358
) a

--select * from #Benefits where [Benfit Value] is not null

select a.*, b.* from #MemberCards a left join #Benefits b on (a.InsuranceCarrierID = b.InsuranceCarrierID and a.InsuranceHealthPlanID = b.InsuranceHealthPlanID)
where NHMemberID_MemberCards = 'NH202002797080 ' and IsActive =1

select * from #MemberCards where NHMemberID_MemberCards = 'NH202002797080 ' and IsActive =1

select * from elig.mstrEligBenefitData where MasterMemberID in ( select MemberID from master.members where NHMemberID in ('NH202002797080 ') and IsActive =1) and IsActive =1

select *, ContractRuleId, BenefitRuleDataId from insurance.ContractRules 

/*
select top 10 * from insurance.HealthPlanContracts
select top 10 * from insurance.ContractRules
select top 10 * from rulesengine.BenefitRulesData

select * from insurance.HealthPlanContracts
select * from insurance.ContractRules
*/

select *
,JSON_VALUE(BenefitRuleData, '$.BENCAT')        [Benfit Cat]
,JSON_VALUE(BenefitRuleData, '$.BENCATVALUE')    [Benfit Value]
,JSON_VALUE(BenefitRuleData, '$.BENTYPE')        [Benfit Type]
,JSON_VALUE(BenefitRuleData, '$.BENBEHV')        [Benfit Reset]
,JSON_VALUE(BenefitRuleData, '$.BENFREQMONTHS') [No of Reset Months]
,JSON_VALUE(BenefitRuleData, '$.BENFREQTYPE')    [FREQ TYPE]
,JSON_VALUE(BenefitRuleData, '$.BENFORTYPE')     [BenfitFORTYPE]
,JSON_VALUE(BenefitRuleData, '$.BENVALUESRC')    [Benfit Source]
,JSON_VALUE(BenefitRuleData, '$.WALCODE')        [Wallet Code]
,JSON_VALUE(BenefitRuleData, '$.APPLYMEMBERCOPAY')        [Member Copay]
from rulesengine.BenefitRulesData


-- All Contracts, Insurance, HealthPlans that are Actives
select  distinct 

 'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*, 'rulesengine.BenefitRulesData' as TableName_BenefitRulesData,c.*

,JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
where 1=1 and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1

