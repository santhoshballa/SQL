

drop table if exists #NHMemberID
create table #NHMemberID
(
NHMemberID varchar(20),
ProxyID varchar(20)
)

insert into #NHMemberID (NHMemberID, ProxyID) values ('NH202106747558','7658473971353')

select 'logs.BenefitErrors' as logs_BenefitErrors_Tablename, CreateDate, NHMemberID, ProxyID, CarrierId, PlanID, ReqData, ResponseData,ReasonGroup, ReasonDetails, Source from logs.BenefitErrors with (nolock)
where NHMemberID in (select NHmemberID from  #NHMemberID) or ProxyID in (select ProxyID from #NHMemberID) and CreateDate > getdate() - 15
order by createDate desc

select 'logs.FISReqResponses' as logs_FISReqResponses_Tablename,Createdate, ReqObject, ResObject, Status, ErrorMessage, MethodName, Source from logs.FISReqResponses with (nolock)
where ReqObject like  concat('%',(select ProxyID from #NHMemberID),'%') and CreateDate > getdate() - 15
order by createDate desc

select 'logs.MSDReqResponses' as logs_MSDReqResponses_Tablename,Createdate, ReqObject, ResObject, Status, APIMethodName, Source from [logs].[MSDReqResponses] with (nolock)
where ReqObject like  concat('%',(select ProxyID from #NHMemberID),'%') and CreateDate > getdate() - 15
order by createDate desc

select '[logs].[MSDReqResponses]' as logs_MSDReqResponses_Tablename,CreateUser, ReqObject, ResObject, Status, APIMethodName, Source from [logs].[MSDReqResponses] with (nolock)
where ReqObject like  concat('%',(select ProxyID from #NHMemberID),'%') and CreateDate > getdate() - 15
order by createDate desc

select top 10 * from [logs].[WEXReqResponses]
select top 10 * from logs.BenefitErrors
select top 10 * from logs.FISReqResponses
select top 10 * from [logs].[MSDReqResponses]

Select 'FISReqResponses' as TableName, Count(*) as TableCount from [logs].[WEXReqResponses] Union
Select 'BenefitErrors' as TableName, Count(*) as TableCount from logs.BenefitErrors union
Select 'FISReqResponses' as TableName, Count(*) as TableCount from logs.FISReqResponses union
Select 'MSDReqResponses' as TableName, Count(*) as TableCount from [logs].[MSDReqResponses]

/*
TableName			TableCount
FISReqResponses		555516
BenefitErrors		1803634
MSDReqResponses		6213378
FISReqResponses		39426763
*/