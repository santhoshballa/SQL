
IF OBJECT_ID('tempdb..#Orders') IS NOT NULL DROP TABLE #Orders
select * into #Orders from (
select o.*,

json_value(o.MemberData, '$.MemberName') as MemberData_MemberName
,json_value(o.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(o.MemberData, '$.insPlanId') as MemberData_insPlanId
,json_value(o.MemberData, '$.insuranceNbr') as MemberData_insuranceNbr

,o.orderID as OrderID_Orders, o.OrderStatusCode as OrderStatusCode_Orders, o.Status as Status_Orders 
from orders.orders o  where o.OrderStatusCode = 'CAN' and o.Source = 'OTC_MEAL' and o.OrderType = 'OTC' and o.IsActive =1
) a

IF OBJECT_ID('tempdb..#OrderTransactionData_CAN') IS NOT NULL DROP TABLE #OrderTransactionData_CAN
select * into #OrderTransactionData_CAN from 
(
select
a.IsActive as IsActive_CAN, a.OrderTransactionID as OrderTransactionID_CAN, a.OrderID as OrderID_CAN, a.OrderStatusCode as OrderStatusCode_CAN , a.OrderTransactionData as OrderTransactionData_CAN
,json_value(a.OrderTransactionData, '$.CancelledDate') as OrderTransactionData_CancelledDate_CAN
,json_value(a.OrderTransactionData, '$.Reason') as OrderTransactionData_Reason_CAN
,json_value(a.OrderTransactionData, '$.AdditionalComments') as OrderTransactionData_AdditionalComments_CAN
from Orders.OrderTransactionDetails a where a.OrderStatusCode = 'CAN' and a.IsActive = 1 and 
a.orderID in (Select o.OrderID from Orders.Orders o where o.OrderStatusCode = 'CAN' and o.Source = 'OTC_MEAL' and o.OrderType = 'OTC' and o.IsActive =1)

) a


IF OBJECT_ID('tempdb..#OrderTransactionData_VOI') IS NOT NULL DROP TABLE #OrderTransactionData_VOI
select * into #OrderTransactionData_VOI from
(
select 
b.IsActive as IsActive_VOI, b.OrderTransactionID as OrderTransactionID_VOI, b.OrderID as OrderID_VOI, b.OrderStatusCode as OrderStatusCode_VOI, b.OrderTransactionData as OrderTransactionData_VOI

,json_value(b.OrderTransactionData, '$.orderId') as OrderTransactionData_orderId_VOI
,json_value(b.OrderTransactionData, '$.orderDate') as OrderTransactionData_orderDate_VOI
,json_value(b.OrderTransactionData, '$.orderGroupId') as OrderTransactionData_orderGroupId_VOI
from Orders.OrderTransactionDetails b
where b.OrderStatusCode in ( 'VOI', 'INI') and b.IsActive = 1 and
b.orderID in (Select o.OrderID from Orders.Orders o where o.OrderStatusCode = 'CAN' and o.Source = 'OTC_MEAL' and o.OrderType = 'OTC' and o.IsActive =1)
) a


IF OBJECT_ID('tempdb..#InsuranceHealthPlans') IS NOT NULL DROP TABLE #InsuranceHealthPlans
select * into #InsuranceHealthPlans from
(
select 
ic.InsuranceCarrierID, ic.InsuranceCarrierName, ic.IsActive as IsActive_InsuranceCarrier  
,hp.InsuranceHealthPlanID, hp.HealthPlanName, hp.IsActive as IsActive_InsuranceHealthPlan
from insurance.InsuranceCarriers ic join insurance.InsuranceHealthPlans hp on ic.InsuranceCarrierID = hp.InsuranceCarrierID
where ic.IsActive =1 and hp.isActive = 1 and
ic.InsuranceCarrierID in (select distinct MemberData_insCarrierId from #Orders) and
hp.InsuranceHealthPlanID in (select distinct MemberData_insPlanId from #Orders) 
) a


IF OBJECT_ID('tempdb..#CancelledMealOrders') IS NOT NULL DROP TABLE #CancelledMealOrders
select * into #CancelledMealOrders from (
select o.*, ihp.*, a.*, b.*
from 
#Orders o 
left join #OrderTransactionData_CAN a on o.OrderID_Orders = a.OrderID_CAN
left join #OrderTransactionData_VOI b on a.OrderID_CAN = b.OrderID_VOI
left join #InsuranceHealthPlans ihp on (ihp.InsuranceCarrierID = o.MemberData_insCarrierId and ihp.InsuranceHealthPlanID = o.MemberData_insPlanId)
) a


IF OBJECT_ID('tempdb..#CancelledMealOrdersFinal') IS NOT NULL DROP TABLE #CancelledMealOrdersFinal
select * into #CancelledMealOrdersFinal from (
Select
OrderID, 
-- Ordertype, NHMemberID, OrderStatusCode, MemberData_MemberName as MemberName, InsuranceCarrierID, InsuranceCarrierName, InsuranceHealthPlanID, HealthPlanName as InsuranceHealthPlanName, 
Cast(OrderTransactionData_OrderDate_VOI as Date) as OrderDate, Cast(OrderTransactionData_CancelledDate_CAN as Date) as CancelledDate 
--OrderTransactionData_Reason_CAN as ReasonForCancellation, OrderTransactionData_AdditionalComments_CAN as ReasonAdditionalComments
from #CancelledMealOrders
-- where OrderTransactionData_OrderDate_VOI is not null
--Order by cast(OrderTransactionData_OrderDate_VOI as Date) desc, cast(OrderTransactionData_CancelledDate_CAN as date) desc, InsuranceCarrierName
) a

