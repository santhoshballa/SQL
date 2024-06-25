/*
Ticket # 42327
Member Name | Heather Bar
Carrier | Optima Health
Item # 5447
*/

select * from information_Schema.columns where table_schema='catalog'

select * from information_schema.columns where table_schema = 'otc'

select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_schema = 'otc'
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and table_name not in ('MemberEligibility1','Catalogs_NOT_IN_USE','InCommCatalogHealthPlans_NOT_IN_USE','ProductCosts_NOT_IN_USE','ProductCatalogs_NOT_IN_USE','Cards_MismatchBak2Jan2021','Cards_bkp_20201231','MemberEligibility_bkp_20210401_beforeHFHP_Q2','ProductCategories_NOT_IN_USE')
and table_name in (  'MemberDiseaseStates','GaTrackingDetails','UserProfilesExternalSources','TrackingDetails','CarrierAgents','Config','QBCOGSDetailsByOrder',
'ViewGetMasterList','Cards','ReshipmentRequests','CardsExternalSources','CardsCatalogs','Subscriptions','ProductPrices','RemittanceReport','QBOTCProductPrices','Tokens',
'FileItems','tempSource','MemberICD10Codes','tempOtcCards','MemberEligibility','RedirectLogins','ProductICDCategoriesAndICDCodes','MemberProducts','CaseManager',
'Remittances','HealthPlanCodes','CatalogBrochures','RemittanceItems','IncommErrors','RemittanceErrors','UserProfiles','UserProfileSecretAnswers','ExternalSources')

order by table_schema, table_name


