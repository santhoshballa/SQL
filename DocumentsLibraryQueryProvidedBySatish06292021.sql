/*
TABLE_SCHEMA	TABLE_NAME	COLUMN_NAME	VALUE
auth|	UserGroupModuleRoles|	UserGroupId|	"7200"
auth|	UserGroupModules|	UserGroupId|	"7200"
auth|	UserGroups|	UserGroupId|	"7200"
auth|	UserProfileGroups|	UserGroupId|	"7200"
auth|	UserProfileGroups|	UserProfileId|	"7200"
auth|	UserProfiles|	UserProfileId|	"7200"
auth|	UserProfileSettings|	UserProfileId|	"7200"
auth|	UserProfileSettings|	UserProfileSettingId|	"7200"
*/

select * from auth.UserProfiles where providercode = 181632

select top 10 * from auth.UserProfiles where firstName like 'Santhosh' and providercode =  '180000' or UserprofileID = 12913
select top 10 * from auth.UserProfileGroups where UserProfileID = 13310

select top 10 * from auth.UserGroups where UserGroupID = 7800
select UserGroupID, UserGroupName, * from auth.UserGroups where UserGroupID = 7800

select top 10 * from auth.UserGroupModules

select top 10 * from auth.UserGroupModuleRoles

select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'Santhosh' and providercode =  '180000' or UserprofileID = 12913
select UserGroupID, UserGroupName,DefaultAppModuleRoleID, IsActive, * from auth.UserGroups where UserGroupID = 7800
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID = 12913
select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID = 7800 and AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID = 7800

select UserProfileID, FirstName, LastName, IsActive, ProviderCode, * from auth.UserProfiles where firstName like 'Alisha'  and UserprofileID = 15448 --or providercode =  '180000'
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID = 15448
select UserGroupID, UserGroupName,DefaultAppModuleRoleID, IsActive, * from auth.UserGroups where UserGroupID = 7200

select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)

select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID = 7200 and AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID = 7200
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID = 7800


select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)

select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'Ellen'  and UserprofileID = 12889 --or providercode =  '180000'
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID = 12889
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID = 7200



SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = @__userProfileId_0) AND ([t1].[IsActive] = 1))
          )
      )) AND ([t].[IsActive] = 1))

--Step 1 Query to check main menu, ProfileID as Parameter ( 12913)
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 13310) AND ([t1].[IsActive] = 1))
          )
      )) AND ([t].[IsActive] = 1))

--12889
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 11850) AND ([t1].[IsActive] = 1))
          )
      )) AND ([t].[IsActive] = 1))



Step 2 | 
  SELECT [t].[AppModuleRoleMenuSubmenuId], [t].[AppModuleRoleMenuId], [t].[AppModuleRoleMenuSubmenuIconImage], [t].[AppModuleRoleMenuSubmenuId1], [t].[AppModuleRoleMenuSubmenuName], [t].[AppModuleRoleMenuSubmenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
      FROM [auth].[AppModuleRoleMenuSubmenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND ([t].[IsActive] = 1)







	  
--Step 1 Query to check main menu, ProfileID as Parameter ( 12913)
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12913) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))

--11850
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 11850) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))


select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7600)
--select * from auth.AppModuleRoleMenus

select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where AppModuleRoleID in (1,2,5)



SELECT [t1].[UserGroupId] FROM [auth].[UserProfileGroups] AS [t1] WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12913) AND ([t1].[IsActive] = 1) ) -- find the UserGroupID using ProfileID
SELECT [t0].[AppModuleRoleId] FROM [auth].[UserGroupModuleRoles] AS [t0] WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (7800)
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (3,5,7,11,8,15,4) )) 
  AND ([t].[IsActive] = 1)


SELECT [t1].[UserGroupId] FROM [auth].[UserProfileGroups] AS [t1] WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12889) AND ([t1].[IsActive] = 1) ) -- find the UserGroupID using ProfileID
SELECT [t0].[AppModuleRoleId], * FROM [auth].[UserGroupModuleRoles] AS [t0] WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (7200)
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,12,5) )) 
  AND ([t].[IsActive] = 1)


insert into [auth].[UserGroupModuleRoles] (UserGroupID, AppModuleRoleID, IsActive) values (7200, 5, 1)