/*

select * from #CancelledMealOrders

Select
OrderID, Ordertype, NHMemberID, OrderStatusCode, MemberData_MemberName as MemberName, InsuranceCarrierID, InsuranceCarrierName, InsuranceHealthPlanID, HealthPlanName as InsuranceHealthPlanName, 
OrderTransactionData_OrderDate_VOI as OrderDate, OrderTransactionData_CancelledDate_CAN as CancelledDate, 
OrderTransactionData_Reason_CAN as ReasonForCancellation, OrderTransactionData_AdditionalComments_CAN as ReasonAdditionalComments
from #CancelledMealOrders
where OrderTransactionData_OrderDate_VOI is not null
Order by cast(OrderTransactionData_CancelledDate_CAN as date) desc, InsuranceCarrierName


Select
OrderID, 
-- Ordertype, NHMemberID, OrderStatusCode, MemberData_MemberName as MemberName, InsuranceCarrierID, InsuranceCarrierName, InsuranceHealthPlanID, HealthPlanName as InsuranceHealthPlanName, 
OrderTransactionData_OrderDate_VOI as OrderDate, OrderTransactionData_CancelledDate_CAN as CancelledDate 
--OrderTransactionData_Reason_CAN as ReasonForCancellation, OrderTransactionData_AdditionalComments_CAN as ReasonAdditionalComments
from #CancelledMealOrders
where OrderTransactionData_OrderDate_VOI is not null
Order by cast(OrderTransactionData_CancelledDate_CAN as date) desc, InsuranceCarrierName


IF OBJECT_ID('tempdb..#CancelledMealOrdersFinal') IS NOT NULL DROP TABLE #CancelledMealOrdersFinal
select * into #CancelledMealOrdersFinal from (
Select
OrderID, 
-- Ordertype, NHMemberID, OrderStatusCode, MemberData_MemberName as MemberName, InsuranceCarrierID, InsuranceCarrierName, InsuranceHealthPlanID, HealthPlanName as InsuranceHealthPlanName, 
Cast(OrderTransactionData_OrderDate_VOI as Date) as OrderDate, Cast(OrderTransactionData_CancelledDate_CAN as Date) as CancelledDate,
OrderTransactionData_Reason_CAN as ReasonForCancellation, OrderTransactionData_AdditionalComments_CAN as ReasonAdditionalComments
from #CancelledMealOrders
-- where OrderTransactionData_OrderDate_VOI is not null
--Order by cast(OrderTransactionData_OrderDate_VOI as Date) desc, cast(OrderTransactionData_CancelledDate_CAN as date) desc, InsuranceCarrierName
) a

*/


select * from #CancelledMealOrdersFinal Order by OrderID asc, OrderDate asc, CancelledDate desc

/*
select * from orders.orders where orderid in (203678484, 203678208)
select * from orders.orderItems where orderid in (203678484, 203678208)
select * from orders.orderTransactionDetails where orderid in (203678484, 203678208)

select * from orders.orders where orderid in (203678484, 203678487, 203678488, 203678485, 203678486)
select * from orders.orderItems where orderid in (203678484, 203678487, 203678488, 203678485, 203678486)
select * from orders.orderTransactionDetails where orderid in (203678484, 203678487, 203678488, 203678485, 203678486)
*/

/*
OrderID	OrderDate	CancelledDate
203678484	2022-09-23	2022-09-23
203678485	2022-09-23	2022-09-23
203678486	2022-09-23	2022-09-23
203678487	2022-09-23	2022-09-23
203678488	2022-09-23	2022-09-23

*/

