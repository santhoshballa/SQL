/*
select * from otc.memberproducts  -- Contains the temporary products in the cart
*/

/*
select a.NHLinkID, b.NHLinkID, a.*, b.*
from 
Master.Members a left join elig.mstrEligBenefitData b on (a.NHLinkID= b.NHLinkID)
where
1=1 and a.NHLInkID is not null and b.NHLinkID is not null and b.dataSource = 'ELIG_MLNA'
and a.lastname like '%heindl%' and b.isactive =1  and a.NHLinkID = '00000182862' and a.DateOfBirth = '05/11/1956'--and b.address1 like '%heritage%' 
--and a.lastname like  '%Kucy%'
--and DOB = '08/10/1947'
--and b.SubscriberID = '%XYK%'

select * from member.MemberCards where NHMemberID in (select NHMemberID from master.members where MemberID in (Select MasterMemberID from elig.mstrEligBenefitData where datasource = 'ELIG_MLNA')
*/
-- select * from master.members where DateofBirth = '08/10/1947' and firstname like '%Sarah%'
--select * from Member.MemberCards where CardNumber = '6363012451091915329'

/* Get NHMemberID from SubscriberID 
select NHmemberID from Master.Members where Memberid in (select MasterMemberID from elig.mstrEligBenefitData where subscriberID in ( '00000116482','00000116480')  and IsActive = 1)
*/


/* Check Eligibility of Member in elig, staging tables

select 'elig.mstrEligBenefitData' as TableName, IsActive, * from elig.mstrEligBenefitData where subscriberID like '%800686446%' or (FirstName in ('Debra') and LastName in ('Giordano')) and isactive =1
select 'elig.errEligBenefitData' as TableName, * from elig.errEligBenefitData where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'
select 'elig.stgEligBenefitData' as TableName,  * from elig.stgEligBenefitData where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'
select 'elig.stgEligBenefitDataHist' as TableName, * from elig.stgEligBenefitDataHist where (FirstName in ('Debra') and LastName in ('Giordano')) and SubscriberID = '80068644600'

*/

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002293375')  -- ticket #  58301 -- Under Review, Paula Campbell 
--insert into #NHMemberIDTemp (NHMemberID)   values ('NH202107610381') -- ticket # 58265
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202208625264') -- ticket # 58265
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002294985') -- ticket # 58265
insert into #NHMemberIDTemp (NHMemberID)   values ('NH202210703502') -- ticket # 58265




/*
-- 37163
Please check eligibility file to verify that the members policy has been reinstated:
Plan: Florida Blue
MEMBER:CAMERON WORTH  
Member ID:XJRH35599638
ADDRESS/PHONE NUMBER:6110 SEMINOLE CIR, RIVIERA BEACH, FL - 33407//561-268-9457
NH:NH202106477686

select top 10 'master.members' as TableName, a.datasource, a.NHMemberID, a.NHLinkID, a.MemberID, a.CreateUser, a.CreateDate
from Master.Members a where a.datasource = 'ELIG_ALGN' and IsActive =1  -- NHMemberID in (select NHMemberID from #NHmemberIDTemp) 

select * from orders.orders where NHMemberID in (select top 10 a.NHMemberID from Master.Members a where a.datasource = 'ELIG_ALGN' and IsActive =1 and CreateDate > (getdate()-90))

select a.*, b.*, c.* from elig.mstrEligBenefitData a join master.Members b on a.NHlinkID= b.NHlinkID left join orders.orders c on b.NHMemberID = c.NHMemberID  where insCarrierID =  '258' and insHealthPlanID = '2433' and a.isActive =1 and b.isActive =1 and c.IsActive =1 
order by c.CreateDate desc


-- Insurance Carriers, HealthPlans query
select 
b.InsuranceCarrierID, b.insuranceCarrierName, b.IsActive as InsuranceCarrier_IsActive,
a.InsuranceHealthPlanID, a.HealthPlanName, a.HealthPlanNumber, a.IsActive as HealthPlan_IsActive
from insurance.InsuranceHealthPlans a left join insurance.InsuranceCarriers b on a.InsuranceCarrierID = b.InsuranceCarrierID
where
a.HealthPlanName  in ('Alignment Health Plan NC H5296-003','Alignment Health Plan CA H3815-018','Alignment Health Plan CA H3815-801','Alignment Health Plan NC H6306-005')

*/


