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