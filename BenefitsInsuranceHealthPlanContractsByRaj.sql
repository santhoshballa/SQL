------------------------HA -------------------------------------Benefits
------------------------HA -------------------------------------Benefits
------------------------HA -------------------------------------Benefits
------------------------HA -------------------------------------Benefits


select 'Hearing Aid' as BenefitType,  a.Carrier, a.PlanName, a.ContactPBP, b.[Benfit Value], b.[Benfit Type], b.[No of Reset Months], b.[Benfit Source], b.[Wallet Code]
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
              --and ic.InsuranceCarrierID not in (16)
              --and ic.InsuranceCarrierID =281
              and ic.IsActive = 1
              and ihp.IsActive=1 
) b on (a.InsuranceCarrierID = b.InsuranceCarrierID and a.InsuranceHealthPlanID = b.InsuranceHealthPlanID and b.[Benfit Type] = 'HA' )
--where a.InsuranceCarrierID = 358


------------------------OTC -------------------------------------Benefits
------------------------OTC -------------------------------------Benefits
------------------------OTC -------------------------------------Benefits
------------------------OTC -------------------------------------Benefits
------------------------OTC -------------------------------------Benefits


select 'OTC' as BenefitType, a.Carrier, a.PlanName, a.ContactPBP, b.[Benfit Value], b.[Benfit Type], b.[No of Reset Months], b.[Benfit Source], b.[Wallet Code]
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
              --and ic.InsuranceCarrierID not in (16)
              --and ic.InsuranceCarrierID =281
              and ic.IsActive = 1
              and ihp.IsActive=1 
) b on (a.InsuranceCarrierID = b.InsuranceCarrierID and a.InsuranceHealthPlanID = b.InsuranceHealthPlanID and b.[Benfit Type] = 'OTC' )
--where a.InsuranceCarrierID = 358