select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'CardId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardId] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'CardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumber] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'ExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExpirationDate] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'SerialNbr' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SerialNbr] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'ProductDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductDescription] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'ClientCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCarrierId] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Cards' as TABLE_NAME,'ProgramCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramCode] as nvarchar))),'"') as VALUE from otc.[Cards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'CardCatalogId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardCatalogId] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'CardId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardId] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'RemainingBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemainingBalance] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'LoginDomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LoginDomain] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsCatalogs' as TABLE_NAME,'LastLoginDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastLoginDate] as nvarchar))),'"') as VALUE from otc.[CardsCatalogs]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsExternalSources' as TABLE_NAME,'CardsExternalSourcesId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardsExternalSourcesId] as nvarchar))),'"') as VALUE from otc.[CardsExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsExternalSources' as TABLE_NAME,'CardId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardId] as nvarchar))),'"') as VALUE from otc.[CardsExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsExternalSources' as TABLE_NAME,'ExternalSourceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExternalSourceId] as nvarchar))),'"') as VALUE from otc.[CardsExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CardsExternalSources' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[CardsExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CarrierAgents' as TABLE_NAME,'CarrierAgentId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierAgentId] as nvarchar))),'"') as VALUE from otc.[CarrierAgents]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CarrierAgents' as TABLE_NAME,'UserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from otc.[CarrierAgents]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CarrierAgents' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otc.[CarrierAgents]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CarrierAgents' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[CarrierAgents]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'CaseManagerID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseManagerID] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'FirstName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'LastName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'CMAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CMAddress] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'CMcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CMcode] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CaseManager' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[CaseManager]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'CatalogBrochureId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CatalogBrochureId] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'CarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierId] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'HealthPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanId] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'CatalogBrochures' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[CatalogBrochures]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'ConfigId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigId] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'ConfigKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigKey] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'ConfigValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigValue] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'ConfigOwner' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigOwner] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'ConfigType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigType] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'Environment' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Environment] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Config' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[Config]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ExternalSources' as TABLE_NAME,'SourceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceId] as nvarchar))),'"') as VALUE from otc.[ExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ExternalSources' as TABLE_NAME,'Code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Code] as nvarchar))),'"') as VALUE from otc.[ExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ExternalSources' as TABLE_NAME,'Clickthroughs' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Clickthroughs] as nvarchar))),'"') as VALUE from otc.[ExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ExternalSources' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[ExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'FileItems' as TABLE_NAME,'FileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileId] as nvarchar))),'"') as VALUE from otc.[FileItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'FileItems' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from otc.[FileItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'FileItems' as TABLE_NAME,'IsProcessed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsProcessed] as nvarchar))),'"') as VALUE from otc.[FileItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'FileItems' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[FileItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'GaTrackingID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GaTrackingID] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'NHMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'TrackingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingNumber] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'TrackingData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingData] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'GaTrackingDetails' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[GaTrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'HealthPlanCodes' as TABLE_NAME,'Subdomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Subdomain] as nvarchar))),'"') as VALUE from otc.[HealthPlanCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'HealthPlanCodes' as TABLE_NAME,'Codes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Codes] as nvarchar))),'"') as VALUE from otc.[HealthPlanCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'IncommErrors' as TABLE_NAME,'ErrorId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ErrorId] as nvarchar))),'"') as VALUE from otc.[IncommErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'IncommErrors' as TABLE_NAME,'RRCCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RRCCode] as nvarchar))),'"') as VALUE from otc.[IncommErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'IncommErrors' as TABLE_NAME,'ActualMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActualMessage] as nvarchar))),'"') as VALUE from otc.[IncommErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'IncommErrors' as TABLE_NAME,'CustomMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustomMessage] as nvarchar))),'"') as VALUE from otc.[IncommErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'IncommErrors' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[IncommErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberDiseaseStates' as TABLE_NAME,'MemberDiseaseStateId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberDiseaseStateId] as nvarchar))),'"') as VALUE from otc.[MemberDiseaseStates]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberDiseaseStates' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[MemberDiseaseStates]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberDiseaseStates' as TABLE_NAME,'Category' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Category] as nvarchar))),'"') as VALUE from otc.[MemberDiseaseStates]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberDiseaseStates' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[MemberDiseaseStates]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'FirstName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'LastName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'DateofBirth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateofBirth] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'MemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberID] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'EmployeeNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmployeeNumber] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'AdminAlias' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AdminAlias] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'Source' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'ZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ZipCode] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'PlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanName] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'PlanYearName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanYearName] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'PlanYearStartDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanYearStartDate] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'PlanYearEndDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanYearEndDate] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'EmployerCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmployerCode] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'IndividualId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IndividualId] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberEligibility' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[MemberEligibility]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberICD10Codes' as TABLE_NAME,'MemberICD10CodesId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberICD10CodesId] as nvarchar))),'"') as VALUE from otc.[MemberICD10Codes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberICD10Codes' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[MemberICD10Codes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberICD10Codes' as TABLE_NAME,'ICD10Code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ICD10Code] as nvarchar))),'"') as VALUE from otc.[MemberICD10Codes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberICD10Codes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[MemberICD10Codes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'MemberProductId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberProductId] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'MemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberId] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'CardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumber] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'ItemTag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemTag] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'UnitPrice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'Quantity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'MemberProducts' as TABLE_NAME,'ItemData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from otc.[MemberProducts]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'RowId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RowId] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'ICD10Code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ICD10Code] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'Category' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Category] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'HealthBenefit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthBenefit] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductICDCategoriesAndICDCodes' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otc.[ProductICDCategoriesAndICDCodes]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductPrices' as TABLE_NAME,'Nations_ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Nations_ID] as nvarchar))),'"') as VALUE from otc.[ProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductPrices' as TABLE_NAME,'Product_Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Product_Name] as nvarchar))),'"') as VALUE from otc.[ProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ProductPrices' as TABLE_NAME,'Best_Cost' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Best_Cost] as nvarchar))),'"') as VALUE from otc.[ProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Invtype' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Invtype] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'OrderDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderDate] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'OrderNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderNumber] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'OrderNumDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderNumDesc] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'CarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierName] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Product_Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Product_Name] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Nations_ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Nations_ID] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Qty' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Qty] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'QtyORG' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([QtyORG] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'BuyCost' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BuyCost] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'MemberName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberName] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Address2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'City' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'Zip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'ShippingVendor' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingVendor] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'TrackingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingNumber] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'OrgOrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrgOrderId] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'shipdate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([shipdate] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBCOGSDetailsByOrder' as TABLE_NAME,'IsCRMUpdateFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCRMUpdateFlag] as nvarchar))),'"') as VALUE from otc.[QBCOGSDetailsByOrder]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBOTCProductPrices' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otc.[QBOTCProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBOTCProductPrices' as TABLE_NAME,'ModelAttributeValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValue] as nvarchar))),'"') as VALUE from otc.[QBOTCProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'QBOTCProductPrices' as TABLE_NAME,'COGS' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([COGS] as nvarchar))),'"') as VALUE from otc.[QBOTCProductPrices]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'SourceSubdomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'TargetSubdomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TargetSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'RedirectToken' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RedirectToken] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'Envelop' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Envelop] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'IsSSO' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSSO] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'RemittanceErrorId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemittanceErrorId] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'RemittanceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemittanceId] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'InvoiceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceId] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'ReferenceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReferenceId] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'ItemData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceErrors' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[RemittanceErrors]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceItems' as TABLE_NAME,'ItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemId] as nvarchar))),'"') as VALUE from otc.[RemittanceItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceItems' as TABLE_NAME,'RemittanceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemittanceId] as nvarchar))),'"') as VALUE from otc.[RemittanceItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceItems' as TABLE_NAME,'AmountDue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AmountDue] as nvarchar))),'"') as VALUE from otc.[RemittanceItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceItems' as TABLE_NAME,'ItemData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from otc.[RemittanceItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceItems' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[RemittanceItems]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'DateOrderReceived' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'Carrier' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Carrier] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'Plan' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Plan] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'SerialNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SerialNumber] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'Date' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Date] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'Time' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Time] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'TransactionNet' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionNet] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'EPPGross' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EPPGross] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'DueFrom' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DueFrom] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'CreditCardGross' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreditCardGross] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'DueTo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DueTo] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'City' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'RemittanceReport' as TABLE_NAME,'Zip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from otc.[RemittanceReport]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'RemittanceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemittanceId] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'FileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileId] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'ExternalRefId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExternalRefId] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'Source' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'AmountDue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AmountDue] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'Paid' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Paid] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Remittances' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[Remittances]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'ReshipmentRequestId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReshipmentRequestId] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'ReshipmentData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReshipmentData] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ReshipmentRequests' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[ReshipmentRequests]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'SubscriptionsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriptionsId] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'Quantity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Subscriptions' as TABLE_NAME,'SubscriptionData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriptionData] as nvarchar))),'"') as VALUE from otc.[Subscriptions]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'tempOtcCards' as TABLE_NAME,'CardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumber] as nvarchar))),'"') as VALUE from otc.[tempOtcCards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'tempOtcCards' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from otc.[tempOtcCards]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'tempSource' as TABLE_NAME,'OTCCardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCCardNumber] as nvarchar))),'"') as VALUE from otc.[tempSource]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'tempSource' as TABLE_NAME,'NHMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from otc.[tempSource]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'tempSource' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from otc.[tempSource]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'TokenId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenId] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'TokenPEM' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenPEM] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'TokenOwner' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenOwner] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'TokenType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenType] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'Environment' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Environment] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'Tokens' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[Tokens]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'TrackingID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingID] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'NHMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'TrackingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingNumber] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'TrackingData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TrackingData] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'TrackingDetails' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[TrackingDetails]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'UserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'UserName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserName] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'PasswordSalt' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PasswordSalt] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'PasswordHash' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PasswordHash] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'IsReceiveOffers' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsReceiveOffers] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'IsBlocked' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsBlocked] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'nhmemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([nhmemberId] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'NotifSubscriptions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NotifSubscriptions] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'SubDomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubDomain] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfiles' as TABLE_NAME,'Preferences' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Preferences] as nvarchar))),'"') as VALUE from otc.[UserProfiles]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfileSecretAnswers' as TABLE_NAME,'UserProfileQAId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileQAId] as nvarchar))),'"') as VALUE from otc.[UserProfileSecretAnswers]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfileSecretAnswers' as TABLE_NAME,'SecretQuestionId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SecretQuestionId] as nvarchar))),'"') as VALUE from otc.[UserProfileSecretAnswers]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfileSecretAnswers' as TABLE_NAME,'UserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from otc.[UserProfileSecretAnswers]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfileSecretAnswers' as TABLE_NAME,'Answer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Answer] as nvarchar))),'"') as VALUE from otc.[UserProfileSecretAnswers]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfileSecretAnswers' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[UserProfileSecretAnswers]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfilesExternalSources' as TABLE_NAME,'UserProfilesExternalSourcesId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfilesExternalSourcesId] as nvarchar))),'"') as VALUE from otc.[UserProfilesExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfilesExternalSources' as TABLE_NAME,'UserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from otc.[UserProfilesExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfilesExternalSources' as TABLE_NAME,'ExternalSourceId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExternalSourceId] as nvarchar))),'"') as VALUE from otc.[UserProfilesExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'UserProfilesExternalSources' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[UserProfilesExternalSources]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'RowID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RowID] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'Title' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Title] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'MediaURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MediaURL] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'BrandName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandName] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'ModelRatings' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelRatings] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'Quantity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'QuantityUnits' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([QuantityUnits] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'Price' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Price] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'Currency' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Currency] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'PricePerQuantity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PricePerQuantity] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a union 
select top 40 * from  (select distinct  'otc' as TABLE_SCHEMA,'ViewGetMasterList' as TABLE_NAME,'CartQty' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CartQty] as nvarchar))),'"') as VALUE from otc.[ViewGetMasterList]) a


