/* Script to verify HCP details.
DECLARE @HCP INT SET @HCP=3396

select 'auth.UserProfiles' as TableName, UserParofileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)
select 'provider.HCPProviderProfile' as TableName,UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' as 'CRM' from provider.HCPProviderProfile where HCPId = @HCP
select 'dbo.ProviderDataHCPs' as TableName, HCPId,FirstName,LastName,IsActive,'Roster' as 'Roster' from dbo.ProviderDataHCPs where HCPId = @HCP
select 'provider.ProviderUsers' as TableName, UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)
select 'auth.UserProfileGroups' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)
select 'provider.ProviderUserLocations' as TableName, UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations  where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)


IF OBJECT_ID('tempdb..#HCPTemp') IS NOT NULL DROP TABLE #HCPTemp
Create table #HCPTemp 
(HCPID int)
insert into #HCPTemp (HCPID) values 
(735),(6922),(4638),(1776),(2026),(6897),(731),(7255),(5616),(5574),(5477),(3082),(5573),(5566),(5587),(5581),(6536),(3170),(6694),(62),(1320),(5276),(6574),(1974),(7013),(7015),(7186)


select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp))
Order by UserProfileId

select UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' from provider.HCPProviderProfile where HCPId IN (select HCPID from #HCPTemp) Order by UserProfileId
select HCPId,FirstName,LastName,IsActive,'Roster' from ProviderDataHCPs where HCPId IN (select HCPID from #HCPTemp)
select UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId
select UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId
select UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId

--- If username already exists with different profile change the username

-- Check UserProfileID, ProviderLocations, 

declare @Username varchar(20) = 'NakieaStrecker'
--declare @UserProfileID int = 4080

--select * from auth.userprofiles where username = @UserProfileID
--select UserProfileID from auth.userprofiles where username = @UserProfileID

select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from 
auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker' )
--select UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' from provider.HCPProviderProfile where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker')
--select HCPId,FirstName,LastName,IsActive,'Roster' from ProviderDataHCPs where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker')
select UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker' )
select UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker' )
select UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker' )
select * from [dbo].[ProviderDataLocations] where locationID in (select LocationId from provider.ProviderUserLocations where UserProfileId IN (select UserProfileID from auth.userprofiles where username = 'NakieaStrecker' ))


update [dbo].[ProviderDataLocations] set IsActive = 1 WHERE LocationId IN (5543)


--EXEC [support].[ResetHCPCredentials]  'HIS', 'sforrest@beltoneamerica.com ; mwells@beltoneamerica.com', '180609', 'StephanieForrest', 735  -- Multiple email ID's
EXEC [support].[ResetHCPCredentials]  'HIS', 'sforrest@beltoneamerica.com', '180609', 'StephanieForrest', 735 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'Nolegirl425@gmail.com', '181594', 'AngelaPinson', 6922 --Account Reset
EXEC [support].[ResetHCPCredentials]  'HIS', 'Kurtdiane63@gmail.com', '180609', 'KurtBaumgartner', 4638 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'LdrakeAudio@Gmail.com', '181041', 'LyleDrake', 1776 -- Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'lbohiosinus@gmail.com', '181085', 'LoisBarin', 2026 -- New Account
EXEC [support].[ResetHCPCredentials]  'AUD', 'susquehannahearing@dejazzd.com', '181556', 'AngelaMuchler', 6897 -- Account Reset
EXEC [support].[ResetHCPCredentials]  'HIS', 'dbass@beltone.com', '180609', 'DavidBass', 731 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'Foresthillsaud@gmail.com', '181809', 'RoksanaBorukhova', 7255 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'jeoc@hearinglife.com', '180842', 'JenniferOcchiuto', 5616 -- New Account
EXEC [support].[ResetHCPCredentials]  'AUD', 'nanm@hearinglife.com', '180842', 'NancyMcGee', 5574 --New Account
EXEC [support].[ResetHCPCredentials]  'HIS', 'MERO@hearmorenow.com', '180842', 'MeganRoy', 5477 --Account Reset
EXEC [support].[ResetHCPCredentials]  'HIS', 'auke@hearinglife.com', '180842', 'AlumbaKeller', 3082 --New Account
EXEC [support].[ResetHCPCredentials]  'AUD', 'reli@hearinglife.com', '180842', 'ReginaLiantonio', 5573 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'vfor@hearinglife.com', '180842', 'VanesaForbes', 5566 --New Account
EXEC [support].[ResetHCPCredentials]  'AUD', 'jget@hearinglfe.com', '180842', 'JonathanGetreu', 5587 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'kish@hearinglife.com', '180842', 'KimberlyShapiro', 5581 --New Account
EXEC [support].[ResetHCPCredentials]  'HIS', 'vnickell@bluegrasshearing.com', '181029', 'BrittanyHampton', 6536 --New Account
--EXEC [support].[ResetHCPCredentials]  'HIS', 'labf@hearinglife.com', '', 'LauraBradford', 3170 --Account Reset, incorrect information
EXEC [support].[ResetHCPCredentials]  'HIS', 'kmorris@myhearingcenters.com', '180221', 'KristinMorris', 6694 --Account Reset
--EXEC [support].[ResetHCPCredentials]  'HIS', 'hearinghotline@aol.com', '180029', 'DavidCrofut', 62
EXEC [support].[ResetHCPCredentials]  'HIS', 'hearinghotline@aol.com', '180029', 'NHDCrofut', 62 -- Account Exists

EXEC [support].[ResetHCPCredentials]  'HIS', 'Sam@rundebeltone.com', '181438', 'SamuelRunde', 1320 -- New Account

--EXEC [support].[ResetHCPCredentials]  'HIS', 'basc@hearinglife.com', '180842', 'BrandiNawrocki', 5276 -- Account already exists
EXEC [support].[ResetHCPCredentials]  'HIS', 'basc@hearinglife.com', '180842', 'NHBrandiNawrocki', 5276 -- New Account
EXEC [support].[ResetHCPCredentials]  'HIS', 'audiohearingctr@gmail.com', '181427', 'MartinStephens', 6574 --Account Reset
--EXEC [support].[ResetHCPCredentials]  'OWNER', 'info@hearinharmony.com', '181490', 'JoshuaPassadino',  -- Incorrect Information
--EXEC [support].[ResetHCPCredentials]  'AUD', 'Drkenney@centersforhearingcare.com', '180861', 'AmandaGrove ', 1974 -- The Account is DrKenny
EXEC [support].[ResetHCPCredentials]  'AUD', 'Drkenney@centersforhearingcare.com', '180861', 'DrKenney ', 1974

EXEC [support].[ResetHCPCredentials]  'HIS', 'Christine@hearagainamerica.com', '180416', 'ChristineHand', 7013 --Account Reset
EXEC [support].[ResetHCPCredentials]  'HIS', 'David@hearagainamerica.com', '180416', 'DavidLeibman', 7015 --Account Reset
EXEC [support].[ResetHCPCredentials]  'AUD', 'brittnay@hearallhearingcenter.com', '180015', 'BrittnayErickson', 7186 --Account Reset


(735,	6922,	4638,	1776,	2026,	6897,	731,	7255,	5616,	5574,	5477,	3082,	5573,	5566,	5587,	5581,	6536,	3170,	6694,	62,	1320,	5276,	6574,	1974,	7013,	7015,	7186)


/* Script to verify HCP details.
DECLARE @HCP varchar(4000) 
SET @HCP = (735,	6922,	4638,	1776,	2026,	6897,	731,	7255,	5616,	5574,	5477,	3082,	5573,	5566,	5587,	5581,	6536,	3170,	6694,	62,	1320,	5276,	6574,	1974,	7013,	7015,	7186)

drop table #HCPTemp 
Create table #HCPTemp 
(HCPID int)
insert into #HCPTemp (HCPID) values 
(735),(6922),(4638),(1776),(2026),(6897),(731),(7255),(5616),(5574),(5477),(3082),(5573),(5566),(5587),(5581),(6536),(3170),(6694),(62),(1320),(5276),(6574),(1974),(7013),(7015),(7186)


select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile 
where HCPId in (select HCPID from #HCPTemp))
order by try_Convert(int, UserName), try_Convert(int, TemproryKeyCode), FirstName, LastName, UserProfileId


select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,try_Convert(int, UserName) as Username_NoAccount, TemproryKeyCode, try_Convert(int, TemproryKeyCode) as TemproryKeyCode_NoAccount, ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and 
UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp))
and try_Convert(int, UserName) is not null
order by FirstName, LastName, UserProfileId


select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,try_Convert(int, UserName) as Username_NoAccount, TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile 
where HCPId in (select HCPID from #HCPTemp))
and try_Convert(int, UserName) is null
order by FirstName, LastName, UserProfileId


select UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' from provider.HCPProviderProfile 
where HCPId in (select HCPID from #HCPTemp)
order by FirstName, LastName, UserProfileId

select HCPId,FirstName,LastName,IsActive,'Roster' from ProviderDataHCPs where HCPId in 
(select HCPID from #HCPTemp) order by FirstName, LastName

select UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in 
(select HCPID from #HCPTemp)) 
order by UserProfileId

select UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile 
where HCPId in (select HCPID from #HCPTemp))
order by UserProfileId

select UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations  where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile 
where HCPId in (select HCPID from #HCPTemp))
order by UserProfileId

--- If username already exists with different profile change the username

select * from auth.userprofiles where username = 'AvivaKagan'
*/







