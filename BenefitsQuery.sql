select InsuranceCarrierID, * from insurance.InsuranceCarriers where InsuranceCarrierName like '%Capital Blue Cross%' 
select * from Insurance.InsuranceHealthPlans where insuranceCarrierID in (271) and HealthPlanName like '%PPO EGWP%'  -- HealthPlanName | 2529

select 
ic.InsuranceCarrierName,
hp.HealthPlanName, hp.HealthPlanNumber,
cw.ContractNbr,cw.GroupNbr,cw.ProductID,cw.PBPID,cw.LOB,cw.PlanName,cw.HealthPlanNumber,cw.InsuranceCarrierId,cw.InsuranceHealthPlanId
--,hpc.*
--,cr.*
,BenefitRuleData
,JSON_VALUE(brd.BenefitRuleData,'$.BENCAT') BenefitCategory
,JSON_VALUE(brd.BenefitRuleData,'$.BENCATVALUE') BenefitCategoryValue
,JSON_VALUE(brd.BenefitRuleData,'$.BENTYPE') BenefitType
,JSON_VALUE(brd.BenefitRuleData,'$.BENBEHV') BenefitBehaviour
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQMONTHS') BenefitFrequencyMonths
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQTYPE') BenefitFrequencyType
,JSON_VALUE(brd.BenefitRuleData,'$.BENFORTYPE') BENFORTYPE
,JSON_VALUE(brd.BenefitRuleData,'$.BENVALUESRC') BenefitValueSource
from elig.BenefitCrossWalk cw
left join Insurance.InsuranceHealthPlans hp on hp.insurancehealthplanid = cw.InsuranceHealthPlanId
left join Insurance.InsuranceCarriers ic on ic.insurancecarrierid = cw.InsuranceCarrierId
left join Insurance.HealthPlanContracts hpc on (hpc.insurancehealthplanid = cw.InsuranceHealthPlanId and hpc.IsActive = 1)
left join Insurance.ContractRules cr on (cr.healthplancontractid = hpc.healthplancontractid and cr.IsActive = 1)
left join rulesengine.BenefitRulesData brd on (cr.BenefitRuleDataId = brd.BenefitRuleDataId and brd.IsActive = 1)
where 1=1
and cw.InsuranceCarrierID in (select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName like '%Capital Blue Cross%'  )
--and cw.InsuranceCarrierId <> 0
order by cw.InsuranceCarrierId, cw.InsuranceHealthPlanId


select 
ic.InsuranceCarrierName,
hp.HealthPlanName, hp.HealthPlanNumber,
cw.ContractNbr,cw.GroupNbr,cw.ProductID,cw.PBPID,cw.LOB,cw.PlanName,cw.HealthPlanNumber,cw.InsuranceCarrierId,cw.InsuranceHealthPlanId
--,hpc.*
--,cr.*
,BenefitRuleData
,JSON_VALUE(brd.BenefitRuleData,'$.BENCAT') BenefitCategory
,JSON_VALUE(brd.BenefitRuleData,'$.BENCATVALUE') BenefitCategoryValue
,JSON_VALUE(brd.BenefitRuleData,'$.BENTYPE') BenefitType
,JSON_VALUE(brd.BenefitRuleData,'$.BENBEHV') BenefitBehaviour
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQMONTHS') BenefitFrequencyMonths
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQTYPE') BenefitFrequencyType
,JSON_VALUE(brd.BenefitRuleData,'$.BENFORTYPE') BENFORTYPE
,JSON_VALUE(brd.BenefitRuleData,'$.BENVALUESRC') BenefitValueSource
from elig.BenefitCrossWalk cw
left join Insurance.InsuranceHealthPlans hp on hp.insurancehealthplanid = cw.InsuranceHealthPlanId
left join Insurance.InsuranceCarriers ic on ic.insurancecarrierid = cw.InsuranceCarrierId
left join Insurance.HealthPlanContracts hpc on (hpc.insurancehealthplanid = cw.InsuranceHealthPlanId and hpc.IsActive = 1)
left join Insurance.ContractRules cr on (cr.healthplancontractid = hpc.healthplancontractid and cr.IsActive = 1)
left join rulesengine.BenefitRulesData brd on (cr.BenefitRuleDataId = brd.BenefitRuleDataId and brd.IsActive = 1)
where 1=1
and cw.InsuranceCarrierID in (select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName like '%Capital Blue Cross%'  )
and ic.insurancecarrierid = 271
and hp.InsuranceHealthPlanID = 2529
--and cw.InsuranceCarrierId <> 0
order by cw.InsuranceCarrierId, cw.InsuranceHealthPlanId




