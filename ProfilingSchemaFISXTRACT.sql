select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('fisxtract')

/*
AccountBalance
Authorization
ColumnValidation
FileHeaderTrailer
FileInfo
FileTrack
FTPUserInfo
ItemLevel
MCCDescription
MCCGroups
MerchantMapping
MerchantMapping_SD_20220718
Monetary
NonMonetary
rawFileFeedData

*/
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('fisxtract')
/*
'AccountBalance',
'Authorization',
'ColumnValidation',
'FileHeaderTrailer',
'FileInfo',
'FileTrack',
'FTPUserInfo',
'ItemLevel',
'MCCDescription',
'MCCGroups',
'MerchantMapping',
'MerchantMapping_SD_20220718',
'Monetary',
'NonMonetary',
'rawFileFeedData',
*/


select * from information_schema.columns where table_schema = 'fisxtract'

select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ ' as TableName ' +','+ ' count(*) as RecordCount from ' + table_schema + '.[' + table_name +']' + ' Union' from information_schema.columns 
where TABLE_SCHEMA in ('fisxtract')

select * from (
select 'fisxtract.AccountBalance' as TableName , count(*) as RecordCount from fisxtract.[AccountBalance] Union
select 'fisxtract.Authorization' as TableName , count(*) as RecordCount from fisxtract.[Authorization] Union
select 'fisxtract.ColumnValidation' as TableName , count(*) as RecordCount from fisxtract.[ColumnValidation] Union
select 'fisxtract.FileHeaderTrailer' as TableName , count(*) as RecordCount from fisxtract.[FileHeaderTrailer] Union
select 'fisxtract.FileInfo' as TableName , count(*) as RecordCount from fisxtract.[FileInfo] Union
select 'fisxtract.FileTrack' as TableName , count(*) as RecordCount from fisxtract.[FileTrack] Union
select 'fisxtract.FTPUserInfo' as TableName , count(*) as RecordCount from fisxtract.[FTPUserInfo] Union
select 'fisxtract.ItemLevel' as TableName , count(*) as RecordCount from fisxtract.[ItemLevel] Union
select 'fisxtract.MCCDescription' as TableName , count(*) as RecordCount from fisxtract.[MCCDescription] Union
select 'fisxtract.MCCGroups' as TableName , count(*) as RecordCount from fisxtract.[MCCGroups] Union
select 'fisxtract.MerchantMapping' as TableName , count(*) as RecordCount from fisxtract.[MerchantMapping] Union
select 'fisxtract.MerchantMapping_SD_20220718' as TableName , count(*) as RecordCount from fisxtract.[MerchantMapping_SD_20220718] Union
select 'fisxtract.Monetary' as TableName , count(*) as RecordCount from fisxtract.[Monetary] Union
select 'fisxtract.NonMonetary' as TableName , count(*) as RecordCount from fisxtract.[NonMonetary] Union
select 'fisxtract.rawFileFeedData' as TableName , count(*) as RecordCount from fisxtract.[rawFileFeedData]
) a
order by a.RecordCount desc


/*
TableName	RecordCount
MarketingCatalog.Packagecodes_to_healthplans	53
MarketingCatalog.Languagecodes	13
MarketingCatalog.Clients	7
MarketingCatalog.FileInfo	0
MarketingCatalog.FileTrack	0
MarketingCatalog.FTPUserInfo	0
MarketingCatalog.Fulfillment_Member_Counts	0
MarketingCatalog.Fulfillmenttype	0
MarketingCatalog.Fullfilment_Member_log	0
MarketingCatalog.FullfilmentMailing	0
MarketingCatalog.FullfilmentVendor	0
MarketingCatalog.ItemCodes	0
MarketingCatalog.PackageCodes	0

*/

