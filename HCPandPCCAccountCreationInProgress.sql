IF OBJECT_ID('tempdb..#HCPAndPCCResets') IS NOT NULL DROP TABLE #HCPAndPCCResets
IF OBJECT_ID('tempdb..#HCPAndPCCResetsTemp') IS NOT NULL DROP TABLE #HCPAndPCCResetsTemp

create table #HCPAndPCCResets
(
DateInitiated Date,
TicketNo int,
HCPID int,
FirstName varchar(50),
LastName varchar(50),
UserType varchar(50),
Title varchar(50),
Email varchar(200),
ProviderID int,
LocationID varchar(100),

-- Computed or Virtual Columns
ProviderCode as cast(ProviderID as int)+cast('180000' as int),
UserNameGenerated as ( LTRIM(RTRIM(FirstName))+ LTRIM(RTRIM(LastName)) ),
NHUserNameGenerated as ( 'NH'+LTRIM(RTRIM(FirstName))+ LTRIM(RTRIM(LastName)))
)

insert into #HCPAndPCCResets (DateInitiated, TicketNo, HCPID, FirstName, LastName, UserType,Title, Email, ProviderID, LocationID) values
('1/29/2021','34277','7280','Anne',	'Jenkins','hcp','aud','jenkinsa@ohpin.com','1811','19343'),
('1/29/2021','34277','7278','Allison','Vivo','hcp','aud','allisonvivo@oenta.com','1811','19341')

select * from #HCPAndPCCResets
select * into #HCPAndPCCResetsTemp from #HCPAndPCCResets
/*
DECLARE @exists BIT = 0
SELECT TOP 1 @exists = 1 FROM MyTable WHERE ...
IF @exists = 1
*/

declare @vHCPID int, @vUserNameGenerated varchar(100), @vNHUserNameGenerated varchar(100);

select top 1 
@vHCPID = HCPID, 
@vUserNameGenerated= UserNameGenerated, 
@vNHUserNameGenerated = NHUserNameGenerated
from #HCPAndPCCResetsTemp
select @vHCPID as HCPID, @vUserNameGenerated as UserNameGenerated, @vNHUserNameGenerated as NHUserNameGenerated 

declare @vUsername varchar(50), @vTemproryKeyCode varchar(20);
select 
@vUsername = UserName,
@vTemproryKeyCode = TemproryKeyCode from auth.UserProfiles where 1=1 and 
UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @vHCPID)

select @vUsername, @vTemproryKeyCode


















