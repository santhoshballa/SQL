select distinct table_name from information_schema.columns where TABLE_SCHEMA in ('PaymentGateway')
select distinct ''''+table_name+''''+ ',' from information_schema.columns where TABLE_SCHEMA in ('PaymentGateway')

select * from information_schema.columns where table_schema = 'PaymentGateway'


select distinct 'select '+ ''''+table_schema+'.'+ table_name +''''+ 'as TableName' +','+ 'count(*) as RecordCount from ' + table_schema + '.' + table_name + ' Union ' from information_schema.columns 
where TABLE_SCHEMA in ('PaymentGateway') 

select * from (

select 'PaymentGateway.AuthorizedTransactions'as TableName,count(*) as RecordCount from PaymentGateway.AuthorizedTransactions Union 
select 'PaymentGateway.BenefitSpendingTypes'as TableName,count(*) as RecordCount from PaymentGateway.BenefitSpendingTypes Union 
select 'PaymentGateway.CapturedTransactions'as TableName,count(*) as RecordCount from PaymentGateway.CapturedTransactions Union 
select 'PaymentGateway.CardType'as TableName,count(*) as RecordCount from PaymentGateway.CardType Union 
select 'PaymentGateway.CurrencyType'as TableName,count(*) as RecordCount from PaymentGateway.CurrencyType Union 
select 'PaymentGateway.InvoiceData'as TableName,count(*) as RecordCount from PaymentGateway.InvoiceData Union 
select 'PaymentGateway.InvoicePaymentTransactionLog'as TableName,count(*) as RecordCount from PaymentGateway.InvoicePaymentTransactionLog Union 
select 'PaymentGateway.PaymentProcessorAdmin'as TableName,count(*) as RecordCount from PaymentGateway.PaymentProcessorAdmin Union 
select 'PaymentGateway.PaymentProcessor'as TableName,count(*) as RecordCount from PaymentGateway.PaymentProcessor Union 
select 'PaymentGateway.PaymentTypes'as TableName,count(*) as RecordCount from PaymentGateway.PaymentTypes Union 
select 'PaymentGateway.ProcessEnvironment'as TableName,count(*) as RecordCount from PaymentGateway.ProcessEnvironment Union 
select 'PaymentGateway.ProcessType'as TableName,count(*) as RecordCount from PaymentGateway.ProcessType Union 
select 'PaymentGateway.RegisteredSources'as TableName,count(*) as RecordCount from PaymentGateway.RegisteredSources Union 
select 'PaymentGateway.ReProcessRequests'as TableName,count(*) as RecordCount from PaymentGateway.ReProcessRequests Union 
select 'PaymentGateway.TransactionLog'as TableName,count(*) as RecordCount from PaymentGateway.TransactionLog
) a
order by a.RecordCount desc


/*
TableName	RecordCount
PaymentGateway.TransactionLog	201991
PaymentGateway.AuthorizedTransactions	105671
PaymentGateway.CapturedTransactions	94169
PaymentGateway.ReProcessRequests	472
PaymentGateway.ProcessEnvironment	39
PaymentGateway.PaymentProcessor	15
PaymentGateway.BenefitSpendingTypes	8
PaymentGateway.PaymentProcessorAdmin	6
PaymentGateway.RegisteredSources	6
PaymentGateway.CardType	4
PaymentGateway.PaymentTypes	4
PaymentGateway.ProcessType	2
PaymentGateway.CurrencyType	1
PaymentGateway.InvoiceData	0
PaymentGateway.InvoicePaymentTransactionLog	0
*/


select distinct
'select top 100 * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'PaymentGateway'

select top 100 * from PaymentGateway.AuthorizedTransactions
select top 100 * from PaymentGateway.BenefitSpendingTypes
select top 100 * from PaymentGateway.CapturedTransactions
select top 100 * from PaymentGateway.CardType
select top 100 * from PaymentGateway.CurrencyType
select top 100 * from PaymentGateway.InvoiceData
select top 100 * from PaymentGateway.InvoicePaymentTransactionLog
select top 100 * from PaymentGateway.PaymentProcessor
select top 100 * from PaymentGateway.PaymentProcessorAdmin
select top 100 * from PaymentGateway.PaymentTypes
select top 100 * from PaymentGateway.ProcessEnvironment
select top 100 * from PaymentGateway.ProcessType
select top 100 * from PaymentGateway.RegisteredSources
select top 100 * from PaymentGateway.ReProcessRequests
select top 100 * from PaymentGateway.TransactionLog