select * from (
select distinct  'select top 10 ' +' '+ ('''['+ table_schema +']'+ '.' +'['+ replace(replace(table_name,' ','_'),'-','_') +']'' as TableName_'+  table_schema + '_' + replace(replace(table_name,' ','_'),'-','_') +','  )  +  STRING_AGG(CONVERT(NVARCHAR(max), ('['+column_name+']')),',') + ' from ' + '['+ table_schema +']'+ '.' +'['+ table_name +']' AS selectList from information_schema.columns
where table_name in ( select distinct table_name from information_schema.columns) and table_schema = 'fisxtract' and table_name in (select top 1000 name from sys.tables order by create_date desc)
group by table_schema, table_name
) a

select top 10  '[fisxtract].[AccountBalance]' as TableName_fisxtract_AccountBalance,[AccountBalanceID],[FileTrackID],[RecordType],[IssuerClientID],[ClientName],[BIN],[BankName],[PAN],[OpeningBalance],[TotalValueloadAmount],[TotalValueloadCount],[TotalPurchaseAmount],[TotalPurchaseCount],[TotalOTCAmount],[TotalOTCCount],[TotalATMWithdrawalAmount],[TotalATMWithdrawalCount],[TotalReturnAmount],[TotalReturnCount],[TotalAdjustmentAmount],[TotalAdjustmentCount],[TotalFees],[TotalFeesCount],[OtherCreditAmount],[OtherCreditCount],[OtherDebitAmount],[OtherDebitCount],[TotalCreditAmount],[TotalCreditCount],[TotalDebitAmount],[TotalDebitCount],[TotalTransactionAmount],[TotalTransactionCount],[ClosingBalance],[BINCurrencyAlpha],[BINCurrencyCode],[PANProxyNumber],[PersonID],[CardholderClientUniqueID],[PurseName],[PurseStatus],[PurseCreationDate],[PurseExpirationDate],[PurseStatusDate],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[AccountBalance]
select top 10  '[fisxtract].[Authorization]' as TableName_fisxtract_Authorization,[AuthorizationID],[FileTrackID],[RecordType],[IssuerClientID],[IssuerClientName],[SubProgramID],[SubProgramName],[BIN],[BINCurrencyAlpha],[BINCurrencyCode],[BankName],[PAN],[CardNumber],[TxnUID],[TxnTypeCode],[TxnTypeName],[PurseNumber],[PurseName],[TransactionDate_Time],[AuthorizationCode],[ActualRequestCode],[ActualRequestCodeDescription],[ResponseCode],[ResponseDescription],[ReasonCode],[ReasonCodeDescription],[SourceCode],[SourceDescription],[AuthorizationAmount],[TxnLocalAmount],[TransactionSign],[TransactionCurrencyCode],[TransactionCurrencyAlpha],[RetrievalReferenceNumber],[Reversed],[AVSInformation],[AVSResponseCode],[PIN],[POSData],[POSEntryCode],[POSEntryDescription],[MCC],[MCCDescription],[MerchantCurrencyAlpha],[MerchantCurrencyCode],[MerchantName],[MerchantNumber],[MerchantStreet],[MerchantCity],[MerchantProvince],[MerchantState],[MerchantZip],[MerchantCountryCode],[MerchantCountryName],[TerminalNumber],[AcquirerID],[CardNumberProxy],[ClientSpecificID],[AuthorizationBalance],[SettleBalance],[ToleranceAmount],[CardVerificationMethod],[CVC2Response],[PANProxyNumber],[ProcessCode],[TokenUniqueReferenceID],[PANUniqueReferenceID],[TokenTransactionID],[TokenStatus],[TokenStatusDescription],[NetworkReferenceID],[AuthExpiryDate],[WCSLocalInserted],[WCSUTCInserted],[WCSUTCUpdated],[ReasonID],[ReasonIDDescription],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[Authorization]
select top 10  '[fisxtract].[ColumnValidation]' as TableName_fisxtract_ColumnValidation,[ColumnValidationID],[ColumnOrder],[FileInfoID],[FileType],[SourceColumn],[TargetColumn],[RecordType],[IsActive],[DataTypeConversion],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[ColumnValidation]
select top 10  '[fisxtract].[FileHeaderTrailer]' as TableName_fisxtract_FileHeaderTrailer,[FileHeaderTrailerId],[FileTrackID],[RecordType],[ProcessorName],[Report_DataFeedName],[FileProcessedDate],[FileDataDate],[TotalRecordsCount],[ErrorCode],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[FileHeaderTrailer]
select top 10  '[fisxtract].[FileInfo]' as TableName_fisxtract_FileInfo,[FileInfoID],[DataSource],[Direction],[FileType],[SnapshotFlag],[FileName],[FileExtension],[FileFormat],[FileDelimiter],[FileTextQualifier],[Frequency],[SourceTable],[TargetTable],[FromLocation],[ToLocation],[isAckFileToFTP],[IsDelFileFromClientFTP],[IsPGP],[PGPFileExtension],[PGPKeyName],[IsActive],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[FileInfo]
select top 10  '[fisxtract].[FileTrack]' as TableName_fisxtract_FileTrack,[FileTrackID],[FileInfoID],[DataSource],[Direction],[FileType],[SnapshotFlag],[FileName],[FileFormat],[DateReceived],[DateProcessed],[TotalRecords],[StatusCode],[IsActive],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[FileTrack]
select top 10  '[fisxtract].[FTPUserInfo]' as TableName_fisxtract_FTPUserInfo,[FTPUserInfoID],[HostAddress],[Port],[UserID],[Password],[WinSCPLoginName],[ContactPerson],[ContactPhoneNbr],[ContactEmail],[isActive],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],[FileType],[SnapshotFlag] from [fisxtract].[FTPUserInfo]
select top 10  '[fisxtract].[ItemLevel]' as TableName_fisxtract_ItemLevel,[ItemLevelID],[File_Name],[SUB_PROGRAM_ID],[SUB_PROGRAM_NAME],[PAN_NUMBER],[PROXY_NUMBER],[TRAN_DATE],[TRAN_TIME],[PRODUCT],[PRODUCT_CODE],[PRODUCT_DESC],[CATEGORY_DESC],[SUB_CATEGORY_DESC],[QUANTITY],[UNITS],[MEASURE],[RQST_AMOUNT],[REFERENCE_NUM] from [fisxtract].[ItemLevel]
select top 10  '[fisxtract].[MCCDescription]' as TableName_fisxtract_MCCDescription,[MCC],[MCCDescription] from [fisxtract].[MCCDescription]
select top 10  '[fisxtract].[MCCGroups]' as TableName_fisxtract_MCCGroups,[MCCGroupID],[MCCGroupCode],[MCCGroupName],[MCCCode],[MCCDescription],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[MCCGroups]
select top 10  '[fisxtract].[MerchantMapping]' as TableName_fisxtract_MerchantMapping,[ExtractType],[MerchantName],[MerchantNumber],[MCC],[rptMerchantName] from [fisxtract].[MerchantMapping]
select top 10  '[fisxtract].[MerchantMapping_SD_20220718]' as TableName_fisxtract_MerchantMapping_SD_20220718,[ExtractType],[MerchantName],[MerchantNumber],[MCC],[rptMerchantName] from [fisxtract].[MerchantMapping_SD_20220718]
select top 10  '[fisxtract].[Monetary]' as TableName_fisxtract_Monetary,[MonetaryID],[FileTrackID],[RecordType],[IssuerClientID],[ClientName],[SubProgramID],[SubProgramName],[BIN],[BINCurrencyAlpha],[BINCurrencyCode],[BankName],[PAN],[CardNumber],[AuthorizationAmount],[AuthorizationCode],[TxnLocalAmount],[TxnLocDateTime],[TxnSign],[TransactionCurrencyCode],[TransactionCurrencyAlpha],[TxnTypeCode],[ReasonCode],[DerivedRequestCode],[ResponseCode],[MatchStatusCode],[MatchTypeCode],[InitialLoadDateFlag],[MCC],[MerchantCurrencyAlpha],[MerchantCurrencyCode],[MerchantName],[MerchantNumber],[ReferenceNumber],[PaymentMethodID],[SettleAmount],[WCSUTCPostDate],[SourceCode],[AcquirerReferenceNumber],[AcquirerID],[AddressVerificationResponse],[AdjustAmount],[AuthorizationResponse],[AVSInformation],[Denomination],[DirectAccessNumber],[CardNumberProxy],[FudgeAmt],[MatchStatusDescription],[MatchTypeDescription],[MCCDescription],[MerchantZip],[MerchantCity],[MerchantCountryCode],[MerchantCountryName],[MerchantProvince],[MerchantState],[MerchantStreet],[PIN],[POSData],[POSEntryCode],[POSEntryDescription],[PurseNo],[ReasonCodeDescription],[DerivedRequestCodeDescription],[ResponseDescription],[Retrievalrefno],[Reversed],[SourceDescription],[TerminalNumber],[TxnTypeName],[UserID],[UserFirstName],[UserLastName],[WCSLocalPostDate],[Comment],[ClientReferenceNumber],[ClientSpecificID],[ActualRequestCode],[ActualRequestCodeDescription],[CardholderClientUniqueID],[PANProxyNumber],[TxnUID],[PurseName],[PurseStatus],[PurseCreationDate],[PurseEffectiveDate],[PurseExpirationDate],[PurseStatusDate],[AssociationSource],[ReasonID],[ReasonDescription],[Variance],[ProcessCode],[TokenUniqueReferenceID],[PANUniqueReferenceID],[TokenTransactionID],[TokenStatus],[TokenStatusDescription],[NetworkReferenceID],[Multi_clearingindication],[AuthorizationBalance],[SettleBalance],[WCSLocalInserted],[WCSUTCInserted],[WCSUTCUpdated],[DiscountAmount],[ACHEffectiveDate],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[Monetary]
select top 10  '[fisxtract].[NonMonetary]' as TableName_fisxtract_NonMonetary,[NonMonetaryID],[FileTrackID],[RecordType],[TopClientID],[TopClientName],[IssuerClientID],[ClientName],[ProgramID],[ProgramName],[SubProgramID],[SubProgramName],[BIN],[BINCurrencyAlpha],[BINCurrencyCode],[PackageID],[PackageName],[PAN],[CardNumber],[ActivateDate],[CardStatus],[CardholderFirstName],[CardholderLastName],[CardholderMiddleName],[CardholderMailingAddressLine1],[CardholderMailingAddressLine2],[CardholderMailingCity],[CardholderMailingState],[CardholderMailingZip],[CardholderMailingCountry],[CardholderCountryCode],[CardholderTelephoneNumber],[CardholderTelephoneNumberExt],[CardNumberLocCreationDate],[CardNumberLocExpirationDate],[MarketSegmentID],[MarketSegmentDescription],[RequestCode],[SourceCode],[WCSUTCInserted],[CardholderBusinessNumber],[CardholderBusinessNumberExt],[CardNumberLocStatusEffectiveDate],[CardholderCounty],[CardholderDateofBirth],[CardholderDriverLicenseNumber],[CardholderDriverLicenseState],[CardholderEmail],[CardholderEmergencyPhone],[CardholderEmergencyPhoneExtension],[CardholderFax],[CardholderFaxExtension],[CardholderSSN],[CardholderSuffix],[CardStatusDescription],[ClientLevelNumber],[CreateDate_AccountLocCreationDate],[ExpirationDate_AccountLocExpirationDate],[CardNumberProxy],[Memo_Comments_ClientDefined],[PrivacyOptOut],[OtherPersonAddr1],[OtherPersonAddr2],[OtherPersonBusinessNumber],[OtherPersonBusinessNumberExt],[OtherPersonCity],[OtherPersonCountry],[OtherPersonCountryCode],[OtherPersonCounty],[OtherPersonDOB],[OtherPersonDriverLicenseNumber],[OtherPersonDriverLicenseState],[OtherPersonEmail],[OtherPersonEmergencyPhone],[OtherPersonEmergencyPhoneExtension],[OtherPersonFax],[OtherPersonRelationship],[OtherPersonFirst],[OtherPersonLast],[OtherPersonMiddle],[OtherPersonState],[OtherPersonTelephoneNumber],[OtherPersonTelephoneNumberExtension],[OtherPersonZip],[PrimaryRelationship],[RequestCodeDescription],[SourceCodeDescription],[TrueAnonymous],[UserID],[UserFirstName],[UserLastName],[PersonID],[CardholderClientUniqueID],[CardholderOtherInfo],[ClientVal],[DiscretionaryData1],[DiscretionaryData2],[DiscretionaryData3],[ClientSpecificID],[CardholderAlertsEmail],[DirectAccessNumber],[CardholderResidentialAddressLine1],[CardholderResidentialAddressLine2],[CardholderResidentialCity],[CardholderResidentialState],[CardholderResidentialZip],[CardholderResidentialCountry],[CardholderSMSMobileNumber],[CardholderMobileNumber],[PANProxyNumber],[CardholderMailingAddressLine3],[CardholderResidentialAddressLine3],[OrderID],[SMSLanguage],[EmailLanguage],[Title],[InitialValueLoad],[DatePersonCreated],[IDType],[IDNumber],[PassportCountryofIssuance],[Name1],[Value1],[Name2],[Value2],[Name3],[Value3],[Name4],[Value4],[Name5],[Value5],[Name6],[Value6],[Name7],[Value7],[Name8],[Value8],[Name9],[Value9],[Name10],[Value10],[RiskWiseCodes],[RiskWiseResult],[IDVCodes],[IDVResult],[IDologyCodes],[IDologyResult],[CardholderFederalTaxID],[CardholderCompanyName],[CardholderIdentificationQuestions],[APSCodes],[APSResult],[ReasonID],[ReasonDescription],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser] from [fisxtract].[NonMonetary]
select top 10  '[fisxtract].[rawFileFeedData]' as TableName_fisxtract_rawFileFeedData,[RecordSno],[FileTrackId],[rawFileFeed1],[rawFileFeed2],[rawFileFeed3],[rawFileFeed4],[rawFileFeed5],[rawFileFeed6],[rawFileFeed7],[rawFileFeed8],[rawFileFeed9],[rawFileFeed10],[rawFileFeed11],[rawFileFeed12],[rawFileFeed13],[rawFileFeed14],[rawFileFeed15],[rawFileFeed16],[rawFileFeed17],[rawFileFeed18],[rawFileFeed19],[rawFileFeed20],[rawFileFeed21],[rawFileFeed22],[rawFileFeed23],[rawFileFeed24],[rawFileFeed25],[rawFileFeed26],[rawFileFeed27],[rawFileFeed28],[rawFileFeed29],[rawFileFeed30],[rawFileFeed31],[rawFileFeed32],[rawFileFeed33],[rawFileFeed34],[rawFileFeed35],[rawFileFeed36],[rawFileFeed37],[rawFileFeed38],[rawFileFeed39],[rawFileFeed40],[rawFileFeed41],[rawFileFeed42],[rawFileFeed43],[rawFileFeed44],[rawFileFeed45],[rawFileFeed46],[rawFileFeed47],[rawFileFeed48],[rawFileFeed49],[rawFileFeed50],[rawFileFeed51],[rawFileFeed52],[rawFileFeed53],[rawFileFeed54],[rawFileFeed55],[rawFileFeed56],[rawFileFeed57],[rawFileFeed58],[rawFileFeed59],[rawFileFeed60],[rawFileFeed61],[rawFileFeed62],[rawFileFeed63],[rawFileFeed64],[rawFileFeed65],[rawFileFeed66],[rawFileFeed67],[rawFileFeed68],[rawFileFeed69],[rawFileFeed70],[rawFileFeed71],[rawFileFeed72],[rawFileFeed73],[rawFileFeed74],[rawFileFeed75],[rawFileFeed76],[rawFileFeed77],[rawFileFeed78],[rawFileFeed79],[rawFileFeed80],[rawFileFeed81],[rawFileFeed82],[rawFileFeed83],[rawFileFeed84],[rawFileFeed85],[rawFileFeed86],[rawFileFeed87],[rawFileFeed88],[rawFileFeed89],[rawFileFeed90],[rawFileFeed91],[rawFileFeed92],[rawFileFeed93],[rawFileFeed94],[rawFileFeed95],[rawFileFeed96],[rawFileFeed97],[rawFileFeed98],[rawFileFeed99],[rawFileFeed100],[rawFileFeed101],[rawFileFeed102],[rawFileFeed103],[rawFileFeed104],[rawFileFeed105],[rawFileFeed106],[rawFileFeed107],[rawFileFeed108],[rawFileFeed109],[rawFileFeed110],[rawFileFeed111],[rawFileFeed112],[rawFileFeed113],[rawFileFeed114],[rawFileFeed115],[rawFileFeed116],[rawFileFeed117],[rawFileFeed118],[rawFileFeed119],[rawFileFeed120],[rawFileFeed121],[rawFileFeed122],[rawFileFeed123],[rawFileFeed124],[rawFileFeed125],[rawFileFeed126],[rawFileFeed127],[rawFileFeed128],[rawFileFeed129],[rawFileFeed130],[rawFileFeed131],[rawFileFeed132],[rawFileFeed133],[rawFileFeed134],[rawFileFeed135],[rawFileFeed136],[rawFileFeed137],[rawFileFeed138],[rawFileFeed139],[rawFileFeed140],[rawFileFeed141],[rawFileFeed142],[rawFileFeed143],[rawFileFeed144],[rawFileFeed145],[rawFileFeed146],[rawFileFeed147],[rawFileFeed148],[rawFileFeed149],[rawFileFeed150],[rawFileFeed151],[rawFileFeed152],[rawFileFeed153],[rawFileFeed154],[rawFileFeed155],[rawFileFeed156],[rawFileFeed157],[rawFileFeed158],[rawFileFeed159],[rawFileFeed160],[rawFileFeed161],[rawFileFeed162],[rawFileFeed163],[rawFileFeed164],[rawFileFeed165],[rawFileFeed166],[rawFileFeed167],[rawFileFeed168],[rawFileFeed169],[rawFileFeed170],[rawFileFeed171],[rawFileFeed172],[rawFileFeed173],[rawFileFeed174],[rawFileFeed175],[rawFileFeed176],[rawFileFeed177],[rawFileFeed178],[rawFileFeed179],[rawFileFeed180],[rawFileFeed181],[rawFileFeed182],[rawFileFeed183],[rawFileFeed184],[rawFileFeed185],[rawFileFeed186],[rawFileFeed187],[rawFileFeed188],[rawFileFeed189],[rawFileFeed190],[rawFileFeed191],[rawFileFeed192],[rawFileFeed193],[rawFileFeed194],[rawFileFeed195],[rawFileFeed196],[rawFileFeed197],[rawFileFeed198],[rawFileFeed199],[rawFileFeed200] from [fisxtract].[rawFileFeedData]



select distinct
'select top 100 ' + ''''+ table_schema + '.' + '['+table_name+']' +''''+ 'as TableName,'+ ' * from '+table_schema + '.' + '['+table_name+']' from information_schema.columns where table_schema = 'fisxtract'

select top 100 'fisxtract.[AccountBalance]'as TableName, * from fisxtract.[AccountBalance]
select top 100 'fisxtract.[Authorization]'as TableName, * from fisxtract.[Authorization]
select top 100 'fisxtract.[ColumnValidation]'as TableName, * from fisxtract.[ColumnValidation]
select top 100 'fisxtract.[FileHeaderTrailer]'as TableName, * from fisxtract.[FileHeaderTrailer]
select top 100 'fisxtract.[FileInfo]'as TableName, * from fisxtract.[FileInfo]
select top 100 'fisxtract.[FileTrack]'as TableName, * from fisxtract.[FileTrack]
select top 100 'fisxtract.[FTPUserInfo]'as TableName, * from fisxtract.[FTPUserInfo]
select top 100 'fisxtract.[ItemLevel]'as TableName, * from fisxtract.[ItemLevel]
select top 100 'fisxtract.[MCCDescription]'as TableName, * from fisxtract.[MCCDescription]
select top 100 'fisxtract.[MCCGroups]'as TableName, * from fisxtract.[MCCGroups]
select top 100 'fisxtract.[MerchantMapping]'as TableName, * from fisxtract.[MerchantMapping]
select top 100 'fisxtract.[MerchantMapping_SD_20220718]'as TableName, * from fisxtract.[MerchantMapping_SD_20220718]
select top 100 'fisxtract.[Monetary]'as TableName, * from fisxtract.[Monetary]
select top 100 'fisxtract.[NonMonetary]'as TableName, * from fisxtract.[NonMonetary]
select top 100 'fisxtract.[rawFileFeedData]'as TableName, * from fisxtract.[rawFileFeedData]


select * from information_schema.columns where table_schema = 'fisxtract'
select top 10 * From fisxtract.Monetary
select top 10 * from elig.mstreligbenefitdata where datasource like '%MLNA%'
select * from elig.clientCodes where ClientName like 'M%'
select top 10 * from elig.mstreligbenefitdata where datasource like '%MLNA%'
select * from fisxtract.Monetary where PANProxyNumber in (select distinct BenefitCardNumber from elig.mstreligbenefitdata where datasource like '%MLNA%')

select count(*) from elig.mstreligbenefitdata where datasource like '%MLNA%' and BenefitCardNumber is not null

select count(*) from (
select distinct PANProxyNumber from fisxtract.Monetary
) a

select a.PANProxyNumber, b.BenefitCardNumber, a.*,b.*
from
fisxtract.Monetary a left join elig.mstreligbenefitdata b on a.PANProxyNumber = b.BenefitCardNumber


select a.TxnUID, a.AuthorizationAmount, m.TxnUID
from fisxtract.Monetary m
left join [fisxtract].[Authorization] a on (m.PANProxyNumber = a.PANProxyNumber and m.TxnUID = a.TxnUID)
where 1 = 1
--and TxnUID = 'C47A1E23-2D02-40DA-842A-EF57700DFD3B'
and m.PANProxyNumber = '0326518075856'
order by TxnLocDateTime


select
NHMemberId,
SubscriberID,
MemberFirstName,
MemberLastName,
PlanName

,TxnUID ,TxnLocDateTime ,WCSLocaLPostDate ,WCSUTCPostDate 
,PurseNo ,PurseName ,AuthorizationAmount ,SettleAmount ,SettleBalance ,MCCDescription ,MerchantName ,CardNumber,Reversed ,ResponseDescription ,
TxnTypeName
from fisxtract.Monetary

select * from information_schema.columns where table_name = 'Monetary'
select * from information_schema.columns where table_schema = 'insurance'
select * from insurance.insurancecarriers where InsuranceCarrierName like '%Molina%'
select * from insurance.insurancecarriers where InsuranceCarrierID in (379,380)
select * from insurance.InsuranceHealthPlans where insuranceCarrierID in (select insuranceCarrierID from insurance.insurancecarriers where InsuranceCarrierName like '%avmed%')
select * from insurance.insurancecarriers where InsuranceCarrierID in (379,380)
select distinct InsuranceCarrierID, InsuranceHealthPlanID, HealthPlanName, IsActive from insurance.InsuranceHealthPlans where insurancecarrierid = 380 and IsActive = 1

select reverse('abcdefghijklmnopqrstuvwxyz')

SELECT 
a.NHMemberId
--,b.SubscriberID
,TRANSLATE(b.SubscriberID,'1234567890', REVERSE('1234567890')) as SubscriberID
--,b.FirstName as MemberFirstName
,UPPER(TRANSLATE(b.FirstName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as FirstName
--,b.LastName as MemberLastName
,UPPER(TRANSLATE(b.LastName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as LastName
--,c.HealthPlanName as PlanName
--,c.InsuranceHealthPlanID as InsuranceHealthPlanID
,CASE WHEN (c.InsuranceHealthPlanID = 4019) THEN 'H1016_023 Medicare Circle Miami Dade HMO'
     WHEN (c.InsuranceHealthPlanID = 4024) THEN 'H1016_ 024 Medicare Circle Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4030) THEN 'H1016_001 Medicare Choice Miami Dade HMO'
	 WHEN (c.InsuranceHealthPlanID = 4031) THEN 'H1016_021 Medicare Choice Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4032) THEN 'H1016_026 Medicare Access Broward County (HMO)'
	 WHEN (c.InsuranceHealthPlanID = 4023) THEN 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
	 END PlanName
/* Avmed HealthPlan Names
-- Avmed
H1016_023 Medicare Circle Miami Dade HMO 
H1016_ 024 Medicare Circle Broward HMO
H1016_001 Medicare Choice Miami Dade HMO
H1016_021 Medicare Choice Broward HMO
-- DHEAllPlans Avmed
H1016_026 Medicare Access Broward County (HMO)
H1016_025 Medicare Access (HMO-POS) Miami-Dade County
H1016_028 Medicare Premium Saver HMO Broward County
*/

/*
4019 replaced with 'H1016_023 Medicare Circle Miami Dade HMO'
4024 replace with 'H1016_ 024 Medicare Circle Broward HMO'
4030 replace with 'H1016_001 Medicare Choice Miami Dade HMO'
4031 replace with 'H1016_021 Medicare Choice Broward HMO'
4032 replace with 'H1016_026 Medicare Access Broward County (HMO)'
4023 replace with 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
*/

,d.TxnUID
,FORMAT(d.TxnLocDateTime,'MMddyyyy hh:mm:ss') as TxnLocDateTime
,FORMAT(d.WCSLocaLPostDate, 'MMddyyyy hh:mm:ss') as WCSLocaLPostDate
,FORMAT(d.WCSUTCPostDate,'MMddyyyy hh:mm:ss') as WCSUTCPostDate
,d.PurseNo,d.PurseName 
--,d.AuthorizationAmount --  fisxtract.Monetary
,e.AuthorizationAmount as AuthorizationAmount --  fisxtract.[Authorization]
,d.SettleAmount, d.SettleBalance, d.MCCDescription, d.MerchantName, d.CardNumber, d.Reversed, d.ResponseDescription, d.TxnTypeName
from 
fisxtract.Monetary d 
left join elig.mstreligbenefitdata b on d.PANProxyNumber = b.BenefitCardNumber
left join master.members a on a.MemberID = b.MasterMemberID
left join insurance.InsuranceHealthPlans c on (b.inscarrierID = c.InsuranceCarrierid and b.insHealthPlanID = c.InsuranceHealthPlanID)
left join fisxtract.[Authorization] e on (e.PANProxyNumber = d.PANProxyNumber and e.TxnUID = d.TxnUID)

where
1=1 and
c.insuranceCarrierID = 380 
and (a.isActive =1 and b.IsActive =1 and c.IsActive = 1 )   -- and d.IsActive=1 is not present
-- and d.MerchantName <> 'MANUAL BATCH LOADER'
and d.PANProxyNumber in ('0701544156626','7880293579976','0326518075856','5793968081803','5782966918391','6043099962656','4383145994616','3185555433261','8997129144084','4542803336688','3856195467888')


select PANProxyNumber, count(1) From fisxtract.Monetary
group by PANProxyNumber
having count(1) > 1
order by 2 desc



select * from fisxtract.[Authorization]

/*
0701544156626	34
7880293579976	24
0326518075856	19
5793968081803	18
5782966918391	17
6043099962656	16
4383145994616	16
3185555433261	16
8997129144084	16
4542803336688	15
3856195467888	15
*/

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
where table_schema = 'fisxtract'

select * from fisxtract.Monetary where PANProxyNumber = '0701544156626'
select * from fisxtract.[Authorization] where PANProxyNumber = '0701544156626'


-- Monetary
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MonetaryID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonetaryID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'FileTrackID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileTrackID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'IssuerClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IssuerClientID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ClientName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SubProgramName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'BIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BIN] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'BINCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BINCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'BINCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BINCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'BankName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BankName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PAN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PAN] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'CardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AuthorizationAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationAmount] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AuthorizationCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnLocalAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnLocalAmount] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnLocDateTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnLocDateTime] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnSign' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnSign] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TransactionCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TransactionCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnTypeCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ReasonCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'DerivedRequestCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DerivedRequestCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ResponseCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MatchStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MatchStatusCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MatchTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MatchTypeCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'InitialLoadDateFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InitialLoadDateFlag] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MCC' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCC] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ReferenceNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReferenceNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PaymentMethodID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentMethodID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SettleAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SettleAmount] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'WCSUTCPostDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSUTCPostDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SourceCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AcquirerReferenceNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AcquirerReferenceNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AcquirerID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AcquirerID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AddressVerificationResponse' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AddressVerificationResponse] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AdjustAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AdjustAmount] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AuthorizationResponse' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationResponse] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AVSInformation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AVSInformation] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Denomination' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Denomination] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'DirectAccessNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DirectAccessNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'CardNumberProxy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumberProxy] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'FudgeAmt' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeAmt] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MatchStatusDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MatchStatusDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MatchTypeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MatchTypeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MCCDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantZip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantZip] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantCity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCity] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantCountryCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCountryCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantCountryName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCountryName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantProvince' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantProvince] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantState' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantState] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'MerchantStreet' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantStreet] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PIN] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'POSData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSData] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'POSEntryCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSEntryCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'POSEntryDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSEntryDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseNo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseNo] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ReasonCodeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonCodeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'DerivedRequestCodeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DerivedRequestCodeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ResponseDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Retrievalrefno' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Retrievalrefno] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Reversed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Reversed] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SourceDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TerminalNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TerminalNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnTypeName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'UserID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'UserFirstName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserFirstName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'UserLastName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserLastName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'WCSLocalPostDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSLocalPostDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Comment' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Comment] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ClientReferenceNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientReferenceNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ClientSpecificID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientSpecificID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ActualRequestCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActualRequestCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ActualRequestCodeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActualRequestCodeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'CardholderClientUniqueID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardholderClientUniqueID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PANProxyNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PANProxyNumber] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TxnUID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnUID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseStatus] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseCreationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseCreationDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseEffectiveDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseEffectiveDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseExpirationDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PurseStatusDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseStatusDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AssociationSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AssociationSource] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ReasonID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ReasonDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Variance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Variance] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ProcessCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessCode] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TokenUniqueReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenUniqueReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'PANUniqueReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PANUniqueReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TokenTransactionID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenTransactionID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TokenStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenStatus] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'TokenStatusDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenStatusDescription] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'NetworkReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NetworkReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'Multi_clearingindication' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Multi_clearingindication] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'AuthorizationBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationBalance] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'SettleBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SettleBalance] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'WCSLocalInserted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSLocalInserted] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'WCSUTCInserted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSUTCInserted] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'WCSUTCUpdated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSUTCUpdated] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'DiscountAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiscountAmount] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ACHEffectiveDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ACHEffectiveDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'CreateDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'CreateUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateUser] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ModifyDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyDate] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Monetary' as TABLE_NAME,'ModifyUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyUser] as nvarchar))),'"') as VALUE from fisxtract.[Monetary]) a



-- Authorization
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AuthorizationID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'FileTrackID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileTrackID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'IssuerClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IssuerClientID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'IssuerClientName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IssuerClientName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'SubProgramName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'BIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BIN] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'BINCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BINCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'BINCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BINCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'BankName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BankName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PAN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PAN] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TxnUID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnUID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TxnTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnTypeCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TxnTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnTypeName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PurseNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TransactionDate_Time' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionDate_Time] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AuthorizationCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ActualRequestCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActualRequestCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ActualRequestCodeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActualRequestCodeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ResponseCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ResponseDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ReasonCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ReasonCodeDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonCodeDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'SourceCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'SourceDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AuthorizationAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationAmount] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TxnLocalAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnLocalAmount] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TransactionSign' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionSign] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TransactionCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TransactionCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'RetrievalReferenceNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RetrievalReferenceNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'Reversed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Reversed] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AVSInformation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AVSInformation] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AVSResponseCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AVSResponseCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PIN] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'POSData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSData] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'POSEntryCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSEntryCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'POSEntryDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POSEntryDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MCC' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCC] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MCCDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantCurrencyAlpha' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCurrencyAlpha] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantCurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCurrencyCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantStreet' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantStreet] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantCity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCity] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantProvince' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantProvince] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantState' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantState] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantZip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantZip] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantCountryCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCountryCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'MerchantCountryName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantCountryName] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TerminalNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TerminalNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AcquirerID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AcquirerID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CardNumberProxy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumberProxy] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ClientSpecificID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientSpecificID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AuthorizationBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthorizationBalance] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'SettleBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SettleBalance] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ToleranceAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ToleranceAmount] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CardVerificationMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardVerificationMethod] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CVC2Response' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CVC2Response] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PANProxyNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PANProxyNumber] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ProcessCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessCode] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TokenUniqueReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenUniqueReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'PANUniqueReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PANUniqueReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TokenTransactionID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenTransactionID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TokenStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenStatus] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'TokenStatusDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenStatusDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'NetworkReferenceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NetworkReferenceID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'AuthExpiryDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthExpiryDate] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'WCSLocalInserted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSLocalInserted] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'WCSUTCInserted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSUTCInserted] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'WCSUTCUpdated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WCSUTCUpdated] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ReasonID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonID] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ReasonIDDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonIDDescription] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CreateDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDate] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'CreateUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateUser] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ModifyDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyDate] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a union 
select top 100 * from  (select distinct  'fisxtract' as TABLE_SCHEMA,'Authorization' as TABLE_NAME,'ModifyUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyUser] as nvarchar))),'"') as VALUE from fisxtract.[Authorization]) a