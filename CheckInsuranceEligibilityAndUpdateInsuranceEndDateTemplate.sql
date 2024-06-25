
/*


Execute the above query to check all 3 tables for Insurance Effective Date and Insurance End Date
select 'elig.EligMstrBenefitData' as TableName, IsActive, MemberInsuranceID, insCarrierID, BenefitStartDate as InsuranceEffectiveDate, BenefitEndDate as  InsuranceEndDate, InsHealthPlanID from elig.mstrEligBenefitData 
where NHLinkID = (select NHLinkID from Master.Members where NHMemberID = 'NH202002090166') and IsActive = 1
Union all
select 'Master.MemberInsurances' as TableName, IsActive, ID as MemberInsuranceID, InsuranceCarrierID, InsuranceEffectiveDate, InsuranceEndDate, InsuranceHealthPlanID from master.memberinsurances 
where MemberID = (select MemberID from Master.Members where NHMemberID = 'NH202002090166') and IsActive = 1
Union all
select 'Provider.MemberInsurances' as TableName, IsActive, MemberInsuranceID, InsuranceCarrierID, InsuranceEffectiveDate, InsuranceEndDate, InsuranceHealthPlanID  from provider.MemberInsurances 
where MemberProfileId = ( select MemberProfileId from provider.MemberProfiles where NHMemberId =  'NH202002090166') and IsActive = 1
*/

update mmi
set InsuranceEndDate = (select BenefitEndDate from elig.mstrEligBenefitData where insCarrierID = 277 and InsHealthPlanID = 2513 and MemberInsuranceID = 4659934 and IsActive = 1)
from master.MemberInsurances mmi where mmi.ID = 4659934

update pmi
set InsuranceEndDate = (select BenefitEndDate from elig.mstrEligBenefitData where insCarrierID = 277 and InsHealthPlanID = 2513 and MemberInsuranceID = 4659934 and IsActive = 1)
from provider.MemberInsurances pmi where pmi.MemberInsuranceID = 4659934


