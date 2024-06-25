
--SQL Statement to extract File information and FTP userinfo
Select ? as InClientCode,fi.ClientCode,
replace(fi.FileName,'yyyymmddhhmmss',cast(format(CONVERT(datetime, SWITCHOFFSET(getdate(), DATEPART(TZOFFSET,getdate() AT TIME ZONE 'Eastern Standard Time'))),'yyyyMMddHHmmss') as varchar(16))) +'.'+fi.fileExtension as Outfilename,
	fi.fileExtension,
	fi.FromLocation,
	fi.ToLocation,
	fi.DataSource,
	ftp.WinSCPLoginName

from elig.fileinfo fi 
join elig.FTPUserInfo ftp on fi.ClientCode = ftp.ClientCode
where 1=1
and fi.ClientCode = ?
and fi.DataSource= ?
and fi.filetype = ?
and fi.Direction ='OUT'

select * from elig.FileInfo
select * from elig.FTPUserInfo

select * from orders.orders
select * from Master.members
select 

select
O.NHMemberID as NHMemberID_Order , O.OrderType, O.Amount, O.DateOrderReceived,O.DateOrderInitiated,O.isActive,O.Source, O.Status, O.OrderStatusCode, --Order
M.NHMemberID as NHMemberID_Master, M.DataSource, --Master
OI.OrderID as OrderID_O, OI.BrandCode, OI.ItemCode, OI.Quantity, OI.Amount, OI.Status, OI.UnitPrice, OI.PairPrice,OI.ItemType --OrderItems

from Orders.Orders O left join Master.Members M on (O.NHMemberId = M.NHMemberID)
left join Orders.OrderItems OI on (O.OrderID = OI.OrderId)
where M.NHMemberID like 'OTC%'