-- Alignment Special File, This file is loaded by Srikanth. IF present in this file, extra OTC benefits provided.

select 'AlignmentSpecialFile' as AlignmentSpecialFile, '[Master].[AlignmentSpecial009Members]' as TableName, * from [Master].[AlignmentSpecial009Members] where SubscriberID in (Select subscriberID from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberid from #NHmemberIDTemp )))


select isnull(NHMemberID, 'No Member Found') as NHMemberID,
'curl '+ '"'+
'https://nbotc-prod-centus-fis-api-app.azurewebsites.net/GetCardAccountDetails/'+CardReferenceNumber+'?carrierId='+Cast(InsuranceCarrierID as Varchar)+'&healthPlanId='+cast(InsuranceHealthPlanID as varchar) +'"' as FIS_CurlURL
from Member.MemberCards
where 
InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and CardVendor ='fis' and IsActive = 1 
and NHMemberID in (select NHmemberid from #NHmemberIDTemp )


select distinct top 5 NhMemberID,

'curl -X POST '+ '"'+ 
'https://externalserviceotc.azurewebsites.net/api/OTC/WEX/GetBalance' + '"'+ ' -H ' + '"' + 'accept: application/json'+ '"'+ ' -H ' +'"' + 'Content-Type: application/json-patch+json' + '"' + ' -d ' + '"'+
'{\"administratorAlias\":\"'+cast(adminalias as nvarchar)+ '\",\"consumerIdentifier\":\"'+cast(employeeNumber as nvarchar)+'\",\"employerCode\":\"'+cast(EmployerCode as nvarchar)+'\",\"planYearName\":\"'+cast(planYearName as nvarchar)+'\",\"planYearStartDate\":\"'+cast(PlanYearStartDate as nvarchar)+'\",\"planName\":\"'+ cast(planName as nvarchar) +'\"}"'

as WEX_CurlURL
from otc.MemberEligibility where 1=1 
and cast(getdate() as date) between PlanYearStartDate and PlanYearEndDate 
and (NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
and InsuranceCarrierId in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and 
( 
InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
or InsuranceHealthPlanID is null
)


-- Check for MemberID, WEX card, carrier and plan
select distinct top 5 'WexQuery | CurrentPlanYearOnly' as WEXCurrentPlanYearOnly, 'otc.MemberEligibility' as TableName,  isnull(NHMemberID, 'Member Not Found') as NHMemberID, 
isnull(cast(insuranceCarrierID as nvarchar), 'Not Found') as InsuranceCarrierID,  isnull((select InsuranceCarrierName from [Insurance].[InsuranceCarriers] ic where ic.insurancecarrierid = me.[InsuranceCarrierID] ), 'Not Found') as InsuranceCarrierName ,
isnull(cast(insuranceHealthPlanID as nvarchar),'Not Found') as InsuranceHealthPlanID, isnull((select HealthPlanName from [Insurance].[InsuranceHealthPlans] ihp where ihp.InsuranceHealthPlanID = me.InsuranceHealthPlanID ), 'Not Found') as InsuranceHealthPlanName, 
PlanYearStartDate, PlanYearEndDate from otc.MemberEligibility me where getdate() between PlanYearStartDate and PlanYearEndDate
and NHMemberID in (select NHMemberID from #NHmemberIDTemp)


-- Members information
select 'master.members' as TableName, a.IsActive, a.datasource,a.NHMemberID, a.NHLinkID, a.MemberID, a.CreateUser, a.CreateDate
from Master.Members a where NHMemberID in (select NHMemberID from #NHmemberIDTemp)

/*
-- Eligibility Stage Loading Table
select 'elig.stgEligBenefitDataHist' as TableName, * from elig.stgEligBenefitDataHist where FirstName in (select Firstname from master.members where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
and LastName in (select LastName from master.members where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
*/

---Eligibility by Multiple MemberID's
select 'elig.mstrEligBenefitData Active' as TableName,a.IsActive as IsActive_elig, b.isActive as IsActive_Members, mstrEligID, a.NHlinkID, b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID and 
a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) 
and a.isActive = 1
order by a.mstrEligID desc


---Eligibility by Multiple MemberID's
select 'elig.mstrEligBenefitData ALL' as TableName,a.IsActive as IsActive_elig, b.isActive as IsActive_Members, mstrEligID, a.NHlinkID, b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID and 
a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) 
--and a.isActive = 1
order by a.mstrEligID desc

-- Master Member Info
select 'Master.Members' TableName,IsActive,
[MemberID],[NHMemberID],[FirstName],[MiddleInitial],[LastName], cast([DateOfBirth] as date) [DateOfBirth],[Gender],[IsActive],[Title],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser], datasource,NHLinkID
 From master.members where NHMemberid in (select NHMemberID from #NHMemberIDTemp )

 -- Address
 select 'Master.Addresses' TableName,IsActive,
Id,[AddressTypeCode],[Address1],[Address2],[City],[State],[ZipCode],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],IsPreferredaddress
  From [Master].[Addresses]
  where memberid in (select memberid From master.members where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))
  order by ID

 --Insurances
select 'Master.MemberInsurances' TableName,IsActive,id,MemberID,
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
 from  [Master].[MemberInsurances] mi where memberid in (select memberid From master.members where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))
 order by mi.ID

 -- Insurance Details
