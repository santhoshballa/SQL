-- By Provider Code
select * from auth.UserProfiles where ProviderCode = 181783 and IsActive = 1 and IsRegister = 1 and IsBlocked = 0 and PasswordHash is not null and PasswordSalt is not null


declare @ProviderCode int
declare @ProviderID int
declare @HCPID int =  228
set @ProviderCode = 181495
set @ProviderID = (@ProviderCode - 180000)
--select @ProviderCode as ProviderCode, @ProviderID as ProviderID
--select '[auth.userProfiles]' as TableName, UserProfileID, FirstName, LastName, IsActive, TemproryKeyCode, UserName from auth.userProfiles where ProviderCode = @ProviderCode or Username like '%sballa%'
select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (10962)
select '[auth.UserProfileGroups]' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (10962)
select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID in (6767)
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in ()
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM',HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (10962)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (10962)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where ProviderID =  @ProviderID
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (10962)
select '[provider.MemberAppointments]' as TableName, 'CRM' as 'FromCRM',  * from provider.MemberAppointments where HCPUserProfileID in (10962) 


select 'auth.UserProfiles' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash
from auth.UserProfiles where 1=1 and UserProfileId IN (select UserProfileId from provider.HCPProviderProfile where HCPId = 6767   )
--UserProfileID | 7133
--ProviderCode | 180704
--LocationID | 5032
select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (7133)

select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (7133)
select '[auth.UserProfileGroups]' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (7133)
select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID = 6211  --isNull(@HCPID, '')
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in (select LocationId from provider.ProviderUserLocations where UserProfileId IN (7133))
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (7133) 
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (7133)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where LocationID = 5032 and ProviderID = 1390
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (7133) and Providerid = 1390 --and LocationID = 5032 
select '[provider.MemberAppointments]' as TableName, 'CRM' as 'FromCRM',  * from provider.MemberAppointments where HCPUserProfileID in (7133)



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





--select  * from ProviderDataHCPs where HCPID =  3396
-- select HCPID, IsActive, Classification, FirstName, LastName, NPINumber, LicenseNumber1, CredentialDate from ProviderDataHCPs where HCPID = 701

select  * from ProviderDataProviders where ProviderID in (1403)
-- select ProviderID, IsActive,  LegalBusinessName, OwnerLastName, OwnerFirstName, PrimaryEmailAddress, BillingAddress, BillingCity, BillingState, BillingZip, BillingCounty from ProviderDataProviders where ProviderID in (704)

select * from ProviderDataLocations where locationID = 17647
-- select Providerid, LocationID, IsActive, ProviderDBA, NPINumber, Address1, Address2, City, State, Zip, TimeZone, LocationEmailAddress, LegalBusinessName, TaxID from ProviderDataLocations

--select  * from ProviderDataHCPMapping where HCPID = 3396
-- select HCPID, LocationID, NPINumber, HCPStatus, Classification, FirstName, LastName, LegalBusinessName from ProviderDataHCPMapping where HCPID = 3396

--Segmentation, Association and Classification algorithms, Data Science, Artificial Intelligence and Machine Learning, Master Data Management, Containerization, Big Data, Data Architecture, Integration

-- Data from the 'Roster'
x


/*
case (a.Classification)
	when 'AUD' Then 'AUD'
	when 'Central Time Zone' Then 'Central Time Zone'
	when 'D.O.' Then 'DO'
	when 'Fitter' then 'Fitter'
	when 'HAD' then 'HAD'
	when 'HAF' then 'HAF'
	when 'HAS' then 'HAS'
	when 'HID' then 'HID'
	when 'HIS' then 'His'
	when 'HS' then 'HS'
	when 'MD' then 'MD'
	when 'Specialist' then 'Specialist'
	else 'None'
end  as Classification,
*/

