select * from information_schema.columns where table_schema = 'dhc'
select distinct ''''+table_name+''''+',' from information_schema.columns where table_schema = 'dhc'
select distinct table_name from information_schema.columns where table_schema = 'dhc' and table_name in 
('AgentCallPerfomanceLogs','AgentStatusTypes','AudiogramReports','DeviceDiagnostics','DeviceLanguages','DeviceLocation','Devices','DeviceSession',
'DeviceSessionMemberLog','DeviceSessionResultLog','DeviceSessionTestLog','DHSStats','Languages','Manufacturers','Models','Orders','SessionOfflineRequests')
and column_name not in ('CreateDate', 'ModifyDate', 'CreateUser', 'ModifyUser')


select * from information_schema.columns where table_schema = 'dhc' and table_name in 
('AgentCallPerfomanceLogs','AgentStatusTypes','AudiogramReports','DeviceDiagnostics','DeviceLanguages','DeviceLocation','Devices','DeviceSession',
'DeviceSessionMemberLog','DeviceSessionResultLog','DeviceSessionTestLog','DHSStats','Languages','Manufacturers','Models','Orders','SessionOfflineRequests')
and column_name not in ('CreateDate', 'ModifyDate', 'CreateUser', 'ModifyUser')


select distinct 'select top 10 * from dhc.' + table_name from information_schema.columns where table_schema = 'dhc' and table_name in 
('AgentCallPerfomanceLogs','AgentStatusTypes','AudiogramReports','DeviceDiagnostics','DeviceLanguages','DeviceLocation','Devices','DeviceSession',
'DeviceSessionMemberLog','DeviceSessionResultLog','DeviceSessionTestLog','DHSStats','Languages','Manufacturers','Models','Orders','SessionOfflineRequests')
--and column_name not in ('CreateDate', 'ModifyDate', 'CreateUser', 'ModifyUser')

select top 10 * from dhc.AgentCallPerfomanceLogs
select top 10 * from dhc.AgentStatusTypes
select top 10 * from dhc.AudiogramReports
select top 10 * from dhc.DeviceDiagnostics
select top 10 * from dhc.DeviceLanguages
select top 10 * from dhc.DeviceLocation
select top 10 * from dhc.Devices
select top 10 * from dhc.DeviceSession
select top 10 * from dhc.DeviceSessionMemberLog
select top 10 * from dhc.DeviceSessionResultLog
select top 10 * from dhc.DeviceSessionTestLog
select top 10 * from dhc.DHSStats
select top 10 * from dhc.Languages
select top 10 * from dhc.Manufacturers
select top 10 * from dhc.Models
select top 10 * from dhc.Orders
select top 10 * from dhc.SessionOfflineRequests

select * from information_schema.columns where column_name like '%Status%' and table_schema = 'dhc'

select * from information_schema.columns where column_name like '%sessionID%' and table_schema = 'dhc'

select data_type, count(*) as NoOfRecords from information_schema.columns where table_schema = 'dhc' group by data_type order by 2 desc

--('nvarchar','bigint','datetime2','bit','varchar','datetime','int','uniqueidentifier','decimal','varbinary')

--'Devices_BK11MAY2020', Not required

select column_name, count(*) as RecordCount from information_schema.columns where table_schema = 'dhc' group by column_name having count(*) < 11 order by 2 desc

select distinct table_name from information_schema.columns where table_schema = 'dhc'

--select top 100 * from dhc.AgentCallPerfomanceLogs

