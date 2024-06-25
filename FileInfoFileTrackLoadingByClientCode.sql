/*

SELECT DISTINCT SubProgramID,FIS_PurseName,FIS_PurseSlot,BenefitFrequencyMonths FROM flex.FISWalletMapping WHERE CarrierID = 417 AND SubProgramID = '115980' AND FIS_Status = 'A' ORDER BY SubProgramID,FIS_PurseName,FIS_PurseSlot 
SELECT DISTINCT SubProgramID,FIS_PurseName,FIS_PurseSlot,BenefitFrequencyMonths FROM flex.FISWalletMapping WHERE CarrierID = 417 AND SubProgramID != '115980' AND FIS_Status = 'A' ORDER BY FIS_PurseName,FIS_PurseSlot

select DISTINCT [Subprogram ID],PurseName,PurseNo
from NationsBenefits_LLC_Data_for_ClientId_995407
where 1=1
AND [Client ID]= 863876
AND [Subprogram ID] = 115980
--AND PurseName like 'U%'
ORDER BY [Subprogram ID],PurseName,PurseNo

select * from information_schema.columns where column_name like '%slot%' order by table_schema

select * from flex.FISWalletMapping_ACC_Tool
select * from flex.FISWallets
select * from nb.Purse
select * from flex.MasterFundAccounts
select * from fis.PurseCashRule
select top 100 * from MarketingCatalog.Clients
select top 100 * from MarketingCatalog.FileInfo
select top 100 * from MarketingCatalog.FileTrack
select top 100 * from MarketingCatalog.FTPUserInfo
select top 100 * from MarketingCatalog.Fulfillment_Member_Counts
select top 100 * from MarketingCatalog.Fulfillmenttype
select top 100 * from MarketingCatalog.Fullfilment_Member_log
select top 100 * from MarketingCatalog.FullfilmentMailing
select top 100 * from MarketingCatalog.FullfilmentVendor
select top 100 * from MarketingCatalog.ItemCodes
select top 100 * from MarketingCatalog.Languagecodes
select top 100 * from MarketingCatalog.PackageCodes
select top 100 * from MarketingCatalog.Packagecodes_to_healthplans


---NationsBenfits Purse Information
select * from nb.Purse where PlanID in (select InsuranceHealthPlanId from insurance.InsuranceHealthPlans where InsuranceCarrierID in (select InsuranceCarrierID from elig.ClientCodes where ClientCode in ( select ClientCodes from #ClientCodesTemp)))
select * from nb.Purse where PlanID in (select InsuranceHealthPlanId from insurance.InsuranceHealthPlans where InsuranceCarrierID in (select distinct InsuranceCarrierID from elig.ClientCodes ))
and IsDeprecated <> 1 order by planID, PurseOrder

/*
-- New Files
Alignment FLorida
LA Care Medicare
New Hanover
BCBS Arizona
*/

*/
select * from elig.ClientCodes where ClientName like '%Alignment%' and ClientName like '%FL%' -- H678
select * from elig.ClientCodes where ClientName like '%Medicare%'  -- H667
select * from elig.ClientCodes where ClientName like '%Hanover%'  -- H626
select * from elig.ClientCodes where ClientName like '%BCBS%' and ClientName like '%AZ%' -- H642


IF OBJECT_ID('tempdb..#ClientCodesTemp') IS NOT NULL DROP TABLE #ClientCodesTemp
Create table #ClientCodesTemp 
(ClientCodes varchar(20))

insert into #ClientCodesTemp (ClientCodes) values ('H678') -- Alignment
--insert into #ClientCodesTemp (ClientCodes) values ('H667') -- LA Care Medicare
--insert into #ClientCodesTemp (ClientCodes) values ('H626') -- New Hanover
--insert into #ClientCodesTemp (ClientCodes) values ('H642') -- BCBS Arizona
-- ticket #  58301 --
select * from information_schema.columns where table_name like 'FileInfo' and column_name like '%FileInfo%'

select 'elig.ClientCodes' as ClientCodes_TableName, ClientCode, ClientName from elig.ClientCodes where ClientCode in ( select ClientCodes from #ClientCodesTemp)
select 'elig.FileInfo' as FileInfo_TableName,* from elig.FileInfo where direction = 'IN' and ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 5 'elig.FileTrack | top 5' as FileTrack_Top5_TableName,a.CreateDate, a.DateReceived,  * from elig.FileTrack a with (nolock)  where DirectionCode = 'IN' and ClientCode in (select ClientCodes from #ClientCodesTemp with (nolock) )
select 'elig.rawEligBenefitData' as rawEligBenefitData_TableName,* from elig.rawEligBenefitData with (nolock)  where ClientCode in (select ClientCodes from #ClientCodesTemp)
select 'elig.stgEligBenefitData' as stgEligBenefitData_TableName,* from elig.stgEligBenefitData with (nolock) where DataSource in ( select distinct datasource from elig.clientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))
select 'elig.errEligBenefitData' as errEligBenefitData_TableName,* from elig.errEligBenefitData with (nolock) where DataSource in ( select distinct datasource from elig.clientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))
select top 100 'elig.mstrEligBenefitData' as 'mstrEligBenefitData_TableName', * from elig.mstrEligBenefitData with (nolock) where DataSource in ( select distinct datasource from elig.clientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))
select top 100 'otcfunds.CardBenefitLoad_CI' as TableName, IsActive, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, * from otcfunds.CardBenefitLoad_CI with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'otcfunds.CardBenefitLoad_FD' as TableName, IsActive, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, * from otcfunds.CardBenefitLoad_FD with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.Clients' as MarketingCatalogClients_TableName,* from MarketingCatalog.Clients with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.FileInfo' as MarketingCatalogFileInfo_TableName,* from MarketingCatalog.FileInfo  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.FileTrack' as MarketingCatalogFileTrack_TableName,* from MarketingCatalog.FileTrack  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.FTPUserInfo' as MarketingCatalogFTPUserInfo_TableName,* from MarketingCatalog.FTPUserInfo  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.ItemCodes' as MarketingCatalogItemCodes_TableName,* from MarketingCatalog.ItemCodes with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.Languagecodes' as MarketingCatalogLanguagecodes_TableName,* from MarketingCatalog.Languagecodes  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.PackageCodes' as MarketingCatalogPackageCodes_TableName,* from MarketingCatalog.PackageCodes  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.Packagecodes_to_healthplans' as MarketingCatalogPackagecodes_to_healthplans_TableName,* from MarketingCatalog.Packagecodes_to_healthplans  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 100 'MarketingCatalog.Fullfilment_Member_log' as MarketingCatalogFullfilment_Member_log_TableName, * from MarketingCatalog.Fullfilment_Member_log  with (nolock) where DataSource in (select datasource from elig.ClientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))

