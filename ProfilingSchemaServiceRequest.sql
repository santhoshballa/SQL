select * from information_schema.columns where table_schema like '%ServiceRequest%'

select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('ServiceRequest')
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('ServiceRequest')

select * from information_schema.columns where table_schema = 'ServiceRequest'

-- TableNames
/*
'CaseJobs','MemberAppointments','MemberCardReasons','MemberCaseCategory','MemberCaseEscalateTeam','MemberCaseEvents','MemberCaseIssues','MemberCases','MemberCaseSource','MemberCaseStatus','MemberCaseTicketComments','MemberCaseTicketHistory','MemberCaseTickets','MemberCaseTopicIssueMapping','MemberCaseTopicReasons',
'MemberCaseTopics','MemberCaseTypeCategoryMapping','MemberCaseTypeIssueMapping','MemberCaseTypes','MemberCaseTypeTopicMapping','MemberDocumentDetails','MemberDocumentMaster',
'MemberGrievanceTicketDetails','MemberMEAEscaltionRouting','MemberOrders','MemberRelations','MemberRequestorTypes',
*/



select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ ' as TableName ' +','+ 'count(*) as RecordCount from ' + table_schema + '.' + table_name + ' (nolock) '+ ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('ServiceRequest') 

select distinct 'select top 10 '+''''++table_schema+'.'+ table_name +''''+ ' as TableName , * from ' +table_schema+'.'+ table_name from information_schema.columns where TABLE_SCHEMA like ('%ServiceRequest%') 


select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' with (nolock) '+
') a union '
from  information_Schema.COLUMNS
where 1=1 and 
TABLE_SCHEMA in ('ServiceRequest') 
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')


-- Record Count

select * from (
select 'ServiceRequest.CaseJobs' as TableName ,count(*) as RecordCount from ServiceRequest.CaseJobs (nolock)  Union 
select 'ServiceRequest.MemberAppointments' as TableName ,count(*) as RecordCount from ServiceRequest.MemberAppointments (nolock)  Union 
select 'ServiceRequest.MemberCardReasons' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCardReasons (nolock)  Union 
select 'ServiceRequest.MemberCaseCategory' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseCategory (nolock)  Union 
select 'ServiceRequest.MemberCaseEscalateTeam' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseEscalateTeam (nolock)  Union 
select 'ServiceRequest.MemberCaseEvents' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseEvents (nolock)  Union 
select 'ServiceRequest.MemberCaseIssues' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseIssues (nolock)  Union 
select 'ServiceRequest.MemberCases' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCases (nolock)  Union 
select 'ServiceRequest.MemberCaseSource' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseSource (nolock)  Union 
select 'ServiceRequest.MemberCaseStatus' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseStatus (nolock)  Union 
select 'ServiceRequest.MemberCaseTicketComments' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTicketComments (nolock)  Union 
select 'ServiceRequest.MemberCaseTicketHistory' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTicketHistory (nolock)  Union 
select 'ServiceRequest.MemberCaseTickets' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTickets (nolock)  Union 
select 'ServiceRequest.MemberCaseTopicIssueMapping' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTopicIssueMapping (nolock)  Union 
select 'ServiceRequest.MemberCaseTopicReasons' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTopicReasons (nolock)  Union 
select 'ServiceRequest.MemberCaseTopics' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTopics (nolock)  Union 
select 'ServiceRequest.MemberCaseTypeCategoryMapping' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTypeCategoryMapping (nolock)  Union 
select 'ServiceRequest.MemberCaseTypeIssueMapping' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTypeIssueMapping (nolock)  Union 
select 'ServiceRequest.MemberCaseTypes' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTypes (nolock)  Union 
select 'ServiceRequest.MemberCaseTypeTopicMapping' as TableName ,count(*) as RecordCount from ServiceRequest.MemberCaseTypeTopicMapping (nolock)  Union 
select 'ServiceRequest.MemberDocumentDetails' as TableName ,count(*) as RecordCount from ServiceRequest.MemberDocumentDetails (nolock)  Union 
select 'ServiceRequest.MemberDocumentMaster' as TableName ,count(*) as RecordCount from ServiceRequest.MemberDocumentMaster (nolock)  Union 
select 'ServiceRequest.MemberGrievanceTicketDetails' as TableName ,count(*) as RecordCount from ServiceRequest.MemberGrievanceTicketDetails (nolock)  Union 
select 'ServiceRequest.MemberMEAEscaltionRouting' as TableName ,count(*) as RecordCount from ServiceRequest.MemberMEAEscaltionRouting (nolock)  Union 
select 'ServiceRequest.MemberOrders' as TableName ,count(*) as RecordCount from ServiceRequest.MemberOrders (nolock)  Union 
select 'ServiceRequest.MemberRelations' as TableName ,count(*) as RecordCount from ServiceRequest.MemberRelations (nolock)  Union 
select 'ServiceRequest.MemberRequestorTypes' as TableName ,count(*) as RecordCount from ServiceRequest.MemberRequestorTypes (nolock)
) a
order by a.RecordCount desc


