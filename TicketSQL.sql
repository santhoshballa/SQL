select 'otcfunds.CardBenefitLoad' as TableName, * from otcfunds.CardBenefitLoad where NHLinkid in (select NHLinkID from master.Members where NHMemberID in (NHMemberID in ( select NHmemberID from #NHMemberIDTemp))
select * from master.members where NHMemberID = 'NH202005953463'
select * from elig.mstrEligBenefitData where NHLinkID = 'MEBTTWLT'
select * from elig.CarrierNameforSearch where carrierName like '%Emblem%'
select * from elig.mstrEligBenefitData where insCarrierID = 298 and FirstName = '%joseph%'
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 298 and HealthPlanName like '%dual%'



select * from otcfunds.CardBenefitLoad where InsCarrierID = 302 and InsHealthPlanID = 4197 and benefitAmount is not null and Lastname like '%JUDITH%' and FirstName like '%BASHIN%'


and NBWalletCode = 'AL01FIS22'

select * from elig.mstrEligBenefitData where insCarrierID = 302 and insHealthPlanID = 4197 and SSBCI = 'YES' and NHLinkID = '00000198413'
select NHMemberID, * from master.members where NhLinkID = '00000198413'


select * from master.members where firstName like '%Shapiro%' and LastName like '%Burton%' 
union 
select * from master.members where firstName like '%Burton%' and LastName like '%Shapiro%' 

select * from elig.errEligBenefitData where firstName like '%Shapiro%' and LastName like '%Burton%' 
union 
select * from elig.errEligBenefitData where firstName like '%Burton%' and LastName like '%Shapiro%' 

select * from elig.mstreligbenefitdata where firstName like '%Shapiro%' and LastName like '%Burton%' 
union 
select * from elig.mstreligbenefitdata where firstName like '%Burton%' and LastName like '%Shapiro%' 

select * from provider.MemberProfiles where firstName like '%Shapiro%' and LastName like '%Burton%' 
union 
select * from provider.MemberProfiles where firstName like '%Burton%' and LastName like '%Shapiro%' 



-- and middleInitial = 'A' 
select * from master.members where  NHlinkid like '%820399186%'


Shapiro, Burton



select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar)))' + ' like '+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('elig')
and TABLE_NAME in ('mstreligbenefitdata', 'errEligBenefitData')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and Column_name in ('SubscriberID', 'GroupNBR', 'SubGroupNbr', 'FamilyLinkID', 'AlternateID', 'MedicaidID', 'MedicareID', 'ClientMemberNumber', 'ContractNbr', 'PBPID', 'ProductID', 'MedicarePlanCode', 'COBCarrierName', 'NHLinkid', 'BenefitCardNumber')
order by table_schema, table_name

declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '%0000008616%'
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'AlternateID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AlternateID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([AlternateID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ClientMemberNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBCarrierName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBCarrierName] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBCarrierName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ContractNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ContractNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'FamilyLinkID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyLinkID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([FamilyLinkID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'GroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([GroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicaidID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicaidID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicaidID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicareID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicareID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicarePlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PBPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PBPID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ProductID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ProductID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SubGroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubGroupNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SubGroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SubscriberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SubscriberID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'AlternateID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AlternateID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([AlternateID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitCardNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitCardNumber] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitCardNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ClientMemberNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBCarrierName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBCarrierName] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBCarrierName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ContractNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ContractNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'FamilyLinkID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyLinkID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([FamilyLinkID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'GroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([GroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicaidID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicaidID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicaidID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicareID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicareID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicarePlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'NHLinkid|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHLinkid] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([NHLinkid] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PBPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PBPID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ProductID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ProductID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SubGroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubGroupNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SubGroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SubscriberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SubscriberID] as nvarchar))) like @SearchPredicate) a	



select top 10 * from otcfunds.CardBenefitLoad

select distinct
b.insuranceCarrierName,
c.HealthPlanName,
a.insCarrierID, 
a.InsHealthPlanID, 
a.BenefitType, a.BenefitSource,a.NBWalletCode, a.BenefitAmount
from otcfunds.CardBenefitLoad a 
left join insurance.insuranceCarriers b on a.InsCarrierID = b.InsuranceCarrierID
left join insurance.InsuranceHealthPlans c on a.InsHealthPlanID = c.InsuranceHealthPlanID
where BenefitAmount is not null  and ResponseRecordStatus = 'SUCCESS' and InsuranceCarrierName like '%Capital%'

order by insCarrierID





 --a.ResponseRecordStatus, a.FirstTimeCardIssued,  a.RequestRecordStatus, 
--FirstTimeCardIssued = 'Y' and 



select * from master.members where firstName like 'JOYCE' and LastName like 'Fleming' and middleInitial = 'A' and NHlinkid like '%820399186%00%'
select * from master.members where  NHlinkid like '%820399186%'

select * from elig.clientcodes where clientname like '%m%v%p%' or clientName like 'MVP'
select * from elig.mstrEligBenefitData where datasource like 'ELIG_MVP' and NHLinkID like '%820399186%'

select * from elig.errEligBenefitData
select top 10 * from elig.errEligBenefitData where subscriberID like '%82039918600%'
--select * from elig.errEligBenefitData where LastName ='Wachob' and FirstName ='Paul'
select * from elig.mstrEligBenefitData where LastName ='Wachob' and FirstName ='Margaret'
select * from elig.mstrEligBenefitData where LastName ='Wachob' and FirstName ='Paul'
select * from information_schema.columns where column_name like '%SSBCI%'
select top 10 * from otc.MemberEligibility
select count(*) from otc.MemberEligibility where NHMemberID is not null
select distinct insuranceCarrierID, INsuranceHealthPlanID from otc.MemberEligibility

select top 10 NHMemberID, adminAlias,employeeNumber, EmployerCode, planYearName, PlanYearStartDate, planName, InsuranceCarrierId, InsuranceHealthPlanID from otc.MemberEligibility where NHMemberID in ('NH202106701948')


curl -X POST "https://externalserviceotc.azurewebsites.net/api/OTC/WEX/GetBalance" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d 
"{\"administratorAlias\":\"HFP\",\"consumerIdentifier\":\"810511321\",\"employerCode\":\"220009\",\"planYearName\":\"2021 OTC Q1\",\"planYearStartDate\":\"2021-01-01\",\"planName\":\"OTC\"}"


select distinct NhMemberID,

'curl -X POST '+ '"'+ 
'https://externalserviceotc.azurewebsites.net/api/OTC/WEX/GetBalance' + '"'+ ' -H ' + '"' + 'accept: application/json'+ '"'+ ' -H ' +'"' + 'Content-Type: application/json-patch+json' + '"' + ' -d ' + '"'+
'{\"administratorAlias\":\"'+cast(adminalias as nvarchar)+ '\",\"consumerIdentifier\":\"'+cast(employeeNumber as nvarchar)+'\",\"employerCode\":\"'+cast(EmployerCode as nvarchar)+'\",\"planYearName\":\"'+cast(planYearName as nvarchar)+'\",\"planYearStartDate\":\"'+cast(PlanYearStartDate as nvarchar)+'\",\"planName\":\"'+ cast(planName as nvarchar) +'\"}"'

as WEX_CurlURL
from otc.MemberEligibility where 1=1 
and cast(getdate() as date) between PlanYearStartDate and PlanYearEndDate 
and (NHMemberID in ('NH202106776464') or NHMemberID is null)



IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202107180953')  -- ticket #  56867

select distinct NhMemberID,

'curl -X POST '+ '"'+ 
'https://externalserviceotc.azurewebsites.net/api/OTC/WEX/GetBalance' + '"'+ ' -H ' + '"' + 'accept: application/json'+ '"'+ ' -H ' +'"' + 'Content-Type: application/json-patch+json' + '"' + ' -d ' + '"'+
'{\"administratorAlias\":\"'+cast(adminalias as nvarchar)+ '\",\"consumerIdentifier\":\"'+cast(employeeNumber as nvarchar)+'\",\"employerCode\":\"'+cast(EmployerCode as nvarchar)+'\",\"planYearName\":\"'+cast(planYearName as nvarchar)+'\",\"planYearStartDate\":\"'+cast(PlanYearStartDate as nvarchar)+'\",\"planName\":\"'+ cast(planName as nvarchar) +'\"}"'

as WEX_CurlURL
from otc.MemberEligibility where 1=1 
and cast(getdate() as date) between PlanYearStartDate and PlanYearEndDate 
and NHMemberID in (select NHmemberid from #NHmemberIDTemp ) 
and InsuranceCarrierId in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and 
( 
InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
or InsuranceHealthPlanID is null
)


select distinct insuranceCarrierid, insuranceCarrierID, insuranceHealthPlanID from  otc.MemberEligibility
select distinct insuranceCarrierID from  otc.MemberEligibility

NULL
74
96
360
362
380
385

select distinct 'WexQuery | CurrentPlanYearOnly' as Query, 'otc.MemberEligibility' as TableName,  isnull(NHMemberID, 'Member Not Found') as NHMemberID, 
isnull(cast(insuranceCarrierID as nvarchar), 'Not Found') as InsuranceCarrierID,  isnull((select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = me.[InsuranceCarrierID] ), 'Not Found') as InsuranceCarrierName ,
isnull(cast(insuranceHealthPlanID as nvarchar),'Not Found') as InsuranceHealthPlanID, isnull((select HealthPlanName from [Insurance].[InsuranceHealthPlans] ihp where ihp.InsuranceHealthPlanID = me.InsuranceHealthPlanID ), 'Not Found') as InsuranceHealthPlanID, 
PlanYearStartDate, PlanYearEndDate from otc.MemberEligibility me where getdate() between PlanYearStartDate and PlanYearEndDate



select distinct adminalias from otc.MemberEligibility

--curl -X POST "https://externalserviceotc.azurewebsites.net/api/OTC/WEX/GetBalance" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d "{\"administratorAlias\":\"HFP\",\"consumerIdentifier\":\"810511321\",\"employerCode\":\"220009\",\"planYearName\":\"2021 OTC Q1\",\"planYearStartDate\":\"2021-01-01\",\"planName\":\"OTC\"}"


select 
'curl '+ '"'+
'https://nbotc-prod-centus-fis-api-app.azurewebsites.net/GetCardAccountDetails/'+CardReferenceNumber+'?carrierId='+Cast(InsuranceCarrierID as Varchar)+'&healthPlanId='+cast(InsuranceHealthPlanID as varchar) +'"'
from Member.MemberCards
where 
InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and CardVendor ='fis' and IsActive = 1 
and NHMemberID in (select NHmemberid from #NHmemberIDTemp )





--declare @SearchPredicate nvarchar(50)
--set @SearchPredicate = '%820399186%'

select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar)))' + ' like '+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('elig')
and TABLE_NAME in ('mstreligbenefitdata', 'errEligBenefitData')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and Column_name in ('SubscriberID', 'GroupNBR', 'SubGroupNbr', 'FamilyLinkID', 'AlternateID', 'MedicaidID', 'MedicareID', 'ClientMemberNumber', 'ContractNbr', 'PBPID', 'ProductID', 'MedicarePlanCode', 'COBCarrierName', 'NHLinkid', 'BenefitCardNumber')
order by table_schema, table_name


declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '%820399186%'
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'errEligID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([errEligID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([errEligID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'FileTrackID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileTrackID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([FileTrackID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DataSource|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DataSource] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'RecordStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordStatus] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([RecordStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'LastName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([LastName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MiddleInitial|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MiddleInitial] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MiddleInitial] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'FirstName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([FirstName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DOB|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DOB] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DOB] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SSN|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SSN] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SSN] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SubscriberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SubscriberID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MemberSuffix|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberSuffix] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MemberSuffix] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'GroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([GroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'BenefitStartDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitStartDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([BenefitStartDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'BenefitEndDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitEndDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([BenefitEndDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SubGroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubGroupNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SubGroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'FamilyLinkID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyLinkID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([FamilyLinkID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'AlternateID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AlternateID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([AlternateID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicaidID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicaidID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicaidID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicareID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicareID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ClientMemberNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ContractNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ContractNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PBPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PBPID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ProductID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductID] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ProductID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'BenefitLevel|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitLevel] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([BenefitLevel] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Language|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Language] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Gender|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Gender] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Gender] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'HomePhoneNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HomePhoneNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([HomePhoneNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherPhoneNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherPhoneNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherPhoneNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MemberEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberEmail] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MemberEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Address1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Address2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([City] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([State] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'ZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ZipCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([ZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MailingAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingAddress1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MailingAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MailingAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingAddress2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MailingAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MailingCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingCity] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MailingCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MailingState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingState] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MailingState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MailingZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingZipCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MailingZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddress1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddress2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherCity] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherState] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherZipCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'OtherAddressType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddressType] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([OtherAddressType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SubscriberIndFlag|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberIndFlag] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SubscriberIndFlag] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'RelationShipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RelationShipCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([RelationShipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MaintenanceType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceType] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MaintenanceType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MaintenanceReason|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceReason] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MaintenanceReason] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'BenefitStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitStatus] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([BenefitStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicarePlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'EligReasonCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligReasonCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([EligReasonCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBRAEvent|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBRAEvent] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBRAEvent] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'EmploymentStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmploymentStatusCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([EmploymentStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'StudentStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StudentStatusCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([StudentStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'HandicapInd|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HandicapInd] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([HandicapInd] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DisabilityType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisabilityType] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DisabilityType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicalCodeQualifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicalCodeQualifier] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicalCodeQualifier] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MedicalCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicalCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MedicalCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'MaintenanceCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([MaintenanceCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'InsuranceLineCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceLineCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([InsuranceLineCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'CoverageLevel|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoverageLevel] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([CoverageLevel] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'LateEnrollment|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LateEnrollment] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([LateEnrollment] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'CoInsurance|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoInsurance] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([CoInsurance] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'CoPayment|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoPayment] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([CoPayment] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Deductible|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Deductible] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Deductible] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'Premium|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Premium] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([Premium] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'SpendDown|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpendDown] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([SpendDown] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'LineNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LineNbr] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([LineNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPName] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPNPI|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPNPI] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPNPI] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPEffDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPEffDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPEffDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPTermDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPTermDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPTermDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPAddress1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPAddress2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPCity] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPState] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPZipCode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'PCPBusinessPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPBusinessPhone] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([PCPBusinessPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBFlag|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBFlag] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBFlag] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBCarrierName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBCarrierName] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBCarrierName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBPolicyNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBPolicyNumber] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBPolicyNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBGroup|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBGroup] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBGroup] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBBegin|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBBegin] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBBegin] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBEnd|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBEnd] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBEnd] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBRespcode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBRespcode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBRespcode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBcode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBcode] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBcode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'COBServiceType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBServiceType] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([COBServiceType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'BusinessCategory|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BusinessCategory] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([BusinessCategory] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'LineOfBusiness|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LineOfBusiness] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([LineOfBusiness] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'EligibilityStartDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligibilityStartDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([EligibilityStartDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'EligibilityEndDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligibilityEndDate] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([EligibilityEndDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'IsMailingAddressForeign|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMailingAddressForeign] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([IsMailingAddressForeign] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'IsMemberAddressForeign|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMemberAddressForeign] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([IsMemberAddressForeign] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex1Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex1Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex1Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex2Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex2Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex2Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex3Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex3Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex3Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex3] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex3] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex4Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex4Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex4Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex4|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex4] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex4] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex5Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex5Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex5Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex5|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex5] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex5] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex6Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex6Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex6Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex6|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex6] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex6] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex7Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex7Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex7Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex7|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex7] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex7] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex8Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex8Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex8Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex8|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex8] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex8] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex9Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex9Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex9Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex9|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex9] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex9] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex10Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex10Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex10Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'VCFlex10|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex10] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([VCFlex10] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex1Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex1Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex1Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex1] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex2Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex2Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex2Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex2] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex3Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex3Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex3Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex3] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex3] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex4Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex4Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex4Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex4|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex4] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex4] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex5Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex5Label] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex5Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'errEligBenefitData|' as TABLE_NAME,'DTFlex5|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex5] as nvarchar))),'"') as VALUE from elig.[errEligBenefitData] where ltrim(rtrim(cast([DTFlex5] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'mstrEligID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([mstrEligID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([mstrEligID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'FileTrackId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileTrackId] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([FileTrackId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'FileID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([FileID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DataSource|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DataSource] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'RecordStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordStatus] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([RecordStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'toBeProcessed|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([toBeProcessed] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([toBeProcessed] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'NHLinkid|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHLinkid] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([NHLinkid] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MasterMemberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MasterMemberID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MasterMemberID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MemberInsuranceID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberInsuranceID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MemberInsuranceID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'insCarrierID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([insCarrierID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([insCarrierID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'insHealthPlanID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([insHealthPlanID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([insHealthPlanID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'RecordEffDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordEffDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([RecordEffDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'RecordEndDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordEndDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([RecordEndDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'isActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([isActive] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([isActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'LastName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([LastName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MiddleInitial|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MiddleInitial] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MiddleInitial] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'FirstName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([FirstName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DOB|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DOB] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DOB] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SSN|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SSN] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SSN] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SubscriberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SubscriberID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MemberSuffix|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberSuffix] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MemberSuffix] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'GroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([GroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitStartDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitStartDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitStartDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitEndDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitEndDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitEndDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SubGroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubGroupNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SubGroupNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'FamilyLinkID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyLinkID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([FamilyLinkID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'AlternateID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AlternateID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([AlternateID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicaidID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicaidID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicaidID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicareID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicareID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ClientMemberNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ClientMemberNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ContractNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ContractNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PBPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PBPID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ProductID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductID] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ProductID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitLevel|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitLevel] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitLevel] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Language|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Language] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Gender|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Gender] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Gender] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'HomePhoneNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HomePhoneNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([HomePhoneNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherPhoneNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherPhoneNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherPhoneNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MemberEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberEmail] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MemberEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Address1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Address2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([City] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([State] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'ZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ZipCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([ZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MailingAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingAddress1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MailingAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MailingAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingAddress2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MailingAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MailingCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingCity] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MailingCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MailingState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingState] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MailingState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MailingZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailingZipCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MailingZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddress1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddress2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherCity] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherState] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherZipCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'OtherAddressType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherAddressType] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([OtherAddressType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SubscriberIndFlag|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberIndFlag] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SubscriberIndFlag] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'RelationShipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RelationShipCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([RelationShipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MaintenanceType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceType] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MaintenanceType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MaintenanceReason|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceReason] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MaintenanceReason] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitStatus] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicarePlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicarePlanCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'EligReasonCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligReasonCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([EligReasonCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBRAEvent|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBRAEvent] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBRAEvent] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'EmploymentStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmploymentStatusCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([EmploymentStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'StudentStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StudentStatusCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([StudentStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'HandicapInd|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HandicapInd] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([HandicapInd] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DisabilityType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisabilityType] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DisabilityType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicalCodeQualifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicalCodeQualifier] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicalCodeQualifier] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MedicalCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicalCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MedicalCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'MaintenanceCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaintenanceCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([MaintenanceCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'InsuranceLineCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceLineCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([InsuranceLineCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'CoverageLevel|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoverageLevel] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([CoverageLevel] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'LateEnrollment|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LateEnrollment] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([LateEnrollment] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'CoInsurance|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoInsurance] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([CoInsurance] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'CoPayment|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CoPayment] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([CoPayment] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Deductible|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Deductible] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Deductible] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'Premium|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Premium] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([Premium] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SpendDown|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpendDown] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SpendDown] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'LineNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LineNbr] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([LineNbr] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPName] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPNPI|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPNPI] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPNPI] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPEffDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPEffDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPEffDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPTermDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPTermDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPTermDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPAddress1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPAddress1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPAddress1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPAddress2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPAddress2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPCity] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPCity] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPState] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPState] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPZipCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPZipCode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPZipCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'PCPBusinessPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PCPBusinessPhone] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([PCPBusinessPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBFlag|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBFlag] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBFlag] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBCarrierName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBCarrierName] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBCarrierName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBPolicyNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBPolicyNumber] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBPolicyNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBGroup|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBGroup] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBGroup] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBBegin|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBBegin] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBBegin] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBEnd|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBEnd] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBEnd] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBRespcode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBRespcode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBRespcode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBcode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBcode] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBcode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'COBServiceType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COBServiceType] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([COBServiceType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BusinessCategory|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BusinessCategory] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BusinessCategory] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'LineOfBusiness|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LineOfBusiness] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([LineOfBusiness] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'EligibilityStartDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligibilityStartDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([EligibilityStartDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'EligibilityEndDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EligibilityEndDate] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([EligibilityEndDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'IsMailingAddressForeign|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMailingAddressForeign] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([IsMailingAddressForeign] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'IsMemberAddressForeign|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMemberAddressForeign] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([IsMemberAddressForeign] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex1Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex1Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex1Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex2Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex2Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex2Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex3Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex3Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex3Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex3] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex3] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex4Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex4Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex4Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex4|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex4] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex4] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex5Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex5Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex5Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex5|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex5] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex5] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex6Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex6Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex6Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex6|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex6] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex6] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex7Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex7Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex7Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex7|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex7] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex7] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex8Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex8Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex8Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex8|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex8] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex8] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex9Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex9Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex9Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex9|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex9] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex9] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex10Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex10Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex10Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'VCFlex10|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VCFlex10] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([VCFlex10] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex1Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex1Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex1Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex1] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex2Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex2Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex2Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex2] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex3Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex3Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex3Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex3] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex3] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex4Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex4Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex4Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex4|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex4] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex4] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex5Label|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex5Label] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex5Label] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'DTFlex5|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DTFlex5] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([DTFlex5] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'BenefitCardNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitCardNumber] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([BenefitCardNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'elig|' as TABLE_SCHEMA,'mstrEligBenefitData|' as TABLE_NAME,'SSBCI|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SSBCI] as nvarchar))),'"') as VALUE from elig.[mstrEligBenefitData] where ltrim(rtrim(cast([SSBCI] as nvarchar))) like @SearchPredicate) a 




IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202106533957')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106403481')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106417052')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106422765')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002310063') 

-- All Contracts, Insurance, HealthPlans that are Actives

select
distinct 
   
  'Benefits' as BenefitsQuery
  ,a.isActive as 'ContractRules_IsActive' ,b.IsActive as 'HealthPlanContracts_IsActive' ,c.IsActive as 'BenefitRulesData_IsActive',ins.IsActive as 'InsuranceCarrier_IsActive',ihp.IsActive as 'InsuranceHealthPlan_IsActive'
  ,mm.NHMemberID as NHMemberID
  ,ins.insuranceCarrierID
  ,ins.InsuranceCarrierName
  ,ihp.insuranceHealthplanID
  ,ihp.HealthPlanName
  ,a.EffectiveFrom
  ,a.EffectiveTo
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

,c.IsActive as IsActive_BenefitRuleData
,c.*

,'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*
,'rulesengine.BenefitRulesData' as TableName_BenefitRulesData

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
left join master.MemberInsurances mi on ins.InsuranceCarrierID = mi.InsuranceCarrierID and ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID
left join master.Members mm on mi.MemberID = mm.MemberID
where 1=1
-- and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1

/*
and ins.InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and (ihp.InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
     or 
	 ihp.InsuranceHealthPlanID is null
	 )
*/

and mm.NHMemberID in (select NHmemberID from #NHMemberIDTemp)
and a.EffectiveFrom between '01-01-2022' and '12-31-2099'

select * from otc.UserProfiles where UserName like '9000%'
select insuranceCarrierID, InsuranceHealthPlanID from master.memberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from otc.UserProfiles where UserName like '9000%'))
and InsuranceHealthPlanID = 3435
select MemberID from master.members where NHMemberID in ( 'NH202106533957','NH202106403481','NH202106417052','NH202106422765')


select 
a.FirstName, a.LastName, b.NHMemberID, a.BenefitStartDate, a.BenefitEndDate, insCarrierID, InsHealthPlanID, a.IsActive
--,a.*,b.* 
from elig.mstrEligBenefitData a left join master.members b on a.MasterMemberID = b.MemberID where MasterMemberID in (select MemberID from master.members where NHMemberID in ( 'NH202106533957','NH202106403481','NH202106417052','NH202106422765') ) 
and cast(BenefitStartDate as date) between cast('01-01-2021' as date) and cast('12-31-2021' as date) order by b.NHMemberID, a.CreateDate


select 
select * from orders.orders where NhmemberID in ( 'NH202106533957','NH202106403481','NH202106417052','NH202106422765') and CreateDate between  '01-01-2021' and '01-01-2022'
select a.*, b.* from 
master.members a left join master.memberinsurances b on a.MemberID = b.MemberID where a.NHMemberID = 'NH202106422765'



IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202106533957')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106403481')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106417052')  -- ticket #
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106422765')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002310063') 

-- All Contracts, Insurance, HealthPlans that are Actives

select
distinct 
   
  'Benefits' as BenefitsQuery
  ,a.isActive as 'ContractRules_IsActive' ,b.IsActive as 'HealthPlanContracts_IsActive' ,c.IsActive as 'BenefitRulesData_IsActive',ins.IsActive as 'InsuranceCarrier_IsActive',ihp.IsActive as 'InsuranceHealthPlan_IsActive'
  ,mm.NHMemberID as NHMemberID
  ,ins.insuranceCarrierID
  ,ins.InsuranceCarrierName
  ,ihp.insuranceHealthplanID
  ,ihp.HealthPlanName
  ,a.EffectiveFrom
  ,a.EffectiveTo
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

,c.IsActive as IsActive_BenefitRuleData
,c.*

,'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*
,'rulesengine.BenefitRulesData' as TableName_BenefitRulesData

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
left join master.MemberInsurances mi on ins.InsuranceCarrierID = mi.InsuranceCarrierID and ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID
left join master.Members mm on mi.MemberID = mm.MemberID
where 1=1
-- and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1