/* List of HCPID's
(7139,699,2601,7125,2699,434,2698,4548,834,1393,6633,376,1297,559,3007,1987,3002,3003,3004,1322,1497,1639))
('LisaKahler','MarieSullivan','NancyHenry','Karafagan','NicoleBanks','KolletteReus','LisaFlett','AshleyHubbard','ShyanneAbbott','LeylaAdan','AllisonTunseth','MickeyFried','DebraVogt','KareenPickett','DaisyDominguez','XiamarisColon','CarolVollmar','BrittanieFranklin','SusanSimpkins','KarenRose','MaryAnnNaccarelli')
*/
-- HCP
-- 22 Records
select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId IN
((735,	6922,	4638,	1776,	2026,	6897,	731,	7255,	5616,	5574,	5477,	3082,	5573,	5566,	5587,	5581,	6536,	3170,	6694,	62,	1320,	5276,	6574,	1974,	7013,	7015,	7186)))
Order by TemproryKeyCode desc 
-- 22


-- PCC
-- 21 Records
select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles
where username in 
('LisaKahler','MarieSullivan','NancyHenry','Karafagan','NicoleBanks','KolletteReus','LisaFlett','AshleyHubbard','ShyanneAbbott','LeylaAdan','AllisonTunseth','MickeyFried','DebraVogt','KareenPickett','DaisyDominguez','XiamarisColon','CarolVollmar','BrittanieFranklin','SusanSimpkins','KarenRose','MaryAnnNaccarelli')
order by TemproryKeyCode desc