-- Top 100
select top 100 'ServiceRequest.MemberAppointments' as TableName , * from ServiceRequest.MemberAppointments -- yes
select top 100 'ServiceRequest.MemberCardReasons' as TableName , * from ServiceRequest.MemberCardReasons -- yes
select top 100 'ServiceRequest.MemberCaseCategory' as TableName , * from ServiceRequest.MemberCaseCategory -- yes
select top 100 'ServiceRequest.MemberCaseEscalateTeam' as TableName , * from ServiceRequest.MemberCaseEscalateTeam -- yes
select top 100 'ServiceRequest.MemberCaseEvents' as TableName , * from ServiceRequest.MemberCaseEvents -- yes
select top 100 'ServiceRequest.MemberCaseIssues' as TableName , * from ServiceRequest.MemberCaseIssues -- yes
select top 100 'ServiceRequest.MemberCases' as TableName , * from ServiceRequest.MemberCases -- yes
select top 100 'ServiceRequest.MemberCaseSource' as TableName , * from ServiceRequest.MemberCaseSource -- yes
select top 100 'ServiceRequest.MemberCaseStatus' as TableName , * from ServiceRequest.MemberCaseStatus -- yes
select top 100 'ServiceRequest.MemberCaseTicketComments' as TableName , * from ServiceRequest.MemberCaseTicketComments -- yes
select top 100 'ServiceRequest.MemberCaseTicketHistory' as TableName , * from ServiceRequest.MemberCaseTicketHistory --yes
select top 100 'ServiceRequest.MemberCaseTickets' as TableName , * from ServiceRequest.MemberCaseTickets -- yes
select top 100 'ServiceRequest.MemberCaseTopicIssueMapping' as TableName , * from ServiceRequest.MemberCaseTopicIssueMapping  -- yes
select top 100 'ServiceRequest.MemberCaseTopicReasons' as TableName , * from ServiceRequest.MemberCaseTopicReasons-- yes
select top 100 'ServiceRequest.MemberCaseTopics' as TableName , * from ServiceRequest.MemberCaseTopics  -- yes
select top 100 'ServiceRequest.MemberCaseTypeCategoryMapping' as TableName , * from ServiceRequest.MemberCaseTypeCategoryMapping -- yes
select top 100 'ServiceRequest.MemberCaseTypeIssueMapping' as TableName , * from ServiceRequest.MemberCaseTypeIssueMapping  -- yes
select top 100 'ServiceRequest.MemberCaseTypes' as TableName , * from ServiceRequest.MemberCaseTypes -- yes
select top 100 'ServiceRequest.MemberCaseTypeTopicMapping' as TableName , * from ServiceRequest.MemberCaseTypeTopicMapping -- yes
select top 100 'ServiceRequest.MemberDocumentDetails' as TableName , * from ServiceRequest.MemberDocumentDetails -- yes
select top 100 'ServiceRequest.MemberDocumentMaster' as TableName , * from ServiceRequest.MemberDocumentMaster -- yes
select top 100 'ServiceRequest.MemberGrievanceTicketDetails' as TableName , * from ServiceRequest.MemberGrievanceTicketDetails --yes
select top 100 'ServiceRequest.MemberMEAEscaltionRouting' as TableName , * from ServiceRequest.MemberMEAEscaltionRouting  -- yes
select top 100 'ServiceRequest.MemberOrders' as TableName , * from ServiceRequest.MemberOrders -- yes
select top 100 'ServiceRequest.MemberRelations' as TableName , * from ServiceRequest.MemberRelations -- yes
select top 100 'ServiceRequest.MemberRequestorTypes' as TableName , * from ServiceRequest.MemberRequestorTypes  --yes


