SELECT DISTINCT
o.OrderId
,CAST(OrderDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) OrderCreatedDate
,o.NHMemberId,o.InsuranceCarrierID,ic.InsuranceCarrierName, o.InsuranceHealthPlanID, hp.HealthPlanName
,JSON_VALUE(o.ShippingAddress,'$.firstName') Ship_FirstName
,JSON_VALUE(o.ShippingAddress,'$.lastName') Ship_LastName
,JSON_VALUE(o.ShippingAddress,'$.phoneNumber') Ship_PhoneNumber
,JSON_VALUE(o.ShippingAddress,'$.address.addressType') Ship_AddressType
,JSON_VALUE(o.ShippingAddress,'$.address.address1') + ' ' + JSON_VALUE(o.ShippingAddress,'$.address.address2') Ship_Address1
--,JSON_VALUE(o.ShippingAddress,'$.address.address1') Ship_Address1
--,JSON_VALUE(o.ShippingAddress,'$.address.address2') Ship_Address2
,JSON_VALUE(o.ShippingAddress,'$.address.city') Ship_City
,JSON_VALUE(o.ShippingAddress,'$.address.state') Ship_State
,JSON_VALUE(o.ShippingAddress,'$.address.zipCode') Ship_ZipCode
,o.[Status],o.OrderType
-- Include HA Battery size and count
,CASE WHEN oi.ItemCode = 'BATTERY' AND oi.ItemType = 'HA' THEN oi.ItemCode + ' ' + JSON_VALUE(oi.ItemAttributesValueData,'$.Size') + ' ' + CAST(oi.Quantity AS VARCHAR(10)) + ' Ct'
		ELSE oi.ItemCode 
		END ItemCode
,oi.Quantity
-- Include HA Battery size and count
,CASE WHEN oi.ItemCode = 'BATTERY' AND oi.ItemType = 'HA' THEN im.ItemDescription + ' ' + JSON_VALUE(oi.ItemAttributesValueData,'$.Size') + ' ' + CAST(oi.Quantity AS VARCHAR(10)) + ' Ct'
		ELSE im.ItemDescription 
		END CatalogName
--,JSON_VALUE(oi.ItemAttributesValueData,'$.Size') BatterySize
--,JSON_VALUE(oi.ItemAttributesValueData,'$.NationsId') Item_NationsId
--,JSON_VALUE(oi.ItemAttributesValueData,'$."Reason for request"') [ReasonForRequest]
--,shi.TrackingNumber, shi.ShipDate
,RANK() OVER (PARTITION BY o.OrderId ORDER BY oi.OrderItemId) OrderItemRank
FROM SupplOrders.Orders o WITH (NOLOCK)
JOIN SupplOrders.OrderItems oi WITH (NOLOCK) ON oi.OrderId = o.OrderId and oi.IsActive = 1
LEFT JOIN SupplOrders.ItemMaster im WITH (NOLOCK) ON im.ItemCode = oi.ItemCode

LEFT JOIN Insurance.InsuranceCarriers ic WITH (NOLOCK) ON ic.InsuranceCarrierID = o.InsuranceCarrierID
LEFT JOIN Insurance.InsuranceHealthPlans hp WITH (NOLOCK) ON hp.InsuranceHealthPlanID = o.InsuranceHealthPlanID
WHERE 1=1
AND (      
			(o.OrderType = 'OTC') -- OTC catalog items
			OR 
			(oi.ItemType = 'HA' AND oi.ItemCode = 'BATTERY') -- HA Battery
	) 
AND o.OrderType NOT IN ('PERS')
AND o.Status NOT IN ('Shipped','Cancel','Declined') -- Exclude shipped orders
AND o.IsActive = 1
AND JSON_VALUE(o.ShippingAddress,'$.firstName') NOT IN ('Mohan','test')
--AND shi.TrackingNumber IS NULL -- Exclude orders that are already shipped
AND CAST(OrderDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) > '20210518' -- Orders created starting May 2021