select * from (
select (Username+'|') as Username, TemproryKeyCode, Designation
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId IN
((735,	6922,	4638,	1776,	2026,	6897,	731,	7255,	5616,	5574,	5477,	3082,	5573,	5566,	5587,	5581,	6536,	3170,	6694,	62,	1320,	5276,	6574,	1974,	7013,	7015,	7186)))
--Order by TemproryKeyCode desc 
union
select (Username+'|') as Username, TemproryKeyCode, Designation from 
auth.UserProfiles
where username in 
('LisaKahler','MarieSullivan','NancyHenry','Karafagan','NicoleBanks','KolletteReus','LisaFlett','AshleyHubbard','ShyanneAbbott','LeylaAdan','AllisonTunseth','MickeyFried','DebraVogt','KareenPickett','DaisyDominguez','XiamarisColon','CarolVollmar','BrittanieFranklin','SusanSimpkins','KarenRose','MaryAnnNaccarelli')
--order by TemproryKeyCode desc
) a
Where TemproryKeyCode is not null
Order by Designation




-- By Provider Code
declare @ProviderCode int
declare @ProviderID int
declare @HCPID int = 3396
set @ProviderCode = 180704
set @ProviderID = (@ProviderCode - 180000)
select @ProviderCode as ProviderCode, @ProviderID as ProviderID
--select '[auth.userProfiles]' as TableName, UserProfileID, FirstName, LastName, IsActive, TemproryKeyCode, UserName from auth.userProfiles where ProviderCode = @ProviderCode
select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (7133)
select '[auth.UserProfileGroups]' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (7133)
select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID = isNull(@HCPID, '')
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in (select LocationId from provider.ProviderUserLocations where UserProfileId IN (7133))
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (7133)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (7133)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where ProviderID =  @ProviderID
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (7133)
select '[provider.MemberAppointments]' as TableName, 'CRM' as 'FromCRM',  * from provider.MemberAppointments where HCPUserProfileID in (7133) 


select 'auth.UserProfiles' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = 3396 )
--UserProfileID | 7133
--ProviderCode | 180704
--LocationID | 5032
select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (7133)

select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (7133)
select '[auth.UserProfileGroups]' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (7133)
select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID = 3396  --isNull(@HCPID, '')
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in (select LocationId from provider.ProviderUserLocations where UserProfileId IN (7133))
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (4080) 
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (4080)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where LocationID = 5032 and ProviderID = 704
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (7133) and LocationID = 5032 and Providerid = 704
select '[provider.MemberAppointments]' as TableName, 'CRM' as 'FromCRM',  * from provider.MemberAppointments where HCPUserProfileID in (4080)



select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID = 3396  
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in (5032)


select distinct table_name from information_schema.columns where table_name like '%provider%' and TABLE_SCHEMA = 'dbo'
--HCPProviderProfile, ProviderDataHCPMapping, ProviderDataHCPs, ProviderDataLocations, ProviderDataProviders, ProviderLocations, PRProviderLocationHCPMapping

select * from information_Schema.columns where table_schema = 'dbo' and table_name like '%Provider%'

select distinct table_name, column_name from information_schema.columns where table_name in 
('HCPProviderProfile', 'ProviderDataHCPMapping', 'ProviderDataHCPs', 'ProviderDataLocations', 'ProviderDataProviders', 'ProviderLocations', 'PRProviderLocationHCPMapping')


select * from auth.UserProfiles
select top 10 * from ProviderDataHCPMapping where HCPID = @HCPID and LocationID = @LocationID and ProviderID = @ProviderID
select top 10 * from ProviderDataHCPs
select top 10 * from ProviderDataLocations
select top 10 * from ProviderDataProviders

--UserProfileID | 7133
--ProviderCode | 180704
--LocationID | 5032

select  * from ProviderDataHCPMapping where HCPID = 3396 and LocationID =  5032 and ProviderID = 704
select  * from ProviderDataHCPs where HCPID =  3396
select  * from ProviderDataLocations where locationID = 5032
select  * from ProviderDataProviders where ProviderID in (704)






