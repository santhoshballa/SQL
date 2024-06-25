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

select * from [auth].[AppModuleRoles] where AppModuleRoleID = 12
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 12

insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, '0x66612D66696C652D746578742D6F', 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')

select * from auth.AppModules where isActive = 1 and ModuleName = 'Provider Portal' -- appmoduleid = 1
select * from auth.AppModuleRoles where isActive =1 and appModuleid = 1 and AppModuleRoleName = 'Provider HCP'  -- AppModuleRoleid = 1 for 'Provider HCP' Various roles in the app module
select * from auth.AppModuleRoleMenus where isActive =1 and AppModuleRoleID = 1

select * from [auth].[UserGroupModuleRoles] where AppModuleRoleID = 1 -- done

select * from auth.UserProfileGroups where UserProfileID = 15631 and UsergroupID = 7200 --done
select * from auth.UserProfiles where UserProfileID = 15631  -- ProviderCode 181783 - done
select * from auth.UserGroups where userGroupid = 7200 --done

select * from auth.AppModules where isActive = 1 and ModuleName = 'Provider Portal' -- appmoduleid = 1 --done
select * from auth.AppModuleRoles where isActive =1 and appModuleid = 1 and AppModuleRoleName = 'Provider HCP'  -- AppModuleRoleid = 1 for 'Provider HCP' Various roles in the app module --done
select * from auth.AppModuleRoleMenus where isActive =1 and AppModuleRoleID = 1 -- done


select * from [auth].[AppModuleRoleMenuSubmenus] where AppModuleRoleMenuSubmenuName like '%Document%'


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [auth].[AppModuleRoleMenus](
	[AppModuleRoleMenuId] [bigint] IDENTITY(1,1) NOT NULL,
	[AppModuleRoleId] [bigint] NOT NULL,
	[AppModuleRoleMenuIconImage] [varbinary](max) NULL,
	[AppModuleRoleMenuName] [nvarchar](50) NULL,
	[AppModuleRoleMenuPage] [nvarchar](50) NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateUser] [nvarchar](150) NULL,
	[IsActive] [bit] NOT NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyUser] [nvarchar](150) NULL,
 CONSTRAINT [PK_AppModuleRoleMenus] PRIMARY KEY CLUSTERED 
(
	[AppModuleRoleMenuId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


declare @AppModuleRoleMenuIconImage nvarchar(500)
set @AppModuleRoleMenuIconImage = convert(VARBINARY(500), '0x66612D66696C652D746578742D6F', 1);


insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, @AppModuleRoleMenuIconImage , 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')

---- This is the record that was inserted into the AppModuleRoleMenus table for the Document Library to show up on the front end
insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, convert(VARBINARY(500), '0x66612D66696C652D746578742D6F', 1) , 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')


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

select * from [auth].[AppModuleRoles] where AppModuleRoleID = 1
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 1


select * from [auth].[AppModuleRoleMenus] order by AppModuleRoleMenuName



declare @AppModuleID int = 2

select * from auth.AppModules where AppModuleID = @AppModuleID
select * from auth.AppModuleRoles where AppModuleID in (select AppModuleID from auth.AppModules where AppModuleID = @AppModuleID )
select * from auth.AppModuleRoleMenus where AppModuleRoleID in (select AppModuleRoleID from auth.AppModuleRoles where AppModuleID in (select AppModuleID from auth.AppModules where AppModuleID = @AppModuleID )) order by AppModuleRoleMenuName
select * from auth.AppModuleRoleMenuSubmenus where AppModuleRoleMenuID in  (select AppModuleRoleMenuID from auth.AppModuleRoleMenus where AppModuleRoleID in (select AppModuleRoleID from auth.AppModuleRoles where AppModuleID in (select AppModuleID from auth.AppModules where AppModuleID = @AppModuleID )))

select * from auth.UserGroupModuleRoles where UserGroupID in ( Select UserGroupID from auth.UserGroups where UserGroupID = 7800) 
and AppModuleRoleID in (select AppModuleRoleID from auth.AppModuleRoles where AppModuleID in (select AppModuleID from auth.AppModules where AppModuleID = @AppModuleID ))


select * from auth.UserProfiles where firstname like '%Bianca%' --11418
select * from auth.UserProfiles where firstname like '%Kenesha%' --11342
select * from auth.UserProfiles where firstname like '%Jitender%' -- (10985, 14362)
select * from auth.UserProfiles where firstname like '%santhosh%' -- 12913

select * from auth.UserProfileGroups where UserProfileid in ( 11342, 11418 )
select * from auth.UserGroups where UserGroupID in (select UserGroupID from auth.UserProfileGroups where UserProfileid in ( 11342, 11418 ))


select * from auth.UserProfileGroups where UserProfileid in (10985, 14362)
select * from auth.UserGroups where UserGroupID in (select UserGroupID from auth.UserProfileGroups where UserProfileid in (10985, 14362))
