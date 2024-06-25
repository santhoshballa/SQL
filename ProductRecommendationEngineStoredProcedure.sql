
/*
Author : Santhosh Balla
Date : 07-12-2022

Product Recommendation Engine
This stored procedure will create the list of products based on a few strategies

1.	If a member buys a product, he is more likely to buy it again.
2.	If another member in his plan buys a product, more than likely he might have an interest to buy
3.	If most members bought a product, more than likely a particular member would love to buy, the top ten products bought during the last 6 months or a frequency period. This includes All Carriers
4.	Browsing history of the member -- This is current not available
5.	Products in his cart and not bought. This is currently not available

The input parameters/variables are the members NHMemberID, Insurance Carrier ID and the Insurance Health Plan ID.

exec [elig].[sp_ProductRecommendationEngine] 'NH202210707408',258,2433 -- works
exec [elig].[sp_ProductRecommendationEngine] 'NH202210707408',258, NULL -- works


declare @vInsuranceCarrierID int = 20
declare @vInsuranceHealthPlanID int = 224

select distinct b.InsuranceCarrierID, c.InsuranceCarrierName, b.InsuranceHealthPlanID, d.HealthPlanName
from master.members a 
left join master.MemberInsurances b on a.MemberID = b.MemberID
left join insurance.InsuranceCarriers c on b.InsuranceCarrierID = c.InsuranceCarrierID
left join insurance.InsuranceHealthPlans d on b.InsuranceHealthPlanID = d.InsuranceHealthPlanID
where a.IsActive = 1 and b.IsActive = 1 -- order by b.InsuranceCarrierID
--and b.InsuranceCarrierID =  @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )
order by b.InsuranceCarrierID

declare @vInsuranceCarrierID int = 302
declare @vInsuranceHealthPlanID int = 2697

-- Sample MemberID's, InsuranceCarrierID and InsuranceHealthPlanID
select top 100 a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID
from master.members a left join master.MemberInsurances b on a.MemberID = b.MemberID
where a.IsActive = 1 and b.IsActive = 1 -- order by b.InsuranceCarrierID
and b.InsuranceCarrierID =  @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )
order by b.InsuranceCarrierID

declare @vInsuranceCarrierID int = 302
declare @vInsuranceHealthPlanID int = 2697


-- Generate the execute statements for Testing
select top 10 
'exec [elig].[sp_ProductRecommendationEngine] ' + ''''+ a.NHMemberID + '''' + ',' + Cast(b.InsuranceCarrierID as nvarchar) + ',' + cast(b.InsuranceHealthPlanID as nvarchar)
from master.members a left join master.MemberInsurances b on a.MemberID = b.MemberID
where a.IsActive = 1 and b.IsActive = 1
and b.InsuranceCarrierID = @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )


exec [elig].[sp_ProductRecommendationEngine] 'NH201901959511',5,12
exec [elig].[sp_ProductRecommendationEngine] 'NH202005639868',5,12

exec [elig].[sp_ProductRecommendationEngine] 'NH202005604639',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605229',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605320',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605855',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005606854',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005607826',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005608010',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005608452',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005609797',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005610906',302,2697

*/


ALTER PROCEDURE [elig].[sp_ProductRecommendationEngine]
(
  @NHMemberID nvarchar(20)
 ,@InsuranceCarrierID int
 ,@InsuranceHealthPlanID int
)
AS

declare @procedureName VARCHAR(100) = 'sp_ProductRecommendationEngine'
declare @vNHMemberID nvarchar(20)
declare @vInsuranceCarrierID int
declare @vInsuranceHealthPlanID int
declare @vAllItems float
declare @vPlanItems float
declare @vMemberItems float

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
SET NOCOUNT ON

BEGIN TRY

set @vNHMemberID = @NHMemberID
set @vInsuranceCarrierID = @InsuranceCarrierID
set @vInsuranceHealthPlanID = @InsuranceHealthPlanID

If @vNHMemberID is null or @vNHMemberID = ''
begin
		select 'NHMemberID is not Provided'
		Return 0
end

If @vInsuranceCarrierID is null or @vInsuranceCarrierID = ''
begin
		select 'Insurance Carrier ID is not Provided'
		Return 0
end

If @vInsuranceHealthPlanID is null or @vInsuranceCarrierID = ''
begin
		select 'Insurance Health Plan ID is not Provided'
		Return 0
end

BEGIN TRANSACTION RecommendationEngine

IF OBJECT_ID('tempdb..#TAllOrdersOrderItems') IS NOT NULL DROP TABLE #TAllOrdersOrderItems 


select 'Step 1 | Select All Orders '

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


select 'Step 2 | Select Orders at Plan Level '

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

--select top 10 * from #TOrdersOrderItems

-- Ratio of all Items


select 'Step 3 | Find total number of Items at all three levels (All Plans, Plan level, Member Level )'

select @vAllItems = sum(Quantity) from #TAllOrdersOrderItems
select @vPlanItems = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vMemberItems = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @vNHMemberID  -- Particular Member

/*
select @vAllTotalItems = Count(*) from #TAllOrdersOrderItems
select @vTotalItems = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vTotalItemsNHMemberID = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @VNHMemberID  -- Particular Member
*/

-- ALL Products All Carriers

select 'Step 4 | Calculate attribution Ratios for all plans )'

IF OBJECT_ID('tempdb..#TAllItems') IS NOT NULL DROP TABLE #TAllItems 

select * into #TAllItems from (
select ItemCode as AllItemCode, ItemName as AllItemName, Sum(Quantity) as AllNumberOfItems, Round(Cast((Sum(Quantity)/@vAllItems) as float), 4) as AllItemRatio  from #TALLOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TAllTotalItemRatio order by AllTotalItemRatio desc


select 'Step 5 | Calculate attribution Ratios for a plan )'
-- All Products within a Carrier and a Health Plan
IF OBJECT_ID('tempdb..#TPlanItems') IS NOT NULL DROP TABLE #TPlanItems

select * into #TPlanItems from (
select ItemCode as PlanLevelItemCode, ItemName as PlanLevelItemName, Sum(Quantity) as PlanNumberOfItems, Round(Cast((Sum(Quantity)/@vPlanItems) as float), 4) as PlanLevelItemRatio  from #TOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TTotalItemRatio


select 'Step 6 | Calculate attribution Ratios for a member )'
-- All Products bought by a Member
IF OBJECT_ID('tempdb..#TMemberItems') IS NOT NULL DROP TABLE #TMemberItems 
select * into #TMemberItems from (
select ItemCode as MemberItemCode, ItemName as MemberItemName, Sum(Quantity) as MemberNumberOfItems, Round(Cast((Sum(Quantity)/@vMemberItems) as float), 4) as MemberLevelRatio  from #TOrdersOrderItems where NHMemberID =  @vNHMemberID
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

select 'Step 6 | Calculate attribution Ratios for a member ) | Complete'
--select * from #TTotalItemNHMemberIDRatio

select 'Step 7 | Final attribution ratio )'

select top 10  @vNHMemberID as 'NHMemberID', a.*, b.*, c.* , (isnull(AllItemRatio,0) + isnull(PlanLevelItemRatio,0) + isnull(MemberLevelRatio, 0)) as WeightedValue 
from #TAllItems a 
left join #TPlanItems b on a.AllItemCode = b.PlanLevelItemCode
left join #TMemberItems c on b.PlanLevelItemCode = c.MemberItemCode
where MemberLevelRatio is not null
order by WeightedValue desc

commit transaction RecommendationEngine

END try


BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION RecommendationEngine
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END

GO


