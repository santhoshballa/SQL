select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('auth')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and TABLE_NAME in 
('ApplicationFeatures','AppModuleRoleMenus','AppModuleRoleMenuSubMenuFeatures','AppModuleRoleMenuSubmenus','AppModuleRoles','AppModules','ParentApplicationFeatures','ProviderFeatures','ProviderUserFeatures')


declare @SearchPredicate nvarchar(50)
set @SearchPredicate = 'NH202106684854'

select
'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar)))' + ' like '+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('auth')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and TABLE_NAME in 
('ApplicationFeatures','AppModuleRoleMenus','AppModuleRoleMenuSubMenuFeatures','AppModuleRoleMenuSubmenus','AppModuleRoles','AppModules','ParentApplicationFeatures','ProviderFeatures','ProviderUserFeatures')


select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'AppFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureId] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'ParentFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureId] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureSectionName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureSectionName] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureName] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureCode] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDefault] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsSystemFeature|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSystemFeature] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsCreate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCreate] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsRead|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsRead] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsUpdate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsUpdate] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsDelete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDelete] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuPage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuPage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppModuleRoleMenuSubMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuId1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId1] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuPage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuPage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'HelpText|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HelpText] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'AppModuleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleId] as nvarchar))),'"') as VALUE from auth.[AppModules]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModules]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleDomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleDomain] as nvarchar))),'"') as VALUE from auth.[AppModules]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleIconImage] as nvarchar))),'"') as VALUE from auth.[AppModules]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleName] as nvarchar))),'"') as VALUE from auth.[AppModules]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureId] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureSectionName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureSectionName] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureName] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureCode] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'OwnerDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OwnerDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'HCPDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'UserDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'ProviderFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderFeatureId] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'IsExclude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsExclude] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'ProviderUserFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderUserFeatureId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'UserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsCreate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCreate] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsRead|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsRead] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsUpdate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsUpdate] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsDelete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDelete] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures]) a



select 'ParentApplicationFeatures' as TableName, count(*) as RecordCount from auth.ParentApplicationFeatures union
select 'ApplicationFeatures' as TableName, count(*) as RecordCount from auth.ApplicationFeatures union
select 'AppModuleRoleMenus' as TableName, count(*) as RecordCount from auth.AppModuleRoleMenus union
select 'AppModuleRoleMenuSubMenuFeatures' as TableName, count(*) as RecordCount from auth.AppModuleRoleMenuSubMenuFeatures union
select 'AppModuleRoleMenuSubmenus' as TableName, count(*) as RecordCount from auth.AppModuleRoleMenuSubmenus union
select 'AppModuleRoles' as TableName, count(*) as RecordCount from auth.AppModuleRoles union
select 'AppModules' as TableName, count(*) as RecordCount from auth.AppModules union
select 'ProviderFeatures' as TableName, count(*) as RecordCount from auth.ProviderFeatures union
select 'ProviderUserFeatures' as TableName, count(*) as RecordCount from auth.ProviderUserFeatures


select top 10 *, '1 ParentApplicationFeatures' as TableName from auth.ParentApplicationFeatures order by ParentFeatureSectionName, ParentFeatureName
select top 10 *, '2 ApplicationFeatures' as TableName from auth.ApplicationFeatures

select top 10 *, 'ProviderFeatures' as TableName from auth.ProviderFeatures
select top 10 *, 'ProviderUserFeatures' as TableName from auth.ProviderUserFeatures

select top 10 *, '1 AppModules' as TableName from auth.AppModules order by moduleName, isActive --Contains ModuleDomains (Important : Not Important)
select top 10 *, '2 AppModuleRoles' as TableName from auth.AppModuleRoles -- Contains a Image for the application
select top 10 *, '3 AppModuleRoleMenus' as TableName from auth.AppModuleRoleMenus 
select top 10 *, '4 AppModuleRoleMenuSubmenus' as TableName from auth.AppModuleRoleMenuSubmenus
select top 10 *, '3 4 Association AppModuleRoleMenuSubMenuFeatures' as TableName from auth.AppModuleRoleMenuSubMenuFeatures