select 
ic.InsuranceCarrierName,
hp.HealthPlanName, hp.HealthPlanNumber,
cw.ContractNbr,cw.GroupNbr,cw.ProductID,cw.PBPID,cw.LOB,cw.PlanName,cw.HealthPlanNumber,cw.InsuranceCarrierId,cw.InsuranceHealthPlanId
--,hpc.*
--,cr.*
,BenefitRuleData
,JSON_VALUE(brd.BenefitRuleData,'$.BENCAT') BenefitCategory
,JSON_VALUE(brd.BenefitRuleData,'$.BENCATVALUE') BenefitCategoryValue
,JSON_VALUE(brd.BenefitRuleData,'$.BENTYPE') BenefitType
,JSON_VALUE(brd.BenefitRuleData,'$.BENBEHV') BenefitBehaviour
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQMONTHS') BenefitFrequencyMonths
,JSON_VALUE(brd.BenefitRuleData,'$.BENFREQTYPE') BenefitFrequencyType
,JSON_VALUE(brd.BenefitRuleData,'$.BENFORTYPE') BENFORTYPE
,JSON_VALUE(brd.BenefitRuleData,'$.BENVALUESRC') BenefitValueSource
from elig.BenefitCrossWalk cw
left join Insurance.InsuranceHealthPlans hp on hp.insurancehealthplanid = cw.InsuranceHealthPlanId
left join Insurance.InsuranceCarriers ic on ic.insurancecarrierid = cw.InsuranceCarrierId
left join Insurance.HealthPlanContracts hpc on (hpc.insurancehealthplanid = cw.InsuranceHealthPlanId ) --and hpc.IsActive = 1
left join Insurance.ContractRules cr on (cr.healthplancontractid = hpc.healthplancontractid ) --and cr.IsActive = 1
left join rulesengine.BenefitRulesData brd on (cr.BenefitRuleDataId = brd.BenefitRuleDataId) --  and brd.IsActive = 1
where 1=1
and cw.InsuranceCarrierID in (select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName like '%Capital Blue Cross%'  )
and ic.insurancecarrierid = 271
and hp.InsuranceHealthPlanID = 2529
--and cw.InsuranceCarrierId <> 0
order by cw.InsuranceCarrierId, cw.InsuranceHealthPlanId


select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Capital Blue Cross%' 




select * from elig.BenefitCrossWalk cw
select * from Insurance.InsuranceHealthPlans hp on hp.insurancehealthplanid = cw.InsuranceHealthPlanId
select * from Insurance.InsuranceCarriers ic on ic.insurancecarrierid = cw.InsuranceCarrierId
select * from Insurance.HealthPlanContracts hpc on (hpc.insurancehealthplanid = cw.InsuranceHealthPlanId and hpc.IsActive = 1)
select * from Insurance.ContractRules cr on (cr.healthplancontractid = hpc.healthplancontractid and cr.IsActive = 1)
select * from rulesengine.BenefitRulesData brd on (cr.BenefitRuleDataId = brd.BenefitRuleDataId and brd.IsActive = 1)


-- Check BenefitCrossWalk to see if the plan is active, Insurance Carrier, Insurance Health Plan, Health Plan Contracts, Contract Rules and Benefit Rules Data
declare @InsuranceCarrierID int = 271
declare @InsuranceHealthPlanID int = 2529
select '[elig.BenefitCrossWalk]' as TableName,IsActive,* from elig.BenefitCrossWalk cw where InsuranceCarrierID = @InsuranceCarrierID and InsuranceHealthPlanId = @InsuranceHealthPlanID 
--and IsActive = 1 
select '[Insurance.InsuranceHealthPlans]' as TableName,IsActive,* from Insurance.InsuranceHealthPlans hp where InsuranceHealthPlanID = @InsuranceHealthPlanID 
--and IsActive = 1 
select '[Insurance.InsuranceCarriers]' as TableName,IsActive,* from Insurance.InsuranceCarriers ic where InsuranceCarrierID = @InsuranceCarrierID 
--and IsActive = 1 
select '[Insurance.HealthPlanContracts]' as TableName,IsActive,* from Insurance.HealthPlanContracts hpc where InsuranceHealthPlanID = @InsuranceHealthPlanID 
--and IsActive = 1 
select '[Insurance.ContractRules]' as TableName,IsActive,* from Insurance.ContractRules cr 
where HealthPlanContractId in (select HealthPlanContractID from Insurance.HealthPlanContracts hpc where InsuranceHealthPlanID = @InsuranceHealthPlanID ) 
--and IsActive = 1 

select '[rulesengine.BenefitRulesData]' as TableName,IsActive,* from rulesengine.BenefitRulesData brd 
where BenefitRuleDataId in (select BenefitRuleDataId from Insurance.ContractRules 
							where HealthPlanContractId in (select HealthPlanContractID from Insurance.HealthPlanContracts hpc 
															where InsuranceHealthPlanID = @InsuranceHealthPlanID 
															)
							)
--and IsActive = 1

/*
Ticket # 44036
declare @InsuranceCarrierID int = 271
declare @InsuranceHealthPlanID int = 2529

--select * from Insurance.ContractRules where ContractRuleID = 487

update Insurance.ContractRules set IsActive = 1 where ContractRuleID = 487
*/