select distinct

' select '+''''+Table_name+'''' + ' as TABLE_NAME,' 
+ 'COUNT(*) ' + ' as RecordCount from ' 
+  Table_schema+'.'+ '['+TABLE_NAME+']'
+ ' union '
from information_schema.columns
where TABLE_SCHEMA in ('otc')


 select * from 
 (
 select 'Cards' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Cards] union 
 --select 'Cards_bkp_20201231' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Cards_bkp_20201231] union 
 --select 'Cards_MismatchBak2Jan2021' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Cards_MismatchBak2Jan2021] union 
 select 'CardsCatalogs' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[CardsCatalogs] union 
 select 'CardsExternalSources' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[CardsExternalSources] union 
 select 'CarrierAgents' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[CarrierAgents] union 
 select 'CaseManager' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[CaseManager] union 
 select 'CatalogBrochures' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[CatalogBrochures] union 
 --select 'Catalogs_NOT_IN_USE' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Catalogs_NOT_IN_USE] union 
 select 'Config' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Config] union 
 select 'ExternalSources' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ExternalSources] union 
 select 'FileItems' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[FileItems] union 
 select 'GaTrackingDetails' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[GaTrackingDetails] union 
 select 'HealthPlanCodes' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[HealthPlanCodes] union 
 --select 'InCommCatalogHealthPlans_NOT_IN_USE' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[InCommCatalogHealthPlans_NOT_IN_USE] union 
 select 'IncommErrors' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[IncommErrors] union 
 select 'MemberDiseaseStates' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberDiseaseStates] union 
 select 'MemberEligibility' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberEligibility] union 
 --select 'MemberEligibility_bkp_20210401_beforeHFHP_Q2' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberEligibility_bkp_20210401_beforeHFHP_Q2] union 
 select 'MemberEligibility1' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberEligibility1] union 
 select 'MemberICD10Codes' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberICD10Codes] union 
 select 'MemberProducts' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[MemberProducts] union 
 --select 'ProductCatalogs_NOT_IN_USE' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ProductCatalogs_NOT_IN_USE] union 
 --select 'ProductCategories_NOT_IN_USE' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ProductCategories_NOT_IN_USE] union 
 --select 'ProductCosts_NOT_IN_USE' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ProductCosts_NOT_IN_USE] union 
 select 'ProductICDCategoriesAndICDCodes' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ProductICDCategoriesAndICDCodes] union 
 select 'ProductPrices' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ProductPrices] union 
 select 'QBCOGSDetailsByOrder' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[QBCOGSDetailsByOrder] union 
 select 'QBOTCProductPrices' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[QBOTCProductPrices] union 
 select 'RedirectLogins' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[RedirectLogins] union 
 select 'RemittanceErrors' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[RemittanceErrors] union 
 select 'RemittanceItems' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[RemittanceItems] union 
 select 'RemittanceReport' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[RemittanceReport] union 
 select 'Remittances' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Remittances] union 
 select 'ReshipmentRequests' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ReshipmentRequests] union 
 select 'Subscriptions' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Subscriptions] union 
 select 'tempOtcCards' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[tempOtcCards] union 
 select 'tempSource' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[tempSource] union 
 select 'Tokens' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[Tokens] union 
 select 'TrackingDetails' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[TrackingDetails] union 
 select 'UserProfiles' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[UserProfiles] union 
 select 'UserProfileSecretAnswers' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[UserProfileSecretAnswers] union 
 select 'UserProfilesExternalSources' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[UserProfilesExternalSources] union 
 select 'ViewGetMasterList' as TABLE_NAME,COUNT(*)  as RecordCount from otc.[ViewGetMasterList]
 ) a
 order by 2 desc



declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '7869881027'

select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar)))' + '='+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_schema = 'otc'
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and table_name not in ('MemberEligibility1','Catalogs_NOT_IN_USE','InCommCatalogHealthPlans_NOT_IN_USE','ProductCosts_NOT_IN_USE','ProductCatalogs_NOT_IN_USE','Cards_MismatchBak2Jan2021','Cards_bkp_20201231','MemberEligibility_bkp_20210401_beforeHFHP_Q2','ProductCategories_NOT_IN_USE')
and table_name in (  'MemberDiseaseStates','GaTrackingDetails','UserProfilesExternalSources','TrackingDetails','CarrierAgents','Config','QBCOGSDetailsByOrder',
'ViewGetMasterList','Cards','ReshipmentRequests','CardsExternalSources','CardsCatalogs','Subscriptions','ProductPrices','RemittanceReport','QBOTCProductPrices','Tokens',
'FileItems','tempSource','MemberICD10Codes','tempOtcCards','MemberEligibility','RedirectLogins','ProductICDCategoriesAndICDCodes','MemberProducts','CaseManager',
'Remittances','HealthPlanCodes','CatalogBrochures','RemittanceItems','IncommErrors','RemittanceErrors','UserProfiles','UserProfileSecretAnswers','ExternalSources')