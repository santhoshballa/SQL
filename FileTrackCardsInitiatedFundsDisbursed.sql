

drop table if exists #FileTrack_CI
select * into #FileTrack_CI from (
select
'[otcfunds].[FileTrack][OUT]' as TableNameFileTrack_OUT,a.[FileTrackID] as FileTrackID_OUT,a.[FileInfoID] as FileInfoID_OUT,a.[ClientCode] as ClientCode_OUT,a.[DirectionCode] as DirectionCode_OUT,a.[FileName] as FileName_OUT,a.[FileFormat] as FileFormat_OUT,a.[FileType] as FileType_OUT,a.[DataSource] as DataSource_OUT,a.[DateReceived] as DateReceived_OUT,a.[DateProcessed] as DateProcessed_OUT,a.[TotalRecords] as TotalRecords_OUT,a.[RecordsProcessed] as RecordsProcessed_OUT,a.[RecordsErrored] as RecordsErrored_OUT,a.[LoadStartTime] as LoadStartTime_OUT,a.[LoadEndTime] as LoadEndTime_OUT,a.[StatusCode] as StatusCode_OUT,a.[CreateDate] as CreateDate_OUT,a.[CreateUser] as CreateUser_OUT,a.[ModifyDate] as ModifyDate_OUT,a.[ModifyUser] as ModifyUser_OUT,a.[RefFileTrackID] as RefFileTrackID_OUT,a.[SnapshotFlag] as SnapshotFlag_OUT, 
'[otcfunds].[FileTrack][IN]'  as TableNameFileTrack_IN, b.[FileTrackID] as FileTrackID_IN,b.[FileInfoID] as FileInfoID_IN,b.[ClientCode] as ClientCode_IN,b.[DirectionCode] as DirectionCode_IN,b.[FileName] as FileName_IN,b.[FileFormat] as FileFormat_IN,b.[FileType] as FileType_IN,b.[DataSource] as DataSource_IN,b.[DateReceived] as DateReceived_IN,b.[DateProcessed] as DateProcessed_IN,b.[TotalRecords] as TotalRecords_IN,b.[RecordsProcessed] as RecordsProcessed_IN,b.[RecordsErrored] as RecordsErrored_IN,b.[LoadStartTime] as LoadStartTime_IN,b.[LoadEndTime] as LoadEndTime_IN,b.[StatusCode] as StatusCode_IN,b.[CreateDate] as CreateDate_IN,b.[CreateUser] as CreateUser_IN,b.[ModifyDate] as ModifyDate_IN,b.[ModifyUser] as ModifyUser_IN,b.[RefFileTrackID] as RefFileTrackID_IN,b.[SnapshotFlag] as SnapshotFlag_IN,

--(b.DateReceived - a.CreateDate) as DifferenceDate
DATEDIFF(DAY, a.CreateDate,b.DateReceived ) as DifferenceInDays
from [otcfunds].[FileTrack] a  with (nolock) left Join [otcfunds].[FileTrack] (nolock) b on a.RefFileTrackID = b.FileTrackID  where a.ClientCode is not null and a.[SnapshotFlag]= 'CI'
) a

--select * from #FileTrack_CI where FileTrackID_OUT = 9619


drop table if exists #FileTrack_FD
select * into #FileTrack_FD from (
select
'[otcfunds].[FileTrack][OUT]' as TableNameFileTrack_OUT,a.[FileTrackID] as FileTrackID_OUT,a.[FileInfoID] as FileInfoID_OUT,a.[ClientCode] as ClientCode_OUT,a.[DirectionCode] as DirectionCode_OUT,a.[FileName] as FileName_OUT,a.[FileFormat] as FileFormat_OUT,a.[FileType] as FileType_OUT,a.[DataSource] as DataSource_OUT,a.[DateReceived] as DateReceived_OUT,a.[DateProcessed] as DateProcessed_OUT,a.[TotalRecords] as TotalRecords_OUT,a.[RecordsProcessed] as RecordsProcessed_OUT,a.[RecordsErrored] as RecordsErrored_OUT,a.[LoadStartTime] as LoadStartTime_OUT,a.[LoadEndTime] as LoadEndTime_OUT,a.[StatusCode] as StatusCode_OUT,a.[CreateDate] as CreateDate_OUT,a.[CreateUser] as CreateUser_OUT,a.[ModifyDate] as ModifyDate_OUT,a.[ModifyUser] as ModifyUser_OUT,a.[RefFileTrackID] as RefFileTrackID_OUT,a.[SnapshotFlag] as SnapshotFlag_OUT, 
'[otcfunds].[FileTrack][IN]'  as TableNameFileTrack_IN, b.[FileTrackID] as FileTrackID_IN,b.[FileInfoID] as FileInfoID_IN,b.[ClientCode] as ClientCode_IN,b.[DirectionCode] as DirectionCode_IN,b.[FileName] as FileName_IN,b.[FileFormat] as FileFormat_IN,b.[FileType] as FileType_IN,b.[DataSource] as DataSource_IN,b.[DateReceived] as DateReceived_IN,b.[DateProcessed] as DateProcessed_IN,b.[TotalRecords] as TotalRecords_IN,b.[RecordsProcessed] as RecordsProcessed_IN,b.[RecordsErrored] as RecordsErrored_IN,b.[LoadStartTime] as LoadStartTime_IN,b.[LoadEndTime] as LoadEndTime_IN,b.[StatusCode] as StatusCode_IN,b.[CreateDate] as CreateDate_IN,b.[CreateUser] as CreateUser_IN,b.[ModifyDate] as ModifyDate_IN,b.[ModifyUser] as ModifyUser_IN,b.[RefFileTrackID] as RefFileTrackID_IN,b.[SnapshotFlag] as SnapshotFlag_IN,

