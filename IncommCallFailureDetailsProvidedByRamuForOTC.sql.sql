-- =======================================================
-- Create Stored Procedure Template for Azure SQL Database
-- =======================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
---execute support.GetFailedIncommCallDetails
/*
Author: Satish Kumar Lakkimsetti
Create Date: 17-March-2021 
Description:Getting failed incomm call details
 ==============================================================
 Information for Incomm URIS 
 1)api/OTC/Transact/GetSecondaryIdType -for getting secondary id type
 2)api/OTC/Transact/GetCardAccessInformation -for validating secondary Id against cardnumber 
 3)api/OTC/Transact/BenefitInquiry - for BenefitInquiry
===============================================================
*/
ALTER PROCEDURE support.GetFailedIncommCallDetails
(
@fromDate Date =null
,@toDate Date =null
)
AS
BEGIN

IF(@fromDate is NULL )
BEGIN
select @fromDate=cast(DATEADD(dd,-30,getdate()) AS DATE)
END

IF(@toDate is NULL )
BEGIN
SELECT @toDate=cast(getdate() AS DATE)
END

PRINT concat('FromDate:',@fromDate)
PRINT concat('toDate:',@toDate)


DECLARE @requiredData TABLE
(
	[Id] [uniqueidentifier] NOT NULL,
	[RefId] [varchar](30) NOT NULL,
	[Client] [varchar](200) NOT NULL,
	[Uri] [nvarchar](max) NOT NULL,
	[Type] [nvarchar](8) NULL,
	[Content] [nvarchar](max) NULL,
	[StatusCode] [smallint] NULL,
	[CreateUser] [nvarchar](50) NOT NULL,
	[ModifyUser] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[ModifyDate] [datetime2](7) NOT NULL,
	[IsActive] [bit] NOT NULL
)

--loading data from given time period.
INSERT INTO @requiredData(Id,RefId,Client,Uri,Type,Content,StatusCode,CreateUser,ModifyUser,CreateDate,ModifyDate,IsActive)
SELECT Id,RefId,Client,Uri,Type,Content,StatusCode,CreateUser,ModifyUser,CreateDate,ModifyDate,IsActive
FROM logs.HttpMessages logs WITH (NOLOCK) WHERE logs.CreateDate > @fromDate AND logs.CreateDate <= @toDate and (statuscode=0 OR statuscode!=200)

SELECT 
JSON_VALUE(rm.content,'$.cardNumber') as CardNumber
,@fromDate AS FromDate
,@toDate AS ToDate
,rm.uri AS Uri
,rm.content AS Request
,rs.content AS Response 
,rs.statuscode AS status
,
(
CASE
WHEN isjson(rs.content)>0 AND JSON_VALUE(rs.content,'$.data.display_message') IS NOT NULL THEN JSON_VALUE(rs.content,'$.data.display_message')
WHEN isjson(rs.content)>0 AND JSON_VALUE(rs.content,'$.data') IS NOT NULL THEN json_value(rs.content,'$.data')
ELSE NULL
END
) AS ErrorMessage  
FROM @requiredData rm  
INNER JOIN @requiredData rs  on rm.refid=rs.refid and rs.type='response'
WHERE 
rm.CreateDate > @fromDate 
AND rm.CreateDate <= @toDate 
AND rs.CreateDate > @fromDate 
AND rs.CreateDate <= @toDate 
AND IsJson(rm.Content)=1 and IsJson(rs.Content)=1
AND rm.type='request'
AND rs.statuscode!='200' 
AND (
rm.uri LIKE '%api/OTC/Transact/GetSecondaryIdType%' 
OR rm.uri LIKE '%api/OTC/Transact/GetCardAccessInformation%' 
OR rm.uri LIKE '%api/OTC/Transact/BenefitInquiry%'
)
END
GO
