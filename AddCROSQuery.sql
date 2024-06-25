/*
select * from orders.orders where orderid = 203107238

declare @orderid bigint, @itemcode varchar(50)
set @orderid = 203107238 set @itemcode = 'SIAX_CROS_CHARGEANDGO'
   
select BrandCode,FamilyCode,StyleCode,TechnologyCode,ModelCode,ItemCode,* from catalog.ItemMasterList where ItemCode in (@itemcode)
--select * from catalog.ItemMasterAttributeValues where ItemCode = @itemcode
--and isactive = 1
--order by 2
--end
-- Add CROS
select BrandCode,FamilyCode,StyleCode,TechnologyCode,ModelCode,ItemCode,* from catalog.ItemMasterList where ItemCode in (@itemcode)
select * from catalog.ItemMasterAttributeValues where ItemCode = @itemcode
select * from orders.orderitems where orderid = 203107238
*/


declare @OrderID nvarchar(20) =  '203107238'
declare @ItemCode nvarchar(1000) = 'SIAX_CROS_CHARGEANDGO'
declare @Modifier nvarchar(10) = ''   -- Modifier is the left or the right year
declare @CrosModifier nvarchar(10) = ''
declare @Quantity nvarchar(10) = ''
declare @Amount nvarchar(10) = ''
declare @UnitPrice nvarchar(10) = ''
declare @PairPrice nvarchar(10) = ''
declare @ItemType nvarchar(10) = ''
declare @ItemData nvarchar(2000) = ''
declare @OrderAmountData nvarchar(4000) = ''
select @OrderAmountData = OrderAmountData from orders.orders where OrderID = @OrderID
-- select @OrderID, @ItemCode, @OrderAmountData

--select BrandCode,FamilyCode,StyleCode,TechnologyCode,ModelCode,ItemCode,* from catalog.ItemMasterList where ItemCode in (@itemcode)
--select * from orders.OrderItems where OrderID = 203107238

select @Modifier = Modifier from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @Quantity = Quantity from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @Amount = Amount from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @UnitPrice = UnitPrice from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @PairPrice = PairPrice from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @ItemData = ItemData from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'
select @ItemType = ItemType from Orders.OrderItems where OrderID = 203107238 and ItemType = 'HA'


-- select @Modifier as Modifier , @Quantity as Quantity, @Amount as Amount,  @UnitPrice as UnitPrice, @PairPrice as PairPrice, @ItemData as ItemData, @ItemType as ItemType


if (@Modifier = 'RT') 
	begin;
	 set @CrosModifier = 'LT'
	end;
else
	begin;
	set @CrosModifier = 'RT'
	end;

-- select @CrosModifier

-- Metadata
select '/*'
select 
'select BrandCode,FamilyCode,StyleCode,TechnologyCode,ModelCode,ItemCode,* from catalog.ItemMasterList where ItemCode in (@itemcode)'

select 
'select * from catalog.ItemMasterAttributeValues where ItemCode = @ItmeCode' + ' -- and isactive = 1' + ' -- order by 2 ' 

select '*/'


select
'declare @OrderID bigint, @ItemCode nvarchar(50) set @OrderID = ' + @OrderID + ' set @ItemCode = ' + ''''+ @ItemCode + ''''


-- First Select Statement


select
'INSERT INTO Orders.OrderItems select '+
'@OrderID' + 
',' +''''+ BrandCode + ''''+
',' +''''+ FamilyCode + ''''+ 
',' +''''+ StyleCode + ''''+ 
',' +''''+ TechnologyCode + ''''+ 
',' +''''+ ModelCode + ''''+ 
',' +''''+ @ItemCode + ''''+ 
',' +''''+ @CrosModifier + ''''+ 
',' + @Quantity  + 
',' + @Amount +
',' +''''+ 'Active' + ''''+
',' + @UnitPrice + 
',' + @PairPrice + 
    +'--'+ ''''+ @ItemData + ''''+
', ' +''''+ @ItemData + ''''+
',' +''''+ 'Cross'+''''+
',' +'NULL'+
',' +'NULL'+
',' +''''+ 'LJuleseus' + ''''+
',' +'getdate()'+
',' +''''+ 'LJuleseus' + ''''+
',' +'getdate()'+
',' + '1'+
',' +'NULL'

from catalog.ItemMasterList where ItemCode = @ItemCode

-- First Update statment
select
'update o set o.OrderAmountData = '+ '''' + @OrderAmountData + '''' + '--'+ @OrderAmountData+ ',' + 'Amount = 0 ' + ' from orders.orders o where OrderID = ' + '@orderID'
from orders.orders where OrderID = @orderID



/* Output

update o set o.OrderAmountData = 
 '{"productPrice":2500.0,"productPriceDetails":{"originalPrice":2500.0,"details":null},"insuranceBenefit":null,"benefitUsed":null,"benefitAvailable":null,"medicaidBenefit":null,"adjustmentDetails":[],"adjustments":0.0,"appliedCredit":null,"memberResponsibility":0.0,"unitPrice":2500.0,"pairPrice":5000.0,"forwardCredits":null,"refundDetails":null}'
--{"productPrice":2500.0,"productPriceDetails":{"originalPrice":2500.0,"details":null},"insuranceBenefit":null,"benefitUsed":null,"benefitAvailable":null,"medicaidBenefit":null,"adjustmentDetails":[],"adjustments":0.0,"appliedCredit":null,"memberResponsibility":0.0,"unitPrice":2500.0,"pairPrice":5000.0,"forwardCredits":null,"refundDetails":null}
,Amount = 0  from orders.orders o where OrderID = @orderID

*/

declare @BenefitsData nvarchar(2000) = ''
select @BenefitsData = BenefitsData from orders.orders where OrderID = @OrderID

-- Second Update Statement
select 
'update o set o.BenefitsData = '+''''+ @BenefitsData + ''''+ '--'+ @BenefitsData+ ' from orders.orders o where OrderID = ' + '@OrderID'
from orders.orders where OrderID = @OrderID

/* Output
update o set o.BenefitData = '{"applied":{"benefitsLeft":2500,"benefitsRight":2500},"eligible":{"benefitsRight":2500,"benefitsLeft":2500},"used":{"benefitsRight":0,"benefitsLeft":0},"available":{"benefitsRight":2500,"benefitsLeft":2500},"remaining":{"benefitsLeft":0,"benefitsRight":0},"benefitAppliedAmount":5000,"outOfPocket":0,"bencat":"Amount","technologyLevel":"Advancedplus","benfortype":"Per Ear","benfreqtype":"CY"}'
							--{"applied":{"benefitsLeft":2500,"benefitsRight":2500},"eligible":{"benefitsRight":2500,"benefitsLeft":2500},"used":{"benefitsRight":0,"benefitsLeft":0},"available":{"benefitsRight":2500,"benefitsLeft":2500},"remaining":{"benefitsLeft":0,"benefitsRight":0},"benefitAppliedAmount":5000,"outOfPocket":0,"bencat":"Amount","technologyLevel":"Advancedplus","benfortype":"Per Ear","benfreqtype":"CY"} 
							from orders.orders o where OrderID = @OrderID

*/