/* Script to verify HCP details.
1/29/2021	34282	7253	Christie	Leung	hcp	aud	christiehleung@gmail.com	1808	19330

EXEC [support].[ResetHCPCredentials]  'AUD', 'christiehleung@gmail.com', '181808', 'ChristieLeung', 7253

DECLARE @HCP INT 
SET @HCP=7364

select 'auth.UserProfiles' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash, *
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)

select 'provider.HCPProviderProfile' as TableName, UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' as ApplicationName, * from provider.HCPProviderProfile where HCPId = @HCP
select 'dbo.ProviderDataHCPs' as TableName, HCPId,FirstName,LastName,IsActive,'Roster' as Roster, * from dbo.ProviderDataHCPs where HCPId = @HCP
select 'provider.ProviderUsers' as TableName, UserProfileId,ProviderId,IsActive, * from provider.ProviderUsers where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)
select 'auth.UserProfileGroups' as TableName, UserProfileId,UserGroupId,IsActive, * from auth.UserProfileGroups where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)
select 'provider.ProviderUserLocations' as TableName, UserProfileId,ProviderId,LocationId,IsActive, * from provider.ProviderUserLocations  where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = @HCP)

select * from auth.userprofiles where username = 'sballa'
select * from auth.userprofiles where FirstName = 'Dorothy' and LastName = 'Kell'


declare @UserProfileId int
set  @UserProfileId = 11158

select * from auth.UserProfiles where 1=1 and UserProfileId in (@UserProfileId)
select * from provider.HCPProviderProfile where UserProfileId in (@UserProfileId)
select * from provider.ProviderUsers where UserProfileId in (@UserProfileId)
select * from auth.UserProfileGroups where UserProfileId in (@UserProfileId)
select * from provider.ProviderUserLocations  where UserProfileId in (@UserProfileId)


IF OBJECT_ID('tempdb..#HCPTemp') IS NOT NULL DROP TABLE #HCPTemp
Create table #HCPTemp 
(HCPID int)
insert into #HCPTemp (HCPID) values 
(3056),(1379),(2682),(2371),(1345),(2517),(1742),(5305),(616),(535),(1808),(3347),(5633),(6754),(5493),(7018),(4553),(7311),(5640),(7260),(6726),(7209),(2702),(6982),(1973),(7127)


select UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp))
Order by UserProfileId

select UserProfileId,HCPId,FirstName,LastName,IsActive,'CRM' from provider.HCPProviderProfile where HCPId IN (select HCPID from #HCPTemp) Order by UserProfileId
select HCPId,FirstName,LastName,IsActive,'Roster' from ProviderDataHCPs where HCPId IN (select HCPID from #HCPTemp)
select UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId
select UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId
select UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId in (select HCPID from #HCPTemp)) Order by UserProfileId

--- If username already exists with different profile change the username
select * from auth.userprofiles where username = 'MaryOrborne'
*/



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