SELECT 'Master.MemberInsuranceDetails' TableName, IsActive,*
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances] 
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (select NHMemberID from #NHMemberIDTemp)
													   )
							)
order by ID

-- Check the IV Status of the member
SELECT 'Master.MemberInsuranceDetails' TableName, IVQStatus,*
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances] 
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (select NHMemberID from #NHMemberIDTemp)
													   )
							)
order by ID


select 'otc.userProfiles' as TableName,IsActive, * from otc.userProfiles where NHMemberID in ( select NHmemberID from #NHMemberIDTemp)
select 'otc.UserProfileSecretAnswers' as TableName,IsActive, * from [otc].[UserProfileSecretAnswers] where userProfileID in (select UserProfileID from otc.userProfiles where NHMemberID in ( select NHmemberID from #NHMemberIDTemp))

--Information sent to FIS
select 'otcfunds.CardBenefitLoad' as TableName, IsActive, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, * from otcfunds.CardBenefitLoad where NHLinkid in (select NHLinkID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)) order by 1
select 'flex.DetailRecord' as TableName , * from flex.DetailRecord where NHLinkID in (select NHLinkID from Master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))
select 'fisxtract.Monetary' as TableName, PANProxyNumber,CardNumberProxy,* from fisxtract.Monetary where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
select 'fisxtract.NonMonetary' as TableName,PANProxyNumber,CardNumberProxy,* from fisxtract.NonMonetary where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))  order by 3
select 'fisxtract.[Authorization]' as TableName, PANProxyNumber,CardNumberProxy,* from fisxtract.[Authorization] where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
select * from otcfunds.CardBenefitLoad where benefitcardnumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp )) order by 1 desc




select 'WalletMapping' as Query, 'flex.FISWalletMapping' as TableName, IsActive, * from flex.FISWalletMapping where
CarrierID in  (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and HealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))

select 'ConfigWallet' as Query, 'insurance.InsuranceConfig' as TableName, IsActive, * from insurance.InsuranceConfig where
insuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and 
(
InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
or InsuranceHealthPlanID is null
)
-- and ConfigType = 'OTCLOGIN'

