--USE [NHCRM_STG]
--GO

--/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v4]    Script Date: 1/28/2021 6:51:32 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO






----exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

--CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v4]
--(
--@InClientCode varchar(20), -- H428 for Baycare
--@OutClientCode varchar(20), --Not in use
--@Filetype varchar(10) --FULL/Delta
--)
--AS
--BEGIN
--    -- SET NOCOUNT ON added to prevent extra result sets from
--SET NOCOUNT ON
--SET XACT_ABORT ON

--BEGIN TRY
----SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date
DECLARE @CurrentDateEST date
DECLARE @DATA_DATE date

SET @CurrentDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @DATA_DATE = FORMAT(@CurrentDateEST , 'yyyy-MM-dd')

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = GetDate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

--SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
SET @FileSubmitGrpId =  CAST(FORMAT(GETDATE(),'yyyyMMdd') AS nvarchar)+'01'

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)                                              

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (            SELECT o.[OrderID] 
                                                                                                                                                                                                FROM Orders.Orders o
                                                                                                                                                                                                WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
                                                                                                                                                                                                                                                                                                FROM [Master].[Members] m
                                                                                                                                                                                                                                                                                                WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
                                                                                                                                                                                                                                                                                                                                                                                FROM [elig].[mstrEligBenefitData] mefd
                                                                                                                                                                                                                                                                                                                                                                                WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
                                                                                                                                                                                                                                                                                                                                                                                and
                                                                                                                                                                                                                                                                                                                                                                                                (
                                                                                                                                                                                                                                                                                                                                                                                                                --Returns the previous month's day 1
                                                                                                                                                                                                                                                                                                                                                                                                                (@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
                                                                                                                                                                                                                                                                                                                                                                                                                (@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
                                                                                                                                                                                                                                                                                                                                                                                                )
                                                                                                                                                                                                                                                                                                                                                                                                and
                                                                                                                                                                                                                                                                                                                                                                                                ( 
                                                                                                                                                                                                                                                                                                                                                                                                                --Returns the Last Month's last day of the month
                                                                                                                                                                                                                                                                                                                                                                                                                (@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
                                                                                                                                                                                                                                                                                                                                                                                                                (@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
                                                                                                                                                                                                                                                                                                                                                                                                )
                                                                                                                                                                                                                                                                                                                                                                                )
                                                                                                                                                                                                                                                                                                )
                                                                                                                                                                                AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
                                                                                                                                                                                )
) A

--SELECT * FROM #OrderIDAndOrderItemIDTemp

--SELECT * FROM Orders.Orders where OrderID in (SELECT DISTINCT OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
--SELECT * FROM Orders.OrderItems where OrderItemID in (SELECT DISTINCT OrderItemID from #OrderIDAndOrderItemIDTemp)
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column


--SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
--,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE
,@DATA_DATE as DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
                WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE 'Ordered'
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
--,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT]

--CAST(
--                             (
--                             CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND CAST(OI.Amount AS decimal(10,2)) >= 0.0 THEN CAST(OI.Amount AS decimal(10,2))*(-1.0)
--                                             WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND CAST(OI.Amount AS decimal(10,2)) >= 0.0 THEN CAST(OI.Amount AS decimal(10,2))
--                             ELSE NULL
--                             END 
--                             ) 
--                             AS DECIMAL(10,2)
--             ) AS BILL_AMT
,cast(OI.Amount as decimal(10,2)) BILL_AMT

, cast(OI.UnitPrice as decimal(10,2)) [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(otd.OrderTransactionData, '$[0].shipDate') as SHIPMENT_DT
,JSON_VALUE(otd.OrderTransactionData, '$[0].carrier') as SHIPMENT_CARRIER
,JSON_VALUE(otd.OrderTransactionData, '$[0].trackingNumber') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]

,O.orderID as [ORIG_TRANSACTION_ID_OrderID],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(O.OrderId as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_ID]


,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER_OrderItemID],
(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(OI.orderitemID as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_LINE_NUMBER]


,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
, case JSON_VALUE(memberdata, '$.insPlanId') when '3232' then '70.00' when '3233' then '100.00' when '3234' then '100.00' end PLAN_RESP_AMT
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

                                                
SELECT * FROM #BenefitUtilizationTemp
--SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|PLAN_RESP_AMT_FREQ|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20)                                                                               
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20)                        
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20)                                                                   
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20)                               
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20)                                                                              
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20)                  
+'|'+ bu.TRANSACTION_STATUS 
--+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100)                                                                      
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20)                     
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20)                                                                 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20)        
+'|'+'3'
+'|'+ cast(bu.BILL_AMT as varchar)
+'|'+ cast(bu.BILL_UNIT_AMT  as varchar)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20)                                                                         
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20)                              
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+ case isnull(bu.shipment_Dt,'') when ''  then '' when '01-01-001' then '' else format(cast(bu.shipment_Dt as date),'yyyy-MM-dd') end 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20)                                                                              
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20)                         
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20)                                                                          
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)                 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20)                                                                      
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20)                 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20)                 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 --as OutputText
from #BenefitUtilizationTemp bu
order by 1


--select * from #BenefitUtilizationTemp
--where 1 = 1
----and PLAN_RESP_AMT not in ('70.00','100.00')
--and TRANSACTION_STATUS = 'Fulfilled'
--and isnull(SHIPMENT_DT,'') = ''

