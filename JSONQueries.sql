select Top 10 * from Orders.Orders

select Top 10 ShippingData from Orders.Orders


{"providerBusinessName":"Darrell M. Sipe Opticians and Hearing Aids",
"dispenser":"G154442",
"dba":"",
"address":{
"address":"2030 THISTLE HILL DRIVE",
			"address1":"2030 THISTLE HILL DRIVE",
			"address2":"Suite 207",
			"city":"SPRING GROVE",
			"state":"PA",
			"zip":"17362",
			"country":"USA"
			},
"email":"",
"shippingInstructions":"",
"manufacturer":"GNR",
"phoneNumber":"7176325558",
"faxNumber":"7654597100"
}

select count(*) from Orders.Orders
select count(*) from Orders.Orders where ISJSON(ShippingData) > 0

select JSON_VALUE(Orders.ShippingData, '$.shippingInstructions') as ShippingInstructions from  Orders.Orders 
where 1=1 and
ISJSON(ShippingData) > 0 and 
(JSON_VALUE(Orders.ShippingData, '$.shippingInstructions') is not null and len(rtrim(ltrim(JSON_VALUE(Orders.ShippingData, '$.shippingInstructions'))))>0)


select top 10  * from orders.Ordertransactiondetails


select top 10 * from Orders.OrderTransactionDetails
select top 10 * from Orders.OrderTransactionDetails

select OTD.OrderID, OTD.OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$.ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$.ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$.ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT

from
 Orders.OrderTransactionDetails OTD where isjson(OrderTransactionData) > 0 and OrderStatusCode = 'SHI'

select distinct orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1


from
 Orders.OrderTransactionDetails OTD where isjson(OrderTransactionData) > 0 and OrderStatusCode = 'SHI'
 and JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') = ''


select * from openjson(OrderTransactionData) 

declare @json nvarchar(max)
set @json = N'
[
{
"InvoiceNumber":"131272242",
"ShipDate":null,
"ShippingMethod":"UPS",
"ShippingStatus":"Shipped",
"ReceivedMethod":"EDI",
"ShipmentTracking":"1Z81075W1307818273",
"urlforTracking":"https://www.ups.com/track?loc=en_US&tracknum=1Z81075W1307818273&requester=MB/"
}
]';

select * from openjson(@json) with 
(InvoiceNumber nvarchar(100) '$.InvoiceNumber',
 ShipDate nvarchar(20) '$.ShipDate',
 ShippingMethod nvarchar(20) '$.ShippingMethod',
 ShippingStatus nvarchar(20) '$.ShippingStatus',
 ShipmentTracking nvarchar(20) '$.ShipmentTracking'
 )


 select OrderTransactionID, OrderID,
 JSON_VALUE(OrderTransactionData, N'strict $.ShipDate'),
 JSON_VALUE(OrderTransactionData, N'strict $.ShippingMethod'),
 JSON_VALUE(OrderTransactionData, N'strict $.ShipmentTracking')
 from
 Orders.OrderTransactionDetails
 where JSON_VALUE(OrderTransactionData, N'strict $.ShipDate') is not null

 select count(*) from  Orders.OrderTransactionDetails
 select isjson(OrderTransactionData) from Orders.OrderTransactionDetails



declare @json nvarchar(max)
set @json = N'
[{
"InvoiceNumber":"131272242",
"ShipDate":null,
"ShippingMethod":"UPS",
"ShippingStatus":"Shipped",
"ReceivedMethod":"EDI",
"ShipmentTracking":"1Z81075W1307818273",
"urlforTracking":"https://www.ups.com/track?loc=en_US&tracknum=1Z81075W1307818273&requester=MB/"
}]
';

select JSON_QUERY(@json,'$')


declare @json nvarchar(max)
set @json = '[{
"InvoiceNumber":"131272242",
"ShipDate":null,
"ShippingMethod":"UPS",
"ShippingStatus":"Shipped",
"ReceivedMethod":"EDI",
"ShipmentTracking":"1Z81075W1307818273",
"urlforTracking":"https://www.ups.com/track?loc=en_US&tracknum=1Z81075W1307818273&requester=MB/"
}]';
select (SUBSTRING(@json, 2, (LEN(@json)-2)))


select  
JSON_VALUE((SUBSTRING(@json, 2, (LEN(@json)-2))), N'strict $.ShipDate'),
JSON_VALUE((SUBSTRING(@json, 2, (LEN(@json)-2))), N'strict $.ShippingMethod'),
JSON_VALUE((SUBSTRING(@json, 2, (LEN(@json)-2))), N'strict $.ShipmentTracking')

