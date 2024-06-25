
declare @FromOrder int, @ToOrder int
set @FromOrder = 200394295		-- OrderStatus	: Returned
set @ToOrder = 200401696		-- OrderStatus 	: Initiated

/*
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @FromOrder -- From Order
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @ToOrder -- To Order
select @ToOrder, 'PAY',JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),1,GETDATE(), 'rsareddy',GETDATE(),'cxavier',1 FROM orders.ordertransactiondetails WHERE 1=1 AND orderid = @FromOrder AND OrderStatusCode = 'PAY' AND IsActive = 1  -- Record to Insert
*/

declare @OrderID int = 200394295

select 'Orders.Orders' as TableName, * from Orders.Orders where orderid = @OrderID 
select 'Orders.OrderItems' as TableName,* from Orders.OrderItems where orderid = @OrderID
select 'Orders.OrderItemDetails' as TableName,* from Orders.OrderItemDetails where orderid = @OrderID
select 'Orders.OrderTransactionDetails' as TableName,* from orders.OrderTransactionDetails where orderid = @OrderID

-- MemberData, OrderAmountData, ShippingData, ProviderData, BenefitData

--declare @SearchPredicate nvarchar(50)
--set @SearchPredicate =  '200168318'

select
'select * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ 'OrderID' +']' + ' as nvarchar)))' + '='+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('orders')
and TABLE_NAME in ( 'Orders', 'OrderItems', 'OrderTransactionDetails','Orders.OrderItemDetails')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
order by table_schema, table_name

---- Order Details for Hearing Aid only
declare @SearchPredicate nvarchar(50)
set @SearchPredicate =  '200168318'

select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderItemId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'BrandCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'FamilyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'StyleCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'TechnologyLevelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ProductModelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Modifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Quantity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'UnitPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PairPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PairPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PONumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PONumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'InvoiceNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceNumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PreviousAmount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PreviousAmount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberChartDataId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberChartDataId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderAmountData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ProviderData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Source|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'RefOrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RefOrderId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderReceived|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderInitiated|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'SpecialInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpecialInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'EarmoldInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderBy] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IPAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IPAddress] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'BenefitsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitsData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionData] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsComplete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsComplete] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a union 
select * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar)))=@SearchPredicate) a





select
'select top 1 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' + ' where '+ 'ltrim(rtrim(cast(' +'['+ column_name +']' + ' as nvarchar)))' + ' like '+ '@SearchPredicate' + 
+ ') a union '
from  information_Schema.COLUMNS
where TABLE_SCHEMA in ('orders')
and TABLE_NAME in ( 'Orders', 'OrderItems', 'OrderTransactionDetails','Orders.OrderItemDetails')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
order by table_schema, table_name



select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderItemId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderItemId] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderId] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'BrandCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([BrandCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'FamilyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([FamilyCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'StyleCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([StyleCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'TechnologyLevelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ProductModelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ProductModelCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Modifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Modifier] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Quantity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Quantity] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Amount] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Status] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'UnitPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([UnitPrice] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PairPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PairPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PairPrice] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemType] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PONumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PONumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PONumber] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'InvoiceNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceNumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([InvoiceNumber] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PreviousAmount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PreviousAmount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PreviousAmount] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberChartDataId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberChartDataId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([MemberChartDataId] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderType] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([MemberData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderAmountData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderAmountData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([ShippingData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ProviderData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([ProviderData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Status] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Source|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Source] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Amount] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([NHMemberId] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'RefOrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RefOrderId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([RefOrderId] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderReceived|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([DateOrderReceived] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderInitiated|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'SpecialInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpecialInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([SpecialInstructions] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'EarmoldInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderBy] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderBy] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IPAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IPAddress] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([IPAddress] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'BenefitsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitsData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([BenefitsData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderTransactionID] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderStatusCode] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionData] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderTransactionData] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsComplete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsComplete] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([IsComplete] as nvarchar))) like @SearchPredicate) a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([IsActive] as nvarchar))) like @SearchPredicate) a