--(b.DateReceived - a.CreateDate) as DifferenceDate
DATEDIFF(DAY, a.CreateDate,b.DateReceived ) as DifferenceInDays
from [otcfunds].[FileTrack]  a with (nolock) left Join [otcfunds].[FileTrack] (nolock) b on a.RefFileTrackID = b.FileTrackID  where a.ClientCode is not null and a.[SnapshotFlag]= 'FD'
) a


drop table if exists #CardBenefitLoad_CI
select * into #CardBenefitLoad_CI from (
select  '[otcfunds].[CardBenefitLoad_CI]' as TableName_otcfunds_CardBenefitLoad_CI,[CardBenefitLoadID],[MemberDataID],[ClientCode],[NHLinkID],[RecordType],[MemberDataSource],[InsCarrierID],[InsHealthPlanID],[BenefitCardNumber],[LastName],[MiddleInitial],[FirstName],[DOB],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[MailingCountry],[HomePhoneNbr],[BenefitType],[BenefitSource],[NBWalletCode],[BenefitAmount],[BenefitValidFrom],[BenefitValidTo],[BenefitFreqInMonth],[BenefitYear],[BenefitPeriod],[IsActive],[RequestRecordStatus],[RequestToBeProcessed],[RequestProcessedFileID],[RequestProcessedDate],[ResponseRecordStatus],[ResponseRecordStatusCode],[ResponseProcessedFileID],[ResponseProcessedDate],[FirstTimeCardIssued],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],[RefCardBenefitLoadID],[ErrorProcessed],[Language],[DiscretionaryData1],[FourthLine],[CarrierMessage],[ClientID],[ProgramID],[SubProgramID],[PackageID],[FileGenInd],[Level1ClientID],[BenefitCardMappingID],
ROW_NUMBER () OVER (PARTITION BY [ClientCode], isnull([NHLinkID], MemberDataID) ORDER BY [ClientCode], isnull([NHLinkID], MemberDataID), [CreateDate] asc) as rn
from [otcfunds].[CardBenefitLoad_CI] with (nolock)
where 1=1 
----nhlinkID is not null or 
--NHLinkID = '101546780100'
) a
--where a.rn > 1


drop table if exists #CardBenefitLoad_FD
select * into #CardBenefitLoad_FD from (
select  '[otcfunds].[CardBenefitLoad_FD]' as TableName_otcfunds_CardBenefitLoad_FD,[CardBenefitLoadID],[MemberDataID],[ClientCode],[NHLinkID],[RecordType],[MemberDataSource],[InsCarrierID],[InsHealthPlanID],[BenefitCardNumber],[LastName],[MiddleInitial],[FirstName],[DOB],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[MailingCountry],[HomePhoneNbr],[BenefitType],[BenefitSource],[NBWalletCode],[BenefitAmount],[BenefitValidFrom],[BenefitValidTo],[BenefitFreqInMonth],[BenefitYear],[BenefitPeriod],[IsActive],[RequestRecordStatus],[RequestToBeProcessed],[RequestProcessedFileID],[RequestProcessedDate],[ResponseRecordStatus],[ResponseRecordStatusCode],[ResponseProcessedFileID],[ResponseProcessedDate],[FirstTimeCardIssued],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],[RefCardBenefitLoadID],[ErrorProcessed],[Language],[MemberDataSourceFile],[Level1ClientID],[ClientID],[SubProgramID],[PackageID],
--[FIS_PurseSlot],
ROW_NUMBER () OVER (PARTITION BY [ClientCode], isnull([NHLinkID], MemberDataID) ORDER BY [ClientCode], isnull([NHLinkID], MemberDataID), [CreateDate] asc) as rn
from [otcfunds].[CardBenefitLoad_FD] with (nolock)
where 1=1 
----nhlinkID is not null or 
--NHLinkID = '101546780100'
) a

