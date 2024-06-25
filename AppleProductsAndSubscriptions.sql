/*
Apple Products and Data Plan Subscription

*/

select * from master.members where lastname like 'Gandhi' and firstname = 'Meena'
select NhMemberID, Cardnumber from otc.cards where NhmemberID in ( select NhMemberID from master.members where lastname like 'Gandhi' and firstname = 'Meena')

select * from orders.Orders where OrderID = 200612365
select * from orders.OrderItems where OrderID = 200612365
select * from orders.orderitemdetails where orderid = 200612365
select * from orders.OrderTransactionDetails where orderid = 200612365

select * from otccatalog.ItemMaster where ItemName like 'apple%'
select * from otccatalog.ItemMaster where NationsID in (8007,8005,8004,8006) -- Apple Products and Subscription


select * from orders.orders where NHMemberID in ('NH202106946362')

select * from orders.Orders where OrderID in (select OrderID from orders.OrderItems where ItemData like '%IsDataPlan%'  )
select * from orders.OrderItems where OrderID in  (select OrderID from orders.OrderItems where ItemData like '%IsDataPlan%' )
select * from orders.orderitemdetails where orderid in (select OrderID from orders.OrderItems where ItemData like '%IsDataPlan%' )
select * from orders.OrderTransactionDetails where orderid in (select OrderID from orders.OrderItems where ItemData like '%IsDataPlan%' )