--To locate JSON data columns
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderItemId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderItemId] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([OrderId] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'BrandCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([BrandCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'FamilyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([FamilyCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'StyleCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([StyleCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'TechnologyLevelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ProductModelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ProductModelCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Modifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Modifier] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Quantity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Quantity] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Amount] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([Status] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'UnitPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([UnitPrice] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PairPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PairPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PairPrice] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([ItemType] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PONumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PONumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PONumber] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'InvoiceNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceNumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([InvoiceNumber] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([IsActive] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PreviousAmount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PreviousAmount] as nvarchar))),'"') as VALUE from Orders.[OrderItems] where ltrim(rtrim(cast([PreviousAmount] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderID] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberChartDataId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberChartDataId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([MemberChartDataId] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderType] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([MemberData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderAmountData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderAmountData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([ShippingData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ProviderData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([ProviderData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Status] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Source|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Source] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([Amount] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([NHMemberId] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'RefOrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RefOrderId] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([RefOrderId] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderReceived|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([DateOrderReceived] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderInitiated|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'SpecialInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpecialInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([SpecialInstructions] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'EarmoldInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([IsActive] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderStatusCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderBy] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([OrderBy] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IPAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IPAddress] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([IPAddress] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'BenefitsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitsData] as nvarchar))),'"') as VALUE from Orders.[Orders] where ltrim(rtrim(cast([BenefitsData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderTransactionID] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderID] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderStatusCode] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionData] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([OrderTransactionData] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsComplete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsComplete] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([IsComplete] as nvarchar))) like '%{%') a union 
select top 1 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails] where ltrim(rtrim(cast([IsActive] as nvarchar))) like '%{%') a


/*
--Columns containing JSON Data
TABLE_SCHEMA	TABLE_NAME	COLUMN_NAME	VALUE
Orders|	OrderItems|	ItemData|	"{""rightEar"":{""platform"":""CROS"
Orders|	Orders|	BenefitsData|	"{""applied"":{},""remaining"":{},"""
Orders|	Orders|	MemberData|	"{""insCarrierId"":334,""insPlanId"
Orders|	Orders|	OrderAmountData|	"{""productPrice"":1660,""insuranc"
Orders|	Orders|	ProviderData|	"{}"
Orders|	Orders|	ShippingData|	"{""providerBusinessName"":""Darre"
Orders|	OrderTransactionDetails|	OrderTransactionData|	"{""orderConfirmationNumber"":""10"
*/



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
where TABLE_SCHEMA in ('orders')
and TABLE_NAME in ( 'Orders', 'OrderItems', 'OrderTransactionDetails','OrderItemDetails')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')


select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'OrderItemDetailID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemDetailID] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'ItemCount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCount] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'ItemType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'ItemAmount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemAmount] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'ItemCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItemDetails|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderItemDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderItemId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderItemId] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'OrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderId] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'BrandCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BrandCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'FamilyCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FamilyCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'StyleCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StyleCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'TechnologyLevelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TechnologyLevelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ProductModelCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductModelCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemCode] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Modifier|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Modifier] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Quantity|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Quantity] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'UnitPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([UnitPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PairPrice|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PairPrice] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemData] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'ItemType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ItemType] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PONumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PONumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'InvoiceNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceNumber] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderItems|' as TABLE_NAME,'PreviousAmount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PreviousAmount] as nvarchar))),'"') as VALUE from Orders.[OrderItems]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberChartDataId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberChartDataId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderType|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'MemberData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderAmountData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ShippingData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'ProviderData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Status|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Source|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'Amount|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'NHMemberId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'RefOrderId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RefOrderId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderReceived|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'DateOrderInitiated|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'SpecialInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpecialInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'EarmoldInstructions|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'OrderBy|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderBy] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'IPAddress|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IPAddress] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'Orders|' as TABLE_NAME,'BenefitsData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitsData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderStatusCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'OrderTransactionData|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionData] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsComplete|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsComplete] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a union 
select top 40 * from  (select distinct  'Orders|' as TABLE_SCHEMA,'OrderTransactionDetails|' as TABLE_NAME,'IsActive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[OrderTransactionDetails]) a