select top 10 'WalletCode to FIS' as WalletCodeToFis, 'otcfunds.CardBenefitLoad' as TableName, IsActive, * from otcfunds.CardBenefitLoad where NBWalletCode in 
( 
		select  distinct JSON_VALUE(c.BenefitRuleData, '$.WALCODE')	[WalletCode]
		from insurance.ContractRules a 
		left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
		left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
		left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
		left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
		where 1=1 and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
		and ins.InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
		and (ihp.InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
			 --or ihp.InsuranceHealthPlanID is null
			 )
)
and InsCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
--and InsHealthPlanID = 4197
and InsHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))


select 
distinct 
 a.insCarrierID, (select b.insuranceCarrierName from insurance.InsuranceCarriers b where b.InsuranceCarrierID = a.insCarrierID ) as InsuranceCarrierName
,a.InsHealthPlanID, (select c.HealthPlanName from insurance.InsuranceHealthPlans c where c.InsuranceHealthPlanID = a.InsHealthPlanID) as InsuranceHealthPlanName
,a.benefitSource, a.NBWalletCode, a.BenefitValidFrom, a.BenefitValidTo, a.BenefitYear
--,a.BenefitAmount 
from otcfunds.CardBenefitLoad a 
where 1=1
and a.BenefitAmount is not null
and a.insCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and a.InsHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))) 
order by 3

