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


select top 10 * from auth.UserProfiles where firstName like 'Santhosh' and providercode =  '180000' or UserprofileID = 12913
select top 10 * from auth.UserProfileGroups where UserProfileID = 12913

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




select UserProfileID, FirstName, LastName, IsActive, ProviderCode from auth.UserProfiles where firstName like 'Ellen'  and UserprofileID = 12889 --or providercode =  '180000'
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserProfileID = 12889
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
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 12913) AND ([t1].[IsActive] = 1))
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
              WHERE ([t1].[IsActive] = 1) AND (([t1].[UserProfileId] = 12889) AND ([t1].[IsActive] = 1))
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

--12889
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12889) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))


select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7800)
select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where  AppModuleID in (select AppModuleID from auth.UserGroupModules where UserGroupID = 7200)
--select * from auth.AppModuleRoleMenus

select AppModuleRoleName, HelpText, IsActive,* from auth.AppModuleRoles where AppModuleRoleID in (1,2,5)



SELECT [t1].[UserGroupId] FROM [auth].[UserProfileGroups] AS [t1] WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 12913) AND ([t1].[IsActive] = 1) ) -- find the UserGroupID using ProfileID
SELECT [t0].[AppModuleRoleId] FROM [auth].[UserGroupModuleRoles] AS [t0] WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN (7800)
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (3,5,7,11,8,15,4) )) 
  AND ([t].[IsActive] = 1)


SELECT [t1].[UserGroupId] FROM [auth].[UserProfileGroups] AS [t1] WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] = 13855) AND ([t1].[IsActive] = 1) ) -- find the UserGroupID using ProfileID
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



/*Ticket # 82283 | provider does not document library and spave to upload documents

select UserProfileID, Designation, UserName, firstName, LastName, IsActive, IsBlocked, IsEnabled, * from auth.UserProfiles where firstName like 'Amanda'  and lastname like 'V%'
select UserProfileID, FirstName, LastName, IsActive, ProviderCode, * from auth.UserProfiles where firstName like 'Amanda'  and lastname like 'V%' and UserprofileID in ( 13855,9470)   --or providercode =  '180000'
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserprofileID in ( 13855)
select UserProfileID, UserGroupID, IsActive, * from auth.UserProfileGroups where UserprofileID in (9470)
select UserGroupID, AppModuleRoleID, IsActive,* from auth.UserGroupModuleRoles where UserGroupID in ( 7200, 7600)



--13855
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] in  (13855)) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))



--9470
SELECT [t].[AppModuleRoleMenuId], [t].[AppModuleRoleId], [t].[AppModuleRoleMenuIconImage], [t].[AppModuleRoleMenuName], [t].[AppModuleRoleMenuPage], [t].[CreateDate], [t].[CreateUser], [t].[IsActive], [t].[ModifyDate], [t].[ModifyUser]
FROM [auth].[AppModuleRoleMenus] AS [t]
WHERE ([t].[IsActive] = 1) AND (
								 ( [t].[AppModuleRoleMenuName] NOT IN (N'', N'string') AND [t].[AppModuleRoleId] IN (  SELECT [t0].[AppModuleRoleId]
																													   FROM [auth].[UserGroupModuleRoles] AS [t0]
																													   WHERE ([t0].[IsActive] = 1) AND [t0].[UserGroupId] IN ( SELECT [t1].[UserGroupId]
																																											   FROM [auth].[UserProfileGroups] AS [t1]
																																											   WHERE ([t1].[IsActive] = 1) AND ( ([t1].[UserProfileId] in  (9470)) AND ([t1].[IsActive] = 1) )
																													)
							  )
	 ) AND ([t].[IsActive] = 1))


*/

select * from  auth.AppModuleRoleMenus where AppModuleRoleID = 1