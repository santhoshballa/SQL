select top 10 * from elig.clientcodes where ClientCode = 'H448'
select * from elig.FileInfo where direction = 'IN' and FileName like '%vba%'
select top 10 * from elig.rawEligBenefitData where FileInfoId in ( '323', '297')
select * from elig.FileTrack where FileInfoID in ( '323', '297') order by DateReceived desc
select top 10 * from elig.stgEligBenefitData where FileTrackID in (select FileTrackID from elig.FileTrack where FileInfoID in ( '323', '297') )
select top 10 * from elig.stgEligBenefitDataHist where FileTrackID in (select FileTrackID from elig.FileTrack where FileInfoID in ( '323', '297') )