--otc Cards
select 'Member.MemberCards' as TableName,IsActive, * from Member.MemberCards where NHMemberID in (select NHMemberID from #NHMemberIDTemp)


--Benefits

-- All Contracts, Insurance, HealthPlans that are Actives
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


-- Wallets for the Member

-- Use this template to check Wallet Information | 01/05/2021
select 'Wallets' as WalletsQuery, IsActive,'otccatalog.wallets' as TableName, * from otccatalog.wallets 
where WalletCode in 
( 
		select  distinct JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[WalletCode]
		from insurance.ContractRules a 
		left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
		left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
		left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
		left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
		where 1=1 and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
		and ins.InsuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
		and (ihp.InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
			 or 
			 ihp.InsuranceHealthPlanID is null)
)


-- walletID's
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

select distinct 'Items' as 'CatalogQuery', 'otccatalog.ItemMaster' as tablename,IsActive,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.Wallets' as tablename,IsActive, * from otccatalog.Wallets where WalletID in (select walletID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select distinct 'otccatalog.WalletPlans' as TableName,IsActive,* from otccatalog.WalletPlans where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID)
select distinct 'otccatalog.WalletItems' as TableName,IsActive,* from otccatalog.WalletItems where WalletID in (select WalletID from #TWalletID) -- and NationsId = 5888
select distinct 'otccatalog.GetPlanWalletMap' as TableName,'NotAvailable' as IsActive,* from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from #TWalletID) and InsuranceCarrierID in (select distinct InsuranceCarrierId from #TWalletID) and InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from #TWalletID)
select distinct 'otccatalog.WalletOverrides' as TableName,IsActive, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (select WalletID from #TWalletID) ) 
select distinct 'otccatalog.WalletPlanOverrides' as TableName,IsActive, * from otccatalog.WalletPlanOverRides where WalletPlanID in (select WalletID from #TWalletID) 
select distinct 'otccatalog.WalletItemsHistory' as TableName,IsActive,* from otccatalog.WalletItemsHistory where WalletID in (select WalletID from #TWalletID)


/*
---Eligibility by Multiple MemberID's
select 'elig.mstrEligBenefitData' as TableName, mstrEligID, a.CreateDate, a.ModifyDate, a.dataSource, a.NHlinkID, b.NHMemberid, a.subscriberID, a.firstname, a.lastname, a.DOB, a.Isactive, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate,   a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID and 
a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) order by a.mstrEligID
*/


/*
select 'elig.mstrEligBenefitData' as TableName, a.CreateDate, a.ModifyDate, a.dataSource, a.NHlinkID, b.NHMemberid, a.subscriberID, a.firstname, a.lastname, a.DOB, a.Isactive, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate,   a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from #NHmemberIDTemp t
join Master.members b  on t.NHMemberID = b.nhmemberid
join  elig.mstrEligBenefitData a on b.nhlinkid = a.nhlinkid
*/





--Phone Numbers
select 'Master.PhoneNumbers' TableName, [MemberID],[PhoneTypeCode],[PhoneNbr],[CreateDate],[CreateUser],[ModifyDate], [ModifyUser] 
From [Master].[PhoneNumbers]
where memberid in (select memberid From master.members where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))

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
  ReferenceIDsData,
  *
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
WHERE membernhmemberid in (select NHMemberID from #NHMemberIDTemp )
ORDER BY cc.[CallConversationId] DESC


-- Call Conversations, Call Pageevents and Call Notes
select * from callcenter.callconversations where MemberNHMemberId in (select NHMemberID from #NHMemberIDTemp )
select * from callcenter.CallPageEvents where CallConversationId in (select CallConversationId from callcenter.callconversations where MemberNHMemberId in (select NHMemberID from #NHMemberIDTemp ))
select * from callcenter.CallNotes where CallConversationId in (select CallConversationId from callcenter.callconversations where MemberNHMemberId in (select NHMemberID from #NHMemberIDTemp ))


--Check appointments----
select 'provider.MemberCharts' as TableName,* from [provider].[MemberCharts]
where memberprofileid in (
							select memberprofileid from [provider].[MemberProfiles]
							where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
						 )
order by MemberChartId


select 'provider.MemberCharts' as TableName, * from [provider].[MemberChartData]
where memberchartid in (select memberchartid from [provider].[MemberCharts]
						where memberprofileid in ( select memberprofileid from [provider].[MemberProfiles]
												   where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))
												 )
order by MemberChartDataId


select 'provider.MemberAppointments' as TableName, * from [provider].[MemberAppointments] ma
where 1 = 1 and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
))
 )order by 1 desc

select 'provider.MemberAppointments_History' as TableName, *
from [provider].[MemberAppointments_History] ma
where 1 = 1
and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
))
 )order by 2 desc

--Check orders----------


select 'Orders.Orders' as TableName,IsActive, * from orders.orders where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
order by OrderID


select 
'Orders.Orders' as TableName,
*, -- all columns

--MemberData
MemberData
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
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions0_catalogName
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

,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions1_catalogName
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
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
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


from orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp )





select
'Orders.orderitems' as TableName
, *
-- ItemData
,json_value(orderItems.ItemData, '$.color') as ItemData_color
,json_value(orderItems.ItemData, '$.batterySize') as ItemData_batterySize
,json_value(orderItems.ItemData, '$.receiverSize') as ItemData_receiverSize
,json_value(orderItems.ItemData, '$.receiverPower') as ItemData_receiverPower
,json_value(orderItems.ItemData, '$.earMold') as ItemData_earMold
,json_value(orderItems.ItemData, '$.serialNbr') as ItemData_serialNbr

,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.nationsId') as ItemData_nationsId
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName

,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode

,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
--Others
,json_value(orderItems.ItemData, '$.sendingImpression') as ItemData_sendingImpression

from Orders.orderItems where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))

/*

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 355
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = (select InsuranceCarrierID FROM insurance.InsuranceCarriers where InsuranceCarrierID = 355)


-- Ticket Information and Queries

Ticket # 34522 | NH202002764911 (given in the ticket) | NH202006181939 (found in elig.mstrEligBenefitData)
Account created by CallCenter through the portal, the NHMemberID is available which was provided by the callcenter staff. 
The eligibility of this member is with a different NHMemberID, search the Master.members, find the first and last name and find the member in the elig.mstrEligBenefitData file
Check his Plan, address details and find the correct MemberID 

select * from elig.mstrEligBenefitData where firstname like '%thomas%' and lastname like 'bishop' and address1 like '5441 LANGWELL DR' order by createdate desc
select * from master.Members where NHLinkID = 'MEBTP6GJ' -- to check the correct NHMemberID



Ticket # 34505 | Contains duplicate wallets for the memberID | NH202005636678
The card number is 6102812311047824096, check the OTC store using the card number.


 Ticket # 34588
IF OBJECT_ID('tempdb..#MemberInsurance') IS NOT NULL DROP TABLE #MemberInsurance
select * from provider.MemberInsurances where MemberInsuranceID = '302354'
select * into #MemberInsuranceTemp from (
select * from provider.MemberInsurances  where MemberInsuranceID = '302354'
) a

select * from #MemberInsuranceTemp
begin tran
update #MemberInsuranceTemp set insuranceType = 'Primary' where MemberInsuranceID = '302354'
select * from #MemberInsuranceTemp
rollback tran


update provider.MemberInsurances set insuranceType = 'Primary' where MemberInsuranceID = '302354'

/*
select insurancecarriername,* from 	insurance.insurancecarriers where 	insurancecarrierid= 343

select * from 	Member.MemberCards where nhmemberid = 'NH202005714237'
*/


