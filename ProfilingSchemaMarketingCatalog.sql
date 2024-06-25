select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('MarketingCatalog')

/*
Clients
FileInfo
FileTrack
FTPUserInfo
Fulfillment_Member_Counts
Fulfillmenttype
Fullfilment_Member_log
FullfilmentMailing
FullfilmentVendor
ItemCodes
Languagecodes
PackageCodes
Packagecodes_to_healthplans

*/
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('MarketingCatalog')
/*
'Clients',
'FileInfo',
'FileTrack',
'FTPUserInfo',
'Fulfillment_Member_Counts',
'Fulfillmenttype',
'Fullfilment_Member_log',
'FullfilmentMailing',
'FullfilmentVendor',
'ItemCodes',
'Languagecodes',
'PackageCodes',
'Packagecodes_to_healthplans',
*/


select * from information_schema.columns where table_schema = 'MarketingCatalog'

select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ ' as TableName ' +','+ ' count(*) as RecordCount from ' + table_schema + '.' + table_name + ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('MarketingCatalog')

select * from (
select 'MarketingCatalog.Clients' as TableName , count(*) as RecordCount from MarketingCatalog.Clients Union 
select 'MarketingCatalog.FileInfo' as TableName , count(*) as RecordCount from MarketingCatalog.FileInfo Union 
select 'MarketingCatalog.FileTrack' as TableName , count(*) as RecordCount from MarketingCatalog.FileTrack Union 
select 'MarketingCatalog.FTPUserInfo' as TableName , count(*) as RecordCount from MarketingCatalog.FTPUserInfo Union 
select 'MarketingCatalog.Fulfillment_Member_Counts' as TableName , count(*) as RecordCount from MarketingCatalog.Fulfillment_Member_Counts Union 
select 'MarketingCatalog.Fulfillmenttype' as TableName , count(*) as RecordCount from MarketingCatalog.Fulfillmenttype Union 
select 'MarketingCatalog.Fullfilment_Member_log' as TableName , count(*) as RecordCount from MarketingCatalog.Fullfilment_Member_log Union 
select 'MarketingCatalog.FullfilmentMailing' as TableName , count(*) as RecordCount from MarketingCatalog.FullfilmentMailing Union 
select 'MarketingCatalog.FullfilmentVendor' as TableName , count(*) as RecordCount from MarketingCatalog.FullfilmentVendor Union 
select 'MarketingCatalog.ItemCodes' as TableName , count(*) as RecordCount from MarketingCatalog.ItemCodes Union 
select 'MarketingCatalog.Languagecodes' as TableName , count(*) as RecordCount from MarketingCatalog.Languagecodes Union 
select 'MarketingCatalog.PackageCodes' as TableName , count(*) as RecordCount from MarketingCatalog.PackageCodes Union 
select 'MarketingCatalog.Packagecodes_to_healthplans' as TableName , count(*) as RecordCount from MarketingCatalog.Packagecodes_to_healthplans
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


select distinct
'select top 100 * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'MarketingCatalog'

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


select distinct
'select * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'MarketingCatalog'

select * from MarketingCatalog.Clients
select * from MarketingCatalog.FileInfo
select * from MarketingCatalog.FileTrack
select * from MarketingCatalog.FTPUserInfo
select * from MarketingCatalog.Fulfillment_Member_Counts
select * from MarketingCatalog.Fulfillmenttype
select * from MarketingCatalog.Fullfilment_Member_log
select * from MarketingCatalog.FullfilmentMailing
select * from MarketingCatalog.FullfilmentVendor
select * from MarketingCatalog.ItemCodes
select * from MarketingCatalog.Languagecodes
select * from MarketingCatalog.PackageCodes
select * from MarketingCatalog.Packagecodes_to_healthplans


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
where 1=1 and 
TABLE_SCHEMA in ('MarketingCatalog' )
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select * from (

select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Languagecodes' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Languagecodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Languagecodes' as TABLE_NAME,'datasource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([datasource] as nvarchar))),'"') as VALUE from MarketingCatalog.[Languagecodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Languagecodes' as TABLE_NAME,'LanguageCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Languagecodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Languagecodes' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from MarketingCatalog.[Languagecodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'filetrackID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([filetrackID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'VendorName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorName] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'PackageCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'Fulfillmenttypecode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Fulfillmenttypecode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'FulfillmentMailingcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentMailingcode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'MasterMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MasterMemberID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'SubscriberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubscriberID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'MemberFirstName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberFirstName] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'MemberLastName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberLastName] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'City' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'ZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ZipCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'SentDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SentDate] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'shipdate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([shipdate] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'Trackingnumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Trackingnumber] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fullfilment_Member_log' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fullfilment_Member_log]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileInfoID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileInfoID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'Direction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Direction] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileExtension' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileExtension] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileFormat' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileFormat] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileType] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'SnapshotFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SnapshotFlag] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'Frequency' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Frequency] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'PickDropTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PickDropTime] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FromLocation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FromLocation] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'ToLocation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ToLocation] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'isActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([isActive] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'IsHeaderRecord' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsHeaderRecord] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'FileFormatValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileFormatValue] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'IsTrailerRecord' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsTrailerRecord] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileInfo' as TABLE_NAME,'isAckFileToFTP' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([isAckFileToFTP] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'FileTrackID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileTrackID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'FileInfoID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileInfoID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'FileFormat' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileFormat] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'SnapshotFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SnapshotFlag] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'FileType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileType] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'DateReceived' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateReceived] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'DateProcessed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateProcessed] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'RecordsReceived' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordsReceived] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'RecordsProcessed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordsProcessed] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'RecordsErrored' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordsErrored] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'LoadStartTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LoadStartTime] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'LoadEndTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LoadEndTime] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FileTrack' as TABLE_NAME,'StatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[FileTrack]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'FtpID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FtpID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'HostAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HostAddress] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'Port' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Port] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'UserID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'Password' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Password] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'WinSCPLoginName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WinSCPLoginName] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'ContactPerson' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContactPerson] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'ContactPhoneNbr' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContactPhoneNbr] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'ContactEmail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContactEmail] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'isActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([isActive] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FTPUserInfo' as TABLE_NAME,'FileType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileType] as nvarchar))),'"') as VALUE from MarketingCatalog.[FTPUserInfo]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'ClientName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientName] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Clients' as TABLE_NAME,'isActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([isActive] as nvarchar))),'"') as VALUE from MarketingCatalog.[Clients]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'PackageCodes' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[PackageCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'PackageCodes' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[PackageCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'PackageCodes' as TABLE_NAME,'PackageCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[PackageCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'PackageCodes' as TABLE_NAME,'PackageDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageDesc] as nvarchar))),'"') as VALUE from MarketingCatalog.[PackageCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'PackageCodes' as TABLE_NAME,'ItemCodes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCodes] as nvarchar))),'"') as VALUE from MarketingCatalog.[PackageCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Packagecodes_to_healthplans' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Packagecodes_to_healthplans]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Packagecodes_to_healthplans' as TABLE_NAME,'PackageCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Packagecodes_to_healthplans]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Packagecodes_to_healthplans' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from MarketingCatalog.[Packagecodes_to_healthplans]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Packagecodes_to_healthplans' as TABLE_NAME,'Isactive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Isactive] as nvarchar))),'"') as VALUE from MarketingCatalog.[Packagecodes_to_healthplans]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'ClientCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'CatalogType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CatalogType] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'CatalogVersion' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CatalogVersion] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'ItemCodes' as TABLE_NAME,'DocumentName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentName] as nvarchar))),'"') as VALUE from MarketingCatalog.[ItemCodes]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillmenttype' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillmenttype]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillmenttype' as TABLE_NAME,'Fulfillmenttypecode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Fulfillmenttypecode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillmenttype]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillmenttype' as TABLE_NAME,'FulfillmenttypeDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmenttypeDesc] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillmenttype]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentMailing' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentMailing]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentMailing' as TABLE_NAME,'FulfillmentMailingcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentMailingcode] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentMailing]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentMailing' as TABLE_NAME,'FullfilmentMailingYear' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FullfilmentMailingYear] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentMailing]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentMailing' as TABLE_NAME,'FullfilmentMailingdesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FullfilmentMailingdesc] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentMailing]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentVendor' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentVendor]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentVendor' as TABLE_NAME,'VendorName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorName] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentVendor]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'FullfilmentVendor' as TABLE_NAME,'VendorNameDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorNameDesc] as nvarchar))),'"') as VALUE from MarketingCatalog.[FullfilmentVendor]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'DataSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DataSource] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'Packagecode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Packagecode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'FulfillmenttypeMailingcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmenttypeMailingcode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'Fulfillmenttypecode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Fulfillmenttypecode] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'Vendor' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Vendor] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a union 
select top 100 * from  (select distinct  'MarketingCatalog' as TABLE_SCHEMA,'Fulfillment_Member_Counts' as TABLE_NAME,'Membercount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Membercount] as nvarchar))),'"') as VALUE from MarketingCatalog.[Fulfillment_Member_Counts]) a 
) b
order by b.table_name, b.column_name