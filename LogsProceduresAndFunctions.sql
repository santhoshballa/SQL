/****** Object:  StoredProcedure [debugtool].[GetlogsBenefitErrors]    Script Date: 6/26/2024 1:17:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
Created By : M Naresh                  
Date : 01-JAN-2024                    
Description : Get member data from logs.BenefitErrors table from logs database.              
exec [debugtool].[GetlogsBenefitErrors]  281, 4137,NULL, NULL ,2024             
*/
CREATE PROCEDURE [debugtool].[GetlogsBenefitErrors] (
	@Param1 BIGINT = NULL -- CarrierID
	,@Param2 BIGINT = NULL -- PlanId
	,@Param3 VARCHAR(50) = NULL -- NHMemberid
	,@Param4 VARCHAR(50) = NULL -- source
	,@BenefitYear BIGINT -- = 2023  
	)
AS
BEGIN
	SELECT TOP 30 ID
		,NHMemberID
		,ProxyID
		,CarrierID
		,PlanId
		,ResponseData
		,ReasonGroup
		,ReasonDetails
		,Source
		,CreateDate
	FROM logs.BenefitErrors WITH(NOLOCK)
	WHERE CarrierID = IIF(@Param1 IS NULL, CarrierID, @Param1)
		AND PlanId = IIF(@Param2 IS NULL, PlanId, @Param2)
		AND NHMemberID = IIF(@Param3 IS NULL, NHMemberId, @Param3)
		AND Source = IIF(@Param4 IS NULL, Source, @Param4)
		AND 1 = CASE         
		WHEN @BenefitYear = YEAR(CreateDate)
			THEN 1                 
		ELSE 0        
		END        
	ORDER BY CreateDate DESC
END
GO
/****** Object:  StoredProcedure [logs].[InsertFisErrorInfo]    Script Date: 6/26/2024 1:17:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================  
-- Author:      <RAMAKRISHNA KUNJA>  
-- Create Date: <07-02-2023>  
-- Description: <Used to log  the fis service benefit errors > 
-- ModifiedBy  : <Jagadish>
-- =============================================  
Create   proc [logs].[InsertFisErrorInfo]   
(    
  @ReqData NVARCHAR(MAX) = null  
 ,@ResponseData NVARCHAR(MAX) = null  
 ,@ProxyID NVARCHAR(100) = null  
 ,@CarrierID BIGINT  = null  
 ,@PlanId BIGINT = null  
 ,@ReasonGroup NVARCHAR(MAX) = null  
 ,@ReasonDetails NVARCHAR(MAX) = null  
 ,@Source varchar(25)  = null  
 ,@CreateUser  VARCHAR(50) = null
 ,@NHMemberID nvarchar(100) = null
)  
AS   
BEGIN   
SET NOCOUNT ON  
BEGIN TRY  
               
     
   INSERT INTO logs.BenefitErrors (
               
               ProxyID  
              ,CarrierID  
              ,PlanId  
              ,ReasonGroup  
              ,ReasonDetails  
              ,Source
              ,ReqData  
              ,ResponseData  
			  ,NHMemberID
              ,CreateUser  
              ,CreateDate  
             )    
            VALUES (    
              @ProxyID   
             ,@CarrierID    
             ,@PlanID    
             ,@ReasonGroup  
             ,@ReasonDetails  
             ,@Source
             ,@ReqData
             ,@ResponseData
             ,@NHMemberID
             ,@CreateUser  
             ,Getdate()  
             )  
  
 END TRY      
 BEGIN CATCH      
  SELECT                 
  ERROR_NUMBER() AS ErrorNumber,                
  ERROR_MESSAGE() AS ErrorMessage;               
 END CATCH      
END     
GO
/****** Object:  StoredProcedure [logs].[InsertFISReqResponses]    Script Date: 6/26/2024 1:17:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
 Modified Date: 23 AUG 2021
 Modified By: K Ramu
 Comments: Added aauid parameter
*/

/*
 Modified Date: 05 01 2023
 Modified By: Edu
 Comments: Added New column proxyID and added new Parameter @proxyID and accepts null 
*/
  
--exec logs.InsertFISReqResponses 'Nations' ,'reqObj','ResObj','Status','ErrorMessage','systemuser','systemuser'  
  