-- Step 1 | Check for the Provider UserProfileID and ProviderCode in the auth.UserProfiles
select '[auth.UserProfiles]' as TableName,UserProfileID, ProviderCode,IsActive,  * from auth.UserProfiles 
where 1=1 
--and UserProfileID = 11073 
--and ProviderCode = 181517 
and (FirstName like '%Jenny%' and LastName like '%Walters%') 
--or (Username like '%Andrew%' or UserName like '%Keiner%')
and ProviderCode is not null -- A Providercode has to be present, cannot be null.
and UserProfileID is not null

-- Step 2 | Check for the HCP ID
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileID, HCPID, ISActive, * from provider.HCPProviderProfile 
where FirstName like '%Andrew%' and LastName like '%Keiner%' 
or UserProfileID = '11073' 
or HCPID ='6803'
--11073,6803

-- You will need UserProfileID and the ProviderCode or ProviderID
select '[provider.providerProfiles]' as TableName, 'CRM' as 'FromCRM', ProviderID, DBA, IsActive, NPINumber, ProviderName, ProviderCode, ProviderDomain from provider.providerProfiles where providerid = 1517
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (11073)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (11073)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM',ProviderID, LocationID, IsActive from Provider.ProviderLocations where ProviderID = 1517 
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (11073)


-- Provider Tables
select '[provider.providerProfiles]' as TableName, 'CRM' as 'FromCRM', ProviderID, DBA, IsActive, NPINumber, ProviderName, ProviderCode, ProviderDomain from provider.providerProfiles where providerid = 1648
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,NPINUmber,IsActive from provider.HCPProviderProfile where UserProfileId IN ('11681') or HCPId in (7009)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN ('11681')
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where LocationID = 17647 and ProviderID = 609
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (12346) and LocationID = 1739 and Providerid = 1648




-- From the 'Roster'
-- By HCPID
select * from ProviderDataHCPMapping where HCPID = 6803  
select * from ProviderDataHCPs where HCPID =  6803

-- By Provider ID
select * from ProviderDataHCPMapping where ProviderID in (1517)
select * from ProviderDataLocations where ProviderID in (1517)
select * from ProviderDataProviders where ProviderID in (1517 )

-- By Location ID
select * from ProviderDataHCPMapping where LocationID in (11632)
select * from ProviderDataLocations where LocationID in (11632)



select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']'
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('dbo')
and TABLE_NAME in ( 'ProviderDataHCPMapping', 'ProviderDataHCPs', 'ProviderDataLocations','ProviderDataProviders')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
order by table_schema, table_name

-- Provider Tables in the Roster that are provided