/*
and ins.InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and (ihp.InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
     or 
	 ihp.InsuranceHealthPlanID is null
	 )
*/

and mm.NHMemberID in (select NHmemberID from #NHMemberIDTemp)
and a.EffectiveFrom between '01-01-2022' and '12-31-2099'




select * from information_schema.columns where column_name like '%ca%'
select * from otc.memberproducts

SELECT * FROM sys.dm_os_performance_counters
WHERE object_name LIKE '%Locks%';

select * from insurance.InsuranceHealthPlans where HealthPlanName like 'Central%Health%Medicare%'
InsuranceHealthPlanID	CreateDate	CreateUser	HealthPlanName	HealthPlanNumber	InsuranceCarrierID	IsActive	IsDiscountProgram	ModifyDate	ModifyUser	IsMedicaid	IsMedicare	PlanConfigData	IsProgramCode
217	2017-12-15 18:42:07.5300000	Script	Central Health Medicare Plan (HMO)	NULL	18	1	0	2017-12-15 18:42:07.5300000	Script	0	0	NULL	0


select * from insurance.InsuranceCarriers where insuranceCarrierID = 18
select top 10 * from master.memberInsurances
select * from master.Members where MemberID in 
select ID, MemberID, InsuranceCarrierID, InsuranceHealthPlanID, * from master.MemberInsurances where InsuranceCarrierID = 18 and InsuranceHealthPlanID = 217
select ID, MemberID, InsuranceCarrierID, InsuranceHealthPlanID, * from master.MemberInsurances where InsuranceCarrierID = 4and InsuranceHealthPlanID = 6
select * from orders.orders where NHMemberID in (
select NHMemberID from master.Members where MemberID in (select MemberID from master.MemberInsurances where InsuranceCarrierID = 4 and InsuranceHealthPlanID = 6))
order by CreateDate Desc
select top 10 * from otccatalog.ItemMaster where itemname like '%box%'
select top 10 * from catalog.ItemMasterPriceList
select * from otccatalog.WalletItems where nationsID in ( 9991,9992, 9993)
select walletID from otccatalog.WalletItems where nationsID in ( 9991,9992, 9993)
select * from otccatalog.walletplans where walletID in (select walletID from otccatalog.WalletItems where nationsID in ( 9991,9992, 9993))  (-- 56,57,58,72,86,56,57,58)
select * from otccatalog.walletplans where InsuranceCarrierID = 4


-- ticket 56848

select * from information_schema.columns where column_name like '%cogs%' and table_schema not in ('ReportsData', 'support', 'temp', 'vsdatamig', 'bireports', 'alerts', 'elig', 'execreports', 'dbo') 
and table_name not like '%bak%' and table_name not like '%bk%' and table_name not like '%SD%'

order by table_schema


select * from catalog.ItemMasterPriceList where PriceType = 'MEDICAID' and UnitCOGS is not null and PairCOGS is not null
--and UnitCOGS  < 1 and PairCOGS < 2
order by UnitCOGS, PairCOGS


select * from benefits.GetRevisionPriceChanges where UnitCogs is not null
select top 10 * from Insurance.ContractProducts
select top 10 * from Insurance.ContractProducts 


select * from information_schema.columns where table_schema = 'benefits'

select top 10 * from benefits.ContractMasterPriceList where PriceTypeCode = 'COGS' 

select * from information_schema.columns where column_name in ('HealthPlanContractID') order by table_schema



select distinct insuranceCarrierID, InsuranceHealthPlanID from insurance.HealthPlanContracts

select * from insurance.HealthPlanContracts where HealthPlanContractID = 1383
select * from insurance.HealthPlanContracts where HealthPlanContractID = 1383
select * from benefits.ContractMasterPriceList where HealthPlanContractID = 1383 and PriceTypeCode = 'COGS' and Isincluded =1

select * from elig.mstrEligBenefitData where subscriberID = '00000194713' and IsActive = 1
select NHmemberID from Master.Members where Memberid in (select MasterMemberID from elig.mstrEligBenefitData where subscriberID = '00000194713' and IsActive = 1)




select 
distinct 
a.insCarrierID
,(select b.InsuranceCarrierName from Insurance.InsuranceCarriers b where a.InsCarrierID = b.InsuranceCarrierID) as InsuranceCarrierName
,a.InsHealthPlanID
,(select c.HealthPlanName from Insurance.InsuranceHealthPlans c where a.InsHealthPlanID = c.InsuranceHealthPlanID) as HealthPlanName

,a.BenefitYear, a.BenefitAmount, a.NBWalletCode from  otcfunds.CardBenefitLoad a  
where BenefitSource = 'FIS' and IsActive =1 and BenefitType = 'OTC' and RecordType = 'FD'and BenefitYear = 2022  and

insCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in ('NH202107499383', 'NH202005652758')))
and insHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in ('NH202107499383', 'NH202005652758')))


--order by insCarrierID, InshealthPlanID,BenefitAmount desc 
select * from otcfunds.CardBenefitLoad where insCarrierID = 302 and InsHealthPlanID = 2692 and  NHLinkID in  ('00000164611','00000194713') order by NHLinkID

select * from elig.mstrEligBenefitData where NHLinkID in ('00000164611','00000194713') and isActive =1
select NHMemberID from master.members where NHLinkID in  ('00000164611','00000194713') 

select 'AlignmentSpecialFile' as Query, '[Master].[AlignmentSpecial009Members]' as TableName, * from [Master].[AlignmentSpecial009Members] where SubscriberID in (Select subscriberID from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in ('NH202107499383', 'NH202005652758')))
select distinct recordType from otcfunds.CardBenefitLoad
select * from otcfunds.ClientBenefitRulesData

select * from information_schema.columns 
select * from sys.columns
select top 10 * from sys.tables 
--where name like '%alignment%'
order by create_date desc

/* 02-04-2022
HAP_Medicare_SeniorPlus_PROD_EOB_20220203
HF_CC_Elig_Data
VirPre_Grocery_Optin_db_20220131
Optima_Grocery_Load_elig_members_20220131
Vibra_Grocery_Optin_20220129
CAPBC_Grocery_Optin_20220129
Optima_Grocery_Load_elig_members_20220128
mstrEligBenefitData_ELIG_BCBSKC_bkup01282022
purse_activity_report
BlueKCAddressChanges
*/

select distinct table_name, table_schema from information_schema.columns where table_name like '%optin%'

select top 10 * from CAPBC_Grocery_Optin_20220118
select top 10 * from CAPBC_Grocery_Optin_20220123
select top 10 * from CAPBC_Grocery_Optin_20220127
select top 10 * from CAPBC_Grocery_Optin_20220129
select top 10 * from Optima_Grocery_Optin_db_20220118
select top 10 * from Optima_Grocery_Optin_manual_20220118
select top 10 * from Vibra_Grocery_Optin_20220118
select top 10 * from Vibra_Grocery_Optin_20220123
select top 10 * from Vibra_Grocery_Optin_20220127
select top 10 * from Vibra_Grocery_Optin_20220129
select top 10 * from VirPre_Grocery_Optin_db_20220118
select top 10 * from VirPre_Grocery_Optin_db_20220131

/* Check Eligibility of Member in elig, staging tables-- Ticket # 59519

select 'elig.mstrEligBenefitData' as TableName, IsActive, * from elig.mstrEligBenefitData where subscriberID like '%800686446%' or (FirstName in ('Debra') and LastName in ('Giordano')) and isactive =1
select 'elig.errEligBenefitData' as TableName, * from elig.errEligBenefitData where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'
select 'elig.stgEligBenefitData' as TableName,  * from elig.stgEligBenefitData where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'
select 'elig.stgEligBenefitDataHist' as TableName, * from elig.stgEligBenefitDataHist where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'

*/

select * from auth.UserProfiles where UserName in ('CCTBui', 'CCSSepulveda','CCVMartinez') 


select * from Master.MemberInsurances where IVStatus 

select * from insurance.InsuranceHealthPlans where HealthPlanName like ('%Molina%')


-- Ticket #
select top 10 MasterMemberID from elig.mstrEligBenefitData where insHealthPlanID in (5337 ) and IsActive =1
select top 10 MasterMemberID from elig.mstrEligBenefitData where insHealthPlanID in (5338 )  and IsActive =1

select top 10 NHMemberID from master.Members where MemberID in (select top 10 MasterMemberID from elig.mstrEligBenefitData where insHealthPlanID in (5337 ) and IsActive =1) and IsActive =1
select top 10 NHMemberID from master.Members where MemberID in (select top 10 MasterMemberID from elig.mstrEligBenefitData where insHealthPlanID in (5338  ) and IsActive =1) and IsActive =1



select * from provider.IVQueue where IsActive = 1 and InsuranceCarrierID = 4  and InsuranceHealthPlanID in (6,8) Order by InsuranceCarrierID, InsuranceHealthPlanID

select distinct a.NHMemberID, b.NhmemberID as M_NHMemberID, b.MemberID, c.MasterMemberID, c.InsCarrierID, c.insHealthPlanID from 
Provider.IVQueue a left join Master.Members b on a.NHMemberID = b.NHMemberID
left join elig.mstrEligBenefitData c on b.MemberID = c.MasterMemberID
where a.Isactive =1 and b.isActive=1 and c.IsActive =1 and insCarrierID = 4 and insHealthPlanID in (6,8) order by insHealthPlanID



update master.MemberInsuranceDetails set IVQStatus = NULL where ID = 9768391
update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = 896840
update provider.IVQueue set IsActive = 0 where IVQueueID = 11039




select ID,IVQStatus from master.MemberInsuranceDetails where MemberInsuranceID in (select ID from master.MemberInsurances where MemberID in (select MemberID from master.Members where NHMemberID in
(
select distinct a.NHMemberID from 
Provider.IVQueue a 
left join provider.MemberProfiles b on a.NHMemberID = b.NHMemberID
left join elig.mstrEligBenefitData c on b.MemberProfileID = c.MasterMemberID
where a.Isactive =1 and b.isActive=1 and c.IsActive =1 and insCarrierID = 4 and insHealthPlanID in (6,8)
)  ))

order by IVQStatus



select IVQstatus, IsActive, * from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in ('NH202107133293')))
select IVQStatus, * from provider.MemberInsuranceDetails where ID = 896840
select IsActive,* from provider.IVQueue where NHMemberID in ('NH202107133293')



IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002293375')  -- ticket #  58301 -- Under Review, Paula Campbell 
insert into #NHMemberIDTemp (NHMemberID) values ('NH202107284632') -- ticket # 58265


select IVQstatus, IsActive, * from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in ('NH202107133293')))
select IVQStatus, * from provider.MemberInsuranceDetails where ID = 896840
select IsActive,* from provider.IVQueue where NHMemberID in ('NH202107133293')

update master.MemberInsuranceDetails set IVQStatus = NULL where ID = 9768391
update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = 896840
update provider.IVQueue set IsActive = 0 where IVQueueID = 11039


-- This script creates a script to update IV Pending

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107133293') 
insert into #NHMemberIDTemp (NHMemberID) values ('NH201800408509')

select NHMemberID, InsuranceCarrierID, InsuranceHealthPlanID, * into #NHMemberIDTemp
from provider.IVQueue where IsActive =1
select * from #NHMemberIDTemp where NHMemberID = 
select * from provider.IVQueue

/*
(NH201800404004,NH201800411070,NH201800430439,NH201800433925,NH201800452449,NH201800544009,NH201800643711,NH201901913712,NH201901948953,NH202002373394,NH201800408509,NH201800435114,NH201800441250,NH201800456547,NH202002749005,NH202107488017)

*/

/*
update master.MemberInsuranceDetails set IVQStatus = NULL where ID = 9768391 -- NH202107133293
update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = 896840 -- NH202107133293
update provider.IVQueue set IsActive = 0 where IVQueueID = 11039 -- NH202107133293

*/

--update master.MemberInsuranceDetails
select
'update master.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as Nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp)))

union
-- Update provider.MemberInsuranceDetails
select
'update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as Nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select NHMemberID from #NHMemberIDTemp)))


union
-- Update provider.IVQueue
select
'update provider.IVQueue set IsActive = 0 where IVQueueID = '+ cast(IVQueueID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp)




-- Use This to remove IV status -- Start
IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210748571') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210684252') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210757648') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210780768') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210777395') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210702842') -- done
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202210748631') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210699887') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210778786') -- done
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202210684593') --done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210793381') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210459196') -- done
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202210795089') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210682957') --done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210724657') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210795215') --done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210726972') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210796808') -- not required, already executed
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210797700') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210775184') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210708292') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210779566') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210699833') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210795209') -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210726894')  -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210726911') -- done
insert into #NHMemberIDTemp (NHMemberID) values ('NH202107407703')



--update master.MemberInsuranceDetails
select 1 as SNo,
'update master.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 and (IVQStatus is not null or IVQStatus = 'DENIED')

union
-- Update provider.MemberInsuranceDetails
select 2 as SNo, 
'update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 and (IVQStatus is not null or IVQStatus = 'DENIED')

union 
-- Update provider.IVQueue
select 3 as SNo,
'update provider.IVQueue set IsActive = 0 where IVQueueID = '+ cast(IVQueueID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive <> 0


--Select for the records that contain an IV
select 1 as SNo,
'select IVQStatus, * from master.MemberInsuranceDetails where ID = ' + Cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 -- and (IVQStatus is not null or IVQStatus = 'DENIED')

union

select 2 as SNo,
'select IVQStatus, * from provider.MemberInsuranceDetails where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 -- and (IVQStatus is not null or IVQStatus = 'DENIED')

union

select 3 as SNo,
'select IsActive, * from provider.IVQueue where IVQueueID = '+ cast(IVQueueID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive <> 0

/*
select IVQStatus, * from master.MemberInsuranceDetails where ID = 10207230 -- NH202210796808
select IVQStatus, * from provider.MemberInsuranceDetails where ID = 1088307 -- NH202210796808
select IsActive, * from provider.IVQueue where IVQueueID = 12425 -- NH202210796808

select IVQStatus, * from master.MemberInsuranceDetails where ID = 10205158 -- NH202210795215
select IVQStatus, * from provider.MemberInsuranceDetails where ID = 1083160 -- NH202210795215
select IsActive, * from provider.IVQueue where IVQueueID = 12387 -- NH202210795215
*/


-- Use This to remove IV status -- End

-- Capital Health Plan Carrier and Plan
/*
InsuranceCarrierID	InsuranceCarrierName	InsuranceHealthPlanID
385	Capital Health Plan Florida	5452

select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 385
*/

-- All IV Pending Status
select *
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select distinct MemberID from master.Members where IsActive =1 ) and IsActive = 1 ) and IsActive = 1 and (IVQStatus not in ( 'DENIED' , 'APPROVED', '0'))

select *
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select distinct NHMemberID from master.Members where IsActive =1) and IsActive =1) and IsActive =1) and IsActive =1 and (IVQStatus not in ( 'DENIED' , 'APPROVED', '0'))

select *
from provider.IVQueue where NHMemberID in (select distinct NHMemberID from master.Members where IsActive =1) and IsActive <> 0

-- All IV Pending Status by Carrier and Plan
select distinct IVQStatus,*
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select distinct MemberID from master.Members where IsActive =1 ) and IsActive = 1 and InsuranceCarrierID = 385 and InsuranceHealthPlanID in ( 5452,5453)  ) and IsActive = 1 and (IVQStatus not in ( 'DENIED' , 'APPROVED', '0'))

select distinct IVQStatus, *
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select distinct NHMemberID from master.Members where IsActive =1) and IsActive =1) and IsActive =1 and InsuranceCarrierID = 385 and InsuranceHealthPlanID in ( 5452,5453  ) ) and IsActive =1 and (IVQStatus not in ( 'DENIED' , 'APPROVED', '0'))

select distinct IsActive, *
from provider.IVQueue where NHMemberID in (select distinct NHMemberID from master.Members where IsActive =1 and MemberID in (Select MemberID from master.MemberInsurances where InsuranceCarrierID = 385 and InsuranceHealthPlanID in ( 5452,5453  ) )) and IsActive <> 0

select distinct IsActive, *
from provider.IVQueue where NHMemberID in (select distinct NHMemberID from provider.MemberProfiles where IsActive = 1 and MemberProfileID in (Select MemberProfileID from provider.MemberInsurances where InsuranceCarrierID = 385 and InsuranceHealthPlanID in ( 5452,5453  ) )) and IsActive <> 0




-- Master tables
select 
c.IVQStatus,c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as Members_IsActive,  a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr, a.*, b.*, c.*
from
master.MemberInsuranceDetails c 
left join master.MemberInsurances b on c.MemberInsuranceID = b.ID
left join master.Members a on a.MemberID = b.MemberID
where 1=1 
-- and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and b.InsuranceCarrierID = 385 and b.InsuranceHealthPlanID in ( 5452,5453 )
and c.IVQStatus not in ('DENIED', 'APPROVED')
order by b.InsuranceHealthPlanID


--Provider Tables
select 
c.IVQStatus,c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as MemberProfiles_IsActive,  a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr, a.*, b.*, c.*
from
Provider.MemberInsuranceDetails c 
left join Provider.MemberInsurances b on c.MemberInsuranceID = b.MemberInsuranceID
left join Provider.MemberProfiles a on a.MemberProfileID = b.MemberProfileId
where 1=1 
-- and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and b.InsuranceCarrierID = 385 and b.InsuranceHealthPlanID in ( 5452,5453 )
and c.IVQStatus not in ('DENIED', 'APPROVED')
order by b.InsuranceHealthPlanID



select c.IVQStatus,d.IsActive as IsActive_IVQueue,
c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as MemberProfiles_IsActive,  a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr, a.*, b.*, c.*, d.*
from
Provider.MemberInsuranceDetails c 
left join Provider.MemberInsurances b on c.MemberInsuranceID = b.MemberInsuranceID
left join Provider.MemberProfiles a on a.MemberProfileID = b.MemberProfileId
left join provider.IVQueue d on d.NHMemberId = a.NHMemberId
where 1=1 
-- and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and b.InsuranceCarrierID = 385 and b.InsuranceHealthPlanID in ( 5452,5453 )
and c.IVQStatus not in ('DENIED', 'APPROVED')
order by b.InsuranceHealthPlanID






select * from master.members where firstName like '%Marilyn%' and LastName like '%French%'



-- To Create MEA Account

IF OBJECT_ID('tempdb..#CreateMEAAccount') IS NOT NULL DROP TABLE #CreateMEAAccount
Create table #CreateMEAAccount
(
TicketNo int,
FirstName nvarchar(50),
LastName nvarchar(50),
UserType nvarchar(10),
SerialNo int,
UserName nvarchar(100)
)

insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (53450,'Santhosh','Balla','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (53451,'Raj','Sareddy','CC',NULL)

update #CreateMEAAccount set UserName = UserType + substring(Firstname,0,1) + LastName + isnull(Cast(SerialNo as nvarchar),'')

select * from #CreateMEAAccount

-- This is the select statement to check the UserName
select
'select FirstName,LastName,UserName from auth.UserProfiles where UserName like '+ ''''+ '%'+ UserName+ '%'+'''' from #CreateMEAAccount


-- Execute Statement
select
'EXECUTE [CallCenter].[CreateMEAAccount] ' + ''''+FirstName+''''+' , '+''''+LastName+''''+' , '+''''+Username+'''' + '    -- Ticket# '+Cast(TicketNo as nvarchar)  from #CreateMEAAccount



/*
select distinct substring(UserName,1,1), substring(Username,1, 2), substring(Username,len(Username), 1) from auth.UserProfiles order by 3,2,1
select substring(Username,len(Username), 1), count(*) as CountNo from auth.UserProfiles group by substring(Username,len(Username), 1) order by 1
select * from auth.UserProfiles where substring(Username,len(Username), 1) = '9'
*/

-- Audit Data or First Call Resolution
-- Ticket # 60006 | Diego Quiroz
/*
Good afternoon,
I am trying to see which plan these members had for 2021 and what was their benefit. Looks like all Florida Blue plans for 2021 are not showing in CRM system.
Will you please be able to provide the name of the plan and the benefit the following members had?

NH202106379731
NH202106394413
NH202106416130
NH202106397461

*/


IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202106379731')  -- ticket #60006
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106394413')  -- ticket #60006
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106416130')  -- ticket #60006
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106397461')  -- ticket #60006
insert into #NHMemberIDTemp (NHMemberID) values ('NH202106893268 ') -- ticket #60006


select
distinct 
   
  'Benefits' as BenefitsQuery
  ,a.isActive as 'ContractRules_IsActive' ,b.IsActive as 'HealthPlanContracts_IsActive' ,c.IsActive as 'BenefitRulesData_IsActive',ins.IsActive as 'InsuranceCarrier_IsActive',ihp.IsActive as 'InsuranceHealthPlan_IsActive'--, mi.IsActive as 'MemberInsurances_IsActive'
  ,mm.NHMemberID as NHMemberID
  ,ins.insuranceCarrierID
  ,ins.InsuranceCarrierName
  ,ihp.insuranceHealthplanID
  ,ihp.HealthPlanName
  ,a.EffectiveFrom
  ,a.EffectiveTo
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

,c.IsActive as IsActive_BenefitRuleData
,c.*

,'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*
,'rulesengine.BenefitRulesData' as TableName_BenefitRulesData

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
left join master.MemberInsurances mi on ins.InsuranceCarrierID = mi.InsuranceCarrierID and ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID
left join master.Members mm on mi.MemberID = mm.MemberID
where 1=1
-- and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1

/*
and ins.InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and (ihp.InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
     or 
	 ihp.InsuranceHealthPlanID is null
	 )
*/

and mm.NHMemberID in (select NHmemberID from #NHMemberIDTemp)
and a.EffectiveFrom between '01-01-2021' and '12-31-2021'



-- Ticket # 60315

202225818

select * from orders.orders where orderid = '202225818'
select * from orders.OrderItems where orderid =  '202225818'
select * from orders.OrderTransactionDetails where orderid =  '202225818'

[{"orderDate":"01-06-2022","carrier":"FedEx Home Delivery","serviceType":"FEDEX2","orderId":"202225818","trackingNumber":"288634487192","trackingUrl":"https://www.fedex.com/fedextrack/?trknbr=288634487192","shipDate":"01-11-2022","shippingCost":"15.16","taxCost":"0.0","itemTracking":[{"itemNumber":"10006","trackingNumber":"288634487192","weight":"10.0","units":"Pound"}]}]


-- ticket # 60372
select top 10 * from otccatalog.ItemMaster where itemName like '%box%'



IF OBJECT_ID('tempdb..#TWalletID') IS NOT NULL DROP TABLE #TWalletID
select * into #TWalletID from 
(
		select distinct 'otccatalog.WalletPlans' as TableName, walletID, InsuranceCarrierID, InsuranceHealthPlanID, PlanWalletName, IsActive, BenefitValueSource from otccatalog.WalletPlans 
		where insuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
		and
		( 
		InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
					 or 
		InsuranceHealthPlanID is null
		)
		-- and IsActive = 1
) a

select * from #TWalletID

select * from otccatalog.WalletPlans where InsuranceCarrierid = 4

delete from #TWalletID where walletID not in (90)

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002293375')  -- ticket #  58301 -- Under Review, Paula Campbell 
insert into #NHMemberIDTemp (NHMemberID)   values ('NH201800430088') -- ticket # 58265

select distinct 'Items' as 'CatalogQuery', 'otccatalog.ItemMaster' as tablename,IsActive,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.Wallets' as tablename,IsActive, * from otccatalog.Wallets where WalletID in (select walletID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.WalletPlans' as TableName,IsActive,* from otccatalog.WalletPlans where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID)
select distinct 'otccatalog.WalletItems' as TableName,IsActive,* from otccatalog.WalletItems where WalletID in (select WalletID from #TWalletID) -- and NationsId = 5888
select distinct 'otccatalog.GetPlanWalletMap' as TableName,'NotAvailable' as IsActive,* from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID)
select distinct 'otccatalog.WalletOverrides' as TableName,IsActive, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (select WalletID from #TWalletID) ) 
select distinct 'otccatalog.WalletPlanOverrides' as TableName,IsActive, * from otccatalog.WalletPlanOverRides where WalletPlanID in (select WalletID from #TWalletID) 
select distinct 'otccatalog.WalletItemsHistory' as TableName,IsActive,* from otccatalog.WalletItemsHistory where WalletID in (select WalletID from #TWalletID)




/*
Ticket # 60464
Hello can you please transfer funds from order#  : 200734986 to order# 202437515 for member Carl Bradley - NH202004652704
*/

declare @FromOrder int, @ToOrder int
set @FromOrder = 200734986		-- OrderStatus	: Returned
set @ToOrder = 202437515		-- OrderStatus 	: Initiated

/* There should be a PAY OrderStatusCode
select a.isActive, a.OrderID, (select NhMemberID from orders.orders b where a.orderID = b.OrderID ), a.OrderStatusCode,  a.OrderTransactionData,  a.IsComplete,  a.CreateDate,  a.CreateUSer,  a.CreateDate,  a.ModifyDate from Orders.OrderTransactionDetails a where OrderID = @FromOrder -- From Order
select a.isActive, a.OrderID, (select NhMemberID from orders.orders b where a.orderID = b.OrderID ), a.OrderStatusCode,  a.OrderTransactionData,  a.IsComplete,  a.CreateDate,  a.CreateUSer,  a.CreateDate,  a.ModifyDate from Orders.OrderTransactionDetails a where OrderID = @ToOrder -- To Order
select @ToOrder, 'PAY',JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),1,GETDATE(), 'rsareddy',GETDATE(),'cxavier',1 FROM orders.ordertransactiondetails WHERE 1=1 AND orderid = @FromOrder AND OrderStatusCode = 'PAY' AND IsActive = 1  -- Record to Insert

*/

INSERT INTO orders.ordertransactiondetails
SELECT @ToOrder, -- To Order
'PAY',
--OrderTransactionData,
JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),   -- To Order
1,
GETDATE(), 
'rsareddy',
GETDATE(),
'cxavier',
1
FROM orders.ordertransactiondetails 
WHERE 1=1
AND orderid = @FromOrder              -- From Order
AND OrderStatusCode = 'PAY'
AND IsActive = 1




-- Ticket # 60316


-- To Create MEA Account

IF OBJECT_ID('tempdb..#CreateMEAAccount') IS NOT NULL DROP TABLE #CreateMEAAccount
Create table #CreateMEAAccount
(
TicketNo int,
FirstName nvarchar(50),
LastName nvarchar(50),
UserType nvarchar(10),
SerialNo int,
UserName nvarchar(100)
)

insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Marlene','Sanchez','CC',1)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Liliana','Teodoro','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Julian','Sevilla','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Randy','Aguilar','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Victoria','Johnson','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Debbie','Altis','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Lubia','Acju','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Khoa','Nguyen','CC',1)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Jasmine','Bond','CC',NULL)
insert into #CreateMEAAccount (TicketNo, FirstName, LastName, UserType, SerialNo) values (60316,'Dianna','Ramos','CC',1)




update #CreateMEAAccount set UserName = UserType + substring(Firstname,1,1) + LastName + isnull(Cast(SerialNo as nvarchar),'')

select * from #CreateMEAAccount

-- This is the select statement to check the UserName
select
'select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '+ ''''+ '%'+ UserName+ '%'+'''' + ' UNION ' from #CreateMEAAccount


-- Execute Statement
select
'EXECUTE [CallCenter].[CreateMEAAccount] ' + ''''+FirstName+''''+' , '+''''+LastName+''''+' , '+''''+Username+'''' + '    -- Ticket# '+Cast(TicketNo as nvarchar)  from #CreateMEAAccount

-- returned zero rows
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCMSanchez1%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCLTeodoro%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCJSevilla%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCRAguilar%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCVJohnson%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCDAltis%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCLAcju%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCKNguyen1%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCJBond%' UNION 
select IsActive, Isregister, FirstName,LastName,UserName,TemproryKeyCode,CreateDate, * from auth.UserProfiles where UserName like '%CCDRamos1%' 

-- Execute Statements
EXECUTE [CallCenter].[CreateMEAAccount] 'Marlene' , 'Sanchez' , 'CCMSanchez1'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Liliana' , 'Teodoro' , 'CCLTeodoro'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Julian' , 'Sevilla' , 'CCJSevilla'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Randy' , 'Aguilar' , 'CCRAguilar'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Victoria' , 'Johnson' , 'CCVJohnson'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Debbie' , 'Altis' , 'CCDAltis'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Lubia' , 'Acju' , 'CCLAcju'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Khoa' , 'Nguyen' , 'CCKNguyen1'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Jasmine' , 'Bond' , 'CCJBond'    -- Ticket# 60316
EXECUTE [CallCenter].[CreateMEAAccount] 'Dianna' , 'Ramos' , 'CCDRamos1'    -- Ticket# 60316




select * from information_schema.columns where Column_name like '%code%' order by column_name

select * from elig.clientcodes where DataSource like '%MLNA%'
select * from elig.mstrEligBenefitData where DataSource like '%MLNA%' and inscarrierid = 380 and insHealthplanID = 5312
FirstName = 'Alice' and LastName = 'Haynes' and isActive =1


select MemberID from master.memberinsurances where insuranceCarrierID = 380 and insuranceHealthPlanID = 5312

select * from orders.orders where NHMemberID in (
select NHMemberID from master.members where memberID in (select MemberID from master.memberinsurances where insuranceCarrierID = 380 and insuranceHealthPlanID = 5312) and isActive =1
)

---------------------------------------------------------------------------------------------------------------------------------------
-- To select records for an Insurance Carrier and Health Plan
select distinct a.isActive as IsActive_Member, b.IsActive as IsActive_Insurances, c.IsActive as IsActive_InsuranceDetails, a.NHMemberID, a.FirstName, a.LastName, cast(a.DateOFBirth as Date), b.InsuranceCarrierID, b.InsuranceHealthplanID, c.InsuranceNBR
,(select top 1 orderID from orders.orders where NHMemberID = a.NHMemberID) as OrderID
from Master.members a 
join master.MemberInsurances b on a.MemberID =b.MemberID
join master.MemberInsuranceDetails c on b.ID = c.MemberInsuranceID


where 1=1
-- and NHMemberID in (' ', '  ')
and b.InsuranceCarrierID in (367) and b.InsuranceHealthPlanID in (5106,3393)
-- and c.InsuranceNbr in (  )
order by OrderID

select * from [provider].[MemberPhoneNumbers]

-- Check all Members and if they have any orders
drop table #TotalOrders
select * into #TotalOrders from (
select a.isActive as IsActive_Member, b.IsActive as IsActive_Insurances, c.IsActive as IsActive_InsuranceDetails, a.NHMemberID, a.FirstName, a.LastName, cast(a.DateOFBirth as Date) as DateofBirth, b.InsuranceCarrierID, b.InsuranceHealthplanID, c.InsuranceNBR
,(select top 1 orderID from orders.orders where NHMemberID = a.NHMemberID) as OrderID
from Master.members a 
join master.MemberInsurances b on a.MemberID =b.MemberID
join master.MemberInsuranceDetails c on b.ID = c.MemberInsuranceID
) a
where a.OrderID is not NULL
and a.IsActive_Member = 1 and a.IsActive_Insurances = 1 and a.IsActive_InsuranceDetails = 1
and a.InsuranceCarrierID in ( 367 ) and a.InsuranceHealthplanID in (5106,3393)
-- 8268187 No Orders at all
-- 662915 have atleast one order
-- total Members -- 8931102

select (cast(662915 as decimal) / cast(8931102 as decimal))*100  -- 7.4225442728120225% of members made a purchase
select (cast(502823 as decimal) / cast(6915220 as decimal))*100  -- 7.2712509508012760%
---------------------------------------------------------------------------------------------------------------------------------------

select count(*) as MembersWhoPurchased from (
select distinct NHMemberId from #TotalOrders  -- 502823
) a

select count(*) as TotalMembers from (
select distinct NHMemberID from master.members -- 6915220
) a



select * from otcfunds.CardBenefitLoad where InsCarrierID = '367'
select * from orders.orders where orderID in (202291474,202294296,202310196,202209771)


select distinct 
   'Benefits' as BenefitsQuery
  ,a.isActive as 'ContractRules_IsActive' ,b.IsActive as 'HealthPlanContracts_IsActive' ,c.IsActive as 'BenefitRulesData_IsActive',ins.IsActive as 'InsuranceCarrier_IsActive',ihp.IsActive as 'InsuranceHealthPlan_IsActive'
  ,mm.NHMemberID as NHMemberID
  ,ins.insuranceCarrierID
  ,ins.InsuranceCarrierName
  ,ihp.insuranceHealthplanID
  ,ihp.HealthPlanName
  ,a.EffectiveFrom
  ,a.EffectiveTo
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

,c.IsActive as IsActive_BenefitRuleData
,c.*

,'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*
,'rulesengine.BenefitRulesData' as TableName_BenefitRulesData

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
left join master.MemberInsurances mi on ins.InsuranceCarrierID = mi.InsuranceCarrierID and ihp.InsuranceHealthPlanID = mi.InsuranceHealthPlanID
left join master.Members mm on mi.MemberID = mm.MemberID
where 1=1
and b.insuranceCarrierID = 


select distinct IsActive, INsuranceCarrierID, InsuranceCarrierName from insurance.InsuranceCarriers where IsActive =1 order by InsuranceCarrierName

-- Total Members in Insurance Carriers, HealthPlans 
select  distinct
insCarrierID, (select b.InsuranceCarrierName from  insurance.InsuranceCarriers b where a.insCarrierID = b.InsuranceCarrierID) InsuranceCarrierName,  
insHealthPlanID, (select b.HealthPlanName from  insurance.InsuranceHealthPlans b where a.insHealthPlanID = b.InsuranceHealthPlanID) InsuranceHealthPlanName,  
count(*) MemberCount from elig.mstrEligBenefitData a where IsActive = 1 group by insCarrierID, insHealthPlanID order by  1,5 desc



IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH201800442735') -- ticket # 58265
insert into #NHMemberIDTemp (NHMemberID) values ('NH202005684546') -- ticket # 58265

IF OBJECT_ID('tempdb..#TWalletID') IS NOT NULL DROP TABLE #TWalletID
select * into #TWalletID from 
(
		select distinct 'otccatalog.WalletPlans' as TableName, walletID, InsuranceCarrierID, InsuranceHealthPlanID, PlanWalletName, IsActive, BenefitValueSource from otccatalog.WalletPlans 
		where insuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
		and
		( 
		InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
					 or 
		InsuranceHealthPlanID is null
		)
		-- and IsActive = 1
) a



select * from #TWalletID
--delete from #TWalletID where WalletID <> 122

select distinct 'Items' as 'CatalogQuery', 'otccatalog.ItemMaster' as tablename,IsActive,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.Wallets' as tablename,IsActive, * from otccatalog.Wallets where WalletID in (select walletID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.WalletPlans' as TableName,IsActive,* from otccatalog.WalletPlans where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and (InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID) or InsuranceHealthPlanID is null)
select distinct 'otccatalog.WalletItems' as TableName,IsActive,* from otccatalog.WalletItems where WalletID in (select WalletID from #TWalletID)  and IsActive = 1-- and NationsId in (5119,5602,5814) 
select distinct 'otccatalog.GetPlanWalletMap' as TableName,'NotAvailable' as IsActive,* from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and (InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID) or InsuranceHealthPlanID is null)
select distinct 'otccatalog.WalletOverrides' as TableName,IsActive, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (select WalletID from #TWalletID) ) 
select distinct 'otccatalog.WalletPlanOverrides' as TableName,IsActive, * from otccatalog.WalletPlanOverRides where WalletPlanID in (select WalletID from #TWalletID) 
select distinct 'otccatalog.WalletItemsHistory' as TableName,IsActive,* from otccatalog.WalletItemsHistory where WalletID in (select WalletID from #TWalletID)



select distinct 'otccatalog.GetPlanWalletMap' as TableName,'NotAvailable' as IsActive,* from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID)



select * from otccatalog.WalletItems where NationsID in (5119,5602,5814) order by walletID

select top 10 * from orders.orders where orderType = 'OTC'and cREATEdATE > Getdate() - 100
select  *
, json_value(orderItems.ItemData, '$.nationsId') as ItemData_nationsId 
from orders.orderItems where ItemType = 'OTC' and json_value(orderItems.ItemData, '$.nationsId')  in (5119,5602,5814) order  by json_value(orderItems.ItemData, '$.nationsId')

select *
,json_value(orders.MemberData, '$.insCarrierID') as MemberData_carrierName
,json_value(orders.MemberData, '$.insPlanID') as MemberData_planName
from orders.orders where orderID in (select orderid from orders.orderItems where ItemType = 'OTC' and json_value(orderItems.ItemData, '$.nationsId')  in (5119,5602,5814))


drop table #ActiveDups
-- Find all records that have the same FirstName, LastName, DOB, zipcode and address1 and are active and benefits are good
Select count(*) as DuplicateCnt, firstname,lastname,DOB,zipcode,address1 into  #ActiveDups
from elig.mstrEligBenefitData (nolock) where isactive=1 and BenefitEndDate>getdate() 
group by firstname,lastname,DOB,zipcode,address1
having count(*)>1

Select count(*) as DuplicateCnt, firstname,lastname,DOB,zipcode,address1 into  #ActiveDups1
from elig.mstrEligBenefitData (nolock) where isactive=1 and Getdate() between BenefitStartDate and BenefitEndDate
group by firstname,lastname,DOB,zipcode,address1
having count(*)>1


-- my scripts
select * from #ActiveDups where duplicateCnt > 4 order by dob, zipcode, address1, firstname, lastname 
select * from elig.mstrEligBenefitData where firstName = 'Jason' and Lastname = 'Plante' and isActive =1


-- Insurance CarrierID is not the same, but the Member Demographic information is similar
select count(*) as cnt,e.firstname,e.lastname,e.DOB,e.zipcode,e.address1, e.MasterMemberID,e.insCarrierID, ic.InsuranceCarrierName 
into #insdups
from #ActiveDups ad
join elig.mstrEligBenefitData (nolock) e on e.firstname=ad.FirstName and e.LastName=ad.LastName and e.dob=ad.dob and e.Address1=ad.Address1 and e.ZipCode=ad.ZipCode
join insurance.InsuranceCarriers ic on ic.InsuranceCarrierID=e.insCarrierID
where e.isactive=1 and e.BenefitEndDate>getdate() 
group by e.firstname,e.lastname,e.DOB,e.zipcode,e.address1,  e.MasterMemberID ,e.insCarrierID ,ic.InsuranceCarrierName
having count(*)=1  order by 2,3,4,5,6

--My Scripts
select * from elig.mstrEligBenefitData where FirstName = 'CHARLES' and LastName like 'WHARTON' and isActive =1 order by DataSource
select * from #insdups where FirstName = 'CHARLES' and LastName like 'WHARTON' 
select * from #insdups where FirstName = 'Jason' and LastName like 'Plante' 


select * into #uaw from #insdups where InsuranceCarrierName like '%UAW%'

select * from #uaw
select * from elig.mstrEligBenefitData where firstName = 'KEVIN' and Lastname = 'VEJNOVICH' and isActive =1

select ins.* into #UAWrecords 
from #insdups ins
join #uaw u on u.FirstName=ins.firstname 
and u.LastName=ins.LastName and u.Address1=ins.Address1
and u.DOB=ins.DOB and u.ZipCode=ins.ZipCode
order by  2,3,4,5,6

--select * from #UAWrecords order by 2,3,4,5,6

select * into #nonuaw 
from #insdups ins
where not exists ( select 1 from #uaw u  where ins.FirstName=u.FirstName and ins.LastName=u.LastName
and ins.Address1=u.Address1 and ins.DOB=u.dob and ins.ZipCode=u.ZipCode)
order by 2,3,4,5,6

select distinct  e.firstname, e.LastName,e.dob,e.Address1, e.ZipCode,e.BenefitStartDate,e.BenefitEndDate,inc.InsuranceCarrierName,e.insCarrierID,e.insHealthPlanID 
into #nuawdet from  #nonuaw nuaw 
join elig.mstrEligBenefitData (nolock) e on e.firstname=nuaw.FirstName 
and e.LastName=nuaw.LastName and e.dob=nuaw.dob and e.Address1=nuaw.Address1 and e.ZipCode=nuaw.ZipCode
join insurance.InsuranceCarriers inc on inc.InsuranceCarrierID=e.insCarrierID
where e.isactive=1 and e.BenefitEndDate>getdate() 
-- 

select * from #UAWrecords order by 2,3,4,5,6
Select * from #nonuaw order by 2,3,4,5,6


select * from (

select Firstname, lastname,dob, address1,zipcode, insCarrierID,
ROW_NUMBER() OVER (PARTITION BY  Firstname,lastname,dob, address1,zipcode order by Firstname,lastname,dob, address1,zipcode) as rowid
from elig.mstrEligBenefitData
where isActive =1 and getdate() between BenefitStartDate and BenefitEndDate
) a
where rowid > 3

select FirstName, LastName, dob, Address1, zipCode,insCarrierID from elig.mstrEligBenefitData where FirstName like 'Charlene' and LastName like 'Brissette' and Dob = '12-13-1943' and IsActive =1


-- Zero records Returned ( There are no records where a member has 5 accounts from 5 different carriers and are active
select 
a.MasterMemberID, a.FirstName, a.LastName, a.dob, a.Address1, a.zipcode, a.insCarrierID,
b.MasterMemberID, b.FirstName, b.LastName, b.dob, b.Address1, b.zipcode, b.insCarrierID,
c.MasterMemberID, c.FirstName, c.LastName, c.dob, c.Address1, c.zipcode, c.insCarrierID,
d.MasterMemberID, d.FirstName, d.LastName, d.dob, d.Address1, d.zipcode, d.insCarrierID,
e.MasterMemberID, e.FirstName, e.LastName, e.dob, e.Address1, e.zipcode, e.insCarrierID
from 
elig.mstrEligBenefitData a 
left join elig.mstrEligBenefitData b on ( a.FirstName = b.FirstName and a.LastName =  b.LastName and a.dob = b.dob and a.Address1 = b.Address1 and a.zipcode = b.zipcode and a.insCarrierID <> b.insCarrierID )
left join elig.mstrEligBenefitData c on ( b.FirstName = c.FirstName and b.LastName =  c.LastName and b.dob = c.dob and b.Address1 = c.Address1 and b.zipcode = c.zipcode and b.insCarrierID <> c.insCarrierID and a.insCarrierID <> c.insCarrierID )
left join elig.mstrEligBenefitData d on ( c.FirstName = d.FirstName and c.LastName =  d.LastName and c.dob = d.dob and c.Address1 = d.Address1 and c.zipcode = d.zipcode and c.insCarrierID <> d.insCarrierID and b.insCarrierID <> d.insCarrierID and a.insCarrierID <> d.insCarrierID  )
left join elig.mstrEligBenefitData e on ( d.FirstName = e.FirstName and d.LastName =  e.LastName and d.dob = e.dob and d.Address1 = e.Address1 and d.zipcode = e.zipcode and d.insCarrierID <> e.insCarrierID and a.insCarrierID <> e.insCarrierID and b.insCarrierID <> e.insCarrierID and c.insCarrierID <> e.insCarrierID )
where 1=1
and a.IsActive =1 and b.isActive = 1 and c.Isactive =1 and d.IsActive =1 and e.Isactive =1
and Getdate() between a.BenefitStartDate and a.BenefitEndDate
and Getdate() between b.BenefitStartDate and b.BenefitEndDate
and Getdate() between c.BenefitStartDate and c.BenefitEndDate
and Getdate() between d.BenefitStartDate and d.BenefitEndDate
and Getdate() between e.BenefitStartDate and e.BenefitEndDate


-- Zero records Returned ( There are no records where a member has 4 accounts from 4 different carriers and are active
select 
a.MasterMemberID, a.FirstName, a.LastName, a.dob, a.Address1, a.zipcode, a.insCarrierID,
b.MasterMemberID, b.FirstName, b.LastName, b.dob, b.Address1, b.zipcode, b.insCarrierID,
c.MasterMemberID, c.FirstName, c.LastName, c.dob, c.Address1, c.zipcode, c.insCarrierID,
d.MasterMemberID, d.FirstName, d.LastName, d.dob, d.Address1, d.zipcode, d.insCarrierID

from 
elig.mstrEligBenefitData a 
left join elig.mstrEligBenefitData b on ( a.FirstName = b.FirstName and a.LastName =  b.LastName and a.dob = b.dob and a.Address1 = b.Address1 and a.zipcode = b.zipcode and a.insCarrierID <> b.insCarrierID )
left join elig.mstrEligBenefitData c on ( b.FirstName = c.FirstName and b.LastName =  c.LastName and b.dob = c.dob and b.Address1 = c.Address1 and b.zipcode = c.zipcode and b.insCarrierID <> c.insCarrierID and a.insCarrierID <> c.insCarrierID )
left join elig.mstrEligBenefitData d on ( c.FirstName = d.FirstName and c.LastName =  d.LastName and c.dob = d.dob and c.Address1 = d.Address1 and c.zipcode = d.zipcode and c.insCarrierID <> d.insCarrierID and b.insCarrierID <> d.insCarrierID and a.insCarrierID <> d.insCarrierID  )
where 1=1
and a.IsActive =1 and b.isActive = 1 and c.Isactive =1 and d.IsActive =1 
and Getdate() between a.BenefitStartDate and a.BenefitEndDate
and Getdate() between b.BenefitStartDate and b.BenefitEndDate
and Getdate() between c.BenefitStartDate and c.BenefitEndDate
and Getdate() between d.BenefitStartDate and d.BenefitEndDate


-- 66 records, Returned ( There are 66 records where a member has 3 accounts from 3 different carriers and are active

select * into #TDuplicate from (
select 
a.MasterMemberID AMasterMemberID  , a.FirstName AFirstName, a.LastName ALastName, a.dob Adob, a.Address1 AAddress1, a.zipcode Azipcode, a.insCarrierID AinsCarrierID,
b.MasterMemberID BMasterMemberID  , b.FirstName BFirstName, b.LastName BLastName, b.dob Bdob, b.Address1 BAddress1, b.zipcode Bzipcode, b.insCarrierID BinsCarrierID,
c.MasterMemberID CMasterMemberID  , c.FirstName CFirstName, c.LastName CLastName, c.dob Cdob, c.Address1 CAddress1, c.zipcode Czipcode, c.insCarrierID CinsCarrierID

from 
elig.mstrEligBenefitData a 
join elig.mstrEligBenefitData b on ( a.FirstName = b.FirstName and a.LastName =  b.LastName and a.dob = b.dob and a.Address1 = b.Address1 and a.zipcode = b.zipcode and a.insCarrierID <> b.insCarrierID )
join elig.mstrEligBenefitData c on ( b.FirstName = c.FirstName and b.LastName =  c.LastName and b.dob = c.dob and b.Address1 = c.Address1 and b.zipcode = c.zipcode and b.insCarrierID <> c.insCarrierID and a.insCarrierID <> c.insCarrierID )
where 1=1
and a.IsActive =1 and b.isActive = 1 and c.Isactive =1 
and Getdate() between a.BenefitStartDate and a.BenefitEndDate
and Getdate() between b.BenefitStartDate and b.BenefitEndDate
and Getdate() between c.BenefitStartDate and c.BenefitEndDate

) a


-- 11 records, ( 11 members have 3 active records with 3 insurance carriers
drop table #TDuplicate
select * into #TDuplicate from (
select 
a.MasterMemberID AMasterMemberID  , a.FirstName AFirstName, a.LastName ALastName, a.dob Adob, a.Address1 AAddress1, a.zipcode Azipcode, a.insCarrierID AinsCarrierID,
b.MasterMemberID BMasterMemberID  , b.FirstName BFirstName, b.LastName BLastName, b.dob Bdob, b.Address1 BAddress1, b.zipcode Bzipcode, b.insCarrierID BinsCarrierID,
c.MasterMemberID CMasterMemberID  , c.FirstName CFirstName, c.LastName CLastName, c.dob Cdob, c.Address1 CAddress1, c.zipcode Czipcode, c.insCarrierID CinsCarrierID,
row_number() over (PARTITION BY  a.Firstname,a.lastname,a.dob, a.Address1, a.ZipCode order by  a.Firstname,a.lastname,a.dob, a.Address1, a.ZipCode) as rowid_RowNumber
from 
elig.mstrEligBenefitData a 
join elig.mstrEligBenefitData b on ( a.FirstName = b.FirstName and a.LastName =  b.LastName and a.dob = b.dob and a.Address1 = b.Address1 and a.zipcode = b.zipcode and a.insCarrierID <> b.insCarrierID )
join elig.mstrEligBenefitData c on ( b.FirstName = c.FirstName and b.LastName =  c.LastName and b.dob = c.dob and b.Address1 = c.Address1 and b.zipcode = c.zipcode and b.insCarrierID <> c.insCarrierID and a.insCarrierID <> c.insCarrierID )
where 1=1
and a.IsActive =1 and b.isActive = 1 and c.Isactive =1 
and Getdate() between a.BenefitStartDate and a.BenefitEndDate
and Getdate() between b.BenefitStartDate and b.BenefitEndDate
and Getdate() between c.BenefitStartDate and c.BenefitEndDate
) a
where a.rowid_RowNumber =1


--Members having two accounts that are active and are from two different carriers.
drop table #TDuplicate
select * into #TDuplicate from (
select 
a.MasterMemberID AMasterMemberID  , a.FirstName AFirstName, a.LastName ALastName, a.dob Adob, a.Address1 AAddress1, a.zipcode Azipcode, a.insCarrierID AinsCarrierID,
b.MasterMemberID BMasterMemberID  , b.FirstName BFirstName, b.LastName BLastName, b.dob Bdob, b.Address1 BAddress1, b.zipcode Bzipcode, b.insCarrierID BinsCarrierID,
row_number() over (PARTITION BY  a.Firstname,a.lastname,a.dob, a.Address1, a.ZipCode order by  a.Firstname,a.lastname,a.dob, a.Address1, a.ZipCode) as rowid_RowNumber
from 
elig.mstrEligBenefitData a 
join elig.mstrEligBenefitData b on ( a.FirstName = b.FirstName and a.LastName =  b.LastName and a.dob = b.dob and a.Address1 = b.Address1 and a.zipcode = b.zipcode and a.insCarrierID <> b.insCarrierID )
where 1=1
and a.IsActive =1 and b.isActive = 1 
and Getdate() between a.BenefitStartDate and a.BenefitEndDate
and Getdate() between b.BenefitStartDate and b.BenefitEndDate
) a
where a.rowid_RowNumber =1




select * from #TDuplicate a order by aFirstName,aLastName, adob, aAddress1, azipcode,ainsCarrierID 
--
select * from (
select *,
row_number() over (PARTITION BY  AFirstname,Alastname,Adob order by  AFirstname,Alastname,Adob) as rowid_RowNumber
--Rank() OVER (PARTITION BY  AFirstname,Alastname,Adob order by  AFirstname,Alastname,Adob) as rowid_Rank,
--dense_rank() over (PARTITION BY AFirstname,Alastname,Adob order by AMasterMemberID) as rowid_DenseRank
from #TDuplicate 
) a
where a.rowid_RowNumber =1

select distinct AFirstName, ALastname, ADOB, AMasterMemberID, BMasterMemberID, CMasterMemberID from #TDuplicate 
select * from master.members where MemberID in ( 8048119, 1430929, 6866854)



select * from elig.mstrEligBenefitData where insCarrierID = 267 and insHealthPlanId =2592 and IsActive =1 order by SSBCI

select top 5 MasterMemberID, insCarrierID, insHealthPlanID, SSBCI from elig.mstrEligBenefitData where insCarrierID = 267 and insHealthPlanId =2592 and IsActive =1 and SSBCI = 'N'
select NHMemberID from master.members where MemberID in (select top 5 MasterMemberID from elig.mstrEligBenefitData where insCarrierID = 267 and insHealthPlanId =2592 and IsActive =1 and SSBCI = 'N' and getdate() between BenefitStartDate and BenefitEndDate )

select top 5 MasterMemberID, insCarrierID, insHealthPlanID, SSBCI from elig.mstrEligBenefitData where insCarrierID = 267 and insHealthPlanId =2592 and IsActive =1 and SSBCI = 'Y'
select NHMemberID from master.members where MemberID in (select top 5 MasterMemberID from elig.mstrEligBenefitData where insCarrierID = 267 and insHealthPlanId =2592 and IsActive =1 and SSBCI = 'Y' and getdate() between BenefitStartDate and BenefitEndDate )


select * from master.members where MemberID in (7154192,7626815,2417754,2416906,2416420,2415913 ) 


select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID in (3232, 3233,3234)


select Top 5 * from elig.mstrEligBenefitData where insHealthPlanID = 3232 and IsActive = 1 and SSBCI = 'Y' union
select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3232 and IsActive = 1 and SSBCI = 'N' union

select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3233 and IsActive = 1 and SSBCI = 'Y' union
select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3233 and IsActive = 1 and SSBCI = 'N' union

select Top 5 * from elig.mstrEligBenefitData where insHealthPlanID = 3234 and IsActive = 1 and SSBCI = 'Y' union
select Top 5 * from elig.mstrEligBenefitData where insHealthPlanID = 3234 and IsActive = 1 and SSBCI = 'N' 

select * from elig.mstrEligBenefitData where SSBCI is not null and isActive =1 and insHealthPlanID in (3232, 3233, 3234)

select  * from elig.mstrEligBenefitData where insHealthPlanID = 3232 and IsActive = 1 and SSBCI is NUll
select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3232 and IsActive = 1 and SSBCI = 'N' union

select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3233 and IsActive = 1 and SSBCI = 'Y' union
select Top 5  * from elig.mstrEligBenefitData where insHealthPlanID = 3233 and IsActive = 1 and SSBCI = 'N' union

select Top 5 * from elig.mstrEligBenefitData where insHealthPlanID = 3234 and IsActive = 1 and SSBCI = 'Y' union
select Top 5 * from elig.mstrEligBenefitData where insHealthPlanID = 3234 and IsActive = 1 and SSBCI = 'N' 
 
select distinct SSBCI from elig.mstrEligBenefitData where insHealthPlanID = 3234 and IsActive = 1 and InsHealthPlanID in (3232, 3233,3234)


select NHMemberID

,json_value(orders.MemberData, '$.insCarrierId') as MemberData_firstName
,json_value(orders.MemberData, '$.insPlanId') as MemberData_lastName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName

from orders.orders where
json_value(orders.MemberData, '$.insCarrierId') = 267
and json_value(orders.MemberData, '$.insPlanId') = 2592
and OrderAmountData like '%VH02FIS22%'

select MemberID from master.Members where IsActive =1 and NHMemberID in 

(select NHMemberID
--,json_value(orders.MemberData, '$.insCarrierId') as MemberData_firstName
--,json_value(orders.MemberData, '$.insPlanId') as MemberData_lastName
--,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
from orders.orders where
json_value(orders.MemberData, '$.insCarrierId') = 267
and json_value(orders.MemberData, '$.insPlanId') = 2592
and OrderAmountData like '%VH02FIS22%'
)

-- Members in a Particular Carrier and Plan having a particular Wallet have orders
select * from elig.mstrEligBenefitData where MasterMemberID in 
(
	select MemberID from master.Members where IsActive =1 and NHMemberID in 
			(
			select NHMemberID, DateOrderReceived, DateOrderInitiated
			--,json_value(orders.MemberData, '$.insCarrierId') as MemberData_firstName
			--,json_value(orders.MemberData, '$.insPlanId') as MemberData_lastName
			--,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
			from orders.orders where
			json_value(orders.MemberData, '$.insCarrierId') = 267
			and json_value(orders.MemberData, '$.insPlanId') = 2592
			
			and OrderAmountData like '%VH02FIS22%' order by DateOrderInitiated
			)
)
and IsActive =1
and getdate() between BenefitStartDate and BenefitENdDate

/*All NHMemberID's that have an order for the Grocery Benefit and the walletID is 'VH02FIS22'
NH202002416600,NH202106946414,NH202107088986,NH202002419177,NH202002418909,NH202002415991,NH202002418329,NH202002418638,NH202002841899,
*/


select * from master.members where 
select * from elig.mstrEligBenefitData where MasterMemberID  = 2495734
select * from master.Members where memberID in (2495734, 2841793)




-- Ticket #  61812

select * from elig.mstrEligBenefitData where MasterMemberID in 
(
	select MemberID from master.Members where IsActive =1 and NHMemberID in 
			(
			select NHMemberID, DateOrderReceived, DateOrderInitiated
			,json_value(orders.MemberData, '$.insCarrierId') as MemberData_firstName
			,json_value(orders.MemberData, '$.insPlanId') as MemberData_lastName
			,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
			from orders.orders where
			json_value(orders.MemberData, '$.insCarrierId') = 302
			and json_value(orders.MemberData, '$.insPlanId') = 2692
			
			and OrderAmountData like '%AL02FIS22%'  order by DateOrderInitiated desc
			)
)
and IsActive =1
and getdate() between BenefitStartDate and BenefitENdDate

select NHMemberID from master.Members where MemberID in (5642267,5621766,5664270,5658369)



select * from elig.ClientCodes where ClientName like '%molina%'  -- carriers 380 and 400
select InsuranceCarrierID, InsuranceCarrierName, * from insurance.insuranceCarriers where InsuranceCarrierID in (380, 400, 138) or InsuranceCarrierName like '%molina%'
select InsuranceHealthPlanID, HealthPlanName, InsuranceCarrierID from insurance.InsuranceHealthPlans where insuranceCarrierID in (380, 400, 138)

select top 10 * from elig.mstrEligBenefitData

select top 10 * from otccatalog.ItemMaster where ItemName like '%catalog%'

select * from supplOrders.PlanItemsConfig where InsuranceCarrierID in (380, 400, 138)
select ItemMasterID, * from supplOrders.ItemMaster where ItemMasterID in (select ItemMasterID from supplOrders.PlanItemsConfig where InsuranceCarrierID in (380, 400, 138))


select top 10 * from SupplOrders.Orders where OrderType = 'OTC' and insuranceCarrierID in  (380, 400, 138)  
select top 10 * from SupplOrders.OrderItems where OrderID in (select OrderID from SupplOrders.Orders where OrderType = 'OTC' and insuranceCarrierID in  (380, 400, 138)  )
select top 10 * from SupplOrders.ItemMaster 



 -- Ticket # 57353 | Molina catalog request for the month of January
IF OBJECT_ID('tempdb..#TCatalogs') IS NOT NULL DROP TABLE #TCatalogs 
select * into #TCatalogs from (
select distinct
oi.IsActive OrderItems_IsActive, o.IsActive as Orders_IsActive, ins.IsActive as Insurance_IsActive, ihp.IsActive as HealthPlans_IsActive, im.IsActive as ItemMaster_IsActive

,'SuppleOrders.OrderItems' as OrderItems_TableName, oi.OrderItemID, oi.OrderID as OrderItem_OrderID, oi.ItemCode as OrderItems_ItemCode, oi.Price, oi.Quantity  -- SupplOrders.OrderItems

,'SuppleOrders.Orders' as Orders_TableName, o.OrderID as Orders_OrderID, o.NHMemberID as Orders_NHMemberID, o.InsuranceCarrierID as Orders_InsuranceCarrierID, o.InsuranceHealthPlanID as Orders_InsuranceHealthPlanID, o.OrderType, o.Amount, o.Status  --SupplOrders.Orders

,Upper(JSON_VALUE(o.ShippingAddress,'$.firstName')) Ship_FirstName
,Upper(JSON_VALUE(o.ShippingAddress,'$.lastName')) Ship_LastName
,JSON_VALUE(o.ShippingAddress,'$.phoneNumber') Ship_PhoneNumber
,JSON_VALUE(o.ShippingAddress,'$.address.addressType') Ship_AddressType
,Upper(JSON_VALUE(o.ShippingAddress,'$.address.address1')) Ship_Address1
,Upper(JSON_VALUE(o.ShippingAddress,'$.address.address2')) Ship_Address2
--,JSON_VALUE(o.ShippingAddress,'$.address.address1') Ship_Address1
--,JSON_VALUE(o.ShippingAddress,'$.address.address2') Ship_Address2
,upper(JSON_VALUE(o.ShippingAddress,'$.address.city')) Ship_City
,upper(JSON_VALUE(o.ShippingAddress,'$.address.state')) Ship_State
,JSON_VALUE(o.ShippingAddress,'$.address.zipCode') Ship_ZipCode
, o.CreateDate
, o.ModifyDate

,'Insurance.InsuranceCarriers' as InsuranceCarriers_TableName, ins.InsuranceCarrierID, ins.InsuranceCarrierName  -- Insurance.InsuranceCarriers
,'Insurance.InsuranceHealthPlans' as InsuranceHealthPlans_TableName, ihp.InsuranceHealthPlanID, ihp.HealthPlanName  -- Insurance.InsuranceHealthPlans
,'SupplOrders.ItemMaster' as ItemMaster_TableName, im.ItemMasterID, im.ItemCode, im.ItemDisplayName, im.ItemDescription, im.ItemType-- SupplOrders.ItemMaster

from 
SupplOrders.orderItems oi 
left join SupplOrders.Orders o on oi.OrderID = o.OrderID
left join Insurance.InsuranceCarriers Ins on  o.InsuranceCarrierID = Ins.InsuranceCarrierID
left Join Insurance.InsuranceHealthPlans Ihp on o.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
left join SupplOrders.ItemMaster im on oi.ItemCode = im.ItemCode
where 1=1
and ins.insuranceCarrierID in  (380, 400, 138)
and o.CreateDate between '01-01-2022' and '02-01-2022'   --'01-31-2022' -- All catalogs that were shipped and requested during the month of January
--Order by o.CreateDate desc
) a


select OrderITem_OrderID, count(*) as RecordCount from #TCatalogs group by OrderITem_OrderID having count(*) > 1 order by 2 desc -- zero records returned

select * from #TCatalogs where status = 'Shipped'
select * from #TCatalogs where status = 'Requested'

IF OBJECT_ID('tempdb..#TeligMember') IS NOT NULL DROP TABLE #TeligMember
select * into #TeligMember from (
select m.MemberID, m.NHMemberID, e.subscriberID, e.MasterMemberID, e.BenefitStartDate, e.BenefitEndDate, e.InsCarrierID, e.insHealthPlanID, e.FirstName, e.LastName, e.dob, e.Address1, e.Address2, e.city, e.ZipCode
,row_number() over ( partition by SubscriberID, MasterMemberID, NHMemberID, InsCarrierID, insHealthPlanID order by SubscriberID, MasterMemberID, NHMemberID, InsCarrierID, insHealthPlanID ) as rowid
from elig.mstrEligBenefitData e join master.Members m
on e.MasterMemberID = m.MemberID
where insCarrierID in (380, 400, 138) and m.IsActive = 1 and e.isActive = 1 and Cast('01-01-2022' as Date)  between BenefitStartDate and BenefitEndDate and  Cast('01-31-2022' as Date)  between BenefitStartDate and BenefitEndDate
) a
where a.rowid = 1

/*
select NHMemberID, insHealthPlanID, count(*) as RecordCount from #TeligMember group by NHMemberID, insHealthPlanID having count(*) > 1
select * from #TeligMember where rowid = 2
select * from #TeligMember where NHMemberID = 'NH202209136616'
*/

IF OBJECT_ID('tempdb..#TCatalogsElig') IS NOT NULL DROP TABLE #TCatalogsElig
select * into #TCatalogsElig from (
select a.*, b.* from
#TCatalogs a join #TeligMember b on (a.Orders_NHMemberID = b.NHMemberID and a.InsuranceCarrierID = b.insCarrierID and a.InsuranceHealthPlanID = b.insHealthPlanID)
) a