select top 1 * from Orders.OrderTransactionDetails
/*
OrderTransactionID	OrderID	OrderStatusCode	OrderTransactionData	IsComplete	CreateDate	CreateUser	ModifyDate	ModifyUser	IsActive
7	180000001	ACK	{"orderConfirmationNumber":"10-A297515","orderConfirmationDate":""}	0	2018-03-23 02:23:43.053	VanillaSoftOrderLoader	2018-09-28 16:12:06.323	SystemUser	1
*/

select  OrderTransactionID, OrderID,
JSON_VALUE((SUBSTRING(OrderTransactionData, 2, (LEN(OrderTransactionData)-2))),  '$.ShipDate'),
JSON_VALUE((SUBSTRING(OrderTransactionData, 2, (LEN(OrderTransactionData)-2))), '$.ShippingMethod'),
JSON_VALUE((SUBSTRING(OrderTransactionData, 2, (LEN(OrderTransactionData)-2))), '$.ShipmentTracking')

 from
 Orders.OrderTransactionDetails where isjson(OrderTransactionData) > 0 and OrderStatusCode = 'SHI'





 select * from Orders.OrderTransactionDetails where isjson(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID = '180018597'

 
select distinct orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1


from
 Orders.OrderTransactionDetails OTD where isjson(OrderTransactionData) > 0 and OrderStatusCode = 'SHI'
 and JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') = ''


 -- Difference between a JSON OBJECT and a JSON ARRAY and how to access using the JSON Path

--Example 1 | JSON ARRAY, since the document starts with [ and ends with ]
declare @json nvarchar(max)
set @json = 
'[
{"InvoiceNumber":"14-B984462","ShipDate":"","ShippingMethod":"FDEN","ShippingStatus":"Shipped","ReceivedMethod":"EDI","ShipmentTracking":"789934409748","urlforTracking":"https://www.fedex.com/apps/fedextrack/index.html?action=track&tracknumbers=789934409748&locale=en_US&cntry_code=en"},
{"InvoiceNumber":"14-B984696","ShipDate":null,"ShippingMethod":"FDEN","ShippingStatus":"Shipped","ReceivedMethod":"EDI","ShipmentTracking":"789938239648","urlforTracking":"https://www.fedex.com/apps/fedextrack/index.html?action=track&tracknumbers=789938239648&locale=en_US&cntry_code=en"}
]'

select 
JSON_VALUE(@json,'$[0].ShipDate') as SHIPMENT_DT, 
JSON_VALUE(@json, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(@json, '$[0].ShipmentTracking') as SHIPMENT_TRACKING

select 
JSON_VALUE(@json,'$[1].ShipDate') as SHIPMENT_DT, 
JSON_VALUE(@json, '$[1].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(@json, '$[1].ShipmentTracking') as SHIPMENT_TRACKING



DECLARE @json NVARCHAR(MAX);
SET @json=N'{"person":{"info":{"name":"John", "name":"Jack"}}}';
SELECT value
FROM OPENJSON(@json,'$.person.info');


--Example 1 | JSON OBJECT, since the document starts with { and ends with }
declare @json nvarchar(max)
set @json = 
'{
"ShippingDetails":[
{"InvoiceNumber":"14-B984462","ShipDate":"","ShippingMethod":"FDEN","ShippingStatus":"Shipped","ReceivedMethod":"EDI","ShipmentTracking":"789934409748","urlforTracking":"https://www.fedex.com/apps/fedextrack/index.html?action=track&tracknumbers=789934409748&locale=en_US&cntry_code=en"},
{"InvoiceNumber":"14-B984696","ShipDate":null,"ShippingMethod":"FDEN","ShippingStatus":"Shipped","ReceivedMethod":"EDI","ShipmentTracking":"789938239648","urlforTracking":"https://www.fedex.com/apps/fedextrack/index.html?action=track&tracknumbers=789938239648&locale=en_US&cntry_code=en"}
]
}'

select 
JSON_VALUE(@json,'$.ShippingDetails[0].ShipDate') as SHIPMENT_DT, 
JSON_VALUE(@json, '$.ShippingDetails[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(@json, '$.ShippingDetails[0].ShipmentTracking') as SHIPMENT_TRACKING

select 
JSON_VALUE(@json,'$.ShippingDetails[1].ShipDate') as SHIPMENT_DT_1, 
JSON_VALUE(@json, '$.ShippingDetails[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(@json, '$.ShippingDetails[1].ShipmentTracking') as SHIPMENT_TRACKING_1

