select a.schema_id, b.name as SchemaName, a.name as TableName, a.type_desc, c.name as ColumnName, a.create_date
from sys.tables a 
join sys.schemas b on a.schema_id = b.schema_id
join sys.all_columns c on a.object_id = c.object_id
where b.name = 'dbo' and a.name like 'FISCCX%'
order by a.create_date desc


select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('dbo') and table_name like 'FISCCX%'
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('dbo') and table_name like 'FISCCX%'

select * from information_schema.columns where TABLE_SCHEMA in ('dbo') and table_name like 'FISCCX%'


select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ 'as TableName' +','+ 'count(*) as RecordCount from ' + table_schema + '.' + table_name + ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('dbo') and table_name like 'FISCCX%'

select * from (
select 'dbo.FISCCX_DCST'as TableName,count(*) as RecordCount from dbo.FISCCX_DCST Union 
select 'dbo.FISCCX_DIIA'as TableName,count(*) as RecordCount from dbo.FISCCX_DIIA Union 
select 'dbo.FISCCX_DODL'as TableName,count(*) as RecordCount from dbo.FISCCX_DODL Union 
select 'dbo.FISCCX_DPKG'as TableName,count(*) as RecordCount from dbo.FISCCX_DPKG Union 
select 'dbo.FISCCX_DPRY'as TableName,count(*) as RecordCount from dbo.FISCCX_DPRY Union 
select 'dbo.FISCCX_DPUR'as TableName,count(*) as RecordCount from dbo.FISCCX_DPUR Union 
select 'dbo.FISCCX_DSPG'as TableName,count(*) as RecordCount from dbo.FISCCX_DSPG Union 
select 'dbo.FISCCX_DUSR'as TableName,count(*) as RecordCount from dbo.FISCCX_DUSR Union 
select 'dbo.FISCCX_Header'as TableName,count(*) as RecordCount from dbo.FISCCX_Header Union 
select 'dbo.FISCCX_Trailer'as TableName,count(*) as RecordCount from dbo.FISCCX_Trailer Union 
select 'dbo.FISCCXStg'as TableName,count(*) as RecordCount from dbo.FISCCXStg
) a
order by a.RecordCount desc

/*
TableName	RecordCount
dbo.FISCCXStg	30747
dbo.FISCCX_DPUR	8508
dbo.FISCCX_DIIA	7446
dbo.FISCCX_DCST	7254
dbo.FISCCX_DPRY	3635
dbo.FISCCX_DPKG	2424
dbo.FISCCX_DSPG	781
dbo.FISCCX_DODL	645
dbo.FISCCX_DUSR	42
dbo.FISCCX_Header	6
dbo.FISCCX_Trailer	6

*/

select * from information_schema.columns where table_schema = 'dbo' and table_name like 'FISCCX%'

select distinct
'select top 100 ' +''''+table_schema + '.' +table_name +''''+ ' as TableName,* from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'dbo' and table_name like 'FISCCX%'

select top 100 'dbo.FISCCX_DCST' as TableName,* from dbo.FISCCX_DCST
select top 100 'dbo.FISCCX_DIIA' as TableName,* from dbo.FISCCX_DIIA
select top 100 'dbo.FISCCX_DODL' as TableName,* from dbo.FISCCX_DODL
select top 100 'dbo.FISCCX_DPKG' as TableName,* from dbo.FISCCX_DPKG
select top 100 'dbo.FISCCX_DPRY' as TableName,* from dbo.FISCCX_DPRY
select top 100 'dbo.FISCCX_DPUR' as TableName,* from dbo.FISCCX_DPUR
select top 100 'dbo.FISCCX_DSPG' as TableName,* from dbo.FISCCX_DSPG
select top 100 'dbo.FISCCX_DUSR' as TableName,* from dbo.FISCCX_DUSR
select top 100 'dbo.FISCCX_Header' as TableName,* from dbo.FISCCX_Header
select top 100 'dbo.FISCCX_Trailer' as TableName,* from dbo.FISCCX_Trailer
select top 100 'dbo.FISCCXStg' as TableName,* from dbo.FISCCXStg