select * from #TCatalogsElig



select 
 Cast(CreateDate as Date) as DateOfRequest
,Status
,SubscriberID,  Orders_NHMemberID as NHMemberID 
,Orders_InsuranceCarrierID as InsuranceCarrierID, InsuranceCarrierName,  Orders_InsuranceHealthPlanID as InsuranceHealthPlanID, HealthPlanName as InsuranceHealthPlanName 
,OrderItems_ItemCode as ItemCode, ItemDisplayName, ItemDescription, ItemType
,BenefitStartDate, BenefitEndDate,  
Ship_FirstName as FirstName, Ship_LastName as LastName, Ship_AddressType as AddressType, Ship_Address1 as Address1, Ship_Address2 as Address2, Ship_City as City, Ship_State as State, Ship_ZipCode as ZipCode
from #TCatalogsElig order by Status


 -- Ticket # 57353 | Molina catalog request for the month of January



 select * from sys.tables order by create_date desc
 select * from sys.all_columns


 select * from information_schema.columns where column_name like 'OptedInDate'
select * from sys.columns where name like '%opt%in%'

 select distinct table_name from information_schema.columns where table_schema like 'temp2021'

select * from temp2021.CapBlueVibraGrocery
select * from temp2021.capblue_grocery_opt_in_ontime
select * from temp2021.vibra_grocery_onetime


select distinct column_name from information_schema.columns where DATA_TYPE in ('date', 'timestamp') and column_name like '%%' 


SELECT DISTINCT
o.OrderId
,CAST(OrderDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) OrderCreatedDate
,o.NHMemberId,o.InsuranceCarrierID,ic.InsuranceCarrierName, o.InsuranceHealthPlanID, hp.HealthPlanName
,JSON_VALUE(o.ShippingAddress,'$.firstName') Ship_FirstName
,JSON_VALUE(o.ShippingAddress,'$.lastName') Ship_LastName
,JSON_VALUE(o.ShippingAddress,'$.phoneNumber') Ship_PhoneNumber
,JSON_VALUE(o.ShippingAddress,'$.address.addressType') Ship_AddressType
,JSON_VALUE(o.ShippingAddress,'$.address.address1') + ' ' + JSON_VALUE(o.ShippingAddress,'$.address.address2') Ship_Address1
--,JSON_VALUE(o.ShippingAddress,'$.address.address1') Ship_Address1
--,JSON_VALUE(o.ShippingAddress,'$.address.address2') Ship_Address2
,JSON_VALUE(o.ShippingAddress,'$.address.city') Ship_City
,JSON_VALUE(o.ShippingAddress,'$.address.state') Ship_State
,JSON_VALUE(o.ShippingAddress,'$.address.zipCode') Ship_ZipCode
,o.[Status],o.OrderType
-- Include HA Battery size and count
,CASE WHEN oi.ItemCode = 'BATTERY' AND oi.ItemType = 'HA' THEN oi.ItemCode + ' ' + JSON_VALUE(oi.ItemAttributesValueData,'$.Size') + ' ' + CAST(oi.Quantity AS VARCHAR(10)) + ' Ct'
		ELSE oi.ItemCode 
		END ItemCode
,oi.Quantity
-- Include HA Battery size and count
,CASE WHEN oi.ItemCode = 'BATTERY' AND oi.ItemType = 'HA' THEN im.ItemDescription + ' ' + JSON_VALUE(oi.ItemAttributesValueData,'$.Size') + ' ' + CAST(oi.Quantity AS VARCHAR(10)) + ' Ct'
		ELSE im.ItemDescription 
		END CatalogName
--,JSON_VALUE(oi.ItemAttributesValueData,'$.Size') BatterySize
--,JSON_VALUE(oi.ItemAttributesValueData,'$.NationsId') Item_NationsId
--,JSON_VALUE(oi.ItemAttributesValueData,'$."Reason for request"') [ReasonForRequest]
--,shi.TrackingNumber, shi.ShipDate
,RANK() OVER (PARTITION BY o.OrderId ORDER BY oi.OrderItemId) OrderItemRank
FROM SupplOrders.Orders o WITH (NOLOCK)
JOIN SupplOrders.OrderItems oi WITH (NOLOCK) ON oi.OrderId = o.OrderId and oi.IsActive = 1
LEFT JOIN SupplOrders.ItemMaster im WITH (NOLOCK) ON im.ItemCode = oi.ItemCode

LEFT JOIN Insurance.InsuranceCarriers ic WITH (NOLOCK) ON ic.InsuranceCarrierID = o.InsuranceCarrierID
LEFT JOIN Insurance.InsuranceHealthPlans hp WITH (NOLOCK) ON hp.InsuranceHealthPlanID = o.InsuranceHealthPlanID
WHERE 1=1
AND (      
			(o.OrderType = 'OTC') -- OTC catalog items
			OR 
			(oi.ItemType = 'HA' AND oi.ItemCode = 'BATTERY') -- HA Battery
	) 
AND o.OrderType NOT IN ('PERS')
AND o.Status NOT IN ('Shipped','Cancel','Declined') -- Exclude shipped orders
AND o.IsActive = 1
AND JSON_VALUE(o.ShippingAddress,'$.firstName') NOT IN ('Mohan','test')
--AND shi.TrackingNumber IS NULL -- Exclude orders that are already shipped
AND CAST(OrderDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) > '20210518' -- Orders created starting May 2021






/*
Ticket # 61837
NH number:   NH202107219160
Member Name:  MARY GOSS RAYFORD 
Member ID:   8000880215078
DOB:  Jul 26, 1958
Health Plan:  Molina Medicare Complete Care (HMO D-SNP) OH H8176-002
The Issue:  member wanted to place  an order for an English catalog. In the Crm under the member the only  option is for a Spanish one.
The fix:  option for English catalog.

*/

select * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in (380)
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID in ( 4026 ) 
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID in ( 380)

select * from [supplOrders].[PlanItemsConfig] where InsuranceCarrierID in ( 380) and insuranceHealthPlanID in ( 4026 ) 
select * from supplOrders.ItemMaster where ItemMasterId = 313
select * from supplOrders.ItemMaster where ItemCode like '%Molina%' and ItemDisplayName not like '%Spanish%'
select * from supplOrders.ItemMaster where ItemMasterID = 306
*/

insert into [supplOrders].[PlanItemsConfig] (ItemMasterID, InsuranceCarrierID, InsuranceHealthPlanID, Isactive, CreateDate, ModifyDate) values (306, 380, 4026, 1, Getdate(), getdate())

select * from [supplOrders].[PlanItemsConfig] where PlanItemsConfigID = 80
update [supplOrders].[PlanItemsConfig] set isActive = 1 where PlanItemsConfigID = 80




/*
Ticket #  61967 | Remove QMB Status
We remove the member from QMB status by assigning the NHMemberID to a different default ID ( 'NH202002615437' | Raj)

select * from master.QMBMembers where NHMemberID = 'NH202209797804' order by CreateDate Desc
select id, insuranceNbr, NHMemberID, * from master.QMBMembers where NHMemberID in ('NH202209797804')
select * from master.QMBMembers where NHMemberID = 'NH202002615437' order by CreateDate Desc -- The ID belongs to Raj by default
*/

update master.QMBMembers set InsuranceNbr = '101507114700A',   -- InsuranceNbr
NHMemberID = 'NH202002615437'   -- Raj's ID always
-- select * from master.QMBMembers
where id in (656967)
and NHMemberID = 'NH202209797804' -- To Member to Remove

-- Script to create the update statement
declare @NHMemberID nvarchar(20) = 'NH202209797804'

select
'update master.QMBMembers set InsuranceNbr = '  +''''+Cast(InsuranceNbr as nvarchar)+'A'+''''+' , '+ 'NHMemberID = ' + ''''+'NH202002615437' +''''+ ' where id in ( '+ Cast(ID as nvarchar) +' )'+ ' and NHMemberID = ' + ''''+@NHMemberID+''''
from master.QMBMembers where NHMemberID = @NHMemberID




-- Request from Raj
Hi Santosh,Need  the following information.
For VIVA we need Orders shipped to a different address than the latest mailing/perm address at the time of placing the order on eligibility file.
-- Request from Raj

select * from elig.ClientCodes where ClientName like '%viva%'
ClientCode	ClientName		DataSource		InsuranceCarrierID
H496		VIVA Health		ELIG_VIVA		394


select * from insurance.insuranceCarriers where InsuranceCarrierName like '%viva%'
select * from insurance.insurancehealthplans where InsuranceCarrierID = '394'
--(4124,4125,4126,4127,4128,4129,4130,4131,4132,4133)

select top 10 * from orders.Orders

select * from elig.mstrEligBenefitData where datasource = 'ELIG_VIVA' or inscarrierID = 394
select (ltrim(rtrim(address1)) +' | ' + ltrim(rtrim(address2)) +' | ' + ltrim(rtrim(city))) as Address, Count(*) as RecordCount from elig.mstrEligBenefitData where inscarrierID = 394 group by (ltrim(rtrim(address1)) +' | ' + ltrim(rtrim(address2)) +' | ' + ltrim(rtrim(city))) order by 2 desc

select * from elig.mstrEligBenefitData where Address1 = '3309 STONYBROOK LN' and inscarrierID = 394


select IsActive, DataSource, SubscriberID, GroupNbr, BenefitStartDate, BenefitStartDate, AlternateID, MedicareID, ContractNbr, PBPID, LineOfBusiness, NHLinkID, MasterMemberID, insCarrierID, insHealthPlanID, FirstName, MiddleInitial,Address1, Address2, City, State, Zipcode,  LastName, DOB, RecordEffDate, RecordEnddate, CreateDate, ModifyDate from elig.mstrEligBenefitData where InsCarrierID = '394'

select MedicareID, count(*) as RecordCount from elig.mstrEligBenefitData where InsCarrierID = '394' group by MedicareID order by 2 desc

select IsActive, DataSource, SubscriberID, GroupNbr, BenefitStartDate, BenefitStartDate, AlternateID, MedicareID, ContractNbr, PBPID, LineOfBusiness, NHLinkID, MasterMemberID, insCarrierID, insHealthPlanID, FirstName, MiddleInitial,Address1, Address2, City, State, Zipcode,  LastName, DOB, RecordEffDate, RecordEnddate, CreateDate, ModifyDate 
from elig.mstrEligBenefitData where InsCarrierID = '394'
and MedicareID = '4HG6R09NM43'

select distinct (ltrim(rtrim(address1)) +' | ' + ltrim(rtrim(address2)) +' | ' + ltrim(rtrim(city))) as Address
from elig.mstrEligBenefitData where InsCarrierID = '394'  -- 48272

select (ltrim(rtrim(address1)) +' | ' + ltrim(rtrim(address2)) +' | ' + ltrim(rtrim(city))) as Address
from elig.mstrEligBenefitData where InsCarrierID = '394'  -- 68268


drop table #TEligMaster
select * into #TEligMaster from (
select a.NHmemberID, a.IsActive as Member_IsActive, b.IsActive as elig_IsActive, b.DataSource, b.SubscriberID, b.GroupNbr, b.BenefitStartDate, b.BenefitEndDate, b.AlternateID, b.MedicareID, b.ContractNbr, b.PBPID, b.LineOfBusiness, b.NHLinkID, b.MasterMemberID, b.insCarrierID, b.insHealthPlanID, b.FirstName, b.MiddleInitial,b.Address1, b.Address2, b.City, b.State, b.Zipcode,  b.LastName, b.DOB, b.RecordEffDate, b.RecordEnddate, b.CreateDate, b.ModifyDate 
from elig.mstrEligBenefitData b left join master.Members a on a.MemberID = MasterMemberID 
where a.IsActive = 1  and b.InsCarrierID = '394'
) a 

select * from #TEligMaster

drop table 
select * from orders.orders where NHMemberID in (select distinct NHmemberID from #TEligMaster) and SpecialInstructions not like '%Voucher%added%'


drop table #TOrders
select * into #TOrders from (
select 
'Orders.Orders' as TableName
--*, -- all columns
 ,NHMemberID
 ,OrderID
 ,DateOrderReceived
 ,DateOrderInitiated
 ,CreateDate,ModifyDate
--MemberData

,MemberData
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName 
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber 
,json_value(orders.MemberData, '$.dob') as MemberData_dob

--MemberData | address
,json_value(orders.MemberData, '$.address.address') as MemberData_address
,json_value(orders.MemberData, '$.address.city') as MemberData_city
,json_value(orders.MemberData, '$.address.state') as MemberData_state 
,json_value(orders.MemberData, '$.address.zip') as MemberData_zip


--MemberData | insurance
,json_value(orders.MemberData, '$.insurance.carrierName') as MemberData_carrierName
,json_value(orders.MemberData, '$.insurance.planName') as MemberData_planName
,json_value(orders.MemberData, '$.insurance.programeName') as MemberData_programeName
,json_value(orders.MemberData, '$.insurance.insuranceMemberId') as MemberData_insuranceMemberId
,json_value(orders.MemberData, '$.insurance.nhMemberId') as MemberData_nhMemberId
,json_value(orders.MemberData, '$.insurance.insuranceBenefit') as MemberData_insuranceBenefit
,json_value(orders.MemberData, '$.insurance.benefitUsed') as MemberData_benefitUsed
,json_value(orders.MemberData, '$.insurance.lastBenefitUsedDate') as MemberData_lastBenefitUsedDate
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId


--OrderAmountData
,OrderAmountData
,json_value(orders.OrderAmountData, '$.productPrice') as OrderAmountData_productPrice
,json_value(orders.OrderAmountData, '$.insuranceBenefit') as OrderAmountData_insuranceBenefit
,json_value(orders.OrderAmountData, '$.benefitUsed') as OrderAmountData_benefitUsed
,json_value(orders.OrderAmountData, '$.benefitAvailable') as OrderAmountData_benefitAvailable
,json_value(orders.OrderAmountData, '$.memberResponsibility') as OrderAmountData_memberResponsibility
,json_value(orders.OrderAmountData, '$.itemcode') as OrderAmountData_itemcode
,json_value(orders.OrderAmountData, '$.vsPrice') as OrderAmountData_vsPrice
,json_value(orders.OrderAmountData, '$.vsTechLevel') as OrderAmountData_vsTechLevel

,'OTC_OrderAmountData' as OTC_LineOfBusiness
,json_value(orders.OrderAmountData, '$.price') as OrderAmountData_price
,json_value(orders.OrderAmountData, '$.amountCovered') as OrderAmountData_amountCovered
,json_value(orders.OrderAmountData, '$.outOfPocket') as OrderAmountData_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions0_catalogName0
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].originalWalletCode') as OrderAmountData_benefitTransactions0_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].benefitType') as OrderAmountData_benefitTransactions0_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].acctLast4Digits') as OrderAmountData_benefitTransactions0_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountCovered') as OrderAmountData_benefitTransactions0_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountRemaining') as OrderAmountData_benefitTransactions0_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].transactionId') as OrderAmountData_benefitTransactions0_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].outOfPocket') as OrderAmountData_benefitTransactions0_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].source') as OrderAmountData_benefitTransactions0_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].emiData') as OrderAmountData_benefitTransactions0_emiData
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions1_catalogName1
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].catalogName') as OrderAmountData_benefitTransactions1_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].originalWalletCode') as OrderAmountData_benefitTransactions1_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].benefitType') as OrderAmountData_benefitTransactions1_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].acctLast4Digits') as OrderAmountData_benefitTransactions1_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountCovered') as OrderAmountData_benefitTransactions1_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountRemaining') as OrderAmountData_benefitTransactions1_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].transactionId') as OrderAmountData_benefitTransactions1_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].outOfPocket') as OrderAmountData_benefitTransactions1_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].source') as OrderAmountData_benefitTransactions1_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].emiData') as OrderAmountData_benefitTransactions1_emiData



