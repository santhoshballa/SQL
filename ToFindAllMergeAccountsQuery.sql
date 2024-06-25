select distinct
a.datasource as [DataSource 1], a.NHMemberID as [NHMemberID 1], a.CreateDate, a.ModifyDate, a.CreateUser, a.ModifyUser, a.firstName [FirstName 1], a.LastName [LastName 1], cast(a.DateOfBirth as date) as [DateOfBirth 1], 
b.datasource as [DataSource 2], b.NHmemberID as [NHMemberID 2], b.CreateDate, b.ModifyDate, b.CreateUser, b.ModifyUser, b.firstName [FirstName 2], b.LastName [LastName 2], cast(b.DateOfBirth as date) as [DateofBirth 2]
--(cast(a.CreateDate as date) - cast(b.CreateDate as date)),
--(cast(a.ModifyDate as date) - cast(b.ModifyDate as date))

from 
master.members a, master.members b where 
a.FirstName = b.firstName and
a.LastName = b.LastName and 
a.DateOfBirth = b.DateOfBirth and
a.IsActive = 1 and b.isActive = 1 and
a.datasource = b.datasource and
a.CreateUser = b.CreateUser and
a.NHMemberID <> b.NHMemberID and
a.CreateDate > GetDate() - 1
order by a.datasource, a.createuser, b.datasource, b.createuser

select * from master.members where NHMemberID in ('NH202106829892', 'NH202106829891')



select distinct
a.datasource as [DataSource 1],a.NHLinkID, a.NHMemberID as [NHMemberID 1], a.CreateDate, a.ModifyDate, a.CreateUser, a.ModifyUser, a.firstName [FirstName 1], a.LastName [LastName 1], cast(a.DateOfBirth as date) as [DateOfBirth 1], 
b.datasource as [DataSource 2],b.NHLinkID, b.NHmemberID as [NHMemberID 2], b.CreateDate, b.ModifyDate, b.CreateUser, b.ModifyUser, b.firstName [FirstName 2], b.LastName [LastName 2], cast(b.DateOfBirth as date) as [DateofBirth 2]
--(cast(a.CreateDate as date) - cast(b.CreateDate as date)),
--(cast(a.ModifyDate as date) - cast(b.ModifyDate as date))

from 
master.members a join master.members b on  
a.FirstName = b.firstName and
a.LastName = b.LastName and 
a.DateOfBirth = b.DateOfBirth and
a.IsActive = 1 and b.isActive = 1 and
a.datasource = b.datasource and
a.CreateUser = b.CreateUser and
a.NHMemberID <> b.NHMemberID and
a.CreateDate > GetDate() - 1
order by a.datasource, a.createuser, b.datasource, b.createuser