-- select top 100 CallPerfomanceId,AgentUserProfileId,CallConversationID,SessionID,CallSource,CreateDateTime,UpdateDateTime,IsActive,CallStatus,CallRecordedPath from dhc.AgentCallPerfomanceLogs
-- select top 100 StatusType,IsActive,StatusTypeDesciption from dhc.AgentStatusTypes
-- select top 100 AudiogramReportId,AudiogramUrl,IsActive,ReportData from dhc.AudiogramReports
-- select top 100 DeviceDiagId,DeviceId,DiagnosticsDate,DiagnosticsBy,IsCamWorking,IsMicWorking,IsSpeakerWorking,IsDualCam,Notes,IsActive from dhc.DeviceDiagnostics
-- select top 100 LanguageId,LanguageName,LanguageData,IsActive from dhc.DeviceLanguages
-- select top 100 LocationId,DeviceId,Address1,Address2,City,State,Zip,Longitude,Latitude,InstallationDate,DeAccLocationDate,LocationBusinessName,LocationBusinessOwner,LocationContactPerson,LocationContactEmail,LocationContactPhone,Notes,IsActive,LocationContactEmail_IsVerified,LocationContactPhone_IsVerified,LocationBusinessHours,LocationEntryCode,KeepAliveData from dhc.DeviceLocation
-- select top 100 DeviceId,MFG_ID,Model_Id,Serial_No,Current_Active_Location_Id,IsActive,SecureCode,UserPin,DeviceSettings from dhc.Devices
-- select top 100 DeviceSessionId,SessionId,DeviceId,SessionStatus,StartDateTime,EndDateTime,IsActive,Name,Address,Email,MobileNumber,Zip,Notes,MemberInfo,NHMemberID from dhc.DeviceSession
-- select top 100 DeviceSessionMemberLogId,Name,Email,Address,MobileNumber,Zip,DeviceId,SessionId,StartDateTime,[EndDateTime ],Notes,IsActive,TestResultsData,AudiogramUrl,IterationId from dhc.DeviceSessionMemberLog -- zero records
-- select top 100 DeviceSessionResultLogId,IsActive,TestResultsData,DeviceId,AudiogramUrl,IterationId,SessionId,DocumentObjectID from dhc.DeviceSessionResultLog
-- select top 100 DeviceSessionTestLogId,EarType,Frequency,SessionId,DeviceId,TestStep,TestStepStatus,Decibals,StartDateTime,[EndDateTime ],Iteration,IsActive,StepNotes from dhc.DeviceSessionTestLog
select top 100 [DeviceId],[LocationBusinessName],[Completed Tests Today],[Completed Tests MTD],[VC Calls Today],[VC Calls MTD],[InComplete Tests Today],[InComplete Tests MTD] from dhc.DHSStats
-- select top 100 [LanguageId],[LanguageName],[LanguageData],[IsActive] from dhc.Languages -- zero records
-- select top 100 [MfgId],[MfgName],[Address1],[Address2],[City],[State],[Zip],[PrimaryContactPerson],[PrimaryContactEmail],[PrimaryContactPhone],[TechnicalContactPerson],[TechnicalContactEmail],[TechnicalContactPhone],[SalesContactPerson],[SalesContactEmail],[SalesContactPhone],[Notes],[IsActive] from  dhc.Manufacturers
-- select top 100 [ModelId],[MFG_ID],[Model_Name],[Descriptions],[Notes],[IsActive] from dhc.Models
select top 100 [DhcOrderID],[DHCId],[MemberData],[ItemData],[ShippingData],[PaymentData],[NHMemberId],[OrderID],[IsActive],[SessionId] from dhc.Orders
-- select top 100 [SessionOfflineRequestId],[SessionId],[DeviceId],[IsActive],[Notes] from dhc.SessionOfflineRequests


select top 10 * from dhc.AgentCallPerfomanceLogs
select top 1000 CallPerfomanceId,AgentUserProfileId,CallConversationID,SessionID,CallSource,CreateDateTime,UpdateDateTime,IsActive,CallStatus,CallRecordedPath from dhc.AgentCallPerfomanceLogs

select top 10 * from dhc.AgentStatusTypes
select top 10  StatusType,IsActive,StatusTypeDesciption from dhc.AgentStatusTypes

select top 10 * from dhc.AudiogramReports
select top 10 AudiogramReportId,AudiogramUrl,IsActive,ReportData from dhc.AudiogramReports

select top 10 * from dhc.DeviceDiagnostics
select top 10 DeviceDiagId,DeviceId,DiagnosticsDate,DiagnosticsBy,IsCamWorking,IsMicWorking,IsSpeakerWorking,IsDualCam,Notes,IsActive from dhc.DeviceDiagnostics

select top 10 * from dhc.DeviceLanguages
select top 10  LanguageId,LanguageName,LanguageData,IsActive from dhc.DeviceLanguages

select top 10 * from dhc.DeviceLocation
select top 10 LocationId,DeviceId,Address1,Address2,City,State,Zip,Longitude,Latitude,InstallationDate,DeAccLocationDate,LocationBusinessName,LocationBusinessOwner,LocationContactPerson,LocationContactEmail,LocationContactPhone,Notes,IsActive,LocationContactEmail_IsVerified,LocationContactPhone_IsVerified,LocationBusinessHours,LocationEntryCode,KeepAliveData from dhc.DeviceLocation

