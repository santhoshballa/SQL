select a.schema_id, b.name as SchemaName, a.name as TableName, a.type_desc, c.name as ColumnName, a.create_date
from sys.tables a 
join sys.schemas b on a.schema_id = b.schema_id
join sys.all_columns c on a.object_id = c.object_id
where b.name = 'nb'
order by a.create_date desc


select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('nb')
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('nb')

select * from information_schema.columns where table_schema = 'nb'


select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ 'as TableName' +','+ 'count(*) as RecordCount from ' + table_schema + '.' + table_name + ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('nb') 

select * from (
select 'nb.Carrier'as TableName,count(*) as RecordCount from nb.Carrier Union 
select 'nb.FudgeMCCs'as TableName,count(*) as RecordCount from nb.FudgeMCCs Union 
select 'nb.HighRiskMCCs'as TableName,count(*) as RecordCount from nb.HighRiskMCCs Union 
select 'nb.Mcc'as TableName,count(*) as RecordCount from nb.Mcc Union 
select 'nb.MccGroup'as TableName,count(*) as RecordCount from nb.MccGroup Union 
select 'nb.Package'as TableName,count(*) as RecordCount from nb.Package Union 
select 'nb.Plan'as TableName,count(*) as RecordCount from nb.[Plan] Union 
select 'nb.PlanStatus'as TableName,count(*) as RecordCount from nb.PlanStatus Union 
select 'nb.Purse'as TableName,count(*) as RecordCount from nb.Purse Union 
select 'nb.PurseBenefit'as TableName,count(*) as RecordCount from nb.PurseBenefit Union 
select 'nb.PurseCashRule'as TableName,count(*) as RecordCount from nb.PurseCashRule Union 
select 'nb.RemotePlan'as TableName,count(*) as RecordCount from nb.RemotePlan Union 
select 'nb.SubprogramAPLLink'as TableName,count(*) as RecordCount from nb.SubprogramAPLLink Union 
select 'nb.SubprogramPackageLink'as TableName,count(*) as RecordCount from nb.SubprogramPackageLink
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

select * from information_schema.columns where table_schema = 'nb'

select distinct
'select top 100 ' +''''+table_schema + '.' +table_name +''''+ ' as TableName,* from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'nb'

select top 100 'nb.Carrier' as TableName,* from nb.Carrier
select top 100 'nb.FudgeMCCs' as TableName,* from nb.FudgeMCCs
select top 100 'nb.HighRiskMCCs' as TableName,* from nb.HighRiskMCCs
select top 100 'nb.Mcc' as TableName,* from nb.Mcc
select top 100 'nb.MccGroup' as TableName,* from nb.MccGroup
select top 100 'nb.Package' as TableName,* from nb.Package
select top 100 'nb.Plan' as TableName,* from nb.[Plan]
select top 100 'nb.PlanStatus' as TableName,* from nb.PlanStatus
select top 100 'nb.Purse' as TableName,* from nb.Purse
select top 100 'nb.PurseBenefit' as TableName,* from nb.PurseBenefit
select top 100 'nb.PurseCashRule' as TableName,* from nb.PurseCashRule
select top 100 'nb.RemotePlan' as TableName,* from nb.RemotePlan
select top 100 'nb.SubprogramAPLLink' as TableName,* from nb.SubprogramAPLLink
select top 100 'nb.SubprogramPackageLink' as TableName,* from nb.SubprogramPackageLink

select distinct
'select * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'nb'

select * from nb.Carrier
select * from nb.FudgeMCCs
select * from nb.HighRiskMCCs
select * from nb.Mcc
select * from nb.MccGroup
select * from nb.Package
select * from nb.[Plan]
select * from nb.PlanStatus
select * from nb.Purse
select * from nb.PurseBenefit
select * from nb.PurseCashRule
select * from nb.RemotePlan
select * from nb.SubprogramAPLLink
select * from nb.SubprogramPackageLink

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
TABLE_SCHEMA in ('nb') 
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
-- and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select * from (

select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'CarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierId] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'CarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierName] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'RemoteCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemoteCarrierId] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Carrier' as TABLE_NAME,'FisCarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FisCarrierName] as nvarchar))),'"') as VALUE from nb.[Carrier]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'FudgeMCCsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeMCCsId] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'FudgeMCC' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeMCC] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'FudgeLimit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeLimit] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'FudgeType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeType] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'FudgeSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FudgeSource] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'FudgeMCCs' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[FudgeMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'HighRiskMCCsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HighRiskMCCsId] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'HighRiskMCC' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HighRiskMCC] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'HighRiskMCCs' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[HighRiskMCCs]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Mcc' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from nb.[Mcc]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Mcc' as TABLE_NAME,'GroupId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupId] as nvarchar))),'"') as VALUE from nb.[Mcc]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Mcc' as TABLE_NAME,'MccId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MccId] as nvarchar))),'"') as VALUE from nb.[Mcc]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Mcc' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from nb.[Mcc]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Mcc' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[Mcc]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'MccGroup' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from nb.[MccGroup]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'MccGroup' as TABLE_NAME,'GroupId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupId] as nvarchar))),'"') as VALUE from nb.[MccGroup]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'MccGroup' as TABLE_NAME,'GroupName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupName] as nvarchar))),'"') as VALUE from nb.[MccGroup]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'CarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierId] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'GroupId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupId] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'PlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanName] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'PhysicalExpireMonths' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PhysicalExpireMonths] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'StaticFourth' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StaticFourth] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'IIASMCCGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASMCCGroup] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'PBMInsteadOfIIAS' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBMInsteadOfIIAS] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'IIASExceptionGrp' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASExceptionGrp] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'IIASMissingData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASMissingData] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'StatusId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusId] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'NBPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NBPlanId] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Plan' as TABLE_NAME,'DeclineReason' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DeclineReason] as nvarchar))),'"') as VALUE from nb.[Plan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PlanStatus' as TABLE_NAME,'StatusId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StatusId] as nvarchar))),'"') as VALUE from nb.[PlanStatus]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PlanStatus' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from nb.[PlanStatus]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PlanStatus' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[PlanStatus]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseId] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseName] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseSlot' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseSlot] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PursePeriod' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PursePeriod] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseType] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'Rollover' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Rollover] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'EffectiveDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EffectiveDate] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'ExpDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExpDate] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'NetworkName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NetworkName] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'MCCGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCGroup] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PursePriorityList' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PursePriorityList] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'IIASGroup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IIASGroup] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'MaxValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxValue] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'MaxLoad' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxLoad] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseBenefitId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseBenefitId] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Purse' as TABLE_NAME,'PurseOrder' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseOrder] as nvarchar))),'"') as VALUE from nb.[Purse]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'BenefitId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitId] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'BenefitNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitNumber] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'BenefitDesc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitDesc] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'PurseCashRuleId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseCashRuleId] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'PurseId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PurseId] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'CashType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CashType] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'CycleSpendMaxAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CycleSpendMaxAmount] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'CycleSpendMaxCount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CycleSpendMaxCount] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'TxnSpendMinAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnSpendMinAmount] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'TxnSpendMaxAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TxnSpendMaxAmount] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseCashRule' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[PurseCashRule]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'PlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanName] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'FullName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FullName] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'RemotePlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemotePlanId] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'CarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierId] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'RemotePlan' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[RemotePlan]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'SubprogramAPLLinkId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubprogramAPLLinkId] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'APLName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([APLName] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramAPLLink' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[SubprogramAPLLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'SubprogramPackageLinkId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubprogramPackageLinkId] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanId] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'PackageName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageName] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'BIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BIN] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'PRIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PRIN] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'SubprogramPackageLink' as TABLE_NAME,'PackageId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageId] as nvarchar))),'"') as VALUE from nb.[SubprogramPackageLink]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'PackageId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PackageId] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'Plan' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Plan] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'PBPNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPNumber] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'NBPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NBPlanID] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'NBPackageId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NBPackageId] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'Language' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Language] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'BIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BIN] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'PRIN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PRIN] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'AgentNum' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AgentNum] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'APLName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([APLName] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'CreatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedDate] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'CreatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreatedBy] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'UpdatedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedDate] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'UpdatedBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UpdatedBy] as nvarchar))),'"') as VALUE from nb.[Package]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'Package' as TABLE_NAME,'IsDeprecated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDeprecated] as nvarchar))),'"') as VALUE from nb.[Package]) a 
) b
order by b.table_name, b.column_name