select * from auth.AppModules where AppModuleID in (3)
select * from auth.AppModuleRoles where AppModuleID in (3)
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleId in (5)



SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (5) )) 
  AND ([t].[IsActive] = 1)
except
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,12) )) 
  AND ([t].[IsActive] = 1)


select * from [auth].[UserGroupModuleRoles] where usergroupid = 7800

select * from auth.UserProfiles where username like 'BarryNabors'
select * from auth.UserProfiles where firstName like '%Ellen%' and LastName like '%Jones%'
select * from auth.UserProfiles where Designation = 'PCC' order by PasswordHash

select * from auth.UserProfiles where Designation in( 'HIS', 'AUD', 'Owner', 'PCC') order by PasswordHash
select * from auth.UserProfiles where Designation in( 'PCC') order by PasswordHash
select * from auth.UserProfiles where Designation in( 'HIS') order by PasswordHash
select * from auth.UserProfiles where Designation in( 'AUD') order by PasswordHash
select * from auth.UserProfiles where Designation in( 'Owner') order by PasswordHash


select distinct designation from auth.UserProfiles

SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (5) )) 
  AND ([t].[IsActive] = 1)
except
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,12) )) 
  AND ([t].[IsActive] = 1)



  --12889
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12579) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))


/*
# 43015

provider code | 180842
UserProfileID | 10934

select * from [auth].[UserGroupModuleRoles] where usergroupid = 7600

SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (1,11) )) 
  AND ([t].[IsActive] = 1)
except
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,12) )) 
  AND ([t].[IsActive] = 1)

SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 10934) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))



select 'provider.MemberAppointments' as TableName, * from [provider].[MemberAppointments] ma
where 1 = 1 and memberchartdataid in(
select memberchartdataid from [provider].[MemberChartData]
where memberchartid in(
select memberchartid from [provider].[MemberCharts]
where memberprofileid in (
select memberprofileid from [provider].[MemberProfiles]
where NHMemberid in (select NHMemberID from #NHMemberIDTemp )
))
 )order by 1 desc


 select top 10 * from [provider].[MemberAppointments] where HCPUserProfileID = 10934

 MemberChartDataID
697127
930739
970706


select 
-- top 1
a.MemberChartID, b.MemberChartDataID, c.MemberAppointmentID,

a.MemberChartId, a.EligibilityCheckByUser, a.EligibilityStatus, a.IsActive, a.IsChartClosed, a.MemberProfileID, a.VisitNotes, a.VisitNumber,
b.MemberChartDataId, b.DocumentID, b.IsActive, b.IsDocumentComplete, b.MajorProcessId, b.MemberChartId, b.MinorProcessId, b.ProcessData, b.UploadType, b.ProviderID, b.LocationId, b.NobleClaimNumber, b.NobleClaimDetailNumber, b.IsComplete,
c.MemberAppointmentID, c.AccompaniedBy, c.AppointmentStatus, c.AppointmentTypeID, c.Confirmed, c.EmailAddress, c.IsActive, c.IsitOverlap, c.HCPUserProfileID,

'provider.MemberCharts' as TableName, a.*,
'provider.MemberChartData' as TableName, b.*, 
'provider.MemberAppointments' as TableName, c.*

from [provider].[MemberCharts] a 
inner join [provider].[MemberChartData] b on a.memberChartId = b.memberChartId
inner join [provider].[MemberAppointments] c on c.[MemberChartDataId]=b.[MemberChartDataId]
where
b.ProviderID = 842 and
--a.MemberProfileID =  10934 and
c.memberappointmentID in (77847,112359,118855)
order by a.MemberChartID desc


select * from provider.memberprofiles where memberprofileid in (329633, 272316)

NH202005688935
NH202005445867

select * from auth.UserProfiles where UserProfileID = 10934

select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'Barry' and providercode =  '180842' or UserprofileID = 10934
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID = 10934
select UserGroupID, UserGroupName,DefaultAppModuleRoleID, IsActive, * from auth.UserGroups where UserGroupID = 7600

select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7600)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7600)
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID = 7600 and AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7600)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID = 7600


SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 10934) AND ([t1].[IsActive] = 1))
          )
      )) AND ([t].[IsActive] = 1))

SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,1) )) 
  AND ([t].[IsActive] = 1)

*/