CREATE   proc [logs].[InsertFISReqResponses]  
  @aauid NVARCHAR(max)  
 ,@ReqObject NVARCHAR(max)  
 ,@ResObject NVARCHAR(max) = null  
 ,@STATUS NVARCHAR(30)  
 ,@ErrorMessage NVARCHAR(200) =null
 ,@source NVARCHAR(200) =null 
 ,@methodName NVARCHAR(200) =null  
 ,@CreateUser  VARCHAR(50)  
 ,@ModifyUser  VARCHAR(50)  
 ,@proxyID  VARCHAR(100) =null 
  
 as  
 begin  
   
INSERT INTO logs.FISReqResponses (  
  aauid  
  ,ReqObject  
 ,ResObject  
 ,STATUS  
 ,ErrorMessage 
 ,MethodName
 ,[Source]
 ,CreateUser  
 ,ModifyUser
 ,ProxyID  
 )  
VALUES (  
  @aauid  
 ,@ReqObject  
 ,@ResObject  
 ,@STATUS  
 ,@ErrorMessage
 ,@methodName
 ,@source
 ,@CreateUser  
 ,@ModifyUser
 ,@proxyID 
 )   
 end   
  
  
 
GO
/****** Object:  StoredProcedure [logs].[InsertMealsLoggingMessages]    Script Date: 6/26/2024 1:17:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                          
  ===================================================================================================                         
  Test Case:                        
  1. EXEC [Orders].[InsertLoggingMessages]                           
  ==================================================================================================                        
  Author:    Modify Date:      Description:                           
  ==================================================================================================                        
  P Venkateshwara Rao  28-09-2023     For getting new Order Data             
  ===================================================================================================                        
*/
-- exec [Orders].[InsertMealsLoggingMessages]                  
CREATE PROCEDURE [logs].[InsertMealsLoggingMessages] @QuickBaseRequestObject VARCHAR(max)
	,@QuickBaseResponseObject VARCHAR(max)
	,@StatusCode INT
	,@ApiMethodName VARCHAR(100)
	,@ErrorMessage VARCHAR(max)
AS
BEGIN
	DECLARE @newID VARCHAR(50)

	SET @newID = newID()

	INSERT INTO [logs].[QuickbaseMessages] (
		ID
		,[QuickBaseRequestObject]
		,[QuickBaseResponseObject]
		,[StatusCode]
		,[ApiMethodName]
		,[ErrorMessage]
		,[CreateUser]
		,[CreateDate]
		)
	VALUES (
		@newID
		,@QuickBaseRequestObject
		,@QuickBaseResponseObject
		,@StatusCode
		,@ApiMethodName
		,@ErrorMessage
		,'Admin'
		,getdate()
		)

	SELECT @newID
END
GO
/****** Object:  StoredProcedure [logs].[InsertMSDReqResponses]    Script Date: 6/26/2024 1:17:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================          
--Created By: Santhosh Akula            
--Changed on: 02-Nov-2021           
--Purpose : MSD Request and Response saving in DB          
--Dev Comments:           
--1. MSD Request and Response save in [logs].[MSDReqResponses] Table.    
--Test Case :    
--EXEC logs.InsertFISReqResponses 'Nations' ,'reqObj','ResObj','Status','ErrorMessage','systemuser','systemuser'      
--Select top 10 * from [logs].[MSDReqResponses] order by 1 desc    
-- =============================================     
CREATE PROC [logs].[InsertMSDReqResponses]              
  @ReqObject VARCHAR(max)                
 ,@ResObject VARCHAR(max) = null                
 ,@Status VARCHAR(20)                
 ,@ApiMethodName VARCHAR(255)              
 ,@source VARCHAR(20) =null               
 ,@CreateUser  CHAR(7)                
 ,@ModifyUser  CHAR(7)    
 AS    
 BEGIN       
 SET NOCOUNT ON    
INSERT INTO [logs].[MSDReqResponses](                
  ReqObject,ResObject,STATUS,ApiMethodName              
 ,[Source],CreateUser              
 ,CreateDate,ModifyDate ,ModifyUser)                
VALUES(                
  @ReqObject,@ResObject,@STATUS,@ApiMethodName              
 ,@source,@CreateUser,getdate(),getdate(),@ModifyUser )             
 select  SCOPE_IDENTITY()      
 end
GO
