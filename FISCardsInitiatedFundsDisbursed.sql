
IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('EH202213813694') 
insert into #NHMemberIDTemp (NHMemberID) values ('EH202213646764') 
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214323932')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202213614832')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214417180')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202213337590')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214119524') 
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214546821')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214165131')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202213557606') 
insert into #NHMemberIDTemp (NHMemberID) values ('EH202213628474')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202314832372')
insert into #NHMemberIDTemp (NHMemberID) values ('EH202214144536') 

select '[otcfunds].[FileTrack][OUT]' as TableNameFileTrack_OUT from [otcfunds].[FileTrack] 
where FileTrackID in (select RequestProcessedFileID from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp ) ) )

select '[otcfunds].[FileTrack][IN]' as TableNameFileTrack_IN from [otcfunds].[FileTrack] 
where FileTrackID in (select ResponseProcessedFileID from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp ) ))

select 'otcfunds.CardBenefitLoad_CI' as TableName, IsActive, NHLinkID,
EHMemberID = (select top 1 NHMemberID from master.Members a where a.NHLinkID = b.NHLinkID )
,RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,
* from otcfunds.CardBenefitLoad_CI b where NHLinkID in (select NHLInkID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp ) )

select 'otcfunds.CardBenefitLoad_FD' as TableName, IsActive, 
EHMemberID = (select top 1 NHMemberID from master.Members a where a.NHLinkID = b.NHLinkID )
,RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD b where NHLinkID in (select NHLInkID from master.members where NHMemberID in (select NHMemberID from #NHMemberIDTemp ) )



-- InsuranceCarrierID and InsuranceHealthPlan
select 'otcfunds.CardBenefitLoad_CI' as TableName, IsActive, NHLinkID,
EHMemberID = (select top 1 NHMemberID from master.Members a where a.NHLinkID = b.NHLinkID )
,RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,
* from otcfunds.CardBenefitLoad_CI b 
where InsCarrierID = 277 -- and InsHealthPlanId in (2473,2509,2510,2511,2512,2513,2732,2733,2734,2735,2737,2738,6739,6740) and IsActive =1

-- InsuranceCarrierID and InsuranceHealthPlan
select 'otcfunds.CardBenefitLoad_FD' as TableName, IsActive, 
EHMemberID = (select top 1 NHMemberID from master.Members a where a.NHLinkID = b.NHLinkID )
,RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD b
where InsCarrierID = 277 --and InsHealthPlanId in (2473,2509,2510,2511,2512,2513,2732,2733,2734,2735,2737,2738,6739,6740) and IsActive =1

-- Checek Orders
select * from orders.orders where NHMemberID in ( select NHMemberID from #HealthFirstMembers) 
and CreateDate > '01-01-2023'
order by CreateDate desc, DateOrderReceived desc
select * from otcfunds.CardBenefitLoad_FD where InsCarrierID = 417
select * from otcfunds.FileTrack where FileTrackID in (9619,9674) or RefFileTrackID in (9619,9674)
select * from elig.FileTrack where FileTrackID in (9619,9674) -- or RefFileTrackID in (9619,9674)
select * from fisxtract.FileTrack where FileTrackID in (9619,9674) -- or RefFileTrackID in (9619,9674)
select * from mft.FileTrack where FileTrackID in (9619,9674) -- or RefFileTrackID in (9619,9674)

select * from information_schema.columns where table_name  = 'FIleTrack'