select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Action|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'HCPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'HCPStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPStatus] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'First Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([First Name] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Last Name|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Last Name] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'NPINumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NPINumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Classification|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Classification] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'LocationID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'ProviderDBA|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderDBA] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'ProviderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'TaxID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TaxID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'LegalBusinesName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LegalBusinesName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'HCPLastAudited|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPLastAudited] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Column 13|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 13] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Column 14|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 14] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Column 15|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 15] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPMapping|' as TABLE_NAME,'Column 16|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 16] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPMapping]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'Action|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'HCPId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'TermDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TermDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'ReasonForTermination|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonForTermination] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'Classification|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Classification] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'Gender|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Gender] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'FirstName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FirstName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LastName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'NPINumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NPINumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'SSN|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SSN] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'DOB|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DOB] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseNumber1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseNumber1] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseState1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseState1] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseNumber2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseNumber2] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseState2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseState2] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseNumber3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseNumber3] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'LicenseState3|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LicenseState3] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'MedicaidID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicaidID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'MedicareID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'PediatricServices|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PediatricServices] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'BoardCertification|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BoardCertification] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'BoardCertificationDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BoardCertificationDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'CredentialDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CredentialDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'CAQH_ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CAQH_ID] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataHCPs|' as TABLE_NAME,'HCP_Email|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCP_Email] as nvarchar))),'"') as VALUE from dbo.[ProviderDataHCPs]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Action|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LocationId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'CredentialingStatus|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CredentialingStatus] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ProviderDBA|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderDBA] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'NPINumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NPINumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'address1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([address1] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'address2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([address2] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'City|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'State|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([State] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Zip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'County|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([County] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'CountyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CountyCode] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'TimeZone|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TimeZone] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LocationEmailAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationEmailAddress] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LocationPhoneNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationPhoneNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LocationFaxNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationFaxNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Monday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Monday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Tuesday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Tuesday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Wednesday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Wednesday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Thursday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Thursday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Friday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Friday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Saturday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Saturday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Sunday Office Hours|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Sunday Office Hours] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ResoundAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResoundAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'BeltoneAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BeltoneAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'BeltoneDispenserNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BeltoneDispenserNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'StarkeyAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StarkeyAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'PhonakAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PhonakAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'WidexAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WidexAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'SigniaAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SigniaAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'UnitronAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitronAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'OticonAccountNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OticonAccountNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Hansaton|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Hansaton] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Rexton|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Rexton] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'WheelChair|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WheelChair] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'PeditatricServices|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PeditatricServices] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Languages|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Languages] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'APDTesting|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([APDTesting] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'APDTreatent|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([APDTreatent] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ENG VNG|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ENG VNG] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'OAEs|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OAEs] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Tympanometry|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Tympanometry] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'VRA|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VRA] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ConditioningPlayAudiometry|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConditioningPlayAudiometry] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ABR|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ABR] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'AuralRehabilitation|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuralRehabilitation] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'TinnitUSEvaluations|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TinnitUSEvaluations] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'CI|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CI] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'BAHA OsteointegratedDevices|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BAHA OsteointegratedDevices] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ECoG|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ECoG] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'RotaryChair|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RotaryChair] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Posturography|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Posturography] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'TaxId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TaxId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LegalBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LegalBusinessName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'LocationLastAudited|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LocationLastAudited] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Column 57|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 57] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Column 58|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 58] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Column 59|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 59] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Column 60|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 60] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'Column 61|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 61] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataLocations|' as TABLE_NAME,'id|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([id] as nvarchar))),'"') as VALUE from dbo.[ProviderDataLocations]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Action|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'TaxId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TaxId] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'LegalBusinessName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LegalBusinessName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Brands|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Brands] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'InitialContract|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InitialContract] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ContractType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractType] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'W9ReceivedDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W9ReceivedDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ADAAttestationReceivedDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ADAAttestationReceivedDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'MedicareAttestationReceivedDate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MedicareAttestationReceivedDate] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Amendment|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amendment] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ContractTermination|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractTermination] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ReasonForTermination|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReasonForTermination] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'PrimaryEmailAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrimaryEmailAddress] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingAddress] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingCity] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingState] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingZip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingZip] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingCounty|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingCounty] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingCountyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingCountyCode] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'BillingPhoneNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BillingPhoneNumber] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'OwnerLastName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OwnerLastName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'OwnerFirstName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OwnerFirstName] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ShippingAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingAddress] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ShippingAddress2|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingAddress2] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ShippingCity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingCity] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ShippingState|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingState] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'ShippingZip|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingZip] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Column 29|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 29] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Column 30|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 30] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a union 
select top 40 * from  (select distinct  'dbo|' as TABLE_SCHEMA,'ProviderDataProviders|' as TABLE_NAME,'Column 31|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Column 31] as nvarchar))),'"') as VALUE from dbo.[ProviderDataProviders]) a





/*

update Orders.OrderTransactionDetails set IsActive = 0 where OrderTransactionID = 1459592

select * from Orders.OrderTransactionDetails where OrderTransactionID = 1459592


select * from orders.orders where orderid = 200394295 
select * from orders.OrderItems where orderid = 200394295 
select * from orders.orderitemdetails where orderid = 200394295 
select * from orders.OrderTransactionDetails where orderid = 200394295

*/

/*


-- By Provider Code
declare @ProviderCode int
declare @ProviderID int
declare @HCPID int =  6987
set @ProviderCode = 180101
set @ProviderID = (@ProviderCode - 180000)
--select @ProviderCode as ProviderCode, @ProviderID as ProviderID
--select '[auth.userProfiles]' as TableName, UserProfileID, FirstName, LastName, IsActive, TemproryKeyCode, UserName from auth.userProfiles where ProviderCode = @ProviderCode
select '[auth.UserProfiles]' as TableName, UserProfileId,FirstName,LastName,IsActive,Designation,UserName,TemproryKeyCode,ProviderCode,PrimaryEmail,PasswordHash from auth.UserProfiles where 1=1 and UserProfileId IN (5815)
select '[auth.UserProfileGroups]' as TableName, UserProfileId,UserGroupId,IsActive from auth.UserProfileGroups where UserProfileId IN (5815)
select '[dbo.ProviderDataHCPs]' as TableName,'Roster' as 'FromRoster' ,HCPId,FirstName,LastName,IsActive from dbo.ProviderDataHCPs where HCPID in (3149)
select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in (select LocationId from provider.ProviderUserLocations where UserProfileId IN (5815)) order by isActive desc
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (5815)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (5815)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where ProviderID =  @ProviderID
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (5815)
select '[provider.MemberAppointments]' as TableName, 'CRM' as 'FromCRM',  * from provider.MemberAppointments where HCPUserProfileID in (5815) 



*/


select * from dbo.ProviderDataLocations where address1 like '%S Dunkin Dr%'


--HCP 6803, ProviderID 1517

declare @ProviderCode int
declare @ProviderID int
declare @HCPID int =  6803
set @ProviderCode = 181495
set @ProviderID = (@ProviderCode - 180000)

select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (10962)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where ProviderID =  @ProviderID
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (10962)


-- Ticket # 41191
Please remove DG�s Hearing Provider Id 1345 from CRM. Its not in the master roster but it is showing in CRM and on the IT roster. 
I believe this was a �test provider� that Diana Garcia made long back but its causing confusion for the MEA�s on the call center.

HCPID
Location
ProviderId

3384
6331
1345


-- From the 'Roster'
-- By HCPID
select * from ProviderDataHCPMapping where HCPID = 3384  
select * from ProviderDataHCPs where HCPID =  3384

-- By Provider ID
select * from ProviderDataHCPMapping where ProviderID in (1345)
select * from ProviderDataLocations where ProviderID in (1345)
select * from ProviderDataProviders where ProviderID in (1345 )

-- By Location ID
select * from ProviderDataHCPMapping where LocationID in (6331)
select * from ProviderDataLocations where LocationID in (6331)



HCPID 3384
Location 6331
ProviderId 1345

select
d.IsActive as 'PDP_IsActive',
c.IsActive as 'PDL_IsActive', 
b.isActive as 'PDHCP_IsActive', 

a.HCPID, d.providerid, c.locationid, 
a.HCPID, a.LocationID, a.NPINumber, a.HCPStatus, a.Classification, a.[First Name], a.[Last Name], a.LegalBusinesName,
b.HCPID, b.IsActive, b.Classification, b.FirstName, b.LastName, b.NPINumber, b.LicenseNumber1, b.CredentialDate,
c.Providerid, c.LocationID, c.IsActive, c.ProviderDBA, c.NPINumber, c.Address1, c.Address2, c.City, c.State, c.Zip, c.TimeZone, c.LocationEmailAddress, c.LegalBusinessName, c.TaxID,
d.ProviderID, d.IsActive,  d.LegalBusinessName, d.OwnerLastName, d.OwnerFirstName, d.PrimaryEmailAddress, d.BillingAddress, d.BillingCity, d.BillingState, d.BillingZip, d.BillingCounty

from ProviderDataHCPMapping a
left join ProviderDataHCPs b on a.HCPID = b.HCPID
left join ProviderDataLocations c on a.LocationID = c.locationid
left join ProviderDataProviders d on c.providerid = d.providerid
where 1=1 
and a.HCPID = 3384
and c.locationid in (6331)
and d.providerid in (1345)
order by c.locationid

HCPID 3384
Location 6331
ProviderId 1345



-- Step 1 | Check for the Provider UserProfileID and ProviderCode in the auth.UserProfiles
select '[auth.UserProfiles]' as TableName,UserProfileID, ProviderCode,IsActive,  * from auth.UserProfiles 
where 1=1 
--and UserProfileID = 11073 
--and ProviderCode = 181517 
and (FirstName like '%Diana%' and LastName like '%Garcia%') 
--or (Username like '%Andrew%' or UserName like '%Keiner%')
and ProviderCode = 181345 -- A Providercode has to be present, cannot be null.
and UserProfileID in (6648,6649,12895,12896)

-- Step 2 | Check for the HCP ID
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileID, HCPID, ISActive, * from provider.HCPProviderProfile 
where FirstName like '%Andrew%' and LastName like '%Keiner%' 
or UserProfileID = '11073' 
or HCPID ='6803'
--11073,6803

-- You will need UserProfileID and the ProviderCode or ProviderID
select '[provider.providerProfiles]' as TableName, 'CRM' as 'FromCRM', ProviderID, DBA, IsActive, NPINumber, ProviderName, ProviderCode, ProviderDomain from provider.providerProfiles where providerid = 1345
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileID in (6648,6649,12895,12896)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileID in (6648,6649,12895,12896)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM',ProviderID, LocationID, IsActive from Provider.ProviderLocations where ProviderID = 1345 
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileID in (6648,6649,12895,12896)

-- Ticket # 41191

update provider.HCPProviderProfile set IsActive = 0 where UserProfileID = 6649
update provider.providerProfiles set IsActive = 0 where providerid = 1345
update provider.Providerusers set IsActive = 0 where providerID = 1345
update Provider.ProviderLocations set IsActive = 0 where providerID = 1345
update provider.ProviderUserLocation set IsActive = 0 where providerID = 1345





UserProfileID : 3547	
ProviderCode | 181083
HCPID | 1983
LocationID |3506

select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (3547)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where ProviderID =  1083
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (3547)


select  * from ProviderDataHCPMapping where HCPID = 1983 and LocationID =  3506 and ProviderID = 1083
select  * from ProviderDataHCPs where HCPID =  1983
select  * from ProviderDataLocations where locationID = 3506
select  * from ProviderDataProviders where ProviderID in (1083)


select * from  provider.HCPProviderProfile where hcpid = 1983
select * from  provider.providerProfiles where providerid = 1083
select * from  Provider.ProviderLocations where providerid = 1083 and locationid = 3506
select * from  provider.ProviderUserLocations where ProviderID = 0365 and UserProfileID = 13855 and locationId = 3506


update provider.HCPProviderProfile set IsActive = 1 where hcpid = 1983
update provider.providerProfiles set IsActive = 1 where providerid = 1083
update Provider.ProviderLocations set IsActive = 1 where providerid = 1083 and locationid= 3506
update provider.ProviderUserLocations set IsActive =1 where UserProfileID = 3547 and ProviderID = 1083 and locationId = 3506


/*

UserProfileID : 9470	
ProviderCode | 180365
HCPID | 1983
LocationID |3506

select UserProfileID, Designation, UserName, firstName, LastName, IsActive, IsBlocked, IsEnabled, * from auth.UserProfiles where firstName like 'Amanda'  and lastname like 'V%'

select * from ProviderDataHCPs where firstname like '
select  * from ProviderDataHCPMapping where HCPID = 1983 and LocationID =  3506 and ProviderID = 0365
select  * from ProviderDataHCPs where HCPID =  1983
select  * from ProviderDataLocations where locationID = 3506
select  * from ProviderDataProviders where ProviderID in (0365)

select * from provider.HCPProviderProfile where firstName like '%Amanda%'  and lastname like '%V%'
select * from  provider.HCPProviderProfile where hcpid = 1983
select * from  provider.providerProfiles where providerid = 0365
select * from  Provider.ProviderLocations where providerid = 0365 and locationid = 3506
select * from  provider.ProviderUserLocations where UserProfileID = 3547 and ProviderID = 1083 and locationId = 3506



*/

/*
Audio'D' and Finetone Hearing
 Select Location                                 1 Plaza Dr, Windham, ME, 04062                                 152 U.S. Rte One, Ste 14, Scarbough, ME, 04074                                 477 Wilton Rd, Ste 2, Farmington, ME, 04938                                 202 Maple St, Ste D, Cornish, ME, 04020                 

Eastern Standard Time
"data":"LOG ID:50a265c0-2aa0-4116-ad2c-b37051da372d Message: Value cannot be null.\r\nParameter name: s","errors":null}

WILLIAM MOORE - NH202005443975

PROVIDER GETS THIS ERROR MESSAGE WHEN HE ENTERS INTO THE MEMBER ENGAGEMENT SCREEN

select * from  provider.HCPProviderProfile where 

select * from  provider.providerProfiles where DBA like '%Finetone Hearing%' or providerName like '%Finetone Hearing%'

select * from provider.HCPProviderProfile where firstName like '%Brian%'  and lastname like '%Files%'
select * from  provider.HCPProviderProfile where hcpid = 2665
select * from  provider.providerProfiles where providerid = 2665
select * from  Provider.ProviderLocations where providerid = 2665 and locationid = 3506
select * from  provider.ProviderUserLocations where UserProfileID = 3547 and ProviderID = 1083 and locationId = 3506


select '[auth.UserProfiles]' as TableName,UserProfileID, ProviderCode,IsActive,  * from auth.UserProfiles 
where 1=1 
--and UserProfileID = 11073 
--and ProviderCode = 181517 
and (FirstName like '%Brian%' and LastName like '%Files%') 
--or (Username like '%Andrew%' or UserName like '%Keiner%')
and ProviderCode = 181345 -- A Providercode has to be present, cannot be null.
and UserProfileID in (6648,6649,12895,12896)

-- Step 2 | Check for the HCP ID
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileID, HCPID, ISActive, * from provider.HCPProviderProfile 
where FirstName like '%Andrew%' and LastName like '%Keiner%' 
or UserProfileID = '11073' 
or HCPID ='6803'
--11073,6803

-- You will need UserProfileID and the ProviderCode or ProviderID
select '[provider.providerProfiles]' as TableName, 'CRM' as 'FromCRM', ProviderID, DBA, IsActive, NPINumber, ProviderName, ProviderCode, ProviderDomain from provider.providerProfiles where providerid = 1345
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileID in (6648,6649,12895,12896)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileID in (6648,6649,12895,12896)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM',ProviderID, LocationID, IsActive from Provider.ProviderLocations where ProviderID = 1345 
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileID in (6648,6649,12895,12896)


select * from auth.UserProfiles where UserProfileID = 4370
--Password for Brian
TableName	UserProfileID	ProviderCode	IsActive	UserProfileId	CreateDate	CreateUser	Designation	FirstName	IsActive	IsBlocked	IsEnabled	IsRegister	LastName	MiddleName	ModifyDate	ModifyUser	PasswordHash	PasswordSalt	TemproryKeyCode	UserName	UserProfileImage	LastLoginDate	Gender	DOB	Languages	IsVerified	PrimaryEmail	PrimaryPhoneNumber	ProviderCode	Title	ActivationDate	IsForcedLogout	LastLogoutDate
[auth.UserProfiles]	4370	180125	1	4370	2019-03-17 17:36:25.6833333	SyncProc	HIS	Brian 	1	0	1	1	Files	NULL	2021-08-09 12:36:45.4335345	BrianFiles	$2a$10$0bS6Y33Db3oX10jBt31AS.6hP7l4rCEc/kA1fcO0OAYzQcVLcDYha	$2a$10$0bS6Y33Db3oX10jBt31AS.	NULL	BrianFiles	NULL	2021-08-09 12:36:45.433	NULL	NULL	NULL	1	Brian.Files@finetonehearing.com	NULL	180125	NULL	2021-02-22 13:54:27.000	0	NULL

UserProfileID | 4370
ProviderCode | 180125
--Reset for testing
update auth.UserProfiles set passwordHash = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm' where UserProfileID = 4370
update auth.UserProfiles set passwordSalt = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.' where UserProfileID = 4370

*/