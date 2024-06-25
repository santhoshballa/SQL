select a.schema_id, b.name as SchemaName, a.name as TableName, a.type_desc, c.name as ColumnName, a.create_date
from sys.tables a 
join sys.schemas b on a.schema_id = b.schema_id
join sys.all_columns c on a.object_id = c.object_id
where b.name = 'callcenter'
order by a.create_date desc

select * from information_schema.columns where table_schema in  ('callcenter')
select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('callcenter')
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('callcenter')
/*
'Actions',
'AgentScripts',
'CallBackQueue',
'CallBackQueueVisibility',
'CallConversations',
'CallMapping',
'CallNotes',
'CallPageEvents',
'EventActions',
'Events',
'MemberSearchKeywords',
'MemberSearchResults',
'OutboundCallTypes',
'ScriptSections',
'ScriptSectionTypes',
'SwitchMemberDispositions',
'SwitchMemberMapping',

*/

select * from information_schema.columns where table_schema = 'callcenter'


select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ 'as TableName' +','+ 'count(*) as RecordCount from ' + table_schema + '.' + table_name + ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('callcenter') 

select * from (
select 'CallCenter.Actions'as TableName,count(*) as RecordCount from CallCenter.Actions Union 
select 'CallCenter.AgentScripts'as TableName,count(*) as RecordCount from CallCenter.AgentScripts Union 
select 'CallCenter.CallBackQueue'as TableName,count(*) as RecordCount from CallCenter.CallBackQueue Union 
select 'CallCenter.CallBackQueueVisibility'as TableName,count(*) as RecordCount from CallCenter.CallBackQueueVisibility Union 
select 'CallCenter.CallConversations'as TableName,count(*) as RecordCount from CallCenter.CallConversations Union 
select 'CallCenter.CallMapping'as TableName,count(*) as RecordCount from CallCenter.CallMapping Union 
select 'CallCenter.CallNotes'as TableName,count(*) as RecordCount from CallCenter.CallNotes Union 
select 'CallCenter.CallPageEvents'as TableName,count(*) as RecordCount from CallCenter.CallPageEvents Union 
select 'CallCenter.EventActions'as TableName,count(*) as RecordCount from CallCenter.EventActions Union 
select 'CallCenter.Events'as TableName,count(*) as RecordCount from CallCenter.Events Union 
select 'CallCenter.MemberSearchKeywords'as TableName,count(*) as RecordCount from CallCenter.MemberSearchKeywords Union 
select 'CallCenter.MemberSearchResults'as TableName,count(*) as RecordCount from CallCenter.MemberSearchResults Union 
select 'CallCenter.OutboundCallTypes'as TableName,count(*) as RecordCount from CallCenter.OutboundCallTypes Union 
select 'CallCenter.ScriptSections'as TableName,count(*) as RecordCount from CallCenter.ScriptSections Union 
select 'CallCenter.ScriptSectionTypes'as TableName,count(*) as RecordCount from CallCenter.ScriptSectionTypes Union 
select 'CallCenter.SwitchMemberDispositions'as TableName,count(*) as RecordCount from CallCenter.SwitchMemberDispositions Union 
select 'CallCenter.SwitchMemberMapping'as TableName,count(*) as RecordCount from CallCenter.SwitchMemberMapping
) a
order by a.RecordCount desc

/*
TableName	RecordCount
nb.RemotePlan	5701
nb.Purse	536
nb.PurseCashRule	536
nb.Carrier	347
nb.Mcc	317
nb.SubprogramPackageLink	102
nb.Plan	99
nb.SubprogramAPLLink	99
nb.HighRiskMCCs	96
nb.PurseBenefit	32
nb.MccGroup	27
nb.Package	21
nb.FudgeMCCs	10
nb.PlanStatus	7

*/

select * from information_schema.columns where table_schema = 'callcenter'

select distinct
'select top 100 ' +''''+table_schema + '.' +table_name +''''+ ' as TableName,* from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'callcenter'

