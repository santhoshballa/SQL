/****** Object:  User [secuser]    Script Date: 6/26/2024 1:12:17 PM ******/
CREATE USER [secuser] FOR LOGIN [SecUser] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'secuser'
GO
/****** Object:  StoredProcedure [dbo].[ActiveQueries]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[ActiveQueries]
as

SELECT s.session_id, r.status,r.blocking_session_id 'Blkby', r.cpu_time, --r.logical_reads,  
Substring(st.TEXT,(r.statement_start_offset / 2) + 1,((CASE r.statement_end_offset WHEN -1 THEN Datalength(st.TEXT) ELSE r.statement_end_offset  
END - r.statement_start_offset) / 2) + 1) AS statement_text, Db_name(r.database_id) as   
DBName, Coalesce(Quotename(Db_name(st.dbid)) + N'.' + Quotename(Object_schema_name(st.objectid, st.dbid)) + N'.'   
+ Quotename(Object_name(st.objectid, st.dbid)), '') AS command_text,  
r.command, s.login_name, ISNULL(s.host_name, '')Host_Name, isnull (s.program_name,'')program_name,  
--s.last_request_end_time,   
--CONVERT(VARCHAR(20), s.login_time, 100) as UTC_login_time ,  
CONVERT(DATETIME,s.login_time AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time') 'EST_login_Time',  
DATEDIFF(MINUTE, CONVERT(DATETIME,s.login_time AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time'), CONVERT(DATETIME,getdate() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time')) 'Min'
--CONVERT(VARCHAR(20), getdate(), 100)) 'Min'  
--,r.open_transaction_count  
FROM sys.dm_exec_sessions AS s  
JOIN sys.dm_exec_requests AS r ON r.session_id = s.session_id  
CROSS APPLY sys.Dm_exec_sql_text(r.sql_handle) st  
WHERE r.session_id != @@SPID  
--and r.status='suspended'-- and host_name='NHETSTSQL1'  
--and Db_name(r.database_id)='DB_NAME'   
--and login_name like 'LOGON\'  
ORDER BY r.cpu_time desc
GO
/****** Object:  StoredProcedure [dbo].[tablecount]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure  [dbo].[tablecount]
as
SELECT 
o.[object_id] , SCHEMA_NAME(o.[schema_id])'SchemaName'  ,  o.name'TableName', o.[type] , i.total_rows , i.total_size, 
 --o.[object_id] , obj = SCHEMA_NAME(o.[schema_id]) + '.' + o.name , o.[type] , i.total_rows , i.total_size, 
(i.total_size/1024) 'GB', ((i.total_size/1024)/1024) 'TB' FROM sys.objects o
JOIN ( SELECT
          i.[object_id]
        , total_size = CAST(SUM(a.total_pages) * 8. / 1024 AS DECIMAL(18,2))
        , total_rows = SUM(CASE WHEN i.index_id IN (0, 1) AND a.[type] = 1 THEN p.[rows] END)
    FROM sys.indexes i
    JOIN sys.partitions p ON i.[object_id] = p.[object_id] AND i.index_id = p.index_id
    JOIN sys.allocation_units a ON p.[partition_id] = a.container_id
    WHERE i.is_disabled = 0
        AND i.is_hypothetical = 0
    GROUP BY i.[object_id]
) i ON o.[object_id] = i.[object_id]
WHERE o.[type] IN ('U') --,'V', 'S')--and SCHEMA_NAME(o.[schema_id])='temp'
ORDER BY i.total_size DESC
GO
/****** Object:  StoredProcedure [IVR].[CardActivationStatistics]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                                    
-- Author:      <Madhu B>                                    
-- Create Date: <12th Dec 2023 >                                    
-- Description: < return Card Activation Statistics report  >                                
-- Exec [IVR].[CardActivationStatistics]            
-- =============================================            
CREATE Proc [IVR].[CardActivationStatistics]          
As          
BEGIN                                    
declare @EffectiveDate datetime = '2024-01-01 00:00:00'  
select sum(s.new) AS ActivationCount ,s.Source,  cast(s.CreateDate as date) as CreateDate,s.[Status1] AS [Status] from 
( select Source, CONVERT(DATETIME,CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time') as CreateDate,
case when Source='IVR' then 'Success'   
else 'Fail' end as Status1,1 as new
from IVR.IVRRequestResponse with (nolock)        
where MethodName='CO_StatusAcct.asp' and Source='IVR'      
and  Status in('Success','Fail')  
and CONVERT(DATETIME,CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time') >= @EffectiveDate 
)s
group by s.Source, cast(s.CreateDate as date),s.[Status1] 

UNION 
select sum(s.new) AS ActivationCount ,s.Source, cast(s.CreateDate as date) as CreateDate,s.[Status] from 
( select Source, CONVERT(DATETIME,CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time') as CreateDate,[Status],1 as new
from IVR.IVRRequestResponse with (nolock)        
where MethodName='WebCardActivation' and Source='WEB'      
and   Status in('Success','Fail')  
and CONVERT(DATETIME,CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time') >= @EffectiveDate   
)s
group by s.Source,cast(s.CreateDate as date),s.[Status]


END         
GO
/****** Object:  StoredProcedure [IVR].[GetCardEntryDetails]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                                
-- Author:      <Jagadish K.>                                
-- Create Date: <7th Dec 2022 >                                
-- Description: < return card entry details based on ConversationID  >                            
-- Exec IVR.GetCardEntryDetails 'conv2554455'        
-- =============================================        
CREATE     Proc [IVR].[GetCardEntryDetails]      
(      
   @ConversationID varchar(100)       
)      
As      
BEGIN                                
 BEGIN TRY                               
   SET NOCOUNT ON       
      
 select top 1      
 InsuranceCarrierID,InsuranceCarrierName,CardStatus,      
 JSON_VALUE(PersonalDetails,'$.BirthDate') AS BirthDate,      
 JSON_VALUE(PersonalDetails,'$.Zipcode') AS Zipcode,isElevance,isnull(BalanceDetails,'') BalanceDetails        
 from IVR.IVREnquiryInfo with (nolock) where ConversationID = @ConversationID and isActive = 1     
      
  END TRY                              
 BEGIN CATCH                              
  SELECT                               
   ERROR_NUMBER() AS ErrorNumber                              
  ,ERROR_MESSAGE() AS ErrorMessage;                              
 END CATCH                              
END 
GO
/****** Object:  StoredProcedure [IVR].[GetInsuranceCarrierName]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                            
-- Author:      <Jagadish K.>                            
-- Create Date: <6th Dec 2022 >                            
-- Description: < return Carrier Name and CarrierID to IVR  >                        
-- Exec IVR.GetInsuranceCarrierName 0    
-- =============================================    
CREATE   Proc [IVR].[GetInsuranceCarrierName]  
(  
   @MemberPANProxy varchar(100)   
)  
As  
BEGIN                            
 BEGIN TRY                           
   SET NOCOUNT ON   
  
  select IC.InsuranceCarrierID,InsuranceCarrierName   
  from Insurance.InsuranceCarriers IC WITH(NOLOCK)   
  inner join MEMBER.MEMBERCARDS MC WITH(NOLOCK)   
  on IC.InsuranceCarrierID=MC.InsuranceCarrierID   
  where        
  CardReferenceNumber = @MemberPANProxy and MC.IsActive = 1    
  
  END TRY                          
 BEGIN CATCH                          
  SELECT                           
   ERROR_NUMBER() AS ErrorNumber                          
  ,ERROR_MESSAGE() AS ErrorMessage;                          
 END CATCH                          
END 
GO
/****** Object:  StoredProcedure [IVR].[InsertIVRRequestResponse]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE     proc [IVR].[InsertIVRRequestResponse]
(
   @aauid uniqueidentifier =null,
   	@ConversationID nvarchar(250) = null,
	@CardNum nvarchar(250) = null,
	@IsElevance bit = null,
	@MethodName varchar(100)= null,
	@Reqobj nvarchar(max)= null,
	@Resobj nvarchar(max)= null,
	@Source varchar(100) = 'IVR',
	@Status	varchar(50)= null,
	@ErrorMessage varchar(500) = null,
	@CreateUser	varchar(50)= null,
	@ModifyUser varchar(50) = null
)
    
AS
Begin

   INSERT INTO [IVR].[IVRRequestResponse]
           ([aauid]
		   ,[ConversationID]
		   ,[CardNum]
           ,[MethodName]
		   ,[IsElevance]
           ,[Reqobj]
           ,[Resobj]
           ,[Source]
           ,[Status]
		   ,[ErrorMessage]
           ,[isActive]
           ,[CreateUser]
           ,[CreateDate]
           ,[ModifyUser]
           ,[ModifyDate])
     VALUES
           ( @aauid,
		   @ConversationID
		   ,@CardNum
           ,@MethodName
		   ,@IsElevance
           ,@Reqobj
           ,@Resobj
           ,@Source
           ,@Status
		   ,@ErrorMessage
           ,1
           ,@CreateUser
           ,GETDATE()
           ,@ModifyUser
           ,GETDATE())

END
GO
/****** Object:  StoredProcedure [IVR].[InsertUpdateIVREnquiryInfo]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================                                  
-- Author:      <Jagadish K.>                                  
-- Create Date: <6th Dec 2022 >                                  
-- Description: < >                              
-- Exec IVR.InsertUpdateIVREnquiryInfo 0,'Enq001'           
-- Exec IVR.InsertUpdateIVREnquiryInfo 1,'Enq001','IVR','02455dd'       
-- Modify By: Madhu Bejugam     
-- Description : removed update query    
-- Modify : Madhu B  
--Description: updated Status and CreateUser  
-- =============================================                                  
CREATE       PROCEDURE [IVR].[InsertUpdateIVREnquiryInfo]                               
(                     
    @EnquiryID bigint = 0,               
    @ConversationID Nvarchar(255),        
 @Source varchar(10) = null,        
 @ProxyKey nvarchar(50) = null,        
    @InsuranceCarrierID bigint = null,        
 @InsuranceCarrierName nvarchar(200) = null,        
 @ReceievdDate DATETIME = null,        
 @CardStatus VARCHAR(50) = null,        
 @PersonalDetails Varchar(500) = null,        
 @BalanceDetails varchar(2000) = null,        
 @Status VARCHAR(10) = 'Processed',        
 @isActive bit = null,        
 @isElevance bit = null,        
 @CreateUser varchar(100) = 'SystemUser'         
)                                
                                  
AS                                  
BEGIN                                  
 BEGIN TRY                                 
   SET NOCOUNT ON         
             
    if exists (select ConversationID from IVR.IVREnquiryInfo where ConversationID=@ConversationID and isActive = 1)      
    begin       
  update IVR.IVREnquiryInfo       
  set isActive=0,      
  ModifyUser =@CreateUser,        
  ModifyDate =GETDATE()       
  where ConversationID=@ConversationID      
    end      
      
    
   INSERT INTO IVR.IVREnquiryInfo(ConversationID,InsuranceCarrierID,InsuranceCarrierName,PersonalDetails,ProxyKey,CardStatus,isElevance,BalanceDetails,ReceievdDate,isActive,CreateUser,CreateDate,ModifyUser,ModifyDate,Status)         
   values                        (@ConversationID,@InsuranceCarrierID,@InsuranceCarrierName,@PersonalDetails,@ProxyKey,@CardStatus,@isElevance,@BalanceDetails,GETDATE(),1,@CreateUser,GETDATE(),@CreateUser,GETDATE(),@Status)             
   select SCOPE_IDENTITY() as EnquiryID          
 
 END TRY                                
 BEGIN CATCH                                
  SELECT                                 
   ERROR_NUMBER() AS ErrorNumber                                
  ,ERROR_MESSAGE() AS ErrorMessage;                                
 END CATCH                                
END 
GO
/****** Object:  StoredProcedure [IVR].[IVRRequestResponseFailedReport]    Script Date: 6/26/2024 1:12:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================  
-- Author:      <Author, Madhu B>  
-- Create Date: <Create Date, 21-12-2022 >  
-- Description: <Description, to get the validation failed data from ivr.IVRRequestResponse  >  
-- EXEC IVR.IVRRequestResponseFailedReport '2022-12-19'  
-- =============================================  
CREATE     PROCEDURE [IVR].[IVRRequestResponseFailedReport]   
(  
   @RequiredDate datetime = null  
)  
AS  
BEGIN  
    -- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.  
    SET NOCOUNT ON  
  
  SELECT  INFO.ConversationID, 
  JSON_VALUE(info.PersonalDetails, '$.BirthDate') AS FISDateOfBirth,  
  SUBSTRING(ires.Reqobj, CHARINDEX('dateOfBirth: ', ires.Reqobj)+Len('dateOfBirth: ')+1, 8) as enteredDataDOB,  
  JSON_VALUE(info.PersonalDetails, '$.Zipcode') AS FISZipcode,  
  SUBSTRING(ires.Reqobj, CHARINDEX('zipCode: ', ires.Reqobj)+Len('zipCode: ')+1, 5) as enteredzipcode ,
  IRES.ErrorMessage
  FROM IVR.IVRENQUIRYINFO INFO   
  INNER JOIN IVR.IVRREQUESTRESPONSE IRES ON INFO.CONVERSATIONID = IRES.CONVERSATIONID  
  WHERE IRES.SOURCE='IVR' AND IRES.METHODNAME = 'IVRMEMBERVALIDATION_VALIDATIONFAILED'  
  AND IRES.CREATEDATE >= ISNULL(@REQUIREDDATE, GETDATE()-1)  
  ORDER BY 1 DESC   
END  

GO