/****** Object:  StoredProcedure [elig].[sp_2021_Incomm_Cardholder_Out_File]    Script Date: 12/23/2020 6:25:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:      Santhosh
-- Create Date: Dec 2020
-- Description: BayCare Report
-- 
-- =============================================

ALTER PROCEDURE elig.Baycare_santhosh
@InClientCode varchar(20), --H223_O for ELIG_BCBSRIOTC; H348 for troy
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
AS
BEGIN

DECLARE @DataSource varchar(20)
DECLARE @sql_bcbsri VARCHAR(max)


SELECT @DataSource = DataSource
FROM elig.ClientCodes
WHERE 1=1
and ClientCode = @InClientCode

	SET NOCount ON 
	SET xact_abort ON
	SET concat_NULL_Yields_NULL off

	DECLARE @Ret_Var Int , 
			@Error_Code Int
			
			
	SELECT @Ret_Var = 0, 
		   @Error_Code = 0

	
-----  BCBSRI OTC 		
SET @sql_bcbsri =
'SELECT 1 as fororder,
''Health Plan code,Program Code,Member ID,Member ID2,First Name,Middle Name,Last Name,Street1,Street2,City,State,Zip,Group Number,User Defined Field1,User defined Field2,Intial Activation Code,Package ID,E-Card,Mobile Phone,Email''
as Outputtext
UNION
SELECT
2 as fororder,
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.AlternateID,''''),'','',''''),1,20) 					
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.SubscriberID,''''),'','',''''),1,20) 		
+'',''+SUBSTRING(REPLACE(ISNULL(FirstName,''''),'','',''''),1,32)			
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.MiddleInitial,''''),'','',''''),1,32)			
+'',''+SUBSTRING(REPLACE(ISNULL(LastName,''''),'','',''''),1,32) 						
+'',''+SUBSTRING(REPLACE(ISNULL(MailingAddress1,''''),'','',''''),1,40)					
+'',''+SUBSTRING(REPLACE(ISNULL(MailingAddress2,''''),'','',''''),1,40)						
+'',''+SUBSTRING(REPLACE(ISNULL(MailingCity,''''),'','',''''),1,32) 							
+'',''+SUBSTRING(REPLACE(ISNULL(MailingState,''''),'','',''''),1,2) 								
+'',''+right(CONCAT(replicate(''0'', 5),ISNULL(mstrEligBenefitData.MailingZipCode,'''')), 5)	
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.GroupNbr,''''),'','',''''),1,24) 									
+'',''+SUBSTRING('''',1,64)                
+'',''+SUBSTRING('''',1,64)                
+'',''+SUBSTRING(REPLACE(ISNULL(RIGHT(AlternateID,4), ''''),'','',''''), 1, 14)          
+'',''+SUBSTRING('''',1,1)    													
+'',''+LEFT(ISNULL(convert(varchar(10),case when len(mstrEligBenefitData.HomePhoneNbr) < 10 then '''' else mstrEligBenefitData.HomePhoneNbr end),'''')+space(10),10)  
+'',''+SUBSTRING('''',1,100)  															
AS Outputtext
FROM elig.mstrEligBenefitData 
WHERE  1=1
and mstrEligBenefitData.DataSource = ''' + @dataSource + '''
and mstrEligBenefitData.isActive=1
and CAST(getdate() AT TIME ZONE ''UTC''  AT TIME ZONE ''Eastern Standard Time'' AS DATE) between mstrEligBenefitData.RecordEffDate and mstrEligBenefitData.RecordEndDate
and (CAST(getdate() AT TIME ZONE ''UTC''  AT TIME ZONE ''Eastern Standard Time'' AS DATE) between mstrEligBenefitData.BenefitStartDate and  mstrEligBenefitData.BenefitEndDate 
or (mstrEligBenefitData.BenefitStartDate > CAST(getdate() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) AND mstrEligBenefitData.BenefitEndDate > mstrEligBenefitData.BenefitStartDate)) 
ORDER by 1'

--select @sql
--for testing
--and mstrEligBenefitData.SubscriberID in (
--''Z2M200387600'',''Z3M200387615'',''Z3M200417879'',''ZBM200388335'',''ZBM200387638'',''ZBM200387593'',        
--''ZBM200387584'',''ZBM200387821'')

   
		
EXEC (@sql_bcbsri);   
	  

--EXEC (@sql); NEED THIS

		SELECT @Error_Code = @@Error  
		IF @Error_Code <> 0  OR @Ret_Var <> 0    
		BEGIN   
		SET @Ret_Var = Case @Ret_Var WHEN 0 THEN @Error_Code ELSE @Ret_Var END  
		GOTO __SPRETURN   
		END  

END
__SPRETURN:  




DECLARE @sql_bcbsri VARCHAR(max)
DECLARE @dataSource varchar(20);
set @dataSource = 'BAYC_RPT';
SET @sql_bcbsri =
'SELECT 1 as fororder,
''Health Plan code,Program Code,Member ID,Member ID2,First Name,Middle Name,Last Name,Street1,Street2,City,State,Zip,Group Number,User Defined Field1,User defined Field2,Intial Activation Code,Package ID,E-Card,Mobile Phone,Email''
as Outputtext
UNION
SELECT
2 as fororder,
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.AlternateID,''''),'','',''''),1,20) 					
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.SubscriberID,''''),'','',''''),1,20) 		
+'',''+SUBSTRING(REPLACE(ISNULL(FirstName,''''),'','',''''),1,32)			
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.MiddleInitial,''''),'','',''''),1,32)			
+'',''+SUBSTRING(REPLACE(ISNULL(LastName,''''),'','',''''),1,32) 						
+'',''+SUBSTRING(REPLACE(ISNULL(MailingAddress1,''''),'','',''''),1,40)					
+'',''+SUBSTRING(REPLACE(ISNULL(MailingAddress2,''''),'','',''''),1,40)						
+'',''+SUBSTRING(REPLACE(ISNULL(MailingCity,''''),'','',''''),1,32) 							
+'',''+SUBSTRING(REPLACE(ISNULL(MailingState,''''),'','',''''),1,2) 								
+'',''+right(CONCAT(replicate(''0'', 5),ISNULL(mstrEligBenefitData.MailingZipCode,'''')), 5)	
+'',''+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.GroupNbr,''''),'','',''''),1,24) 									
+'',''+SUBSTRING('''',1,64)                
+'',''+SUBSTRING('''',1,64)                
+'',''+SUBSTRING(REPLACE(ISNULL(RIGHT(AlternateID,4), ''''),'','',''''), 1, 14)          
+'',''+SUBSTRING('''',1,1)    													
+'',''+LEFT(ISNULL(convert(varchar(10),case when len(mstrEligBenefitData.HomePhoneNbr) < 10 then '''' else mstrEligBenefitData.HomePhoneNbr end),'''')+space(10),10)  
+'',''+SUBSTRING('''',1,100)  															
AS Outputtext
FROM elig.mstrEligBenefitData 
WHERE  1=1
and mstrEligBenefitData.DataSource = ''' + @dataSource + '''
and mstrEligBenefitData.isActive=1
and CAST(getdate() AT TIME ZONE ''UTC''  AT TIME ZONE ''Eastern Standard Time'' AS DATE) between mstrEligBenefitData.RecordEffDate and mstrEligBenefitData.RecordEndDate
and (CAST(getdate() AT TIME ZONE ''UTC''  AT TIME ZONE ''Eastern Standard Time'' AS DATE) between mstrEligBenefitData.BenefitStartDate and  mstrEligBenefitData.BenefitEndDate 
or (mstrEligBenefitData.BenefitStartDate > CAST(getdate() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) AND mstrEligBenefitData.BenefitEndDate > mstrEligBenefitData.BenefitStartDate)) 
ORDER by 1'

Print(@sql_bcbsri )

EXEC (@sql_bcbsri);   


SELECT 1 as fororder,
'Health Plan code,Program Code,Member ID,Member ID2,First Name,Middle Name,Last Name,Street1,Street2,City,State,Zip,Group Number,User Defined Field1,User defined Field2,Intial Activation Code,Package ID,E-Card,Mobile Phone,Email'
as Outputtext
UNION
SELECT
2 as fororder,
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.AlternateID,''),',',''),1,20) 					
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.SubscriberID,''),',',''),1,20) 		
+','+SUBSTRING(REPLACE(ISNULL(FirstName,''),',',''),1,32)			
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.MiddleInitial,''),',',''),1,32)			
+','+SUBSTRING(REPLACE(ISNULL(LastName,''),',',''),1,32) 						
+','+SUBSTRING(REPLACE(ISNULL(MailingAddress1,''),',',''),1,40)					
+','+SUBSTRING(REPLACE(ISNULL(MailingAddress2,''),',',''),1,40)						
+','+SUBSTRING(REPLACE(ISNULL(MailingCity,''),',',''),1,32) 							
+','+SUBSTRING(REPLACE(ISNULL(MailingState,''),',',''),1,2) 								
+','+right(CONCAT(replicate('0', 5),ISNULL(mstrEligBenefitData.MailingZipCode,'')), 5)	
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.GroupNbr,''),',',''),1,24) 									
+','+SUBSTRING('',1,64)                
+','+SUBSTRING('',1,64)                
+','+SUBSTRING(REPLACE(ISNULL(RIGHT(AlternateID,4), ''),',',''), 1, 14)          
+','+SUBSTRING('',1,1)    													
+','+LEFT(ISNULL(convert(varchar(10),case when len(mstrEligBenefitData.HomePhoneNbr) < 10 then '' else mstrEligBenefitData.HomePhoneNbr end),'')+space(10),10)  
+','+SUBSTRING('',1,100)  															
AS Outputtext
FROM elig.mstrEligBenefitData 
WHERE  1=1
--and mstrEligBenefitData.DataSource = 'BAYC_RPT'
and mstrEligBenefitData.isActive=1
and CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' AS DATE) between mstrEligBenefitData.RecordEffDate and mstrEligBenefitData.RecordEndDate
and (CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' AS DATE) between mstrEligBenefitData.BenefitStartDate and  mstrEligBenefitData.BenefitEndDate 
or (mstrEligBenefitData.BenefitStartDate > CAST(getdate() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) AND mstrEligBenefitData.BenefitEndDate > mstrEligBenefitData.BenefitStartDate)) 
ORDER by 1



--Reasons for the code being complex but easy to understand
declare @LastName varchar(max);
--set @LastName = NULL;
set @LastName = 'abcdefghijklmnopqrstaaa,,,,,,,,,,,,,,,,aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaEND'
select ISNULL(@LastName,'If value is null') -- checks if a value is null, because NULL values cannot be compared and NULLs should be converted to a blank
select REPLACE(ISNULL(@LastName,'If value, is null'),',','') -- replaces any commas in the @LastName with a not null blank, why? because the delimiter is a ,
select SUBSTRING(REPLACE(ISNULL(@LastName,'If value,,,,,, is null'),',',''),1,32) -- Makes sure the values and truncated to 32 characters



SELECT 1 as fororder,
'Health Plan code,Program Code,Member ID,Member ID2,First Name,Middle Name,Last Name,Street1,Street2,City,State,Zip,Group Number,User Defined Field1,User defined Field2,Intial Activation Code,Package ID,E-Card,Mobile Phone,Email'
as Outputtext
UNION
SELECT
2 as fororder,
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.AlternateID,''),',',''),1,20) 					
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.SubscriberID,''),',',''),1,20) 		
+','+SUBSTRING(REPLACE(ISNULL(FirstName,''),',',''),1,32)			
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.MiddleInitial,''),',',''),1,32)			
+','+SUBSTRING(REPLACE(ISNULL(LastName,''),',',''),1,32) 						
+','+SUBSTRING(REPLACE(ISNULL(MailingAddress1,''),',',''),1,40)					
+','+SUBSTRING(REPLACE(ISNULL(MailingAddress2,''),',',''),1,40)						
+','+SUBSTRING(REPLACE(ISNULL(MailingCity,''),',',''),1,32) 							
+','+SUBSTRING(REPLACE(ISNULL(MailingState,''),',',''),1,2) 								
+','+right(CONCAT(replicate('0', 5),ISNULL(mstrEligBenefitData.MailingZipCode,'')), 5)	
+','+SUBSTRING(REPLACE(ISNULL(mstrEligBenefitData.GroupNbr,''),',',''),1,24) 									
+','+SUBSTRING('',1,64)                
+','+SUBSTRING('',1,64)                
+','+SUBSTRING(REPLACE(ISNULL(RIGHT(AlternateID,4), ''),',',''), 1, 14)          
+','+SUBSTRING('',1,1)    													
+','+LEFT(ISNULL(convert(varchar(10),case when len(mstrEligBenefitData.HomePhoneNbr) < 10 then '' else mstrEligBenefitData.HomePhoneNbr end),'')+space(10),10)  
+','+SUBSTRING('',1,100)  															
AS Outputtext
FROM elig.mstrEligBenefitData 
WHERE  1=1



/****** Object:  StoredProcedure [dbo].[sp_BayCareBenefitUtil]    Script Date: 12/23/2020 6:12:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[sp_BayCareBenefitUtil]
(
    -- Add the parameters for the stored procedure here
--@FileSubmitGrpId nvarchar(20)
--,@ResultSetOutput nvarchar(max) OUT
)
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

					,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
					,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

					,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
					--,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

					,'OTC' AS [BENEFIT_TYPE]
					,O.orderID as [TRANSACTION_ID]
					,OI.orderitemID as [TRANSACTION_LINE_NUMBER]
					,O.Status as [TRANSACTION_TYPE]
					,O.OrderStatusCode as [TRANSACTION_STATUS]
					,NULL as [NDC]
					,OI.BrandCode as [PRODUCT_NAME]
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
					,'ShipmentDate' as [SHIPMENT_DT]
					,'ShipmentCarrier' as [SHIPMENT_CARRIER]
					,'ShipmentCarrier' as [SHIPMENT_TRACKING]
					,'ShipmentAmt' as [SHIPMENT_AMT]
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

					from 
					Orders.Orders O
					left join Orders.OrderItems OI on (O.OrderID = OI.OrderID )
					left join Master.Members M on (O.NHMemberID = M.NHMemberID)
					left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
			
			) A
			 
			
			SELECT * FROM #BayCareTemp



SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.PRODUCT_NAME,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.BILL_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.BILL_UNIT_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.REFUND_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(#BayCareTemp.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BayCareTemp




	

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

exec [dbo].[sp_BayCareBenefitUtil]

*/

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
where TABLE_NAME IN 
( 'orders', 'OrderPOs','OrderItems', 'OrderTransactionDetails', 
'ItemMasterList', 'ItemMasterAttributeValues', 'ItemMasterContent', 
'ClientCodes', 
'Members', 'MemberInsurances',  'MemberInsuranceDetails','Addresses', 'PhoneNumbers',
'FileInfo', 'FTPUserInfo')
and DATA_TYPE IN ('bigint','bit','datetime','nvarchar','varchar')
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')