--select * from [otcfunds].[CardBenefitLoad_CI]  where NHLinkID is null

drop table if exists #FileTrackCardBenefitLoad_CI
select * into #FileTrackCardBenefitLoad_CI from (
select  a.*, b.*
from #CardBenefitLoad_CI a join #FileTrack_CI b on a.RequestProcessedFileID = FileTrackID_OUT or a.ResponseProcessedFileID = FileTrackID_IN
where RN > 0
/*
NHLinkID in ('101551793600','101546780100') -- have 4 records each
NHLINKID = '000114219'
order by rn desc, a.NHLinkID, CreateDate asc
*/
) a

drop table if exists #FileTrackCardBenefitLoad_FD
select * into #FileTrackCardBenefitLoad_FD from (
select  a.*, b.*
from #CardBenefitLoad_FD a join #FileTrack_FD b on a.RequestProcessedFileID = FileTrackID_OUT or a.ResponseProcessedFileID = FileTrackID_IN
where RN > 0
/*
NHLinkID in ('101551793600','101546780100') -- have 4 records each
NHLINKID = '000114219'
order by rn desc, a.NHLinkID, CreateDate asc
*/
) a

/*
select * from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
and NHLinkID = '00000103561'

select * from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
and NHLinkID = '00000103561'
*/

/*
select SnapshotFlag_OUT,a.ClientCode,
ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
NHLinkID, 
insCarrierID,
InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers b where b.InsuranceCarrierID = a.InsCarrierID), 
InsHealthPlanID, 
InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans b where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN,RequestRecordStatus, ResponseRecordStatus, ResponseRecordStatusCode, rn as NoOfTimesSent,
CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse

from #FileTrackCardBenefitLoad_CI a
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'SUCCESS') 
--and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_OUT, ClientCode, 
ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
NHLinkID, 
insCarrierID,
InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers (nolock) b where b.InsuranceCarrierID = a.InsCarrierID), 
InsHealthPlanID, 
InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans (nolock) b where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN, RequestRecordStatus, ResponseRecordStatus,ResponseRecordStatusCode, rn as NoOfTimesSent,
CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse,
BenefitType, BenefitSource, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, BenefitFreqInMonth, BenefitYear, IsActive as IsActive_Benefit
from #FileTrackCardBenefitLoad_FD a
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'SUCCESS')
--and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent

*/


drop table if exists #CardInitiated
select * into #CardInitiated from (
select SnapshotFlag_OUT,a.ClientCode,
ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
NHLinkID, 
insCarrierID,
InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers b with (nolock)where b.InsuranceCarrierID = a.InsCarrierID), 
InsHealthPlanID, 
InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans b with (nolock)  where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN,RequestRecordStatus, ResponseRecordStatus, ResponseRecordStatusCode, rn as NoOfTimesSent,
CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse

from #FileTrackCardBenefitLoad_CI a
where 1 = 1 
--and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'SUCCESS') 
--and NHLinkID = '00000103561'
--order by NHLInkID, NoOfTimesSent
) a

select distinct insCarrierID, insHealthPlanID from #FileTrackCardBenefitLoad_CI order by InsCarrierID, InsHealthPlanID

drop table if exists #FundsDisbursement
select * into #FundsDisbursement from (
select SnapshotFlag_OUT, ClientCode, 
ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
NHLinkID, 
insCarrierID,
InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers b with (nolock)  where b.InsuranceCarrierID = a.InsCarrierID), 
InsHealthPlanID, 
InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans b with (nolock)  where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN, RequestRecordStatus, ResponseRecordStatus,ResponseRecordStatusCode, rn as NoOfTimesSent,
CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse,
BenefitType, BenefitSource, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, BenefitFreqInMonth, BenefitYear, IsActive as IsActive_Benefit
from #FileTrackCardBenefitLoad_FD a
where 1 = 1 
--and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'SUCCESS')
--and NHLinkID = '00000103561'
--order by NHLInkID, NoOfTimesSent
) a

