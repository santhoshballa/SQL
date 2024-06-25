/*
select 'Orders.Orders' as TableName, NHMemberID, OrderID, Source, Status, MemberData, ShippingData from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' 
and Status = 'ACTIVE'

select NHMemberID from orders.orders where orderID in (202509378) -- 202509378, check the address
*/

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))

insert into #NHMemberIDTemp (NHMemberID) values ('NH202210009781') 

-- master.MemberInsurances 
select 'MEALS_Query_Insurance' as MEALS_Query_Insurance,  'master.MemberInsurances' as MemberInsurances_TableName, a.InsuranceCarrierID
,(select c.InsuranceCarrierName from insurance.InsuranceCarriers c where c.InsuranceCarrierID = a.InsuranceCarrierID) as InsuranceCarrierName
,a.InsuranceHealthPlanID
,(select d.HealthPlanName from insurance.InsuranceHealthPlans d where d.InsuranceHealthPlanID = a.InsuranceHealthPlanID) as InsuranceHealthPlanName
from master.MemberInsurances a where MemberID in (Select MemberID from Master.Members where NHMemberID in (select NhMemberID from #NHMemberIDTemp))

-- Master and Elig | Just Active and Eligible
select 'MEALS_Query_MasterElig_Active' as MEALS_Query_MasterElig_Active,  a.IsActive as Members_IsActive, b.IsActive as Elig_IsActive, a.NHMemberID, b.SubscriberID, b.insCarrierID
,(select c.InsuranceCarrierName from insurance.InsuranceCarriers c where c.InsuranceCarrierID =b.insCarrierID) as InsuranceCarrierName
,b.insHealthPlanID
,(select d.HealthPlanName from insurance.InsuranceHealthPlans d where d.InsuranceHealthPlanID = b.insHealthPlanID) as InsuranceHealthPlanName
,'master.Members' as Members_TableName, a.*, 'elig.mstrEligBenefitData' as Elig_TableName, b.* 
from master.members a left join elig.mstrEligBenefitData b
on a.MemberID= b.MasterMemberID
where 1=1
and a.IsActive = 1 and b.IsActive =1
and NHMemberID in (select NHMemberID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp) ) 
and getdate() between b.benefitStartDate and b.BenefitEndDate

-- Master and Elig | All elig records available
select 'MEALS_Query_MasterElig_All' as MEALS_Query_MasterElig_All,  a.IsActive as Members_IsActive, b.IsActive as Elig_IsActive, a.NHMemberID, b.SubscriberID, b.insCarrierID
,(select c.InsuranceCarrierName from insurance.InsuranceCarriers c where c.InsuranceCarrierID =b.insCarrierID) as InsuranceCarrierName
,b.insHealthPlanID
,(select d.HealthPlanName from insurance.InsuranceHealthPlans d where d.InsuranceHealthPlanID = b.insHealthPlanID) as InsuranceHealthPlanName
,'master.Members' as Members_TableName, a.*, 'elig.mstrEligBenefitData' as Elig_TableName, b.* 
from master.members a left join elig.mstrEligBenefitData b
on a.MemberID= b.MasterMemberID
where 1=1
and a.IsActive = 1 -- and b.IsActive =1
and NHMemberID in (select NHMemberID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp) ) 
-- and getdate() between b.benefitStartDate and b.BenefitEndDate


-- Wallet Configuration for Meals
select 'MEALS_Query_ConfigWallet' as MEALS_Query_ConfigWallet, 'insurance.InsuranceConfig' as TableName, IsActive, ConfigData, InsuranceCarrierID

,json_value(InsuranceConfig.ConfigData, '$.phone') as ConfigData_Phone
,json_value(InsuranceConfig.ConfigData, '$.civilRightsDisclaimer') as ConfigData_civilRightsDisclaimer
,json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation') as ConfigData_hoursOfOperation
,json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes') as ConfigData_mealBundleTypes
,json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes[0].bundleName') as ConfigData_bundleName
,json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes[0].bundleValue') as ConfigData_bundleValue
,json_value(InsuranceConfig.ConfigData, '$.maxMealCount') as ConfigData_maxMealCount
,json_value(InsuranceConfig.ConfigData, '$.mealsPerDay') as ConfigData_mealsPerDay
,json_value(InsuranceConfig.ConfigData, '$.maxLimitPerYear') as ConfigData_maxLimitPerYear