insert into Member.MemberCards 
values ('NH202005714237','NH202005714237','','','','',getdate(),getdate(),1,null,343,null)

select * from Member.MemberCards where cardnumber = '6102812731008017747'
select * from insurance.InsuranceCarriers where InsuranceCarrierID = 359

--only these plans are present for ClientCarrierID
select distinct a.InsuranceCarrierID, a.InsuranceCarrierName, b.InsuranceHealthPlanID, b.HealthPlanName
from insurance.InsuranceCarriers a join insurance.InsuranceHealthPlans b on a.InsuranceCarrierID=b.InsuranceCarrierID 
where a.InsuranceCarrierID in (select distinct clientcarrierid from Member.MemberCards)




--  Ticket #35063
('NH202106549278'), --new 
('NH202002469750')  --old


Call Conversations
-- There is a 4 hour difference between EST and Getdate(), add 4 hours to EST
select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 06, 16, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 06, 16, 10, 00, 00, 00 )
and CreateUser like 'sballa'

1218757	12913	SBalla	MNT	NULL	0000000000	NULL	0000000000	2021-04-06 16:00:06.0571150	SBalla	2021-04-06 16:02:30.5256748	2021-04-06 16:02:24.6936303	2021-04-06 16:02:24.6532087	1	NULL	NH202005659504	2021-04-06 16:02:30.5721736	SBalla	1	2021-04-06 16:00:06.0506798

*/


/*+
Correct and current account w/ Quartz (NVA) health plan:
Jay Baukin - NH202106555967

duplicate/previous accounts:
Jay Baukin NH202002375196

duplicate/previous accounts:
Jay Baukin -NH202002411718

*/

/*
select * from Member.MemberCards where NHMemberID = 'NH202002580388' -- not found

OTCSerialNumber | 231207580
CardNumber | 6102812831002181687
select * from master.MemberInsuranceDetails where id = 2578983

update Member.MemberCards set NHMemberID = 'NH202002580388' where CardID = 124688 -- CardNumber 6102812831002181687
update master.MemberInsuranceDetails set OTCCardNumber = '6102812831002181687' where id = 2578983
update master.MemberInsuranceDetails set OTCSerialNumber = '231207580' where id = 2578983

*/

/*OLD TICKETS
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107098791')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106779994')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106978675')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106708146')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202001969506')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002210527')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106765843')  -- 42901
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005443975')  -- # 42965
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106765843')  -- # 42877
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004745183')  -- # 42655
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005443975')  -- # 42965
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106774922')  --# 42874
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002414895')  --# 42823
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106779718')  -- #42880
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002837977')  -- #42701 -- call center, no orders
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002580388')  -- #42701 --in the request, right one elig
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002210527')  -- #42768 --
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002414895')  -- #42823 --
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004832037')    -- #43449 --
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002540848')  -- 43358
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002507224')  -- 43358
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106972569')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002295183')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004865995')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002340452')    --43457
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106554194')    -- 42306  Rebecca Heindl 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106684620') --42895
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202006133690') -- 43390
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002752995')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106973235')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002125285')  -- 43194
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002536714')  -- 43194
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005108137')  -- 43194
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002536714')  -- 43194
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106780955')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106973235')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002316282')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002581181')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106684928')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002556271')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005643720')  --39254
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002179849') -- 42628
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106765843') -- 42628
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002853330') -- 45071 Deborah Khan -- done
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002853294') -- 45071 Arif Khan
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002842861') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002206426') -- 44703
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002720411') -- # 44674

--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901284507') -- # 43486
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202004786359') -- # 44418

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005628125') -- issue
----insert into #NHMemberIDTemp (NHMemberID) values ('NH202005611816') -- 
----insert into #NHMemberIDTemp (NHMemberID) values ('NH202106993779') -- no issue
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005628129') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002798539') -- old
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005058950')  -- new

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106522510') -- 45949

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106567498') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107256820')

*/