select * from auth.UserProfiles where UserProfileID in (  12913, 10934) -- 12913 Santhosh

select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'santhosh' and providercode =  '180000' or UserProfileID in (  12913, 10934)
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID in (  12913, 10934)
select UserGroupID, UserGroupName,DefaultAppModuleRoleID, IsActive, * from auth.UserGroups where UserGroupID in ( 7800, 7600)

select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in ( 7800, 7600) )
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in ( 7800, 7600) )
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID in ( 7800, 7600)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID in ( 7800, 7600)


SELECT '1' as No,
[t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 10934) AND ([t1].[IsActive] = 1))
          )
      )) AND ([t].[IsActive] = 1)) order by appmoduleroleid

SELECT '2' as No,
[t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
      WHERE ([t].[IsActive] = 1) AND (([t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (
          SELECT [t0].[AppModuleRoleId]
          FROM [auth].[UserGroupModuleRoles] AS [t0]
          WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (
              SELECT [t1].[UserGroupId]
              FROM [auth].[UserProfileGroups] AS [t1]
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 10934) AND ([t1].[IsActive] = 1)  )
          )
      )) AND ([t].[IsActive] = 1)) order by appmoduleroleid
	 



SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (11,1) )) 
  AND ([t].[IsActive] = 1)

select
  [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t] where appmoduleRoleid in (1,5)
order by AppmoduleRoleMenuName, AppModuleRoleId

/*
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleMenuID in (50, 59)
*/

update [auth].[AppModuleRoleMenus] set Isactive = 0 where AppModuleRoleMenuID = 59

select * from auth.userprofiles where 


-- 12913 Santhosh, 11850 Wayne Wilson
-- 180000, 181666

select * from auth.UserProfiles where UserProfileID in (  12913, 11850) 

select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'santhosh' and providercode in (180000, 181666)  or UserProfileID in (  12913, 11850) 
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID in (  12913, 11850) 
select UserGroupID, UserGroupName,DefaultAppModuleRoleID, IsActive, * from auth.UserGroups where UserGroupID in ( 7800, 7600)

select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in ( 7800, 7600) )
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in ( 7800, 7600) )
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID in ( 7800, 7600)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID in ( 7800, 7600)


select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in (7600) )
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in ( 7600) )
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID in ( 7600)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID in ( 7600)



select ModuleDomain, ModuleName, IsActive,  * from auth.AppModules where AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in (7800) )
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID in (7800)  )
select UserGroupID, AppModuleID, IsActive, * from auth.UserGroupModules where UserGroupID in (7800) 
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID in (7800) 


auth.UserProfiles
auth.UserGroups
auth.UserProfileGroups

select * from auth.UserProfiles where UserProfileID = 12913
select * from auth.UserGroups where UserGroupID = 7800
select * from auth.UserProfileGroups where UserGroupID = 7800 and UserProfileID = 12913 -- Association Table


select * from auth.UserProfiles where UserProfileID = 11850
select * from auth.UserGroups where UserGroupID = 7600
select * from auth.UserProfileGroups where UserGroupID = 7600 and UserProfileID = 11850 -- Association Table

select * from auth.UserProfiles --done
select * from auth.AppModules --done
select * from auth.AppModuleRoles -- done
select * from auth.UserGroupModules --done
select * from auth.UserGroupModuleRoles -- done
select * from auth.ApplicationFeatures -- done
select * from auth.AppModuleRoleMenus -- done
select * from auth.AppModuleRoleMenuSubmenus -- done
select * from auth.AppModuleRoleMenuSubMenuFeatures --done


select 
distinct '[UserProfiles]' as TableName, IsActive, UserProfileId, Designation,UserName, FirstName,LastName,MiddleName,Gender	IsBlocked,	IsEnabled,	IsRegister,	
PasswordHash,PasswordSalt,TemproryKeyCode, LastLoginDate, DOB,Languages,IsVerified,PrimaryEmail,PrimaryPhoneNumber,ProviderCode,Title,ActivationDate,IsForcedLogout,LastLogoutDate 
from auth.UserProfiles
where IsActive = 1 and UserName like '%sballa%' and FirstName like '%Santhosh%' and LastName like '%Balla%'