from insurance.InsuranceConfig where
insuranceCarrierID in (select distinct InsuranceCarrierID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
and 
(
InsuranceHealthPlanID in (select distinct InsuranceHealthPlanID from master.MemberInsurances where MemberID in (select memberID from master.members where NHMemberID in (select NHmemberID from #NHMemberIDTemp)))
or InsuranceHealthPlanID is null
)


--Orders.Orders

/*
---- Important Notes ----
The Order ID is the parent for RefOrderID, shipping is done in multiple shipments and hence RefOrderID contains the Parent OrderID 
The address in the OrderID where ReforderID contains the Parent OrderID is the one reflecting on the UI on meals.nationsbenefits.com

*/
select  'MEALS_Query_Orders' as MEALS_Query_Orders, 'Orders.Orders' as TableName, NHMemberID, OrderID, RefOrderID, Source, Status, MemberData, MemberData, SHippingData
,json_value(orders.MemberData, '$.MemberName') as MemberData_MemberName
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId
,json_value(orders.MemberData, '$.subdomain') as MemberData_subdomain
,json_value(orders.MemberData, '$.clientCarrierId') as MemberData_clientCarrierId
,json_value(orders.MemberData, '$.clientPlanId') as MemberData_clientPlanId
,json_value(orders.MemberData, '$.cardNumber') as MemberData_cardNumber
,json_value(orders.MemberData, '$.healthPlanCode') as MemberData_healthPlanCode
,json_value(orders.MemberData, '$.programCode') as MemberData_programCode
,json_value(orders.MemberData, '$.groupNumber') as MemberData_groupNumber
,json_value(orders.MemberData, '$.paymentConsent') as MemberData_paymentConsent
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.middleName') as MemberData_middleName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.address') as MemberData_address
,json_value(orders.MemberData, '$.address.address1') as MemberData_address1
,json_value(orders.MemberData, '$.address.address2') as MemberData_address1
,json_value(orders.MemberData, '$.address.city') as MemberData_address1
,json_value(orders.MemberData, '$.address.state') as MemberData_address1
,json_value(orders.MemberData, '$.address.zip') as MemberData_address1
,json_value(orders.MemberData, '$.address.county') as MemberData_address1
,json_value(orders.MemberData, '$.address.country') as MemberData_address1
,json_value(orders.MemberData, '$.address.phoneNumber') as MemberData_address1
,json_value(orders.MemberData, '$.insuranceNbr') as MemberData_insuranceNbr
,json_value(orders.MemberData, '$.dateOfBirth') as MemberData_dateOfBirth
,json_value(orders.MemberData, '$.email') as MemberData_email
,json_value(orders.MemberData, '$.nhMemberId') as MemberData_NHMemberId

,json_value(orders.ShippingData, '$.MemberName') as ShippingData_MemberName
,json_value(orders.ShippingData, '$.insCarrierId') as ShippingData_insCarrierId
,json_value(orders.ShippingData, '$.insPlanId') as ShippingData_insPlanId
,json_value(orders.ShippingData, '$.subdomain') as ShippingData_subdomain
,json_value(orders.ShippingData, '$.clientCarrierId') as ShippingData_clientCarrierId
,json_value(orders.ShippingData, '$.clientPlanId') as ShippingData_clientPlanId
,json_value(orders.ShippingData, '$.cardNumber') as ShippingData_cardNumber
,json_value(orders.ShippingData, '$.healthPlanCode') as ShippingData_healthPlanCode
,json_value(orders.ShippingData, '$.programCode') as ShippingData_programCode
,json_value(orders.ShippingData, '$.groupNumber') as ShippingData_groupNumber
,json_value(orders.ShippingData, '$.paymentConsent') as ShippingData_paymentConsent
,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.middleName') as ShippingData_middleName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.phoneNumber') as ShippingData_address1
,json_value(orders.ShippingData, '$.insuranceNbr') as ShippingData_insuranceNbr
,json_value(orders.ShippingData, '$.dateOfBirth') as ShippingData_dateOfBirth
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.nhMemberId') as ShippingData_NHMemberId

from Orders.orders
where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL'
and NHMemberID in (select NhMemberID from #NHMemberIDTemp)
order by OrderID, CreateDate


-- Orders.OrderItems
select 'MEALS_Query_OrderItems' as MEALS_Query_OrderItems, 'Orders.OrderItems' as OrderItems_TableName, OrderID, ItemCode, Quantity, Amount, Status, UnitPrice, PairPrice, ItemType
,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName
,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.source') as ItemData_source
,json_value(orderItems.ItemData, '$.itemPriceVersionInfo.version') as ItemData_version

from Orders.OrderItems 
where ItemType = 'OTC' and IsActive =1 and OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive =1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp))
order by OrderID, CreateDate


select 'MEALS_Query_ItemMaster' as MEALS_Query_ItemMaster, 'otccatalog.ItemMaster' as ItemMaster_TableName, IsActive, NationsID, ItemCode, ItemName, StandardPrice, * 
from otccatalog.ItemMaster 
where ItemCode in (
					select Itemcode from Orders.OrderItems 
					where ItemType = 'OTC' and IsActive = 1 
										   and OrderID in ( 
														    select OrderID from orders.orders 
															where OrderType = 'OTC'  and IsActive =1 
															                         and Source = 'OTC_MEAL' 
																					 and NHMemberID in (select NhMemberID from #NHMemberIDTemp)
										                  )
				  )


select 'MEALS_Query_ItemMaster_AllMeals' as MEALS_Query_ItemMaster_AllMeals, 'otccatalog.ItemMaster' as ItemMaster_TableName, IsActive, NationsID, ItemCode, ItemName, StandardPrice from otccatalog.ItemMaster where nationsID > 9900 and nationsID < 9950


-- Orders.OrderTransactionDetails
select 'MEALS_Query_OrderTransactionDetails' as MEALS_Query_OrderTransactionDetails, 'Orders.OrderTransactionDetails' as OrderItems_TableName, OrderID, OrderStatusCode, OrderTransactionData
,json_value(OrderTransactionDetails.OrderTransactionData, '$.fileName') as OrderTransactionData_fileName
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendEmail') as OrderTransactionData_SendEmail
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.SendSMS') as OrderTransactionData_SendSMS
,json_value(OrderTransactionDetails.OrderTransactionData, '$.preferenceData.profileLevelPreferences') as OrderTransactionData_profileLevelPreferences

,json_value(OrderTransactionDetails.OrderTransactionData, '$.OrderId') as OrderTransactionData_OrderID
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderGroupId') as OrderTransactionData_orderGroupId
,json_value(OrderTransactionDetails.OrderTransactionData, '$.expectedDeliveryDate') as OrderTransactionData_expectedDeliveryDate

,json_value(OrderTransactionDetails.OrderTransactionData, '$.orderMealType') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealPreferece') as OrderTransactionData_mealPreferece

,json_value(OrderTransactionDetails.OrderTransactionData, '$.mealCount') as OrderTransactionData_mealCount
,json_value(OrderTransactionDetails.OrderTransactionData, '$.logId') as OrderTransactionData_logID

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderDate') as OrderTransactionData_orderDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].carrier') as OrderTransactionData_carrier
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].serviceType') as OrderTransactionData_serviceType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].orderId') as OrderTransactionData_orderId

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingNumber') as OrderTransactionData_trackingNumber
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].trackingUrl') as OrderTransactionData_trackingUrl
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shipDate') as OrderTransactionData_shipDate
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].shippingCost') as OrderTransactionData_shippingCost

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].taxCost') as OrderTransactionData_orderMealType
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].itemNumber') as OrderTransactionData_ItemNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].trackingNumber') as OrderTransactionData_trackingNumber_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].weight') as OrderTransactionData_weight_0
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[0].units') as OrderTransactionData_units_0

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].itemNumber') as OrderTransactionData_ItemNumber_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].trackingNumber') as OrderTransactionData_trackingNumber_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].weight') as OrderTransactionData_weight_1
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[1].units') as OrderTransactionData_units_1

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].itemNumber') as OrderTransactionData_ItemNumber_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].trackingNumber') as OrderTransactionData_trackingNumber_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].weight') as OrderTransactionData_weight_2
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[2].units') as OrderTransactionData_units_2

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].itemNumber') as OrderTransactionData_ItemNumber_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].trackingNumber') as OrderTransactionData_trackingNumber_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].weight') as OrderTransactionData_weight_3
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[3].units') as OrderTransactionData_units_3

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].itemNumber') as OrderTransactionData_ItemNumber_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].trackingNumber') as OrderTransactionData_trackingNumber_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].weight') as OrderTransactionData_weight_4
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[4].units') as OrderTransactionData_units_4

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].itemNumber') as OrderTransactionData_ItemNumber_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].trackingNumber') as OrderTransactionData_trackingNumber_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].weight') as OrderTransactionData_weight_5
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[5].units') as OrderTransactionData_units_5

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].itemNumber') as OrderTransactionData_ItemNumber_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].trackingNumber') as OrderTransactionData_trackingNumber_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].weight') as OrderTransactionData_weight_6
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[6].units') as OrderTransactionData_units_6

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].itemNumber') as OrderTransactionData_ItemNumber_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].trackingNumber') as OrderTransactionData_trackingNumber_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].weight') as OrderTransactionData_weight_7
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[7].units') as OrderTransactionData_units_7

,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].itemNumber') as OrderTransactionData_ItemNumber_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].trackingNumber') as OrderTransactionData_trackingNumber_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].weight') as OrderTransactionData_weight_8
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[8].units') as OrderTransactionData_units_8


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].itemNumber') as OrderTransactionData_ItemNumber_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].trackingNumber') as OrderTransactionData_trackingNumber_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].weight') as OrderTransactionData_weight_9
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[9].units') as OrderTransactionData_units_9


,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].itemNumber') as OrderTransactionData_ItemNumber_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].trackingNumber') as OrderTransactionData_trackingNumber_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].weight') as OrderTransactionData_weight_10
,json_value(OrderTransactionDetails.OrderTransactionData, '$[0].itemTracking[10].units') as OrderTransactionData_units_10

from orders.OrderTransactionDetails where OrderID in (select OrderID from orders.orders where OrderType = 'OTC' and IsActive = 1 and Source = 'OTC_MEAL' and NHMemberID in (select NhMemberID from #NHMemberIDTemp))
order by OrderID, CreateDate