--ShippingData
,ShippingData
,json_value(orders.ShippingData, '$.providerBusinessName') as ShippingData_providerBusinessName
,json_value(orders.ShippingData, '$.dispenser') as ShippingData_dispenser
,json_value(orders.ShippingData, '$.dba') as ShippingData_dba -- What is this column used for?

--ShippingData | address
,json_value(orders.ShippingData, '$.address.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address2

,json_value(orders.ShippingData, '$.address.city') as ShippingData_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_zip
,json_value(orders.ShippingData, '$.address.country') as ShippingData_country

,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_shippingInstructions
,json_value(orders.ShippingData, '$.manufacturer') as ShippingData_manufacturer
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.faxNumber') as ShippingData_faxNumber




,'OTC_ShippingData' as OTC_LineOfBusiness_ShippingData
--ShippingData | address


,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
--,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
--,json_value(orders.ShippingData, '$.email') as ShippingData_email
--,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address_address2
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address_zip
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address_county
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address_country
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_address_shippingInstructions
,json_value(orders.ShippingData, '$.verifyShippingAddress') as ShippingData_address_verifyShippingAddress


--ProviderData
--dba (doing business as)
,ProviderData
,json_value(orders.ProviderData, '$.providerLeagalBusinessName') as ProviderData_providerLeagalBusinessName
,json_value(orders.ProviderData, '$.dba') as ProviderData_dba
,json_value(orders.ProviderData, '$.dispenser') as ProviderData_dispenser
,json_value(orders.ProviderData, '$.emailId') as ProviderData_emailId

--ProviderData | address
,json_value(orders.ProviderData, '$.address.address') as ProviderData_address_address
,json_value(orders.ProviderData, '$.address.address1') as ProviderData_address_address1
,json_value(orders.ProviderData, '$.address.city') as ProviderData_address_city
,json_value(orders.ProviderData, '$.address.state') as ProviderData_address_state
,json_value(orders.ProviderData, '$.address.zip') as ProviderData_address_zip
,json_value(orders.ProviderData, '$.address.locationId') as ProviderData_address_locationId


--ProviderData | hcp
,json_value(orders.ProviderData, '$.hcp.firstName') as ProviderData_hcp_firstName
,json_value(orders.ProviderData, '$.hcp.lastName') as ProviderData_hcp_lastName
,json_value(orders.ProviderData, '$.hcp.npiNumber') as ProviderData_hcp_npinumber
,json_value(orders.ProviderData, '$.hcp.phoneNumber') as ProviderData_hcp_phoneNumber
,json_value(orders.ProviderData, '$.hcp.hcpid') as ProviderData_hcp_hcpid
,json_value(orders.ProviderData, '$.hcp.faxNumber') as ProviderData_hcp_faxNumber
,json_value(orders.ProviderData, '$.providerId') as ProviderData_providerId



-- BenefitsData
,json_value(orders.BenefitsData, '$.applied.benefitsLeft') as BenefitsData_applied_benefitsLeft
,json_value(orders.BenefitsData, '$.applied.benefitsRight') as BenefitsData_applied_benefitsRight
,json_value(orders.BenefitsData, '$.eligible.benefitsLeft') as BenefitsData_eligible_benefitsLeft
,json_value(orders.BenefitsData, '$.eligible.benefitsRight') as BenefitsData_eligible_benefitsRight
,json_value(orders.BenefitsData, '$.used.benefitsLeft') as BenefitsData_used_benefitsLeft
,json_value(orders.BenefitsData, '$.used.benefitsRight') as BenefitsData_used_benefitsRight
,json_value(orders.BenefitsData, '$.available.benefitsLeft') as BenefitsData_available_benefitsLeft
,json_value(orders.BenefitsData, '$.available.benefitsRight') as BenefitsData_available_benefitsRight
,json_value(orders.BenefitsData, '$.remaining.benefitsLeft') as BenefitsData_remaining_benefitsLeft
,json_value(orders.BenefitsData, '$.remaining.benefitsRight') as BenefitsData_remaining_benefitsRight
,json_value(orders.BenefitsData, '$.benefitAppliedAmount') as BenefitsData_benefitAppliedAmount
,json_value(orders.BenefitsData, '$.outOfPocket') as BenefitsData_outOfPocket
,json_value(orders.BenefitsData, '$.bencat') as BenefitsData_bencat
,json_value(orders.BenefitsData, '$.technologyLevel') as BenefitsData_technologyLevel
,json_value(orders.BenefitsData, '$.benfortype') as BenefitsData_benfortype
,json_value(orders.BenefitsData, '$.terminationDate') as BenefitsData_terminationDate
,json_value(orders.BenefitsData, '$.benfreqtype') as BenefitsData_benfreqtype



,json_value(orders.BenefitsData, '$.applied.devicesCount') as BenefitsData_applied_devicesCount
,json_value(orders.BenefitsData, '$.eligible.devicesCount') as BenefitsData_eligible_devicesCount
,json_value(orders.BenefitsData, '$.used.devicesCount') as BenefitsData_used_devicesCount
,json_value(orders.BenefitsData, '$.available.devicesCount') as BenefitsData_available_devicesCount
,json_value(orders.BenefitsData, '$.remaining.devicesCount') as BenefitsData_remaining_devicesCount



from orders.orders where NHMemberID in (select distinct NHmemberID from #TEligMaster) and SpecialInstructions not like '%Voucher%added%'
) a

select * from #TOrders


select
  o.NHMemberID
 ,o.Orderid
 ,o.CreateDate as OrderCreateDate
 ,o.ModifyDate as OrderModifyDate
 ,o.DateOrderInitiated
 ,o.DateOrderReceived
 ,b.RecordEffDate, b.RecordEnddate, b.CreateDate, b.ModifyDate
 ,b.SubscriberID, b.BenefitStartDate, b.BenefitEndDate, b.FirstName, b.LastName
 
 ,'Member Address at time of Order' as AddressAtOrder
--,MemberData_address
,rtrim (ltrim(replace(o.MemberData_address, ',',''))) as MemberData_addressNew
,rtrim (ltrim(o.MemberData_city)) as MemberData_city
,rtrim (ltrim(o.MemberData_state)) as MemberData_state
,rtrim (ltrim(o.MemberData_zip)) as MemberData_zip

,b.Address1, b.Address2, b.City, b.State, b.ZipCode

,o.ShippingData_address
,rtrim (ltrim(replace(o.ShippingData_address1, ',',''))) as ShippingData_address1
,rtrim (ltrim(replace(o.ShippingData_address2, ',',''))) as ShippingData_address2
,rtrim (ltrim(o.ShippingData_city)) as ShippingData_City
,rtrim (ltrim(o.ShippingData_state)) as ShippingData_State
,rtrim (ltrim(o.ShippingData_zip)) as ShippingData_ZipCode

--elig and Member Address


from  #TOrders o join #TEligMaster b on b.NHMemberID = o.NHMemberID 
where o.DateOrderReceived between RecordEffDate and RecordEndDate

--and o.NHMemberID = 'NH202107443798'
order by o.NHMemberID


select * from #TEligMaster where NHmemberID in (select distinct NHMemberID from #TOrders)

select * from orders.orders where ordertype = 'NEW' and status = 'Cancelled'

select * from orders.orders where orderid = 180015047
select * from orders.orderItems where orderid = 180015047
select * from orders.OrderTransactionDetails where orderid = 180015047
select * from orders.orderPOs where orderid =  180015047

/*
# 62720
Good morning,
RE: NH202005003637
I am unable to cancel the following DHE orders due to receiving a red, circle cursor when trying to click the “Cancel Order” tab. Can this please be investigated, as well as order# 202482514 and 202482520 both be canceled?
Below are screen shots of the orders.
*/

select * from orders.orders where orderid = 202482514 
select * from orders.orderItems where orderid = 202482514 
select * from orders.OrderTransactionDetails where orderid = 202482514 
select * from orders.orderPOs where orderid =  202482514 

select * from orders.orders where orderid = 202482520
select * from orders.orderItems where orderid = 202482520
select * from orders.OrderTransactionDetails where orderid = 202482520
select * from orders.orderPOs where orderid =  202482520


-- OrderID |  202482514
update orders.orders set Status = 'CANCELLED' where OrderID = 202482514
update orders.orders set OrderStatusCode = 'CAN' where OrderID = 202482514
update orders.orders set IsActive = 0 where OrderID = 202482514
update orders.OrderItems set Status = 'CANCELLED' where OrderID = 202482514


-- OrderID | 202482520
update orders.orders set Status = 'CANCELLED' where OrderID = 202482520
update orders.orders set Status = 'CAN' where OrderID = 202482520
update orders.orders set IsActive = 0 where OrderID = 202482520
update orders.OrderItems set Status = 'CANCELLED' where OrderID = 202482520





select top 100 * from elig.mstrEligBenefitData where datasource = 'ELIG_UAWT'
select * from provider.MemberProfiles where NHMemberID  = 'NH202108295859'
update provider.MemberProfiles set LastName = 'BELLENGER' where MemberProfileID = '740677'
select * from elig.ClientCodes where DataSource = 'ELIG_CCARE'


select top 10 * from elig.filetrack where directionCode = 'in' and DataSource = 'ELIG_CCARE' order by CreateDate desc
select * from elig.stgEligBenefitDataHist where 1=1
--and FileTrackID in (52214,51642) 
and SubscriberID in ('90003667701')
order by FileTrackID



--H426

select top 10 * from elig.stgEligBenefitDataHist where DataSource = 'ELIG_CCARE' and SubscriberID in ('K4034950001', 'K4034752801') order by ArchiveDate Desc
select top 10 * from elig.stgEligBenefitData where DataSource = 'ELIG_CCARE' and SubscriberID in ('K4034950001', 'K4034752801')

select * from elig.FileTrack where DataSource in ( select datasource from elig.ClientCodes where ClientName like '%Connect%'  ) and ClientCode = 'H426' order by DateReceived Desc


select * from elig.clientCodes where ClientCode = 'H426'
select * from elig.FileInfo where ClientCode = 'H426' and direction = 'IN' order by FileInfoID desc
select * from elig.FileTrack where ClientCode = 'H426' and FileTrackID = 52752
select * from elig.stgEligBenefitData where FileTrackID  = 52752 and SubscriberID in ('K4034950001', 'K4034752801')
select * from elig.stgEligBenefitDataHist where FileTrackID = 52752
select * from elig.rawEligBenefitData where FileTrackID = 52752
select * from elig.errEligBenefitData where FileTrackID = 52752 and SubscriberID in ('K4034950001', 'K4034752801')

select * from elig.ClientCodes where ClientCode = 'H426'
select * from elig.FileTrack where FileTrackID = 52752
select * from elig.stgEligBenefitData where FileTrackID = 52752
select * from elig.stgEligBenefitDataHist where FileTrackID = 52752




select * from elig.clientCodes where ClientCode = 'H426'
select * from elig.FileInfo where ClientCode = 'H426' and direction = 'IN' order by FileInfoID desc
select * from elig.FileTrack where ClientCode = 'H426' and FileTrackID = 52752
select * from elig.stgEligBenefitData where FileTrackID  = 52752 and SubscriberID in ('K4034950001', 'K4034752801')
select * from elig.stgEligBenefitDataHist where FileTrackID = 52752
select * from elig.rawEligBenefitData where FileTrackID = 52752
select * from elig.errEligBenefitData where SubscriberID in ('K4034950001', 'K4034752801')
select FileTrackID, DataSource, RecordStatus, LastName, FirstName, DOB, SubscriberID, BenefitEndDate, CreateDate, ModifyDate from elig.errEligBenefitData where SubscriberID in ('K4034950001', 'K4034752801')

select * from elig.stgEligBenefitData where SubscriberID in ('K4034950001', 'K4034752801')
select * from elig.stgEligBenefitDataHist where SubscriberID in ('K4034950001', 'K4034752801')



select distinct InsuranceNbr from master.MemberInsuranceDetails where MemberInsuranceID in (select MemberInsuranceID from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID = 5312)


select a.NHMemberID, a.NHlinkID, b.InsuranceCarrierID,  b.InsuranceHealthPlanID,  c.InsuranceNbr,Len(ltrim(rtrim(c.InsuranceNbr))) as NoofDigits

from 
master.members a 
left join master.MemberInsurances b on a.MemberID = b.MemberID
left join master.MemberInsuranceDetails c on c.MemberInsuranceID = b.ID
where 1=1
and b.InsuranceCarrierID = 380 and b.InsuranceHealthPlanID = 5312
order by InsuranceHealthPlanID, Len(ltrim(rtrim(c.InsuranceNbr))), InsuranceNbr




/*
Ticket #  61967 | Remove QMB Status
We remove the member from QMB status by assigning the NHMemberID to a different default ID ( 'NH202002615437' | Raj)

select * from master.QMBMembers where NHMemberID = 'NH202209797804' order by CreateDate Desc
select id, insuranceNbr, NHMemberID, * from master.QMBMembers where NHMemberID in ('NH202209797804')
select * from master.QMBMembers where NHMemberID = 'NH202002615437' order by CreateDate Desc -- The ID belongs to Raj by default
*/

update master.QMBMembers set InsuranceNbr = '101507114700A',   -- InsuranceNbr
NHMemberID = 'NH202002615437'   -- Raj's ID always
-- select * from master.QMBMembers
where id in (656967)
and NHMemberID = 'NH202209797804' -- To Member to Remove

-- Script to create the update statement
declare @NHMemberID nvarchar(20) = 'NH202209797804'

select
'update master.QMBMembers set InsuranceNbr = '  +''''+Cast(InsuranceNbr as nvarchar)+'A'+''''+' , '+ 'NHMemberID = ' + ''''+'NH202002615437' +''''+ ' where id in ( '+ Cast(ID as nvarchar) +' )'+ ' and NHMemberID = ' + ''''+@NHMemberID+''''
from master.QMBMembers where NHMemberID = @NHMemberID


-- Script to create the update statement
declare @NHMemberID nvarchar(20) = 'NH202209797804'

select
'update master.QMBMembers set InsuranceNbr = '  +''''+Cast(InsuranceNbr as nvarchar)+'A'+''''+' , '+ 'NHMemberID = ' + ''''+'NH202002615437' +''''+ ' where id in ( '+ Cast(ID as nvarchar) +' )'+ ' and NHMemberID = ' + ''''+@NHMemberID+''''
from master.QMBMembers where NHMemberID = @NHMemberID





select * from insurance.insuranceCarriers where InsuranceCarrierID = 401

-- Ticket Alignment Member Funds Missing: PAUL BATTISTI - NH202210755133
CarrierID	HealthPlanID
302	2694

select SSBCI, * from elig.mstrEligBenefitData where insCarrierid = 302 and insHealthPlanID = 2694 and isActive =1 
select NhMemberID from master.members where MemberID =7345015

NH202210755133 -- Member that is investigated
NH202107345015 -- SSBCI flag is set to 'YES' has a $10 grocery


catalog.ItemMasterList
benefits.ContractMasterPriceList
benefits.ContractPriceRevisions
benefits.Presets
benefits.PresetRevisions
[benefits].[MasterRevisions]
[benefits].[TechnologyLevelContractRevisions]
[benefits].[ContractPriceRevisions]
[benefits].[MasterRevisions]
[benefits].[DispensingFeeContractRevisions] 
[benefits].[COGSContractRevisions]
[benefits].[MemberPriceContractRevisions]
[benefits].[DispensingFeeContractRevisions]
[catalog].[ItemMasterList]
[benefits].[MasterRevisions]

select top 10 * from catalog.ItemMasterList
select top 10 * from benefits.ContractMasterPriceList
select top 10 * from benefits.ContractPriceRevisions
select top 10 * from benefits.Presets
select top 10 * from benefits.PresetRevisions
select top 10 * from [benefits].[MasterRevisions]
select top 10 * from [benefits].[TechnologyLevelContractRevisions]
select top 10 * from [benefits].[ContractPriceRevisions]
select top 10 * from [benefits].[MasterRevisions]
select top 10 * from [benefits].[DispensingFeeContractRevisions] 
select top 10 * from [benefits].[COGSContractRevisions]
select top 10 * from [benefits].[MemberPriceContractRevisions]
select top 10 * from [benefits].[DispensingFeeContractRevisions]
select top 10 * from [catalog].[ItemMasterList]
select top 10 * from [benefits].[MasterRevisions]
select top 10 * from benefits.HealthPlanContractID

select * from information_schema.columns where column_name like '%healthplancontractid%' order by table_schema

select  * from insurance.HealthPlanContracts

select * from insurance.HealthPlanContracts where getdate() between EffectiveFromDate and EffectiveToDate order by InsuranceCarrierID, InsuranceHealthPlanID --
select distinct InsuranceCarrierID, InsuranceHealthPlanID from insurance.HealthPlanContracts where isActive = 1




-- Meals
select top 10 * from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and OrderStatusCode = 'SHI'

select 'Orders.Orders' as TableName, NHMemberID, OrderID, Source, Status, MemberData
,json_value(orders.MemberData, '$.MemberName') as MemberData_MemberName
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId
,json_value(orders.MemberData, '$.subdomain') as MemberData_subdomain
,json_value(orders.MemberData, '$.clientCarrierId') as MemberData_clientCarrierId
,json_value(orders.MemberData, '$.clientPlanId') as MemberData_clientPlanId
,json_value(orders.MemberData, '$.cardNumber') as MemberData_cardNumber
,json_value(orders.MemberData, '$.healthPlanCode') as MemberData_healthPlanCode
,json_value(orders.MemberData, '$.programCode') as MemberData_programCode
,json_value(orders.MemberData, '$.groupNumber') as MemberData_groupNumber
,json_value(orders.MemberData, '$.paymentConsent') as MemberData_paymentConsent
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.middleName') as MemberData_middleName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.address') as MemberData_address
,json_value(orders.MemberData, '$.address.address1') as MemberData_address1
,json_value(orders.MemberData, '$.address.address2') as MemberData_address1
,json_value(orders.MemberData, '$.address.city') as MemberData_address1
,json_value(orders.MemberData, '$.address.state') as MemberData_address1
,json_value(orders.MemberData, '$.address.zip') as MemberData_address1
,json_value(orders.MemberData, '$.address.county') as MemberData_address1
,json_value(orders.MemberData, '$.address.country') as MemberData_address1
,json_value(orders.MemberData, '$.address.phoneNumber') as MemberData_address1
,json_value(orders.MemberData, '$.insuranceNbr') as MemberData_insuranceNbr
,json_value(orders.MemberData, '$.dateOfBirth') as MemberData_dateOfBirth
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.nhMemberId') as MemberData_NHMemberId

,json_value(orders.ShippingData, '$.MemberName') as ShippingData_MemberName
,json_value(orders.ShippingData, '$.insCarrierId') as ShippingData_insCarrierId
,json_value(orders.ShippingData, '$.insPlanId') as ShippingData_insPlanId
,json_value(orders.ShippingData, '$.subdomain') as ShippingData_subdomain
,json_value(orders.ShippingData, '$.clientCarrierId') as ShippingData_clientCarrierId
,json_value(orders.ShippingData, '$.clientPlanId') as ShippingData_clientPlanId
,json_value(orders.ShippingData, '$.cardNumber') as ShippingData_cardNumber
,json_value(orders.ShippingData, '$.healthPlanCode') as ShippingData_healthPlanCode
,json_value(orders.ShippingData, '$.programCode') as ShippingData_programCode
,json_value(orders.ShippingData, '$.groupNumber') as ShippingData_groupNumber
,json_value(orders.ShippingData, '$.paymentConsent') as ShippingData_paymentConsent
,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.middleName') as ShippingData_middleName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.phoneNumber') as ShippingData_address1
,json_value(orders.ShippingData, '$.insuranceNbr') as ShippingData_insuranceNbr
,json_value(orders.ShippingData, '$.dateOfBirth') as ShippingData_dateOfBirth
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.nhMemberId') as ShippingData_NHMemberId

from Orders.orders
where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL'


select * from orders.orderItems where OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL')

select OrderID, ItemCode, Quantity, Amount, Status, UnitPrice, PairPrice, ItemType
,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName
,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.source') as ItemData_source
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.version') as ItemData_version

from Orders.OrderItems 
where ItemType = 'OTC' and IsActive =1 and OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL')


select * from orders.OrderTransactionDetails where orderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL')

select OrderID, OrderStatusCode, OrderTransactionData
,json_value(OrderTransactionDetails.OrderTransactionData, '$.fileName') as OrderTransactionData_fileName
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendEmail') as OrderTransactionData_SendEmail
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendSMS') as OrderTransactionData_SendSMS
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.profileLevelPreferences') as OrderTransactionData_profileLevelPreferences


,json_value(OrderTransactionDetails.OrderTransactionData, '$.OrderId') as OrderTransactionData_OrderID
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderGroupId') as OrderTransactionData_orderGroupId
,json_value(OrderTransactionDetails.OrderTransactionData, '$.expectedDeliveryDate') as OrderTransactionData_expectedDeliveryDate


,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderMealType') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealPreferece') as OrderTransactionData_mealPreferece


,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealCount') as OrderTransactionData_mealCount
,json_value(OrderTransactionDetails.OrderTransactionData, '$.logId') as OrderTransactionData_logID


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].carrier') as OrderTransactionData_carrier
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].serviceType') as OrderTransactionData_serviceType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderId') as OrderTransactionData_orderId


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingNumber') as OrderTransactionData_trackingNumber
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingUrl') as OrderTransactionData_trackingUrl
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shipDate') as OrderTransactionData_shipDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shippingCost') as OrderTransactionData_shippingCost


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].taxCost') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].itemNumber') as OrderTransactionData_ItemNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].trackingNumber') as OrderTransactionData_trackingNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].weight') as OrderTransactionData_weight_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].units') as OrderTransactionData_units_0

from orders.OrderTransactionDetails where OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and OrderID = 202322509)


select * from orders.OrderPOs where orderID in  (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and OrderID = 202322509)




IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002293375')  -- ticket #  58301 -- Under Review, Paula Campbell 

select a.*, b.* 
from master.members a left join elig.mstrEligBenefitData b
on a.MemberID= b.MasterMemberID
where 1=1
and a.IsActive = 1 and b.IsActive =1
and NHMemberID in (select NHMemberID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' ) 
and getdate() between b.benefitStartDate and b.BenefitEndDate
and NHMemberID in (select NhMemberID from #NHMemberIDTemp)




select 'Orders.Orders' as TableName, NHMemberID, OrderID, Source, Status, MemberData
,json_value(orders.MemberData, '$.MemberName') as MemberData_MemberName
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId
,json_value(orders.MemberData, '$.subdomain') as MemberData_subdomain
,json_value(orders.MemberData, '$.clientCarrierId') as MemberData_clientCarrierId
,json_value(orders.MemberData, '$.clientPlanId') as MemberData_clientPlanId
,json_value(orders.MemberData, '$.cardNumber') as MemberData_cardNumber
,json_value(orders.MemberData, '$.healthPlanCode') as MemberData_healthPlanCode
,json_value(orders.MemberData, '$.programCode') as MemberData_programCode
,json_value(orders.MemberData, '$.groupNumber') as MemberData_groupNumber
,json_value(orders.MemberData, '$.paymentConsent') as MemberData_paymentConsent
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.middleName') as MemberData_middleName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.address') as MemberData_address
,json_value(orders.MemberData, '$.address.address1') as MemberData_address1
,json_value(orders.MemberData, '$.address.address2') as MemberData_address1
,json_value(orders.MemberData, '$.address.city') as MemberData_address1
,json_value(orders.MemberData, '$.address.state') as MemberData_address1
,json_value(orders.MemberData, '$.address.zip') as MemberData_address1
,json_value(orders.MemberData, '$.address.county') as MemberData_address1
,json_value(orders.MemberData, '$.address.country') as MemberData_address1
,json_value(orders.MemberData, '$.address.phoneNumber') as MemberData_address1
,json_value(orders.MemberData, '$.insuranceNbr') as MemberData_insuranceNbr
,json_value(orders.MemberData, '$.dateOfBirth') as MemberData_dateOfBirth
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.nhMemberId') as MemberData_NHMemberId

,json_value(orders.ShippingData, '$.MemberName') as ShippingData_MemberName
,json_value(orders.ShippingData, '$.insCarrierId') as ShippingData_insCarrierId
,json_value(orders.ShippingData, '$.insPlanId') as ShippingData_insPlanId
,json_value(orders.ShippingData, '$.subdomain') as ShippingData_subdomain
,json_value(orders.ShippingData, '$.clientCarrierId') as ShippingData_clientCarrierId
,json_value(orders.ShippingData, '$.clientPlanId') as ShippingData_clientPlanId
,json_value(orders.ShippingData, '$.cardNumber') as ShippingData_cardNumber
,json_value(orders.ShippingData, '$.healthPlanCode') as ShippingData_healthPlanCode
,json_value(orders.ShippingData, '$.programCode') as ShippingData_programCode
,json_value(orders.ShippingData, '$.groupNumber') as ShippingData_groupNumber
,json_value(orders.ShippingData, '$.paymentConsent') as ShippingData_paymentConsent
,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.middleName') as ShippingData_middleName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.phoneNumber') as ShippingData_address1
,json_value(orders.ShippingData, '$.insuranceNbr') as ShippingData_insuranceNbr
,json_value(orders.ShippingData, '$.dateOfBirth') as ShippingData_dateOfBirth
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.nhMemberId') as ShippingData_NHMemberId