/*
Work in Progress, verifying eligibility of the member.

There is no eligibility information from the carrier, Thank you.
*/
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106560803')

/*
--38677

Please check eligibility file to verify that the members policy has been reinstated:
Plan:HAP COMMUNITY CARE OK
MEMBER:JERRY MYERS
Member ID:C0029146401
ADDRESS/PHONE NUMBER:11003 East 97th street North, Owasso, OK - 74055//918-272-3557
NH:NH202106900042

*/

/*
--38716
Please check eligibility file to verify that the members policy has been reinstated:
Plan:HAP COMMUNITY CARE OK
MEMBER:Frank Curry
Member ID:c0038915701
ADDRESS/PHONE NUMBER:Po box 1045 , Pawhuska, OK - 74056//918-287-3167
NH:NH202106900104

insert into #NHMemberIDTemp (NHMemberID) values ('NH202106900104')





--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005618695') -- David Truong -- not working
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106790747') -- XUAN VO -- not working
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005604829') -- Africa Dizon -- not working
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002606071') --Janne RoseCrans
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107393611') -- Arttiss
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107090726')  -- Maria gonzalez
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107323866')  -- Mejan Sullivan
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106750864')  -- Mary Ryan
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901332346')  -- Prime Card II
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107396329')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202106563870')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106521914')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106893496') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106893494')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106854007')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002741125') -- Carolyn Porto
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107033768') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106712852') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106772327') -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210317678') --  Candace Pider
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901964720') --  USAN MAGRATH
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005667747') --  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005613703') 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005953463')  -- joseph miceli
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107508931')  -- JUDITH		BASHIN
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107509150')  -- JUDITH		BASHIN
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107509081')  -- Guadalupe Palacios
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005646384')  -- {"firstName":"LETICIA","lastName":"MARTINEZ","phoneNumber":"6195872872","email":"letymtz53@gmail.com","address":{"address1":"1734 SOLSTICE AVE","address2":"APT 121","city":"CHULA VISTA","state":"CA","zip":"91915","county":null,"country":"USA"},"shippingInstructions":null,"verifyShippingAddress":true,"memberPrefrences":null,"additionalShippingInfo":null}
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005607846')
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202106659150')
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107377752')  -- Andy Chung S
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002198929')  -- Gennaro Parise -- 53616
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005645755')  -- Le TIEU -- 53613
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002417246')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202108462872')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002310998')  -- 55571, Capital blue cross - NH202002310998
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106655246')  -- 55559, Capital blue cross - NH202106655246
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005647980')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106659150')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107339288')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH201901393855')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106659150')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202210392075')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH201800428651')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202005953463')  -- 
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002204193')  -- 
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002175427')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002177883')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107079694')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202108512290')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002824635')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107230279')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002310063')  -- ticket #56862


--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106533957')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106403481')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106417052')  -- ticket #
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106422765')  -- ticket #

--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002308216')  -- ticket #
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202005641339')  -- ticket # 56886
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005679964')  -- ticket # 56886
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005674133')  -- ticket #  56875
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202208622601')  -- ticket #  56875
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005674133')  -- ticket #  56875
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202107079694')  -- ticket #  56870
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107230279')  -- ticket #  56867
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107184089')  -- ticket #  56867
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202107393236')  -- ticket #  56867



*/