select 
a.AppModuleID, a.ModuleDomain, a.ModuleName,  a.IsActive,
b.AppModuleRoleID, b.AppModuleRoleName, b.IsActive,
c.AppModuleRoleMenuID, c.AppModuleRoleMenuName, c.AppModuleRoleMenuPage, c.IsActive,
d.AppModuleRoleMenuSubmenuID, d.AppModuleRoleMenuSubmenuName, d.AppModuleRoleMenuSubMenuPage, d.IsActive
--e.AppModuleRoleMenuID, e.AppFeatureCode

from auth.AppModules a 
left join auth.AppModuleRoles b on (a.AppModuleId = b.AppModuleRoleID)
left join auth.AppModuleRoleMenus c on (b.AppModuleRoleId = c.AppModuleRoleId)
left join auth.AppModuleRoleMenuSubmenus d on (c.AppModuleRoleMenuId = d.AppModuleRoleMenuId)
where AppModuleRoleMenuName like '%Documents Library%'
order by a.AppModuleID 


-- auth.ParentApplicationFeatures
select *, 'ParentApplicationFeatures' as TableName from auth.ParentApplicationFeatures  -- or parentFeatureSectionName like '%Member Details%'  order by ParentFeatureSectionName
select *, 'ApplicationFeatures' as TableName  from auth.applicationFeatures

select --a.*, b.*
a.appFeatureID, a.FeatureSectionName, a.FeatureName, a.FeatureCode, a.isDefault, a.IsSystemFeature, a.IsCreate, a.IsUpdate, a.IsDelete, a.isActive,
b.ParentFeatureSectionName, b.ParentFeatureName, b.ParentFeatureCode, b.OwnerDefault, b.HCPDefault, b.userDefault, b.IsActive
from auth.applicationFeatures a left join auth.ParentApplicationFeatures b on (a.ParentFeatureId = b.ParentFeatureId)



select *, 'AppModuleRoleMenuSubMenuFeatures' as TableName from auth.AppModuleRoleMenuSubMenuFeatures

select a.*,b.*,c.*,
b.AppModuleRoleId, a.AppModuleRoleMenuSubmenuID

from auth.AppModuleRoleMenuSubMenuFeatures a 
full outer join auth.AppModuleRoleMenus b on (a.AppModuleRoleMenuID = b.AppModuleRoleMenuID)
full outer join auth.AppModuleRoleMenuSubmenus c on (a.AppModuleRoleMenuSubMenuID = c.AppModuleRoleMenuSubMenuID)
where 1=1
--and b.AppModuleRoleId is null
and c.AppModuleRoleMenuSubMenuID is null



select *, '1 AppModules' as TableName from auth.AppModules order by moduleName, isActive --Contains ModuleDomains (Important : Not Important)
select *, '2 AppModuleRoles' as TableName from auth.AppModuleRoles -- Contains a Image for the application
select *, '3 AppModuleRoleMenus' as TableName from auth.AppModuleRoleMenus 
select *, '4 AppModuleRoleMenuSubmenus' as TableName from auth.AppModuleRoleMenuSubmenus
select *, '5 AppModuleRoleMenuSubMenuFeatures' as TableName from auth.AppModuleRoleMenuSubMenuFeatures


select * from information_schema.columns where column_name like '%features%'
select top 10 * from auth.UserProfiles where FirstName like '%Ellen%' and lastname like '%Jones%'
--12889 | UserProfileID
--180450 | ProviderCode, 0450 ProviderID
select top 10 * from auth.UserProfileSecretAnswers where UserprofileID in ( 5, 3195)



declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '%180450%'