select distinct '[UserGroups]' as TableName, IsActive,  UserGroupId, ApplyNumericPresedence, UserGroupName, DefaultAppModuleRoleID from auth.UserGroups
where isActive = 1 and UserGroupID = 7600

select distinct '[UserProfileGroups]' as TableName, IsActive, UserGroupID, UserProfileID from  auth.UserProfileGroups
where UserProfileID = 11850 and UserGroupID = 7600

select distinct '[AppModules]' as TableName, isActive, AppModuleID, ModuleDomain, ModuleName from auth.AppModules
where IsActive = 1 and ModuleName like '%Provider%'

select distinct '[UserGroupModules]' as TableName, IsActive, UserGroupModuleID, UserGroupID from auth.UserGroupModules
where IsActive = 1 and UserGroupID = 7600

select distinct '[AppModuleRoles]' as TableName, IsActive,  AppModuleRoleID, AppModuleId, AppModuleRoleName, HelpText from auth.AppModuleRoles
where IsActive = 1 and AppModuleRoleID in (1,11)

select distinct '[UserGroupModuleRoles]' as TableName, IsActive, UserGroupID, AppModuleRoleID from auth.UserGroupModuleRoles
where IsActive = 1 and  UserGroupID = 7600

select distinct '[ApplicationFeatures]' as TableName, IsActive, AppFeatureID, ParentFeatureID, FeatureSectionName, FeatureName, FeatureCode, IsDefault, IsSystemFeature, IsCreate, IsRead, IsUpdate,IsDelete from auth.ApplicationFeatures
where IsActive = 1 and ParentFeatureID = 

select distinct '[AppModuleRoleMenus]' as TableName, IsActive, AppModuleRoleMenuID, AppModuleRoleID, AppModuleRoleMenuName, AppModuleRoleMenuPage from auth.AppModuleRoleMenus
where IsActive = 1

select distinct '[AppModuleRoleMenuSubmenus]' as TableName, IsActive, AppModuleRoleMenuSubMenuID, AppModuleRoleMenuID, AppModuleRoleMenuSubmenuId1, AppModuleRoleMenuSubmenuName, AppModuleRoleMenuSubmenuPage from auth.AppModuleRoleMenuSubmenus
where IsActive = 1


