/*
We remove the member from QMB status by assigning the NHMemberID to a different default ID ( 'NH202002615437' | Raj)

select * from master.QMBMembers where NHMemberID = 'NH202209797804' order by CreateDate Desc
select id, insuranceNbr, NHMemberID, * from master.QMBMembers where NHMemberID in ('NH202209797804')
select * from master.QMBMembers where NHMemberID = 'NH202002615437' order by CreateDate Desc -- The ID belongs to Raj by default
*/



select * from master.QMBMembers where NHMemberID =  'NH202209572784'

declare @NHMemberID nvarchar(20) = 'NH202209572784' -- Enter the NHMemberID of the member whose QMB status has to be removed.
declare @Query nvarchar(2000) = ''
select @Query =
'update master.QMBMembers set InsuranceNbr = ' + '''' +  cast(InsuranceNbr as nvarchar) +'A'+ '''' + ',' + 'NHMemberID = ' + ''''+'NH202002615437'+''''+ ' where id in ( ' + cast(id as nvarchar) + ' )' + ' and NHMemberID = ' + ''''+ @NHMemberID + ''''
from master.QMBMembers where NHMemberID = @NHMemberID
select @Query

-- update master.QMBMembers set InsuranceNbr = '101511052700A',NHMemberID = 'NH202002615437' where id in ( 686426 ) and NHMemberID = 'NH202209572784'