select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberMEAEscaltionRouting' as TABLE_NAME,'MEAEscaltionRouting' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MEAEscaltionRouting] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberMEAEscaltionRouting] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberMEAEscaltionRouting' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberMEAEscaltionRouting] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseEscalateTeam' as TABLE_NAME,'UserMail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserMail] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseEscalateTeam] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseEscalateTeam' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseEscalateTeam] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseEscalateTeam' as TABLE_NAME,'Region' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Region] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseEscalateTeam] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'WipLine' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WipLine] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'AccountNum' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountNum] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'ProcessType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessType] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'ReturnReason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnReason] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'Card Proxy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Card Proxy] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'Remarks' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Remarks] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'CaseJobs' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[CaseJobs] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'CaseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'CaseNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseNumber] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'NHMemberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'RequestorName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RequestorName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'CaseData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCases' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCases] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseIssues' as TABLE_NAME,'CaseIssue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseIssue] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseIssues] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseIssues' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseIssues] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTypeTopicMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTypeTopicMapping] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'CaseTicketHistoryID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketHistoryID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'TableName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TableName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'ColumnName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ColumnName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'OldValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OldValue] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'NewValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NewValue] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketHistory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseSource' as TABLE_NAME,'CaseSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseSource] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseSource] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseSource' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseSource] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentMaster' as TABLE_NAME,'DocumentMasterID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentMasterID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentMaster] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentMaster' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentMaster] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentMaster' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentMaster] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseEvents' as TABLE_NAME,'CaseEvent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseEvent] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseEvents] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseEvents' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseEvents] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberRequestorTypes' as TABLE_NAME,'RequestorType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RequestorType] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberRequestorTypes] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberRequestorTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberRequestorTypes] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberRelations' as TABLE_NAME,'MemberRelation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberRelation] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberRelations] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberRelations' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberRelations] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'GrievanceTicketDetailID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GrievanceTicketDetailID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IsIncludeIntakeReporting' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsIncludeIntakeReporting] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IntakeReportingStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IntakeReportingStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IntakeReportingDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IntakeReportingDate] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IntakeReportingSummary' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IntakeReportingSummary] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IsIncludeClosureReporting' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsIncludeClosureReporting] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'ClosureReportingStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClosureReportingStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'ClosureReportingDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClosureReportingDate] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'ClosureReportingSummary' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClosureReportingSummary] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IsMEAEscalation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMEAEscalation] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'MeaEscalationComments' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MeaEscalationComments] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'CaseId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'MeaEscalationStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MeaEscalationStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'MeaEscalationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MeaEscalationDate] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'Reason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Reason] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'MeaEscalationRoutingId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MeaEscalationRoutingId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IsSubmitForFulfilment' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSubmitForFulfilment] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberGrievanceTicketDetails' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberGrievanceTicketDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketComments' as TABLE_NAME,'CaseTicketCommentsID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketCommentsID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketComments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketComments' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketComments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketComments' as TABLE_NAME,'Comments' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Comments] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketComments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketComments' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketComments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTicketComments' as TABLE_NAME,'IsRead' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsRead] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTicketComments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseCategory' as TABLE_NAME,'CaseCategory' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseCategory] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseCategory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseCategory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseCategory] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTypes' as TABLE_NAME,'CaseType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseType] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTypes] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTypes] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTypeCategoryMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTypeCategoryMapping] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTypeIssueMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTypeIssueMapping] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCardReasons' as TABLE_NAME,'CardReason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardReason] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCardReasons] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCardReasons' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCardReasons] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseStatus' as TABLE_NAME,'CaseStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseStatus] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseStatus' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseStatus] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTopics' as TABLE_NAME,'CaseTopic' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTopic] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTopics] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTopics' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTopics] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CaseTicketID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CaseTicketNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketNumber] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CaseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CallConversationID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CallConversationID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CaseTicketData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseTicketData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CaseIssues' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaseIssues] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'IsFirstCallResolution' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsFirstCallResolution] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'IsWrittenResolutionRequested' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsWrittenResolutionRequested] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'DueDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DueDate] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'AssignedTo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AssignedTo] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'DocumentID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'AdditionalInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AdditionalInfo] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'CardLast4digits' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardLast4digits] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'TransactionType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionType] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'TransactionStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTickets' as TABLE_NAME,'StatusReason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusReason] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTickets] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentDetails' as TABLE_NAME,'DocumentDetailID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentDetailID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentDetails' as TABLE_NAME,'DocumentMasterID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentMasterID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentDetails' as TABLE_NAME,'DocumentName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentDetails' as TABLE_NAME,'Extension' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Extension] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberDocumentDetails' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberDocumentDetails] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberCaseTopicIssueMapping' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberCaseTopicIssueMapping] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'MemberAppointmentId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberAppointmentId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'AppointmentTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppointmentTypeName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'AppointmentStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppointmentStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'ProviderName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'HCPName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'ProviderLocation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderLocation] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'ProviderZip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderZip] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'InsuranceHealthPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'AppointmentProcessData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppointmentProcessData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'ProviderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'LocationId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'AppointmentTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppointmentTypeId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberAppointments' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberAppointments] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'OrderType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'MemberData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'OrderAmountData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ShippingData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ProviderData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'OrderStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'TotalAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TotalAmount] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'orderDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([orderDate] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ItemName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemName] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ItemDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDescription] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ItemData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'UnitPrice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'Amount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'itemStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([itemStatus] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'InsuranceHealthPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanId] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a union 
select top 100 * from  (select distinct  'ServiceRequest' as TABLE_SCHEMA,'MemberOrders' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from ServiceRequest.[MemberOrders] with (nolock) ) a 