--select * from insurance.InsuranceCarriers

--select top 10 * from  #CardInitiated

select 'CardInitiated' as Query, insCarrierID, InsCarrierName, InsHealthPlanID, InsHealthPlanName, cast(CIRecordCreateDate as Date) CreateDate, count(*) as RC 
from #CardInitiated 
where insCarrierID = 417 --and InsHealthPlanID =6882
group by insCarrierID, InsCarrierName, InsHealthPlanID, InsHealthPlanName, cast(CIRecordCreateDate as Date) 
order by 1,3,5 desc


select 'FundsDisbursement' as Query, insCarrierID, InsCarrierName, InsHealthPlanID, InsHealthPlanName, cast(CIRecordCreateDate as Date) as CreateDate, count(*) as RC 
from #FundsDisbursement
where insCarrierID = 417 --and InsHealthPlanID =6882
group by insCarrierID, InsCarrierName, InsHealthPlanID, InsHealthPlanName, cast(CIRecordCreateDate as Date)
order by 1,3,5 desc

/*
select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')
select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')

*/

/*
select 'CardInitiated' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #CardInitiated 
where cast(CIRecordCreateDate as Date) >= '12-30-2022'
group by InsCarrierName, cast(CIRecordCreateDate as Date)
order by 2 desc

select 'FundsDisbursement' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #FundsDisbursement
where cast(CIRecordCreateDate as Date) >= '12-30-2022'
group by InsCarrierName, cast(CIRecordCreateDate as Date)
order by 3 desc
*/

/*

select 'CardInitiated' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #CardInitiated 
where cast(CIRecordCreateDate as Date) >= '12-01-2022' 
group by InsCarrierName, cast(CIRecordCreateDate as Date)
Union All
select 'FundsDisbursement' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #FundsDisbursement
where cast(CIRecordCreateDate as Date) >= '12-01-2022'
group by InsCarrierName, cast(CIRecordCreateDate as Date)
order by 4 desc,1,InsCarrierName, 3 desc

*/
/*
select top 10 * from #CardInitiated
select NHLinkID, count(*) as RC from #FundsDisbursement group by NHLinkID having count(*) > 20
*/
/*
NHLinkID	RC
00000180460	29
00000157559	27
00000129925	28
801180399	21
00000191433	25
00000189394	27
*/


select 'CardInitiated' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #CardInitiated 
where cast(CIRecordCreateDate as Date) >= '01-01-2020' --and  NHLinkID  = '810W10039'
group by InsCarrierName, cast(CIRecordCreateDate as Date)
Union All
select 'FundsDisbursement' as Query, InsCarrierName, cast(CIRecordCreateDate as Date) as CreateDate, Count(*) as RecordCount from #FundsDisbursement
where cast(CIRecordCreateDate as Date) >= '12-01-2022'-- and   NHLinkID  = '810W10039'
group by InsCarrierName, cast(CIRecordCreateDate as Date)
order by 4 desc,1,InsCarrierName, 3 desc

--select NHLinkID from master.members where NHMemberID = 'EH202213813694'


select * from #CardInitiated where cast(CIRecordCreateDate as Date) >= '01-01-2000' and   NHLinkID  in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')
select * from #FundsDisbursement where cast(CIRecordCreateDate as Date) >= '01-01-2000' and   NHLinkID  in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')


select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202213813694')
select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202213813694')

select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202213646764')
select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202213646764')

select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_CI where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')
select IsActive, RequestProcessedFileID, RequestProcessedDate, RequestRecordStatus, ResponseProcessedFileID, ResponseProcessedDate, ResponseRecordStatus,* from otcfunds.CardBenefitLoad_FD where NHLinkID in (select NHLInkID from master.members where NHMemberID = 'EH202214323932')



/*
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_OUT, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent


select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_OUT, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent



-- zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN,RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (ResponseRecordStatus is NULL or ResponseRecordStatus = '') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (ResponseRecordStatus is NULL or ResponseRecordStatus = '') 
order by NHLInkID, NoOfTimesSent


--zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = '' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus ='' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent


-- Zero Records 
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (isnull(RequestRecordStatus,'') = '' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (isnull(RequestRecordStatus,'') = '' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

-- Zero Records 
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus is NULL and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus is NULL and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

--should get zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

-- should get zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'SUCCESS') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'SUCCESS')
order by NHLInkID, NoOfTimesSent
*/