select distinct
'select * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'dbo' and table_name like 'FISCCX%'

select * from dbo.FISCCX_DCST
select * from dbo.FISCCX_DIIA
select * from dbo.FISCCX_DODL
select * from dbo.FISCCX_DPKG
select * from dbo.FISCCX_DPRY
select * from dbo.FISCCX_DPUR
select * from dbo.FISCCX_DSPG
select * from dbo.FISCCX_DUSR
select * from dbo.FISCCX_Header
select * from dbo.FISCCX_Trailer
select * from dbo.FISCCXStg

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
table_schema = 'dbo' and table_name like 'FISCCX%'
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
-- and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select * from (

select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'PurseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'CashType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CashType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'TotalAmountLimit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TotalAmountLimit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'TotalCountLimit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TotalCountLimit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'MaxAmountPerTrans' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxAmountPerTrans] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'MinAmountPerTrans' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinAmountPerTrans] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'CycleAmountLimit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CycleAmountLimit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'CycleCountLimit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CycleCountLimit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'CycleDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CycleDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'IsDeleted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeleted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DCST' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DCST]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'PurseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IIAS' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIAS] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IIASDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASDesc] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IIASGroupID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASGroupID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IIASGroupDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASGroupDesc] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'Priority' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Priority] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IsDeleted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeleted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IIASGroupPriority' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASGroupPriority] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DIIA' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DIIA]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'MCCGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCGroup] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'Fudge' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Fudge] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'IncAuthHoldTimeMCCGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IncAuthHoldTimeMCCGroup] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'AuthHoldTimeDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthHoldTimeDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DODL' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DODL]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'PackageID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'PackageName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'ArtworkName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ArtworkName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'BIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BIN] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'PrinAndAgentRange' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrinAndAgentRange] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'FulfillmentHouse' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentHouse] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'CardCountThreshold' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardCountThreshold] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'CardIssuedSequentFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardIssuedSequentFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'BarcodeType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BarcodeType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'FormFactor' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FormFactor] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'ReplacementPackageID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReplacementPackageID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'DuplicateSettlementAwaitInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DuplicateSettlementAwaitInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'AuthAwaitSettlementInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthAwaitSettlementInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'EncodingMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EncodingMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'PartialAuth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PartialAuth] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'IsDeleted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeleted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'ImmediateCredit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImmediateCredit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'ApprovedProductList' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ApprovedProductList] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPKG' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPKG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'PurseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'GroupID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'MCCGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCGroup] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'MCCDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCDesc] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'Priority' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Priority] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'IsDeleted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeleted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPRY' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPRY]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'PurseID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'PurseStrategy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseStrategy] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'AllowedMCCGroups' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AllowedMCCGroups] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'NetworkName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NetworkName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'PurseValueLimits' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseValueLimits] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'MinimumValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinimumValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'MaximumValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaximumValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'MinimumLoad' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinimumLoad] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'MaximumLoad' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaximumLoad] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'EffectiveDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EffectiveDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'ExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExpirationDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'ExtensionDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExtensionDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'ExtensionFlagName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExtensionFlagName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'IsDeleted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeleted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'PurseHandle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseHandle] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'DefaultPurseForAuth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DefaultPurseForAuth] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DPUR' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DPUR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SubProgramName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SubProgramActiveFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubProgramActiveFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProgramName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClientName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClientAltValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientAltValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TemplateSubProgramID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TemplateSubProgramID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FISAssumeFraudLiability' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISAssumeFraudLiability] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProxyName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProxyName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AKAName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AKAName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PseudoBIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PseudoBIN] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MarketSegment' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MarketSegment] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProgramLevel' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramLevel] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProgramUseProxyNumbers' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramUseProxyNumbers] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProxyType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProxyType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IVRAuthenticationMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IVRAuthenticationMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CardType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ProgramType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProgramType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PINBased' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PINBased] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PINTries' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PINTries] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'NumberOfDaysPINLocked' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NumberOfDaysPINLocked] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RePlastic' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RePlastic] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AdvanceExpire' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AdvanceExpire] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrivacyOptOut' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrivacyOptOut] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'LoadSuspend' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LoadSuspend] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ApproveMissingTransaction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ApproveMissingTransaction] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SkipExpiredClosedCardDDA' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SkipExpiredClosedCardDDA] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AreCardsReloadable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AreCardsReloadable] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'InitialCardStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InitialCardStatus] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ActiveMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActiveMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'HowWillCardsBeActivated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HowWillCardsBeActivated] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PhysicalExpirationMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PhysicalExpirationMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PhysicalExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PhysicalExpirationDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PhysicalExpirationMonth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PhysicalExpirationMonth] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'Logical' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Logical] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'LogicalDynamic' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LogicalDynamic] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'LogicalExpireEvent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LogicalExpireEvent] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AutoRenewal' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AutoRenewal] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RenewalWindow' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RenewalWindow] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RenewalMonths' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RenewalMonths] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RenewalCardStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RenewalCardStatus] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BalanceThreshold' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BalanceThreshold] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FinancialActivityWindowInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FinancialActivityWindowInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PositiveFinancialActivityWindow' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PositiveFinancialActivityWindow] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'UtilizeReplacementPackage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UtilizeReplacementPackage] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AccountValueLimits' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountValueLimits] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FixedValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FixedValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MinValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MinLoadOnCard' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinLoadOnCard] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxLoadOnCard' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxLoadOnCard] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ThirdLineEmbossing' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ThirdLineEmbossing] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ThirdLineEmbossStaticName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ThirdLineEmbossStaticName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FourthLineEmbossing' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FourthLineEmbossing] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FourthLineEmbossStaticName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FourthLineEmbossStaticName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EmbossOrPrintBeginDates' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmbossOrPrintBeginDates] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EmbossOrPrintExpireDates' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmbossOrPrintExpireDates] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EmbossOrPrintSecurityCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmbossOrPrintSecurityCode] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SendPIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SendPIN] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PINMailerLag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PINMailerLag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PINMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PINMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CarrierSlotType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierSlotType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnAddress1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnAddress1] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnAddress2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnAddress2] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnAddress3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnAddress3] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnAddress4' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnAddress4] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintLine1AccountNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintLine1AccountNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintLine2ExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintLine2ExpirationDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintLine3CardholderName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintLine3CardholderName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintLine4' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintLine4] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintProxy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintProxy] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintIndentCardNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintIndentCardNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintSecurityCodeOnIndent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintSecurityCodeOnIndent] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IssueDuplicateCard' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IssueDuplicateCard] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EmbossFullDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EmbossFullDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SortBySequentialProxyNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SortBySequentialProxyNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassCardHolderPhoneNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassCardHolderPhoneNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassCardholderEmail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassCardholderEmail] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassCardholderDARoutingInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassCardholderDARoutingInfo] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassCountry' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassCountry] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassOtherInformation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassOtherInformation] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PassClientAltValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PassClientAltValue] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ParsingRulesToAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParsingRulesToAddress] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ShipmentRecordsFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShipmentRecordsFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MagName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MagName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FulfillmentInstructions1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentInstructions1] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FulfillmentInstructions2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentInstructions2] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DiscretionaryData1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiscretionaryData1] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DiscretionaryData2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiscretionaryData2] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DiscretionaryData3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DiscretionaryData3] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CardNumberEmbossingMask' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardNumberEmbossingMask] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SecondaryCardsFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SecondaryCardsFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'NumberOfSecondaryCards' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NumberOfSecondaryCards] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxActivationAttempts' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxActivationAttempts] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AllowBillPayFunctionality' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AllowBillPayFunctionality] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BlockBillingTransactionFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BlockBillingTransactionFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValueLoadUponActivation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueLoadUponActivation] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ExpiredCardConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExpiredCardConfig] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RetailReloadNetworkServices' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RetailReloadNetworkServices] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MoneyTransferSetupFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MoneyTransferSetupFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SetupMasterCardMoneySend' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SetupMasterCardMoneySend] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PFraudConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PFraudConfig] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EnableOpenToBuyBalanceAtPOS' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EnableOpenToBuyBalanceAtPOS] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BlockCountry' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BlockCountry] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'UnblockCountry' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnblockCountry] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IncludeCountry' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IncludeCountry] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'VelocityLimitPeriodInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VelocityLimitPeriodInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValueLoadNumberPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueLoadNumberPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValueLoadAmountPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueLoadAmountPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FrozenFromActivationInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FrozenFromActivationInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FreqLimitForAddressChange' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FreqLimitForAddressChange] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxNumberOfAddressChanges' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxNumberOfAddressChanges] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ApplNotConsideredForAddressVelocity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ApplNotConsideredForAddressVelocity] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClearNegativeBalances' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClearNegativeBalances] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'LiabilityOnNegativeBalances' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LiabilityOnNegativeBalances] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxNegativeBalanceAutoCleared' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxNegativeBalanceAutoCleared] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AccountStatusNotAutoCleared' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountStatusNotAutoCleared] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MaxNegativeBalanceManuallyCleared' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxNegativeBalanceManuallyCleared] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClearNegativeBalancesAfterEventInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClearNegativeBalancesAfterEventInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DisputeResolutionServiceFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisputeResolutionServiceFlag] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DisputeProcessGuideLine' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisputeProcessGuideLine] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TempCreditToApplyInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TempCreditToApplyInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TempCreditDisputeToApplyInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TempCreditDisputeToApplyInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DisputeLettersMailed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisputeLettersMailed] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SettleServiceAndMoneyMove' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SettleServiceAndMoneyMove] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CustomerServicePhoneNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustomerServicePhoneNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MinAutoChargeBackReviewInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MinAutoChargeBackReviewInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AccountWithPositiveBalance' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountWithPositiveBalance] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'Statements' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Statements] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'OnlineStatements' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OnlineStatements] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PaperStatements' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaperStatements] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PrintBydefaultOrCHOption' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintBydefaultOrCHOption] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StatementCycle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatementCycle] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TransactionActivity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionActivity] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BalanceGreaterThan' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BalanceGreaterThan] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BalanceLessThan' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BalanceLessThan] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AccountStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountStatus] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StatementPaper' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatementPaper] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StatementTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatementTemplate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StatementFileFormat' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatementFileFormat] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DirectAccessConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DirectAccessConfig] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DDASponsorBank' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DDASponsorBank] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RoutingTransitNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RoutingTransitNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BankPrefix' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BankPrefix] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'Withdrawal' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Withdrawal] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValueLoadDirectDepositLimitCheck' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueLoadDirectDepositLimitCheck] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CardStatusUpdate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardStatusUpdate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'CardStatusToPFraud' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardStatusToPFraud] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FAXNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAXNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'NameMatchForIRSTaxRefunds' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NameMatchForIRSTaxRefunds] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ACHTrialDepositVerificationConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ACHTrialDepositVerificationConfig] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'UserInputAttemptsPermitted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserInputAttemptsPermitted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValidationInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValidationInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ACHAccountDisplay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ACHAccountDisplay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ValueLoadWaitPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueLoadWaitPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'NumberOfExternalBankAccounts' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NumberOfExternalBankAccounts] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ClientACHAccountDisplay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientACHAccountDisplay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EffectiveEntryDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EffectiveEntryDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'Active' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Active] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnCVV2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnCVV2] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReturnExpirationDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReturnExpirationDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'InstantConfigured' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InstantConfigured] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StandardConfigured' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StandardConfigured] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StandardWaitPeriodInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StandardWaitPeriodInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PPDBNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PPDBNumber] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AccountToAccountTransferConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountToAccountTransferConfig] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMaxNumberOfRecipients' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMaxNumberOfRecipients] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderLengthOfPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderLengthOfPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMaxTransfersPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMaxTransfersPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMaxTransferAmountPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMaxTransferAmountPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderTransfersInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderTransfersInDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMaxTransferAmountPerDay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMaxTransferAmountPerDay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMaxAmountPerTransaction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMaxAmountPerTransaction] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderMinAmountPerTransaction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderMinAmountPerTransaction] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderAllowFeeReversal' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderAllowFeeReversal] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderQualifiedStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderQualifiedStatus] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderDestinationClients' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderDestinationClients] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SearchReceiverCriteria' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SearchReceiverCriteria] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TieBreakerRules' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TieBreakerRules] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverLengthOfPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverLengthOfPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMaxNumberOfTransfersPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMaxNumberOfTransfersPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMaxTransferAmountPerPeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMaxTransferAmountPerPeriod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMaxNumberOfTransfersPerDay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMaxNumberOfTransfersPerDay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMaxTransferAmountPerDay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMaxTransferAmountPerDay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMaxAmountPerTransaction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMaxAmountPerTransaction] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverMinAmountPerTransaction' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverMinAmountPerTransaction] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverQualifiedStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverQualifiedStatus] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverDestinationClients' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverDestinationClients] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BlockGamblingMerchantsMCC7995' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BlockGamblingMerchantsMCC7995] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'BlockCashAndQuasiCash' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BlockCashAndQuasiCash] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'OtherMCCsRestricted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OtherMCCsRestricted] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AdditionalProxyLength' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AdditionalProxyLength] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IVRSecondaryAuthMethod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IVRSecondaryAuthMethod] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'AutoRenewalOnValueLoad' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AutoRenewalOnValueLoad] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SetupRegionalNetworkMoneyTransfer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SetupRegionalNetworkMoneyTransfer] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DisputeFormTempCredit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisputeFormTempCredit] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'TokenizationAllowed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TokenizationAllowed] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IsACHFastPayEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsACHFastPayEnabled] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'SenderReversalDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SenderReversalDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverAllowFeeReversal' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverAllowFeeReversal] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'ReceiverReversalDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverReversalDays] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IVROrMyAccountPINOptions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IVROrMyAccountPINOptions] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RestrictAdjust' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RestrictAdjust] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FulfillmentRequestType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FulfillmentRequestType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StatementMessageContents' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatementMessageContents] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'StartDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StartDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'EndDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'DefaultPurseForDirectAccess' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DefaultPurseForDirectAccess] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'Copay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Copay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MCCGroupCopay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCGroupCopay] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FutureUse2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FutureUse2] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FutureUse3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FutureUse3] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PBM' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBM] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'MCCGroupPayAndChase' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCGroupPayAndChase] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'NetworkName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NetworkName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'PurseStatusAutoRenewal' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseStatusAutoRenewal] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'RandomPINCardGeneration' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RandomPINCardGeneration] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DSPG' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DSPG]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'ClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'ClientIDName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientIDName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'SourceName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'Username' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Username] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'SecurityLevelName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SecurityLevelName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'Active' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Active] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_DUSR' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_DUSR]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'ProcessorName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessorName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'ReportDataFeedName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReportDataFeedName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'FileDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'WorkOfDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WorkOfDate] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'ClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'BankID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BankID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Header' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Header]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'StgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StgID] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'RecordType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordType] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'RecordCount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RecordCount] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCX_Trailer' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCX_Trailer]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F1] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F2] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F3] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F4' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F4] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F5' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F5] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F6' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F6] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F7' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F7] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F8' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F8] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F9' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F9] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F10' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F10] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F11' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F11] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F12' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F12] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F13' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F13] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F14' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F14] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F15' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F15] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F16' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F16] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F17' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F17] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F18' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F18] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F19' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F19] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F20' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F20] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F21' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F21] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F22' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F22] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F23' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F23] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F24' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F24] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F25' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F25] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F26' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F26] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F27' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F27] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F28' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F28] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F29' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F29] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F30' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F30] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F31' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F31] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F32' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F32] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F33' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F33] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F34' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F34] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F35' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F35] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F36' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F36] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F37' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F37] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F38' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F38] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F39' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F39] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F40' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F40] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F41' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F41] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F42' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F42] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F43' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F43] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F44' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F44] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F45' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F45] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F46' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F46] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F47' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F47] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F48' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F48] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F49' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F49] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F50' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F50] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F51' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F51] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F52' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F52] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F53' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F53] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F54' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F54] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F55' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F55] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F56' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F56] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F57' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F57] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F58' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F58] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F59' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F59] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F60' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F60] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F61' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F61] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F62' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F62] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F63' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F63] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F64' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F64] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F65' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F65] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F66' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F66] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F67' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F67] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F68' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F68] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F69' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F69] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F70' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F70] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F71' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F71] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F72' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F72] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F73' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F73] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F74' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F74] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F75' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F75] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F76' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F76] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F77' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F77] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F78' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F78] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F79' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F79] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F80' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F80] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F81' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F81] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F82' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F82] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F83' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F83] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F84' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F84] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F85' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F85] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F86' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F86] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F87' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F87] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F88' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F88] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F89' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F89] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F90' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F90] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F91' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F91] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F92' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F92] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F93' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F93] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F94' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F94] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F95' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F95] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F96' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F96] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F97' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F97] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F98' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F98] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F99' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F99] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F100' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F100] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F101' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F101] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F102' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F102] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F103' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F103] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F104' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F104] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F105' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F105] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F106' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F106] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F107' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F107] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F108' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F108] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F109' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F109] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F110' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F110] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F111' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F111] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F112' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F112] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F113' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F113] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F114' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F114] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F115' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F115] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F116' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F116] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F117' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F117] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F118' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F118] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F119' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F119] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F120' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F120] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F121' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F121] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F122' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F122] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F123' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F123] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F124' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F124] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F125' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F125] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F126' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F126] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F127' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F127] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F128' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F128] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F129' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F129] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F130' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F130] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F131' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F131] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F132' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F132] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F133' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F133] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F134' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F134] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F135' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F135] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F136' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F136] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F137' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F137] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F138' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F138] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F139' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F139] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F140' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F140] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F141' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F141] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F142' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F142] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F143' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F143] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F144' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F144] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F145' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F145] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F146' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F146] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F147' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F147] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F148' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F148] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F149' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F149] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F150' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F150] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F151' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F151] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F152' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F152] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F153' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F153] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F154' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F154] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F155' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F155] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F156' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F156] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F157' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F157] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F158' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F158] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F159' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F159] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F160' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F160] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F161' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F161] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F162' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F162] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F163' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F163] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F164' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F164] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F165' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F165] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F166' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F166] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F167' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F167] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F168' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F168] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F169' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F169] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F170' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F170] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F171' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F171] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F172' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F172] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F173' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F173] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F174' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F174] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F175' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F175] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F176' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F176] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F177' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F177] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F178' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F178] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F179' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F179] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F180' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F180] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F181' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F181] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F182' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F182] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F183' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F183] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F184' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F184] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F185' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F185] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F186' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F186] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F187' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F187] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F188' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F188] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F189' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F189] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F190' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F190] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F191' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F191] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F192' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F192] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F193' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F193] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F194' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F194] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F195' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F195] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F196' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F196] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F197' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F197] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F198' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F198] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F199' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F199] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F200' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F200] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F201' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F201] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F202' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F202] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F203' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F203] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F204' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F204] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F205' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F205] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F206' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F206] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F207' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F207] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F208' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F208] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F209' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F209] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F210' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F210] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F211' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F211] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F212' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F212] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F213' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F213] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F214' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F214] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F215' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F215] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F216' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F216] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F217' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F217] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F218' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F218] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F219' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F219] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F220' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F220] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F221' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F221] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F222' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F222] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F223' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F223] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F224' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F224] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F225' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F225] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F226' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F226] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F227' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F227] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F228' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F228] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F229' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F229] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F230' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F230] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F231' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F231] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F232' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F232] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F233' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F233] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F234' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F234] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F235' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F235] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F236' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F236] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F237' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F237] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F238' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F238] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F239' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F239] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F240' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F240] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F241' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F241] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F242' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F242] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F243' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F243] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F244' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F244] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F245' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F245] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F246' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F246] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F247' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F247] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F248' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F248] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F249' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F249] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'F250' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([F250] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'FileName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FileName] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'FISCCXStg' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[FISCCXStg]) a 
) b
order by b.table_name, b.column_name