--The correct query
Select  ? as InClientCode,
	fi.ClientCode,
replace(fi.FileName,'yyyymmddhhmmss',cast(format(CONVERT(datetime, SWITCHOFFSET(getdate(), DATEPART(TZOFFSET,getdate() AT TIME ZONE 'Eastern Standard Time'))),'yyyyMMddHHmmss') as varchar(16))) +'.'+fi.fileExtension as Outfilename,
	fi.fileExtension,
	fi.FromLocation,
	fi.ToLocation,
	fi.DataSource,
	ftp.WinSCPLoginName

from elig.fileinfo fi 
join elig.FTPUserInfo ftp on fi.ClientCode = ftp.ClientCode
where 1=1
and fi.ClientCode = ?
and fi.DataSource= ?
and fi.filetype = ?
and fi.Direction ='OUT'


Select 'H428' as InClientCode,
	fi.ClientCode,
replace(fi.FileName,'yyyymmddhhmmss',cast(format(CONVERT(datetime, SWITCHOFFSET(getdate(), DATEPART(TZOFFSET,getdate() AT TIME ZONE 'Eastern Standard Time'))),'yyyyMMddHHmmss') as varchar(16))) +'.'+fi.fileExtension as Outfilename,
	fi.fileExtension,
	fi.FromLocation,
	fi.ToLocation,
	fi.DataSource,
	ftp.WinSCPLoginName

