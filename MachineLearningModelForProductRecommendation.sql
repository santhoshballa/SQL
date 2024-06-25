--Provide NHMemberID, InsuranceCarrierID and InsuranceHealthPlanID
/*
select NHMemberID, count(*) as MemberCount from orders.orders where IsActive =1 and  OrderStatusCode = 'SHI' and CreateDate > '01-01-2022'  group by NHMemberID order by 2 desc

select * from orders.orders where NHMemberID = 'NH202002617848'

select * from orders.orderItems where orderid in (select orderid from orders.orders where NHMemberID = 'NH202002617848' and CreateDate > '01-01-2022') 

select insCarrierID, insHealthPlanID, count(*) from elig.mstrEligBenefitData where IsActive =1 group by insCarrierID, insHealthPlanID order by Count(*) desc
*/

IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp 

select * into #TAllOrdersOrderItems from (
select
a.OrderID, a.OrderType, a.Status OrderStatus, a.NHMemberID, a.OrderStatusCode
,json_value(a.MemberData, '$.insCarrierId') as InsuranceCarrierID
,json_value(a.MemberData, '$.insPlanId') as InsuranceHealthPlanID

,b.ItemCode
,json_value(b.ItemData, '$.nationsId') as NationsID
,b.Status as OrderItemStatus
,b.Quantity
,b.UnitPrice
,b.PairPrice
,b.IsActive

,c.ItemCode as ItemMasterItemCode
,c.ItemName

from Orders.orders a 
left join Orders.OrderItems b on a.OrderID = b.OrderID
left join otcCatalog.ItemMaster c on b.ItemCode = c.ItemCode
where a.orderType = 'OTC' and a.createDate > '01-01-2022' and a.Status = 'Active' and a.OrderStatusCode = 'SHI' and b.ItemType = 'OTC' and b.ItemCode not in ('NB_VOUCHER')
) a

-- select top 10 * from #TAllOrdersOrderItems 

declare @vInsuranceCarrierID int = 258
declare @vInsuranceHealthPlanID int = 2433

IF OBJECT_ID('tempdb..#TOrdersOrderItems') IS NOT NULL DROP TABLE #TOrdersOrderItems 
select * into #TOrdersOrderItems from (
select
a.OrderID, a.OrderType, a.Status OrderStatus, a.NHMemberID, a.OrderStatusCode
,json_value(a.MemberData, '$.insCarrierId') as InsuranceCarrierID
,json_value(a.MemberData, '$.insPlanId') as InsuranceHealthPlanID

,b.ItemCode
,json_value(b.ItemData, '$.nationsId') as NationsID
,b.Status as OrderItemStatus
,b.Quantity
,b.UnitPrice
,b.PairPrice
,b.IsActive

,c.ItemCode as ItemMasterItemCode
,c.ItemName

from Orders.orders a 
left join Orders.OrderItems b on a.OrderID = b.OrderID
left join otcCatalog.ItemMaster c on b.ItemCode = c.ItemCode
where a.orderType = 'OTC' and a.createDate > '01-01-2022' and a.Status = 'Active' and a.OrderStatusCode = 'SHI' and b.ItemType = 'OTC' and b.ItemCode not in ('NB_VOUCHER')
and json_value(a.MemberData, '$.insCarrierId') = @vInsuranceCarrierID and json_value(a.MemberData, '$.insPlanId') = @vInsuranceHealthPlanID
) a

select top 10 * from #TOrdersOrderItems

-- Ratio of all Items
declare @vNHMemberID nvarchar(20) = 'NH202210707408'
declare @vAllTotalItems float
declare @vTotalItems float
declare @vTotalItemsNHMemberID float


select @vAllTotalItems = sum(Quantity) from #TAllOrdersOrderItems
select @vTotalItems = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vTotalItemsNHMemberID = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @vNHMemberID  -- Particular Member

/*
select @vAllTotalItems = Count(*) from #TAllOrdersOrderItems
select @vTotalItems = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vTotalItemsNHMemberID = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @VNHMemberID  -- Particular Member
*/

-- ALL Products All Carriers
IF OBJECT_ID('tempdb..#TAllTotalItemRatio') IS NOT NULL DROP TABLE #TAllTotalItemRatio 

select * into #TAllTotalItemRatio from (
select ItemCode, ItemName, Sum(Quantity) as NumberOfItems, Round(Cast((Sum(Quantity)/@vAllTotalItems) as float), 4) as AllTotalItemRatio  from #TALLOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TAllTotalItemRatio order by AllTotalItemRatio desc


-- All Products within a Carrier and a Health Plan
IF OBJECT_ID('tempdb..#TTotalItemRatio') IS NOT NULL DROP TABLE #TTotalItemRatio 

select * into #TTotalItemRatio from (
select ItemCode, ItemName, Sum(Quantity) as NumberOfItems, Round(Cast((Sum(Quantity)/@vTotalItems) as float), 4) as TotalItemRatio  from #TOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TTotalItemRatio

-- All Products bought by a Member
IF OBJECT_ID('tempdb..#TTotalItemNHMemberIDRatio') IS NOT NULL DROP TABLE #TTotalItemNHMemberIDRatio 
select * into #TTotalItemNHMemberIDRatio from (
select ItemCode, ItemName, Sum(Quantity) as NumberOfItems, Round(Cast((Sum(Quantity)/@vTotalItemsNHMemberID) as float), 4) as RatioNHMemberID  from #TOrdersOrderItems where NHMemberID =  @vNHMemberID
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TTotalItemNHMemberIDRatio


select a.*, b.*, c.*, (isnull(ALLTotalItemRatio,0)+isnull(TotalItemRatio,0) + isnull(RatioNHMemberID, 0)) as WeightedValue 
from #TAllTotalItemRatio a 
left join #TTotalItemRatio b on a.ItemCode = b.ItemCode
left join #TTotalItemNHMemberIDRatio c on b.ItemCode = c.itemCode
--where RatioNHMemberID is not null
order by WeightedValue desc










/*



select * from information_schema.columns where TABLE_NAME like '%ItemMaster%'
select top 10 * from otccatalog.ItemMaster




select
json_value(a.MemberData, '$.insCarrierId') as InsuranceCarrierID
,json_value(a.MemberData, '$.insPlanId') as InsuranceHealthPlanID
,count(*) as NumberOFOrders

from Orders.orders a 
left join Orders.OrderItems b on a.OrderID = b.OrderID
left join otcCatalog.ItemMaster c on b.ItemCode = c.ItemCode
where a.orderType = 'OTC' and a.createDate > '01-01-2022' and a.Status = 'Active' and a.OrderStatusCode = 'SHI' and b.ItemType = 'OTC' and b.ItemCode not in ('NB_VOUCHER')
group by 
json_value(a.MemberData, '$.insCarrierId'),json_value(a.MemberData, '$.insPlanId')
--order by count(*) desc


/*
InsuranceCarrierID	InsuranceHealthPlanID	NumberOFOrders
394	4126	387214
302	2692	287138
4	6	260954
380	4024	193960
223	5359	190076
4	8	174305
398	4723	146735
388	4974	140588
380	4031	139731
270	2763	87324
380	4030	84274
278	3435	83196
258	2433	81033
278	2572	80810
*/

*/