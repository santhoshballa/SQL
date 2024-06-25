USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BayCareBenefitUtil]    Script Date: 12/30/2020 6:19:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0

DECLARE @DataSource nvarchar(20)
SET @DataSource = 'ELIG_OPTIMA'
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
Print(GetDate())
Print(@GetDateEST)
SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#BayCareTemp') IS NOT NULL DROP TABLE #BayCareTemp
IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE ##OrderShippingInfoTemp


-- This temp table contains the OrderItemID and OrderID's from the Orders.OrderItems table
SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = 'ELIG_HF' AND 
																								(
																									--Returns the previous month's day 1
																									(FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') between [RecordEffDate] and [RecordEndDate]) and 
																									(FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') between [RecordEffDate] and [RecordEndDate]) and 
																									(FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
												)
) A

--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,O.Status as [TRANSACTION_TYPE]
,O.OrderStatusCode as [TRANSACTION_STATUS]
,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'PostedDate' as [POSTED_DT]
,M.MemberID as [MEMBER_ID]
,0 AS [PLAN_RESP_AMT]
,O.Amount as [BILL_AMT]
,OI.UnitPrice as [BILL_UNIT_AMT]
,'SalesTxAmt' AS [SALES_TAX_AMT]
,'ConsumerUseTax' AS [CONSUMER_USE_TAX]
,'SellerUseTax' AS [SELLER_USE_TAX]
,'AdminFeeAmt' AS [ADMIN_FEE_AMT]
,'RefundAmt' as [REFUND_AMT]
,'RestockAmt' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'EnternalTransactionID' as [EXTERNAL_TRANSACTION_ID]
,'ExternalTransactionLineNumber' as [EXTERNAL_TRANSACTION_LINE_NUMBER]
,O.orderID as [ORIG_TRANSACTION_ID]
,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER]
,'C1' as [CONDITION_1_CD]
,'C2' as [CONDITION_2_CD]
,'C3' as [CONDITION_3_CD]
,'FST1' as [FEED_SPECIFIC_TXT1]
,'FST2' as [FEED_SPECIFIC_TXT2]
,'FST3' as [FEED_SPECIFIC_TXT3]
,'FST4' as [FEED_SPECIFIC_TXT4]
,'FST5' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID)
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp




SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
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
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
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
 as OutputText
 from #BenefitUtilizationTemp bu



 

		END TRY

		BEGIN CATCH

		

		IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'Logs' AND TABLE_SCHEMA = N'dbo')
				
				CREATE TABLE Logs
				(
				ERROR_PROCEDURE_NAME nvarchar(200),
				ERROR_NUMBER nvarchar(200), 
				ERROR_SEVERITY nvarchar(200), 
				ERROR_STATE nvarchar(200), 
				ERROR_PROCEDURE nvarchar(200), 
				ERROR_LINE nvarchar(200), 
				ERROR_MESSAGE nvarchar(200),
				ERROR_DATE datetime default CURRENT_TIMESTAMP
				)

		INSERT INTO Logs (ERROR_PROCEDURE_NAME,ERROR_NUMBER, ERROR_SEVERITY, ERROR_STATE, ERROR_PROCEDURE, ERROR_LINE, ERROR_MESSAGE) 
		VALUES ('dbo.sp_BayCareBenefitUtil', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO

--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