from elig.fileinfo fi 
join elig.FTPUserInfo ftp on fi.ClientCode = ftp.ClientCode
where 1=1
and fi.ClientCode = 'H428'
and fi.DataSource= 'ELIG_BAYC'
and fi.filetype = 'ELIG'
and fi.Direction ='OUT'
and ftp.WinSCPLoginName = 'nhitsftp'

select * from elig.fileinfo
select * from elig.FTPUserInfo







INSERT [elig].[FileInfo] ([ClientCode], [Direction], [FileName], [FileExtension], [FileFormat], [FileType], [SnapshotFlag], [Frequency], [PickDropTime], [FromLocation], [ToLocation], [DataSource], [isActive], [IsHeaderRecord], [FileFormatValue], [IsTrailerRecord], [isAckFileToFTP], [CreateDate], [CreateUser], [ModifyDate], [ModifyUser], [IsDelFileFromClientFTP], [IsControlFile], [IsPGP], [PGPFileExtension], [PGPKeyName], [IsFileHeaderRecord], [IsFileTrailerRecord], [MasterDataSource], [IsThresholdCheck], [ThresholdValue], [isOutFileEmail], [OutFileEmail]) 
VALUES ( N'H428', N'OUT', N'FaSysId_FileSubmitGrpId_BenefitUtil_YYYYMMDD', N'txt', N'Pipe', N'ELIG', N'FULL', N'Dly/Full/8:30AM/Mo-Fr', NULL, N'/h428/', N'C:\NHEligJobs\BayCare_SSIS\DAT\OUT\', N'ELIG_BAYC', 1, 0, N'', 0, NULL, CAST(N'2020-12-14T23:39:52.590' AS DateTime), N'appuser', CAST(N'2020-12-14T23:39:52.590' AS DateTime), N'appuser', NULL, NULL, N'N', NULL, NULL, NULL, NULL, N'ELIG_BAYC', NULL, NULL, NULL, NULL)


SELECT  * FROM  [elig].[FileInfo] WHERE ClientCode = 'H428'