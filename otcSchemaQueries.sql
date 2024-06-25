select distinct table_schema from information_schema.columns where table_schema like '%otc%'

select * from information_schema.columns where table_schema = 'otc'
select distinct table_name from information_schema.columns where table_schema = 'otc'
select distinct ''''+table_name+''''+',' from information_schema.columns where table_schema = 'otc'


IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))
insert into #NHMemberIDTemp (NHMemberID) values 
('NH202005628865') 
 ,('NH202002689003')

select * from otc.cards where NHMemberID in (select * from #NHMemberIDTemp)
-- ('NH202005628865') exists in the database, ('NH202002689003') does not exist
/*
CardId	NHMemberId	CardNumber	ExpirationDate	SerialNbr	CreateUser	ModifyUser	CreateDate	ModifyDate	IsActive	ProductDescription	ClientCarrierId	ProgramCode
51856	NH202005628865	6363012451045907513	NULL	126380609		script	2020-06-23 22:45:43.6773486	2021-01-29 00:50:20.4500000	1	IHA OTC Medicare46 24510	302	NULL
*/










-- otc schema tables
(
'Cards', 'CardsCatalogs','CardsExternalSources','CaseManager','CatalogBrochures',
'Config','ExternalSources','FileItems','HealthPlanCodes','MemberDiseaseStates','MemberEligibility',
'MemberEligibility1','MemberICD10Codes','MemberProducts','ProductICDCategoriesAndICDCodes',
'ProductPrices','QBCOGSDetailsByOrder','QBOTCProductPrices','RedirectLogins','RemittanceErrors','RemittanceItems','RemittanceReport',
'Remittances','ReshipmentRequests','Subscriptions','tempOtcCards','tempSource','Tokens','TrackingDetails',
'UserProfiles','UserProfileSecretAnswers','UserProfilesExternalSources','ViewGetMasterList'
--'Cards_bkp_20201231','Cards_MismatchBak2Jan2021','Catalogs_NOT_IN_USE','InCommCatalogHealthPlans_NOT_IN_USE','ProductCatalogs_NOT_IN_USE','ProductCategories_NOT_IN_USE','ProductCosts_NOT_IN_USE'
)
