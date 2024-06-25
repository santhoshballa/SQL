

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202002517664') --expected
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202005646527') --resulted


select * from information_schema.columns where table_schema ='provider'

select top 10 * from provider.MemberProfiles
select top 10 * from provider.MemberAppointments

--Check appointments----
select 'provider.MemberCharts' as TableName,* from [provider].[MemberCharts]
where memberprofileid in (
							select memberprofileid from [provider].[MemberProfiles]
							where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
						 )
order by MemberChartId


select 'provider.MemberCharts' as TableName, * from [provider].[MemberChartData]
where memberchartid in (select memberchartid from [provider].[MemberCharts]
						where memberprofileid in ( select memberprofileid from [provider].[MemberProfiles]
												   where NHMemberid in (select NHMemberID from #NHMemberIDTemp ))
												 )
order by MemberChartDataId


select 'provider.MemberAppointments' as TableName, * from [provider].[MemberAppointments] ma
where 1 = 1 and memberchartdataid in (select memberchartdataid from [provider].[MemberChartData]
									  where memberchartid in (select memberchartid from [provider].[MemberCharts]
															  where memberprofileid in (select memberprofileid from [provider].[MemberProfiles]
																						where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
																						)
															 )
									) 
order by 1 desc


select top 10 * from [provider].[MemberProfiles]
select NHMemberID, MemberProfileID, FirstName, LastName, InsurancecarriersID, InsuranceHealthPlansID, IsActive from [provider].[MemberProfiles]
select '[provider].[MemberProfiles]' as TableName, count(*) as RecordCount from [provider].[MemberProfiles]
select NHMemberID, count(*) as RecordCount from [provider].[MemberProfiles] group by NHMemberID having count(*) > 1  --NHMemberID is unique


select top 10 * from [provider].[MemberCharts]



select top 10 * from [provider].[MemberChartData]
select top 10 * from [provider].[MemberAppointments]


select 'provider.MemberAppointments_History' as TableName, *
from [provider].[MemberAppointments_History] ma
where 1 = 1
and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
))
 )order by 2 desc


select * from information_schema.columns where table_schema like '%document%'
select * from document.DocumentTransaction where MemberProfileID = 13083

select * from auth.UserProfiles where firstname like '%stacey%' and lastname like '%Blackerby%'