select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'AppFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureId] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([AppFeatureId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'ParentFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureId] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([ParentFeatureId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureSectionName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureSectionName] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([FeatureSectionName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureName] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([FeatureName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'FeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureCode] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([FeatureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDefault] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsDefault] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsSystemFeature|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSystemFeature] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsSystemFeature] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsCreate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCreate] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsCreate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsRead|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsRead] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsRead] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsUpdate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsUpdate] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsUpdate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsDelete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDelete] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsDelete] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ApplicationFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ApplicationFeatures] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([AppModuleRoleMenuIconImage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([AppModuleRoleMenuName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'AppModuleRoleMenuPage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuPage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([AppModuleRoleMenuPage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenus|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenus] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures] where ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppModuleRoleMenuSubMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures] where ltrim(rtrim(cast([AppModuleRoleMenuSubMenuId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubMenuFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubMenuFeatures] where ltrim(rtrim(cast([AppFeatureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuSubmenuIconImage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuId1|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId1] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuSubmenuId1] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuSubmenuName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'AppModuleRoleMenuSubmenuPage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleMenuSubmenuPage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([AppModuleRoleMenuSubmenuPage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoleMenuSubmenus|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoleMenuSubmenus] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([AppModuleRoleId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleId] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([AppModuleId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleIconImage] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([AppModuleRoleIconImage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'AppModuleRoleName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleRoleName] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([AppModuleRoleName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'HelpText|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HelpText] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([HelpText] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModuleRoles|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModuleRoles] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'AppModuleId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppModuleId] as nvarchar))),'"') as VALUE from auth.[AppModules] where ltrim(rtrim(cast([AppModuleId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[AppModules] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleDomain|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleDomain] as nvarchar))),'"') as VALUE from auth.[AppModules] where ltrim(rtrim(cast([ModuleDomain] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleIconImage|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleIconImage] as nvarchar))),'"') as VALUE from auth.[AppModules] where ltrim(rtrim(cast([ModuleIconImage] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'AppModules|' as TABLE_NAME,'ModuleName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModuleName] as nvarchar))),'"') as VALUE from auth.[AppModules] where ltrim(rtrim(cast([ModuleName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureId] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([ParentFeatureId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureSectionName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureSectionName] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([ParentFeatureSectionName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureName] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([ParentFeatureName] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'ParentFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ParentFeatureCode] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([ParentFeatureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'OwnerDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OwnerDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([OwnerDefault] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'HCPDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([HCPDefault] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'UserDefault|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserDefault] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([UserDefault] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ParentApplicationFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ParentApplicationFeatures] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'ProviderFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderFeatureId] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([ProviderFeatureId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([AppFeatureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([ProviderId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'IsExclude|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsExclude] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([IsExclude] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'ProviderUserFeatureId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderUserFeatureId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([ProviderUserFeatureId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([ProviderId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'AppFeatureCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AppFeatureCode] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([AppFeatureCode] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'UserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([UserProfileId] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsCreate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCreate] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([IsCreate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsRead|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsRead] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([IsRead] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsUpdate|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsUpdate] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([IsUpdate] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsDelete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDelete] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([IsDelete] as nvarchar))) like @SearchPredicate) a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a




declare @SearchPredicate nvarchar(50)
set @SearchPredicate = '180450'
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderFeatures] where ltrim(rtrim(cast([ProviderId] as nvarchar))) like '%180450%') a union 
select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'ProviderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where ltrim(rtrim(cast([ProviderId] as nvarchar))) like '%180450%') a

select ProviderID, QUOTENAME(ltrim(rtrim(cast([ProviderId] as nvarchar))),'"') as VALUE from auth.ProviderFeatures where ltrim(rtrim(cast([ProviderId] as nvarchar))) like '%180450%'

select top 40 * from  (select distinct  'auth|' as TABLE_SCHEMA,'ProviderUserFeatures|' as TABLE_NAME,'UserProfileId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UserProfileId] as nvarchar))),'"') as VALUE from auth.[ProviderUserFeatures] where UserProfileId like '12889' ) a union 

select distinct UserProfileId from auth.[ProviderUserFeatures]
select * from auth.UserProfiles where UserProfileID in (26,4346,5994)


select ProviderCode, count(*) as RecordCount from auth.UserProfiles where providerCode = '180450' group by ProviderCode order by  2 desc
select * from auth.UserProfiles where providerCode = '180450' or firstname like 'Santhosh'

