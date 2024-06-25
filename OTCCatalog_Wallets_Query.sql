select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where 1=1 and 
TABLE_SCHEMA in ('otccatalog' )
--(TABLE_NAME IN 
--('Itemtypes','ItemMaster','ItemAttributes','ItemAttributeOptions','NationsIds','PlanItemsConfig','OrderStatusType','OrdersHistory','Orders','OrderItems','DocumentTransaction')  OR 
--TABLE_NAME IN ('InsuranceCarriers','InsuranceHealthPlans') )
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')


-- Catalog
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'AttributeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeName] as nvarchar))),'"') as VALUE from catalog.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'AttributeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeCode] as nvarchar))),'"') as VALUE from catalog.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'CustomerNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustomerNumber] as nvarchar))),'"') as VALUE from catalog.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'MODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'MODELNAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELNAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'BRANDCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'FAMILYCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAMILYCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'TECHCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TECHCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'STYLECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([STYLECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'UNITPRICE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UNITPRICE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'PAIRPRICE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PAIRPRICE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'MODELSHORTDESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELSHORTDESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'MODELLONGDESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELLONGDESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'VENDORMODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VENDORMODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'ITEMTYPECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEMTYPECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp_20210722' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp_20210722]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'ModelAttributeValueID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValueID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'AttributeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'Itemcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Itemcode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'ModelAttributeValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValue] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'VendorCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'Modifier' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'ModelAttributeValueDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValueDescription] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues' as TABLE_NAME,'ERPREFID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ERPREFID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronReferencesTemp' as TABLE_NAME,'type' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([type] as nvarchar))),'"') as VALUE from catalog.[UnitronReferencesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronReferencesTemp' as TABLE_NAME,'target' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([target] as nvarchar))),'"') as VALUE from catalog.[UnitronReferencesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'BrandFamilyID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyID] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'BrandFamilyName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyName] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilies' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[BrandFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilyRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[BrandFamilyRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilyRules' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[BrandFamilyRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilyRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[BrandFamilyRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilyRules' as TABLE_NAME,'EarmoldTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeCode] as nvarchar))),'"') as VALUE from catalog.[BrandFamilyRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandFamilyRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[BrandFamilyRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandID] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandName] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandEmail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandEmail] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandAddress1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandAddress1] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandAddress2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandAddress2] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandCity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCity] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandZipCode] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'BrandState' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandState] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'POEDIConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([POEDIConfig] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'InvXlsConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvXlsConfig] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Brands' as TABLE_NAME,'NHCustomerBillingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHCustomerBillingNumber] as nvarchar))),'"') as VALUE from catalog.[Brands]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypeRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypeRules' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypeRules' as TABLE_NAME,'EarmoldTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeCode] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypeRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NobleDirectItemMaster' as TABLE_NAME,'ITEM_ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEM_ID] as nvarchar))),'"') as VALUE from catalog.[NobleDirectItemMaster]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NobleDirectItemMaster' as TABLE_NAME,'HCPCS_CODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HCPCS_CODE] as nvarchar))),'"') as VALUE from catalog.[NobleDirectItemMaster]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NobleDirectItemMaster' as TABLE_NAME,'ITEM_DESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEM_DESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[NobleDirectItemMaster]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NobleDirectItemMaster' as TABLE_NAME,'ITEM_PRICE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEM_PRICE] as nvarchar))),'"') as VALUE from catalog.[NobleDirectItemMaster]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandPaymentTerms' as TABLE_NAME,'BrandPaymentTermId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandPaymentTermId] as nvarchar))),'"') as VALUE from catalog.[BrandPaymentTerms]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandPaymentTerms' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[BrandPaymentTerms]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandPaymentTerms' as TABLE_NAME,'Term' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Term] as nvarchar))),'"') as VALUE from catalog.[BrandPaymentTerms]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandPaymentTerms' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[BrandPaymentTerms]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandPaymentTerms' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[BrandPaymentTerms]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_Staging' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'EarmoldTypeID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeID] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'EarmoldTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeCode] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'EarmoldTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeName] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'EarMoldTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[EarMoldTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'AttributeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'Itemcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Itemcode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'ModelAttributeValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValue] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'VendorCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'Modifier' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_Staging' as TABLE_NAME,'ModelAttributeValueDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValueDescription] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_Staging]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributesTemp' as TABLE_NAME,'ATTRIBUTEID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ATTRIBUTEID] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributesTemp' as TABLE_NAME,'ATTRIBUTENAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ATTRIBUTENAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributesTemp' as TABLE_NAME,'ATTRIBUTECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ATTRIBUTECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProductRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[FamilyProductRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProductRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[FamilyProductRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProductRules' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[FamilyProductRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProductRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[FamilyProductRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProductRules' as TABLE_NAME,'TechnologyLevelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from catalog.[FamilyProductRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'MODELATTRIBUTEVALUEID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELATTRIBUTEVALUEID] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'ATTRIBUTECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ATTRIBUTECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'MODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'MODELATTRIBUTREVALUE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELATTRIBUTREVALUE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'VENDORMODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VENDORMODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyAttributeValuesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyAttributeValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyBrandsTemp' as TABLE_NAME,'BRANDCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyBrandsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyBrandsTemp' as TABLE_NAME,'BRANDNAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDNAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyBrandsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyBrandsTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyBrandsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyBrandsTemp' as TABLE_NAME,'BRANDIMAGEURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDIMAGEURL] as nvarchar))),'"') as VALUE from catalog.[StarKeyBrandsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyBrandsTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyBrandsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'FamilyProductID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductID] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'FamilyProductName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductName] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FamilyProducts' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[FamilyProducts]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyFamiliesTemp' as TABLE_NAME,'FAMILYCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAMILYCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyFamiliesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyFamiliesTemp' as TABLE_NAME,'FAMILYNAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAMILYNAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyFamiliesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyFamiliesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyFamiliesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyFamiliesTemp' as TABLE_NAME,'BRANDCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyFamiliesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyFamiliesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyFamiliesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyItemTypesTemp' as TABLE_NAME,'ITEMTYPECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEMTYPECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyItemTypesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyItemTypesTemp' as TABLE_NAME,'ITEMTYPENAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEMTYPENAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyItemTypesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyItemTypesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyItemTypesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyItemTypesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyItemTypesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'FeatureID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureID] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'FeatureCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureCode] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'FeatureName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureName] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'StyleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleID] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Features' as TABLE_NAME,'ValueType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ValueType] as nvarchar))),'"') as VALUE from catalog.[Features]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'MODELCONTENTID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELCONTENTID] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'MODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'CONTENTTYPE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CONTENTTYPE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'CONTENTFILENAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CONTENTFILENAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'CONTENTDESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CONTENTDESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelContentTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelContentTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'SalesTaxID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesTaxID] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'StateName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StateName] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'IsSalesTaxPresentinInvoice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsSalesTaxPresentinInvoice] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'SalesTaxPercentage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SalesTaxPercentage] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandSalesTax' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[BrandSalesTax]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'MODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'MODELNAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELNAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'BRANDCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'FAMILYCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAMILYCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'TECHCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TECHCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'STYLECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([STYLECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'UNITPRICE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UNITPRICE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'PAIRPRICE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PAIRPRICE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'MODELSHORTDESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELSHORTDESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'MODELLONGDESCRIPTION' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MODELLONGDESCRIPTION] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'VENDORMODELCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VENDORMODELCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'ITEMTYPECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ITEMTYPECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyModelsTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyModelsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'ActiveFlag' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ActiveFlag] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'Coupling' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Coupling] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'EarmoldTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'FeatureValueID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureValueID] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'Material' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Material] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'PowerLevel' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PowerLevel] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'ProductModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'ProductTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'PushButton' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PushButton] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'SendReceiver' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SendReceiver] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'ShellCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'TechnologyLevelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValueRules' as TABLE_NAME,'TeleCoil' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TeleCoil] as nvarchar))),'"') as VALUE from catalog.[FeatureValueRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyStylesTemp' as TABLE_NAME,'STYLECODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([STYLECODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyStylesTemp' as TABLE_NAME,'STYLENAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([STYLENAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyStylesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyStylesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'TECHCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TECHCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'TECHNAME' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TECHNAME] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'BRANDCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BRANDCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'FAMILYCODE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FAMILYCODE] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'StarKeyTechnologiesTemp' as TABLE_NAME,'CUSTOMER_NUMBER' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CUSTOMER_NUMBER] as nvarchar))),'"') as VALUE from catalog.[StarKeyTechnologiesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'FeatureValueID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureValueID] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'FeatureID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureID] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'FeatureName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureName] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'FeatureValueCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureValueCode] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'FeatureValueName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FeatureValueName] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FeatureValues' as TABLE_NAME,'IsDefault' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDefault] as nvarchar))),'"') as VALUE from catalog.[FeatureValues]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ManufacturerItemCodes' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ManufacturerItemCodes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ManufacturerItemCodes' as TABLE_NAME,'NHItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHItemCode] as nvarchar))),'"') as VALUE from catalog.[ManufacturerItemCodes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ManufacturerItemCodes' as TABLE_NAME,'MFGItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MFGItemCode] as nvarchar))),'"') as VALUE from catalog.[ManufacturerItemCodes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandShippingFees' as TABLE_NAME,'ShippingFeeID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingFeeID] as nvarchar))),'"') as VALUE from catalog.[BrandShippingFees]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandShippingFees' as TABLE_NAME,'ISACTIVE' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ISACTIVE] as nvarchar))),'"') as VALUE from catalog.[BrandShippingFees]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandShippingFees' as TABLE_NAME,'ShippingFeeStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingFeeStatus] as nvarchar))),'"') as VALUE from catalog.[BrandShippingFees]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandShippingFees' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[BrandShippingFees]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'BrandShippingFees' as TABLE_NAME,'ShippingAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingAmount] as nvarchar))),'"') as VALUE from catalog.[BrandShippingFees]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'EarmoldTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldTypeCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'ProductModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'ProductTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'ShellCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'StyleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleID] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModelRules' as TABLE_NAME,'TechnologyLevelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from catalog.[ProductModelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'ProductModelID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelID] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'ProductModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'ProductModelName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelName] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductModels' as TABLE_NAME,'StyleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleID] as nvarchar))),'"') as VALUE from catalog.[ProductModels]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Brand' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Brand] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Family' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Family] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Technology' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Technology] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Model' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Style' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Style] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'Colors' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Colors] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'BatterySizes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BatterySizes] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'ReceiverSizes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverSizes] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'ReceiverPowers' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverPowers] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewModelList' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[viewModelList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypeRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[ProductTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypeRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[ProductTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypeRules' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[ProductTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypeRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ProductTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypeRules' as TABLE_NAME,'ProductTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeCode] as nvarchar))),'"') as VALUE from catalog.[ProductTypeRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'ProductTypeID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeID] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'ProductTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeCode] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ProductTypes' as TABLE_NAME,'ProductTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeName] as nvarchar))),'"') as VALUE from catalog.[ProductTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ShellRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[ShellRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ShellRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[ShellRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ShellRules' as TABLE_NAME,'FamilyProductCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyProductCode] as nvarchar))),'"') as VALUE from catalog.[ShellRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ShellRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ShellRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ShellRules' as TABLE_NAME,'ShellCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellCode] as nvarchar))),'"') as VALUE from catalog.[ShellRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'ShellID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellID] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'ShellCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellCode] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Shells' as TABLE_NAME,'ShellName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShellName] as nvarchar))),'"') as VALUE from catalog.[Shells]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_Temp_Phonak_SD' as TABLE_NAME,'ItemPriceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemPriceID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_Temp_Phonak_SD]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_Temp_Phonak_SD' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_Temp_Phonak_SD]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_Temp_Phonak_SD' as TABLE_NAME,'PriceType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_Temp_Phonak_SD]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_Temp_Phonak_SD' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_Temp_Phonak_SD]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'DomainID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DomainID] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'AllowOrder' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AllowOrder] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'AllowPayments' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AllowPayments] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'CatalogType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CatalogType] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'Default' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Default] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'Domain' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Domain] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'InsuranceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceID] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'InsurancePlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsurancePlanID] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'NHMemberNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberNumber] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'NHPrice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHPrice] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'ShowBenfits' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShowBenfits] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'SiteRules' as TABLE_NAME,'ShowManufacturePrice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShowManufacturePrice] as nvarchar))),'"') as VALUE from catalog.[SiteRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Styles' as TABLE_NAME,'StyleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleID] as nvarchar))),'"') as VALUE from catalog.[Styles]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Styles' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[Styles]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Styles' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[Styles]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'Styles' as TABLE_NAME,'StyleName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleName] as nvarchar))),'"') as VALUE from catalog.[Styles]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NationsId_UPC_Map' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[NationsId_UPC_Map]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NationsId_UPC_Map' as TABLE_NAME,'NHId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHId] as nvarchar))),'"') as VALUE from catalog.[NationsId_UPC_Map]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'NationsId_UPC_Map' as TABLE_NAME,'Upc' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Upc] as nvarchar))),'"') as VALUE from catalog.[NationsId_UPC_Map]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TableNameMappings' as TABLE_NAME,'TableNameMappingID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TableNameMappingID] as nvarchar))),'"') as VALUE from catalog.[TableNameMappings]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TableNameMappings' as TABLE_NAME,'DBTableName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DBTableName] as nvarchar))),'"') as VALUE from catalog.[TableNameMappings]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TableNameMappings' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[TableNameMappings]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TableNameMappings' as TABLE_NAME,'XMLTableName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([XMLTableName] as nvarchar))),'"') as VALUE from catalog.[TableNameMappings]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Manufacturer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Manufacturer] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Family' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Family] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Style' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Style] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Technology' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Technology] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Model' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'BatterySize' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BatterySize] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'ReceiverSize' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverSize] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'ReceiverPower' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverPower] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Colors' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Colors] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'OtherProductsRules' as TABLE_NAME,'Catergory' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Catergory] as nvarchar))),'"') as VALUE from catalog.[OtherProductsRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'TechnologyLevelID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelID] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'TechnologyLevelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'ImageURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ImageURL] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevel' as TABLE_NAME,'TechnologyLevelName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelName] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevel]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Manufacturer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Manufacturer] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Family ' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Family ] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Style' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Style] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Technology' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Technology] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Model' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Model] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Battery Size' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Battery Size] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Slimtube' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Slimtube] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'Color' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Color] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'CROSData' as TABLE_NAME,'CROS Compatible Families' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CROS Compatible Families] as nvarchar))),'"') as VALUE from catalog.[CROSData]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevelRules' as TABLE_NAME,'RuleID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RuleID] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevelRules' as TABLE_NAME,'BrandFamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandFamilyCode] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevelRules' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevelRules' as TABLE_NAME,'ProductTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductTypeCode] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'TechnologyLevelRules' as TABLE_NAME,'TechnologyLevelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from catalog.[TechnologyLevelRules]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList' as TABLE_NAME,'ItemPriceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemPriceID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList' as TABLE_NAME,'PriceType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList' as TABLE_NAME,'PriceVersion' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceVersion] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewItemList' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[viewItemList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'viewItemList' as TABLE_NAME,'ItemDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDescription] as nvarchar))),'"') as VALUE from catalog.[viewItemList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'ItemID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_bkp_20190806_COGS_Update' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_BM_BAK' as TABLE_NAME,'ItemPriceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemPriceID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_BM_BAK]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_BM_BAK' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_BM_BAK]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_BM_BAK' as TABLE_NAME,'PriceType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_BM_BAK]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_BM_BAK' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_BM_BAK]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_bkp_20190806_COGS_Update' as TABLE_NAME,'ItemPriceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemPriceID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_bkp_20190806_COGS_Update' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_bkp_20190806_COGS_Update' as TABLE_NAME,'PriceType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterPriceList_bkp_20190806_COGS_Update' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterPriceList_bkp_20190806_COGS_Update]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakSellable' as TABLE_NAME,'sellable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([sellable] as nvarchar))),'"') as VALUE from catalog.[PhonakSellable]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronSellableTemp' as TABLE_NAME,'sellable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([sellable] as nvarchar))),'"') as VALUE from catalog.[UnitronSellableTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakColorNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakColorNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'ItemID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BK4ERP_6DEC2021' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakColorTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakColorTemp' as TABLE_NAME,'value1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([value1] as nvarchar))),'"') as VALUE from catalog.[PhonakColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakColorTemp' as TABLE_NAME,'value2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([value2] as nvarchar))),'"') as VALUE from catalog.[PhonakColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'ItemID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_20190617' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakFamilyNameTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakFamilyNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakFamilyNameTemp' as TABLE_NAME,'type' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([type] as nvarchar))),'"') as VALUE from catalog.[PhonakFamilyNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'ModelAttributeValueID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValueID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'AttributeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'Itemcode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Itemcode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'ModelAttributeValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValue] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'VendorCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([VendorCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'Modifier' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterAttributeValues_20190617' as TABLE_NAME,'ModelAttributeValueDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelAttributeValueDescription] as nvarchar))),'"') as VALUE from catalog.[ItemMasterAttributeValues_20190617]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakFamilyTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakFamilyTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakIdentifierTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakIdentifierTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakModelTypeTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakModelTypeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakModelTypeTemp' as TABLE_NAME,'name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([name] as nvarchar))),'"') as VALUE from catalog.[PhonakModelTypeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'phonakOptionsTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[phonakOptionsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'phonakOptionsTemp' as TABLE_NAME,'default' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([default] as nvarchar))),'"') as VALUE from catalog.[phonakOptionsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'phonakOptionsValuesTemp' as TABLE_NAME,'values' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([values] as nvarchar))),'"') as VALUE from catalog.[phonakOptionsValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakPerformanceLevelNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakPerformanceLevelNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakPerformanceLevelTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakPerformanceLevelTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'brand' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([brand] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'ean' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ean] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'lastModifiedSAP' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([lastModifiedSAP] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'styles' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([styles] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'tamperProofEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([tamperProofEnabled] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakProductTemp' as TABLE_NAME,'unit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([unit] as nvarchar))),'"') as VALUE from catalog.[PhonakProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakReferencesTemp' as TABLE_NAME,'type' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([type] as nvarchar))),'"') as VALUE from catalog.[PhonakReferencesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakReferencesTemp' as TABLE_NAME,'target' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([target] as nvarchar))),'"') as VALUE from catalog.[PhonakReferencesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakModelTypeNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakModelTypeNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakCodeTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[PhonakCodeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakBatterySizeTemp' as TABLE_NAME,'batterySize' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([batterySize] as nvarchar))),'"') as VALUE from catalog.[PhonakBatterySizeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakStylesTemp' as TABLE_NAME,'styles' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([styles] as nvarchar))),'"') as VALUE from catalog.[PhonakStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakPictureURLTemp' as TABLE_NAME,'pictureURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([pictureURL] as nvarchar))),'"') as VALUE from catalog.[PhonakPictureURLTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakThumbnailURLTemp' as TABLE_NAME,'thumbnailURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([thumbnailURL] as nvarchar))),'"') as VALUE from catalog.[PhonakThumbnailURLTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'PhonakFamilyDescriptionTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[PhonakFamilyDescriptionTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronColorNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronColorNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronColorTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronColorTemp' as TABLE_NAME,'value1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([value1] as nvarchar))),'"') as VALUE from catalog.[UnitronColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronColorTemp' as TABLE_NAME,'value2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([value2] as nvarchar))),'"') as VALUE from catalog.[UnitronColorTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronFamilyNameTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronFamilyNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronFamilyNameTemp' as TABLE_NAME,'type' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([type] as nvarchar))),'"') as VALUE from catalog.[UnitronFamilyNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronFamilyTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronFamilyTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronIdentifierTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronIdentifierTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronModelTypeTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronModelTypeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronModelTypeTemp' as TABLE_NAME,'name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([name] as nvarchar))),'"') as VALUE from catalog.[UnitronModelTypeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronOptionsTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronOptionsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronOptionsTemp' as TABLE_NAME,'default' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([default] as nvarchar))),'"') as VALUE from catalog.[UnitronOptionsTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronOptionsValuesTemp' as TABLE_NAME,'values' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([values] as nvarchar))),'"') as VALUE from catalog.[UnitronOptionsValuesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronPerformanceLevelNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronPerformanceLevelNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronPerformanceLevelTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronPerformanceLevelTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'brand' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([brand] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'ean' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ean] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'lastModifiedSAP' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([lastModifiedSAP] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'styles' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([styles] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'tamperProofEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([tamperProofEnabled] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronProductTemp' as TABLE_NAME,'unit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([unit] as nvarchar))),'"') as VALUE from catalog.[UnitronProductTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronModelTypeNameTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronModelTypeNameTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronCodeTemp' as TABLE_NAME,'code' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([code] as nvarchar))),'"') as VALUE from catalog.[UnitronCodeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronBatterySizeTemp' as TABLE_NAME,'batterySize' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([batterySize] as nvarchar))),'"') as VALUE from catalog.[UnitronBatterySizeTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronStylesTemp' as TABLE_NAME,'styles' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([styles] as nvarchar))),'"') as VALUE from catalog.[UnitronStylesTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronPictureURLTemp' as TABLE_NAME,'pictureURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([pictureURL] as nvarchar))),'"') as VALUE from catalog.[UnitronPictureURLTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronThumbnailURLTemp' as TABLE_NAME,'thumbnailURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([thumbnailURL] as nvarchar))),'"') as VALUE from catalog.[UnitronThumbnailURLTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronFamilyDescriptionTemp' as TABLE_NAME,'en' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([en] as nvarchar))),'"') as VALUE from catalog.[UnitronFamilyDescriptionTemp]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemTypes' as TABLE_NAME,'ItemTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemTypeId] as nvarchar))),'"') as VALUE from catalog.[ItemTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemTypes' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemTypes' as TABLE_NAME,'ItemDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDescription] as nvarchar))),'"') as VALUE from catalog.[ItemTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemTypes]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronMappedFamilies' as TABLE_NAME,'NewCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NewCode] as nvarchar))),'"') as VALUE from catalog.[UnitronMappedFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'UnitronMappedFamilies' as TABLE_NAME,'OldFamily' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OldFamily] as nvarchar))),'"') as VALUE from catalog.[UnitronMappedFamilies]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'Colors' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Colors] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'BatterySizes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BatterySizes] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ReceiverSizes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverSizes] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ReceiverPowers' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReceiverPowers] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'QBSyncDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([QBSyncDate] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ItemID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList_BKP24012019' as TABLE_NAME,'SlimtubeSizes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SlimtubeSizes] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList_BKP24012019]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'ItemID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemID] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'BrandCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'FamilyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'TechnologyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'ModelCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModelCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'StyleCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'MonauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MonauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'ItemMasterList' as TABLE_NAME,'BinauralHCPCSCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BinauralHCPCSCode] as nvarchar))),'"') as VALUE from catalog.[ItemMasterList]) a



--otcCatalog

select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'ItemMasterHistroyId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterHistroyId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'ItemMasterId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'ItemName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemName] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'ItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'StockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'IsItemFree' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsItemFree] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMasterHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from otccatalog.[ItemMasterHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletName] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletDescription] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'ShowonWeb' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShowonWeb] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletCode] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletSource] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'DisplayWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisplayWalletName] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'ColorCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ColorCode] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'BenefitValueSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitValueSource] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'WalletStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletStandardData] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets' as TABLE_NAME,'BenefitSpendingType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingType] as nvarchar))),'"') as VALUE from otccatalog.[Wallets]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItems' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItems]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItems' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItems]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItems' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItems]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItems' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletItems]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletName] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletDescription] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'ShowonWeb' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShowonWeb] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletCode] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletSource] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'DisplayWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisplayWalletName] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'ColorCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ColorCode] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'BenefitValueSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitValueSource] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'WalletStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletStandardData] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'Wallets_backup' as TABLE_NAME,'BenefitSpendingType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingType] as nvarchar))),'"') as VALUE from otccatalog.[Wallets_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'WalletPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanId] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'PlanWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanWalletName] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'DisplayWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisplayWalletName] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'WalletStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletStandardData] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'BenefitValueSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitValueSource] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'walletplans_backup' as TABLE_NAME,'BenefitSpendingType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingType] as nvarchar))),'"') as VALUE from otccatalog.[walletplans_backup]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'WalletItemHistoryId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemHistoryId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletItemsHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from otccatalog.[WalletItemsHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'WalletOverrideId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletOverrideId] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'OverrideItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'OverrideStockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideStockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverrides' as TABLE_NAME,'OverrideItemCustomizedData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemCustomizedData] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'WalltetOverridesHistoryId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalltetOverridesHistoryId] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'WalletOverrideId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletOverrideId] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'OverrideItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'OverrideStockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideStockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletOverridesHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from otccatalog.[WalletOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'WalletPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'PlanWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanWalletName] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'DisplayWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DisplayWalletName] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'WalletStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletStandardData] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'BenefitValueSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitValueSource] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlans' as TABLE_NAME,'BenefitSpendingType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingType] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlans]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'WalletPlansHistoryId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlansHistoryId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'WalletPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'PlanWalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanWalletName] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlansHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlansHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'WalletPlanOverrideId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanOverrideId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'WalletPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'OverrideItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'OverrideStockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideStockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverrides' as TABLE_NAME,'OverrideItemCustomizedData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemCustomizedData] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverrides]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'WalletPlanOverridesHistoryid' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanOverridesHistoryid] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'WalletPlanOverrideId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanOverrideId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'WalletPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletPlanId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'WalletItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletItemId] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'OverrideItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'OverrideStockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OverrideStockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletPlanOverridesHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from otccatalog.[WalletPlanOverridesHistory]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'SNo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SNo] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'CatalogName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CatalogName] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'InsuranceHealthPlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanId] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'StockStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatus] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'RestockDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RestockDate] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'PriceType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PriceType] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'Title' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Title] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'IsItemFree' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsItemFree] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'MediaURL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MediaURL] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'HealthConditions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthConditions] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'Categories' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Categories] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'Tags' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Tags] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'WarehouseCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WarehouseCode] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WebCache' as TABLE_NAME,'ItemPriceVersionInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemPriceVersionInfo] as nvarchar))),'"') as VALUE from otccatalog.[WebCache]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'ItemMasterId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'ItemName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemName] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'ItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'StockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'IsItemFree' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsItemFree] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster_BK4ERP_6DEC2021' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster_BK4ERP_6DEC2021]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'MSDMasters' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from otccatalog.[MSDMasters]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'MSDMasters' as TABLE_NAME,'MasterTable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MasterTable] as nvarchar))),'"') as VALUE from otccatalog.[MSDMasters]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'MSDMasters' as TABLE_NAME,'syncType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([syncType] as nvarchar))),'"') as VALUE from otccatalog.[MSDMasters]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'MSDMasters' as TABLE_NAME,'lastModifiedDateTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([lastModifiedDateTime] as nvarchar))),'"') as VALUE from otccatalog.[MSDMasters]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemAttributeMaster' as TABLE_NAME,'Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from otccatalog.[ItemAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemAttributeMaster' as TABLE_NAME,'Data' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Data] as nvarchar))),'"') as VALUE from otccatalog.[ItemAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemAttributeMaster' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from otccatalog.[ItemAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemAttributeMaster' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[ItemAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletAttributeMaster' as TABLE_NAME,'WalletAttributeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletAttributeId] as nvarchar))),'"') as VALUE from otccatalog.[WalletAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletAttributeMaster' as TABLE_NAME,'Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Name] as nvarchar))),'"') as VALUE from otccatalog.[WalletAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletAttributeMaster' as TABLE_NAME,'Data' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Data] as nvarchar))),'"') as VALUE from otccatalog.[WalletAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletAttributeMaster' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from otccatalog.[WalletAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'WalletAttributeMaster' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[WalletAttributeMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'InsuranceCarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'InsuranceCarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierName] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'HealthPlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanName] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalletId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletId] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalletName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletName] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalletCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletCode] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalletSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalletSource] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalltMaps' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalltMaps] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'GetPlanWalletMap' as TABLE_NAME,'WalltAdds' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([WalltAdds] as nvarchar))),'"') as VALUE from otccatalog.[GetPlanWalletMap]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'StockStatusTypes' as TABLE_NAME,'StockStatusId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusId] as nvarchar))),'"') as VALUE from otccatalog.[StockStatusTypes]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'StockStatusTypes' as TABLE_NAME,'StockStatusName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusName] as nvarchar))),'"') as VALUE from otccatalog.[StockStatusTypes]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'StockStatusTypes' as TABLE_NAME,'StockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[StockStatusTypes]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'StockStatusTypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[StockStatusTypes]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemMasterId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemName] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemStandardData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemStandardData] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'StockStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StockStatusCode] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'IsItemFree' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsItemFree] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a union 
select top 100 * from  (select distinct  'otccatalog' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemCustomizedData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCustomizedData] as nvarchar))),'"') as VALUE from otccatalog.[ItemMaster]) a