from Orders.orders
where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL'
and NHMemberID in (select NhMemberID from #NHMemberIDTemp)



select OrderID, ItemCode, Quantity, Amount, Status, UnitPrice, PairPrice, ItemType
,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName
,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.source') as ItemData_source
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.version') as ItemData_version

from Orders.OrderItems 
where ItemType = 'OTC' and IsActive =1 and OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp))





select OrderID, OrderStatusCode, OrderTransactionData
,json_value(OrderTransactionDetails.OrderTransactionData, '$.fileName') as OrderTransactionData_fileName
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendEmail') as OrderTransactionData_SendEmail
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendSMS') as OrderTransactionData_SendSMS
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.profileLevelPreferences') as OrderTransactionData_profileLevelPreferences


,json_value(OrderTransactionDetails.OrderTransactionData, '$.OrderId') as OrderTransactionData_OrderID
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderGroupId') as OrderTransactionData_orderGroupId
,json_value(OrderTransactionDetails.OrderTransactionData, '$.expectedDeliveryDate') as OrderTransactionData_expectedDeliveryDate


,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderMealType') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealPreferece') as OrderTransactionData_mealPreferece


,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealCount') as OrderTransactionData_mealCount
,json_value(OrderTransactionDetails.OrderTransactionData, '$.logId') as OrderTransactionData_logID


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].carrier') as OrderTransactionData_carrier
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].serviceType') as OrderTransactionData_serviceType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderId') as OrderTransactionData_orderId


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingNumber') as OrderTransactionData_trackingNumber
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingUrl') as OrderTransactionData_trackingUrl
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shipDate') as OrderTransactionData_shipDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shippingCost') as OrderTransactionData_shippingCost


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].taxCost') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].itemNumber') as OrderTransactionData_ItemNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].trackingNumber') as OrderTransactionData_trackingNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].weight') as OrderTransactionData_weight_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].units') as OrderTransactionData_units_0

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].itemNumber') as OrderTransactionData_ItemNumber_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].trackingNumber') as OrderTransactionData_trackingNumber_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].weight') as OrderTransactionData_weight_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].units') as OrderTransactionData_units_1


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].itemNumber') as OrderTransactionData_ItemNumber_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].trackingNumber') as OrderTransactionData_trackingNumber_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].weight') as OrderTransactionData_weight_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].units') as OrderTransactionData_units_2


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].itemNumber') as OrderTransactionData_ItemNumber_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].trackingNumber') as OrderTransactionData_trackingNumber_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].weight') as OrderTransactionData_weight_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].units') as OrderTransactionData_units_3


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].itemNumber') as OrderTransactionData_ItemNumber_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].trackingNumber') as OrderTransactionData_trackingNumber_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].weight') as OrderTransactionData_weight_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].units') as OrderTransactionData_units_4


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].itemNumber') as OrderTransactionData_ItemNumber_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].trackingNumber') as OrderTransactionData_trackingNumber_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].weight') as OrderTransactionData_weight_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].units') as OrderTransactionData_units_5


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].itemNumber') as OrderTransactionData_ItemNumber_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].trackingNumber') as OrderTransactionData_trackingNumber_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].weight') as OrderTransactionData_weight_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].units') as OrderTransactionData_units_6


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].itemNumber') as OrderTransactionData_ItemNumber_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].trackingNumber') as OrderTransactionData_trackingNumber_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].weight') as OrderTransactionData_weight_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].units') as OrderTransactionData_units_7


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].itemNumber') as OrderTransactionData_ItemNumber_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].trackingNumber') as OrderTransactionData_trackingNumber_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].weight') as OrderTransactionData_weight_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].units') as OrderTransactionData_units_8


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].itemNumber') as OrderTransactionData_ItemNumber_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].trackingNumber') as OrderTransactionData_trackingNumber_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].weight') as OrderTransactionData_weight_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].units') as OrderTransactionData_units_9


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].itemNumber') as OrderTransactionData_ItemNumber_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].trackingNumber') as OrderTransactionData_trackingNumber_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].weight') as OrderTransactionData_weight_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].units') as OrderTransactionData_units_10

from orders.OrderTransactionDetails where OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive = 1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp))


select * from elig.ClientCodes where datasource = 'ELIG_ALGN'

select * from elig.clientCodes where ClientCode = 'H462_IN'
select * from elig.FileInfo where ClientCode = 'H462_IN' and direction = 'IN' order by FileInfoID desc
select * from elig.FileTrack where ClientCode = 'H462_IN' -- and FileTrackID = 52752
select * from elig.stgEligBenefitData where SubscriberID in ('00053478301')
select * from elig.stgEligBenefitDataHist  where SubscriberID in ('00053478301')
select * from elig.errEligBenefitData where SubscriberID in ('00053478301')



select * from elig.rawEligBenefitData where FileTrackID = 52752
select * from elig.errEligBenefitData where SubscriberID in ('00053478301')

select * from flex.FISWalletMapping where carrierID = 302 and HealthPlanID = 2694


InsuranceCarrierName	InsuranceHealthPlanID
Alignment Health Plan	2694
select top 10 * from elig.BenefitCrossWalk where InsuranceCarrierID = 302 and InsuranceHealthPlanID = 2694


select * from member.MemberCards where InsuranceCarrierID = 302 and InsuranceHealthPlanID = 2694 and IsActive = 1 -- 9980 records

select a.NhMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID from master.members a join master.MemberInsurances b on a.MemberID = b.MemberID and b.InsuranceCarrierID = 302 and b.InsuranceHealthPlanID = 2694

select * from member.MemberCards 
where NHMemberID not in 

(
select a.NhMemberID from master.members a join master.MemberInsurances b on a.MemberID = b.MemberID left join elig.mstrEligBenefitData c on a.MemberID = c.MasterMemberID
where a.NHMemberID not in (select NHMemberID from member.MemberCards where InsuranceCarrierID = 302 and InsuranceHealthPlanID = 2694 and IsActive = 1)
--and NHMemberID in ('NH202210755133')
and b.InsuranceCarrierID = 302 and b.InsuranceHealthPlanID = 2694
and a.IsActive=1 and c.IsActive=1 and b.IsActive = 1 and getdate() between c.BenefitStartDate and c.BenefitEndDate
)
and InsuranceCarrierID = 302 and InsuranceHealthPlanID = 2694 and IsActive = 1 

select a.NhMemberID, c.SSBCI, c.* from master.members a join master.MemberInsurances b on a.MemberID = b.MemberID left join elig.mstrEligBenefitData c on a.MemberID = c.MasterMemberID
--where a.NHMemberID not in (select NHMemberID from member.MemberCards where InsuranceCarrierID = 302 and InsuranceHealthPlanID = 2694 and IsActive = 1)
--and NHMemberID in ('NH202210755133')

where b.InsuranceCarrierID = 302 and b.InsuranceHealthPlanID = 2694
and a.IsActive=1 and c.IsActive=1 and b.IsActive = 1 and getdate() between c.BenefitStartDate and c.BenefitEndDate
--and NHMemberID  in ('NH202210755133')
order by c.SSBCI



select * from elig.mstrEligBenefitData where subscriberID = '5008630100'
select NHMemberID from master.members where MemberID =7407703

select * from elig.mstrEligBenefitData where subscriberID = '00000208592'
select NHMemberID from master.members where MemberID =10747799

select * from elig.mstrEligBenefitData where subscriberID = '00000115537'
select NHMemberID from master.members where MemberID =5678797

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 /*
Dianne Coopers Requirements
	1. Find all duplicates for Alignment members, use FirstName, LastName,  DOB and SubscriberID for all accounts created by MEA's and in the Eligibility File
	2. Find All Alignment accounts where an IV is pending
	3. Find all insurances which are created by MEA's for all members in Alignment that are not present in the eligibility file.
*/


select * from elig.ClientCodes where clientname like '%alignment%'
select InsuranceCarrierID, InsuranceCarrierName, IsActive from Insurance.InsuranceCarriers where InsuranceCarrierName like '%align%'
select InsuranceCarrierID, InsuranceHealthPlanID, HealthPlanName from Insurance.InsuranceHealthPlans where InsuranceCarrierID in (Select InsuranceCarrierID from Insurance.InsuranceCarriers where InsuranceCarrierName like '%align%')

select InsuranceCarrierID, InsuranceCarrierName, IsActive from Insurance.InsuranceCarriers order by InsuranceCarrierName --(302, 379, 20) -- 302 is the only 
select InsuranceHealthPlanID from Insurance.InsuranceHealthPlans where InsuranceCarrierID =  302 -- All Alignment Hea

-- There are no triplicates for a member
select distinct
a.NHMemberID, a.FirstName, a.LastName, a.DateOfBirth,
b.NHMemberID, b.FirstName, b.LastName, b.DateOfBirth,
c.NHMemberID, c.FirstName, c.LastName, c.DateOfBirth,

row_number() over (partition by a.FirstName, a.LastName, a.DateOfBirth order by a.FirstName, a.LastName, a.DateOfBirth)
from master.members a 
join master.members b on a.FirstName = b.FirstName and a.LastName = b.LastName and a.DateOfBirth = b.DateOfBirth and a.NHMemberID <> b.NHMemberID
join master.members c on b.FirstName = c.FirstName and b.LastName = c.LastName and b.DateOfBirth = c.DateOfBirth and b.NHMemberID <> c.NHMemberID and a.NHmemberID <> c.NHmemberID
where 1=1
and a.IsActive = 1 and b.IsActive = 1 and c.IsActive =1
and a.NHMemberID in (
					   select NHmemberID from master.members 
					   where MemberID in ( 
											select MemberID from master.memberInsurances 
											where insuranceCarrierID in (302) and InsuranceHealthPlanID in (
																											select InsuranceHealthPlanID from insurance.InsuranceHealthPlans 
																											where insuranceCarrierID in (302)
																											)
										 )
					  )

and b.NHMemberID in (
					   select NHmemberID from master.members 
					   where MemberID in ( 
											select MemberID from master.memberInsurances 
											where insuranceCarrierID in (302) and InsuranceHealthPlanID in (
																											select InsuranceHealthPlanID from insurance.InsuranceHealthPlans 
																											where insuranceCarrierID in (302)
																											)
										 )
				)

and c.NHMemberID in (
					   select NHmemberID from master.members 
					   where MemberID in ( 
											select MemberID from master.memberInsurances 
											where insuranceCarrierID in (302) and InsuranceHealthPlanID in (
																											select InsuranceHealthPlanID from insurance.InsuranceHealthPlans 
																											where insuranceCarrierID in (302)
																											)
										 )
				)

order by a.FirstName, a.LastName, a.DateOfBirth


-- 1. No of Duplicates | All active and Inactive MemberID's that are duplicates

select * from 
(

		select distinct
		a.NHMemberID as A_NHMemberID, upper(a.FirstName) as A_FirstName, upper(a.LastName) as A_LastName, cast(a.DateOfBirth as date) as A_DateOfBirth, a.IsActive as A_IsActive,
		b.NHMemberID as B_NHMemberID, upper(b.FirstName) as B_FirstName, upper(b.LastName) as B_LastName, cast(b.DateOfBirth as date) as B_DateOfBirth, b.IsActive as B_IsActive,

		row_number() over (partition by a.FirstName, a.LastName, a.DateOfBirth order by a.FirstName, a.LastName, a.DateOfBirth) as rowid
		from master.members a 
		join master.members b on a.FirstName = b.FirstName and a.LastName = b.LastName and a.DateOfBirth = b.DateOfBirth and a.NHMemberID <> b.NHMemberID
		where 1=1
		-- and a.IsActive = 1 and b.IsActive = 1 
		and a.NHMemberID in (
							   select NHmemberID from master.members 
							   where MemberID in ( 
													select MemberID from master.memberInsurances 
													where insuranceCarrierID in (302) and InsuranceHealthPlanID in (
																													select InsuranceHealthPlanID from insurance.InsuranceHealthPlans 
																													where insuranceCarrierID in (302)
																													)
												 )
							  )

		and b.NHMemberID in (
							   select NHmemberID from master.members 
							   where MemberID in ( 
													select MemberID from master.memberInsurances 
													where insuranceCarrierID in (302) and InsuranceHealthPlanID in (
																													select InsuranceHealthPlanID from insurance.InsuranceHealthPlans 
																													where insuranceCarrierID in (302)
																													)
												 )
						)

		-- order by 2,3,4
) a
where a.rowid = 1
order by 5,10,2,3,4


--- Scripts to removed IV status
IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202005670629')



--update master.MemberInsuranceDetails
select 1 as SNo,
'update master.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 and (IVQStatus is not null or IVQStatus = 'DENIED')

union
-- Update provider.MemberInsuranceDetails
select 2 as SNo, 
'update provider.MemberInsuranceDetails set IVQStatus = NULL where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 and (IVQStatus is not null or IVQStatus = 'DENIED')