select * from 
(

(select distinct '[UserProfiles]' as TableName, IsActive, UserProfileId, Designation,UserName, FirstName,LastName,MiddleName,Gender	IsBlocked,	IsEnabled,	IsRegister,	PasswordHash,PasswordSalt,TemproryKeyCode, LastLoginDate, DOB,Languages,IsVerified,PrimaryEmail,PrimaryPhoneNumber,ProviderCode,Title,ActivationDate,IsForcedLogout,LastLogoutDate from auth.UserProfiles
 where IsActive = 1 and UserName like '%sballa%' and FirstName like '%Santhosh%' and LastName like '%Balla%' ) 
 
(select distinct '[AppModules]' as TableName, isActive, AppModuleID, ModuleDomain, ModuleName from auth.AppModules
where IsActive = 1 and ModuleName like '%Provider%')

(select distinct '[AppModuleRoles]' as TableName, IsActive,  AppModuleRoleID, AppModuleId, AppModuleRoleName, HelpText from auth.AppModuleRoles
where IsActive = 1)

(select distinct '[UserGroupModuleRoles]' as TableName, IsActive, UserGroupID, AppModuleRoleID from auth.UserGroupModuleRoles
where IsActive = 1)

(select distinct '[ApplicationFeatures]' as TableName, IsActive, AppFeatureID, ParentFeatureID, FeatureSectionName, FeatureName, FeatureCode, IsDefault, IsSystemFeature, IsCreate, IsRead, IsUpdate,IsDelete from auth.ApplicationFeatures
where IsActive = 1)

(select distinct '[AppModuleRoleMenus]' as TableName, IsActive, AppModuleRoleMenuID, AppModuleRoleID, AppModuleRoleMenuName, AppModuleRoleMenuPage from auth.AppModuleRoleMenus
where IsActive = 1)

(select distinct '[AppModuleRoleMenuSubmenus]' as TableName, IsActive, AppModuleRoleMenuSubMenuID, AppModuleRoleMenuID, AppModuleRoleMenuSubmenuId1, AppModuleRoleMenuSubmenuName, AppModuleRoleMenuSubmenuPage from auth.AppModuleRoleMenuSubmenus
where IsActive = 1)



select * from 
(select distinct '[UserGroupModules]' as TableName, IsActive, UserGroupModuleID, AppModuleID, UserGroupID from auth.UserGroupModules
where IsActive = 1) a
join
(select distinct '[UserGroups]' as TableName, IsActive,  UserGroupId, ApplyNumericPresedence, UserGroupName, DefaultAppModuleRoleID from auth.UserGroups
where isActive = 1 
and UserGroupID = 7600
) b on a.UserGroupID = b.UserGroupID
join 
(select distinct '[AppModules]' as TableName, isActive, AppModuleID, ModuleDomain, ModuleName from auth.AppModules
where IsActive = 1 and ModuleName like '%%') c on a.AppModuleID = c.AppModuleID


select * from 

(select distinct '[AppModuleRoles]' as TableName, IsActive,  AppModuleRoleID, AppModuleId, AppModuleRoleName, HelpText from auth.AppModuleRoles
where IsActive = 1) d
join 
(select distinct '[AppModules]' as TableName, isActive, AppModuleID, ModuleDomain, ModuleName from auth.AppModules
where IsActive = 1 and ModuleName like '%%') e on d.AppModuleID = e.AppModuleID


select * from 

(select distinct '[UserGroupModuleRoles]' as TableName, IsActive, UserGroupID, AppModuleRoleID from auth.UserGroupModuleRoles
where IsActive = 1) f
join 
(select distinct '[AppModuleRoles]' as TableName, IsActive,  AppModuleRoleID, AppModuleId, AppModuleRoleName, HelpText from auth.AppModuleRoles
where IsActive = 1) g on f.AppModuleRoleID = g.AppModuleRoleID
join
(select distinct '[UserGroups]' as TableName, IsActive,  UserGroupId, ApplyNumericPresedence, UserGroupName, DefaultAppModuleRoleID from auth.UserGroups
where isActive = 1 
and UserGroupID = 7600
) h on f.UserGroupID = h.UserGroupID



select * from 
(select distinct '[AppModuleRoles]' as TableName, IsActive,  AppModuleRoleID, AppModuleId, AppModuleRoleName, HelpText from auth.AppModuleRoles
where IsActive = 1) i
join 
(select distinct '[AppModuleRoleMenus]' as TableName, IsActive, AppModuleRoleMenuID, AppModuleRoleID, AppModuleRoleMenuName, AppModuleRoleMenuPage from auth.AppModuleRoleMenus
where IsActive = 1) j on i.AppModuleRoleId = j.AppModuleRoleId
join
(select distinct '[AppModuleRoleMenuSubmenus]' as TableName, IsActive, AppModuleRoleMenuSubMenuID, AppModuleRoleMenuID,  AppModuleRoleMenuSubmenuName, AppModuleRoleMenuSubmenuPage from auth.AppModuleRoleMenuSubmenus
where IsActive = 1) k on k.AppModuleRoleMenuID = j.AppModuleRoleMenuId


--UserGroups, UserProfiles and UserProfileGroups
select * from 
(select distinct '[UserProfileGroups]' as TableName, c.IsActive, c.UserGroupID, c.UserProfileID from  auth.UserProfileGroups c where c.IsActive =1 ) a
join 
(select distinct '[UserProfiles]' as TableName, b.IsActive, b.UserProfileId, b.Designation,b.UserName, b.FirstName,b.LastName,b.MiddleName,b.Gender,b.IsBlocked,b.IsEnabled,b.IsRegister,	
b.PasswordHash,b.PasswordSalt,b.TemproryKeyCode, b.LastLoginDate,b.DOB,b.Languages,b.IsVerified,b.PrimaryEmail,b.PrimaryPhoneNumber,b.ProviderCode,b.Title,b.ActivationDate,b.IsForcedLogout,b.LastLogoutDate 
from auth.UserProfiles b
where b.IsActive = 1 and b.providercode is not null and UserProfileId = 11850 --and UserName like '%sballa%' and FirstName like '%Santhosh%' and LastName like '%Balla%' 
) b on a.UserProfileId = b.UserProfileId
join 
(select distinct '[UserGroups]' as TableName, a.IsActive,  a.UserGroupId, a.ApplyNumericPresedence, a.UserGroupName, a.DefaultAppModuleRoleID from auth.UserGroups a
where isActive = 1 and UserGroupID = 7600 ) c on a.UserGroupId = c.UserGroupId


/*
UserName	passwordHash	PasswordSalt
BarryNabors	$2a$10$XL8i0WAhyKJswZ/ONraY5.Ps.CUNQFlE0iB25q/q7UQIF3ildyp42	$2a$10$XL8i0WAhyKJswZ/ONraY5.
SBalla	$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm	$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.
*/

select * from auth.userProfiles where userprofileid in (12913, 11850)

update auth.Userprofiles set PasswordHash = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm' where UserProfileID = 11850
update auth.Userprofiles set PasswordSalt = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.' where UserProfileID = 11850

select * from auth.userprofiles



select * from [auth].[AppModuleRoles] where AppModuleRoleID = 1
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 1

declare	@UserProfileId bigint = 15631,
		@AppmoduleId int = 1

select 'PROD' as 'ENV',
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]


	--Select * from auth.UserProfiles where FirstName like '%Madison%' and isActive =1 and LastName like '%Mcgee%'
