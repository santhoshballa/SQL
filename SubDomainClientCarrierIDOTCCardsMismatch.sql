select * from information_schema.columns where COLUMN_NAME like '%SubDomain%'


declare @SearchPredicate nvarchar(50)
set @SearchPredicate = 'NH202002210527'

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
where TABLE_SCHEMA in ('otc', 'dbo')
and TABLE_NAME in ( 'MasterCarrierConfigTemp','RedirectLogins','HealthPlanCodes','UserProfiles')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
order by table_schema, table_name


declare @SearchPredicate nvarchar(50)
set @SearchPredicate = 'healthfirst'

select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierID] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierID] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierName] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierName] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'Action|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([Action] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'HealthPlanID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanID] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([HealthPlanID] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'HealthPlanName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanName] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([HealthPlanName] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([IsActive] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'subDomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([subDomain] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([subDomain] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'ParentCarrierId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentCarrierId] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([ParentCarrierId] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'IsTeleAudiologyEnabled|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsTeleAudiologyEnabled] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([IsTeleAudiologyEnabled] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'carrierCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([carrierCode] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([carrierCode] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'DHE TFN|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHE TFN] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([DHE TFN] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CARRIERCONFIG|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CARRIERCONFIG] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CARRIERCONFIG] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierConfig_HealthPlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_HealthPlanCode] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierConfig_HealthPlanCode] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierConfig_ProgramType _Remarks|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_ProgramType _Remarks] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierConfig_ProgramType _Remarks] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierConfig_ProgramType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_ProgramType] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierConfig_ProgramType] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'CarrierConfig_BenefitTypes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([CarrierConfig_BenefitTypes] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLOGIN|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLOGIN] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLOGIN] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_IsRegisterable|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_IsRegisterable] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_IsRegisterable] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_IsManaged|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_IsManaged] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_IsManaged] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_IsLoginRestricted|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_IsLoginRestricted] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_IsLoginRestricted] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_BenValSrc|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_BenValSrc] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_BenValSrc] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_LoginTemplate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_LoginTemplate] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_LoginTemplate] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_ReplaceWallets|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_ReplaceWallets] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_ReplaceWallets] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_AddWallets|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_AddWallets] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_AddWallets] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_MapWallets|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_MapWallets] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_Tags|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_Tags] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_Tags] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCLogin_SplashTemplate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_SplashTemplate] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCLogin_SplashTemplate] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP_CanSubscribe|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP_CanSubscribe] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP_CanSubscribe] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP_IsHealthProfileDisabled|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP_IsHealthProfileDisabled] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP_IsHealthProfileDisabled] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP_ClientLogoPlace|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP_ClientLogoPlace] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP_ClientLogoPlace] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP_AlwaysViewCatalog|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP_AlwaysViewCatalog] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP_AlwaysViewCatalog] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCAPP_DisablePromotions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCAPP_DisablePromotions] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCAPP_DisablePromotions] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCCONTENT|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCCONTENT] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCCONTENT] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_Phone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_Phone] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_Phone] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_ExceedBenefitConfirmationKey|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_ExceedBenefitConfirmationKey] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_ExceedBenefitConfirmationKey] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_CoveredByKey|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_CoveredByKey] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_CoveredByKey] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_CartNotCoveredKey|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_CartNotCoveredKey] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_CartNotCoveredKey] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_cartCoveredKey|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_cartCoveredKey] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_cartCoveredKey] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_ShowOTCGuidelines|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_ShowOTCGuidelines] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_ShowOTCGuidelines] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'MasterCarrierConfigTemp|' as TABLE_NAME,'OTCContent_Disclaimer|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_Disclaimer] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp] where ltrim(rtrim(cast([OTCContent_Disclaimer] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'HealthPlanCodes|' as TABLE_NAME,'Subdomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Subdomain] as nvarchar))),'"') as VALUE from otc.[HealthPlanCodes] where ltrim(rtrim(cast([Subdomain] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'HealthPlanCodes|' as TABLE_NAME,'Codes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Codes] as nvarchar))),'"') as VALUE from otc.[HealthPlanCodes] where ltrim(rtrim(cast([Codes] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'SourceSubdomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([SourceSubdomain] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'TargetSubdomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TargetSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([TargetSubdomain] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'RedirectToken|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RedirectToken] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([RedirectToken] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'Envelop|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Envelop] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([Envelop] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'IsSSO|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSSO] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([IsSSO] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'RedirectLogins|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[RedirectLogins] where ltrim(rtrim(cast([IsActive] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'UserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([UserProfileId] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'UserName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserName] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([UserName] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'PasswordSalt|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PasswordSalt] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([PasswordSalt] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'PasswordHash|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PasswordHash] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([PasswordHash] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'IsReceiveOffers|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsReceiveOffers] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([IsReceiveOffers] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'IsBlocked|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsBlocked] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([IsBlocked] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([IsActive] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'nhmemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([nhmemberId] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([nhmemberId] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'NotifSubscriptions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NotifSubscriptions] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([NotifSubscriptions] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'SubDomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubDomain] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([SubDomain] as nvarchar)))=@SearchPredicate) a union 
select top 40 * from  (select distinct  'otc|' as TABLE_SCHEMA,'UserProfiles|' as TABLE_NAME,'Preferences|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Preferences] as nvarchar))),'"') as VALUE from otc.[UserProfiles] where ltrim(rtrim(cast([Preferences] as nvarchar)))=@SearchPredicate) a


select  * from otc.RedirectLogins where envelop like '%6102812781000347725%' order by createdate desc



select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_NAME IN 
('RedirectLogins')
--and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')


select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'SourceSubdomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'TargetSubdomain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TargetSubdomain] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'RedirectToken' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RedirectToken] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'Envelop' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Envelop] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'IsSSO' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSSO] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'CreateUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateUser] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'CreateDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDate] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'ModifyUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyUser] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a union 
select top 100 * from  (select distinct  'otc' as TABLE_SCHEMA,'RedirectLogins' as TABLE_NAME,'ModifyDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyDate] as nvarchar))),'"') as VALUE from otc.[RedirectLogins]) a


-- Serarch Card By NH Member
declare @NHMemberID varchar(20)
set @NHMemberID = 'NH202002210527'

-- Cards
select '[otc.Cards]' as TableName, 'OTC' as Card, @NHMemberID as NHMemberID, CardID, CardNumber,  ClientCarrierID from otc.Cards where NHMemberID = @NHMemberID

-- Master
SELECT '[Master.MemberInsuranceDetails]' TableName, 'Master' as Card, @NHMemberID as NHMemberID, [OTCCardNumber],
  id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],    [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (@NHMemberID)
													   )
							)