-- File Info by ClientCode
select top 10 'elig.FileInfo' as elig_FileInfo_TableName, * from elig.FileInfo where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 10 'otcfunds.FileInfo' as otcfunds_FileInfo_TableName,* from otcfunds.FileInfo  where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 10 'fisxtract.FileInfo' as fisxtract_FileInfo_TableName,* from fisxtract.FileInfo with (nolock) where DataSource in (select datasource from elig.ClientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))
select top 10 'mft.FileInfo' as mft_FileInfo_TableName,* from mft.FileInfo  where ClientCode in (select ClientCodes from #ClientCodesTemp)
select top 10 'MarketingCatalog.FileInfo' as MarketingCatalog_FileInfo_TableName,* from MarketingCatalog.FileInfo  where ClientCode in (select ClientCodes from #ClientCodesTemp)

-- select top 100 * from MarketingCatalog.Fulfillment_Member_Counts  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
-- select top 100 * from MarketingCatalog.Fulfillmenttype  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
-- select top 100 * from MarketingCatalog.Fullfilment_Member_log  with (nolock) where DataSource in (select datasource from elig.ClientCodes where ClientCode in (select ClientCodes from #ClientCodesTemp))
-- select top 100 * from MarketingCatalog.FullfilmentMailing  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)
-- select top 100 * from MarketingCatalog.FullfilmentVendor  with (nolock) where ClientCode in (select ClientCodes from #ClientCodesTemp)

















--select 'flex.DetailRecord' as TableName , * from flex.DetailRecord where NHLinkID in (select NHLinkID from Master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))
--select 'fisxtract.Monetary' as TableName, PANProxyNumber,CardNumberProxy,* from fisxtract.Monetary with (nolock)  where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))
--select 'fisxtract.NonMonetary' as TableName,PANProxyNumber,CardNumberProxy,* from fisxtract.NonMonetary with (nolock)  where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))  order by 3
--select 'fisxtract.[Authorization]' as TableName, PANProxyNumber,CardNumberProxy,* from fisxtract.[Authorization] with (nolock)  where PANProxyNumber in (select CardReferenceNumber from member.membercards where NHMemberID in (select NHmemberid from #NHmemberIDTemp ))

/*

select 'elig.ClientCodes' as ClientCodes_TableName, ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
select 'elig.ClientCodes' as ClientCodes_TableName, * from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
select 'elig.FileInfo' as FileInfo_TableName,* from elig.FileInfo where direction = 'IN' and
ClientCode in (select ClientCode from elig.ClientCodes where datasource in (select datasource from elig.mstrEligBenefitData where MasterMemberID in (select MemberID from master.Members where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
Order by FileInfoID desc

select top 5 'elig.FileTrack | top 5' as FileTrack_Top5_TableName,a.CreateDate, a.DateReceived,  * from elig.FileTrack a with (nolock)  where DirectionCode = 'IN' and 
ClientCode in (select ClientCode from elig.ClientCodes with (nolock)  where datasource in (select datasource from elig.mstrEligBenefitData with (nolock) where MasterMemberID in (select MemberID from master.Members with (nolock) where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
order by datasource, FiletrackID desc, FileInfoID desc, a.DateReceived Desc

select 'elig.rawEligBenefitData' as rawEligBenefitData_TableName,* from elig.rawEligBenefitData with (nolock)  where 
ClientCode in (select ClientCode from elig.ClientCodes with (nolock)  where datasource in (select datasource from elig.mstrEligBenefitData with (nolock)  where MasterMemberID in (select MemberID from master.Members with (nolock)  where NHMemberID in (select NHmemberID from #NHMemberIDTemp))))
order by FiletrackID desc

select 'elig.stgEligBenefitData' as stgEligBenefitData_TableName,* from elig.stgEligBenefitData with (nolock)  where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData with (nolock)  where MasterMemberID in (select MemberID from master.Members with (nolock)  where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc

select 'elig.stgEligBenefitDataHist' as stgEligBenefitDataHist_TableName,* from elig.stgEligBenefitDataHist with (nolock)  where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData with (nolock)  where MasterMemberID in (select MemberID from master.Members with (nolock)  where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc

select 'elig.errEligBenefitData' as errEligBenefitData_TableName,* from elig.errEligBenefitData with (nolock)  where SubscriberID in (select SubscriberID from elig.mstrEligBenefitData with (nolock)  where MasterMemberID in (select MemberID from master.Members with (nolock)  where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
order by Filetrackid desc

*/