--15631 | UserProfileID
--181783 | Provider Code


--EXEC [auth].[GetUserMenusAndFeatures] 5, 1191,1


declare
	@UserProfileId bigint = 15631, 
	@ProviderId bigint = 181783, 
	@AppmoduleId bigint = 1


select * from (
select
	ROW_NUMBER() OVER(ORDER BY c.MenuId, c.SubMenuId ASC) AS RowId,@UserProfileId as 'UserProfileId', @ProviderId as 'ProviderId',c.RoleId as 'RoleId', c.RoleName as 'RoleName',
	c.MenuId,case when (@AppmoduleId = 4 and c.MenuName = 'Today''s Appointments') then 'Home' else c.MenuName end as MenuName,c.MenuPage,cast(c.MenuIcon as varchar) as MenuIcon,c.SubMenuId,c.SubMenuName,c.SubMenuPage,cast(c.SubMenuIcon as varchar) as SubMenuIcon
	,af.[AppFeatureId], af.[FeatureSectionName], af.[FeatureName], af.[FeatureCode], af.[IsSystemFeature]
	,cast((case puf.[IsCreate] when 0 then 0 else (case when af.[IsCreate]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsCreate'
	,cast((case puf.[IsRead] when 0 then 0 else (case when af.[IsRead]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsRead'
	,cast((case puf.[IsUpdate] when 0 then 0 else (case when af.[IsUpdate]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsUpdate'
	,cast((case puf.[IsDelete] when 0 then 0 else (case when af.[IsDelete]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsDelete'
	from (
	select
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]
	) c

	left outer join [auth].[AppModuleRoleMenuSubMenuFeatures] pfmap on pfmap.[AppModuleRoleMenuId]=c.MenuId and (pfmap.[AppModuleRoleMenuSubMenuId]=c.SubMenuId or c.SubMenuId is null)
	left outer join [auth].[ApplicationFeatures] af on af.[FeatureCode] = pfmap.[AppFeatureCode]
	left outer join [auth].[ProviderUserFeatures] puf on puf.[AppFeatureCode]=af.[FeatureCode] and puf.[UserProfileId]=@UserProfileId and puf.[ProviderID]=@ProviderId
where not exists (select * from [auth].[ProviderFeatures] pf where pf.[AppFeatureCode]=af.[FeatureCode] and pf.[ProviderId]=@ProviderId and pf.[IsActive]=1)
)a where (a.IsCreate <> 0 or a.IsRead <> 0 or a.IsUpdate <> 0) or a.MenuName = 'Today''s Appointments' or a.MenuName = 'Home' or a.SubMenuName = 'Engagement' or a.MenuName = 'Documents Library' or a.MenuName = 'Provider Network'
ORDER BY
(CASE WHEN a.MenuName = 'Home' THEN 0 ELSE 1 END)



declare	@UserProfileId bigint = 15631,
		@AppmoduleId int = 1

select 'STG' as 'ENV',
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]

select * from [auth].[AppModuleRoles] where AppModuleRoleID = 12
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 12

insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, '0x66612D66696C652D746578742D6F', 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')