/*
select * from orders.orders where RefOrderID in (203678484, 203678487, 203678488, 203678485, 203678486)
select * from orders.orderItems where orderid in (203678484, 203678487, 203678488, 203678485, 203678486)
select * from orders.orderTransactionDetails where orderid in (203678484, 203678487, 203678488, 203678485, 203678486)
*/


/*
For OTC Meals, The first order ( OrderID 203678484) is created with RefOderId is null, This has dependent Orders ( Order ID 203678485,203678486,203678487,203678488 ) where the RefOrderID is the same as the Initial Order that was created.


select * from orders.orders where orderid in (203707368) -- main order has a RefOrderID that is null
select * from orders.orders where RefOrderID in  (203707368) -- Dependent Orders, The RefOrderis 203707368
select * from orders.orderItems where orderid in (203707368) or OrderID in (select OrderID from orders.orders where RefOrderID in  (203707368))
select * from orders.orderTransactionDetails where orderid in (203707368) or OrderID in (select OrderID from orders.orders where RefOrderID in  (203707368))


*/
-- OrderTransactionDetails, OrderTransactionData 

select *,
orderDate, orderGroupId, expectedDeliveryDate, orderMealType

OrderTransactionData,
-- OrderStatusCode is COMM
OrderTransactionData_MealPreference,preferenceData_sendEmail, preferenceData_sendSMS, preferenceData_profileLevelPreferences,

-- OrderStatusCode is INI
OrderTransactionData_orderId,
json_value(OrderTransactionData_MealPreference, '$.InitialOrderDeliveryDate') as InitialOrderDeliveryDate,
json_value(OrderTransactionData_MealPreference, '$.MealType') as MealType ,
json_value(OrderTransactionData_MealPreference, '$.MealTypeText')  as MealTypeText,
json_value(OrderTransactionData_MealPreference, '$.NumberofOrders') as NumberofOrders ,
json_value(OrderTransactionData_MealPreference, '$.NumberofOrdersText') as NumberofOrdersText,
json_value(OrderTransactionData_MealPreference, '$.DietRestrictions') as DietRestrictions,
json_value(OrderTransactionData_MealPreference, '$.DietRestrictionsText') as DietRestrictionsText,
json_value(OrderTransactionData_MealPreference, '$.FoodAllergies') as  FoodAllergies,
json_value(OrderTransactionData_MealPreference, '$.FoodAllergiesText') as FoodAllergiesText,
json_value(OrderTransactionData_MealPreference, '$.AdditionalComments') as AdditionalComments,

json_value(OrderTransactionData_MealPreference, '$.Address.Address1') as Address_Address1,
json_value(OrderTransactionData_MealPreference, '$.Address.Address2') as Address_Address2,
json_value(OrderTransactionData_MealPreference, '$.Address.City') as Address_City,
json_value(OrderTransactionData_MealPreference, '$.Address.State') as Address_State,
json_value(OrderTransactionData_MealPreference, '$.Address.ZipCode') as Address_ZipCode,
json_value(OrderTransactionData_MealPreference, '$.Address.Country') as Address_ZipCode,
json_value(OrderTransactionData_MealPreference, '$.Address.PhoneNumber') as PhoneNumber,
json_value(OrderTransactionData_MealPreference, '$.CheckBoxForAddress') as CheckBoxForAddress,
json_value(OrderTransactionData_MealPreference, '$.MealCount') as TotalMealCount,
mealCount

from (
select *,
--OrderStatusCode = 'INI'
json_value(OrderTransactionData, '$.orderId') as OrderTransactionData_orderId,
json_value(OrderTransactionData, '$.orderDate') as orderDate,
json_value(OrderTransactionData, '$.orderGroupId') as orderGroupId,
json_value(OrderTransactionData, '$.expectedDeliveryDate') as expectedDeliveryDate,
json_value(OrderTransactionData, '$.orderMealType') as orderMealType,
json_value(OrderTransactionData, '$.mealPreferece') as OrderTransactionData_MealPreference,
json_value(OrderTransactionData, '$.mealCount') as mealCount,

--OrderStatusCode = 'COMM'
json_value(OrderTransactionData, '$.preferenceData.sendEmail') as preferenceData_sendEmail,
json_value(OrderTransactionData, '$.preferenceData.sendSMS') as preferenceData_sendSMS,
json_value(OrderTransactionData, '$.preferenceData.profileLevelPreferences') as preferenceData_profileLevelPreferences

from orders.orderTransactionDetails where OrderId in (203707372)
) a