union 
-- Update provider.IVQueue
select 3 as SNo,
'update provider.IVQueue set IsActive = 0 where IVQueueID = '+ cast(IVQueueID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive <> 0


--Select for the records that contain an IV
select 1 as SNo,
'select IVQStatus, * from master.MemberInsuranceDetails where ID = ' + Cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from master.MemberInsuranceDetails where MemberInsuranceID in (Select ID from master.MemberInsurances where MemberID in (select MemberID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 -- and (IVQStatus is not null or IVQStatus = 'DENIED')

union

select 2 as SNo,
'select IVQStatus, * from provider.MemberInsuranceDetails where ID = '+ cast(ID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.MemberInsuranceDetails where MemberInsuranceID in (Select MemberInsuranceID from provider.MemberInsurances where MemberProfileId in (select MemberProfileID from provider.memberProfiles where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive =1) and IsActive =1) and IsActive =1 -- and (IVQStatus is not null or IVQStatus = 'DENIED')

union

select 3 as SNo,
'select IsActive, * from provider.IVQueue where IVQueueID = '+ cast(IVQueueID as nvarchar) + ' -- ' + (select NHMemberID from #NHMemberIDTemp) as Query
from provider.IVQueue where NHMemberID in (select NHMemberID from #NHMemberIDTemp) and IsActive <> 0


select IVQStatus, * from master.MemberInsuranceDetails where ID = 3839508 -- NH202005670629
select IVQStatus, * from provider.MemberInsuranceDetails where ID = 465409 -- NH202005670629
select IsActive, * from provider.IVQueue where IVQueueID = 12018 -- NH202005670629





-- Master tables
select 
c.IVQStatus,c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as Members_IsActive,  a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr, a.*, b.*, c.*
from
master.MemberInsuranceDetails c 
left join master.MemberInsurances b on c.MemberInsuranceID = b.ID
left join master.Members a on a.MemberID = b.MemberID
where 1=1 
-- and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and b.InsuranceCarrierID = (302) and b.InsuranceHealthPlanID in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where insuranceCarrierID in (302)	)
and c.IVQStatus not in ('DENIED', 'APPROVED')
order by b.InsuranceHealthPlanID


--Provider Tables
select 
c.IVQStatus,c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as MemberProfiles_IsActive,  a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr, a.*, b.*, c.*
from
Provider.MemberInsuranceDetails c 
left join Provider.MemberInsurances b on c.MemberInsuranceID = b.MemberInsuranceID
left join Provider.MemberProfiles a on a.MemberProfileID = b.MemberProfileId
where 1=1 
-- and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and b.InsuranceCarrierID = (302) and b.InsuranceHealthPlanID in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where insuranceCarrierID in (302)	)
and c.IVQStatus not in ('DENIED', 'APPROVED')
order by b.InsuranceHealthPlanID


-- 2 - For IVQStatus as Pending | Use this

select IVQStatus,
--IVQueueId, 
NHMemberID, InsuranceCarrierID , InsuranceHealthPlanID,  InsuranceNbr, IV_InsuranceCarrierId, IV_InsuranceHealthPlanId,  FirstName, LastName, DateOfBirth 
from 
(
select distinct 
c.IVQStatus, d.IVQueueId, 
a.NHMemberID, b.InsuranceCarrierID , b.InsuranceHealthPlanID,  InsuranceNbr, 
d.InsuranceCarrierId as IV_InsuranceCarrierId, d.InsuranceHealthPlanId as IV_InsuranceHealthPlanId, upper(a.FirstName) as FirstName, upper(a.LastName) as LastName, cast(a.DateOfBirth as Date) as DateOfBirth,
d.IsActive as IsActive_IVQueue, c.IsActive as MemberInsuranceDetails_IsActive, b.IsActive as MemberInsurances_IsActive, a.IsActive as MemberProfiles_IsActive,  -- Active Flags
row_number() over (partition by a.NHMemberID, b.InsuranceCarrierID,b.InsuranceHealthPlanID, c.InsuranceNbr order by a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, c.InsuranceNbr ) as rowid
-- a.*, b.*, c.*, d.*
from
Provider.MemberInsuranceDetails c 
left join Provider.MemberInsurances b on c.MemberInsuranceID = b.MemberInsuranceID
left join Provider.MemberProfiles a on a.MemberProfileID = b.MemberProfileId
left join provider.IVQueue d on d.NHMemberId = a.NHMemberId
where 1=1 
--and a.IsActive=1 and b.ISActive = 1 and c.IsActive = 1 
and 
b.InsuranceCarrierID in (302) and b.InsuranceHealthPlanID in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where insuranceCarrierID in (302)	)
--and c.IVQStatus not in ('DENIED', 'APPROVED')
and c.IVQStatus is not null and c.IVQStatus not in ('DENIED', 'APPROVED') -- and d.IsActive = 1
--order by  a.NHMemberID, b.InsuranceHealthPlanID
--and a.NHMemberID = 'NH202002691282'

) a
where a.rowid = 1


-- Requirement 3 | 
select 
a.NHMemberID, 
b.FirstName, b.LastName, b.InsCarrierID, b.insHealthplanID, 
b.DOB as Elig_DateOfBirth, b.SubscriberID as Elig_SubscriberID, b.MasterMemberID 
from master.Members a left join elig.mstrEligBenefitData b on a.MemberID = b.MasterMemberID
where InsCarrierID in (302) and insHealthplanID in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where insuranceCarrierID in (302))  and a.IsActive = 1 and b.IsActive = 1


-- Insurances that are created by MEA's and not the same in the eligibility, that are active in the Eligibility file, Master data | Use This
select
a.IsActive as Master_IsActive,  b.IsActive as Elig_IsActive, c.isActive as MemberInsurances_IsActive, d.IsActive as MemberInsuranceDetails_IsActive,
a.NHMemberID,b.MasterMemberID, 
b.SubscriberID as Elig_SubscriberID, b.FirstName, b.LastName, b.DOB as Elig_DateOfBirth,  b.InsCarrierID as Elig_InsCarrierID, b.insHealthplanID as Elig_insHealthplanID, b.BenefitStartDate as ELig_BenefitStartDate, b.BenefitEndDate as Elig_BenefitEndDate,
c.InsuranceCarrierID as MEACreated_MemberInsurances_InsuranceCarrierID , c.InsuranceHealthPlanID as MEACreated_MemberInsurances_InsuranceHealthPlanID, 

d.InsuranceNbr as MEACreated_MemberInsuranceDetails_SubscriberID
from master.Members a 
join elig.mstrEligBenefitData b on a.MemberID = b.MasterMemberID
join master.MemberInsurances c on a.MemberID = c.MemberID
join master.MemberInsuranceDetails d on c.ID = d.MemberInsuranceID
where InsCarrierID in (302) and insHealthplanID in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where insuranceCarrierID in (302)) 
and a.IsActive = 1 and b.IsActive = 1 -- and c.isActive = 1 and d.IsActive =1
and (b.insCarrierID <> c.InsuranceCarrierID or b.insHealthPlanID <> c.InsuranceHealthPlanID)  -- checks all insurance carriers and Health Plans that are different in the elig and insurancesdetails

-- and getdate() between b.BenefitStartDate and b.BenefitEndDate 
order by 3,4, NHMemberID



select * from orders.orders where orderID in (202201950,202297317)


select * from elig.mstrEligBenefitData where SubscriberID like '%V00006573%'
select * from master.members where MemberID = '2788573'


------------------------------------------------
--Richard Dell
select * from (
select distinct FirstName, LastName, SubscriberID, DOB, 
row_number() over (partition by SubscriberID order by SubscriberID) as rowid
from elig.mstrEligBenefitData where
SubscriberID in ('00000111386','00000155397','00000188962','00000148465','00000183125','00000202881','00000191928','00014646501','00000186338','00000113442','00000133099','00000100176','00000181573','00000123485','00029922301','00000202553','00066632901','00000183843','00006021001','00000115695','00056848001','00000175905','00000191173','00000107615','00000149423','00000204931','00078620801','00000112315','00000198561','00000109936','00081352001','00000131574','00000113422','00000134922','00000133758','00000184174','00000155747','00095833701','00000131198','00000159165','00000122662','00000200185','00000156712','00000198800','00000132626','00038684801','00000188098','00000205630','00033902201','00000144785','00000161653','00000164349','00000115194','00000148375','00000184164','00000162742','00056487001','00000162705','00042762601','00000168322','00000102815','00000205843','00000111612','00000109927','00000105943','00000205555','00000203907','00014819201','00000163022','00000167986','00084656602','00000111296','00000134917','00000108570','00000155306','00000151183','00000177806','00000132754','00099432101','00000205408','00000181583','00024248001','00000101180','00000158325','00000111403','00000131096','00000141324','00000204070','00069211801','00000178630','00000199101','00075558501','00000166505','00000188186','00038223701','00000136082','00099497401','00000180394','00000172906','00000130725','00000138615','00000199816','00096779001','00000153388','00000149838','00000149052','00000193041','00000183246','00000114482','00000110642','00000166586','00000196909','00000182348','00065365501','00000136520','00000129029','00000182936','00000115735','00039386201','00000192129','00027498201','00000198302','00000128320','00000192691','00000202773','00000182268','00000169483','00000197726','00057455101','00000140103','00000187175','00000452301','00026419701','00000146806','00000129790','00022458301','00065568201','00000202709','00000132442','00000203340','00000130305','00000124151','00000202975','00049239301','00000171776','00000189688','00000122318','00000197289','00000194230','00000179093','00000128372','00000118653','00000132589','00000200902','00000180867','00000201879','00000130432','00000169944','00000128267','00000118425','00033902202','00000111833','00000205820','00000135552','00000169919','00000177570','00000185820','00000182140','00000173189','00000151755','00000100291','00000150846','00000150843','00000185863','00000105951','00000157177','00000131069','00000103354','00000103428','00000173952','00000135282','00000163056','00000118928','00000179070','00000106847','00000109890','00000113119','00000148697','00067092201','00000127190','00042513701','00000148459','00000185195','00000114897','00000164099','00000170713','00000117890','00000139380','00000192121','00000205726','00000113453','00000126674','00098647301','00000198527','00000190978','00000197650','00000203365','00000186273','00000140511','00000130880','00000110523','00000174309','00000187657','00029929201','00099567501','00000150391','00000194590','00000173126','00000188193','00000174594','00000201759','00007676201','00000185729','00000160737','00085811301','00000197758','00000179060','00000175556','00053909601','00000100727','00000150466','00000158964','00014760701','00000148066','00000121051','00000172400','00000180338','00000145759','00000199538','00010533301','00000142674','00000175949','00000116067','00000151201','00000118462','00000202385','00029326201','00000139806','00018267001','00000198097','00000158565','00077195301','00093938701','00092159601','00000205508','00000135268','00000150069','00080826101','00000132800','00000106848','00000200039','00000134795','00000163286','00000161149','00000130372','00000157377','00000163026','00000204392','00008990701','00015223101','00000129914','00000199915','00000111208','00016674201','00000130256','00000152695','00000102352','00000155239','00000120593','00056587501','00010947001','00000198168','00000186309','00000143783','00000197602','00000191213','00000139615','00000115996','00000197507','00000180327','00000114593','00000178667','00000164674','00000113451','00000189837','00040271301','00000111475','00000191114','00000191930','00000182108','00000180989','00082365501','00000127479','00060205001','00000188822','00000186513','00000163771','00000191134','00000125610','00000101794','00000199044','00014503601','00000142066','00000181571','00000107895','00000205510','00000200244','00000172347','00000153729','00000119786','00000199519','00000126835','00000107060','00028465901','00000144998','00072726001','00000204670','00000177977','00000136108','00000150319','00000158470','00000201560','00000188682','00000133334','00000172730','00087634601','00000197044','00000177452','00000141150','00000201065','00000203097','00000185685','94107402901','00000185352','00000165854','00000164304','00000114351','00000183030','00000189920','00000195291','00000186141','00000137274','00000154606','00000120766','00000191712','00056600101','00000182121','00000113002','00000127616','00000206092','00000187670','00000187919','00000152193','00030112702','00022979801','00000109315','00000138453','00039805801','00000141315','00000177058','00000140246','00097866501','00000192195','00000191509','00076671201','94107419501','00000117233','00000107579','00000183980','00000189145','00055156601','00071017701','00000206408','00000146238','00016298202','00000199427','00000169829','00000148598','00000149565','00000202823','00000164440','00000201662','00000122317','00051339301','00000192669','00000158185','00000200971','00000188091','00000195703','00098689901','00000157947','00000194671','00000153728','00000195296','00045162401','00000186770','00000112230','00000197814','00027073401','00025077301','00000139393','00000186996','00000135597','00092980501','00000118389','00000191950','00024800801','00006633801','00000172482','00000203978','00000109003','00000125378','00000124677','00000201225','00000152023','00015689201','00000146868','00027242101','00000136579','00000103717','00000189537','00018227701','00000139379','00000100287','00000126015','00000106152','00000118214'
)
and IsActive = 1
) a
 where a.rowid =1
--order by 3,4 






select top 10 * from otcfunds.CardBenefitLoad
select top 10 * from sys.columns 
select top 100  * from sys.tables order by Modify_date desc,Create_date
select * from information_schema.columns where table_schema = 'otcfunds' and table_name like '%CardBenefit%'
select top 10 * from otcfunds.CardBenefitLoad_CI order by CreateDate desc -- Card Issued
select top 10 * from otcfunds.CardBenefitLoad_FD order by CreateDate desc -- Funds Issued


select distinct table_name from information_schema.columns where table_schema like '%otcfunds%'




--Richard Dell | Capital and Vibra
select * from (
select distinct FirstName, LastName, SubscriberID, DOB, CreateDate,
row_number() over (partition by SubscriberID order by SubscriberID, CreateDate desc) as rowid
from elig.mstrEligBenefitData where
SubscriberID in 
('YWW871038949','YWW871038416','YWW871038415','YWW871036885','YWW871036852','YWW871036627','YWW871035594','YWW871035552','YWW871034442','YWW871034078','YWW871033646','YWW871033537','YWW871033421','YWW871033164','YWW871032922','YWW871032299','YWW871031807','YWW871031806','YWW871030935','YWW871030899','YWW871030455','YWW871030207','YWW871029677','YWW871029315','YWW871029224','YWW871028621','YWW871028620','YWW871028593','YWW871027739','YWW871027276','YWW871026007','YWW871025550','YWW871025321','YWW871025075','YWW871025074','YWW871024192','YWW871024180','YWW871023864','YWW871022339','YWW871020507','YWW871020117','YWW871019492','YWW871019475','YWW871017005','YWW871016673','YWW871016555','YWW871016461','YWW871014722','YWW871013871','YWW871012959','YWW871012256','YWW871011912','YWW871011679','YWW871010279','YWW871009852','YWW871009278','YWW871008183','YWW871007347','YWW871006307','YWW871005412','YWW871003176','YWW871002757','YWW871002698','YWW871002556','YWW871001822','YWW871000176','YWW870028484','YWW870027965','YWW870027962','YWW870027265','YWW870027264','YWW870027175','YWW870026328','YWW870026159','YWW870024983','YWW870024176','YWW870024167','YWW870023636','YWW870023524','YWW870023441','YWW870023237','YWW870023216','YWW870022619','YWW870022456','YWW870022188','YWW870022068','YWW870021831','YWW870021679','YWW870021627','YWW870021037','YWW870020548','YWW870020064','YWW870020062','YWW870019644','YWW870018808','YWW870018106','YWW870018064','YWW870017939','YWW870017484','YWW870017386','YWW870017202','YWW870017105','YWW870016822','YWW870016402','YWW870015840','YWW870015108','YWW870014963','YWW870014658','YWW870014470','YWW870014170','YWW870014160','YWW870013023','YWW870011538','YWW870011481','YWW870011122','YWW870010696','YWW870009930','YWW870009197','YWW870008563','YWW870008471','YWW870008165','YWW870007926','YWW870007655','YWW870007613','YWW870006971','YWW870006965','YWW870006864','YWW870006863','YWW870006859','YWW870006038','YWW870005924','YWW870005793','YWW870004568','YWW870004545','YWW870004396','YWW870004319','YWW870004057','YWW870003326','YWW870003162','YWW870003160','YWW870002633','YWW870002494','YWW870002493','YWW870002471','YWW870002459','YWW870001997','YWW870000056','YWW801243681','YWW801230199','YWW801224287','YWW801222906','YWW801211268','YWW801210275','YWW801207873','YWW801206141','YWW801200457','YWW801200306','YWW801197354','YWW801194288','YWW801193996','YWW801192923','YWW801191707','YWW801191701','YWW801190809','YWW801186387','YWW801183623','YWW801143015','YWW801140778','YWW801134129','YWW801134128','YWW801124468','YWW801117947','YWW801087833','YWW801081103','YWW801076884','YWW801053158','YWW801045989','YWW801038369','YWW801009141','YWW800997297','YWW800989234','YWW800968839','YWW800945387','YWW800919264','YWW800897806','YWW800889463','YWW800881966','YWW800871567','YWW800866071','YWW800865060','YWW800861824','YWW800848763','YWW800848280','YWW800837787','YWW800825381','YWW800795886','YWW800757154','YWK871036235','YWK871030404','YWK871030117','YWK871030099','YWK871029995','YWK871029169','YWK871028449','YWK871027033','YWK871026698','YWK871026559','YWK871026552','YWK871025172','YWK871024675','YWK871024619','YWK871024146','YWK871023806','YWK871023439','YWK871021701','YWK871021204','YWK871020636','YWK871020520','YWK871020458','YWK871020380','YWK871019870','YWK871019620','YWK871019536','YWK871019530','YWK871018709','YWK871018644','YWK871018388','YWK871016811','YWK871016786','YWK871016734','YWK871016658','YWK871015306','YWK871015149','YWK871015132','YWK871014641','YWK871014560','YWK871014559','YWK871013993','YWK871013952','YWK871013917','YWK871013763','YWK871013644','YWK871013148','YWK871013129','YWK871013069','YWK871013004','YWK871012994','YWK871012993','YWK871012985','YWK871012658','YWK871012280','YWK871010803','YWK871009745','YWK871009718','YWK871007403','YWK871006988','YWK871006452','YWK871006315','YWK871006275','YWK871006274','YWK871002851','YWK871002425','YWK871002361','YWK871002046','YWK871001201','YWK871000988','YWK871000902','YWK871000745','YWK871000216','YWK870029589','YWK870027511','YWK870026831','YWK870026539','YWK870018715','YWK870010902','YWK870000976','YWK801237697','YWK801236399','YWK801196555','YWK801189103','YWK801151692','YWK801132034','YWK801122407','YWK801111038','YWK801103928','YWK801103759','YWK801103728','YWK801075038','YWK801043646','YWK801034820','YWK800927020','YWK800907293','YWK800800321','YWK800800312','YWK800789732','YWK800776825','YWK800427131','YWK800417575','YWK800417545','YWK800416911','YWK800416184','YWK800414584','YWK800414365','YWK800414282','YWK800414133','YWK800413859','YWK800413423','YWK800412964','YWK800412724','YWK800412384','YWK800412309','YWK800411205','YWK800410971','YWK800410763','YWK800410725','YWK800410165','YWK800409221','YWK800408280','YWK800408232','YWK800407978','YWK800407955','YWK800407184','YWK800406741','YWK800406108','YWK800405458','YWK800403372','YWK800400277','V00009917','V00009895','V00009819','V00009489','V00009366','V00009315','V00009250','V00009195','V00009049','V00008457','V00008334','V00008309','V00008282','V00008200','V00008142','V00008048','V00007879','V00007867','V00007751','V00007608','V00007494','V00007235','V00007143','V00007037','V00006994','V00006357','V00006356','V00006224','V00006088','V00006086','V00006064','V00005899','V00005824','V00005770','V00005681','V00005175','V00005164','V00004655','V00004578','V00004566','V00004198','V00004083','V00003864','V00003731','V00003714','V00003544','V00003274','V00002185','V00002063','V00001882','V00001825','V00001692','V00001563','V00001547','V00001231','V00001053','V00001012','V00000856','V00000848','V00000491','V00000024','871036885','871036627','871034442','871034078','871033537','871033421','871033164','871031807','871030935','871030899','871030207','871030117','871028449','871027739','871027276','871027033','871026559','871026552','871026007','871025550','871025321','871025172','871025075','871025074','871024675','871024619','871024192','871024180','871024146','871023864','871023806','871022339','871021204','871020636','871020507','871020458','871020380','871020117','871019870','871019620','871019536','871019530','871019492','871019475','871018709','871018644','871018388','871017005','871016786','871016734','871016673','871016658','871016555','871015306','871015149','871014722','871014641','871014560','871014559','871013993','871013871','871013763','871013644','871013129','871012256','871011912','871011679','871010803','871010279','871009718','871009278','871008183','871007347','871006988','871006452','871006315','871006307','871006275','871006274','871005412','871003176','871002851','871002757','871002698','871002556','871002361','871001201','871000902','871000745','871000216','871000176','870029589','870028484','870027965','870027962','870027511','870027265','870026831','870026328','870026159','870024983','870024176','870024167','870023779','870023778','870023441','870023237','870023216','870022619','870022188','870021679','870021627','870021037','870020064','870020062','870019644','870018715','870018106','870018064','870017484','870017386','870017202','870016822','870016402','870015840','870015108','870014963','870014658','870014470','870014170','870014160','870013023','870011538','870010902','870010696','870009930','870008563','870008165','870007926','870007655','870007613','870006971','870006965','870006864','870006859','870006038','870005924','870005793','870004568','870004545','870004396','870004057','870003326','870003162','870003160','870002633','870002494','870002493','870002471','870002459','870001997','870000976','801243681','801237697','801236399','801230199','801224287','801222906','801211268','801207873','801206141','801200457','801200306','801197354','801194288','801193996','801192923','801191707','801191701','801190809','801189103','801186387','801183623','801143015','801140778','801134129','801134128','801132034','801124468','801122407','801117947','801103928','801103759','801103728','801087833','801081103','801076884','801075038','801053158','801045989','801043646','801038369','801034820','801009141','800997297','800989234','800968839','800945387','800907293','800897806','800889463','800881966','800866071','800848763','800848280','800837787','800800321','800800312','800795886','800789732','800776825','800427131','800417575','800416911','800416184','800414584','800414365','800414133','800413859','800413423','800412964','800412724','800412384','800412309','800411205','800410971','800410763','800410165','800409221','800408280','800408232','800407978','800407955','800407184','800406741','800406108','800405458','800403372','800400277')
--and IsActive = 1
) a
 --where a.rowid =1
 where SubscriberID = 'YWK800417545' order by createdate desc
--order by 3,4 

-- Capital and Vibra
('YWW871038949','YWW871038416','YWW871038415','YWW871036885','YWW871036852','YWW871036627','YWW871035594','YWW871035552','YWW871034442','YWW871034078','YWW871033646','YWW871033537','YWW871033421','YWW871033164','YWW871032922','YWW871032299','YWW871031807','YWW871031806','YWW871030935','YWW871030899','YWW871030455','YWW871030207','YWW871029677','YWW871029315','YWW871029224','YWW871028621','YWW871028620','YWW871028593','YWW871027739','YWW871027276','YWW871026007','YWW871025550','YWW871025321','YWW871025075','YWW871025074','YWW871024192','YWW871024180','YWW871023864','YWW871022339','YWW871020507','YWW871020117','YWW871019492','YWW871019475','YWW871017005','YWW871016673','YWW871016555','YWW871016461','YWW871014722','YWW871013871','YWW871012959','YWW871012256','YWW871011912','YWW871011679','YWW871010279','YWW871009852','YWW871009278','YWW871008183','YWW871007347','YWW871006307','YWW871005412','YWW871003176','YWW871002757','YWW871002698','YWW871002556','YWW871001822','YWW871000176','YWW870028484','YWW870027965','YWW870027962','YWW870027265','YWW870027264','YWW870027175','YWW870026328','YWW870026159','YWW870024983','YWW870024176','YWW870024167','YWW870023636','YWW870023524','YWW870023441','YWW870023237','YWW870023216','YWW870022619','YWW870022456','YWW870022188','YWW870022068','YWW870021831','YWW870021679','YWW870021627','YWW870021037','YWW870020548','YWW870020064','YWW870020062','YWW870019644','YWW870018808','YWW870018106','YWW870018064','YWW870017939','YWW870017484','YWW870017386','YWW870017202','YWW870017105','YWW870016822','YWW870016402','YWW870015840','YWW870015108','YWW870014963','YWW870014658','YWW870014470','YWW870014170','YWW870014160','YWW870013023','YWW870011538','YWW870011481','YWW870011122','YWW870010696','YWW870009930','YWW870009197','YWW870008563','YWW870008471','YWW870008165','YWW870007926','YWW870007655','YWW870007613','YWW870006971','YWW870006965','YWW870006864','YWW870006863','YWW870006859','YWW870006038','YWW870005924','YWW870005793','YWW870004568','YWW870004545','YWW870004396','YWW870004319','YWW870004057','YWW870003326','YWW870003162','YWW870003160','YWW870002633','YWW870002494','YWW870002493','YWW870002471','YWW870002459','YWW870001997','YWW870000056','YWW801243681','YWW801230199','YWW801224287','YWW801222906','YWW801211268','YWW801210275','YWW801207873','YWW801206141','YWW801200457','YWW801200306','YWW801197354','YWW801194288','YWW801193996','YWW801192923','YWW801191707','YWW801191701','YWW801190809','YWW801186387','YWW801183623','YWW801143015','YWW801140778','YWW801134129','YWW801134128','YWW801124468','YWW801117947','YWW801087833','YWW801081103','YWW801076884','YWW801053158','YWW801045989','YWW801038369','YWW801009141','YWW800997297','YWW800989234','YWW800968839','YWW800945387','YWW800919264','YWW800897806','YWW800889463','YWW800881966','YWW800871567','YWW800866071','YWW800865060','YWW800861824','YWW800848763','YWW800848280','YWW800837787','YWW800825381','YWW800795886','YWW800757154','YWK871036235','YWK871030404','YWK871030117','YWK871030099','YWK871029995','YWK871029169','YWK871028449','YWK871027033','YWK871026698','YWK871026559','YWK871026552','YWK871025172','YWK871024675','YWK871024619','YWK871024146','YWK871023806','YWK871023439','YWK871021701','YWK871021204','YWK871020636','YWK871020520','YWK871020458','YWK871020380','YWK871019870','YWK871019620','YWK871019536','YWK871019530','YWK871018709','YWK871018644','YWK871018388','YWK871016811','YWK871016786','YWK871016734','YWK871016658','YWK871015306','YWK871015149','YWK871015132','YWK871014641','YWK871014560','YWK871014559','YWK871013993','YWK871013952','YWK871013917','YWK871013763','YWK871013644','YWK871013148','YWK871013129','YWK871013069','YWK871013004','YWK871012994','YWK871012993','YWK871012985','YWK871012658','YWK871012280','YWK871010803','YWK871009745','YWK871009718','YWK871007403','YWK871006988','YWK871006452','YWK871006315','YWK871006275','YWK871006274','YWK871002851','YWK871002425','YWK871002361','YWK871002046','YWK871001201','YWK871000988','YWK871000902','YWK871000745','YWK871000216','YWK870029589','YWK870027511','YWK870026831','YWK870026539','YWK870018715','YWK870010902','YWK870000976','YWK801237697','YWK801236399','YWK801196555','YWK801189103','YWK801151692','YWK801132034','YWK801122407','YWK801111038','YWK801103928','YWK801103759','YWK801103728','YWK801075038','YWK801043646','YWK801034820','YWK800927020','YWK800907293','YWK800800321','YWK800800312','YWK800789732','YWK800776825','YWK800427131','YWK800417575','YWK800417545','YWK800416911','YWK800416184','YWK800414584','YWK800414365','YWK800414282','YWK800414133','YWK800413859','YWK800413423','YWK800412964','YWK800412724','YWK800412384','YWK800412309','YWK800411205','YWK800410971','YWK800410763','YWK800410725','YWK800410165','YWK800409221','YWK800408280','YWK800408232','YWK800407978','YWK800407955','YWK800407184','YWK800406741','YWK800406108','YWK800405458','YWK800403372','YWK800400277','V00009917','V00009895','V00009819','V00009489','V00009366','V00009315','V00009250','V00009195','V00009049','V00008457','V00008334','V00008309','V00008282','V00008200','V00008142','V00008048','V00007879','V00007867','V00007751','V00007608','V00007494','V00007235','V00007143','V00007037','V00006994','V00006357','V00006356','V00006224','V00006088','V00006086','V00006064','V00005899','V00005824','V00005770','V00005681','V00005175','V00005164','V00004655','V00004578','V00004566','V00004198','V00004083','V00003864','V00003731','V00003714','V00003544','V00003274','V00002185','V00002063','V00001882','V00001825','V00001692','V00001563','V00001547','V00001231','V00001053','V00001012','V00000856','V00000848','V00000491','V00000024','871036885','871036627','871034442','871034078','871033537','871033421','871033164','871031807','871030935','871030899','871030207','871030117','871028449','871027739','871027276','871027033','871026559','871026552','871026007','871025550','871025321','871025172','871025075','871025074','871024675','871024619','871024192','871024180','871024146','871023864','871023806','871022339','871021204','871020636','871020507','871020458','871020380','871020117','871019870','871019620','871019536','871019530','871019492','871019475','871018709','871018644','871018388','871017005','871016786','871016734','871016673','871016658','871016555','871015306','871015149','871014722','871014641','871014560','871014559','871013993','871013871','871013763','871013644','871013129','871012256','871011912','871011679','871010803','871010279','871009718','871009278','871008183','871007347','871006988','871006452','871006315','871006307','871006275','871006274','871005412','871003176','871002851','871002757','871002698','871002556','871002361','871001201','871000902','871000745','871000216','871000176','870029589','870028484','870027965','870027962','870027511','870027265','870026831','870026328','870026159','870024983','870024176','870024167','870023779','870023778','870023441','870023237','870023216','870022619','870022188','870021679','870021627','870021037','870020064','870020062','870019644','870018715','870018106','870018064','870017484','870017386','870017202','870016822','870016402','870015840','870015108','870014963','870014658','870014470','870014170','870014160','870013023','870011538','870010902','870010696','870009930','870008563','870008165','870007926','870007655','870007613','870006971','870006965','870006864','870006859','870006038','870005924','870005793','870004568','870004545','870004396','870004057','870003326','870003162','870003160','870002633','870002494','870002493','870002471','870002459','870001997','870000976','801243681','801237697','801236399','801230199','801224287','801222906','801211268','801207873','801206141','801200457','801200306','801197354','801194288','801193996','801192923','801191707','801191701','801190809','801189103','801186387','801183623','801143015','801140778','801134129','801134128','801132034','801124468','801122407','801117947','801103928','801103759','801103728','801087833','801081103','801076884','801075038','801053158','801045989','801043646','801038369','801034820','801009141','800997297','800989234','800968839','800945387','800907293','800897806','800889463','800881966','800866071','800848763','800848280','800837787','800800321','800800312','800795886','800789732','800776825','800427131','800417575','800416911','800416184','800414584','800414365','800414133','800413859','800413423','800412964','800412724','800412384','800412309','800411205','800410971','800410763','800410165','800409221','800408280','800408232','800407978','800407955','800407184','800406741','800406108','800405458','800403372','800400277')


select * from elig.mstrEligBenefitData where SubscriberID = '800403372'


select * from (
select distinct IsActive, Datasource, FirstName, LastName, SubscriberID, DOB, CreateDate,
row_number() over (partition by SubscriberID order by SubscriberID, CreateDate desc) as rowid
from elig.mstrEligBenefitData where
SubscriberID in 
('YWW871038949','YWW871038416','YWW871038415','YWW871036885','YWW871036852','YWW871036627','YWW871035594','YWW871035552','YWW871034442','YWW871034078','YWW871033646','YWW871033537','YWW871033421','YWW871033164','YWW871032922','YWW871032299','YWW871031807','YWW871031806','YWW871030935','YWW871030899','YWW871030455','YWW871030207','YWW871029677','YWW871029315','YWW871029224','YWW871028621','YWW871028620','YWW871028593','YWW871027739','YWW871027276','YWW871026007','YWW871025550','YWW871025321','YWW871025075','YWW871025074','YWW871024192','YWW871024180','YWW871023864','YWW871022339','YWW871020507','YWW871020117','YWW871019492','YWW871019475','YWW871017005','YWW871016673','YWW871016555','YWW871016461','YWW871014722','YWW871013871','YWW871012959','YWW871012256','YWW871011912','YWW871011679','YWW871010279','YWW871009852','YWW871009278','YWW871008183','YWW871007347','YWW871006307','YWW871005412','YWW871003176','YWW871002757','YWW871002698','YWW871002556','YWW871001822','YWW871000176','YWW870028484','YWW870027965','YWW870027962','YWW870027265','YWW870027264','YWW870027175','YWW870026328','YWW870026159','YWW870024983','YWW870024176','YWW870024167','YWW870023636','YWW870023524','YWW870023441','YWW870023237','YWW870023216','YWW870022619','YWW870022456','YWW870022188','YWW870022068','YWW870021831','YWW870021679','YWW870021627','YWW870021037','YWW870020548','YWW870020064','YWW870020062','YWW870019644','YWW870018808','YWW870018106','YWW870018064','YWW870017939','YWW870017484','YWW870017386','YWW870017202','YWW870017105','YWW870016822','YWW870016402','YWW870015840','YWW870015108','YWW870014963','YWW870014658','YWW870014470','YWW870014170','YWW870014160','YWW870013023','YWW870011538','YWW870011481','YWW870011122','YWW870010696','YWW870009930','YWW870009197','YWW870008563','YWW870008471','YWW870008165','YWW870007926','YWW870007655','YWW870007613','YWW870006971','YWW870006965','YWW870006864','YWW870006863','YWW870006859','YWW870006038','YWW870005924','YWW870005793','YWW870004568','YWW870004545','YWW870004396','YWW870004319','YWW870004057','YWW870003326','YWW870003162','YWW870003160','YWW870002633','YWW870002494','YWW870002493','YWW870002471','YWW870002459','YWW870001997','YWW870000056','YWW801243681','YWW801230199','YWW801224287','YWW801222906','YWW801211268','YWW801210275','YWW801207873','YWW801206141','YWW801200457','YWW801200306','YWW801197354','YWW801194288','YWW801193996','YWW801192923','YWW801191707','YWW801191701','YWW801190809','YWW801186387','YWW801183623','YWW801143015','YWW801140778','YWW801134129','YWW801134128','YWW801124468','YWW801117947','YWW801087833','YWW801081103','YWW801076884','YWW801053158','YWW801045989','YWW801038369','YWW801009141','YWW800997297','YWW800989234','YWW800968839','YWW800945387','YWW800919264','YWW800897806','YWW800889463','YWW800881966','YWW800871567','YWW800866071','YWW800865060','YWW800861824','YWW800848763','YWW800848280','YWW800837787','YWW800825381','YWW800795886','YWW800757154','YWK871036235','YWK871030404','YWK871030117','YWK871030099','YWK871029995','YWK871029169','YWK871028449','YWK871027033','YWK871026698','YWK871026559','YWK871026552','YWK871025172','YWK871024675','YWK871024619','YWK871024146','YWK871023806','YWK871023439','YWK871021701','YWK871021204','YWK871020636','YWK871020520','YWK871020458','YWK871020380','YWK871019870','YWK871019620','YWK871019536','YWK871019530','YWK871018709','YWK871018644','YWK871018388','YWK871016811','YWK871016786','YWK871016734','YWK871016658','YWK871015306','YWK871015149','YWK871015132','YWK871014641','YWK871014560','YWK871014559','YWK871013993','YWK871013952','YWK871013917','YWK871013763','YWK871013644','YWK871013148','YWK871013129','YWK871013069','YWK871013004','YWK871012994','YWK871012993','YWK871012985','YWK871012658','YWK871012280','YWK871010803','YWK871009745','YWK871009718','YWK871007403','YWK871006988','YWK871006452','YWK871006315','YWK871006275','YWK871006274','YWK871002851','YWK871002425','YWK871002361','YWK871002046','YWK871001201','YWK871000988','YWK871000902','YWK871000745','YWK871000216','YWK870029589','YWK870027511','YWK870026831','YWK870026539','YWK870018715','YWK870010902','YWK870000976','YWK801237697','YWK801236399','YWK801196555','YWK801189103','YWK801151692','YWK801132034','YWK801122407','YWK801111038','YWK801103928','YWK801103759','YWK801103728','YWK801075038','YWK801043646','YWK801034820','YWK800927020','YWK800907293','YWK800800321','YWK800800312','YWK800789732','YWK800776825','YWK800427131','YWK800417575','YWK800417545','YWK800416911','YWK800416184','YWK800414584','YWK800414365','YWK800414282','YWK800414133','YWK800413859','YWK800413423','YWK800412964','YWK800412724','YWK800412384','YWK800412309','YWK800411205','YWK800410971','YWK800410763','YWK800410725','YWK800410165','YWK800409221','YWK800408280','YWK800408232','YWK800407978','YWK800407955','YWK800407184','YWK800406741','YWK800406108','YWK800405458','YWK800403372','YWK800400277','V00009917','V00009895','V00009819','V00009489','V00009366','V00009315','V00009250','V00009195','V00009049','V00008457','V00008334','V00008309','V00008282','V00008200','V00008142','V00008048','V00007879','V00007867','V00007751','V00007608','V00007494','V00007235','V00007143','V00007037','V00006994','V00006357','V00006356','V00006224','V00006088','V00006086','V00006064','V00005899','V00005824','V00005770','V00005681','V00005175','V00005164','V00004655','V00004578','V00004566','V00004198','V00004083','V00003864','V00003731','V00003714','V00003544','V00003274','V00002185','V00002063','V00001882','V00001825','V00001692','V00001563','V00001547','V00001231','V00001053','V00001012','V00000856','V00000848','V00000491','V00000024','871036885','871036627','871034442','871034078','871033537','871033421','871033164','871031807','871030935','871030899','871030207','871030117','871028449','871027739','871027276','871027033','871026559','871026552','871026007','871025550','871025321','871025172','871025075','871025074','871024675','871024619','871024192','871024180','871024146','871023864','871023806','871022339','871021204','871020636','871020507','871020458','871020380','871020117','871019870','871019620','871019536','871019530','871019492','871019475','871018709','871018644','871018388','871017005','871016786','871016734','871016673','871016658','871016555','871015306','871015149','871014722','871014641','871014560','871014559','871013993','871013871','871013763','871013644','871013129','871012256','871011912','871011679','871010803','871010279','871009718','871009278','871008183','871007347','871006988','871006452','871006315','871006307','871006275','871006274','871005412','871003176','871002851','871002757','871002698','871002556','871002361','871001201','871000902','871000745','871000216','871000176','870029589','870028484','870027965','870027962','870027511','870027265','870026831','870026328','870026159','870024983','870024176','870024167','870023779','870023778','870023441','870023237','870023216','870022619','870022188','870021679','870021627','870021037','870020064','870020062','870019644','870018715','870018106','870018064','870017484','870017386','870017202','870016822','870016402','870015840','870015108','870014963','870014658','870014470','870014170','870014160','870013023','870011538','870010902','870010696','870009930','870008563','870008165','870007926','870007655','870007613','870006971','870006965','870006864','870006859','870006038','870005924','870005793','870004568','870004545','870004396','870004057','870003326','870003162','870003160','870002633','870002494','870002493','870002471','870002459','870001997','870000976','801243681','801237697','801236399','801230199','801224287','801222906','801211268','801207873','801206141','801200457','801200306','801197354','801194288','801193996','801192923','801191707','801191701','801190809','801189103','801186387','801183623','801143015','801140778','801134129','801134128','801132034','801124468','801122407','801117947','801103928','801103759','801103728','801087833','801081103','801076884','801075038','801053158','801045989','801043646','801038369','801034820','801009141','800997297','800989234','800968839','800945387','800907293','800897806','800889463','800881966','800866071','800848763','800848280','800837787','800800321','800800312','800795886','800789732','800776825','800427131','800417575','800416911','800416184','800414584','800414365','800414133','800413859','800413423','800412964','800412724','800412384','800412309','800411205','800410971','800410763','800410165','800409221','800408280','800408232','800407978','800407955','800407184','800406741','800406108','800405458','800403372','800400277')
--and IsActive = 1
) a
 where a.rowid = 1
 order by SubscriberID
 --where SubscriberID = 'YWK800417545' order by createdate desc




select * from elig.ClientCodes where datasource in ( 'ELIG_CAPBC', 'ELIG_VIBRA')

select * from elig.clientCodes where ClientCode in ('H229','H335')
select * from elig.FileInfo where ClientCode in ('H229','H335') and direction = 'IN' order by FileInfoID desc
select * from elig.FileTrack where ClientCode in ('H229','H335') and DirectionCode = 'IN' order by datasource, FiletrackID desc, FileInfoID desc, DateReceived Desc -- and FileTrackID = 52752
select * from elig.stgEligBenefitData where SubscriberID in ('00053478301')
select * from elig.stgEligBenefitDataHist  where SubscriberID in ('00053478301')
select * from elig.errEligBenefitData where SubscriberID in ('00053478301')


select * from auth.userProfiles where Username in ( 'skanala', 'sballa') -- 12913, 12260



IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202002292162')

select 'elig.ClientCodes' as ClientCodes_TableName, ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
select 'elig.ClientCodes' as ClientCodes_TableName, * from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
select 'elig.FileInfo' as FileInfo_TableName,* from elig.FileInfo where direction = 'IN' and
ClientCode in (select ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
Order by FileInfoID desc

select top 5 'elig.FileTrack | top 5' as FileTrack_Top5_TableName,a.CreateDate, a.DateReceived,  * from elig.FileTrack a where DirectionCode = 'IN' and 
ClientCode in (select ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
order by datasource, FiletrackID desc, FileInfoID desc, a.DateReceived Desc

select 'elig.rawEligBenefitData' as rawEligBenefitData_TableName,* from elig.rawEligBenefitData where 
ClientCode in (select ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
order by FiletrackID desc

select 'elig.stgEligBenefitData' as stgEligBenefitData_TableName,* from elig.stgEligBenefitData where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc

select 'elig.stgEligBenefitDataHist' as stgEligBenefitDataHist_TableName,* from elig.stgEligBenefitDataHist where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc

select 'elig.errEligBenefitData' as errEligBenefitData_TableName,* from elig.errEligBenefitData where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc


select top 10 * from master.members where NHLinkID not in (select distinct NHLinkID from elig.mstrEligBenefitData) or NHLinkID is null

select * from master.members where CreateUser like '%unauthorize%'

select * from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.members where CreateUser like '%unauthorize%')


select * from otc.cards where cardnumber = 6363011091041696156
select top 10 * from Member.MemberCards 
select * from Member.MemberCards where NHMemberID  = 'NH202002067893'
where CardNumber = '6363011091041696156'

select distinct a.InsuranceCarrierID,
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = a.[InsuranceCarrierID] ), 
a.InsuranceHealthPlanID,
HealthPlanName = (select HealthPlanName from [Insurance].[InsuranceHealthPlans] ihp where ihp.InsuranceHealthPlanID = a.InsuranceHealthPlanID ) 
from Member.MemberCards a where IsActive =1 order by InsuranceCarrierID

select * from  elig.rawEligBenefitData where rawvcflex7 = '6363011091041696156'
select * from Member.MemberCards where insuranceCarrierID = 277 and InsuranceHealthPlanID = 2509 -- where CardNumber = '6363011091041696156'
select * from Member.MemberCards where NHMemberID = 'NH202002067893'


---------------------------Tyzo's request--------------------------------

Ticket #  64387

select top 10 * from orders.orders where OrderType = 'OTC'
select top 10 * from orders.orderItems 
select top 10 * from orders.orderTransactiondetails where OrderType = 'OTC'

select * from otccatalog.ItemMaster where ItemName like '%box%' 




select * from insurance.insuranceCarriers where insuranceCarrierName like '%Health%first%'
select * from insurance.insuranceHealthPlans where insuranceCarrierID = 277

/*
InsuranceCarrierID	InsuranceCarrierName
88					Health First, Inc.
93					Healthfirst, Inc.
277					Healthfirst (New York) -- This one
362					Health First Health Plans (HFHP)
363					Health First Health Plans (AdventHealth)

*/



select
o.IsActive, oi.IsActive, 
'Orders.orderitems' as OrderItems_TableName
,oi.ItemCode
,im.ItemName

,oi.Quantity,oi.Amount,oi.Status,oi.UnitPrice
-- ItemData
,json_value(oi.ItemData, '$.quantity') as ItemData_quantity
,json_value(oi.ItemData, '$.nationsId') as ItemData_nationsId
--,json_value(oi.ItemData, '$.catalogName') as ItemData_catalogName
--,json_value(oi.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
--,json_value(oi.ItemData, '$.categories') as ItemData_categories

,'Orders.orders' as Orders_TableName, o.orderID, o.NHMemberid 
, json_value(o.MemberData, '$.insCarrierId') as InsuranceCarrierID
, (select InsuranceCarrierName from Insurance.InsuranceCarriers a where a.InsuranceCarrierID = json_value(o.MemberData, '$.insCarrierId')) as InsuranceCarrierName
, json_value(o.MemberData, '$.insPlanId') as InsuranceHealthPlanID
,(select HealthPlanName as InsuranceHealthPlanName from Insurance.InsuranceHealthPlans b where b.InsuranceHealthPlanID =  json_value(o.MemberData, '$.insPlanId')) as InsuranceHealthPlanName
,o.*

from Orders.orderItems oi 
left join Orders.Orders o on oi.OrderID =o.OrderID
left join otccatalog.ItemMaster im on oi.ItemCode = im.ItemCode
where 1=1 
and json_value(oi.ItemData, '$.nationsId') in (10014,10005,10006,10007,10008,10009,10010,10011,10012) -- pantry boxes
and (  json_value(o.MemberData, '$.insCarrierId') in (277) and json_value(o.MemberData, '$.insPlanId') in (select InsuranceHealthPlanID from insurance.InsuranceHealthPlans where InsuranceCarrierID = 277))
and oi.CreateDate > '2022-01-01' 
and oi.Isactive =1 and o.IsActive =1 
and oi.Status = 'ACTIVE'

order by oi.OrderID




---------------------------Tyzo's request--------------------------------

Member ID: 200010039
Name: Beverly Hunt 
Effective Date: 3/1/2022

select * from auth.Userprofiles where FirstName like 'Carmine'

select * from elig.clientcodes where clientname like '%apex%'
select * from elig.mstrEligBenefitData where firstName like 'Beverly' and lastName like 'Hunt' and subscriberID like '%39%'
select * from elig.mstrEligBenefitData where inscarrierid = 268  order by CreateDate desc NHLinkID

FileTrackID (49455,33812,33771,33200,32836,32835,31819,31635) --Apex


select * from elig.ClientCodes where datasource in ( 'ELIG_CAPBC', 'ELIG_VIBRA')
select * from elig.clientCodes where ClientCode in ('H499')
select * from elig.FileInfo where ClientCode in ('H499') and direction = 'IN' order by FileInfoID desc
select * from elig.FileTrack where ClientCode in ('H499') and DirectionCode = 'IN' order by datasource, FiletrackID desc, FileInfoID desc, DateReceived Desc -- and FileTrackID = 52752
select * from elig.stgEligBenefitData where FileTrackID in (49455,33812,33771,33200,32836,32835,31819,31635) order by SubscriberID
select * from elig.stgEligBenefitDataHist  where  FileTrackID in (49455,33812,33771,33200,32836,32835,31819,31635) order by SubscriberID
select * from elig.errEligBenefitData where FileTrackID in (49455,33812,33771,33200,32836,32835,31819,31635) order by SubscriberID
 



 ------------------------Quamari Request | 66284 ------------------------------------------

 -- Check the insurance carrier and the data source of the client

select * from elig.clientCodes where clientName like '%molina%'
select * from elig.clientCodes where dataSource = 'ELIG_CCOK'

DECLARE @StartDate DATE = '01-01-2022' ;
DECLARE @EndDate DATE = '02-28-2022';
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
              --and exists (select 1 from master.Members m where m.NHMemberID = c.MemberNHMemberId and m.DataSource = 'ELIG_CCOK')
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





-- Your changes, Use this with Insurance Carrier ID
select * from elig.clientCodes where clientName like '%molina%'
select * from elig.clientCodes where dataSource = 'ELIG_CCOK'

DECLARE @StartDate DATE = '01-01-2022' ;
DECLARE @EndDate DATE = '02-28-2022';
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
              --and exists (select 1 from master.Members m where m.NHMemberID = c.MemberNHMemberId and m.DataSource = 'ELIG_CCOK')
              and exists (select 1 from jobs.Events e where e.EventId = cp.EventId and EventTriggerBy = 'DISPOSITION')
              and c.AgentUserProfileName not in ('rsareddy','mnanduri','sraghavendran','ZPerlmanCC','awrenn','SDaggubati','skapa','spotiigari', 'sballa')
                           ) z
						inner join master.members z1 on (z.MemberNHMemberId = z1.NHMemberID)
						inner join ( 
                           --select distinct LastName, FirstName,MedicareID,MasterMemberID From elig.mstrEligBenefitData where DataSource = 'ELIG_CCOK'
						   select distinct LastName, FirstName, MedicareID, MasterMemberID from elig.mstrEligBenefitData where insCarrierID in (380)
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
--where datasource = 'ELIG_CCOK'
where insCarrierID in (380)
group by mastermemberid ,nhlinkid) s on (t.mastermemberid = s.mastermemberid)



select distinct MemberNHMemberId,nhlinkid as MemberInsuranceId,Callbound, Callingnumber, a.FirstName, a.LastName
, MedicareID, substring(HealthPlanNumber,1,5) ContractID, substring(HealthPlanNumber,7,3) PLANID,  CallDate
, CallTime, CategoryoftheCall, CallEndSummary,a.agentuserprofilename,x.ProfileIDFirstname,x.ProfileIDLastname
,@StartDate startDate,@EndDate enddate
from #RS_HF_Audit1 a
inner join elig.BenefitCrossWalk b on (b.insurancehealthplanid= a.healthplanid and b.InsuranceCarrierId in (380) )
left join (
     select userprofileid userprofileid,
	        username      ProfileIDUsername,
	        firstname     ProfileIDfirstname,
			lastname      ProfileIDlastname
			from auth.UserProfiles
			where 1=1 )x on a.agentuserprofilename = x.ProfileIDUsername
where 1 = 1


select MemberNHMemberId, Count(*) from #RS_HF_Audit1 group by MemberNHMemberId order by 2 desc

select * from #RS_HF_Audit1 where MemberNHMemberId = 'NH202107188698'


 ------------------------Quamari Request | 66284 ------------------------------------------


------------------------Jeanette Request |  57353 ------------------------------------------

select top 10 * from supplOrders.Orders
select * from insurance.InsuranceCarriers where InsuranceCarrierName like '%Molina%'

-- Catalog Requests for Moline Members
IF OBJECT_ID('tempdb..#TSupplOrdersCatalog') IS NOT NULL DROP TABLE #TSupplOrdersCatalog
select * into #TSupplOrdersCatalog from (

select a.IsActive Orders_IsActive, b.IsActive as Members_IsActive, a.OrderID,  a.orderDate, a.NHMemberID, b.FirstName, b.LastName,

a.InsuranceCarrierID, 
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = a.InsuranceCarrierID ), 
a.InsuranceHealthPlanId, 
InsuranceHealthPlanName = (select HealthPlanName from Insurance.InsuranceHealthPlans ihp where ihp.InsuranceHealthPlanID = a.InsuranceHealthPlanId ), 

a.ShippedDate
,json_value(a.ShippingAddress, '$.address.addressType') as ShippingAddress_AddressType
,json_value(a.ShippingAddress, '$.address.address1') as ShippingAddress_address1
,json_value(a.ShippingAddress, '$.address.address2') as ShippingAddress_address2
,json_value(a.ShippingAddress, '$.address.city') as ShippingAddress_city
,json_value(a.ShippingAddress, '$.address.state') as ShippingAddress_state
,json_value(a.ShippingAddress, '$.address.zipCode') as ShippingAddress_ZipCode

,a.Status, a.IsActive  --, a.*
from supplOrders.Orders a left join master.Members b on a.NHMemberID = b.NHMemberID and b.IsActive = 1
where 1=1 and 
a.InsuranceCarrierID in (380, 400, 138) and
a.Status in ( 'Shipped', 'Requested')
) a