-- OTCCatalog

select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Zing%'
select * from Insurance.InsuranceHealthPlans where InsuranceCarrierID in ( select insuranceCarrierID from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Zing%') -- 281

select * from information_schema.columns where column_name like 'nationsid'

select top 10 * from otccatalog.Wallets where WalletName like 'Medicare'
select top 10 * from otccatalog.WalletPlans where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare')
select top 10 * from otccatalog.WalletItems where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare')
select top 10 * from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare')
select top 10 * from otccatalog.WalletItemsHistory where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare')



-- Find all Items for all insurance carriers, NationsID is the ID used
select 'otccatalog.ItemMaster',* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare Plus'))
select 'otccatalog.ItemMaster',* from otccatalog.ItemMaster where NationsID in (5888)
select * from otccatalog.ItemMaster where InventoryQty < 0 order by nationsID, InventoryQty asc
select * from otccatalog.ItemMaster where InventoryQty > 0 order by nationsID, InventoryQty asc

select ItemCode,NationsID, ItemName, INventoryQty from otccatalog.ItemMaster where InventoryQty < 0 order by nationsID, InventoryQty asc

select ItemCode,NationsID, ItemName, INventoryQty from otccatalog.ItemMaster where InventoryQty > 0 order by nationsID, InventoryQty asc
-- Insurance and InsuranceHealthPlans
select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Health%' and InsuranceCarrierName like '%First%' -- 277
select * from Insurance.InsuranceHealthPlans where InsuranceCarrierID in ( select insuranceCarrierID from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Zing%') -- 281select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Zing%'
select * from Insurance.InsuranceHealthPlans where InsuranceCarrierID in ( select insuranceCarrierID from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Zing%') -- 281


select 'otccatalog.Wallets' as TableName,* from otccatalog.Wallets where WalletName like 'OTC'

-- By Wallet
IF OBJECT_ID('tempdb..#TWalletID') IS NOT NULL DROP TABLE #TWalletID
select * into #TWalletID from (select distinct walletID, InsuranceCarrierID, InsuranceHealthPlanID, PlanWalletName, IsActive, BenefitValueSource from otccatalog.WalletPlans where WalletID in (select WalletID from otccatalog.Wallets where WalletName like 'Medicare') ) a

-- By Insurance CarrierID
IF OBJECT_ID('tempdb..#TWalletID') IS NOT NULL DROP TABLE #TWalletID
select * into #TWalletID from (select distinct walletID, InsuranceCarrierID, InsuranceHealthPlanID, PlanWalletName, IsActive, BenefitValueSource from otccatalog.WalletPlans where insuranceCarrierID in (select insuranceCarrierID from Insurance.InsuranceCarriers where insuranceCarrierID =  277)) a

IF OBJECT_ID('tempdb..#TWalletID') IS NOT NULL DROP TABLE #TWalletID
Create table #TWalletID (WalletID int)
insert into #TWalletID values (45)
insert into #TWalletID values (48)
select * from #TWalletID

select 'otccatalog.GetPlanWalletMap' as TableName,* from otccatalog.GetPlanWalletMap where InsuranceCarrierID in (278,401) and insuranceHealthPlanID in (2572)


--select * from catalog.ItemMasterList where ItemCode  = '07110191105'
--select * from catalog.ItemMasterAttributeValues where ItemCode  = '07110191105'
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select 'otccatalog.Wallets' as tablename, * from otccatalog.Wallets where WalletID in (select walletID from otccatalog.WalletItems  where WalletID in (select WalletID from #TWalletID))
select 'otccatalog.WalletPlans' as TableName,* from otccatalog.WalletPlans where WalletID in (select WalletID from #TWalletID)
select 'otccatalog.WalletItems' as TableName,* from otccatalog.WalletItems where WalletID in (select WalletID from #TWalletID) --and NationsId = 5888
select 'otccatalog.GetPlanWalletMap' as TableName,* from otccatalog.GetPlanWalletMap where WalletID in (select WalletID from #TWalletID)
select 'otccatalog.WalletItemsHistory' as TableName,* from otccatalog.WalletItemsHistory where WalletID in (select WalletID from #TWalletID)

/*
select a.*, b.*, c.* from elig.mstrEligBenefitData a left join master.Members b on a.NHlinkID= b.NHlinkID left join orders.orders c on b.NHMemberID = c.NHMemberID  where 
a.insCarrierID =  '281'  and insHealthPlanID = 3259
and a.isActive = 1 and b.isActive =1 -- and c.IsActive =1 
--and ltrim(rtrim(a.NHLinkID)) = 'Z000003145' 
-- and b.NHMemberID ='NH202107393611'
order by c.CreateDate desc

select * from information_schema.columns where column_name like 'ItemCode' order by table_schema
*/

select * from otccatalog.ItemMaster where ItemName like '%activity%'
/* The Item # on the OTC website is the NationsID.
ItemMasterId	NationsId	ItemCode	ItemName	ItemStandardData	StandardPrice	StockStatusCode	DisplayOrder	IsItemFree	IsActive	CreateUser	CreateDate	ModifyUser	ModifyDate	EffectiveFrom	VersionNumber	InventoryQty	ItemCustomizedData
790	5813	84378510115	Activity Tracker	NULL	52.00	Stock	1	0	1	mnanduri	2020-12-05 08:44:28.3700000	ErpUser	2021-12-28 20:06:41.0933333	NULL	1	-255	NULL

*/

-- BrightHealth
select * from member.memberCards where ClientCarrierID = 300 and insuranceCarrierID = 258 and last4 = '7445' and 
select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%bright%'
select InsuranceCarrierID, InsuranceCarrierName, IsActive from Insurance.InsuranceCarriers where InsuranceCarrierName like '%bright%health%plan' -- 300
select * from elig.mstrEligBenefitData where insCarrierID = '300'
select * from otccatalog.ItemMaster where ItemCode = '84378510115'
select * from otccatalog.ItemAttributeMaster
select * from otccatalog.WalletAttributeMaster
select * from information_schema.columns where column_name like '%PurseName%'
select * from otccatalog.WebCache where CatalogName = 'CustomMedicareHealthFood' and NationsID = 5813
select * from otccatalog.ItemMaster where NationsID = 5813
select * from catalog.ItemMaster where NationsID = 5813
select * from otc.CatalogBrochures
select * from otc.MemberProducts where PurseName = 'CustomMedicareHealthFood' and ItemCode  = '84378510115'
select * from information_schema.columns where column_name like '%NationsID%' order by table_schema
select * from otc.ProductICDCategoriesAndICDCodes
select * from otc.MemberProducts where PurseName = 'CustomMedicareHealthFood'
select * from otc.CatalogBrochures where PurseName = 'CustomMedicareHealthFood'
select * from fisxtract.Monetary where PurseName = 'CustomMedicareHealthFood'
select * from fisxtract.[Authorization] where PurseName = 'CustomMedicareHealthFood'
select * from information_schema.columns where column_name like '%description%' order by table_schema
select * from otccatalog.ItemMaster where NationsID = 5813
select * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%Molina%'



-- Use this template to check Wallet Information | 01/05/2021
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where DisplayWalletName = 'OTC' and walletname like '%Molina%' and WalletCode = 'ML01WEX22'
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 4 and (InsuranceHealthPlanID = 6 or InsuranceHealthPlanID is NULL) and walletID in (110 ) 
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 380 and walletID in (110 ) and (InsuranceHealthPlanID = 4031 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (110 ) and nationsID = 6002 -- walletItemID = 60838
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (110)) and NationsID = 6002
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (110 ) ) and WalletItemID = 60838
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (110 ) 

select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (110)) and NationsID = 6002

-- Update script
update otccatalog.WalletPlans set isActive = 1 where WalletPlanID in (95, 94)
update otccatalog.Wallets set ShowonWeb = 1 where walletID in (45,48)  


select * from master.MemberInsurances where insuranceCarrierID =  15 and InsuranceHealthPlanID = 38
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where NationsId = 5853
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 15
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where WalletID in (45,48) and NationsID in (5853, 5806)

/*
Ticket # 52427

271 | Insurance Carrier
2540 | Insurance Health Plan

walletID's | (95, 121)

-- Wallets
-- Use this template to check Wallet Information | 01/05/2021
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where DisplayWalletName = 'OTC' and walletname like '%Molina%Healthcare%' --and WalletCode = 'ML01WEX22'


select * from otccatalog.wallets where walletID in (95,121)
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 271 
--and walletID in (110 )  
and (InsuranceHealthPlanID = 2540 or InsuranceHealthPlanID is NULL)

select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 271 and walletID in (121 ) and (InsuranceHealthPlanID = 2540 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (121) and NationsID = 7001
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (121)) and NationsID = 7001
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (121) ) and WalletItemID = 65181
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (121)


--Benefits

select  distinct 

 'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*, 'rulesengine.BenefitRulesData' as TableName_BenefitRulesData,c.*

,JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
where 1=1 
and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
and ins.InsuranceCarrierID = 271 and ihp.InsuranceHealthPlanID = 2540
and JSON_VALUE(c.BenefitRuleData, '$.WALCODE')	in ('CB02FIS22', 'CB01NB22')

*/


select distinct *,
 JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from rulesengine.BenefitRulesData c

select * from orders.orders where NHMemberID  = 'NH202002296969'


-- Wallets
-- Use this template to check Wallet Information | 01/05/2021
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where DisplayWalletName = 'OTC' and walletname like '%Molina%Healthcare%' --and WalletCode = 'ML01WEX22'

select * from otccatalog.wallets where walletID in (102)
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 106 
--and walletID in (110 )  
and (InsuranceHealthPlanID = 2540 or InsuranceHealthPlanID is NULL)

select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where  walletID in (102 ) and InsuranceCarrierId = 106 and (InsuranceHealthPlanID = 2540 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (102) -- and NationsID = 7001
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (102)) -- and NationsID = 7001
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (102) ) -- and WalletItemID = 65181
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (102)


--Benefits

select  distinct 

 'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules  --, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*, 'rulesengine.BenefitRulesData' as TableName_BenefitRulesData,c.*

,JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
where 1=1 
and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
and ins.InsuranceCarrierID = 106 --and ihp.InsuranceHealthPlanID = 2540
and JSON_VALUE(c.BenefitRuleData, '$.WALCODE')	in ('HP01NB22')










select a.datasource, a.NHmemberID, a.firstName, a.LastName, b.InsCarrierID, b.insHealthPlanID, a.isActive, b.BenefitStartDate, b.BenefitEndDate, b.* from elig.mstrEligBenefitData b join master.Members a on a.NHLinkID = b.NHLinkID where insCarrierID = 106 and b.isActive =1 and getdate() between BenefitStartDate and BenefitEndDate
and b.insHealthPlanID = 5455
order by b.benefitstartdate desc

select * from insurance.insuranceCarriers where insuranceCarrierID = 106

select * from insurance.InsuranceHealthPlans where insuranceCarrierID = 106



/*

select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where walletname like '%UMHA%' or walletname like '%BathroomSafety%'
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 15 and walletID in (45, 48 ) and InsuranceHealthPlanID = 38
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where WalletName like '%BathroomSafety%' or WalletName like '%UMHA%' and InsuranceCarrierId = 15 and InsuranceHealthPlanID = 38
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (45, 48 )
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (45, 48 ))
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in  (45, 48 )
select 'otccatalog.ItemMaster' as TableName, * from otccatalog.ItemMaster

update otccatalog.WalletPlans set isActive = 1 where WalletPlanID in (95, 94)
update otccatalog.Wallets set ShowonWeb = 1 where walletID in (45,48)  

select * from master.MemberInsurances where insuranceCarrierID =  15 and InsuranceHealthPlanID = 38
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where NationsId = 5853
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 15
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where WalletID in (45,48) and NationsID in (5853, 5806)


select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where walletname like '%alignment%' --or walletname like '%BathroomSafety%'
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 302 and walletID in (24,123,126,127,143) and InsuranceHealthPlanID = 2692
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 302 and InsuranceHealthPlanID = 2692
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletID in (24,123,126,127,143) and nationsID = 5049
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (24,123,126,127,143))
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID  in (select WalletPlanID from otccatalog.walletPlans where walletID in (24,123,126,127,143))
select 'otccatalog.ItemMaster' as TableName, * from otccatalog.ItemMaster



select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where walletname like '%alignment%' --or walletname like '%BathroomSafety%'
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 302 and walletID in (143) and InsuranceHealthPlanID = 2692
-- select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 302 and InsuranceHealthPlanID = 2692
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletID in (24,123,126,127,143) and nationsID = 5049
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (24,123,126,127,143))
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID  in (select WalletPlanID from otccatalog.walletPlans where walletID in (24,123,126,127,143))
select 'otccatalog.ItemMaster' as TableName, * from otccatalog.ItemMaster

update otccatalog.WalletPlans set isActive = 1 where WalletPlanID in (95, 94)
update otccatalog.Wallets set ShowonWeb = 1 where walletID in (45,48)  

select * from master.MemberInsurances where insuranceCarrierID =  15 and InsuranceHealthPlanID = 38
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where NationsId = 5853
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 15
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where WalletID in (45,48) and NationsID in (5853, 5806)

*/


select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where DisplayWalletName = 'OTC' and walletname like '%HAP%' --and WalletCode = 'ML01WEX22'

select * from otccatalog.wallets where walletID in (101)
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 223 
--and walletID in (110 )  
and (InsuranceHealthPlanID = 2540 or InsuranceHealthPlanID is NULL)

select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where  walletID in (101 ) and InsuranceCarrierId = 106 and (InsuranceHealthPlanID = 223 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (101) -- and NationsID = 7001
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (101)) -- and NationsID = 7001
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (101) ) -- and WalletItemID = 65181
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (101)



-- Wallets
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where WalletCode in ('CB01NB22') -- and DisplayWalletName = 'OTC' 

select 'otccatalog.Wallets' as TableName, * from otccatalog.wallets where walletID in (95)
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 271 
--and walletID in (110 )  
and (InsuranceHealthPlanID = 2538 or InsuranceHealthPlanID is NULL) and WalletID = 95

select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where  walletID in (95) and InsuranceCarrierId = 271 and (InsuranceHealthPlanID = 2538 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (95)-- and NationsID = 7001
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (95)) -- and NationsID = 7001
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (95) ) -- and WalletItemID = 65181
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (95)



-- Wallets
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where WalletCode in ('CB02FIS22') -- and DisplayWalletName = 'OTC' 

select 'otccatalog.Wallets' as TableName, * from otccatalog.wallets where walletID in (121)
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 271 
--and walletID in (110 )  
and (InsuranceHealthPlanID = 2538 or InsuranceHealthPlanID is NULL) and WalletID = 121

select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where  walletID in (121) and InsuranceCarrierId = 271 and (InsuranceHealthPlanID = 2538 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (121)-- and NationsID = 7001
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (121)) -- and NationsID = 7001
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (121) ) -- and WalletItemID = 65181
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (121)

-- Benefits
select  distinct 

 'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*, 'rulesengine.BenefitRulesData' as TableName_BenefitRulesData,c.*

,JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
where 1=1 and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
and ins.InsuranceCarrierID = 271
and ihp.InsuranceHealthPlanID = 2538
--and JSON_VALUE(c.BenefitRuleData, '$.BENTYPE') = 'OTC'



-- mapping between Wallets and FIS -- We have to check this table to see if its configured with FIS
select top 10 * from flex.FISWalletMapping where CarrierID = 271 and HealthPlanID = 2538



-- Benefits
select  distinct 

 'insurance.InsuranceCarriers' as TableName_Insurance,ins.insuranceCarrierName, ins.InsuranceCarrierID
,'insurance.InsuranceHealthPlan' as TableName_HealthPlan, ihp.insuranceHealthplanID, ihp.HealthPlanName
,'insurance.ContractRules' as TableName_ContractRules, a.*,'Insurance.HealthPlanContracts' as TableName_HealthPlanContracts, b.*, 'rulesengine.BenefitRulesData' as TableName_BenefitRulesData,c.*

,JSON_VALUE(c.BenefitRuleData, '$.BENCAT')				[Benfit Cat]
,JSON_VALUE(c.BenefitRuleData, '$.BENCATVALUE')			[Benfit Value]
,JSON_VALUE(c.BenefitRuleData, '$.BENTYPE')				[Benfit Type]
,JSON_VALUE(c.BenefitRuleData, '$.BENBEHV')				[Benfit Reset]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQMONTHS')		[No of Reset Months]
,JSON_VALUE(c.BenefitRuleData, '$.BENFREQTYPE')			[FREQ TYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENFORTYPE')			[BenfitFORTYPE]
,JSON_VALUE(c.BenefitRuleData, '$.BENVALUESRC')			[Benfit Source]
,JSON_VALUE(c.BenefitRuleData, '$.WALCODE')				[Wallet Code]
,JSON_VALUE(c.BenefitRuleData, '$.APPLYMEMBERCOPAY')	[Member Copay]

from insurance.ContractRules a 
left join Insurance.HealthPlanContracts b on a.HealthPlanContractID = b.HealthPlanContractID
left join rulesengine.BenefitRulesData c on a.BenefitRuleDataID  = c.BenefitRuleDataID
left join insurance.InsuranceCarriers ins on b.InsuranceCarrierID = ins.InsuranceCarrierID
left join insurance.InsuranceHealthPlans ihp on b.InsuranceHealthPlanID = ihp.InsuranceHealthPlanID
where 1=1 and a.isActive = 1 and b.IsActive = 1 and c.IsActive =1 and ins.IsActive =1 and ihp.IsActive = 1
and ins.InsuranceCarrierID = 271
and ihp.InsuranceHealthPlanID = 2538
--and JSON_VALUE(c.BenefitRuleData, '$.BENTYPE') = 'OTC'




86,87,89,90,142


-- Use this template to check Wallet Information | 01/05/2021
-- select 'otccatalog.wallets' as TableName, * from otccatalog.wallets where DisplayWalletName = 'OTC' and walletname like '%Molina%' and WalletCode = 'ML01WEX22'
select 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 4 and (InsuranceHealthPlanID = 6 or InsuranceHealthPlanID is NULL) and walletID in (86,87,89,90,142 ) 
select 'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 4 and walletID in (86,87,89,90,142) and (InsuranceHealthPlanID = 6 or InsuranceHealthPlanID is NULL)
select 'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (86,87,89,90,142) and NationsID in (9991, 9992, 9993 ) -- walletItemID = 60838
select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (86,87,89,90,142) and NationsID in (9991, 9992, 9993 ))
select 'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (86,87,89,90,142) ) --and WalletItemID = 60838
select 'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (86,87,89,90,142 ) 

select 'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (86,87,89,90,142)) and NationsID in (9991, 9992, 9993 )




-- Use this query to find out in an item is available for the Member
select 'otccatalog.wallets' as TableName, * from otccatalog.wallets 
where 1=1 
and walletID in (86)
or WalletCode like '%CH0622%'
or DisplayWalletName like '%rewards%'
or WalletName like '%Central%Health%Plan%'

select IsActive, 'otccatalog.WalletPlans' as TableName, * from otccatalog.WalletPlans where insuranceCarrierID = 4 and (InsuranceHealthPlanID = 6 or InsuranceHealthPlanID is NULL) and walletID in (86) 
select 'Not Available' as InActive,'otccatalog.GetPlanWalletMap' as TableName, * from otccatalog.GetPlanWalletMap where InsuranceCarrierId = 4 and walletID in (86) and (InsuranceHealthPlanID = 6 or InsuranceHealthPlanID is NULL)
select IsActive,'otccatalog.WalletItems' as TableName, * from otccatalog.WalletItems where walletId in (86) and NationsID in (9991, 9992, 9993 ) -- walletItemID = 60838
select IsActive,'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (86) and NationsID in (9991, 9992, 9993 ))
select IsActive,'otccatalog.WalletOverrides' as TableName, * from otccatalog.WalletOverrides where WalletItemID in (select walletItemID from otccatalog.WalletItems where walletID in (86) and NationsID in (9991, 9992, 9993 ) ) --and WalletItemID = 60838
select IsActive,'otccatalog.WalletPlanOverrides' as TableName, * from otccatalog.WalletPlanOverRides where WalletPlanID in (86) 
select IsActive,'otccatalog.ItemMaster' as tablename,* from otccatalog.ItemMaster where NationsID in (select NationsID from otccatalog.WalletItems  where WalletID in (86)) and NationsID in (9991, 9992, 9993 )




select *