and OTCCardNumber is not null

-- Provider
SELECT '[Provider.MemberInsuranceDetails]' TableName,'Provider' as Card, @NHMemberID as NHMemberID, [OTCCardNumber],
	id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],    [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN ( SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN ( SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@NHMemberID)
																)
							)
and OTCCardNumber is not null



select '[Insurance.InsuranceCarriers]' TableName,insuranceCarrierID, InsuranceCarrierName, IsActive, CarrierConfig from insurance.InsuranceCarriers where InsuranceCarrierID = (select ClientCarrierId from otc.cards where NHMemberID = @NHMemberID)
select '[Insurance.InsuranceHealthPlans]' as TableName,InsuranceHealthPlanID, HealthPlanName, InsuranceCarrierID, IsActive  
from insurance.InsuranceHealthPlans where InsuranceCarrierID in (select InsuranceCarrierID from insurance.InsuranceCarriers 
                                                                 where InsuranceCarrierID in (select ClientCarrierId from otc.cards where NHMemberID = @NHMemberID)
                                                                )

select '[Insurance.InsuranceCarriers]' TableName,insuranceCarrierID, InsuranceCarrierName, IsActive, CarrierConfig from insurance.InsuranceCarriers where InsuranceCarrierID in ( 270, 277)
select '[Insurance.InsuranceHealthPlans]' as TableName, InsuranceHealthPlanID, HealthPlanName, InsuranceCarrierID, IsActive  
from insurance.InsuranceHealthPlans where InsuranceCarrierID in ( select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierID in ( 270, 277) ) order by InsuranceCarrierID


/*
Ticket #  42768
I was assisting this member today and when opening his OTC store from crm, it opens as the incorrect health plan, Healthfirst. 
This member is with BCBS Ri and their health plan info is correct in their crm. Can this be fixed please?
Kenneth Haskell - NH202002210527

[otc.Cards]	OTC	NH202002210527	123045	6102812781000347725	277
[Insurance.InsuranceCarriers]	270	BCBS Rhode Island	1	{"subdomain":"bcbsri","benefitValueSource":"incomm","isManaged":true}
[Insurance.InsuranceCarriers]	277	Healthfirst (New York)	1	{"subdomain":"healthfirst","carrierCode":"healthfirst","dhePhone":"877-236-7027","isTeleAudiologyEnabled":true,"benefitValueSource":"incomm","isManaged":false,"clientLogoPlace":"Left"}

update otc.cards set ClientCarrierID = 270 where cardid = 123045


*/