select * from #TSupplOrdersCatalog

select  NHMemberID,  upper(FirstName) as FirstName, upper(LastName) as LastName, Cast(OrderDate as Date) as OrderDate, InsuranceCarrierName, InsuranceHealthPlanName, 
cast(ShippedDate as Date) as ShippedDate, ShippingAddress_AddressType as AddressType, ShippingAddress_Address1 as Address1 , ShippingAddress_Address2 as Address2 , ShippingAddress_City as City, ShippingAddress_State as State, ShippingAddress_ZipCode as ZipCode

,cast(cast(ShippedDate as Date) as nvarchar) + '  |  ' + ShippingAddress_AddressType + '  |  ' +
(IsNull(ShippingAddress_Address1,'') + ', ' + IsNull(ShippingAddress_Address2, '') + 

(CASE WHEN ltrim(rtrim(ShippingAddress_Address2)) <> ''  then ', '  else '' end)  +  IsNull(ShippingAddress_City,'') + ', ' + IsNull(ShippingAddress_State,'') + ' - ' + IsNull(cast(ShippingAddress_ZipCode as nvarchar),'')) as ShippingDetails

from #TSupplOrdersCatalog

-- Address2 is not Null its ''
select 
ShippingAddress_Address2, 
ltrim(rtrim(ShippingAddress_Address2)) as TRIM_Address2
,len(ltrim(rtrim(ShippingAddress_Address2))) 
from #TSupplOrdersCatalog where ShippingAddress_Address2 is not null

------------------------Jeanette Request |  57353 ------------------------------------------

/*

----Xiaosen | To investigate orders from two different plans----

NH202107403996	VIVA Medicare Me H0154-014
NH202107403996	VIVA Medicare Plus (Seg 1 and seg 2) H0154-015
NH202107431724	VIVA Medicare Extra Value H0154-012
NH202107431724	VIVA Medicare Plus (Seg 1 and seg 2) H0154-015
NH202107434401	VIVA Medicare Extra Value H0154-012
NH202107434401	VIVA Medicare Plus (Seg 1 and seg 2) H0154-015
NH202107445010	VIVA Medicare Extra Value H0154-012
NH202107445010	VIVA Medicare Plus (Seg 1 and seg 2) H0154-015

*/
-- elig and master
select a.CreateDate, b.NHMemberID, a.BenefitStartDate, a.BenefitEndDate, a.recordEffDate,  a.IsActive, 
a.insCarrierID, a.insHealthPlanID, 
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = a.insCarrierID ), 
InsuranceHealthPlanName = (select HealthPlanName from Insurance.InsuranceHealthPlans ihp where ihp.InsuranceHealthPlanID = a.insHealthPlanID ), 
a.*, b.* from elig.mstrEligBenefitData a join master.members b on a.MasterMemberID =  b.MemberID  -- and a.Isactive =1 and b.IsActive =1
where 
b.NHMemberID in ('NH202107403996','NH202107431724','NH202107434401','NH202107445010')
order by a.MasterMemberID, a.CreateDate desc

select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID in (4127,4128,4126)
select * from orders.orders where NHMemberID in ('NH202107403996','NH202107431724','NH202107434401','NH202107445010') order by NHMemberID

----Xiaosen | To investigate orders from two different plans----


----------Catalog report for Kira | # 64736 -----------------------

-- Catalog Requests for  Experience Health

select * from insurance.InsuranceCarriers where InsuranceCarrierName like '%Experience%'
InsuranceCarrierID,	InsuranceCarrierName
343,	Experience Health

select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 343
InsuranceHealthPlanID, HealthPlanName
3247, Experience Health Medicare Advantage (HMO) H3777-001

IF OBJECT_ID('tempdb..#TSupplOrdersCatalog') IS NOT NULL DROP TABLE #TSupplOrdersCatalog
select * into #TSupplOrdersCatalog from (

select a.IsActive Orders_IsActive, b.IsActive as Members_IsActive, a.OrderID,  a.orderDate, a.NHMemberID, b.FirstName, b.LastName,

a.InsuranceCarrierID, 
InsuranceCarrierName = (select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = a.InsuranceCarrierID ), 
a.InsuranceHealthPlanId, 
InsuranceHealthPlanName = (select HealthPlanName from Insurance.InsuranceHealthPlans ihp where ihp.InsuranceHealthPlanID = a.InsuranceHealthPlanId ), 

a.ShippedDate
,json_value(a.ShippingAddress, '$.address.addressType') as ShippingAddress_AddressType
,json_value(a.ShippingAddress, '$.address.address1') as ShippingAddress_address1
,json_value(a.ShippingAddress, '$.address.address2') as ShippingAddress_address2
,json_value(a.ShippingAddress, '$.address.city') as ShippingAddress_city
,json_value(a.ShippingAddress, '$.address.state') as ShippingAddress_state
,json_value(a.ShippingAddress, '$.address.zipCode') as ShippingAddress_ZipCode

,a.Status, a.IsActive  --, a.*
from supplOrders.Orders a left join master.Members b on a.NHMemberID = b.NHMemberID and b.IsActive = 1
where 1=1 and 
a.InsuranceCarrierID in (343) and
a.Status in ( 'Shipped', 'Requested')
) a



select  NHMemberID,  upper(FirstName) as FirstName, upper(LastName) as LastName, Cast(OrderDate as Date) as OrderDate, year(OrderDate) as OrderYear, month(OrderDate) as OrderMonth, InsuranceCarrierName, InsuranceHealthPlanName, 
cast(ShippedDate as Date) as ShippedDate, ShippingAddress_AddressType as AddressType, ShippingAddress_Address1 as Address1 , ShippingAddress_Address2 as Address2 , ShippingAddress_City as City, ShippingAddress_State as State, ShippingAddress_ZipCode as ZipCode

,cast(cast(ShippedDate as Date) as nvarchar) + '  |  ' + ShippingAddress_AddressType + '  |  ' +
(IsNull(ShippingAddress_Address1,'') + ', ' + IsNull(ShippingAddress_Address2, '') + 

(CASE WHEN ltrim(rtrim(ShippingAddress_Address2)) <> ''  then ', '  else '' end)  +  IsNull(ShippingAddress_City,'') + ', ' + IsNull(ShippingAddress_State,'') + ' - ' + IsNull(cast(ShippingAddress_ZipCode as nvarchar),'')) as ShippingDetails

from #TSupplOrdersCatalog order by year(OrderDate) desc,  month(OrderDate) asc


-- No Of Catalogs per Month for Experience Health | Kira just request this only | 64736
select 1 as SNo, 'January' as [Order Month], Count(*) as [No Of Catalogs] from #TSupplOrdersCatalog
where OrderDate > = '01-01-2022' and OrderDate <= '01-31-2022'
union
select 2 as SNo, 'February' as [Order Month], Count(*) as [No Of Catalogs] from #TSupplOrdersCatalog
where OrderDate > = '02-01-2022' and OrderDate <= '02-28-2022'
union
select 3 as SNo,  'March' as [Order Month], Count(*) as [No Of Catalogs] from #TSupplOrdersCatalog
where OrderDate > = '03-01-2022' and OrderDate <= '03-31-2022'



---------- Catalog report for Kira | # 64736 -----------------------

NH202210702088

select * from master.members where NHMemberID = 'NH202210702088'
select * from elig.mstrEligBenefitData where MasterMemberID = 10702088

select * from auth.Userprofiles where Username like '%CCKAdolphe%'



select * from elig.clientCodes order by CreateDate desc

select * from information_schema.columns where table_name like '%clientcodes%'

select * from insurance.insuranceCarriers where InsuranceCarrierID in (367, 403)



select top 10  'elig.mstrEligBenefitData Active' as TableName, a.IsActive as IsActive_elig, b.isActive as IsActive_Members, SSBCI, a.insCarrierID, a.insHealthPlanId, a.NHlinkID, a.subscriberID, a.DOB,  b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID,  a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID and 
a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in ('NH202002303281' )) 
and a.isActive = 1 and a.insCarrierID = 302 and a.insHealthPlanID = 2692
order by a.mstrEligID desc


select * from orders.orders where NHMemberID in (select NhmemberID from master.members where MemberID in (select distinct masterMemberID from elig.mstrEligBenefitData a where a.isActive = 1 and a.insCarrierID = 269 and a.insHealthPlanID = 2544 ))
order by createdate desc

Gary Sherman - NH202002353450

insCarrierID	insHealthPlanId
269	2542 -- works
269	2544


select a.CreateDate, recordeffdate, recordenddate, * from elig.mstreligbenefitdata a where LastName like 'tran' and Firstname like 'LUONG' and  inscarrierid  = 302 and insHealthPlanID in (2690,4195) and isActive =1 
order by 1 desc

select a.CreateDate, recordeffdate, recordenddate, * from elig.mstreligbenefitdata a where LastName like 'LUONG' and Firstname like 'tran' and  inscarrierid  = 302 and insHealthPlanID in (2690,4195) and isActive =1 
order by 1 desc

select * from otcfunds.CardBenefitLoad_CI where inscarrierid  = 302 and insHealthPlanID in (2690,4195) and LastName like 'tran' and Firstname like 'LUONG'
select * from otcfunds.CardBenefitLoad_CI where inscarrierid  = 302 and insHealthPlanID in (2690,4195) and LastName like 'LUONG' and Firstname like 'tran'


select * from elig.ClientCodes where clientname like '%UAW%'
select * from insurance.insurancecarriers where insurancecarrierID = 398
select * from insurance.insuranceHealthPlans where insurancecarrierID = 398
select configtype, configdata from insurance.insuranceconfig where InsuranceCarrierID =  398 and configdata like '%walletto%'
{"multiplePlans":{"considerSingleBenefit":true,"walletToCheckFor":"UW01NB22"},"benefitsTypesForProductElig":[{"benefitType":"OTC","benefitName":"OTC"},{"benefitType":"GROCERY","benefitName":"GROCERY"}],"benefitsTypesForStoreLocator":[{"benefitType":"OTC","benefitName":"OTC"},{"benefitType":"GROCERY","benefitName":"GROCERY"}],"restrictedCardStatusForBenefitUtilization":["SUSPENDED","LOST","Fraud"]}



select * from otcfunds.CardBenefitLoad_CI where insCarrierID =  398

select * from elig.mstreligbenefitdata where insCarrierID =  398 and  getdate() between benefitstartdate and BenefitEndDate order by benefitstartdate desc
select * from master.members where memberID in ( 8334250, 7899812)

NH202107899812
NH202108334250
select carrierconfig from insurance.InsuranceCarriers where carrierconfig is not null and carrierconfig like '%wallet%'


select * from otcfunds.CardBenefitLoad_CI where inscarrierid  = 302 and LastName like 'LUONG' and Firstname like 'tran'

select * from elig.mstreligbenefitdata where NHLinkid in ( '00000159548' ,'00073787001' ) and isActive = 1
select * from master.members where NHLinkid in ( '00000159548' ,'00073787001' ) 

select CreateDate, benefitstartdate, benefitenddate, RecordEffDate, RecordEndDate, * from elig.mstreligbenefitdata where NHLinkid in ( '00073787001' ) 
--and isActive = 1 
order by 1 desc
select createdate, * from otcfunds.CardBenefitLoad_CI where NHLinkID = '00073787001'
select createdate, * from otcfunds.CardBenefitLoad_FD where NHLinkID = '00073787001' 
order by 1 desc
select * from master.MemberInsurances where ID in (18255972,11316047)


select top 10 * from orders.Orders
select top 10 * from orders.OrderItems