select top 10 * from dhc.Devices -- The serial number, SecureCode and UserPin are used by the owner to login the application. Device setting are configured here.
select top 10 DeviceId,MFG_ID,Model_Id,Serial_No,Current_Active_Location_Id,IsActive,SecureCode,UserPin,DeviceSettings from dhc.Devices

select top 10 * from dhc.DeviceSession -- A sessionID is created when a user is logged into the applicaiton to take a test. Test status S for start, T for Terminate and E for End.
select top 10 DeviceSessionId,SessionId,DeviceId,SessionStatus,StartDateTime,EndDateTime,IsActive,Name,Address,Email,MobileNumber,Zip,Notes,MemberInfo,NHMemberID from dhc.DeviceSession

select top 10 * from dhc.DeviceSessionMemberLog
select top 10 DeviceSessionMemberLogId,Name,Email,Address,MobileNumber,Zip,DeviceId,SessionId,StartDateTime,[EndDateTime ],Notes,IsActive,TestResultsData,AudiogramUrl,IterationId from dhc.DeviceSessionMemberLog

select top 10 * from dhc.DeviceSessionResultLog
select top 10 DeviceSessionResultLogId,IsActive,TestResultsData,DeviceId,AudiogramUrl,IterationId,SessionId,DocumentObjectID from dhc.DeviceSessionResultLog

select top 10 * from dhc.DeviceSessionTestLog -- All information related to the hearing tests are in this table
select top 10 DeviceSessionTestLogId,EarType,Frequency,SessionId,DeviceId,TestStep,TestStepStatus,Decibals,StartDateTime,[EndDateTime ],Iteration,IsActive,StepNotes from dhc.DeviceSessionTestLog

select top 10 * from dhc.DHSStats
select top 10 [DeviceId],[LocationBusinessName],[Completed Tests Today],[Completed Tests MTD],[VC Calls Today],[VC Calls MTD],[InComplete Tests Today],[InComplete Tests MTD] from dhc.DHSStats

select top 10 * from dhc.Languages -- contains zero records
select top 10 [LanguageId],[LanguageName],[LanguageData],[IsActive] from dhc.Languages

select top 10 * from dhc.Manufacturers
select top 10 [MfgId],[MfgName],[Address1],[Address2],[City],[State],[Zip],[PrimaryContactPerson],[PrimaryContactEmail],[PrimaryContactPhone],[TechnicalContactPerson],[TechnicalContactEmail],[TechnicalContactPhone],[SalesContactPerson],[SalesContactEmail],[SalesContactPhone],[Notes],[IsActive] from  dhc.Manufacturers

select top 10 * from dhc.Models
select top 10 [ModelId],[MFG_ID],[Model_Name],[Descriptions],[Notes],[IsActive] from dhc.Models

select top 10 * from dhc.Orders
select top 10 [DhcOrderID],[DHCId],[MemberData],[ItemData],[ShippingData],[PaymentData],[NHMemberId],[OrderID],[IsActive],[SessionId] from dhc.Orders

select top 10 * from dhc.SessionOfflineRequests
select top 10 [SessionOfflineRequestId],[SessionId],[DeviceId],[IsActive],[Notes] from dhc.SessionOfflineRequests

select distinct table_schema from information_schema.tables
select * from information_schema.tables where table_schema like '%sys%'

select * from sys.objects
select a.*, b.* from sys.objects a join sys.tables b on a.parent_object_id = b.object_id where b.schema_id = 53  and a.name not like '%CreateUser%' and a.name not like '%ModifyUser%' order by a.name
select * from sys.tables where schema_id = 53
select * from sys.schemas where schema_id = 53


--select * from dhc.AgentStatusTypes
select StatusType, StatusTypeDesciption, IsActive from dhc.AgentStatusTypes
/*
Only 6 StatusTypes
StatusType	StatusTypeDesciption
	100			TRYING
	180			RINGING
	183			IN-PROGRESS
	202			ACCEPTED
	480			MISSED
	487			ENDED
*/


select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 100 and CallConversationID is null and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 180 and CallConversationID is null and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 183 and CallConversationID is null and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 202 and CallConversationID is null and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 480 and CallConversationID is null and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 487 and CallConversationID is null and CallSource = 'DHE'

select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 100 and CallConversationID = 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 180 and CallConversationID = 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 183 and CallConversationID = 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 202 and CallConversationID = 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 480 and CallConversationID = 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 487 and CallConversationID = 0 and CallSource = 'DHE'