select top 100 'CallCenter.Actions' as TableName,* from CallCenter.Actions
select top 100 'CallCenter.AgentScripts' as TableName,* from CallCenter.AgentScripts
select top 100 'CallCenter.CallBackQueue' as TableName,* from CallCenter.CallBackQueue
--select top 100 'CallCenter.CallBackQueueVisibility' as TableName,* from CallCenter.CallBackQueueVisibility -- zero records
select top 100 'CallCenter.CallConversations' as TableName,* from CallCenter.CallConversations
select top 100 'CallCenter.CallMapping' as TableName,* from CallCenter.CallMapping
select top 100 'CallCenter.CallNotes' as TableName,* from CallCenter.CallNotes
select top 100 'CallCenter.CallPageEvents' as TableName,* from CallCenter.CallPageEvents
select top 100 'CallCenter.EventActions' as TableName,* from CallCenter.EventActions
select top 100 'CallCenter.Events' as TableName,* from CallCenter.Events
-- select top 100 'CallCenter.MemberSearchKeywords' as TableName,* from CallCenter.MemberSearchKeywords  -- 2 records
select top 100 'CallCenter.MemberSearchResults' as TableName,* from CallCenter.MemberSearchResults
select top 100 'CallCenter.OutboundCallTypes' as TableName,* from CallCenter.OutboundCallTypes
select top 100 'CallCenter.ScriptSections' as TableName,* from CallCenter.ScriptSections
select top 100 'CallCenter.ScriptSectionTypes' as TableName,* from CallCenter.ScriptSectionTypes
select top 100 'CallCenter.SwitchMemberDispositions' as TableName,* from CallCenter.SwitchMemberDispositions
select top 100 'CallCenter.SwitchMemberMapping' as TableName,* from CallCenter.SwitchMemberMapping



select distinct
'select * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'callcenter'

