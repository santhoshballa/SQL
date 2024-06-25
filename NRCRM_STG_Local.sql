/****** Object:  Table [Orders].[Orders]    Script Date: 12/11/2020 10:45:06 AM ******/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[Orders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[MemberChartDataId] [bigint] NOT NULL,
	[OrderType] [varchar](10) NOT NULL,
	[MemberData] [nvarchar](4000) NOT NULL,
	[OrderAmountData] [nvarchar](4000) NOT NULL,
	[ShippingData] [nvarchar](4000) NOT NULL,
	[ProviderData] [nvarchar](4000) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Source] [varchar](20) NULL,
	[Amount] [float] NOT NULL,
	[NHMemberId] [nvarchar](20) NOT NULL,
	[RefOrderId] [bigint] NULL,
	[DateOrderReceived] [datetime] NOT NULL,
	[DateOrderInitiated] [datetime] NOT NULL,
	[SpecialInstructions] [varchar](1500) NULL,
	[EarmoldInstructions] [varchar](1500) NULL,
	[CreateUser] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUser] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[OrderStatusCode] [nvarchar](3) NOT NULL,
	[OrderBy] [nvarchar](50) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[BenefitsData] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO





select

'select top 40 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_NAME = 'orders'
and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')

select top 1 * from information_Schema.columns


select top 10 * from information_schema.columns 

select distinct data_type from information_schema.columns 

select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderID] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'MemberChartDataId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberChartDataId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderType] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'MemberData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderAmountData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderAmountData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ShippingData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ShippingData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ProviderData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProviderData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'Status' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Status] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'Source' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Source] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'Amount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Amount] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'NHMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([NHMemberId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'RefOrderId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([RefOrderId] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'DateOrderReceived' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderReceived] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'DateOrderInitiated' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DateOrderInitiated] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'SpecialInstructions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SpecialInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'EarmoldInstructions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([EarmoldInstructions] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'CreateUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateUser] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'CreateDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CreateDate] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ModifyUser' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyUser] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'ModifyDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ModifyDate] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderStatusCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderStatusCode] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'OrderBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OrderBy] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'IPAddress' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IPAddress] as nvarchar))),'"') as VALUE from Orders.[Orders]) a union 
select top 40 * from  (select distinct  'Orders' as TABLE_SCHEMA,'Orders' as TABLE_NAME,'BenefitsData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitsData] as nvarchar))),'"') as VALUE from Orders.[Orders]) a