select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 100 and CallConversationID > 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 180 and CallConversationID > 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 183 and CallConversationID > 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 202 and CallConversationID > 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 480 and CallConversationID > 0 and CallSource = 'DHE'
select top 100 * from dhc.AgentCallPerfomanceLogs where CallStatus = 487 and CallConversationID > 0 and CallSource = 'DHE'


/*
declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '%Ruskin%'
*/

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
where table_schema = 'dhc' and table_name in 
('AgentCallPerfomanceLogs','AgentStatusTypes','AudiogramReports','DeviceDiagnostics','DeviceLanguages','DeviceLocation','Devices','DeviceSession',
'DeviceSessionMemberLog','DeviceSessionResultLog','DeviceSessionTestLog','DHSStats','Languages','Manufacturers','Models','Orders','SessionOfflineRequests')
and column_name not in ('CreateDate', 'ModifyDate', 'CreateUser', 'ModifyUser')
and data_type in ('nvarchar','bigint','datetime2','bit','varchar','datetime','int','decimal') --'varbinary' 'uniqueidentifier' removed

declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '%Ruskin%'

select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallPerfomanceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallPerfomanceId] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CallPerfomanceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'AgentUserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentUserProfileId] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([AgentUserProfileId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallConversationID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationID] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CallConversationID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallSource|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallSource] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CallSource] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CreateDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDateTime] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CreateDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'UpdateDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdateDateTime] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([UpdateDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallStatus] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CallStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallRecordedPath|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallRecordedPath] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs] where ltrim(rtrim(cast([CallRecordedPath] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'StatusType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusType] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes] where ltrim(rtrim(cast([StatusType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'StatusTypeDesciption|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusTypeDesciption] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes] where ltrim(rtrim(cast([StatusTypeDesciption] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'AudiogramReportId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramReportId] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports] where ltrim(rtrim(cast([AudiogramReportId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports] where ltrim(rtrim(cast([AudiogramUrl] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DeviceDiagId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceDiagId] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([DeviceDiagId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DiagnosticsDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiagnosticsDate] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([DiagnosticsDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DiagnosticsBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiagnosticsBy] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([DiagnosticsBy] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsCamWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCamWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([IsCamWorking] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsMicWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMicWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([IsMicWorking] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsSpeakerWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSpeakerWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([IsSpeakerWorking] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsDualCam|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDualCam] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([IsDualCam] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageId] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages] where ltrim(rtrim(cast([LanguageId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageName] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages] where ltrim(rtrim(cast([LanguageName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageData] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages] where ltrim(rtrim(cast([LanguageData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationId] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Address1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Address2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([City] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([State] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Zip] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Longitude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Longitude] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Longitude] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Latitude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Latitude] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Latitude] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'InstallationDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InstallationDate] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([InstallationDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'DeAccLocationDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeAccLocationDate] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([DeAccLocationDate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessName] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationBusinessName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessOwner|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessOwner] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationBusinessOwner] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPerson] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationContactPerson] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactEmail] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationContactEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPhone] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationContactPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactEmail_IsVerified|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactEmail_IsVerified] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationContactEmail_IsVerified] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPhone_IsVerified|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPhone_IsVerified] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationContactPhone_IsVerified] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessHours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessHours] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationBusinessHours] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationEntryCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationEntryCode] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([LocationEntryCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'KeepAliveData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([KeepAliveData] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation] where ltrim(rtrim(cast([KeepAliveData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'MFG_ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MFG_ID] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([MFG_ID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Model_Id|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model_Id] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([Model_Id] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Serial_No|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Serial_No] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([Serial_No] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Current_Active_Location_Id|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Current_Active_Location_Id] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([Current_Active_Location_Id] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'SecureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SecureCode] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([SecureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'UserPin|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserPin] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([UserPin] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'DeviceSettings|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSettings] as nvarchar))),'"') as VALUE from dhc.[Devices] where ltrim(rtrim(cast([DeviceSettings] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'DeviceSessionId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionId] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([DeviceSessionId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'SessionStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SessionStatus] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([SessionStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([StartDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'EndDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([EndDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([Name] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Address|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([Address] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Email|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Email] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([Email] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'MobileNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MobileNumber] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([MobileNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([Zip] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'MemberInfo|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberInfo] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([MemberInfo] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'NHMemberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from dhc.[DeviceSession] where ltrim(rtrim(cast([NHMemberID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'DeviceSessionMemberLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionMemberLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([DeviceSessionMemberLogId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([Name] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Email|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Email] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([Email] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Address|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([Address] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'MobileNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MobileNumber] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([MobileNumber] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([Zip] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([StartDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'EndDateTime |' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime ] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([EndDateTime ] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'TestResultsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestResultsData] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([TestResultsData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([AudiogramUrl] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'IterationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IterationId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog] where ltrim(rtrim(cast([IterationId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DeviceSessionResultLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionResultLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([DeviceSessionResultLogId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'TestResultsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestResultsData] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([TestResultsData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([AudiogramUrl] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'IterationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IterationId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([IterationId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DocumentObjectID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentObjectID] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog] where ltrim(rtrim(cast([DocumentObjectID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'DeviceSessionTestLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionTestLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([DeviceSessionTestLogId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'EarType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarType] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([EarType] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Frequency|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Frequency] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([Frequency] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'TestStep|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestStep] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([TestStep] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'TestStepStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestStepStatus] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([TestStepStatus] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Decibals|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Decibals] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([Decibals] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([StartDateTime] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'EndDateTime |' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime ] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([EndDateTime ] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Iteration|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Iteration] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([Iteration] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'StepNotes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StepNotes] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog] where ltrim(rtrim(cast([StepNotes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'LocationBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessName] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([LocationBusinessName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'Completed Tests Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Completed Tests Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([Completed Tests Today] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'Completed Tests MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Completed Tests MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([Completed Tests MTD] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'VC Calls Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VC Calls Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([VC Calls Today] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'VC Calls MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VC Calls MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([VC Calls MTD] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'InComplete Tests Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InComplete Tests Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([InComplete Tests Today] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'InComplete Tests MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InComplete Tests MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats] where ltrim(rtrim(cast([InComplete Tests MTD] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageId] as nvarchar))),'"') as VALUE from dhc.[Languages] where ltrim(rtrim(cast([LanguageId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageName] as nvarchar))),'"') as VALUE from dhc.[Languages] where ltrim(rtrim(cast([LanguageName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageData] as nvarchar))),'"') as VALUE from dhc.[Languages] where ltrim(rtrim(cast([LanguageData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Languages] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'MfgId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MfgId] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([MfgId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'MfgName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MfgName] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([MfgName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([Address1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([Address2] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([City] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([State] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([Zip] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([PrimaryContactPerson] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([PrimaryContactEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([PrimaryContactPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([TechnicalContactPerson] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([TechnicalContactEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([TechnicalContactPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([SalesContactPerson] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([SalesContactEmail] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([SalesContactPhone] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Manufacturers] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'ModelId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelId] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([ModelId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'MFG_ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MFG_ID] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([MFG_ID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Model_Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model_Name] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([Model_Name] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Descriptions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Descriptions] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([Descriptions] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Models] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DhcOrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DhcOrderID] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([DhcOrderID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DHCId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHCId] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([DHCId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([MemberData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([ItemData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([ShippingData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'PaymentData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentData] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([PaymentData] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([NHMemberId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Orders] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'SessionOfflineRequestId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SessionOfflineRequestId] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests] where ltrim(rtrim(cast([SessionOfflineRequestId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests] where ltrim(rtrim(cast([DeviceId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests] where ltrim(rtrim(cast([Notes] as nvarchar))) like @SearchPredicate) a

select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('dhc')
and table_name in 
('AgentCallPerfomanceLogs','AgentStatusTypes','AudiogramReports','DeviceDiagnostics','DeviceLanguages','DeviceLocation','Devices','DeviceSession',
'DeviceSessionMemberLog','DeviceSessionResultLog','DeviceSessionTestLog','DHSStats','Languages','Manufacturers','Models','Orders','SessionOfflineRequests')
and column_name not in ('CreateDate', 'ModifyDate', 'CreateUser', 'ModifyUser') 
and data_type in ('nvarchar','bigint','datetime2','bit','varchar','datetime','int','decimal') --'varbinary' 'uniqueidentifier' removed
order by table_schema, table_name

select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallPerfomanceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallPerfomanceId] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'AgentUserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentUserProfileId] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallConversationID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationID] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallSource|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallSource] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CreateDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDateTime] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'UpdateDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdateDateTime] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallStatus] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentCallPerfomanceLogs|' as TABLE_NAME,'CallRecordedPath|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallRecordedPath] as nvarchar))),'"') as VALUE from dhc.[AgentCallPerfomanceLogs]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'StatusType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusType] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AgentStatusTypes|' as TABLE_NAME,'StatusTypeDesciption|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusTypeDesciption] as nvarchar))),'"') as VALUE from dhc.[AgentStatusTypes]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'AudiogramReportId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramReportId] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'AudiogramReports|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[AudiogramReports]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DeviceDiagId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceDiagId] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DiagnosticsDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiagnosticsDate] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'DiagnosticsBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiagnosticsBy] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsCamWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCamWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsMicWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMicWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsSpeakerWorking|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSpeakerWorking] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsDualCam|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDualCam] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceDiagnostics|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceDiagnostics]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageId] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageName] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'LanguageData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageData] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLanguages|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceLanguages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationId] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Longitude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Longitude] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Latitude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Latitude] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'InstallationDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InstallationDate] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'DeAccLocationDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeAccLocationDate] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessName] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessOwner|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessOwner] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPerson] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactEmail] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPhone] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactEmail_IsVerified|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactEmail_IsVerified] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationContactPhone_IsVerified|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationContactPhone_IsVerified] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationBusinessHours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessHours] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'LocationEntryCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationEntryCode] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceLocation|' as TABLE_NAME,'KeepAliveData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([KeepAliveData] as nvarchar))),'"') as VALUE from dhc.[DeviceLocation]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'MFG_ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MFG_ID] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Model_Id|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model_Id] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Serial_No|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Serial_No] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'Current_Active_Location_Id|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Current_Active_Location_Id] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'SecureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SecureCode] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'UserPin|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserPin] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Devices|' as TABLE_NAME,'DeviceSettings|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSettings] as nvarchar))),'"') as VALUE from dhc.[Devices]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'DeviceSessionId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionId] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'SessionStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SessionStatus] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'EndDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Address|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Email|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Email] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'MobileNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MobileNumber] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'MemberInfo|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberInfo] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSession|' as TABLE_NAME,'NHMemberID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from dhc.[DeviceSession]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'DeviceSessionMemberLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionMemberLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Email|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Email] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Address|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'MobileNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MobileNumber] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'EndDateTime |' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime ] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'TestResultsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestResultsData] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionMemberLog|' as TABLE_NAME,'IterationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IterationId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionMemberLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DeviceSessionResultLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionResultLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'TestResultsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestResultsData] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'AudiogramUrl|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AudiogramUrl] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'IterationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IterationId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionResultLog|' as TABLE_NAME,'DocumentObjectID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentObjectID] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionResultLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'DeviceSessionTestLogId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceSessionTestLogId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'EarType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarType] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Frequency|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Frequency] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'TestStep|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestStep] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'TestStepStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TestStepStatus] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Decibals|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Decibals] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'StartDateTime|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDateTime] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'EndDateTime |' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDateTime ] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'Iteration|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Iteration] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DeviceSessionTestLog|' as TABLE_NAME,'StepNotes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StepNotes] as nvarchar))),'"') as VALUE from dhc.[DeviceSessionTestLog]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'LocationBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationBusinessName] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'Completed Tests Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Completed Tests Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'Completed Tests MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Completed Tests MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'VC Calls Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VC Calls Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'VC Calls MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VC Calls MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'InComplete Tests Today|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InComplete Tests Today] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'DHSStats|' as TABLE_NAME,'InComplete Tests MTD|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InComplete Tests MTD] as nvarchar))),'"') as VALUE from dhc.[DHSStats]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageId] as nvarchar))),'"') as VALUE from dhc.[Languages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageName] as nvarchar))),'"') as VALUE from dhc.[Languages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'LanguageData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LanguageData] as nvarchar))),'"') as VALUE from dhc.[Languages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Languages|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Languages]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'MfgId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MfgId] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'MfgName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MfgName] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'PrimaryContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'TechnicalContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnicalContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactPerson|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactPerson] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactEmail|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactEmail] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'SalesContactPhone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesContactPhone] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Manufacturers|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Manufacturers]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'ModelId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelId] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'MFG_ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MFG_ID] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Model_Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model_Name] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Descriptions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Descriptions] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Models|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Models]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DhcOrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DhcOrderID] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DHCId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHCId] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'PaymentData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentData] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[Orders]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'SessionOfflineRequestId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SessionOfflineRequestId] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'DeviceId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeviceId] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests]) a union 
select top 40 * from  (select distinct  'dhc|' as TABLE_SCHEMA,'SessionOfflineRequests|' as TABLE_NAME,'Notes|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Notes] as nvarchar))),'"') as VALUE from dhc.[SessionOfflineRequests]) a