select * from information_schema.columns where table_schema = 'SupplOrders'
select * from information_schema.columns where table_schema = 'insurance'
select * from information_Schema.columns where table_schema = 
/*
Tables in SupplOrders Schema
('Itemtypes','ItemMaster','ItemAttributes','ItemAttributeOptions','NationsIds','PlanItemsConfig','OrderStatusType','OrdersHistory','Orders','OrderItems','DocumentTransaction')

Tables in Insurance schema
('InsuranceCarriers'), ('InsuranceHealthPlans')


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
where TABLE_SCHEMA in ('SupplOrders', 'Insurance' )
and 
(TABLE_NAME IN 
('Itemtypes','ItemMaster','ItemAttributes','ItemAttributeOptions','NationsIds','PlanItemsConfig','OrderStatusType','OrdersHistory','Orders','OrderItems','DocumentTransaction')  OR 
TABLE_NAME IN ('InsuranceCarriers','InsuranceHealthPlans') )
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')


select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'DocumentID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentID] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'BrowserName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrowserName] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'ClientIP' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientIP] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'DocumentExtension' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentExtension] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'DocumentName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentName] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'DocumentTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentTypeCode] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'DocumentStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DocumentStatus] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'MemberProfileId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberProfileId] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'PrintName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintName] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'DocumentTransaction' as TABLE_NAME,'PrintDateTime' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PrintDateTime] as nvarchar))),'"') as VALUE from SupplOrders.[DocumentTransaction]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsAddress1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsAddress1] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsAddress2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsAddress2] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsCity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsCity] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsEmailAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsEmailAddress] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsPhoneNbr' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsPhoneNbr] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsState' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsState] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'ClaimsZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClaimsZipCode] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceAddress1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceAddress1] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceAddress2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceAddress2] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceCity' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceCity] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceEmailAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceEmailAddress] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServicePhoneNbr' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServicePhoneNbr] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceState' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceState] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CustServiceZipCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CustServiceZipCode] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'InsuranceCarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierName] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'IsContracted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsContracted] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'IsDiscountProgram' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDiscountProgram] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'MemberDataFileProvided' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberDataFileProvided] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'IsAutoSendPaymentReceipt' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsAutoSendPaymentReceipt] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'CarrierConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'IsNHDiscount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsNHDiscount] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceCarriers' as TABLE_NAME,'AllowAdditionalServices' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AllowAdditionalServices] as nvarchar))),'"') as VALUE from Insurance.[InsuranceCarriers]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'HealthPlanName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanName] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'HealthPlanNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanNumber] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'IsDiscountProgram' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsDiscountProgram] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'IsMedicaid' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMedicaid] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'IsMedicare' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMedicare] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'PlanConfigData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanConfigData] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'InsuranceHealthPlans' as TABLE_NAME,'IsProgramCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsProgramCode] as nvarchar))),'"') as VALUE from Insurance.[InsuranceHealthPlans]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributeOptions' as TABLE_NAME,'ltemAttributeOptionID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ltemAttributeOptionID] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributeOptions]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributeOptions' as TABLE_NAME,'ItemAttributeID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemAttributeID] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributeOptions]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributeOptions' as TABLE_NAME,'AttributeOptionValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeOptionValue] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributeOptions]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributeOptions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributeOptions]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'ItemAttributeID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemAttributeID] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'AttributeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeCode] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'AttributeDisplayName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AttributeDisplayName] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'ItemMasterId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterId] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'IsMandate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsMandate] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemAttributes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[ItemAttributes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemMasterId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterId] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemDisplayName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDisplayName] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDescription] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemImagesUrl' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemImagesUrl] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'MaxQuantityPerOrder' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MaxQuantityPerOrder] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'ItemMaster' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[ItemMaster]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Itemtypes' as TABLE_NAME,'ItemTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemTypeId] as nvarchar))),'"') as VALUE from SupplOrders.[Itemtypes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Itemtypes' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from SupplOrders.[Itemtypes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Itemtypes' as TABLE_NAME,'ItemDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemDescription] as nvarchar))),'"') as VALUE from SupplOrders.[Itemtypes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Itemtypes' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[Itemtypes]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'NationsIds' as TABLE_NAME,'NationsId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NationsId] as nvarchar))),'"') as VALUE from SupplOrders.[NationsIds]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'NationsIds' as TABLE_NAME,'ltemAttributeOptionIDs' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ltemAttributeOptionIDs] as nvarchar))),'"') as VALUE from SupplOrders.[NationsIds]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'NationsIds' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from SupplOrders.[NationsIds]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'NationsIds' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[NationsIds]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'OrderItemId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemId] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'ItemCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'ItemType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'ItemAttributesValueData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemAttributesValueData] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderItems' as TABLE_NAME,'ItemData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from SupplOrders.[OrderItems]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderDate] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ShippedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippedDate] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ShippingAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingAddress] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ProcessData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessData] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'RemarksData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemarksData] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'MemberData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderAmountData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderData] as nvarchar))),'"') as VALUE from SupplOrders.[Orders]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'Id' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Id] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'OrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'OrderDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderDate] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'ShippedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippedDate] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'ShippingAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingAddress] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'OrderType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'ProcessData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessData] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'RemarksData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RemarksData] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'MemberData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'OrderAmountData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'OrderData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderData] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrdersHistory' as TABLE_NAME,'Action' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Action] as nvarchar))),'"') as VALUE from SupplOrders.[OrdersHistory]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderStatusType' as TABLE_NAME,'OrderType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from SupplOrders.[OrderStatusType]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderStatusType' as TABLE_NAME,'OrderStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatus] as nvarchar))),'"') as VALUE from SupplOrders.[OrderStatusType]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderStatusType' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from SupplOrders.[OrderStatusType]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'OrderStatusType' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[OrderStatusType]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'PlanItemsConfig' as TABLE_NAME,'PlanItemsConfigID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanItemsConfigID] as nvarchar))),'"') as VALUE from SupplOrders.[PlanItemsConfig]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'PlanItemsConfig' as TABLE_NAME,'ItemMasterID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemMasterID] as nvarchar))),'"') as VALUE from SupplOrders.[PlanItemsConfig]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'PlanItemsConfig' as TABLE_NAME,'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar))),'"') as VALUE from SupplOrders.[PlanItemsConfig]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'PlanItemsConfig' as TABLE_NAME,'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar))),'"') as VALUE from SupplOrders.[PlanItemsConfig]) a union 
select top 100 * from  (select distinct  'SupplOrders' as TABLE_SCHEMA,'PlanItemsConfig' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from SupplOrders.[PlanItemsConfig]) a


select '[supplOrders].[ItemTypes]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[ItemTypes] union all
select '[supplOrders].[ItemMaster]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[ItemMaster] union all
select '[supplOrders].[ItemAttributes]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[ItemAttributes] union all
select '[supplOrders].[ItemAttributeOptions]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[ItemAttributeOptions] union all
select '[supplOrders].[NationsIds]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[NationsIds] union all
select '[supplOrders].[PlanItemsConfig]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[PlanItemsConfig] union all
select '[supplOrders].[OrderStatusType]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[OrderStatusType] union all
select '[supplOrders].[OrdersHistory]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[OrdersHistory] union all
select '[supplOrders].[Orders]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[Orders] union all
select '[supplOrders].[OrderItems]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[OrderItems] union all
select '[supplOrders].[DocumentTransaction]' as TableName, count(*) as TotalNoOfRecords from [supplOrders].[DocumentTransaction] union all
select '[Insurance].[InsuranceCarriers]' as TableName, count(*) as TotalNoOfRecords from [Insurance].[InsuranceCarriers] union all
select '[Insurance].[InsuranceHealthPlans]' as TableName, count(*) as TotalNoOfRecords from [insurance].[InsuranceHealthPlans]



('Itemtypes','ItemMaster','ItemAttributes','ItemAttributeOptions','NationsIds','PlanItemsConfig','OrderStatusType','OrdersHistory','Orders','OrderItems','DocumentTransaction')  OR 
TABLE_NAME IN ('InsuranceCarriers','InsuranceHealthPlans') )


select top 10 '[supplOrders].[ItemTypes]' as TableName,  * from [supplOrders].[ItemTypes] -- List of Item Types, Hearing Aids, Over the Counter, Generic, PERS orders -- Lookup  Table
select top 10 '[supplOrders].[ItemMaster]' as TableName, * from [supplOrders].[ItemMaster] -- List of all Battery and Catalogs are configured -- Lookup table
select top 10 '[supplOrders].[ItemAttributes]' as TableName, * from [supplOrders].[ItemAttributes] -- List of Attributes for the Battery like Quantity, Size, Reason, Quantity and a Headphone
select top 10 '[supplOrders].[ItemAttributeOptions]' as TableName, * from [supplOrders].[ItemAttributeOptions] -- For each Attribute, multiple options are configured, for example the size for battery 10, 13, 312, 675, Reasons for requesting the supplemental order
select top 10 '[supplOrders].[NationsIds]' as TableName, * from [supplOrders].[NationsIds] -- The Battery and Headphone are Nations specific
select top 10 '[supplOrders].[PlanItemsConfig]' as TableName, * from [supplOrders].[PlanItemsConfig] -- This is the main table where the supplemental orders are configured according to Insurance carrier and Health Plan
select top 10 '[supplOrders].[Orders]' as TableName, * from [supplOrders].[Orders] -- Orders, insurance carrier, healthplan, shipping address, statusordertype ( HA, OTC), contains the NHMemberID
select top 10 '[supplOrders].[OrderItems]' as TableName, * from [supplOrders].[OrderItems] -- Contains the multiple order items within an order, This will help in counting the number of items that are shipped, there is a limit of 3 on headphones
select top 10 '[supplOrders].[OrderStatusType]' as TableName, * from [supplOrders].[OrderStatusType] -- Order Status for the process of shipping catalogs and battery, OrderFlowSteps are also configured here
select top 10 '[supplOrders].[OrdersHistory]' as TableName,  * from [supplOrders].[OrdersHistory] order by CreateDate desc -- Captures the history of the order and the order status
select top 10 '[supplOrders].[DocumentTransaction]' as TableName, * from [supplOrders].[DocumentTransaction] -- stores the catalog pdf encrypted as an hexadecimal for all PERS orders
select top 10 '[Insurance].[InsuranceCarriers]' as TableName, * from [Insurance].[InsuranceCarriers] -- stores all the insurance carriers we have a partnership with
select top 10 '[Insurance].[InsuranceHealthPlans]' as TableName, * from [Insurance].[InsuranceHealthPlans] -- list all the healthplans under an insurance carrier

-- Order and Order Histoty table
select * from [supplOrders].[Orders] where orderid = 35598
select * from [supplOrders].[OrdersHistory] where orderid = 35598
select * from [supplOrders].[DocumentTransaction] where orderid = 35598

select max(orderid) from [supplOrders].[DocumentTransaction]
--35598

select distinct ordertype from [supplOrders].[Orders] where orderid in (select distinct orderid from [supplOrders].[DocumentTransaction] )

--Both the below queries should return zero
select * from [supplOrders].[OrderItems] where orderid not in ( select orderid from [supplOrders].[Orders])
select * from [supplOrders].[Orders] where orderid not in (select orderid from [supplOrders].[OrderItems])



select 
'[supplOrders].[OrderItems]' as TableName, a.IsActive, a. OrderItemID, a.OrderId, a.ItemCode, a.ItemType, a.Price, a.Quantity, a.ItemAttributesValueData, a.IsActive, a.ItemData, a.*,
'[supplOrders].[Orders]' as TableName, b.IsActive, b.OrderID, b.OrderDate, b.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, b.ShippedDate, b.ShippingAddress, b.Status, b.OrderType, b.Amount, b.ProcessData, b.RemarksData, b.MemberData, b.OrderAmountData, b.OrderData, b.* ,
'[supplOrders].[ItemMaster]' as TableName, c.IsActive, c.ItemCode, c.ItemDisplayName, c.ItemDescription, c.ItemType, c.MaxQuantityPerOrder, c.*,
'[supplOrders].[ItemTypes]' as TableName, d.IsActive, d.ItemType, d.ItemDescription, d.*,
'[supplOrders].[ItemAttributes]' as TableName, e.IsActive, e.AttributeCode, e.AttributeDisplayName, e.IsMandate, e.*,
'[supplOrders].[ItemAttributeOptions]' as TableName, f.IsActive, f.AttributeOptionValue, f.*,
'[supplOrders].[NationsIds]' as TableName, g.IsActive, g.NationsId, g.Description, g.*,
'[Insurance].[InsuranceCarriers]' as TableName, h.isActive, h.insuranceCarrierName, h.*,
'[Insurance].[InsuranceHealthPlans]' as TableName, i.isActive, i.healthplanname, i.*


from 
[supplOrders].[OrderItems] a 
left join [supplOrders].[Orders] b on (a.orderid = b.orderid)
left join [supplOrders].[ItemMaster] c on a.ItemCode = c.ItemCode
left join [supplOrders].[ItemTypes] d on c.ItemType =  d.ItemType
left join [supplOrders].[ItemAttributes] e on c.ItemMasterID = e.ItemMasterID
left join [supplOrders].[ItemAttributeOptions] f on f.ItemAttributeID = e.ItemAttributeID
left join [supplOrders].[NationsIds] g on g.ltemAttributeOptionIDs = f.ltemAttributeOptionID  -- column name has an s
left join [Insurance].[InsuranceCarriers] h on h.InsuranceCarrierID = b.InsuranceCarrierID
left join [Insurance].[InsuranceHealthPlans] i on i.InsuranceHealthPlanID =  b.InsuranceHealthPlanID
where
1=1 and 
--b.NHMemberID = 'NH201902180038' and
a.orderid = 6041


select Orderid, count(*) as Recordcount from [supplOrders].[OrderItems] group by Orderid having count(*) > 5
Orderid	Recordcount
6041	6




select 
'[supplOrders].[OrderItems]' as TableName, a.IsActive, a. OrderItemID, a.OrderId, a.ItemCode, a.ItemType, a.Price, a.Quantity, a.ItemAttributesValueData, a.IsActive, a.ItemData, 
'[supplOrders].[Orders]' as TableName, b.IsActive, b.OrderID, b.OrderDate, b.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID, b.Status, b.OrderType, b.Amount, b.ProcessData, b.RemarksData, b.MemberData, b.OrderAmountData, b.OrderData, 

b.OrderDate,
CAST(b.OrderDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS date ) OrderDate_EST
,b.ShippedDate, b.ShippingAddress
,JSON_VALUE(b.ShippingAddress,'$.firstName') ShippingAddress_FirstName
,JSON_VALUE(b.ShippingAddress,'$.lastName') ShippingAddress_LastName
,JSON_VALUE(b.ShippingAddress,'$.phoneNumber') ShippingAddress_PhoneNumber
,JSON_VALUE(b.ShippingAddress,'$.address.addressType') ShippingAddress_AddressType
--,JSON_VALUE(b.ShippingAddress,'$.address.address1') + ' ' + JSON_VALUE(b.ShippingAddress,'$.address.address2') ShippingAddress_Address1
,JSON_VALUE(b.ShippingAddress,'$.address.address1') ShippingAddress_Address1
,JSON_VALUE(b.ShippingAddress,'$.address.address2') ShippingAddress_Address2
,JSON_VALUE(b.ShippingAddress,'$.address.city') ShippingAddress_City
,JSON_VALUE(b.ShippingAddress,'$.address.state') ShippingAddress_State
,JSON_VALUE(b.ShippingAddress,'$.address.zipCode') ShippingAddress_ZipCode,

'[supplOrders].[ItemMaster]' as TableName, c.IsActive, c.ItemCode, c.ItemDisplayName, c.ItemDescription, c.ItemType, c.MaxQuantityPerOrder, 
'[supplOrders].[ItemTypes]' as TableName, d.IsActive, d.ItemType, d.ItemDescription, 
'[supplOrders].[ItemAttributes]' as TableName, e.IsActive, e.AttributeCode, e.AttributeDisplayName, e.IsMandate, 
'[supplOrders].[ItemAttributeOptions]' as TableName, f.IsActive, f.AttributeOptionValue, 
'[supplOrders].[NationsIds]' as TableName, g.IsActive, g.NationsId, g.Description, 
'[Insurance].[InsuranceCarriers]' as TableName, h.isActive, h.InsuranceCarrierID, h.insuranceCarrierName, 
'[Insurance].[InsuranceHealthPlans]' as TableName, i.isActive, i.InsuranceHealthPlanID, i.healthplanname 




from 
[supplOrders].[OrderItems] a 
left join [supplOrders].[Orders] b on (a.orderid = b.orderid)
left join [supplOrders].[ItemMaster] c on a.ItemCode = c.ItemCode
left join [supplOrders].[ItemTypes] d on c.ItemType =  d.ItemType
left join [supplOrders].[ItemAttributes] e on c.ItemMasterID = e.ItemMasterID
left join [supplOrders].[ItemAttributeOptions] f on f.ItemAttributeID = e.ItemAttributeID
left join [supplOrders].[NationsIds] g on g.ltemAttributeOptionIDs = f.ltemAttributeOptionID  -- column name has an s
left join [Insurance].[InsuranceCarriers] h on h.InsuranceCarrierID = b.InsuranceCarrierID
left join [Insurance].[InsuranceHealthPlans] i on i.InsuranceHealthPlanID =  b.InsuranceHealthPlanID
where
1=1 
--and b.NHMemberID = 'NH201902180038'
--and a.orderid = 6041
--and b.InsuranceCarrierID =  
and a.CreateDate > getdate() - 1

select max(CreateDate) from [supplOrders].[OrderItems]