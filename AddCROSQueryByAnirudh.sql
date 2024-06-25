declare @orderid bigint, @itemcode varchar(50)
set @orderid = 203112450 set @itemcode = 'CROSBICROS_STARKEY.EVOLV AI.CROSBICROS.RIC.312.NA'
if(1=1)
begin
drop table if exists #results19
create table #results19(Cros varchar(max))
insert into #results19
values ('')
insert into #results19
values ('')
insert into #results19
values ('')
insert into #results19
values ('')
insert into #results19
values ('')
insert into #results19
values ('declare @orderid bigint, @itemcode varchar(50)')
insert into #results19
values ('set @orderid = '+cast(@orderid as varchar(50))+' set @itemcode = '''+@itemcode+'''')
insert into #results19
values ('')
insert into #results19
values ('-- Add CROS')
insert into #results19
values ('')
insert into #results19
values ('INSERT INTO ORDERS.OrderItems')
insert into #results19
values ('select')
insert into #results19
values ('--OrderId,BrandCode,FamilyCode,StyleCode,TechnologyLevelCode,ProductModelCode,ItemCode,Ear,Amount,UnitPrice,PairPrice')
insert into #results19
select CROS ='@orderid' +','''+BrandCode+''','''+FamilyCode+''','''+StyleCode+''','''+TechnologyCode+''','''+ModelCode+''','''+i.ItemCode+''','''
+case when o.Modifier = 'RT' THEN 'LT' else 'RT' end+''',1,'+cast(o.Amount as varchar)+','''+o.[Status]+''','+cast(o.UnitPrice as varchar)+','+cast(o.PairPrice as varchar)
from catalog.ItemMasterList i
left join (select Modifier,Itemcode,IsActive,Amount,UnitPrice,PairPrice,[Status],ItemData,ItemType from orders.orderitems where OrderId = @orderid)o on i.IsActive = o.IsActive and o.ItemType = 'HA' and o.[Status] = 'ACTIVE'
where i.ItemCode in (@itemcode)
insert into #results19
select '--'''+ItemData+'''' from orders.orderitems o
where o.OrderId = @orderid and o.ItemType = 'HA' and o.[Status] = 'Active'
insert into #results19
select ', '''+ItemData+'''' from orders.orderitems o
where o.OrderId = @orderid and o.ItemType = 'HA' and o.[Status] = 'Active'
insert into #results19
values(',''CROS'',NULL,NULL,''LJuleseus'',getdate(),''LJuleseus'',getdate(),1,NULL')
insert into #results19
values ('')
insert into #results19
values ('-- Update amounts in OrderData and BenefitData JSON''s')
declare @OrderAmountData nvarchar(4000) = ''
select @OrderAmountData = OrderAmountData from orders.orders where OrderID = @OrderID
insert into #results19
select
'update o'
from orders.orders where OrderID = @orderID
insert into #results19
select
+ 'set o.OrderAmountData = '+ '''' + @OrderAmountData + ''''
from orders.orders where OrderID = @orderID
insert into #results19
select
' '+' '+' --'+ @OrderAmountData
from orders.orders where OrderID = @orderID
insert into #results19
select
',Amount = 0 '
from orders.orders where OrderID = @orderID
insert into #results19
select
'-- declare @orderid bigint set @orderid = '+cast(@orderid as varchar(50))+' select *'
from orders.orders where OrderID = @orderID
insert into #results19
select
' from orders.orders o'
from orders.orders where OrderID = @orderID
insert into #results19
select
'where OrderID = ' + '@orderID'
from orders.orders where OrderID = @orderID
-- Second Update Statement
declare @BenefitsData nvarchar(2000) = ''
select @BenefitsData = BenefitsData from orders.orders where OrderID = @OrderID
insert into #results19
values ('')
insert into #results19
select
'update o'
from orders.orders where OrderID = @orderID
insert into #results19
select
+ 'set o.BenefitsData = '+ '''' + @BenefitsData + ''''
from orders.orders where OrderID = @orderID
insert into #results19
select
' '+' '+' --'+ @BenefitsData
from orders.orders where OrderID = @orderID
insert into #results19
select
' from orders.orders o'
from orders.orders where OrderID = @orderID
insert into #results19
select
'where OrderID = ' + '@orderID'
from orders.orders where OrderID = @orderID



select * from #results19
--check if correct COMMENT OUT
select * from orders.orders where OrderId in (@orderid)
select * from orders.orderitems where OrderId = @orderid
select BrandCode,FamilyCode,StyleCode,TechnologyCode,ModelCode,ItemCode,* from catalog.ItemMasterList where ItemCode in (@itemcode)
select * from catalog.ItemMasterAttributeValues where ItemCode = @itemcode
and isactive = 1
order by 2
end