select distinct
'select * from '+table_schema + '.' +table_name from information_schema.columns where table_schema = 'PaymentGateway'

select * from PaymentGateway.AuthorizedTransactions
select * from PaymentGateway.BenefitSpendingTypes
select * from PaymentGateway.CapturedTransactions
select * from PaymentGateway.CardType
select * from PaymentGateway.CurrencyType
select * from PaymentGateway.InvoiceData
select * from PaymentGateway.InvoicePaymentTransactionLog
select * from PaymentGateway.PaymentProcessor
select * from PaymentGateway.PaymentProcessorAdmin
select * from PaymentGateway.PaymentTypes
select * from PaymentGateway.ProcessEnvironment
select * from PaymentGateway.ProcessType
select * from PaymentGateway.RegisteredSources
select * from PaymentGateway.ReProcessRequests
select * from PaymentGateway.TransactionLog


select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where 1=1 and 
TABLE_SCHEMA in ('PaymentGateway') 
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select * from (

select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'AccountHolderName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountHolderName] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'PaymentTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'CardTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'AccountNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountNumber] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'ExpiryDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ExpiryDate] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'CVVCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CVVCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'Amount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'RoutingNumber' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RoutingNumber] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'BankName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BankName] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'CurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CurrencyCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address1] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'Address2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Address2] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'City' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([City] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'StateCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([StateCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'Zip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Zip] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'ProcessEnvironmentCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessEnvironmentCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'TransactionOrderRef' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionOrderRef] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'RespAuthenticationToken' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RespAuthenticationToken] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'RespTransactionStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RespTransactionStatus] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'ResponseDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseDescription] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'ProcessTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'TransactionComments' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionComments] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'RequestDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RequestDate] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'AuthorizedTransactions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[AuthorizedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'TransactionGroupAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([TransactionGroupAmount] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'AuthenticationToken' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AuthenticationToken] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'Amount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'RespSettlementStatus' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RespSettlementStatus] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'ResponseDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseDescription] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'RespCaptureAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RespCaptureAmount] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'CaptureDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CaptureDate] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CapturedTransactions' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[CapturedTransactions]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CardType' as TABLE_NAME,'AccountTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[CardType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CardType' as TABLE_NAME,'AccountTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([AccountTypeName] as nvarchar))),'"') as VALUE from PaymentGateway.[CardType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CurrencyType' as TABLE_NAME,'CurrencyCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CurrencyCode] as nvarchar))),'"') as VALUE from PaymentGateway.[CurrencyType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CurrencyType' as TABLE_NAME,'CurrencyName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CurrencyName] as nvarchar))),'"') as VALUE from PaymentGateway.[CurrencyType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'CurrencyType' as TABLE_NAME,'CurrencySymbol' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CurrencySymbol] as nvarchar))),'"') as VALUE from PaymentGateway.[CurrencyType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'PaymentProcessorName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentProcessorName] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'Username' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Username] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'Password' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Password] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'MerchantId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantId] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'ProcessEnvironmentCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessEnvironmentCode] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointURI' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointURI] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointAuthorize' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointAuthorize] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointCapture' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointCapture] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointDecline' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointDecline] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointRefund' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointRefund] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointVoid' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointVoid] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'ModifiedDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifiedDate] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessor' as TABLE_NAME,'EndpointInquire' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointInquire] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessor]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentTypes' as TABLE_NAME,'PaymentTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentTypes' as TABLE_NAME,'PaymentTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PaymentTypeName] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ProcessEnvironment' as TABLE_NAME,'ProcessEnvironmentCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessEnvironmentCode] as nvarchar))),'"') as VALUE from PaymentGateway.[ProcessEnvironment]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ProcessEnvironment' as TABLE_NAME,'ProcessEnvironmentName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessEnvironmentName] as nvarchar))),'"') as VALUE from PaymentGateway.[ProcessEnvironment]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ProcessType' as TABLE_NAME,'ProcessTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessTypeCode] as nvarchar))),'"') as VALUE from PaymentGateway.[ProcessType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ProcessType' as TABLE_NAME,'ProcessTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessTypeName] as nvarchar))),'"') as VALUE from PaymentGateway.[ProcessType]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'RegisteredSources' as TABLE_NAME,'SourceName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SourceName] as nvarchar))),'"') as VALUE from PaymentGateway.[RegisteredSources]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'TransactionLog' as TABLE_NAME,'Request' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Request] as nvarchar))),'"') as VALUE from PaymentGateway.[TransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'TransactionLog' as TABLE_NAME,'Response' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Response] as nvarchar))),'"') as VALUE from PaymentGateway.[TransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'TransactionLog' as TABLE_NAME,'ProcessRequest' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessRequest] as nvarchar))),'"') as VALUE from PaymentGateway.[TransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'TransactionLog' as TABLE_NAME,'ProcessResponse' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProcessResponse] as nvarchar))),'"') as VALUE from PaymentGateway.[TransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'ReProcessRequestId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReProcessRequestId] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'OrderTransactionId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderTransactionId] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'EndpointType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EndpointType] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'LastProcessDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LastProcessDate] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'NextProcessDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NextProcessDate] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'RequestData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RequestData] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'ResponseData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseData] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'ReferenceData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ReferenceData] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'ReProcessRequests' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[ReProcessRequests]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'InvoiceDataId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceDataId] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'InvoiceCheckData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceCheckData] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'InvoiceACHData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceACHData] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'InvoiceBatchId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoiceBatchId] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'IsCheckReady' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCheckReady] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'IsCheckProcessed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsCheckProcessed] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'CheckProcessDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CheckProcessDate] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'IsACHProcessed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsACHProcessed] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoiceData' as TABLE_NAME,'IsACHReady' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsACHReady] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoiceData]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoicePaymentTransactionLog' as TABLE_NAME,'InvoicePaymentTransactionLogId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoicePaymentTransactionLogId] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoicePaymentTransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoicePaymentTransactionLog' as TABLE_NAME,'InvoicePaymentEventId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InvoicePaymentEventId] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoicePaymentTransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoicePaymentTransactionLog' as TABLE_NAME,'RequestDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RequestDescription] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoicePaymentTransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoicePaymentTransactionLog' as TABLE_NAME,'ResponseDescription' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ResponseDescription] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoicePaymentTransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'InvoicePaymentTransactionLog' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[InvoicePaymentTransactionLog]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'ID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'URL' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([URL] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'Username' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Username] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'Password' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Password] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'MerchantId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MerchantId] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'MCCCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MCCCode] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'Remarks' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Remarks] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'PaymentProcessorAdmin' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from PaymentGateway.[PaymentProcessorAdmin]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'BenefitSpendingTypes' as TABLE_NAME,'BenefitSpendingId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingId] as nvarchar))),'"') as VALUE from PaymentGateway.[BenefitSpendingTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'BenefitSpendingTypes' as TABLE_NAME,'BenefitSpendingType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitSpendingType] as nvarchar))),'"') as VALUE from PaymentGateway.[BenefitSpendingTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'BenefitSpendingTypes' as TABLE_NAME,'Description' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Description] as nvarchar))),'"') as VALUE from PaymentGateway.[BenefitSpendingTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'BenefitSpendingTypes' as TABLE_NAME,'Isactive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Isactive] as nvarchar))),'"') as VALUE from PaymentGateway.[BenefitSpendingTypes]) a union 
select top 100 * from  (select distinct  'PaymentGateway' as TABLE_SCHEMA,'BenefitSpendingTypes' as TABLE_NAME,'MIDType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MIDType] as nvarchar))),'"') as VALUE from PaymentGateway.[BenefitSpendingTypes]) a

) b
order by b.table_name, b.column_name