select * from elig.ClientCodes  where ClientName like '%hap%'  
/*
ClientName	DataSource	InsuranceCarrierID
Virginia Premier	ELIG_VPremier	388
Virginia Premier CCC	ELIG_VPremier_CCC	388
Virginia Premier DSNP	ELIG_VPremier_DSNP	388
Virginia Premier MED4	ELIG_VPremier_MED4	388
*/


select * from elig.mstrEligBenefitData 
where 1=1
--where insCarrierID =  388 
and datasource like  '%ELIG_ALGN%'

select * from master.Members where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  388 and datasource like  '%ELIG_VPremier%')
select distinct insuranceCarrierID, insuranceHealthPlanID from master.MemberInsurances where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  388 and datasource like  '%ELIG_VPremier%')
select * from orders.orders where NHmemberID in ( select NHMemberID from master.Members where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  388 and datasource like  '%ELIG_VPremier%'))


select * from master.Members where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  388 and datasource like '%ELIG_ALGN%')
select distinct insuranceCarrierID, insuranceHealthPlanID from master.MemberInsurances where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  302 and datasource like  '%ELIG_ALGN%')
select * from orders.orders where NHmemberID in ( select NHMemberID from master.Members where MemberID in (select MasterMemberID from elig.mstrEligBenefitData where insCarrierID =  302 and datasource like  '%ELIG_ALGN%')) and CreateDate > Getdate() -1



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
and ic.InsuranceCarrierID = 298
--and ihp.InsuranceHealthPlanID in (38)
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
            --  and ic.InsuranceCarrierID in (276)
              --and ic.InsuranceCarrierID =300
              and ic.IsActive = 1
              and ihp.IsActive =1
) b on (a.InsuranceCarrierID = b.InsuranceCarrierID and a.InsuranceHealthPlanID = b.InsuranceHealthPlanID ) --and b.[Benfit Type] = 'HA' )
--where a.InsuranceCarrierID = 358



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