select * from CallCenter.Actions
select * from CallCenter.AgentScripts
select * from CallCenter.CallBackQueue
select * from CallCenter.CallBackQueueVisibility
select * from CallCenter.CallConversations
select * from CallCenter.CallMapping
select * from CallCenter.CallNotes
select * from CallCenter.CallPageEvents
select * from CallCenter.EventActions
select * from CallCenter.Events
select * from CallCenter.MemberSearchKeywords
select * from CallCenter.MemberSearchResults
select * from CallCenter.OutboundCallTypes
select * from CallCenter.ScriptSections
select * from CallCenter.ScriptSectionTypes
select * from CallCenter.SwitchMemberDispositions
select * from CallCenter.SwitchMemberMapping

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
TABLE_SCHEMA in ('callcenter') 
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
-- and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select * from (

select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'EventActions' as TABLE_NAME,'EventActionId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventActionId] as nvarchar))),'"') as VALUE from CallCenter.[EventActions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'EventActions' as TABLE_NAME,'ActionId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActionId] as nvarchar))),'"') as VALUE from CallCenter.[EventActions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'EventActions' as TABLE_NAME,'EventId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventId] as nvarchar))),'"') as VALUE from CallCenter.[EventActions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'EventActions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[EventActions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'CallBound' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBound] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'EventCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventCode] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'EventName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventName] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'EventTriggerBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventTriggerBy] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'ParentId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentId] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Events' as TABLE_NAME,'ReferenceIdType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReferenceIdType] as nvarchar))),'"') as VALUE from CallCenter.[Events]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'OutboundCallTypes' as TABLE_NAME,'OutboundCallTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OutboundCallTypeId] as nvarchar))),'"') as VALUE from CallCenter.[OutboundCallTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'OutboundCallTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[OutboundCallTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'OutboundCallTypes' as TABLE_NAME,'OutboundCallTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OutboundCallTypeCode] as nvarchar))),'"') as VALUE from CallCenter.[OutboundCallTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'OutboundCallTypes' as TABLE_NAME,'OutboundCallTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OutboundCallTypeName] as nvarchar))),'"') as VALUE from CallCenter.[OutboundCallTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSections' as TABLE_NAME,'ScriptSectionID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptSectionID] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSections]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSections' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSections]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSections' as TABLE_NAME,'ScriptID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptID] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSections]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSections' as TABLE_NAME,'ScriptSectionTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptSectionTypeId] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSections]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSections' as TABLE_NAME,'SectionScriptDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SectionScriptDescription] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSections]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSectionTypes' as TABLE_NAME,'ScriptSectionTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptSectionTypeId] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSectionTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSectionTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSectionTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'ScriptSectionTypes' as TABLE_NAME,'ScriptSectionTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptSectionTypeName] as nvarchar))),'"') as VALUE from CallCenter.[ScriptSectionTypes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberDispositions' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberDispositions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberDispositions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberDispositions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberDispositions' as TABLE_NAME,'Disposition' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Disposition] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberDispositions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberDispositions' as TABLE_NAME,'DisplayOrder' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisplayOrder] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberDispositions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberMapping' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberMapping' as TABLE_NAME,'CallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberMapping' as TABLE_NAME,'ReasonCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonCode] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'SwitchMemberMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[SwitchMemberMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'MemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberID] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'NHMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'FirstName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'LastName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'DateOfBirth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOfBirth] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'Gender' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Gender] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'MaritalStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaritalStatus] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'Address2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'City' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'Country' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Country] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'ZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ZipCode] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'EmailAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmailAddress] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'Phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Phone] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'InsuranceHealthPlanNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanNumber] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'OTCCardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCCardNumber] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'InsuranceHealthPlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanName] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'InsuranceCarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierName] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'SearchFilterCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SearchFilterCarrierId] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchKeywords' as TABLE_NAME,'PONumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PONumber] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchKeywords]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'ConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'CallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'IsAutoEndCall' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsAutoEndCall] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'IsOtherCarrier' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsOtherCarrier] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallMapping' as TABLE_NAME,'IsForceEndCall' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsForceEndCall] as nvarchar))),'"') as VALUE from CallCenter.[CallMapping]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'SearchId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SearchId] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'ConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConversationId] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'SearchResults' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SearchResults] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'SearchRequest' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SearchRequest] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'IsAssigned' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsAssigned] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'MemberSearchResults' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[MemberSearchResults]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Actions' as TABLE_NAME,'ActionId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActionId] as nvarchar))),'"') as VALUE from CallCenter.[Actions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Actions' as TABLE_NAME,'ActionName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActionName] as nvarchar))),'"') as VALUE from CallCenter.[Actions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Actions' as TABLE_NAME,'ActionSchema' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActionSchema] as nvarchar))),'"') as VALUE from CallCenter.[Actions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'Actions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[Actions]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'AgentScripts' as TABLE_NAME,'ScriptID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptID] as nvarchar))),'"') as VALUE from CallCenter.[AgentScripts]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'AgentScripts' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[AgentScripts]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'AgentScripts' as TABLE_NAME,'ScriptDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptDescription] as nvarchar))),'"') as VALUE from CallCenter.[AgentScripts]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'AgentScripts' as TABLE_NAME,'ScriptName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptName] as nvarchar))),'"') as VALUE from CallCenter.[AgentScripts]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'AgentScripts' as TABLE_NAME,'ScriptType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ScriptType] as nvarchar))),'"') as VALUE from CallCenter.[AgentScripts]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackQueueId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackQueueId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'ActionProcessQueueId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActionProcessQueueId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'ActivityStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActivityStatus] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackCallType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackCallType] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackDate] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackMemberName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackMemberName] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackNumber] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackReason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackReason] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackRefId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackRefId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'CallBackType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackType] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'PriorityLevel' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriorityLevel] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'SourceActionProcessQueueId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceActionProcessQueueId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueue' as TABLE_NAME,'SourceAgentUserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceAgentUserProfileId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueue]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueueVisibility' as TABLE_NAME,'CallBackQueueVisibilityId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBackQueueVisibilityId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueueVisibility]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueueVisibility' as TABLE_NAME,'AgentUserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentUserProfileId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueueVisibility]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueueVisibility' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueueVisibility]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallBackQueueVisibility' as TABLE_NAME,'TransferAgentUserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransferAgentUserProfileId] as nvarchar))),'"') as VALUE from CallCenter.[CallBackQueueVisibility]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'AgentUserProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentUserProfileId] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'AgentUserProfileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentUserProfileName] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallBound' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallBound] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallEndSummary' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallEndSummary] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallerNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallerNumber] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallerTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallerTypeCode] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'CallingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallingNumber] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'EndCallSummaryEnd' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndCallSummaryEnd] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'EndCallSummaryStart' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndCallSummaryStart] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'EndTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndTime] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'LinkedCallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LinkedCallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'MemberNHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberNHMemberId] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'ProcessFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessFlag] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallConversations' as TABLE_NAME,'StartTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartTime] as nvarchar))),'"') as VALUE from CallCenter.[CallConversations]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallNotes' as TABLE_NAME,'CallNoteId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallNoteId] as nvarchar))),'"') as VALUE from CallCenter.[CallNotes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallNotes' as TABLE_NAME,'CallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallNotes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallNotes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallNotes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallNotes' as TABLE_NAME,'Note' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Note] as nvarchar))),'"') as VALUE from CallCenter.[CallNotes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallNotes' as TABLE_NAME,'PageName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PageName] as nvarchar))),'"') as VALUE from CallCenter.[CallNotes]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'CallPageEventId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallPageEventId] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'MemberAppointmentId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberAppointmentId] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'CallConversationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationId] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'EventId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EventId] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a union 
select top 100 * from  (select distinct  'CallCenter' as TABLE_SCHEMA,'CallPageEvents' as TABLE_NAME,'ReferenceIDsData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReferenceIDsData] as nvarchar))),'"') as VALUE from CallCenter.[CallPageEvents]) a
) b
order by b.table_name, b.column_name