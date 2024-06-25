select * from information_schema.columns where column_name like '%document%' or column_name like '%version%' order by table_schema

select * from information_schema.columns where table_schema = 'Document'

select top 10 * from document.documentLookup
select top 10 * from document.documentMaster
select top 10 * from document.documentObject
select top 10 * from document.documentTransaction

select '[document].[documentLookup]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentLookup] union all
select '[document].[documentMaster]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentMaster] union all 
select '[document].[documentObject]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentObject] union all
select '[document].[documentTransaction]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentTransaction]

/*
TableName	TotalNoOfRecords
[document].[documentLookup]	25
[document].[documentMaster]	132
[document].[documentObject]	324828
[document].[documentTransaction]	268979
*/


DECLARE @COLUMNS NVARCHAR(MAX) = null

SELECT @COLUMNS = (
SELECT ( STUFF (
  (
SELECT name as 'ListOfColumns' FROM sys.all_columns WHERE OBJECT_ID=OBJECT_ID('document.documentLookup') and name not in ('CreateUser','CreateDate','ModifyDate','ModifyUser')
	FOR XML PATH('')
  ),1,1,''
)
) AS COLUMNS
)

SELECT REPLACE(REPLACE(REPLACE(REPLACE(@COLUMNS, 'ListOfColumns', ''), '>',''), '<',''), '/',',')


SELECT @COLUMNS = (
SELECT ( STUFF (
  (
SELECT name as 'ListOfColumns' FROM sys.all_columns WHERE OBJECT_ID=OBJECT_ID('document.documentMaster') and name not in ('CreateUser','CreateDate','ModifyDate','ModifyUser')
	FOR XML PATH('')
  ),1,1,''
)
) AS COLUMNS
)

SELECT REPLACE(REPLACE(REPLACE(REPLACE(@COLUMNS, 'NAME', ''), '>',''), '<',''), '/',',')



SELECT @COLUMNS = (
SELECT ( STUFF (
  (
SELECT name as 'ListOfColumns' FROM sys.all_columns WHERE OBJECT_ID=OBJECT_ID('document.documentObject') and name not in ('CreateUser','CreateDate','ModifyDate','ModifyUser')
	FOR XML PATH('')
  ),1,1,''
)
) AS COLUMNS
)

SELECT REPLACE(REPLACE(REPLACE(REPLACE(@COLUMNS, 'NAME', ''), '>',''), '<',''), '/',',')


SELECT @COLUMNS = (
SELECT ( STUFF (
  (
SELECT name as 'ListOfColumns' FROM sys.all_columns WHERE OBJECT_ID=OBJECT_ID('document.documentTransaction') and name not in ('CreateUser','CreateDate','ModifyDate','ModifyUser')
	FOR XML PATH('')
  ),1,1,''
)
) AS COLUMNS
)

SELECT REPLACE(REPLACE(REPLACE(REPLACE(@COLUMNS, 'NAME', ''), '>',''), '<',''), '/',',')

--,CreateUser,CreateDate,ModifyDate,ModifyUser -- metadata columns

select top 1 '[document].[documentLookup]' as TableName, DocumentLookUpID,DocumentLookUpCode,DocumentLookUpName,IsActive from  [document].[documentLookup]
select top 1 '[document].[documentMaster]' as TableName, DocumentMasterID,DocumentExtension,DocumentName,DocumentObjectID,Download,ESign,Email,IsActive,Prefill,PrintDoc,Upload,DocumentTypeCode,State,Language from [document].[documentMaster] 
select top 1 '[document].[documentObject]' as TableName, DocumentObjectID,DocumentObject,IsActive,isFileholdSync from [document].[documentObject]
select top 1 '[document].[documentTransaction]' as TableName,DocumentID,BrowserName,BrowserVersion,ClientIP,DocUrl,DocumentExtension,DocumentLookUpID,DocumentMasterID,DocumentName,DocumentObjectID,DocumentSubTypeCode,DocumentTypeCode,DocumentUserRefID,IsActive,DocumentStatus,DocumentComments,DocumentVersion,MemberChartId,MemberChartDataId,MemberProfileId,DocProcessID from [document].[documentTransaction]
 

select '[document].[documentLookup]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentLookup] union all
select '[document].[documentMaster]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentMaster] union all 
select '[document].[documentObject]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentObject] union all
select '[document].[documentTransaction]' as TableName, count(*) as TotalNoOfRecords  from [document].[documentTransaction]






select top 10 '[document].[documentTransaction]' as TableName, a.*,'[document].[documentObject]' as TableName, b.*, '[document].[documentMaster]' as TableName, c.* ,'[document].[documentLookup]' as TableName, d.*
from [document].[documentTransaction] a 
join [document].[documentObject] b on a.DocumentObjectID = b.DocumentObjectID
join [document].[documentMaster] c on c.DocumentObjectID = b.DocumentObjectID
--left join [document].[documentLookup] d on d.DocumentLookUpID = a.DocumentLookUpID


select top 10 '[document].[documentTransaction]' as TableName, a.*,'[document].[documentObject]' as TableName, b.*,'[document].[documentMaster]' as TableName, c.*,
'[document].[documentLookup]' as TableName, '[document].[documentLookup]' as TableName, d.*, '[provider].[MemberCharts]' as TableName,  e.*, '[provider].[MemberChartData]' as TableName, f.*, '[provider].[MemberProfiles]', g.*
from [document].[documentTransaction] a 
join [document].[documentObject] b on a.DocumentObjectID = b.DocumentObjectID
left join [document].[documentMaster] c on a.DocumentMasterID= c.DocumentMasterID
left join [document].[documentLookup] d on a.DocumentLookUpID = d.DocumentLookUpID
join provider.MemberCharts e on a.MemberChartId = e.MemberChartId
join provider.MemberChartData f on a.MemberChartDataId = f.MemberChartDataId
join provider.MemberProfiles g on a.MemberProfileId = g.MemberProfileId

where 1=1
and DocProcessID in ( '52cf29cc-06f9-4b21-93f6-e804c6aa836a', '228fedb4-3c9c-4f2c-82b8-b6d77a86649a')
and NHMemberID in ('NH202006133690')


select routine_definition from information_schema.routines where routine_definition like '%documentTransaction%' and specific_schema = 'Document'

select * from Document.DocumentLookup

select * from information_schema.columns where column_name like '%DocumentLookUp%'

select 