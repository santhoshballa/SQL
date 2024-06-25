select *, ClientCode,Datasource,InsuranceCarrierID,InsuranceHealthPlanID,IsCardIssuance,LanguageIndicator FROM [otcfunds].[ClientBenefitRulesData]
where InsuranceCarrierID = 278 and InsuranceHealthPlanID = 3438

drop table  if exists #allOptimaMembersInPlan
select * into #allOptimaMembersInPlan from (
select distinct NHMemberID, NHLinkID from master.Members where NHlinkID in (select NHLInkID from elig.mstrEligBenefitData where InsCarrierID = 278 and InsHealthPlanID = 3438 and IsActive =1and BenefitEndDate > '07-19-2023')
) a

drop table  if exists #allHCQ_opt
select ma.*,q.SubCategory,q.Question,a.Answer,CASE WHEN q.Question = 'Other' then ISNULL(ma.OtherAnswer,q.SubCategory) else q.Question end QuestionswithYES
INTO #allHCQ_opt
from member.MemberAnswers ma
join member.Questions q on q.QuestionId = ma.QuestionId and q.Category = 'OTC_HCQ'
join member.Answers a on a.AnswerId = ma.AnswerId
where 1=1 and ma.NHMemberID in (select distinct NHMemberID from #allOptimaMembersInPlan)

select distinct NHMemberID from #allHCQ_opt

drop table  if exists #allHCQ_YES_opt
SELECT distinct e.NHMemberID,  LEFT(r.QuestionswithYES , LEN(r.QuestionswithYES)-1) QuestionswithYES
INTO #allHCQ_YES_opt
FROM #allHCQ_opt e
CROSS APPLY
(
	SELECT cast(r.QuestionswithYES as varchar(1000)) + '; '
	FROM #allHCQ_opt r
	where e.NHMemberID = r.NHMemberID
      FOR XML PATH('')
) r (QuestionswithYES)

select * from #allHCQ_YES_opt

drop table  if exists #ChangeRequest
select BenefitCardVendor, InsuranceCarrierID, InsuranceHealthPlanId, NHMemberID, IsProcessed, IsActive into #ChangeRequest from benefitcard.ChangeRequest where NHMemberID in (select NHMemberID from #allOptimaMembersInPlan)

select * from #ChangeRequest

select a.*, b.*, c.*
from #allOptimaMembersInPlan a 
left join #allHCQ_YES_opt b on a.NHMemberID = b.NHmemberid
left join #ChangeRequest c on a.NHMemberID = c.NHMemberId
where c.NHMemberID is null



select * from 
