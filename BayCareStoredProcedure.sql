/****** Object:  StoredProcedure [dbo].[sp_BayCareBenefitUtil]    Script Date: 12/23/2020 6:14:59 PM ******/
--exec [dbo].[sp_BayCareBenefitUtil]

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_BayCareBenefitUtil]
--(
    -- Add the parameters for the stored procedure here
--@FileSubmitGrpId nvarchar(20)
--,@ResultSetOutput nvarchar(max) OUT
--)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRY
	--SELECT 1/0; 
			IF OBJECT_ID('tempdb..#BayCareTemp') IS NOT NULL DROP TABLE #BayCareTemp

			SELECT * INTO #BayCareTemp FROM
			(SELECT TOP 10
					'NATIONSOTC' as [SOURCE_SENDER]
					,'NBCRM' as [SOURCE_SYSTEM]
					,FORMAT(GETDATE(), 'yyyy-MM-dd') AS DATA_DATE

					,(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) as PERIOD_BEGIN_DATE
					,(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) as PERIOD_END_DATE

					,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
					--,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

					,'OTC' AS [BENEFIT_TYPE]
					,O.orderID as [TRANSACTION_ID]
					,OI.orderitemID as [TRANSACTION_LINE_NUMBER]
					,O.Status as [TRANSACTION_TYPE]
					,O.OrderStatusCode as [TRANSACTION_STATUS]
					,NULL as [NDC]
					,OI.BrandCode as [PRODUCT_NAME_Brand]
					,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
					,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
					,O.DateOrderReceived as [ORDER_DT]
					,O.DateOrderInitiated as [SVC_DT]
					,'NA' as [POSTED_DT]
					,M.MemberID as [MEMBER_ID]
					,0 AS [PLAN_RESP_AMT]
					,O.Amount as [BILL_AMT]
					,OI.UnitPrice as [BILL_UNIT_AMT]
					,'NA' AS [SALES_TAX_AMT]
					,'NA' AS [CONSUMER_USE_AMT]
					,'NA' AS [SELLER_USE_TAX]
					,'NA' AS [ADMIN_FEE_AMT]
					,'NA' as [REFUND_AMT]
					,'NA' as [RESTOCK_AMT]
					,'NA' as [SHIPMENT_DT]
					,'NA' as [SHIPMENT_CARRIER]
					,'NA' as [SHIPMENT_TRACKING]
					,'NA' as [SHIPMENT_AMT]
					,'NA' as [EXTERNAL_TRANSACTION_ID]
					,'NA' as [EXTERNAL_TRANSACTION_LINE_NUMBER]
					,'NA' as [ORIG_TRANSACTION_ID]
					,'NA' as [ORIG_TRANSACTION_LINE_NUMBER]
					,'NA' as [CONDITION_1_CD]
					,'NA' as [CONDITION_2_CD]
					,'NA' as [CONDITION_3_CD]
					,'NA' as [FEED_SPECIFIC_TXT1]
					,'NA' as [FEED_SPECIFIC_TXT2]
					,'NA' as [FEED_SPECIFIC_TXT3]
					,'NA' as [FEED_SPECIFIC_TXT4]
					,'NA' as [FEED_SPECIFIC_TXT5]

					from 
					Orders.Orders O
					left join Orders.OrderItems OI on (O.OrderID = OI.OrderID )
					left join Master.Members M on (O.NHMemberID = M.NHMemberID)
					left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
			
			) A
			 
			
			SELECT * FROM #BayCareTemp

	

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


/*
Test Case Driven Development
Test Case 1 | Positive | Success
TRUNCATE TABLE Logs
DECLARE @FileSubmitGrpId nvarchar(14)
SET @FileSubmitGrpId = CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)
Print(@FileSubmitGrpId)
exec dbo.sp_BayCareBenefitUtil @FileSubmitGrpId
SELECT * FROM Logs

Test Case 2 | Negative | Unsuccessfull
TRUNCATE TABLE Logs
exec dbo.sp_BayCareBenefitUtil
SELECT * FROM Logs

*/

/*
select * from information_schema.routines

select SPECIFIC_CATALOG,SPECIFIC_SCHEMA, SPECIFIC_NAME, ROUTINE_NAME, ROUTINE_DEFINITION

DECLARE @PROCEDURE_CODE nvarchar(max)
SET @PROCEDURE_CODE=SELECT cast(ROUTINE_DEFINITION as nvarchar) FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_CATALOG = 'NHCRM_STG' AND ROUTINE_SCHEMA = 'dbo' AND ROUTINE_NAME = N'sp_BayCareBenefitUtil'
Print(@PROCEDURE_CODE)
*/

/*
alter view dbo.vw_BayCare
as

(SELECT TOP 10
					'NATIONSOTC' as [SOURCE_SENDER]
					,'NBCRM' as [SOURCE_SYSTEM]
					,FORMAT(GETDATE(), 'yyyy-MM-dd') AS DATA_DATE

					,(DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)) as PERIOD_BEGIN_DATE
					,(DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)) as PERIOD_END_DATE

					,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
					--,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

					,'OTC' AS [BENEFIT_TYPE]
					,O.orderID as [TRANSACTION_ID]
					,OI.orderitemID as [TRANSACTION_LINE_NUMBER]
					,O.Status as [TRANSACTION_TYPE]
					,O.OrderStatusCode as [TRANSACTION_STATUS]
					,NULL as [NDC]
					,OI.BrandCode as [PRODUCT_NAME_Brand]
					,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
					,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
					,O.DateOrderReceived as [ORDER_DT]
					,O.DateOrderInitiated as [SVC_DT]
					,'NA' as [POSTED_DT]
					,M.MemberID as [MEMBER_ID]
					,0 AS [PLAN_RESP_AMT]
					,O.Amount as [BILL_AMT]
					,OI.UnitPrice as [BILL_UNIT_AMT]
					,'NA' AS [SALES_TAX_AMT]
					,'NA' AS [CONSUMER_USE_AMT]
					,'NA' AS [SELLER_USE_TAX]
					,'NA' AS [ADMIN_FEE_AMT]
					,'NA' as [REFUND_AMT]
					,'NA' as [RESTOCK_AMT]
					,'NA' as [SHIPMENT_DT]
					,'NA' as [SHIPMENT_CARRIER]
					,'NA' as [SHIPMENT_TRACKING]
					,'NA' as [SHIPMENT_AMT]
					,'NA' as [EXTERNAL_TRANSACTION_ID]
					,'NA' as [EXTERNAL_TRANSACTION_LINE_NUMBER]
					,O.orderID  as [ORIG_TRANSACTION_ID]
					,OI.orderitemID as [ORIG_TRANSACTION_LINE_NUMBER]
					,'NA' as [CONDITION_1_CD]
					,'NA' as [CONDITION_2_CD]
					,'NA' as [CONDITION_3_CD]
					,'NA' as [FEED_SPECIFIC_TXT1]
					,'NA' as [FEED_SPECIFIC_TXT2]
					,'NA' as [FEED_SPECIFIC_TXT3]
					,'NA' as [FEED_SPECIFIC_TXT4]
					,'NA' as [FEED_SPECIFIC_TXT5]

					from 
					Orders.Orders O
					left join Orders.OrderItems OI on (O.OrderID = OI.OrderID )
					left join Master.Members M on (O.NHMemberID = M.NHMemberID)
					left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
			
			)
go
Select * from vw_BayCare

--exec [dbo].[sp_BayCareBenefitUtil]
GO


