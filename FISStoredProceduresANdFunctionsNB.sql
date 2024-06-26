/****** Object:  UserDefinedFunction [flex].[Fn_Insert_Select_RecordTypeQuery]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [flex].[Fn_Insert_Select_RecordTypeQuery]
(
@RecordType INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Query VARCHAR(MAX);


--	 )
SELECT @Query =   'INSERT INTO ' + BaseTableName +'('+ColumnNames+')'
+CHAR(10)+'SELECT '+ RecordType_Column_Query+','
				   +IIF((RecordType=90 OR RecordType=10 ) ,'CAST(@FileTrackId as varchar(10))'+','
				   ,'CAST(@Identity as varchar(10))'+',')
				   +RecordType_Query 
				  -- + IIF((RecordType=30 OR RecordType=60 ),'', 'SELECT '+ RecordType_Query)
 FROM (
SELECT
 BaseTableName
,ColumnNames
,RecordType
,RecordType_Query = STUFF((SELECT IIF((DefaultValue IN ('FK','BaseTable') OR StartPosition=-1)
											,''
											,' +' +IIF(DefaultValue = ' '
													 ,'REPLICATE('''+ DefaultValue+''','+CAST((EndPosition+1)-Startposition AS varchar)+')'
													 ,'CAST('+ DefaultValue +' AS varchar(400))' ))
                                   FROM(SELECT IIF(Startposition IN (-1), ID*100, Startposition ) orderid, FieldName,DefaultValue,Startposition,EndPosition
                                   FROM  flex.FISFieldStartEndPositions U
                                   WHERE U.RecordType = CTE.RecordType								   
                                   ) sc
								   order by orderid
                                   FOR
                                   XML PATH('')
                                   ), 1, 2, '')
,RecordType_Column_Query = STUFF((SELECT IIF((DefaultValue IN ('FK','BaseTable') )
											,''
											,' , ['+FieldName+'] = ' +IIF(Required='FIS','NULL',IIF(DefaultValue=' '
													 ,'REPLICATE('''+ DefaultValue+''','+CAST((EndPosition+1)-Startposition AS varchar)+')'
													 ,DefaultValue  )))
                                   FROM(SELECT IIF(Startposition IN (-1), ID*100, Startposition )orderid,FieldName,DefaultValue,EndPosition,Startposition,Required
                                   FROM  flex.FISFieldStartEndPositions U
                                   WHERE U.RecordType = CTE.RecordType								  
                                   ) sc
								   order by orderid
                                   FOR
                                   XML PATH('')
                                   ), 1, 2, '')
FROM (SELECT 
	   RecordType
	  ,FKColumnName = MAX(CASE WHEN DefaultValue='FK' THEN FieldName ELSE NULL END)
	  ,BaseTableName = MAX(CASE WHEN DefaultValue='BaseTable' THEN FieldName ELSE NULL END)	 
	  ,ColumnNames = STUFF((SELECT IIF(DefaultValue='BaseTable','',' ,' +'['+FieldName +']')
                                   FROM(SELECT IIF(Startposition IN (-1), ID*100, Startposition )orderid, FieldName,DefaultValue
                                   FROM  flex.FISFieldStartEndPositions U
                                   WHERE U.RecordType = I.RecordType
                                   ) sc
								   order by orderid
                                   FOR
                                   XML PATH('')
                                   ), 1, 2, '')+','+'[CombinedRecord]'
	 FROM flex.FISFieldStartEndPositions I 
	 WHERE RecordType=@RecordType
	 GROUP BY RecordType
) CTE
) t 
RETURN  @Query;
 
END
GO
/****** Object:  UserDefinedFunction [flex].[Fn_Replace_Special_Character]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [flex].[Fn_Replace_Special_Character] (
@String VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
DECLARE @NString VARCHAR(4000)
SET @NString = @String ;
With Special_C AS
(
SELECT '>' AS Ch
UNION ALL
SELECT '<' AS Ch
UNION ALL
SELECT '(' AS Ch
UNION ALL
SELECT ')' AS Ch
UNION ALL
SELECT '!' AS Ch
UNION ALL
SELECT '?' AS Ch
UNION ALL
SELECT '@' AS Ch
UNION ALL
SELECT '*' AS Ch
UNION ALL
SELECT '%' AS Ch
UNION ALL
SELECT '$' AS Ch
UNION ALL
SELECT '~' AS Ch
UNION ALL
SELECT '#' AS Ch
)
SELECT @NString = REPLACE(@NString, Ch, '') FROM SPECIAL_C
RETURN @NString
END
GO
/****** Object:  UserDefinedFunction [flex].[RemoveExtendedASCII]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [flex].[RemoveExtendedASCII] 
(
    @nstring nvarchar(255)
)
RETURNS varchar(255)
AS
BEGIN

    DECLARE @Result varchar(255)
    SET @Result = ''

    DECLARE @nchar nvarchar(1)
    DECLARE @position int

    SET @position = 1
    WHILE @position <= LEN(@nstring)
    BEGIN
        SET @nchar = SUBSTRING(@nstring, @position, 1)
        --Unicode & ASCII are the same from 1 to 255.
        --Only Unicode goes beyond 255
        --0 to 31 are non-printable characters
        IF (     
				ASCII(@nchar) between 48 and 57  -- Numeric
		     OR ASCII(@nchar) between 65 and 90  -- Uppercase alphabets
			 OR ASCII(@nchar) between 97 and 122 -- Lowercase alphabets
			 OR ASCII(@nchar) = 32 -- Space
			 OR ASCII(@nchar) = 35 -- Pound
			 OR ASCII(@nchar) = 38 -- Ampersand
			 OR ASCII(@nchar) = 39 -- Single quote
			 OR ASCII(@nchar) = 47 -- Slash
			 OR ASCII(@nchar) between 44 and 46  -- Comma, Hyphen & Period			 
			)
            SET @Result = @Result + @nchar
        SET @position = @position + 1
    END

    RETURN @Result

END
GO
/****** Object:  StoredProcedure [BenefitCardRequest].[sp_CardIssueRequestData]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================            
-- Author:      <Author, Madhu B>            
-- Create Date: <Create Date,04/08/2023 , >            
-- Description: <Description, Inserts Values     
-- =============================================            

CREATE   PROC [BenefitCardRequest].[sp_CardIssueRequestData]             
(            
   @tabType BenefitCardRequest.CardIssueRequestData READONLY    

)            
AS            
BEGIN            
    -- SET NOCOUNT ON added to prevent extra result sets from            
    -- interfering with SELECT statements.     
INSERT INTO [BenefitCardRequest].[CardIssue]    
           ([NHLinkID],[InsCarrierID] ,[InsHealthPlanID] 
           ,[FirstName] 
           ,[MiddleInitial]    
           ,[LastName]        
           ,[DOB]    
           ,[MailingAddress1]    
           ,[MailingAddress2]    
           ,[MailingCity]    
           ,[MailingState]    
           ,[MailingZipCode]    
           ,[RequestToBeProcessed]    
           ,[CreateDate]   ,[CreateUser]    ,[ModifyDate]    ,[ModifyUser]    
           ,[ClientID]    ,[SubProgramID] ,[ProgramID]    ,[PackageID]  ,[Level1ClientID]    
           ,[OBTID])    

      select   NHLinkID    
           ,InsCarrierID    
           ,InsHealthPlanID    
           ,FirstName     
           ,MiddleInitial    
           ,LastName    
           ,DOB    
           ,MailingAddress1    
           ,MailingAddress2    
           ,MailingCity    
           ,MailingState    
           ,MailingZipCode   ,RequestToBeProcessed    ,CreateDate     ,CreateUser    ,ModifyDate    ,ModifyUser    
           ,ClientID  ,SubProgramID   , ProgramID ,PackageID    
           ,Level1ClientID    
           ,OBTID from  @tabType t     
     where t.OBTID not in (select OBTID from [BenefitCardRequest].[CardIssue])    
END     
GO
/****** Object:  StoredProcedure [flex].[sp_FIS_FundDisbursement_Credits]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [flex].[sp_FIS_FundDisbursement_Credits]   
AS  

BEGIN 
BEGIN TRY
BEGIN TRANSACTION FISFDCredits

drop table if exists #Credits,#FD,#DontUpdate

select *
into #Credits
-- select *
from BenefitCardRequest.FundDisbursement e WITH (NOLOCK)
where 1=1
and ISNULL(e.RequestToBeProcessed,'') = 'Y'
AND e.isActive = 1

select f.*
,t.BenefitAmount [IncentiveValue],t.BenefitCardRequestID
into #FD 
-- select f.*,t.amount
from #Credits t
join (
			select *,RANK() over(PARTITION by fd.NHLinkID,fd.BenefitCardNumber,fd.FIS_PurseSlot order by fd.CardBenefitLoadID DESC) Prank1
			from otcfunds.CardBenefitLoad_FD fd
			where 1=1
			and ResponseRecordStatus = 'success'
)
f on f.NHLinkID = t.NHLinkID and t.insCarrierID = f.InsCarrierID and f.FIS_PurseSlot = t.FIS_PurseSlot and f.BenefitYear = t.BenefitYear and f.BenefitPeriod = t.BenefitPeriod and Prank1 = 1
and f.ResponseRecordStatus = 'success'
where 1=1

-- None of these members are eligible for these benefits
select a1.NHLinkID [RewardsNhlinkID],a1.BenefitAmount IncentiveValue,a1.BenefitCardRequestID,a1.FIS_PurseSlot [RewardPurseSlot]--,f.*
into #DontUpdate
from (
		select NHLinkID,FIS_PurseSlot
		from #Credits
		except 
		select NHLinkID,FIS_PurseSlot
		from #FD
)a
join #Credits a1 on a1.NHLinkID = a.NHLinkID and a1.FIS_PurseSlot = a.FIS_PurseSlot
--join otcfunds.CardBenefitLoad_FD f on f.NHLinkID = a.NHLinkID and GETDATE() between BenefitValidFrom and BenefitValidTo

update f
set RecordType = 'FD',MemberDataId = BenefitCardRequestID,RefCardBenefitLoadID = NULL,RequestToBeProcessed = 'Y',RequestRecordStatus = NULL,RequestProcessedFileID = NULL,RequestProcessedDate = NULL   
	,ResponseRecordStatus = NULL,ResponseRecordStatusCode = NULL,ResponseProcessedFileID = NULL,ResponseProcessedDate = NULL, CreateDate = getdate(), ModifyDate = getdate()
	,MemberDataSource = 'elig' --elig --credit
	,MemberDataSourceFile = 'Credit'
-- select *
from #FD f 

update t
set benefitamount = (IncentiveValue)
from #FD t

---- Updating the dates so after the 25th of the month we load to next month
--update fd
--set BenefitValidFrom = cast(DATEADD(month, DATEDIFF(month, 0, getdate()+5), 0) as date),BenefitValidTo =cast(DATEADD(d, -1, DATEADD(m, DATEDIFF(m, 0, getdate()+5) + 1, 0)) as date),BenefitPeriod = month(getdate()+5)
---- select *
--from #FD fd
--where 1=1
--and BenefitFreqInMonth = 1

--update fd
--set BenefitValidFrom = cast(DATEADD(qq,DATEDIFF(qq,0,GETDATE()+5),0) as date),BenefitValidTo =cast(DATEADD(qq,DATEDIFF(qq,-1,GETDATE()+5),-1) as date),BenefitPeriod = '2' + cast(DATEPART(q, getdate()) as varchar)
---- select *
--from #FD fd
--where 1=1
--and BenefitFreqInMonth = 3

alter table #FD drop column IncentiveValue, cardbenefitloadid, BenefitCardRequestID, Prank1

-- Inserting final records in FD
insert into otcfunds.CardBenefitLoad_FD
select *
from #FD

-- Updating BenefitCardRequest table to mark it as processed
update a
set a.RequestToBeProcessed = 'P'
-- select *
from BenefitCardRequest.FundDisbursement a
--join otcfunds.CardBenefitLoad_FD fd on fd.MemberDataID = a.BenefitCardRequestID and fd.NHLinkID = a.NHLinkid and fd.RequestToBeProcessed = 'Y'
JOIN #Credits r1 ON r1.NHLinkID = a.NHLinkID AND a.BenefitCardRequestID = r1.BenefitCardRequestID
WHERE 1=1
and ISNULL(a.RequestToBeProcessed,'') = 'Y'
and not exists (
				select 1 
				from #DontUpdate d
				where 1=1
				and d.BenefitCardRequestID = a.BenefitCardRequestID
				and d.RewardsNhlinkID = a.NHLinkid
)


drop table if exists #AlignCredits,#FD,#DontUpdate,#AlignCreditsFailed

COMMIT TRANSACTION FISFDCredits
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISFDCredits 
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(); 
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_CardIssue_CreateFile]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [flex].[sp_ssis_FIS_CardIssue_CreateFile] (@ClientCode VARCHAR(20), @Level1Clientid bigint)
AS

-- exec flex.[sp_ssis_FIS_CardIssue_CreateFile] 'H672',995407

BEGIN
SET NOCOUNT ON 

BEGIN TRY

		BEGIN TRANSACTION FISCardIssueCreateFile
			
			      -- Questions -- Check again in eligibilty and update CardBenefitLoadID
				  --    Change the package name
				  
				  declare @FileThresHold   int;
				  declare @RecordTypeCnt   int;
				  declare @RecordTypes     varchar(50);
				  --declare @Level1Clientid  varchar(6);
				  
				  -- Need to discuss if required - SD
				  /*
                  DECLARE file_cursor CURSOR FOR
                  SELECT ISNULL(FileThreshold,0) FileThreshold, RecordTypeCnt, RecordTypes , convert(varchar(6), Level1Clientid) Level1Clientid 
				                                FROM  otcfunds.FileInfo fo WHERE 1=1
																					AND fo.ClientCode = @ClientCode
																					AND fo.isActive = 1
																					AND fo.Direction ='OUT'
																					AND fo.SnapshotFlag = 'CI' ;
																					
                  OPEN file_cursor;
                  FETCH NEXT FROM file_cursor INTO @FileThresHold, @RecordTypeCnt, @RecordTypes, @Level1Clientid;
                 
                  CLOSE file_cursor;
                  DEALLOCATE file_cursor;
				  */
				  
				 SELECT @FileThresHold = ISNULL(FileThreshold,0)
				        ,@RecordTypeCnt = RecordTypeCnt
						,@RecordTypes = RecordTypes
				 FROM  otcfunds.FileInfo fo 
				 WHERE 1=1
				 --AND fo.ClientCode = @ClientCode
				 AND fo.isActive = 1
				 AND fo.Direction ='OUT'
				 AND fo.SnapshotFlag = 'CI' 
				AND fo.Level1ClientID = @Level1Clientid;


					/*Step 1 Start - Load #Temp_CardBenefitLoad*/
					DROP TABLE IF EXISTS #Temp_CardBenefitLoad

					CREATE TABLE #Temp_CardBenefitLoad
					(
						[CardBenefitLoadID] [bigint]  NOT NULL,
						[MemberDataID] [bigint] NOT NULL,
						[ClientCode] [varchar](20) NULL,
						[NHLinkID] [varchar](100) NULL,
						[RecordType] [varchar](50) NULL,
						[MemberDataSource] [varchar](50) NULL,
						[InsCarrierID] [int] NULL,
						[InsHealthPlanID] [int] NULL,
						[BenefitCardNumber] [varchar](30) NULL,
						[LastName] [nvarchar](100) NULL,
						[MiddleInitial] [nvarchar](20) NULL,
						[FirstName] [nvarchar](100) NULL,
						[DOB] [date] NULL,
						[MailingAddress1] [nvarchar](150) NULL,
						[MailingAddress2] [nvarchar](100) NULL,
						[MailingCity] [nvarchar](100) NULL,
						[MailingState] [nvarchar](50) NULL,
						[MailingZipCode] [nvarchar](20) NULL,
						[MailingCountry] [nvarchar](100) NULL,
						[HomePhoneNbr] [nvarchar](20) NULL,
						[BenefitType] [varchar](50) NULL,
						[BenefitSource] [varchar](50) NULL,
						[NBWalletCode] [varchar](50) NULL,
						[BenefitAmount] [decimal](10, 2) NULL,
						[BenefitValidFrom] [date] NULL,
						[BenefitValidTo] [date] NULL,
						[BenefitFreqInMonth] [int] NULL,
						[BenefitYear] [int] NULL,
						[BenefitPeriod] [int] NULL,
						[IsActive] [bit] NULL,
						[RequestRecordStatus] [varchar](50) NULL,
						[RequestToBeProcessed] [varchar](20) NULL,
						[RequestProcessedFileID] [bigint] NULL,
						[RequestProcessedDate] [datetime] NULL,
						[ResponseRecordStatus] [varchar](225) NULL,
						[ResponseRecordStatusCode] [varchar](2) NULL,
						[ResponseProcessedFileID] [bigint] NULL,
						[ResponseProcessedDate] [datetime] NULL,
						[FirstTimeCardIssued] [varchar](1) NULL,
						[CreateDate] [datetime] NULL,
						[CreateUser] [nvarchar](100) NULL,
						[ModifyDate] [datetime] NULL,
						[ModifyUser] [nvarchar](100) NULL,
						[RefCardBenefitLoadID] [bigint] NULL,
						[ErrorProcessed] [smallint] NULL,
						--[Language] [nvarchar](50) NULL,
						[ClientID] bigint,
						--[ProgramID] bigint,
						[SubProgramID] bigint,
						[PackageID] bigint,
						[FIS_PurseSlot] nvarchar(30),
						[DiscretionaryData1] nvarchar(50),
						[FourthLine] nvarchar(26),
						[CarrierMessage] nvarchar(256),
						[DiscretionaryData2] varchar(50),
						OtherInformation VARCHAR(60)
						CONSTRAINT [PK_Temp_CardBenefitLoad_CI] PRIMARY KEY CLUSTERED 
					(
						[CardBenefitLoadID] ASC
					)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
					) ON [PRIMARY]


					--SELECT * INTO #Temp_CardBenefitLoad FROM otcfunds.CardBenefitLoad_CI WHERE 1 = 0
					
					SET ROWCOUNT @FileThresHold

					INSERT INTO #Temp_CardBenefitLoad
					(
					CardBenefitLoadID
					,MemberDataID
					,ClientCode
					,NHLinkID
					,RecordType
					,MemberDataSource
					,InsCarrierID
					,InsHealthPlanID
					,BenefitType
					,BenefitSource
					,NBWalletCode
					,BenefitAmount
					,BenefitValidFrom
					,BenefitValidTo
					,BenefitFreqInMonth
					,BenefitYear
					,BenefitPeriod
					,IsActive
					,LastName
					,MiddleInitial
					,FirstName
					,DOB
					,MailingAddress1
					,MailingAddress2
					,MailingCity
					,MailingState
					,MailingZipCode
					,MailingCountry
					,HomePhoneNbr
					,BenefitCardNumber
					,RequestToBeProcessed
					,ClientID
					--,ProgramID
					,SubProgramID
					,PackageID
					,FIS_PurseSlot
					,DiscretionaryData1
					,FourthLine
					,CarrierMessage
					,DiscretionaryData2
					,OtherInformation
					)
					SELECT DISTINCT
					 cbl.CardBenefitLoadID
					,cbl.MemberDataID
					,cbl.ClientCode
					,cbl.NHLinkID
					,cbl.RecordType
					,cbl.MemberDataSource
					,cbl.InsCarrierID
					,cbl.InsHealthPlanID
					,cbl.BenefitType
					,cbl.BenefitSource
					,cbl.NBWalletCode
					,cbl.BenefitAmount
					,cbl.BenefitValidFrom
					,cbl.BenefitValidTo
					,cbl.BenefitFreqInMonth
					,cbl.BenefitYear
					,cbl.BenefitPeriod
					,cbl.IsActive
					,cbl.LastName
					,LEFT (cbl.MiddleInitial,1) MiddleInitial 
					,cbl.FirstName
					,cbl.DOB
					,LEFT(flex.RemoveExtendedASCII(cbl.MailingAddress1),50) MailingAddress1   
					,flex.RemoveExtendedASCII(cbl.MailingAddress2) MailingAddress2
					,flex.RemoveExtendedASCII(cbl.MailingCity) MailingCity
					,cbl.MailingState
					,CASE WHEN  LEN(cbl.MailingZipCode) < 5 THEN RIGHT('00000'+ISNULL(cbl.MailingZipCode,''),5) ELSE cbl.MailingZipCode END MailingZipCode
					,cbl.MailingCountry
					,ISNULL(CASE   WHEN  TRY_CAST(HomePhoneNbr AS BIGINT) IS NULL THEN '1'
								   WHEN ISNUMERIC(HomePhoneNbr) = 1 AND CAST(HomePhoneNbr AS BIGINT) = 0 THEN '1' 
										 ELSE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IIF(HomePhoneNbr IN (''),'1',HomePhoneNbr),')',''),'(',''),',',''),'-',''),' ','')  
										 END,1) HomePhoneNbr
					,cbl.BenefitCardNumber
					,cbl.RequestToBeProcessed
					,cbl.ClientID
					--,cbl.ProgramID
					,cbl.SubProgramID
					,cbl.PackageID
					,FIS_PurseSlot = ''
					,ISNULL(DiscretionaryData1,'') DiscretionaryData1 -- NOV2022
					,ISNULL(FourthLine,'') FourthLine
					,ISNULL(CarrierMessage,'') CarrierMessage
					,ISNULL(DiscretionaryData2,'') DiscretionaryData2
					,ISNULL(OtherInformation,'') OtherInformation
					FROM otcfunds.CardBenefitLoad_CI cbl					
				    WHERE 1=1
					AND cbl.IsActive = 1
					--AND cbl.ClientCode= @ClientCode
					AND cbl.Level1ClientID = @Level1Clientid
					AND cbl.RequestToBeProcessed = 'Y'
					--AND isnull(cbl.FileGenInd,'N') = 'N'
					AND (ISNULL(cbl.ClientID,'') != '' OR ISNULL(cbl.SubProgramID,'') != '' OR ISNULL(cbl.PackageID,'') != '')
					order by cbl.PackageID,cbl.SubProgramID,cbl.ClientID

					/*Step 1 End */
                    SET ROWCOUNT 0


					/*Step 3 Start  - Pre process */
					DECLARE @MaxLenSQL VARCHAR(MAX)
					,@UpdateSQL VARCHAR(MAX)
					,@TableName VARCHAR(200)

					/*Max Length Check */

					DROP TABLE IF EXISTS #tempMaxLength

					CREATE TABLE #tempMaxLength(ColumnName varchar(200),MaxLength int,ColumnAllowedLen int)
					SELECT @TableName = '#Temp_CardBenefitLoad'
					SELECT @MaxLenSQL = ''
					SELECT @MaxLenSQL =  @MaxLenSQL + 'SELECT ColumnName = ' + QUOTENAME(sc.OTCColumnName, '''')  
									   + ', MaxLength = MAX(LEN(' + QUOTENAME(sc.OTCColumnName) + '))'
									   + ', ColumnAllowedLen = '+CAST(((sc.EndPosition+1)-sc.StartPosition) as varchar(10))
									   + ' FROM '
									   + @TableName
									   + ' WHERE RequestToBeProcessed = ''Y'''				   
									   + CHAR(10) +' UNION '
					FROM flex.FISFieldStartEndPositions sc
					WHERE RecordType = 30
					AND OTCColumnName IS NOT NULL

					SELECT @MaxLenSQL = LEFT(@MaxLenSQL, LEN(@MaxLenSQL)-6)
					SELECT @MaxLenSQL = 'INSERT INTO #tempMaxLength '+CHAR(10) + @MaxLenSQL
					PRINT @MaxLenSQL
					EXEC (@MaxLenSQL)


					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL =  @UpdateSQL + ' UPDATE '+@TableName
													+ ' SET  RequestToBeProcessed = ''ERR_SIZE'''
													+ ' WHERE LEN('+ColumnName +') >'+ CAST(ColumnAllowedLen as varchar(10))
													+ ' AND RequestToBeProcessed = ''Y'''
													FROM #tempMaxLength
													WHERE MaxLength>ColumnAllowedLen
					EXEC(@UpdateSQL)



					/* Nullable check for Mandatory Columns*/

					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL = ' UPDATE '+@TableName
										+ CHAR(10)
										+ 'SET RequestToBeProcessed = ''ERR_MAN_COL'''
										+ CHAR(10)
										+ 'WHERE ('
										+ CHAR(10)
										+ STUFF((SELECT ' +' +'CAST(['+sc.OTCColumnName +'] AS varchar(400))'
													   FROM(SELECT U.OTCColumnName
													   FROM  flex.FISFieldStartEndPositions U
													   WHERE RecordType = 30
													   AND [Required] ='Yes'
													   AND OTCColumnName IS NOT NULL
													   ) sc
													   FOR
													   XML PATH('')
													   ), 1, 2, '')
										 + CHAR(10)
										 +') IS NULL'
					PRINT @UpdateSQL
					EXEC(@UpdateSQL)

					/* Replace Special Charcters */
				IF CHARINDEX('33',@RecordTypes)  > 0  --NOV2022
					BEGIN 
			        UPDATE  #Temp_CardBenefitLoad
					SET  FirstName = flex.[Fn_Replace_Special_Character](FirstName)
					   , LastName = flex.[Fn_Replace_Special_Character](LastName)
					   , MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
					   , MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
					WHERE RequestToBeProcessed = 'Y' 
					AND (FirstName LIKE '%[^0-9a-zA-Z]%' 
						OR  LastName LIKE '%[^0-9a-zA-Z]%' 
						OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
						OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
						)					
					
					END 
				ELSE 
					BEGIN
					UPDATE  #Temp_CardBenefitLoad
					SET  FirstName = flex.[Fn_Replace_Special_Character](FirstName)
					   , LastName = flex.[Fn_Replace_Special_Character](LastName)
					   --, MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
					   --, MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
					WHERE RequestToBeProcessed = 'Y' 
					AND (FirstName LIKE '%[^0-9a-zA-Z]%' 
						OR  LastName LIKE '%[^0-9a-zA-Z]%' 
						--OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
						--OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
						)
					END	
						
					/* Updating otc funds table for Error Records*/ 

					UPDATE otc
					SET otc.RequestToBeProcessed = tcb.RequestToBeProcessed
					,otc.RequestRecordStatus = CASE WHEN tcb.RequestToBeProcessed ='ERR_SIZE' THEN   'Column length exceeded more than FIS'
													WHEN tcb.RequestToBeProcessed ='ERR_MAN_COL' THEN   'FIS Mandatory columns does not allow NULL values' 
											   END
					FROM otcfunds.CardBenefitLoad_CI otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed  IN('ERR_SIZE','ERR_MAN_COL')



					/*Step 3 END */
					
					/* Updating otc funds table success  Records*/ 

					UPDATE otc
					SET otc.FileGenInd = 'Y'					
					FROM otcfunds.CardBenefitLoad_CI otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE otc.RequestToBeProcessed  = 'Y'



					/*Step 3A END */



					/*Step 4 Start Insert FIS Batch file records */

					DROP TABLE IF EXISTS #ClientDetails
					DROP TABLE IF EXISTS #Loop
					DROP TABLE IF EXISTS #FileInfo
					--DROP TABLE IF EXISTS #TempBatch



					DECLARE @Query nvarchar(max)

					,@Identity bigint
					--RecordType = 90

					,@TotalRecords int
					,@BatchCount int
					,@DetailCount int
					,@BatchDetailCount int
					,@TotalCredit decimal (12,2)
					,@TotalDebit decimal (12,2)
					,@FileTrailerID bigint

					,@BatchSequence int
					,@ClientID varchar(20)
					,@SubprogramID varchar(20)
					,@PackageID varchar(20)
					,@RecordType int

					,@Parmdef nvarchar (max)
					,@FileHeaderID bigint
					,@Direction varchar(3)='OUT'
					,@FileTrackId bigint
					,@VendorWalletCode varchar(2)

					--SELECT * FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'

					--SELECT COUNT(1) FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'


					IF EXISTS (SELECT TOP 1 1 FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y')
					BEGIN

					SELECT DISTINCT fo.FileInfoID as FileInfoID,	
						fo.SnapshotFlag + FORMAT(CAST(GETDATE()AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime),'HHmmssMMddyyyy')+'01'+'.'+ fo.FileExtension AS FileName,
						fo.FromLocation AS FromLocation,
						fo.ToLocation AS ToLocation,
						fo.Direction AS Direction,
						fo.FileFormat AS FileFormat,
						fo.SnapshotFlag AS SnapshotFlag,
						fo.DataSource AS DataSource,
						fo.FileExtension AS FileExtension,
						fo.FileType AS FileType,
						ftpi.WinSCPLoginName AS WinSCPLoginName,
						ISNULL(fo.IsPGP,'') AS IsPGP,
						ISNULL(fo.PGPFileExtension,'') AS PGPFileExtension,
						ISNULL(fo.PGPKeyName,'') AS PGPKeyName,
						ISNULL(fo.isAckFileToFTP,'') AS isFileToFTP
						INTO #FileInfo
					FROM otcfunds.FileInfo fo
					JOIN otcfunds.FTPUserInfo ftpi 
					ON fo.ClientCode = ftpi.ClientCode 
					AND fo.FileType = ftpi.FileType
					AND fo.SnapshotFlag= ftpi.SnapshotFlag
					WHERE 1=1
					AND fo.ClientCode = @ClientCode
					AND fo.isActive = 1
					AND fo.Direction ='OUT'
					AND fo.SnapshotFlag = 'CI'
					and fo.Level1ClientID = @Level1Clientid


					INSERT INTO otcfunds.FileTrack( 
					 FileInfoID
					,FileName
					,ClientCode
					,DirectionCode
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,StatusCode
					)
					SELECT FileInfoID
					,FileName
					,@ClientCode
					,'OUT'
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,'999' 
					FROM #FileInfo
					SELECT @FileTrackId= @@IDENTITY

					CREATE TABLE #ClientDetails(
												DetailCount bigint
											   ,TotalCredit decimal(12,2)
											   ,TotalDebit decimal(12,2)
											   ,ClientID varchar(20)
											   --,ProgramID varchar(20)
											   ,SubProgramID varchar(20)
											   ,PackageID varchar(20)
											   ,BatchID varchar(20)
											   )
					INSERT INTO #ClientDetails(
												DetailCount 
											   ,TotalCredit
											   ,TotalDebit 
											   ,ClientID 
											   --,ProgramID
											   ,SubProgramID 
											   ,PackageID 
											   ,BatchID 
											   )


					SELECT  t.DetailCount
						   ,TotalCredit --= tc.TotalCredit
						   ,TotalDebit --= td.TotalDebit
						   ,t.ClientID
						   --,t.ProgramID
						   ,t.SubProgramID
						   ,t.PackageID
						  -- ,t.BatchID
						   ,BatchID=ROW_NUMBER() OVER( ORDER BY  t.PackageID,t.SubProgramID,t.ClientID)
					FROM 
					(
		
							--SELECT DetailCount=COUNT(CardBenefitLoadID)*2 -- one record for 30 and one record for 31
							SELECT DetailCount=COUNT(CardBenefitLoadID) *  ISNULL(@RecordTypeCnt,2)
							,ClientID=ClientID
							--,ProgramID=ProgramID
							,SubProgramID=SubProgramID
							,PackageID=cbl.PackageID
							,TotalDebit = '000000000.00' --CASE WHEN cbl.RecordType NOT IN ('FD','CI') THEN SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) ELSE '000000000.00' END
							,TotalCredit = '000000000.00'--CASE WHEN cbl.RecordType NOT IN ('DF','CI') THEN SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) ELSE '000000000.00' END
							FROM #Temp_CardBenefitLoad cbl
							WHERE 1=1 
							AND cbl.RequestToBeProcessed = 'Y'
							GROUP BY cbl.PackageID,cbl.ClientID,cbl.SubProgramID
							--,cbl.ProgramID
							,cbl.RecordType
					) t

      --Debug  select * from  #ClientDetails

					SELECT Rn = ROW_NUMBER() OVER(ORDER BY client.PackageID,client.SubProgramID
					--,client.ProgramID
					,c.orderRecordType,c.RecordType) 
					,c.RecordType
					,client.DetailCount 
					,client.TotalCredit 
					,client.TotalDebit 
					,client.ClientID 
					--,client.ProgramID 
					,client.SubProgramID 
					,client.PackageID 						  
					,client.BatchID
					,c.orderRecordType
					INTO #Loop 
					FROM (
							SELECT DISTINCT fis.RecordType , convert(int,substring(convert(varchar,fis.RecordType )	,1,2) ) orderRecordType
							FROM flex.FISFieldStartEndPositions fis
							WHERE 1=1 
							 --AND ( fis.RecordType IN (20,80)  OR ( fis.RecordType like '3%' and CHARINDEX(CONVERT(varchar,fis.RecordType),@RecordTypes) > 0   )  )
							 AND ( fis.RecordType IN (20,80)  OR ( CONVERT(varchar,fis.RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )  )
							 ) c									
									     
							--WHERE 1=( 
							--		CASE WHEN @OTCRecordType='CI' AND fis.RecordType NOT IN (10,90,60,99) THEN 1
							--		     WHEN @OTCRecordType<>'CI' AND fis.RecordType NOT IN (10,90,30,31,99) THEN 1
							--		END
							--		)
							--	 ) c  
					CROSS APPLY(
					SELECT   DetailCount 
							,TotalCredit 
							,TotalDebit 
							,ClientID 
							--,ProgramID 
							,SubProgramID 
							,PackageID 						  
							,BatchID  FROM #ClientDetails
					) client
					ORDER BY client.BatchID, c.orderRecordType, c.RecordType

  --Debug select * from  #LOOP
   
					/*Executing RecordType=10*/
					SELECT @Query =''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(10)
					SET @Identity= @FileTrackId

					SET @parmdef = '@FileTrackId varchar(10)
									,@Direction varchar(3)
									,@FilHeaderID bigint out'
					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					SELECT @Query = replace(@Query,'   718967',('   '+ CAST(@Level1Clientid AS VARCHAR(10)))  ) 
					
					--print @Query

					EXEC sp_executesql  @Query
									   ,@parmdef				   
									   ,@Identity
									   ,@Direction
									   ,@Identity OUT
					SELECT @FileHeaderID=@Identity
					--print @Query


					--/*10 Record Completed */

					/*90 Record Type Started */

					SELECT @TotalRecords=COUNT(1)+2
					FROM #Loop WHERE RecordType  IN (20,80) -- NOT IN (30,31,33,3601)

					SELECT @DetailCount = SUM(DetailCount)
					,@BatchCount=COUNT(BatchID)
					,@TotalCredit=SUM(TotalCredit)
					,@TotalDebit=SUM(TotalDebit)
					FROM #ClientDetails

					SET @parmdef = '@TotalRecords int,@BatchCount int
							,@DetailCount bigint
							,@TotalCredit decimal(12,2)
							,@TotalDebit decimal(12,2)
							,@FileTrackId varchar(10)
							,@Direction varchar(3)
							,@FileTrailerID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(90)
					SELECT @Query = @Query+'SELECT @FileTrailerID= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@TotalRecords
									  ,@BatchCount
									  ,@DetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@FileTrackId
									  ,@Direction
									  ,@FileTrailerID OUT
					/*90 Record Type End */


					/*Record Type 20,30,60,80 Started */

					DECLARE @MinCounter int
						   ,@MaxCounter int
					SELECT @MinCounter = MIN(Rn) 
						  ,@MaxCounter = MAX(Rn)
					FROM #Loop

 
					WHILE(@MinCounter<=@MaxCounter)
					BEGIN

					SELECT TOP 1  @BatchSequence=  BatchID 
								 ,@ClientID = ClientID
								 ,@SubprogramID = SubprogramID
								 ,@PackageID = PackageID
								 ,@RecordType = RecordType
								 ,@BatchDetailCount = DetailCount
								 --,@VendorWalletCode = FIS_PurseSlot
								 ,@TotalCredit = TotalCredit
								 ,@TotalDebit = TotalDebit	
								FROM #Loop 
								WHERE Rn= @MinCounter
								ORDER BY BatchID,RecordType
			
					/*20 Variables */
					IF (@RecordType=20)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@ClientID varchar(20)
							,@SubprogramID varchar(20)
							,@PackageID varchar(20)
							,@Direction varchar(3)
							,@FilHeaderID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(20)


					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@FileHeaderID
									  ,@BatchSequence
									  ,@ClientID
									  ,@SubprogramID
									  ,@PackageID
									  ,@Direction
									  ,@Identity OUT
					END



					--IF (@RecordType IN (30,31,33,3601))
				
					IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					BEGIN
					SET @parmdef = '@Identity varchar(10)
									,@Direction varchar(3)'
				
					SELECT @Query = ''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(@RecordType)

                  --Debug print @RecordType

					SELECT @Query = @Query+' FROM #Temp_CardBenefitLoad WHERE 1=1'
					+' AND #Temp_CardBenefitLoad.RequestToBeProcessed = ''Y'''
					+' AND #Temp_CardBenefitLoad.ClientID = '+''''+@ClientID +''''
					+' AND #Temp_CardBenefitLoad.SubProgramID = '+''''+@SubprogramID  +''''
					+' AND #Temp_CardBenefitLoad.PackageID = '+''''+@PackageID +''''




				--	IF(@RecordType IN (30,31,33,3601))
				    IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					
				--	print @RecordType
				--	print @Identity
				--	print @Direction 
				--	print @Query
					--print substr(@Query, 300, len(@Query))
					
					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@Direction 



					END
					IF (@RecordType=80)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@BatchDetailCount varchar(20)
							,@TotalCredit varchar(20)
							,@TotalDebit varchar(20)
							,@Direction varchar(3)'
		
					SELECT @Query=''

					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(80)


					SELECT @Identity= @FileTrailerID

					SELECT @Query = @Query+'SELECT @Identity= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@BatchSequence
									  ,@BatchDetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@Direction
					END

					SELECT @MinCounter = @MinCounter+1

					END
					
					END
					/*Step 4 End */

					IF(@FileTrackId>0)
					BEGIN
					SELECT FileName
						  ,FromLocation
						  ,ToLocation
						  ,WinSCPLoginName
						  ,FileTrackId=@FileTrackId
						  ,IsPGP
						  ,PGPFileExtension
						  ,PGPKeyName 
						  ,isFileToFTP
						  FROM #FileInfo 
					END
					ELSE 
					BEGIN
					SELECT FileName=''
						  ,FromLocation=''
						  ,ToLocation=''
						  ,WinSCPLoginName=''
						  ,FileTrackId=0
						  ,IsPGP=''
						  ,PGPFileExtension=''
						  ,PGPKeyName =''
						  ,isFileToFTP=''
					END
         
         DROP TABLE IF EXISTS #Temp_CardBenefitLoad

		COMMIT TRANSACTION FISCardIssueCreateFile
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISCardIssueCreateFile
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        DECLARE @ErrorLine  INT;

        SELECT 		
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine =ERROR_LINE(); 
		
        set @ErrorMessage = @ErrorMessage + '--Error Line' + cast(@ErrorLine as NVARCHAR(5) )
		
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

END

GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_CardIssue_CreateFile_bkp]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [flex].[sp_ssis_FIS_CardIssue_CreateFile_bkp] (@ClientCode VARCHAR(20), @Level1Clientid bigint)
AS

-- exec flex.sp_ssis_FIS_FileCardIssue 'H482'

BEGIN
SET NOCOUNT ON 

BEGIN TRY

		BEGIN TRANSACTION FISCardIssueCreateFile


			
			      -- Questions -- Check again in eligibilty and update CardBenefitLoadID
				  --    Change the package name
				  
				  declare @FileThresHold   int;
				  declare @RecordTypeCnt   int;
				  declare @RecordTypes     varchar(50);
				  --declare @Level1Clientid  varchar(6);
				  
				  -- Need to discuss if required - SD
				  /*
                  DECLARE file_cursor CURSOR FOR
                  SELECT ISNULL(FileThreshold,0) FileThreshold, RecordTypeCnt, RecordTypes , convert(varchar(6), Level1Clientid) Level1Clientid 
				                                FROM  otcfunds.FileInfo fo WHERE 1=1
																					AND fo.ClientCode = @ClientCode
																					AND fo.isActive = 1
																					AND fo.Direction ='OUT'
																					AND fo.SnapshotFlag = 'CI' ;
																					
                  OPEN file_cursor;
                  FETCH NEXT FROM file_cursor INTO @FileThresHold, @RecordTypeCnt, @RecordTypes, @Level1Clientid;
                 
                  CLOSE file_cursor;
                  DEALLOCATE file_cursor;
				  */
				  
				 SELECT @FileThresHold = ISNULL(FileThreshold,0)
				        ,@RecordTypeCnt = RecordTypeCnt
						,@RecordTypes = RecordTypes
				 FROM  otcfunds.FileInfo fo 
				 WHERE 1=1
				 AND fo.isActive = 1
				 AND fo.Direction ='OUT'
				 AND fo.SnapshotFlag = 'CI' 
				AND fo.Level1ClientID = @Level1Clientid;


					/*Step 1 Start - Load #Temp_CardBenefitLoad*/
					DROP TABLE IF EXISTS #Temp_CardBenefitLoad

					CREATE TABLE #Temp_CardBenefitLoad
					(
						[CardBenefitLoadID] [bigint]  NOT NULL,
						[MemberDataID] [bigint] NOT NULL,
						[ClientCode] [varchar](20) NULL,
						[NHLinkID] [varchar](100) NULL,
						[RecordType] [varchar](50) NULL,
						[MemberDataSource] [varchar](50) NULL,
						[InsCarrierID] [int] NULL,
						[InsHealthPlanID] [int] NULL,
						[BenefitCardNumber] [varchar](30) NULL,
						[LastName] [nvarchar](100) NULL,
						[MiddleInitial] [nvarchar](20) NULL,
						[FirstName] [nvarchar](100) NULL,
						[DOB] [date] NULL,
						[MailingAddress1] [nvarchar](150) NULL,
						[MailingAddress2] [nvarchar](100) NULL,
						[MailingCity] [nvarchar](100) NULL,
						[MailingState] [nvarchar](50) NULL,
						[MailingZipCode] [nvarchar](20) NULL,
						[MailingCountry] [nvarchar](100) NULL,
						[HomePhoneNbr] [nvarchar](20) NULL,
						[BenefitType] [varchar](50) NULL,
						[BenefitSource] [varchar](50) NULL,
						[NBWalletCode] [varchar](50) NULL,
						[BenefitAmount] [decimal](10, 2) NULL,
						[BenefitValidFrom] [date] NULL,
						[BenefitValidTo] [date] NULL,
						[BenefitFreqInMonth] [int] NULL,
						[BenefitYear] [int] NULL,
						[BenefitPeriod] [int] NULL,
						[IsActive] [bit] NULL,
						[RequestRecordStatus] [varchar](50) NULL,
						[RequestToBeProcessed] [varchar](20) NULL,
						[RequestProcessedFileID] [bigint] NULL,
						[RequestProcessedDate] [datetime] NULL,
						[ResponseRecordStatus] [varchar](225) NULL,
						[ResponseRecordStatusCode] [varchar](2) NULL,
						[ResponseProcessedFileID] [bigint] NULL,
						[ResponseProcessedDate] [datetime] NULL,
						[FirstTimeCardIssued] [varchar](1) NULL,
						[CreateDate] [datetime] NULL,
						[CreateUser] [nvarchar](100) NULL,
						[ModifyDate] [datetime] NULL,
						[ModifyUser] [nvarchar](100) NULL,
						[RefCardBenefitLoadID] [bigint] NULL,
						[ErrorProcessed] [smallint] NULL,
						[ClientID] bigint,
						--[ProgramID] bigint,
						[SubProgramID] bigint,
						[PackageID] bigint,
						[FIS_PurseSlot] nvarchar(30),
						[DiscretionaryData1] nvarchar(50),
						[FourthLine] nvarchar(26),
						[CarrierMessage] nvarchar(256),
						[DiscretionaryData2] varchar(50)
						--CONSTRAINT [PK_Temp_CardBenefitLoad_CI] PRIMARY KEY CLUSTERED 
					--(
					--	[CardBenefitLoadID] ASC
					--)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
					--) ON [PRIMARY]
					)

					--SELECT * INTO #Temp_CardBenefitLoad FROM otcfunds.CardBenefitLoad_CI WHERE 1 = 0
					
					SET ROWCOUNT @FileThresHold

					INSERT INTO #Temp_CardBenefitLoad
					(
					CardBenefitLoadID
					,MemberDataID
					,ClientCode
					,NHLinkID
					,RecordType
					,MemberDataSource
					,InsCarrierID
					,InsHealthPlanID
					,BenefitType
					,BenefitSource
					,NBWalletCode
					,BenefitAmount
					,BenefitValidFrom
					,BenefitValidTo
					,BenefitFreqInMonth
					,BenefitYear
					,BenefitPeriod
					,IsActive
					,LastName
					,MiddleInitial
					,FirstName
					,DOB
					,MailingAddress1
					,MailingAddress2
					,MailingCity
					,MailingState
					,MailingZipCode
					,MailingCountry
					,HomePhoneNbr
					,BenefitCardNumber
					,RequestToBeProcessed
					,ClientID
					--,ProgramID
					,SubProgramID
					,PackageID
					,FIS_PurseSlot
					,DiscretionaryData1
					,FourthLine
					,CarrierMessage
					,DiscretionaryData2
					)
					SELECT distinct
					 cbl.CardBenefitLoadID
					,cbl.MemberDataID
					,cbl.ClientCode
					,cbl.NHLinkID
					,cbl.RecordType
					,cbl.MemberDataSource
					,cbl.InsCarrierID
					,cbl.InsHealthPlanID
					,cbl.BenefitType
					,cbl.BenefitSource
					,cbl.NBWalletCode
					,cbl.BenefitAmount
					,cbl.BenefitValidFrom
					,cbl.BenefitValidTo
					,cbl.BenefitFreqInMonth
					,cbl.BenefitYear
					,cbl.BenefitPeriod
					,cbl.IsActive
					,cbl.LastName
					,LEFT (cbl.MiddleInitial,1) MiddleInitial 
					,cbl.FirstName
					,cbl.DOB
					,LEFT(flex.RemoveExtendedASCII(cbl.MailingAddress1),50) MailingAddress1   
					,flex.RemoveExtendedASCII(cbl.MailingAddress2) MailingAddress2
					,flex.RemoveExtendedASCII(cbl.MailingCity) MailingCity
					,cbl.MailingState
					,CASE WHEN  LEN(cbl.MailingZipCode) < 5 THEN RIGHT('00000'+ISNULL(cbl.MailingZipCode,''),5) ELSE cbl.MailingZipCode END MailingZipCode
					,cbl.MailingCountry
					,ISNULL(CASE   WHEN  TRY_CAST(HomePhoneNbr AS BIGINT) IS NULL THEN '1'
								   WHEN ISNUMERIC(HomePhoneNbr) = 1 AND CAST(HomePhoneNbr AS BIGINT) = 0 THEN '1' 
										 ELSE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IIF(HomePhoneNbr IN (''),'1',HomePhoneNbr),')',''),'(',''),',',''),'-',''),' ','')  
										 END,1) HomePhoneNbr
					,cbl.BenefitCardNumber
					,cbl.RequestToBeProcessed
					,cbl.ClientID
					--,cbl.ProgramID
					,cbl.SubProgramID
					,cbl.PackageID
					,FIS_PurseSlot = ''
					,ISNULL(DiscretionaryData1,'') DiscretionaryData1 -- NOV2022
					,ISNULL(FourthLine,'') FourthLine
					,ISNULL(CarrierMessage,'') CarrierMessage
					,ISNULL(DiscretionaryData2,'') DiscretionaryData2
					FROM otcfunds.CardBenefitLoad_CI cbl					
				    WHERE 1=1
					AND cbl.IsActive = 1
					AND cbl.Level1ClientID = @Level1Clientid
					AND cbl.RequestToBeProcessed = 'Y'
					AND (ISNULL(cbl.ClientID,'') != '' OR ISNULL(cbl.SubProgramID,'') != '' OR ISNULL(cbl.PackageID,'') != '')
					order by cbl.PackageID,cbl.SubProgramID,cbl.ClientID

					/*Step 1 End */
                    SET ROWCOUNT 0


					/*Step 3 Start  - Pre process */
					DECLARE @MaxLenSQL VARCHAR(MAX)
					,@UpdateSQL VARCHAR(MAX)
					,@TableName VARCHAR(200)

					/*Max Length Check */

					DROP TABLE IF EXISTS #tempMaxLength

					CREATE TABLE #tempMaxLength(ColumnName varchar(200),MaxLength int,ColumnAllowedLen int)
					SELECT @TableName = '#Temp_CardBenefitLoad'
					SELECT @MaxLenSQL = ''
					SELECT @MaxLenSQL =  @MaxLenSQL + 'SELECT ColumnName = ' + QUOTENAME(sc.OTCColumnName, '''')  
									   + ', MaxLength = MAX(LEN(' + QUOTENAME(sc.OTCColumnName) + '))'
									   + ', ColumnAllowedLen = '+CAST(((sc.EndPosition+1)-sc.StartPosition) as varchar(10))
									   + ' FROM '
									   + @TableName
									   + ' WHERE RequestToBeProcessed = ''Y'''				   
									   + CHAR(10) +' UNION '
					FROM flex.FISFieldStartEndPositions sc
					WHERE RecordType = 30
					AND OTCColumnName IS NOT NULL

					SELECT @MaxLenSQL = LEFT(@MaxLenSQL, LEN(@MaxLenSQL)-6)
					SELECT @MaxLenSQL = 'INSERT INTO #tempMaxLength '+CHAR(10) + @MaxLenSQL
					PRINT @MaxLenSQL
					EXEC (@MaxLenSQL)


					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL =  @UpdateSQL + ' UPDATE '+@TableName
													+ ' SET  RequestToBeProcessed = ''ERR_SIZE'''
													+ ' WHERE LEN('+ColumnName +') >'+ CAST(ColumnAllowedLen as varchar(10))
													+ ' AND RequestToBeProcessed = ''Y'''
													FROM #tempMaxLength
													WHERE MaxLength>ColumnAllowedLen
					EXEC(@UpdateSQL)



					/* Nullable check for Mandatory Columns*/

					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL = ' UPDATE '+@TableName
										+ CHAR(10)
										+ 'SET RequestToBeProcessed = ''ERR_MAN_COL'''
										+ CHAR(10)
										+ 'WHERE ('
										+ CHAR(10)
										+ STUFF((SELECT ' +' +'CAST(['+sc.OTCColumnName +'] AS varchar(400))'
													   FROM(SELECT U.OTCColumnName
													   FROM  flex.FISFieldStartEndPositions U
													   WHERE RecordType = 30
													   AND [Required] ='Yes'
													   AND OTCColumnName IS NOT NULL
													   ) sc
													   FOR
													   XML PATH('')
													   ), 1, 2, '')
										 + CHAR(10)
										 +') IS NULL'
					PRINT @UpdateSQL
					EXEC(@UpdateSQL)

					/* Replace Special Charcters */
				IF CHARINDEX('33',@RecordTypes)  > 0  --NOV2022
					BEGIN 
			        UPDATE  #Temp_CardBenefitLoad
					SET  FirstName = flex.[Fn_Replace_Special_Character](FirstName)
					   , LastName = flex.[Fn_Replace_Special_Character](LastName)
					   , MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
					   , MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
					WHERE RequestToBeProcessed = 'Y' 
					AND (FirstName LIKE '%[^0-9a-zA-Z]%' 
						OR  LastName LIKE '%[^0-9a-zA-Z]%' 
						OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
						OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
						)					
					
					END 
				ELSE 
					BEGIN
					UPDATE  #Temp_CardBenefitLoad
					SET  FirstName = flex.[Fn_Replace_Special_Character](FirstName)
					   , LastName = flex.[Fn_Replace_Special_Character](LastName)
					   --, MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
					   --, MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
					WHERE RequestToBeProcessed = 'Y' 
					AND (FirstName LIKE '%[^0-9a-zA-Z]%' 
						OR  LastName LIKE '%[^0-9a-zA-Z]%' 
						--OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
						--OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
						)
					END	
						
					/* Updating otc funds table for Error Records*/ 

					UPDATE otc
					SET otc.RequestToBeProcessed = tcb.RequestToBeProcessed
					,otc.RequestRecordStatus = CASE WHEN tcb.RequestToBeProcessed ='ERR_SIZE' THEN   'Column length exceeded more than FIS'
													WHEN tcb.RequestToBeProcessed ='ERR_MAN_COL' THEN   'FIS Mandatory columns does not allow NULL values' 
											   END
					FROM otcfunds.CardBenefitLoad_CI otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed  IN('ERR_SIZE','ERR_MAN_COL')



					/*Step 3 END */
					
					/* Updating otc funds table success  Records*/ 

					UPDATE otc
					SET otc.FileGenInd = 'Y'					
					FROM otcfunds.CardBenefitLoad_CI otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE otc.RequestToBeProcessed  = 'Y'



					/*Step 3A END */



					/*Step 4 Start Insert FIS Batch file records */

					DROP TABLE IF EXISTS #ClientDetails
					DROP TABLE IF EXISTS #Loop
					DROP TABLE IF EXISTS #FileInfo
					--DROP TABLE IF EXISTS #TempBatch



					DECLARE @Query nvarchar(max)

					,@Identity bigint
					--RecordType = 90

					,@TotalRecords int
					,@BatchCount int
					,@DetailCount int
					,@BatchDetailCount int
					,@TotalCredit decimal (12,2)
					,@TotalDebit decimal (12,2)
					,@FileTrailerID bigint

					,@BatchSequence int
					,@ClientID varchar(20)
					,@SubprogramID varchar(20)
					,@PackageID varchar(20)
					,@RecordType int

					,@Parmdef nvarchar (max)
					,@FileHeaderID bigint
					,@Direction varchar(3)='OUT'
					,@FileTrackId bigint
					,@VendorWalletCode varchar(2)

					--SELECT * FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'

					--SELECT COUNT(1) FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'


					IF EXISTS (SELECT TOP 1 1 FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y')
					BEGIN

					SELECT  fo.FileInfoID as FileInfoID,	
						fo.SnapshotFlag + FORMAT(CAST(GETDATE()AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime),'HHmmssMMddyyyy')+'01'+'.'+ fo.FileExtension AS FileName,
						fo.FromLocation AS FromLocation,
						fo.ToLocation AS ToLocation,
						fo.Direction AS Direction,
						fo.FileFormat AS FileFormat,
						fo.SnapshotFlag AS SnapshotFlag,
						fo.DataSource AS DataSource,
						fo.FileExtension AS FileExtension,
						fo.FileType AS FileType,
						ftpi.WinSCPLoginName AS WinSCPLoginName,
						ISNULL(fo.IsPGP,'') AS IsPGP,
						ISNULL(fo.PGPFileExtension,'') AS PGPFileExtension,
						ISNULL(fo.PGPKeyName,'') AS PGPKeyName,
						ISNULL(fo.isAckFileToFTP,'') AS isFileToFTP
						INTO #FileInfo
					FROM otcfunds.FileInfo fo
					JOIN otcfunds.FTPUserInfo ftpi 
					ON fo.ClientCode = ftpi.ClientCode 
					AND fo.FileType = ftpi.FileType
					AND fo.SnapshotFlag= ftpi.SnapshotFlag
					WHERE 1=1
					AND fo.isActive = 1
					AND fo.Direction ='OUT'
					AND fo.SnapshotFlag = 'CI'
					and fo.Level1ClientID = @Level1Clientid


					INSERT INTO otcfunds.FileTrack( 
					 FileInfoID
					,FileName
					,ClientCode
					,DirectionCode
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,StatusCode
					)
					SELECT FileInfoID
					,FileName
					,@ClientCode
					,'OUT'
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,'999' 
					FROM #FileInfo
					SELECT @FileTrackId= @@IDENTITY


					CREATE TABLE #ClientDetails(
												DetailCount bigint
											   ,TotalCredit decimal(12,2)
											   ,TotalDebit decimal(12,2)
											   ,ClientID varchar(20)
											   --,ProgramID varchar(20)
											   ,SubProgramID varchar(20)
											   ,PackageID varchar(20)
											   ,BatchID varchar(20)
											   )
					INSERT INTO #ClientDetails(
												DetailCount 
											   ,TotalCredit
											   ,TotalDebit 
											   ,ClientID 
											   --,ProgramID
											   ,SubProgramID 
											   ,PackageID 
											   ,BatchID 
											   )


					SELECT  t.DetailCount
						   ,TotalCredit --= tc.TotalCredit
						   ,TotalDebit --= td.TotalDebit
						   ,t.ClientID
						   --,t.ProgramID
						   ,t.SubProgramID
						   ,t.PackageID
						  -- ,t.BatchID
						   ,BatchID=ROW_NUMBER() OVER( ORDER BY  t.PackageID,t.SubProgramID,t.ClientID)
					FROM 
					(
		
							--SELECT DetailCount=COUNT(CardBenefitLoadID)*2 -- one record for 30 and one record for 31
							SELECT DetailCount=COUNT(CardBenefitLoadID) *  ISNULL(@RecordTypeCnt,2)
							,ClientID=ClientID
							--,ProgramID=ProgramID
							,SubProgramID=SubProgramID
							,PackageID=cbl.PackageID
							,TotalDebit = '000000000.00' --CASE WHEN cbl.RecordType NOT IN ('FD','CI') THEN SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) ELSE '000000000.00' END
							,TotalCredit = '000000000.00'--CASE WHEN cbl.RecordType NOT IN ('DF','CI') THEN SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) ELSE '000000000.00' END
							FROM #Temp_CardBenefitLoad cbl
							WHERE 1=1 
							AND cbl.RequestToBeProcessed = 'Y'
							GROUP BY cbl.PackageID,cbl.ClientID,cbl.SubProgramID
							--,cbl.ProgramID
							,cbl.RecordType
					) t

      --Debug  select * from  #ClientDetails

					SELECT Rn = ROW_NUMBER() OVER(ORDER BY client.PackageID,client.SubProgramID
					--,client.ProgramID
					,c.orderRecordType,c.RecordType) 
					,c.RecordType
					,client.DetailCount 
					,client.TotalCredit 
					,client.TotalDebit 
					,client.ClientID 
					--,client.ProgramID 
					,client.SubProgramID 
					,client.PackageID 						  
					,client.BatchID
					,c.orderRecordType
					INTO #Loop 
					FROM (
							SELECT DISTINCT fis.RecordType , convert(int,substring(convert(varchar,fis.RecordType )	,1,2) ) orderRecordType
							FROM flex.FISFieldStartEndPositions fis
							WHERE 1=1 
							 --AND ( fis.RecordType IN (20,80)  OR ( fis.RecordType like '3%' and CHARINDEX(CONVERT(varchar,fis.RecordType),@RecordTypes) > 0   )  )
							 AND ( fis.RecordType IN (20,80)  OR ( CONVERT(varchar,fis.RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )  )
							 ) c									
									     
							--WHERE 1=( 
							--		CASE WHEN @OTCRecordType='CI' AND fis.RecordType NOT IN (10,90,60,99) THEN 1
							--		     WHEN @OTCRecordType<>'CI' AND fis.RecordType NOT IN (10,90,30,31,99) THEN 1
							--		END
							--		)
							--	 ) c  
					CROSS APPLY(
					SELECT   DetailCount 
							,TotalCredit 
							,TotalDebit 
							,ClientID 
							--,ProgramID 
							,SubProgramID 
							,PackageID 						  
							,BatchID  FROM #ClientDetails
					) client
					ORDER BY client.BatchID, c.orderRecordType, c.RecordType

  --Debug select * from  #LOOP
   
					/*Executing RecordType=10*/
					SELECT @Query =''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(10)
					SET @Identity= @FileTrackId

					SET @parmdef = '@FileTrackId varchar(10)
									,@Direction varchar(3)
									,@FilHeaderID bigint out'
					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					SELECT @Query = replace(@Query,'   718967',('   '+ CAST(@Level1Clientid AS VARCHAR(10)))  ) 
					
					--print @Query

					EXEC sp_executesql  @Query
									   ,@parmdef				   
									   ,@Identity
									   ,@Direction
									   ,@Identity OUT
					SELECT @FileHeaderID=@Identity
					--print @Query


					--/*10 Record Completed */

					/*90 Record Type Started */

					SELECT @TotalRecords=COUNT(1)+2
					FROM #Loop WHERE RecordType  IN (20,80) -- NOT IN (30,31,33,3601)

					SELECT @DetailCount = SUM(DetailCount)
					,@BatchCount=COUNT(BatchID)
					,@TotalCredit=SUM(TotalCredit)
					,@TotalDebit=SUM(TotalDebit)
					FROM #ClientDetails

					SET @parmdef = '@TotalRecords int,@BatchCount int
							,@DetailCount bigint
							,@TotalCredit decimal(12,2)
							,@TotalDebit decimal(12,2)
							,@FileTrackId varchar(10)
							,@Direction varchar(3)
							,@FileTrailerID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(90)
					SELECT @Query = @Query+'SELECT @FileTrailerID= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@TotalRecords
									  ,@BatchCount
									  ,@DetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@FileTrackId
									  ,@Direction
									  ,@FileTrailerID OUT
					/*90 Record Type End */


					/*Record Type 20,30,60,80 Started */

					DECLARE @MinCounter int
						   ,@MaxCounter int
					SELECT @MinCounter = MIN(Rn) 
						  ,@MaxCounter = MAX(Rn)
					FROM #Loop

 
					WHILE(@MinCounter<=@MaxCounter)
					BEGIN

					SELECT TOP 1  @BatchSequence=  BatchID 
								 ,@ClientID = ClientID
								 ,@SubprogramID = SubprogramID
								 ,@PackageID = PackageID
								 ,@RecordType = RecordType
								 ,@BatchDetailCount = DetailCount
								 --,@VendorWalletCode = FIS_PurseSlot
								 ,@TotalCredit = TotalCredit
								 ,@TotalDebit = TotalDebit	
								FROM #Loop 
								WHERE Rn= @MinCounter
								ORDER BY BatchID,RecordType
			
					/*20 Variables */
					IF (@RecordType=20)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@ClientID varchar(20)
							,@SubprogramID varchar(20)
							,@PackageID varchar(20)
							,@Direction varchar(3)
							,@FilHeaderID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(20)


					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@FileHeaderID
									  ,@BatchSequence
									  ,@ClientID
									  ,@SubprogramID
									  ,@PackageID
									  ,@Direction
									  ,@Identity OUT
					END



					--IF (@RecordType IN (30,31,33,3601))
				
					IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					BEGIN
					SET @parmdef = '@Identity varchar(10)
									,@Direction varchar(3)'
				
					SELECT @Query = ''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(@RecordType)

                  --Debug print @RecordType

					SELECT @Query = @Query+' FROM #Temp_CardBenefitLoad WHERE 1=1'
					+' AND #Temp_CardBenefitLoad.RequestToBeProcessed = ''Y'''
					+' AND #Temp_CardBenefitLoad.ClientID = '+''''+@ClientID +''''
					+' AND #Temp_CardBenefitLoad.SubProgramID = '+''''+@SubprogramID  +''''
					+' AND #Temp_CardBenefitLoad.PackageID = '+''''+@PackageID +''''




				--	IF(@RecordType IN (30,31,33,3601))
				    IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					
				--	print @RecordType
				--	print @Identity
				--	print @Direction 
				--	print @Query
					--print substr(@Query, 300, len(@Query))
					
					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@Direction 



					END
					IF (@RecordType=80)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@BatchDetailCount varchar(20)
							,@TotalCredit varchar(20)
							,@TotalDebit varchar(20)
							,@Direction varchar(3)'
		
					SELECT @Query=''

					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(80)


					SELECT @Identity= @FileTrailerID

					SELECT @Query = @Query+'SELECT @Identity= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@BatchSequence
									  ,@BatchDetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@Direction
					END

					SELECT @MinCounter = @MinCounter+1

					END
					
					END
					/*Step 4 End */

					IF(@FileTrackId>0)
					BEGIN
					SELECT FileName
						  ,FromLocation
						  ,ToLocation
						  ,WinSCPLoginName
						  ,FileTrackId=@FileTrackId
						  ,IsPGP
						  ,PGPFileExtension
						  ,PGPKeyName 
						  ,isFileToFTP
						  FROM #FileInfo 
					END
					ELSE 
					BEGIN
					SELECT FileName=''
						  ,FromLocation=''
						  ,ToLocation=''
						  ,WinSCPLoginName=''
						  ,FileTrackId=0
						  ,IsPGP=''
						  ,PGPFileExtension=''
						  ,PGPKeyName =''
						  ,isFileToFTP=''
					END

		COMMIT TRANSACTION FISCardIssueCreateFile
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISCardIssueCreateFile
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
        DECLARE @ErrorLine  INT;

        SELECT 		
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine =ERROR_LINE(); 
		
        set @ErrorMessage = @ErrorMessage + '--Error Line' + cast(@ErrorLine as NVARCHAR(5) )
		
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_CardIssue_Test]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [flex].[sp_ssis_FIS_CardIssue_Test] (@ClientCode VARCHAR(20), @Level1Clientid bigint)
AS

-- exec flex.sp_ssis_FIS_CardIssue 'H482'

BEGIN
SET NOCOUNT ON 

BEGIN TRY

		BEGIN TRANSACTION FISCardIssueTest

					declare @LoadThresHold   int;

					--print '01/02/2023';

					--set @EligibleAsOfDate = '01/02/2023';

					--set @EligibleAsOfDate = '12/22/2022'; -- Just for San Mateo & AvMed (no need since everything is open ended)
					
					set @LoadThresHold  = ( SELECT ISNULL(LoadThreshold,0) FROM  otcfunds.FileInfo fo WHERE 1=1
																					AND fo.Direction ='OUT'
																					AND fo.SnapshotFlag = 'CI'
																					AND Level1ClientID = @Level1Clientid)



                    DROP TABLE IF EXISTS #OTCFUNDSCI
					drop table if EXISTS #OTCFUNDSCI_CM
					--drop table if EXISTS #dup_nh
					
					

						/*Step 1 Start */

								SELECT DISTINCT 
									   Mstr.BenefitCardRequestID MemberDataID
									  ,Mstr.[NHLinkid]
									  ,'CI' RecordType
									  ,'elig'[DataSource]
									  ,Mstr.InsCarrierID  [InsCarrierID]
									  ,Mstr.InsHealthPlanID  [InsHealthPlanID]
									  ,'OTC' BenefitType
									  ,'Test' [BenefitSource]
									  ,1 [isActive]
									  ,'Y' [RequestToBeProcessed]
									  ,Mstr.[LastName]
									  --,Mstr.[MiddleInitial]
									  ,CASE WHEN Mstr.MiddleInitial IN ('-','.','0') THEN '' ELSE Mstr.MiddleInitial END MiddleInitial -- Symbols and numerics in Middle Initial									  
									  ,Mstr.[FirstName]
									  ,Mstr.[DOB]
									  ,Mstr.[MailingAddress1] [MailingAddress1]
									  ,Mstr.[MailingAddress2] [MailingAddress2] 
									  ,Mstr.[MailingCity]	   [MailingCity]
									  ,Mstr.[MailingState]     [MailingState]
									  ,Mstr.[MailingZipCode]  [MailingZipCode]
									  ,'840' [MailingCountryCode]
									  ,'' [HomePhoneNbr]
									  ,NULL [BenefitCardNumber]
									  ,'Test' ClientCode
									  --,REPLACE(ISNULL(Mstr.Language,''),',','') [Language]
								INTO #OTCFUNDSCI
								FROM [BenefitCardRequest].[CardIssue] Mstr WITH (NOLOCK)  			
								WHERE  1=1
								AND Mstr.RequestToBeProcessed = 'Y'
								AND NOT EXISTS ( 
								                 SELECT NHLinkID 
												 FROM  [otcfunds].[CardBenefitLoad_CI] CL 
												 where CL.NHLinkID=MSTR.NHLinkid 
												 and CL.RecordType='CI' 
												 and CL.ClientCode=@ClientCode 
											     and CL.Level1Clientid = @Level1Clientid 
												 AND (   
												               (CL.RequestRecordStatus = 'SUCCESS' AND CL.ResponseRecordStatus IS NULL) -- IF card request sent but waiting for response 
															or (CL.RequestRecordStatus = 'SUCCESS' AND CL.ResponseRecordStatus = 'SUCCESS') -- IF card is already issued to member do not issue again though it is a new record 
															or (CL.RequestRecordStatus IS NULL AND CL.RequestToBeProcessed = 'Y') -- card request to be processed set as Y but request not yet sent to FIS
												 
												     )    
											   ) 

								
								---- Check for duplicate members
								--select 	NHLinkID, count(*) cnt 
								--into #dup_nh 
								--from 	#OTCFUNDSCI	 
								--group by NHLinkID
        --                        having count(*) > 1	


					--select * from #OTCFUNDSCI

					  
					
					  CREATE TABLE #OTCFUNDSCI_CM(	
									[MemberDataID] [bigint] NOT NULL,
									[ClientCode] [varchar](20) NULL,
									[NHLinkID] [varchar](100) NOT NULL,
									[RecordType] [varchar](50) NULL,
									[DataSource] [varchar](50) NULL,
									[InsCarrierID] [int] NULL,
									[InsHealthPlanID] [int] NULL,
									[BenefitType] [varchar](20) NULL,
									[BenefitSource] [varchar](20) NULL,
									[IsActive] [bit] NULL,
									[RequestToBeProcessed] [varchar](20) NULL,
									[LastName] [nvarchar](100) NULL,
									[MiddleInitial] [nvarchar](20) NULL,
									[FirstName] [nvarchar](100) NULL,
									[DOB] [date] NULL,
									[MailingAddress1] [nvarchar](150) NULL,
									[MailingAddress2] [nvarchar](100) NULL,
									[MailingCity] [nvarchar](100) NULL,
									[MailingState] [nvarchar](50) NULL,
									[MailingZipCode] [nvarchar](20) NULL,
									[MailingCountryCode] [varchar](20) NULL,
									[HomePhoneNbr] [nvarchar](20) NULL,
									[BenefitCardNumber] [varchar](30) NULL,
									[ClientID] [bigint] NULL,
									[SubProgramID] [bigint] NULL,
									[PackageID] [bigint] NULL,
									[CarrierMessage] [varchar](256) NULL,
									[Level1ClientId] [bigint] NULL,
								)
									
								create  nonclustered index IX_TMP_OTCFUNDSCI_CM
								on #OTCFUNDSCI_CM (NHLinkID);
								
								SET ROWCOUNT @LoadThresHold

					
					            INSERT INTO #OTCFUNDSCI_CM	
								SELECT distinct A.MemberDataID
							  ,A.[ClientCode]
							   ,A.[NHLinkID]
							   ,A.[RecordType]
							   ,A.[DataSource]
							   ,A.[InsCarrierID]
							   ,A.[InsHealthPlanID]
							   ,A.[BenefitType]
							   ,A.[BenefitSource]
							   ,A.[IsActive]
							   ,A.[RequestToBeProcessed]
							   ,A.[LastName]
							   ,A.[MiddleInitial]
							   ,A.[FirstName]
							   ,A.[DOB]
							   ,A.[MailingAddress1]
							   ,A.[MailingAddress2]
							   ,A.[MailingCity]
							   ,A.[MailingState]
							   ,A.[MailingZipCode]
							   ,A.[MailingCountryCode]
							   ,A.[HomePhoneNbr]
							   ,A.[BenefitCardNumber]							  
							   ,CI.[ClientID]
							   --,CI.[ProgramID]
							   ,CI.[SubProgramID]
							   ,CI.[PackageID]								  
							   ,'' [CarrierMessage]							   
							   ,@Level1Clientid Level1Clientid						   
						FROM #OTCFUNDSCI A 
						JOIN (
								SELECT DISTINCT	ClientID,SubProgramID,PackageID,LanguageIndicator,LanguageLOV,CarrierID,HealthPlanID
								FROM flex.FISWalletMapping	
								WHERE ISNULL(isactive,0)=1
								AND Level1Clientid = @Level1Clientid
								AND isnull(FIS_Status,'') = 'A'
					            AND CAST(GETDATE() as DATE) BETWEEN PurseStartDate and PurseEndDate
						     ) CI ON CI.CarrierID = A.InsCarrierID AND CI.HealthPlanID = A.InsHealthPlanID 													   			
                        WHERE 1=1		
                        --AND A.[NHLinkID] not IN ( SELECT NHLinkID 	from  #dup_nh )
						
						
				      		SET ROWCOUNT 0
					

					INSERT INTO [otcfunds].[CardBenefitLoad_CI]
							   ([MemberDataID]
							   ,[ClientCode]
							   ,[NHLinkID]
							   ,[RecordType]
							   ,[MemberDataSource]
							   ,[InsCarrierID]
							   ,[InsHealthPlanID]
							   ,[BenefitType]
							   ,[BenefitSource]
							   ,[IsActive]
							   ,[RequestToBeProcessed]
							   ,[LastName]
							   ,[MiddleInitial]
							   ,[FirstName]
							   ,[DOB]
							   ,[MailingAddress1]
							   ,[MailingAddress2]
							   ,[MailingCity]
							   ,[MailingState]
							   ,[MailingZipCode]
							   ,[MailingCountry]
							   ,[HomePhoneNbr]
							   ,[BenefitCardNumber]						  
							   ,[ClientID]
							   --,[ProgramID]
							   ,[SubProgramID]
							   ,[PackageID]
							   ,[CarrierMessage]
							   ,[Level1ClientId]
							   )
					 SELECT distinct A.MemberDataID
							  ,A.[ClientCode]
							   ,A.[NHLinkID]
							   ,A.[RecordType]
							   ,A.[DataSource]
							   ,A.[InsCarrierID]
							   ,A.[InsHealthPlanID]
							   ,A.[BenefitType]
							   ,A.[BenefitSource]
							   ,A.[IsActive]
							   ,A.[RequestToBeProcessed]
							   ,A.[LastName]
							   ,A.[MiddleInitial]
							   ,A.[FirstName]
							   ,A.[DOB]
							   ,A.[MailingAddress1]
							   ,A.[MailingAddress2]
							   ,A.[MailingCity]
							   ,A.[MailingState]
							   ,A.[MailingZipCode]
							   ,A.[MailingCountryCode]
							   ,A.[HomePhoneNbr]
							   ,A.[BenefitCardNumber]							  
							   ,A.[ClientID]
							   --,A.[ProgramID]
							   ,A.[SubProgramID]
							   ,A.[PackageID]	
							   ,A.[CarrierMessage]
							   ,@Level1Clientid
						FROM #OTCFUNDSCI_CM A 							
						WHERE 1=1
							
						 update a
						 set RequestToBeProcessed = 'P'
						 -- select *
						 from BenefitCardRequest.CardIssue a
						 where 1=1
						 and exists (
										select 1
										from otcfunds.CardBenefitLoad_CI c
										where 1=1
										and c.MemberDataID = a.BenefitCardRequestID
										and c.NHLinkID = a.NHLinkID
										and c.Level1ClientID = @Level1Clientid
						 )

					DROP TABLE IF EXISTS #OTCFUNDSCI
					drop table if EXISTS #OTCFUNDSCI_CM
					--drop table if EXISTS #dup_nh
					


		COMMIT TRANSACTION FISCardIssueTest
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISCardIssueTest
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(); 
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH

END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_FundDisbursement_CreateFile]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [flex].[sp_ssis_FIS_FundDisbursement_CreateFile] (@ClientCode VARCHAR(20), @Level1Clientid bigint)
AS

-- exec flex.sp_ssis_FIS_FundDisbursement_CreateFile 'H638' , 995407

BEGIN
SET NOCOUNT ON 

BEGIN TRY

		BEGIN TRANSACTION FISFundDisbursementCreateFile
			
			      -- Questions -- Check again in eligibilty and update CardBenefitLoadID
				  --    Change the package name
				  
				  declare @FileThresHold   int;
				  declare @RecordTypeCnt   int;
				  declare @RecordTypes     varchar(50);
				  
				  
				  SELECT @FileThresHold = ISNULL(FileThreshold,0)
				        ,@RecordTypeCnt = RecordTypeCnt
						,@RecordTypes = RecordTypes
				 FROM  otcfunds.FileInfo fo 
				 WHERE 1=1
				 AND fo.isActive = 1
				 AND fo.Direction ='OUT'
				 AND fo.SnapshotFlag = 'FD' 
				 AND fo.Level1ClientID = @Level1Clientid;
				  
				  
                  
				  
				 

					/*Step 1 Start - Load #Temp_CardBenefitLoad*/
DROP TABLE IF EXISTS #Temp_CardBenefitLoad

CREATE TABLE #Temp_CardBenefitLoad(
	[CardBenefitLoadID] [bigint]  NOT NULL,
	[MemberDataID] [bigint] NOT NULL,
	[ClientCode] [varchar](20) NULL,
	[NHLinkID] [varchar](100) NULL,
	[RecordType] [varchar](50) NULL,
	[MemberDataSource] [varchar](50) NULL,
	[InsCarrierID] [int] NULL,
	[InsHealthPlanID] [int] NULL,
	[BenefitCardNumber] [varchar](30) NULL,
	[LastName] [nvarchar](100) NULL,
	--[MiddleInitial] [nvarchar](20) NULL,
	--[FirstName] [nvarchar](100) NULL,
	--[DOB] [date] NULL,
	--[MailingAddress1] [nvarchar](150) NULL,
	--[MailingAddress2] [nvarchar](100) NULL,
	--[MailingCity] [nvarchar](100) NULL,
	--[MailingState] [nvarchar](50) NULL,
	--[MailingZipCode] [nvarchar](20) NULL,
	--[MailingCountry] [nvarchar](100) NULL,
	--[HomePhoneNbr] [nvarchar](20) NULL,
	[BenefitType] [varchar](50) NULL,
	[BenefitSource] [varchar](50) NULL,
	[NBWalletCode] [varchar](50) NULL,
	[BenefitAmount] [decimal](10, 2) NULL,
	[BenefitValidFrom] [date] NULL,
	[BenefitValidTo] [date] NULL,
	[BenefitFreqInMonth] [int] NULL,
	[BenefitYear] [int] NULL,
	[BenefitPeriod] [int] NULL,
	[IsActive] [bit] NULL,
	[RequestRecordStatus] [varchar](50) NULL,
	[RequestToBeProcessed] [varchar](20) NULL,
	[RequestProcessedFileID] [bigint] NULL,
	[RequestProcessedDate] [datetime] NULL,
	[ResponseRecordStatus] [varchar](225) NULL,
	[ResponseRecordStatusCode] [varchar](2) NULL,
	[ResponseProcessedFileID] [bigint] NULL,
	[ResponseProcessedDate] [datetime] NULL,
	[FirstTimeCardIssued] [varchar](1) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUser] [nvarchar](100) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUser] [nvarchar](100) NULL,
	[RefCardBenefitLoadID] [bigint] NULL,
	[ErrorProcessed] [smallint] NULL,
	[Language] [nvarchar](50) NULL,
	[ClientID] bigint,
  --  [ProgramID] bigint,
    [SubProgramID] bigint,
    [PackageID] bigint,
    [FIS_PurseSlot] nvarchar(30)
 CONSTRAINT [PK_Temp_CardBenefitLoad_FD] PRIMARY KEY CLUSTERED 
(
	[CardBenefitLoadID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

					--SELECT * INTO #Temp_CardBenefitLoad FROM otcfunds.CardBenefitLoad_CI WHERE 1 = 0
					
					SET ROWCOUNT @FileThresHold

INSERT INTO #Temp_CardBenefitLoad
(
 CardBenefitLoadID
,MemberDataID
,ClientCode
,NHLinkID
,RecordType
,MemberDataSource
,InsCarrierID
,InsHealthPlanID
,BenefitType
,BenefitSource
,NBWalletCode
,BenefitAmount
,BenefitValidFrom
,BenefitValidTo
,BenefitFreqInMonth
,BenefitYear
,BenefitPeriod
,IsActive
,LastName
--,MiddleInitial
--,FirstName
--,DOB
--,MailingAddress1
--,MailingAddress2
--,MailingCity
--,MailingState
--,MailingZipCode
--,MailingCountry
--,HomePhoneNbr
,BenefitCardNumber
,RequestToBeProcessed
,ClientID
--,ProgramID
,SubProgramID
,PackageID
,FIS_PurseSlot
)
SELECT DISTINCT
 cbl.CardBenefitLoadID
,cbl.MemberDataID
,cbl.ClientCode
,cbl.NHLinkID
,cbl.RecordType
,cbl.MemberDataSource
,cbl.InsCarrierID
,cbl.InsHealthPlanID
,cbl.BenefitType
,cbl.BenefitSource
,cbl.NBWalletCode
,cbl.BenefitAmount
,cbl.BenefitValidFrom
,cbl.BenefitValidTo
,cbl.BenefitFreqInMonth
,cbl.BenefitYear
,cbl.BenefitPeriod
,cbl.IsActive
,cbl.LastName
--,LEFT (cbl.MiddleInitial,1) MiddleInitial 
--,cbl.FirstName
--,cbl.DOB
--,LEFT(flex.RemoveExtendedASCII(cbl.MailingAddress1),50) MailingAddress1   
--,flex.RemoveExtendedASCII(cbl.MailingAddress2) MailingAddress2
--,flex.RemoveExtendedASCII(cbl.MailingCity) MailingCity
--,cbl.MailingState
--,CASE WHEN  LEN(cbl.MailingZipCode) < 5 THEN RIGHT('00000'+ISNULL(cbl.MailingZipCode,''),5) ELSE cbl.MailingZipCode END MailingZipCode
--,cbl.MailingCountry
--,ISNULL(CASE   WHEN  TRY_CAST(HomePhoneNbr AS BIGINT) IS NULL THEN '1'
--               WHEN ISNUMERIC(HomePhoneNbr) = 1 AND CAST(HomePhoneNbr AS BIGINT) = 0 THEN '1' 
--                     ELSE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IIF(HomePhoneNbr IN (''),'1',HomePhoneNbr),')',''),'(',''),',',''),'-',''),' ','')  
--					 END,1) HomePhoneNbr
,cbl.BenefitCardNumber
,cbl.RequestToBeProcessed
,cbl.ClientID
--,cbl.ProgramID
,cbl.SubProgramID
,cbl.PackageID
,cbl.FIS_PurseSlot 
FROM otcfunds.CardBenefitLoad_FD cbl
WHERE cbl.RecordType ='FD'
AND cbl.IsActive = 1
AND cbl.Level1ClientID = @Level1Clientid
AND cbl.RequestToBeProcessed = 'Y'
and cbl.FIS_PurseSlot IS NOT NULL -- Enable for FD  As above condition OUTER APPLY to CROSS APPLY we dont need this condition
--AND isnull(cbl.FileGenInd,'N') = 'N'
AND (ISNULL(cbl.ClientID,'') != '' OR ISNULL(cbl.SubProgramID,'') != '' OR ISNULL(cbl.PackageID,'') != '')
order by cbl.SubProgramID,cbl.PackageID,cbl.ClientID

					/*Step 1 End */
                    SET ROWCOUNT 0


					/*Step 3 Start  - Pre process */
					DECLARE @MaxLenSQL VARCHAR(MAX)
					,@UpdateSQL VARCHAR(MAX)
					,@TableName VARCHAR(200)

					/*Max Length Check */

					DROP TABLE IF EXISTS #tempMaxLength

					CREATE TABLE #tempMaxLength(ColumnName varchar(200),MaxLength int,ColumnAllowedLen int)
					SELECT @TableName = '#Temp_CardBenefitLoad'
					SELECT @MaxLenSQL = ''
					SELECT @MaxLenSQL =  @MaxLenSQL + 'SELECT ColumnName = ' + QUOTENAME(sc.OTCColumnName, '''')  
									   + ', MaxLength = MAX(LEN(' + QUOTENAME(sc.OTCColumnName) + '))'
									   + ', ColumnAllowedLen = '+CAST(((sc.EndPosition+1)-sc.StartPosition) as varchar(10))
									   + ' FROM '
									   + @TableName
									   + ' WHERE RequestToBeProcessed = ''Y'''				   
									   + CHAR(10) +' UNION '
					FROM flex.FISFieldStartEndPositions sc
					WHERE RecordType = 60
					AND OTCColumnName IS NOT NULL

					SELECT @MaxLenSQL = LEFT(@MaxLenSQL, LEN(@MaxLenSQL)-6)
					SELECT @MaxLenSQL = 'INSERT INTO #tempMaxLength '+CHAR(10) + @MaxLenSQL
					PRINT @MaxLenSQL
					EXEC (@MaxLenSQL)


					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL =  @UpdateSQL + ' UPDATE '+@TableName
													+ ' SET  RequestToBeProcessed = ''ERR_SIZE'''
													+ ' WHERE LEN('+ColumnName +') >'+ CAST(ColumnAllowedLen as varchar(10))
													+ ' AND RequestToBeProcessed = ''Y'''
													FROM #tempMaxLength
													WHERE MaxLength>ColumnAllowedLen
					EXEC(@UpdateSQL)



					/* Nullable check for Mandatory Columns*/

					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL = ' UPDATE '+@TableName
										+ CHAR(10)
										+ 'SET RequestToBeProcessed = ''ERR_MAN_COL'''
										+ CHAR(10)
										+ 'WHERE ('
										+ CHAR(10)
										+ STUFF((SELECT ' +' +'CAST(['+sc.OTCColumnName +'] AS varchar(400))'
													   FROM(SELECT U.OTCColumnName
													   FROM  flex.FISFieldStartEndPositions U
													   WHERE RecordType = 60
													   AND [Required] ='Yes'
													   AND OTCColumnName IS NOT NULL
													   ) sc
													   FOR
													   XML PATH('')
													   ), 1, 2, '')
										 + CHAR(10)
										 +') IS NULL'
					PRINT @UpdateSQL
					EXEC(@UpdateSQL)

					
/* Replace Special Charcters */
UPDATE  #Temp_CardBenefitLoad
SET  
--FirstName = flex.[Fn_Replace_Special_Character](FirstName),
    LastName = flex.[Fn_Replace_Special_Character](LastName)
   --, MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
   --, MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
WHERE RequestToBeProcessed = 'Y' 
AND (
--FirstName LIKE '%[^0-9a-zA-Z]%' 
	--OR  
	LastName LIKE '%[^0-9a-zA-Z]%' 
	--OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
	--OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
	)
						
					/* Updating otc funds table for Error Records*/ 

					UPDATE otc
					SET otc.RequestToBeProcessed = tcb.RequestToBeProcessed
					,otc.RequestRecordStatus = CASE WHEN tcb.RequestToBeProcessed ='ERR_SIZE' THEN   'Column length exceeded more than FIS'
													WHEN tcb.RequestToBeProcessed ='ERR_MAN_COL' THEN   'FIS Mandatory columns does not allow NULL values' 
											   END
					FROM otcfunds.CardBenefitLoad_FD otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed IN ('ERR_SIZE','ERR_MAN_COL')



					/*Step 3 END */
					
					/* Updating otc funds table success  Records*/ 

					/*UPDATE otc
					SET otc.FileGenInd = 'Y'					
					FROM otcfunds.CardBenefitLoad_FD otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed  = 'Y'

                    */

					/*Step 3A END */



					/*Step 4 Start Insert FIS Batch file records */

					DROP TABLE IF EXISTS #ClientDetails
					DROP TABLE IF EXISTS #Loop
					DROP TABLE IF EXISTS #FileInfo
					--DROP TABLE IF EXISTS #TempBatch



					DECLARE @Query nvarchar(max)

					,@Identity bigint
					--RecordType = 90

					,@TotalRecords int
					,@BatchCount int
					,@DetailCount int
					,@BatchDetailCount int
					,@TotalCredit decimal (12,2)
					,@TotalDebit decimal (12,2)
					,@FileTrailerID bigint

					,@BatchSequence int
					,@ClientID varchar(20)
					,@SubprogramID varchar(20)
					,@PackageID varchar(20)
					,@RecordType int

					,@Parmdef nvarchar (max)
					,@FileHeaderID bigint
					,@Direction varchar(3)='OUT'
					,@FileTrackId bigint
					,@VendorWalletCode varchar(2)

					--SELECT * FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'

					--SELECT COUNT(1) FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'


					IF EXISTS (SELECT TOP 1 1 FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y')
					BEGIN

					SELECT DISTINCT  fo.FileInfoID as FileInfoID,	
						fo.SnapshotFlag + FORMAT(CAST(GETDATE()AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime),'HHmmssMMddyyyy')+'01'+'.'+ fo.FileExtension AS FileName,
						fo.FromLocation AS FromLocation,
						fo.ToLocation AS ToLocation,
						fo.Direction AS Direction,
						fo.FileFormat AS FileFormat,
						fo.SnapshotFlag AS SnapshotFlag,
						fo.DataSource AS DataSource,
						fo.FileExtension AS FileExtension,
						fo.FileType AS FileType,
						ftpi.WinSCPLoginName AS WinSCPLoginName,
						ISNULL(fo.IsPGP,'') AS IsPGP,
						ISNULL(fo.PGPFileExtension,'') AS PGPFileExtension,
						ISNULL(fo.PGPKeyName,'') AS PGPKeyName,
						ISNULL(fo.isAckFileToFTP,'') AS isFileToFTP
						INTO #FileInfo
					FROM otcfunds.FileInfo fo
					JOIN otcfunds.FTPUserInfo ftpi 
					ON fo.ClientCode = ftpi.ClientCode 
					AND fo.FileType = ftpi.FileType
					AND fo.SnapshotFlag= ftpi.SnapshotFlag
					WHERE 1=1
					AND fo.isActive = 1
					AND fo.Direction ='OUT'
					AND fo.SnapshotFlag = 'FD'
					and fo.Level1ClientID = @Level1Clientid


					INSERT INTO otcfunds.FileTrack( 
					 FileInfoID
					,FileName
					,ClientCode
					,DirectionCode
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,StatusCode
					)
					SELECT FileInfoID
					,FileName
					,@ClientCode
					,'OUT'
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,'999' 
					FROM #FileInfo
					SELECT @FileTrackId= @@IDENTITY

					CREATE TABLE #ClientDetails(
												DetailCount bigint
											   ,TotalCredit decimal(12,2)
											   ,TotalDebit decimal(12,2)
											   ,ClientID varchar(20)
											 --  ,ProgramID varchar(20)
											   ,SubProgramID varchar(20)
											   ,PackageID varchar(20)
											   ,BatchID varchar(20)
											   )
											   
					INSERT INTO #ClientDetails(
												DetailCount 
											   ,TotalCredit
											   ,TotalDebit 
											   ,ClientID 
											 --  ,ProgramID
											   ,SubProgramID 
											   ,PackageID 
											   ,BatchID 
											   )
								SELECT  t.DetailCount
									   ,TotalCredit 
									   ,TotalDebit 
									   ,t.ClientID
									 --  ,t.ProgramID
									   ,t.SubProgramID
									   ,t.PackageID
									   ,BatchID=ROW_NUMBER() OVER( ORDER BY  t.PackageID,t.SubProgramID,t.ClientID)
								FROM 
								(
										
										SELECT DetailCount= COUNT(CardBenefitLoadID)  
										,ClientID=ClientID
										--,ProgramID=ProgramID
										,SubProgramID=SubProgramID
										,PackageID=cbl.PackageID
										,TotalDebit = '000000000.00'
										,TotalCredit =  SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) 
										FROM #Temp_CardBenefitLoad cbl
										WHERE 1=1 
										AND cbl.RequestToBeProcessed = 'Y'
										GROUP BY cbl.PackageID,cbl.ClientID,cbl.SubProgramID
										--,cbl.ProgramID
										,cbl.RecordType
								) t


					SELECT Rn = ROW_NUMBER() OVER(ORDER BY client.PackageID,client.SubProgramID
					          -- ,client.ProgramID
							   ,c.orderRecordType,c.RecordType) 
					,c.RecordType
					,client.DetailCount 
					,client.TotalCredit 
					,client.TotalDebit 
					,client.ClientID 
					--,client.ProgramID 
					,client.SubProgramID 
					,client.PackageID 						  
					,client.BatchID
					,c.orderRecordType
					INTO #Loop 
					FROM (
							SELECT DISTINCT fis.RecordType , convert(int,substring(convert(varchar,fis.RecordType )	,1,2) ) orderRecordType
							FROM flex.FISFieldStartEndPositions fis
							WHERE 1=1 
						--	 AND ( fis.RecordType IN (20,80)  OR ( fis.RecordType like '6%' and CHARINDEX(CONVERT(varchar,fis.RecordType),@RecordTypes) > 0   )  )
							 AND ( fis.RecordType IN (20,80)  OR ( CONVERT(varchar,fis.RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )  )
							 ) c									
									     
							--WHERE 1=( 
							--		CASE WHEN @OTCRecordType='CI' AND fis.RecordType NOT IN (10,90,60,99) THEN 1
							--		     WHEN @OTCRecordType<>'CI' AND fis.RecordType NOT IN (10,90,30,31,99) THEN 1
							--		END
							--		)
							--	 ) c  
					CROSS APPLY(
					SELECT   DetailCount 
							,TotalCredit 
							,TotalDebit 
							,ClientID 
							--,ProgramID 
							,SubProgramID 
							,PackageID 						  
							,BatchID  FROM #ClientDetails
					) client
					ORDER BY client.BatchID, c.orderRecordType, c.RecordType


					/*Executing RecordType=10*/
					SELECT @Query =''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(10)
					SET @Identity= @FileTrackId

					SET @parmdef = '@FileTrackId varchar(10)
									,@Direction varchar(3)
									,@FilHeaderID bigint out'
					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					SELECT @Query = replace(@Query,'   718967',('   '+ CAST(@Level1Clientid AS VARCHAR(10)))  )
					
					--print @Query

					EXEC sp_executesql  @Query
									   ,@parmdef				   
									   ,@Identity
									   ,@Direction
									   ,@Identity OUT
					SELECT @FileHeaderID=@Identity
					--print @Query


					--/*10 Record Completed */

					/*90 Record Type Started */

					SELECT @TotalRecords=COUNT(1)+2
					FROM #Loop WHERE RecordType  IN (20,80) -- NOT IN (60)

					SELECT @DetailCount = SUM(DetailCount)
					,@BatchCount=COUNT(BatchID)
					,@TotalCredit=SUM(TotalCredit)
					,@TotalDebit=SUM(TotalDebit)
					FROM #ClientDetails

					SET @parmdef = '@TotalRecords int,@BatchCount int
							,@DetailCount bigint
							,@TotalCredit decimal(12,2)
							,@TotalDebit decimal(12,2)
							,@FileTrackId varchar(10)
							,@Direction varchar(3)
							,@FileTrailerID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(90)
					SELECT @Query = @Query+'SELECT @FileTrailerID= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@TotalRecords
									  ,@BatchCount
									  ,@DetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@FileTrackId
									  ,@Direction
									  ,@FileTrailerID OUT
					/*90 Record Type End */


					/*Record Type 20,30,60,80 Started */

					DECLARE @MinCounter int
						   ,@MaxCounter int
					SELECT @MinCounter = MIN(Rn) 
						  ,@MaxCounter = MAX(Rn)
					FROM #Loop

 
					WHILE(@MinCounter<=@MaxCounter)
					BEGIN

					SELECT TOP 1  @BatchSequence=  BatchID 
								 ,@ClientID = ClientID
								 ,@SubprogramID = SubprogramID
								 ,@PackageID = PackageID
								 ,@RecordType = RecordType
								 ,@BatchDetailCount = DetailCount
								 --,@VendorWalletCode = FIS_PurseSlot
								 ,@TotalCredit = TotalCredit
								 ,@TotalDebit = TotalDebit	
								FROM #Loop 
								WHERE Rn= @MinCounter
								ORDER BY BatchID,RecordType
			
					/*20 Variables */
					IF (@RecordType=20)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@ClientID varchar(20)
							,@SubprogramID varchar(20)
							,@PackageID varchar(20)
							,@Direction varchar(3)
							,@FilHeaderID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(20)


					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@FileHeaderID
									  ,@BatchSequence
									  ,@ClientID
									  ,@SubprogramID
									  ,@PackageID
									  ,@Direction
									  ,@Identity OUT
					END



					--IF (@RecordType IN (60))
				
					--IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					IF (CONVERT(varchar,@RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )
					BEGIN
					SET @parmdef = '@Identity varchar(10)
									,@Direction varchar(3)'
				
					SELECT @Query = ''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(@RecordType)

					SELECT @Query = @Query+' FROM #Temp_CardBenefitLoad WHERE 1=1'
					+' AND #Temp_CardBenefitLoad.RequestToBeProcessed = ''Y'''
					+' AND #Temp_CardBenefitLoad.ClientID = '+''''+@ClientID +''''
					+' AND #Temp_CardBenefitLoad.SubProgramID = '+''''+@SubprogramID  +''''
					+' AND #Temp_CardBenefitLoad.PackageID = '+''''+@PackageID +''''




				--	IF(@RecordType IN (30,31,33,3601))
				--    IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					IF (CONVERT(varchar,@RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )
				--	print @RecordType
				--	print @Identity
				--	print @Direction 
				--	print @Query
					--print substrING(@Query, 300, len(@Query))
					
					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@Direction 



					END
					IF (@RecordType=80)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@BatchDetailCount varchar(20)
							,@TotalCredit varchar(20)
							,@TotalDebit varchar(20)
							,@Direction varchar(3)'
		
					SELECT @Query=''

					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(80)


					SELECT @Identity= @FileTrailerID

					SELECT @Query = @Query+'SELECT @Identity= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@BatchSequence
									  ,@BatchDetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@Direction
					END

					SELECT @MinCounter = @MinCounter+1

					END
					
					END
					/*Step 4 End */

					IF(@FileTrackId>0)
					BEGIN
					SELECT FileName
						  ,FromLocation
						  ,ToLocation
						  ,WinSCPLoginName
						  ,FileTrackId=@FileTrackId
						  ,IsPGP
						  ,PGPFileExtension
						  ,PGPKeyName 
						  ,isFileToFTP
						  FROM #FileInfo 
					END
					ELSE 
					BEGIN
					SELECT FileName=''
						  ,FromLocation=''
						  ,ToLocation=''
						  ,WinSCPLoginName=''
						  ,FileTrackId=0
						  ,IsPGP=''
						  ,PGPFileExtension=''
						  ,PGPKeyName =''
						  ,isFileToFTP=''
					END


		COMMIT TRANSACTION FISFundDisbursementCreateFile
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISFundDisbursementCreateFile
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
		DECLARE @ErrorLine  INT;

        SELECT 		
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine =ERROR_LINE(); 
		
        set @ErrorMessage = @ErrorMessage + '--Error Line' + cast(@ErrorLine as NVARCHAR(5) )
		
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);

  
END CATCH

END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_FundDisbursement_CreateFile_bkp]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [flex].[sp_ssis_FIS_FundDisbursement_CreateFile_bkp] (@ClientCode VARCHAR(20), @Level1Clientid bigint)
AS

-- exec flex.sp_ssis_FIS_FundDisbursement_CreateFile 'H638' , 995407

BEGIN
SET NOCOUNT ON 

BEGIN TRY

		BEGIN TRANSACTION FISFundDisbursementCreateFile
			
			      -- Questions -- Check again in eligibilty and update CardBenefitLoadID
				  --    Change the package name
				  
				  declare @FileThresHold   int;
				  declare @RecordTypeCnt   int;
				  declare @RecordTypes     varchar(50);
				  
				  
				  SELECT @FileThresHold = ISNULL(FileThreshold,0)
				        ,@RecordTypeCnt = RecordTypeCnt
						,@RecordTypes = RecordTypes
				 FROM  otcfunds.FileInfo fo 
				 WHERE 1=1
				 AND fo.isActive = 1
				 AND fo.Direction ='OUT'
				 AND fo.SnapshotFlag = 'FD' 
				 AND fo.Level1ClientID = @Level1Clientid;
				  
				  
                  
				  
				 

					/*Step 1 Start - Load #Temp_CardBenefitLoad*/
DROP TABLE IF EXISTS #Temp_CardBenefitLoad

CREATE TABLE #Temp_CardBenefitLoad(
	[CardBenefitLoadID] [bigint]  NOT NULL,
	[MemberDataID] [bigint] NOT NULL,
	[ClientCode] [varchar](20) NULL,
	[NHLinkID] [varchar](100) NULL,
	[RecordType] [varchar](50) NULL,
	[MemberDataSource] [varchar](50) NULL,
	[InsCarrierID] [int] NULL,
	[InsHealthPlanID] [int] NULL,
	[BenefitCardNumber] [varchar](30) NULL,
	[LastName] [nvarchar](100) NULL,
	--[MiddleInitial] [nvarchar](20) NULL,
	--[FirstName] [nvarchar](100) NULL,
	--[DOB] [date] NULL,
	--[MailingAddress1] [nvarchar](150) NULL,
	--[MailingAddress2] [nvarchar](100) NULL,
	--[MailingCity] [nvarchar](100) NULL,
	--[MailingState] [nvarchar](50) NULL,
	--[MailingZipCode] [nvarchar](20) NULL,
	--[MailingCountry] [nvarchar](100) NULL,
	--[HomePhoneNbr] [nvarchar](20) NULL,
	[BenefitType] [varchar](50) NULL,
	[BenefitSource] [varchar](50) NULL,
	[NBWalletCode] [varchar](50) NULL,
	[BenefitAmount] [decimal](10, 2) NULL,
	[BenefitValidFrom] [date] NULL,
	[BenefitValidTo] [date] NULL,
	[BenefitFreqInMonth] [int] NULL,
	[BenefitYear] [int] NULL,
	[BenefitPeriod] [int] NULL,
	[IsActive] [bit] NULL,
	[RequestRecordStatus] [varchar](50) NULL,
	[RequestToBeProcessed] [varchar](20) NULL,
	[RequestProcessedFileID] [bigint] NULL,
	[RequestProcessedDate] [datetime] NULL,
	[ResponseRecordStatus] [varchar](225) NULL,
	[ResponseRecordStatusCode] [varchar](2) NULL,
	[ResponseProcessedFileID] [bigint] NULL,
	[ResponseProcessedDate] [datetime] NULL,
	[FirstTimeCardIssued] [varchar](1) NULL,
	[CreateDate] [datetime] NULL,
	[CreateUser] [nvarchar](100) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUser] [nvarchar](100) NULL,
	[RefCardBenefitLoadID] [bigint] NULL,
	[ErrorProcessed] [smallint] NULL,
	[Language] [nvarchar](50) NULL,
	[ClientID] bigint,
  --  [ProgramID] bigint,
    [SubProgramID] bigint,
    [PackageID] bigint,
    [FIS_PurseSlot] nvarchar(30)
 CONSTRAINT [PK_Temp_CardBenefitLoad_FD] PRIMARY KEY CLUSTERED 
(
	[CardBenefitLoadID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

					--SELECT * INTO #Temp_CardBenefitLoad FROM otcfunds.CardBenefitLoad_CI WHERE 1 = 0
					
					SET ROWCOUNT @FileThresHold

INSERT INTO #Temp_CardBenefitLoad
(
 CardBenefitLoadID
,MemberDataID
,ClientCode
,NHLinkID
,RecordType
,MemberDataSource
,InsCarrierID
,InsHealthPlanID
,BenefitType
,BenefitSource
,NBWalletCode
,BenefitAmount
,BenefitValidFrom
,BenefitValidTo
,BenefitFreqInMonth
,BenefitYear
,BenefitPeriod
,IsActive
,LastName
--,MiddleInitial
--,FirstName
--,DOB
--,MailingAddress1
--,MailingAddress2
--,MailingCity
--,MailingState
--,MailingZipCode
--,MailingCountry
--,HomePhoneNbr
,BenefitCardNumber
,RequestToBeProcessed
,ClientID
--,ProgramID
,SubProgramID
,PackageID
,FIS_PurseSlot
)
SELECT DISTINCT
 cbl.CardBenefitLoadID
,cbl.MemberDataID
,cbl.ClientCode
,cbl.NHLinkID
,cbl.RecordType
,cbl.MemberDataSource
,cbl.InsCarrierID
,cbl.InsHealthPlanID
,cbl.BenefitType
,cbl.BenefitSource
,cbl.NBWalletCode
,cbl.BenefitAmount
,cbl.BenefitValidFrom
,cbl.BenefitValidTo
,cbl.BenefitFreqInMonth
,cbl.BenefitYear
,cbl.BenefitPeriod
,cbl.IsActive
,cbl.LastName
--,LEFT (cbl.MiddleInitial,1) MiddleInitial 
--,cbl.FirstName
--,cbl.DOB
--,LEFT(flex.RemoveExtendedASCII(cbl.MailingAddress1),50) MailingAddress1   
--,flex.RemoveExtendedASCII(cbl.MailingAddress2) MailingAddress2
--,flex.RemoveExtendedASCII(cbl.MailingCity) MailingCity
--,cbl.MailingState
--,CASE WHEN  LEN(cbl.MailingZipCode) < 5 THEN RIGHT('00000'+ISNULL(cbl.MailingZipCode,''),5) ELSE cbl.MailingZipCode END MailingZipCode
--,cbl.MailingCountry
--,ISNULL(CASE   WHEN  TRY_CAST(HomePhoneNbr AS BIGINT) IS NULL THEN '1'
--               WHEN ISNUMERIC(HomePhoneNbr) = 1 AND CAST(HomePhoneNbr AS BIGINT) = 0 THEN '1' 
--                     ELSE REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(IIF(HomePhoneNbr IN (''),'1',HomePhoneNbr),')',''),'(',''),',',''),'-',''),' ','')  
--					 END,1) HomePhoneNbr
,cbl.BenefitCardNumber
,cbl.RequestToBeProcessed
,cbl.ClientID
--,cbl.ProgramID
,cbl.SubProgramID
,cbl.PackageID
,cbl.FIS_PurseSlot 
FROM otcfunds.CardBenefitLoad_FD cbl
WHERE cbl.RecordType ='FD'
AND cbl.IsActive = 1
AND cbl.Level1ClientID = @Level1Clientid
AND cbl.RequestToBeProcessed = 'Y'
and cbl.FIS_PurseSlot IS NOT NULL -- Enable for FD  As above condition OUTER APPLY to CROSS APPLY we dont need this condition
--AND isnull(cbl.FileGenInd,'N') = 'N'
AND (ISNULL(cbl.ClientID,'') != '' OR ISNULL(cbl.SubProgramID,'') != '' OR ISNULL(cbl.PackageID,'') != '')
order by cbl.SubProgramID,cbl.PackageID,cbl.ClientID

					/*Step 1 End */
                    SET ROWCOUNT 0


					/*Step 3 Start  - Pre process */
					DECLARE @MaxLenSQL VARCHAR(MAX)
					,@UpdateSQL VARCHAR(MAX)
					,@TableName VARCHAR(200)

					/*Max Length Check */

					DROP TABLE IF EXISTS #tempMaxLength

					CREATE TABLE #tempMaxLength(ColumnName varchar(200),MaxLength int,ColumnAllowedLen int)
					SELECT @TableName = '#Temp_CardBenefitLoad'
					SELECT @MaxLenSQL = ''
					SELECT @MaxLenSQL =  @MaxLenSQL + 'SELECT ColumnName = ' + QUOTENAME(sc.OTCColumnName, '''')  
									   + ', MaxLength = MAX(LEN(' + QUOTENAME(sc.OTCColumnName) + '))'
									   + ', ColumnAllowedLen = '+CAST(((sc.EndPosition+1)-sc.StartPosition) as varchar(10))
									   + ' FROM '
									   + @TableName
									   + ' WHERE RequestToBeProcessed = ''Y'''				   
									   + CHAR(10) +' UNION '
					FROM flex.FISFieldStartEndPositions sc
					WHERE RecordType = 60
					AND OTCColumnName IS NOT NULL

					SELECT @MaxLenSQL = LEFT(@MaxLenSQL, LEN(@MaxLenSQL)-6)
					SELECT @MaxLenSQL = 'INSERT INTO #tempMaxLength '+CHAR(10) + @MaxLenSQL
					PRINT @MaxLenSQL
					EXEC (@MaxLenSQL)


					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL =  @UpdateSQL + ' UPDATE '+@TableName
													+ ' SET  RequestToBeProcessed = ''ERR_SIZE'''
													+ ' WHERE LEN('+ColumnName +') >'+ CAST(ColumnAllowedLen as varchar(10))
													+ ' AND RequestToBeProcessed = ''Y'''
													FROM #tempMaxLength
													WHERE MaxLength>ColumnAllowedLen
					EXEC(@UpdateSQL)



					/* Nullable check for Mandatory Columns*/

					SELECT @UpdateSQL = ''
					SELECT @UpdateSQL = ' UPDATE '+@TableName
										+ CHAR(10)
										+ 'SET RequestToBeProcessed = ''ERR_MAN_COL'''
										+ CHAR(10)
										+ 'WHERE ('
										+ CHAR(10)
										+ STUFF((SELECT ' +' +'CAST(['+sc.OTCColumnName +'] AS varchar(400))'
													   FROM(SELECT U.OTCColumnName
													   FROM  flex.FISFieldStartEndPositions U
													   WHERE RecordType = 60
													   AND [Required] ='Yes'
													   AND OTCColumnName IS NOT NULL
													   ) sc
													   FOR
													   XML PATH('')
													   ), 1, 2, '')
										 + CHAR(10)
										 +') IS NULL'
					PRINT @UpdateSQL
					EXEC(@UpdateSQL)

					
/* Replace Special Charcters */
UPDATE  #Temp_CardBenefitLoad
SET  
--FirstName = flex.[Fn_Replace_Special_Character](FirstName),
    LastName = flex.[Fn_Replace_Special_Character](LastName)
   --, MailingAddress1 = flex.[Fn_Replace_Special_Character](MailingAddress1)
   --, MailingAddress2 = flex.[Fn_Replace_Special_Character](MailingAddress2)
WHERE RequestToBeProcessed = 'Y' 
AND (
--FirstName LIKE '%[^0-9a-zA-Z]%' 
	--OR  
	LastName LIKE '%[^0-9a-zA-Z]%' 
	--OR MailingAddress1 LIKE '%[^0-9a-zA-Z]%'
	--OR MailingAddress2 LIKE '%[^0-9a-zA-Z]%'
	)
						
					/* Updating otc funds table for Error Records*/ 

					UPDATE otc
					SET otc.RequestToBeProcessed = tcb.RequestToBeProcessed
					,otc.RequestRecordStatus = CASE WHEN tcb.RequestToBeProcessed ='ERR_SIZE' THEN   'Column length exceeded more than FIS'
													WHEN tcb.RequestToBeProcessed ='ERR_MAN_COL' THEN   'FIS Mandatory columns does not allow NULL values' 
											   END
					FROM otcfunds.CardBenefitLoad_FD otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed IN ('ERR_SIZE','ERR_MAN_COL')



					/*Step 3 END */
					
					/* Updating otc funds table success  Records*/ 

					/*UPDATE otc
					SET otc.FileGenInd = 'Y'					
					FROM otcfunds.CardBenefitLoad_FD otc
					INNER JOIN #Temp_CardBenefitLoad tcb
					ON tcb.CardBenefitLoadID = otc.CardBenefitLoadID
					WHERE tcb.RequestToBeProcessed  = 'Y'

                    */

					/*Step 3A END */



					/*Step 4 Start Insert FIS Batch file records */

					DROP TABLE IF EXISTS #ClientDetails
					DROP TABLE IF EXISTS #Loop
					DROP TABLE IF EXISTS #FileInfo
					--DROP TABLE IF EXISTS #TempBatch



					DECLARE @Query nvarchar(max)

					,@Identity bigint
					--RecordType = 90

					,@TotalRecords int
					,@BatchCount int
					,@DetailCount int
					,@BatchDetailCount int
					,@TotalCredit decimal (12,2)
					,@TotalDebit decimal (12,2)
					,@FileTrailerID bigint

					,@BatchSequence int
					,@ClientID varchar(20)
					,@SubprogramID varchar(20)
					,@PackageID varchar(20)
					,@RecordType int

					,@Parmdef nvarchar (max)
					,@FileHeaderID bigint
					,@Direction varchar(3)='OUT'
					,@FileTrackId bigint
					,@VendorWalletCode varchar(2)

					--SELECT * FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'

					--SELECT COUNT(1) FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y'


					IF EXISTS (SELECT TOP 1 1 FROM #Temp_CardBenefitLoad t WHERE t.RequestToBeProcessed='Y')
					BEGIN

					SELECT  fo.FileInfoID as FileInfoID,	
						fo.SnapshotFlag + FORMAT(CAST(GETDATE()AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime),'HHmmssMMddyyyy')+'01'+'.'+ fo.FileExtension AS FileName,
						fo.FromLocation AS FromLocation,
						fo.ToLocation AS ToLocation,
						fo.Direction AS Direction,
						fo.FileFormat AS FileFormat,
						fo.SnapshotFlag AS SnapshotFlag,
						fo.DataSource AS DataSource,
						fo.FileExtension AS FileExtension,
						fo.FileType AS FileType,
						ftpi.WinSCPLoginName AS WinSCPLoginName,
						ISNULL(fo.IsPGP,'') AS IsPGP,
						ISNULL(fo.PGPFileExtension,'') AS PGPFileExtension,
						ISNULL(fo.PGPKeyName,'') AS PGPKeyName,
						ISNULL(fo.isAckFileToFTP,'') AS isFileToFTP
						INTO #FileInfo
					FROM otcfunds.FileInfo fo
					JOIN otcfunds.FTPUserInfo ftpi 
					ON fo.ClientCode = ftpi.ClientCode 
					AND fo.FileType = ftpi.FileType
					AND fo.SnapshotFlag= ftpi.SnapshotFlag
					WHERE 1=1
					AND fo.isActive = 1
					AND fo.Direction ='OUT'
					AND fo.SnapshotFlag = 'FD'
					and fo.Level1ClientID = @Level1Clientid


					INSERT INTO otcfunds.FileTrack( 
					 FileInfoID
					,FileName
					,ClientCode
					,DirectionCode
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,StatusCode
					)
					SELECT FileInfoID
					,FileName
					,@ClientCode
					,'OUT'
					,FileFormat
					,DataSource
					,FileType
					,SnapshotFlag
					,'999' 
					FROM #FileInfo
					SELECT @FileTrackId= @@IDENTITY

					CREATE TABLE #ClientDetails(
												DetailCount bigint
											   ,TotalCredit decimal(12,2)
											   ,TotalDebit decimal(12,2)
											   ,ClientID varchar(20)
											 --  ,ProgramID varchar(20)
											   ,SubProgramID varchar(20)
											   ,PackageID varchar(20)
											   ,BatchID varchar(20)
											   )
											   
					INSERT INTO #ClientDetails(
												DetailCount 
											   ,TotalCredit
											   ,TotalDebit 
											   ,ClientID 
											 --  ,ProgramID
											   ,SubProgramID 
											   ,PackageID 
											   ,BatchID 
											   )
								SELECT  t.DetailCount
									   ,TotalCredit 
									   ,TotalDebit 
									   ,t.ClientID
									 --  ,t.ProgramID
									   ,t.SubProgramID
									   ,t.PackageID
									   ,BatchID=ROW_NUMBER() OVER( ORDER BY  t.PackageID,t.SubProgramID,t.ClientID)
								FROM 
								(
										
										SELECT DetailCount= COUNT(CardBenefitLoadID)  
										,ClientID=ClientID
										--,ProgramID=ProgramID
										,SubProgramID=SubProgramID
										,PackageID=cbl.PackageID
										,TotalDebit = '000000000.00'
										,TotalCredit =  SUM(ISNULL(cbl.BenefitAmount,'000000000.00')) 
										FROM #Temp_CardBenefitLoad cbl
										WHERE 1=1 
										AND cbl.RequestToBeProcessed = 'Y'
										GROUP BY cbl.PackageID,cbl.ClientID,cbl.SubProgramID
										--,cbl.ProgramID
										,cbl.RecordType
								) t


					SELECT Rn = ROW_NUMBER() OVER(ORDER BY client.PackageID,client.SubProgramID
					          -- ,client.ProgramID
							   ,c.orderRecordType,c.RecordType) 
					,c.RecordType
					,client.DetailCount 
					,client.TotalCredit 
					,client.TotalDebit 
					,client.ClientID 
					--,client.ProgramID 
					,client.SubProgramID 
					,client.PackageID 						  
					,client.BatchID
					,c.orderRecordType
					INTO #Loop 
					FROM (
							SELECT DISTINCT fis.RecordType , convert(int,substring(convert(varchar,fis.RecordType )	,1,2) ) orderRecordType
							FROM flex.FISFieldStartEndPositions fis
							WHERE 1=1 
						--	 AND ( fis.RecordType IN (20,80)  OR ( fis.RecordType like '6%' and CHARINDEX(CONVERT(varchar,fis.RecordType),@RecordTypes) > 0   )  )
							 AND ( fis.RecordType IN (20,80)  OR ( CONVERT(varchar,fis.RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )  )
							 ) c									
									     
							--WHERE 1=( 
							--		CASE WHEN @OTCRecordType='CI' AND fis.RecordType NOT IN (10,90,60,99) THEN 1
							--		     WHEN @OTCRecordType<>'CI' AND fis.RecordType NOT IN (10,90,30,31,99) THEN 1
							--		END
							--		)
							--	 ) c  
					CROSS APPLY(
					SELECT   DetailCount 
							,TotalCredit 
							,TotalDebit 
							,ClientID 
							--,ProgramID 
							,SubProgramID 
							,PackageID 						  
							,BatchID  FROM #ClientDetails
					) client
					ORDER BY client.BatchID, c.orderRecordType, c.RecordType


					/*Executing RecordType=10*/
					SELECT @Query =''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(10)
					SET @Identity= @FileTrackId

					SET @parmdef = '@FileTrackId varchar(10)
									,@Direction varchar(3)
									,@FilHeaderID bigint out'
					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					SELECT @Query = replace(@Query,'   718967',('   '+ CAST(@Level1Clientid AS VARCHAR(10)))  )
					
					--print @Query

					EXEC sp_executesql  @Query
									   ,@parmdef				   
									   ,@Identity
									   ,@Direction
									   ,@Identity OUT
					SELECT @FileHeaderID=@Identity
					--print @Query


					--/*10 Record Completed */

					/*90 Record Type Started */

					SELECT @TotalRecords=COUNT(1)+2
					FROM #Loop WHERE RecordType  IN (20,80) -- NOT IN (60)

					SELECT @DetailCount = SUM(DetailCount)
					,@BatchCount=COUNT(BatchID)
					,@TotalCredit=SUM(TotalCredit)
					,@TotalDebit=SUM(TotalDebit)
					FROM #ClientDetails

					SET @parmdef = '@TotalRecords int,@BatchCount int
							,@DetailCount bigint
							,@TotalCredit decimal(12,2)
							,@TotalDebit decimal(12,2)
							,@FileTrackId varchar(10)
							,@Direction varchar(3)
							,@FileTrailerID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(90)
					SELECT @Query = @Query+'SELECT @FileTrailerID= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@TotalRecords
									  ,@BatchCount
									  ,@DetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@FileTrackId
									  ,@Direction
									  ,@FileTrailerID OUT
					/*90 Record Type End */


					/*Record Type 20,30,60,80 Started */

					DECLARE @MinCounter int
						   ,@MaxCounter int
					SELECT @MinCounter = MIN(Rn) 
						  ,@MaxCounter = MAX(Rn)
					FROM #Loop

 
					WHILE(@MinCounter<=@MaxCounter)
					BEGIN

					SELECT TOP 1  @BatchSequence=  BatchID 
								 ,@ClientID = ClientID
								 ,@SubprogramID = SubprogramID
								 ,@PackageID = PackageID
								 ,@RecordType = RecordType
								 ,@BatchDetailCount = DetailCount
								 --,@VendorWalletCode = FIS_PurseSlot
								 ,@TotalCredit = TotalCredit
								 ,@TotalDebit = TotalDebit	
								FROM #Loop 
								WHERE Rn= @MinCounter
								ORDER BY BatchID,RecordType
			
					/*20 Variables */
					IF (@RecordType=20)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@ClientID varchar(20)
							,@SubprogramID varchar(20)
							,@PackageID varchar(20)
							,@Direction varchar(3)
							,@FilHeaderID bigint out'

					SELECT @Query=''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(20)


					SELECT @Query = @Query+'SELECT @FilHeaderID= CAST (@@Identity as bigint)'
					
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@FileHeaderID
									  ,@BatchSequence
									  ,@ClientID
									  ,@SubprogramID
									  ,@PackageID
									  ,@Direction
									  ,@Identity OUT
					END



					--IF (@RecordType IN (60))
				
					--IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					IF (CONVERT(varchar,@RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )
					BEGIN
					SET @parmdef = '@Identity varchar(10)
									,@Direction varchar(3)'
				
					SELECT @Query = ''
					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(@RecordType)

					SELECT @Query = @Query+' FROM #Temp_CardBenefitLoad WHERE 1=1'
					+' AND #Temp_CardBenefitLoad.RequestToBeProcessed = ''Y'''
					+' AND #Temp_CardBenefitLoad.ClientID = '+''''+@ClientID +''''
					+' AND #Temp_CardBenefitLoad.SubProgramID = '+''''+@SubprogramID  +''''
					+' AND #Temp_CardBenefitLoad.PackageID = '+''''+@PackageID +''''




				--	IF(@RecordType IN (30,31,33,3601))
				--    IF (CHARINDEX(CONVERT(varchar,@RecordType),@RecordTypes) > 0 )
					IF (CONVERT(varchar,@RecordType) IN (SELECT VALUE FROM STRING_SPLIT(@RecordTypes, ',') ) )
				--	print @RecordType
				--	print @Identity
				--	print @Direction 
				--	print @Query
					--print substrING(@Query, 300, len(@Query))
					
					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@Direction 



					END
					IF (@RecordType=80)
					BEGIN
					SET @parmdef = '@Identity varchar(10)
							,@BatchSequence int
							,@BatchDetailCount varchar(20)
							,@TotalCredit varchar(20)
							,@TotalDebit varchar(20)
							,@Direction varchar(3)'
		
					SELECT @Query=''

					SELECT @Query = flex.Fn_Insert_Select_RecordTypeQuery(80)


					SELECT @Identity= @FileTrailerID

					SELECT @Query = @Query+'SELECT @Identity= CAST (@@Identity as bigint)'
					--print @Query

					EXEC sp_executesql @Query
									  ,@parmdef
									  ,@Identity
									  ,@BatchSequence
									  ,@BatchDetailCount
									  ,@TotalCredit
									  ,@TotalDebit
									  ,@Direction
					END

					SELECT @MinCounter = @MinCounter+1

					END
					
					END
					/*Step 4 End */

					IF(@FileTrackId>0)
					BEGIN
					SELECT FileName
						  ,FromLocation
						  ,ToLocation
						  ,WinSCPLoginName
						  ,FileTrackId=@FileTrackId
						  ,IsPGP
						  ,PGPFileExtension
						  ,PGPKeyName 
						  ,isFileToFTP
						  FROM #FileInfo 
					END
					ELSE 
					BEGIN
					SELECT FileName=''
						  ,FromLocation=''
						  ,ToLocation=''
						  ,WinSCPLoginName=''
						  ,FileTrackId=0
						  ,IsPGP=''
						  ,PGPFileExtension=''
						  ,PGPKeyName =''
						  ,isFileToFTP=''
					END


		COMMIT TRANSACTION FISFundDisbursementCreateFile
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISFundDisbursementCreateFile
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;
		DECLARE @ErrorLine  INT;

        SELECT 		
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(),
        @ErrorLine =ERROR_LINE(); 
		
        set @ErrorMessage = @ErrorMessage + '--Error Line' + cast(@ErrorLine as NVARCHAR(5) )
		
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);

  
END CATCH

END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_FIS_FundDisbursement_Test]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--EXEC flex.sp_ssis_FIS_FundDisbursement_DP 'H638',1,'2023',0

CREATE PROCEDURE [flex].[sp_ssis_FIS_FundDisbursement_Test]
(
	    @ClientCode VARCHAR(20)
       ,@Period INT
	   ,@Year INT
	   ,@Flip INT
	   ,@Level1Clientid bigint
	   )
	   AS 
BEGIN
BEGIN TRY
BEGIN TRANSACTION FISFundDisbursementDP




DECLARE @EligibleDate DATE
	-- Monthly
	IF(@Period BETWEEN 1 AND 12) 	
	  BEGIN 
	     DECLARE 
                 @MonthNumber INT = @Period, 
				 @MonthStartDate Date, 
				 @MonthEndDate Date 

         SET @MonthStartDate = (Select DATEFROMPARTS(@Year,@MonthNumber,1))
         SET @MonthEndDate = (Select EOMONTH(DATEFROMPARTS(@Year,@MonthNumber,1))) 
		 --SELECT @EligibleDate = @MonthStartDate
	  END 

    -- Quarterly
    ELSE IF(@Period BETWEEN 21 AND 24)
       BEGIN  
	     DECLARE 
                 @QuarterNumber INT = Right(@Period,1),
				 @QuarterStartDate Date, 
				 @QuarterEndDate Date 
         SET @QuarterStartDate = (Select DATEFROMPARTS(@year,(@QuarterNumber * 3)-2,1))
         SET @QuarterEndDate = (Select EOMONTH(DATEFROMPARTS(@year,@QuarterNumber * 3,1))) 
		 --SELECT @EligibleDate = @QuarterStartDate
	  END 

    -- Yearly
	ELSE IF (@Period=0) 
	   BEGIN 
	      DECLARE 
				  @AnnualStartDate Date, 
				  @AnnualEndDate Date

		  SET @AnnualStartDate = (Select DATEFROMPARTS(@year,1,1))
          SET @AnnualEndDate = (Select EOMONTH(DATEFROMPARTS(@year,12,31)))
		  --SELECT @EligibleDate = @AnnualStartDate
	   END

    -- Half Yearly
    ELSE IF(@Period BETWEEN 31 AND 32)
       BEGIN  
	     DECLARE 
                 @HalfYearlyNumber INT = Right(@Period,1),
				 @HalfYearlyStartDate Date, 
				 @HalfYearlyEndDate Date 
         SET @HalfYearlyStartDate = (Select DATEFROMPARTS(@year,(@HalfYearlyNumber * 6)-5,1))
         SET @HalfYearlyEndDate = (Select EOMONTH(DATEFROMPARTS(@year,@HalfYearlyNumber * 6,1))) 
		 --SELECT @EligibleDate = @QuarterStartDate
	  END 

    

	   IF (@Flip = 1) -- Flip = 1 enables the flip API call to update SubProgram and is used to load funds for current benefit period
	   BEGIN  
		SET @EligibleDate = CAST(getdate() AT TIME ZONE 'UTC'   AT TIME ZONE 'Eastern Standard Time' AS DATE)
		--set @EligibleDate = '01/02/2023';
	   END

	   IF (@Flip = 0)  -- Flip = 0 disables the flip API call and is used to load funds for future benefit period, member should be eligible next 3 days.
	   BEGIN
		SET @EligibleDate = CAST(getdate()+3 AT TIME ZONE 'UTC'   AT TIME ZONE 'Eastern Standard Time' AS DATE)
		--set @EligibleDate = '01/02/2023';
	   END

  DECLARE  @LoadThresHold   int
       
		SET @LoadThresHold  = ( SELECT ISNULL(LoadThreshold,0) FROM  otcfunds.FileInfo fo WHERE 1=1
																					AND fo.ClientCode = @ClientCode
																					AND fo.isActive = 1
																					AND fo.Direction ='OUT'
																					AND fo.Level1Clientid = @Level1Clientid
																					AND fo.SnapshotFlag = 'FD' )


	
/*Step 1 Start Identify records for Funds to be load */
DROP TABLE IF EXISTS #OTCFUNDSFD								
DROP TABLE IF EXISTS #OTCFUNDSFDFreq
DROP TABLE IF EXISTS #BenefitDataPrep
drop table if EXISTS #dup_nh

	       SELECT DISTINCT Mstr.MemberDataID
			  ,Mstr.NHLinkID 
			  ,Mstr.[insCarrierID] 
			  ,Mstr.[insHealthPlanID]			  
			  ,'OTC' BenefitType			  
			  ,'FIS' BenefitSource			 
			  ,GETDATE() BenefitStartDate
			  ,'12/31/2099' BenefitEndDate 
			  ,'Test'ClientCode
			  ,Mstr.LastName
			  ,mstr.BenefitCardNumber   
			  into #OTCFUNDSFD
			   From [otcfunds].[CardBenefitLoad_CI] Mstr WITH (NOLOCK)
			   JOIN (
			           select DISTINCT CarrierID,HealthPlanID
					   from [flex].[FISWalletMapping] 
					   where isactive =1 
					   AND FIS_PurseName is not null
					   AND Level1Clientid = @Level1Clientid 
					   and ClientCode = @ClientCode
					   -- and ISNULL(FIS_Status,'') = 'A'
					   -- AND @EligibleDate BETWEEN PurseStartDate and PurseEndDate
			        ) Ben ON Ben.CarrierID=Mstr.insCarrierID  AND Ben.HealthPlanID=Mstr.insHealthPlanID	
			     WHERE Mstr.isActive = 1
				 and mstr.ClientCode = @ClientCode
				 and mstr.Level1ClientID = @Level1Clientid
				 and mstr.BenefitCardNumber is not null

            -- Check for duplicate members
			select NHLinkID, count(*) cnt 
			into #dup_nh 
			from #OTCFUNDSFD	 
			group by NHLinkID
            having count(*) > 1


			   										 

CREATE  NONCLUSTERED INDEX IX_TMP_OTCFUNDSFD 	on #OTCFUNDSFD (NHLinkID);	



-- Create Table

CREATE TABLE #BenefitDataPrep(	
	[mstrEligID] [bigint] NOT NULL,								
	[NHLinkID] [varchar](100) NOT NULL,									
	[InsCarrierID] [int] NULL,
	[InsHealthPlanID] [int] NULL,
	[BenefitType] [varchar](20) NULL,
	[BenefitSource] [varchar](20) NULL,
	[NBWalletCode] [nvarchar](30) NULL,
	[BenefitCategoryValue] [decimal](10, 2) NULL,
	[BenefitFrequencyMonths] [int] NULL,
	[BenefitStartDate] [date] NOT NULL,
	[BenefitEndDate] [date] NOT NULL,
	[ClientCode] [varchar](20) NULL,
	[LastName] [nvarchar](100) NULL,
	[BenefitCardNumber] [varchar](30) NULL									
	)

CREATE  NONCLUSTERED INDEX IX_TMP_BenefitDataPrep 	on #BenefitDataPrep (NHLinkID);	

          
		   
		   
		   INSERT INTO  #BenefitDataPrep
	       SELECT DISTINCT A.MemberDataID
			  ,A.NHLinkID 
			  ,A.[insCarrierID] 
			  ,A.[insHealthPlanID]			  
			  ,A.BenefitType			  
			  ,A.BenefitSource
			  ,BEN.NB_WalletCode [NBWalletCode]
			  ,BEN.[BenefitCategoryValue]
			  ,Ben.BenefitFrequencyMonths
			  ,A.BenefitStartDate
			  ,A.BenefitEndDate 
			  ,A.ClientCode
			  ,A.LastName
			  ,A.BenefitCardNumber           
			   From #OTCFUNDSFD	 A		    
			   JOIN (
			           select DISTINCT CarrierID,HealthPlanID,NB_WalletCode,[BenefitCategoryValue],BenefitFrequencyMonths, FIS_PurseName
					   from [flex].[FISWalletMapping] 
					   where isnull(isactive,0) =1 
					   AND FIS_PurseName is not null
					   AND Level1Clientid = @Level1Clientid 
					   and ClientCode = @ClientCode
					   -- and ISNULL(FIS_Status,'') = 'A'
					   -- AND @EligibleDate BETWEEN PurseStartDate and PurseEndDate
			        ) Ben ON Ben.CarrierID=A.insCarrierID  AND Ben.HealthPlanID=A.insHealthPlanID				   
			   WHERE 1=1
			   AND A.[NHLinkID] not IN ( SELECT NHLinkID from #dup_nh )
			 			

              


			
	    
--SELECT * FROM #BenefitDataPrep

       SET ROWCOUNT @LoadThresHold
   
		SELECT DISTINCT 			
			   BD.[mstrEligID] MemberDataID
			  ,BD.ClientCode
			  ,BD.[NHLinkid]
			  ,'FD' RecordType
			  --,BenLd.[MemberDataSource]
			  ,'elig' MemberDataSource
			  ,BD.[insCarrierID]
			  ,BD.[insHealthPlanID]
			  ,BD.BenefitType
			  ,BD.[BenefitSource]
			  ,BD.[NBWalletCode]
			  ,BD.[BenefitCategoryValue]
			  ,CASE WHEN (@Period BETWEEN 1 AND 12) AND (BD.BenefitEndDate > @MonthStartDate) Then @MonthStartDate	
					WHEN (@Period BETWEEN 21 AND 24) AND (BD.BenefitEndDate > @QuarterStartDate) Then @QuarterStartDate
		 			WHEN (@Period=0) AND (BD.BenefitEndDate > @AnnualStartDate) Then @AnnualStartDate
					WHEN (@Period BETWEEN 31 AND 32) AND (BD.BenefitEndDate > @HalfYearlyStartDate) Then @HalfYearlyStartDate
			   END BenefitValidFrom
			 ,CASE  WHEN (@Period BETWEEN 1 AND 12) AND (BD.BenefitEndDate > @MonthStartDate) Then @MonthEndDate		
					WHEN (@Period BETWEEN 21 AND 24) AND (BD.BenefitEndDate > @QuarterStartDate) Then @QuarterEndDate
		  			WHEN (@Period=0) AND (BD.BenefitEndDate > @AnnualStartDate) Then @AnnualEndDate
					WHEN (@Period BETWEEN 31 AND 32) AND (BD.BenefitEndDate > @HalfYearlyStartDate) Then @HalfYearlyEndDate
			  END BenefitValidTo
			  ,BD.BenefitFrequencyMonths
			  ,@Year BenefitYear
			  ,@Period BenefitPeriod
			  ,1 [isActive]
			  ,'Y' [RequestToBeProcessed]			  
			  ,BD.LastName			  
			  ,BD.BenefitCardNumber
		INTO #OTCFUNDSFDFreq
		FROM #BenefitDataPrep BD 
		--JOIN [otcfunds].[CardBenefitLoad_CI] BenLd WITH (NOLOCK) ON BD.NHLinkid=BenLd.NHLinkID AND ISNULL(BenLd.BenefitCardNumber,'') != '' AND BenLd.ClientCode = @ClientCode
		JOIN [otcfunds].[PeriodFrequencyMapping] FM WITH (NOLOCK) ON FM.Frequency=BD.BenefitFrequencyMonths
		WHERE FM.Period=@Period 		
		


		SET ROWCOUNT 0

		
	
	  --select * from #OTCFUNDSFDFreq 
	  	   
		INSERT INTO [otcfunds].[CardBenefitLoad_FD]
					   ([MemberDataID]
					   ,[ClientCode]
					   ,[NHLinkID]
					   ,[RecordType]
					   ,[MemberDataSource]
					   ,[InsCarrierID]
					   ,[InsHealthPlanID]
					   ,[BenefitType]
					   ,[BenefitSource]
					   ,[NBWalletCode]
					   ,[BenefitAmount]
					   ,[BenefitValidFrom]
					   ,[BenefitValidTo]
					   ,[BenefitFreqInMonth]
					   ,[BenefitYear]
					   ,[BenefitPeriod]
					   ,[IsActive]
					   ,[RequestToBeProcessed]
					   ,[LastName]
					   ,[BenefitCardNumber]
					   ,[ClientID]					  
					   ,[SubProgramID]
					   ,[PackageID]
					   ,[FIS_PurseSlot]
					   ,[Level1ClientId]
					   )
		SELECT DISTINCT 
						A.MemberDataID
					   ,A.[ClientCode]
					   ,A.[NHLinkID]
					   ,A.[RecordType]
					   ,A.[MemberDataSource]
					   ,A.[InsCarrierID]
					   ,A.[InsHealthPlanID]
					   ,A.[BenefitType]
					   ,A.[BenefitSource]
					   ,A.[NBWalletCode]
					   ,A.[BenefitCategoryValue]
					   ,A.[BenefitValidFrom]
					   ,A.[BenefitValidTo]
					   ,A.BenefitFrequencyMonths
					   ,A.BenefitYear
					   ,A.[BenefitPeriod]
					   ,A.[IsActive]
					   ,A.[RequestToBeProcessed]
					   ,A.[LastName]
					   ,A.[BenefitCardNumber]
					   ,ClientID = FDF.ClientID					  
					   ,SubProgramID = FDF.SubProgramID
					   ,PackageID = FDF.PackageID
					   ,FIS_PurseSlot =  FDF.FIS_PurseSlot 
					   ,@Level1Clientid
				FROM #OTCFUNDSFDFreq A 
				  JOIN (
							SELECT ClientID ,SubProgramID,PackageID = MAX(PackageID),CarrierID,HealthPlanID,NB_WalletCode,FIS_PurseSlot 
							FROM [flex].[FISWalletMapping] 
							WHERE 1=1
							AND FIS_PurseName is not null
							and Level1Clientid = @Level1Clientid
							AND ISNULL(IsActive,0) = 1--> Added is active condition				
							and ClientCode = @ClientCode
							-- and ISNULL(FIS_Status,'') = 'A'
							-- AND @EligibleDate BETWEEN PurseStartDate and PurseEndDate
							GROUP BY ClientID,SubProgramID,CarrierID,HealthPlanID ,NB_WalletCode,FIS_PurseSlot	  
				     ) FDF ON  A.InsCarrierID = FDF.CarrierID AND A.InsHealthPlanID = FDF.HealthPlanID 	AND A.NBWalletCode = FDF.NB_WalletCode
					 Where NOT EXISTS ( 
					                      SELECT NHLinkID 
										  FROM [otcfunds].[CardBenefitLoad_FD] CL 
					                      where CL.NHLinkID = A.NHLinkid and CL.RecordType='FD' 
										  AND CL.BenefitYear = @Year AND CL.BenefitPeriod = @Period AND CL.BenefitPeriod = A.BenefitPeriod AND CL.BenefitYear = A.BenefitYear 
										  and cl.MemberDataSource = 'elig' --AND CL.ResponseRecordStatus = 'SUCCESS'
										  and CL.ClientCode = @ClientCode 
										  and CL.Level1Clientid = @Level1Clientid
										  AND (   
													   (CL.RequestRecordStatus = 'SUCCESS' AND CL.ResponseRecordStatus IS NULL)  -- If value load request sent but waiting for response 
													or (CL.RequestRecordStatus = 'SUCCESS' AND CL.ResponseRecordStatus = 'SUCCESS') -- If value load is already sent and processed do not load again
													or (CL.RequestRecordStatus IS NULL AND CL.RequestToBeProcessed = 'Y') -- value load to be processed set as Y but request not yet sent to FIS
											  )
									 )
					 AND (A.BenefitValidTo IS NOT NULL AND A.BenefitValidFrom IS NOT NULL)
					 and FDF.FIS_PurseSlot IS NOT NULL -- Enable for FD  As above condition OUTER APPLY to CROSS APPLY we dont need this condition
	 
	 exec [flex].[sp_FIS_FundDisbursement_Credits]

DROP TABLE IF EXISTS #OTCFUNDSFD
DROP TABLE IF EXISTS #OTCFUNDSFDFreq 
DROP TABLE IF EXISTS #BenefitDataPrep
drop table if EXISTS #dup_nh



COMMIT TRANSACTION FISFundDisbursementDP
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION FISFundDisbursementDP 
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(); 
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Load_Log_FileBatchDetail]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
--EXEC [flex].[sp_ssis_Load_Log_FileBatchDetail] 279


MODIFICATIONS                              
 Initials		Date					Modification                              
------------------------------------------------------------   
 Srikanth       2022-10-07              Included Record Type 33 to pass Discretionary Data 1 for Aetna COVID V2  

*/                     
CREATE PROC [flex].[sp_ssis_Load_Log_FileBatchDetail]
(
	@FileTrackId INT
)
AS
BEGIN
SET NOCOUNT ON 
BEGIN TRY
BEGIN TRANSACTION RetrunFileInsert
drop table if exists #Batch_Seq_Process

Create table #Batch_Seq_Process 
(
 Id INT identity (1,1)
,BatchSeq varchar(6)
,[20_Record_Start_Position] INT
,[80_Record_Start_Position] INT
)


DECLARE
  @Counter int=1
 ,@Max_Row int=0
 ,@BatchHeaderTrailerId BIGINT 
 ,@FileHeaderTrailerId_For10 BIGINT
 ,@FileHeaderTrailerId_For90 BIGINT
 ,@Is_CI_Record INT=NULL
 select distinct @Is_CI_Record=  left(RecordData,2) from flex.StgReturnFileData where left(RecordData,2)in (30,60) and FileTrackID=@FileTrackId

---------------------File Header Insert ---------------------------------------
Insert Into flex.FileHeaderTrailer
(
	FileTrackID
	,RecordType
	,FileDate
	,FileTime
	,CompanyId
	,Version
	,LogFileIndicator
	,TestProdIndicator
	,Reserved
	,ProcessDate
	,ProcessTime
	,ClientLookup
	,HeaderFiller1
	,ProxyLookup
	,CompanyIdExtended
	,HeaderFiller2
	,Direction
	,CombinedRecord
	,ModifyDate
)
SELECT  
@FileTrackId
,RecordType
,FileDate
,FileTime
,CompanyID
,Version
,LogFileIndicator
,TestProdIndicator
,Reserved
,ProcessDate
,ProcessTime
,ClientLookup
,HeaderFiller1
,ProxyLookup
,CompanyIDExtended
,HeaderFiller2
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.RecordData  
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=10 and p.RecordType=10 and t.FileTrackID=@FileTrackId
)as Header
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (		RecordType
,FileDate
,FileTime
,CompanyID
,Version
,LogFileIndicator
,TestProdIndicator
,Reserved
,ProcessDate
,ProcessTime
,ClientLookup
,HeaderFiller1
,ProxyLookup
,CompanyIDExtended
,HeaderFiller2
 )
) AS Pvt
select @FileHeaderTrailerId_For10=@@identity
---------------------File Trailer Insert --------------------------------------- 
Insert Into flex.FileHeaderTrailer
(
	FileTrackID
	,RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
	,Direction
	,CombinedRecord
	,ModifyDate
)
select 
@FileTrackId
	,RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
	,'IN'
	,RecordData
	,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM 
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.RecordData 
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=90 and p.RecordType=90 and t.FileTrackID=@FileTrackId
) AS Trailer
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	
  RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
 )
) AS Pvt
select @FileHeaderTrailerId_For90=@@identity

INSERT INTO #Batch_Seq_Process
(
 BatchSeq
,[20_Record_Start_Position] 
,[80_Record_Start_Position] 
)
SELECT 
	 BatchSeq
	,[20] as [20_Record_Start_Position]
	,[80] as [80_Record_Start_Position] 
FROM
(
select
SUBSTRING(t.[RecordData],A.StartPosition,((A.EndPosition+1)-A.StartPosition)) as BatchSeq
,A.RecordType,t.StgReturnFileDataID
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.[FISFieldStartEndPositions] p WHERE FieldName='BatchSequence'
and p.recordType=left(t.RecordData,2) and t.FileTrackID=@FileTrackId
and p.RecordType in (20,80)) A
) as Loop
PIVOT
(
MAX([StgReturnFileDataID]) FOR [RecordType] in 
 (
 [20],[80]

  )
) AS Pvt
--select * from #Batch_Seq_Process
select @Max_Row=MAX(Id)From #Batch_Seq_Process

WHILE (@Counter<=@Max_Row)

Begin
Declare @Batch_Seq INT,@20_Record_Start_Position INT,@80_Record_Start_Position INT
select @Batch_Seq = BatchSeq From #Batch_Seq_Process where Id=@Counter
select @20_Record_Start_Position = [20_Record_Start_Position] From #Batch_Seq_Process where Id=@Counter
select @80_Record_Start_Position = [80_Record_Start_Position] From #Batch_Seq_Process where Id=@Counter

-----------Batch Header Insertion---------------------------------------

INSERT INTO [flex].[BatchHeaderTrailer]
(
FileHeaderTrailerId
,RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,CombinedRecord
,Direction
,RefBatchHeaderTrailerID
,ModifyDate
)
	SELECT 
@FileHeaderTrailerId_For10  
,RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,RecordData
,'IN'
,RefBatchHeaderTrailer
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
From(
Select 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=20 and p.RecordType=20 and t.StgReturnFileDataId=@20_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as Header
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (
RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,CombinedRecord
,RefBatchHeaderTrailer
  )
) AS Pvt

select @BatchHeaderTrailerId= @@IDENTITY 

-----------Insertion for 30 Record ---------------------------------------
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
	 @BatchHeaderTrailerId
,RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=30 and p.RecordType=30 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 

 )
) AS Pvt
End

-----------Insertion for 31 Record ---------------------------------------
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
	 @BatchHeaderTrailerId
,RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=31 and p.RecordType=31 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
 RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage  

 )
) AS Pvt
End



-----------Insertion for 33 Record --------------------------------------- Included by SD on 2022-10-07 to pass Discretionary Data 1 for Aetna COVID V2
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
@BatchHeaderTrailerId
,RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=33 and p.RecordType=33 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
 RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 

 )
) AS Pvt
End







-----------Insertion for 60 Record ---------------------------------------
if @Is_CI_Record=60
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)
select
 @BatchHeaderTrailerId
,RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.StgReturnFileDataId ,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=60 and P.RecordType=60 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.FileTrackId=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
 )
) AS Pvt
End
-----------Batch  Trailer Insertion---------------------------------------

INSERT INTO [flex].[BatchHeaderTrailer]
(
FileHeaderTrailerId  
,RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,Direction
,CombinedRecord
,ModifyDate
)

select 
	@FileHeaderTrailerId_for90
,RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM 
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(RecordData,2)=80 and RecordType=80  and t.stgreturnfiledataid=@80_Record_Start_Position
and t.FileTrackId=@FileTrackId
) AS Trailer
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	
RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller

  )
) AS Pvt
set @Counter=@Counter+1
END
COMMIT TRANSACTION RetrunFileInsert
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION RetrunFileInsert
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(); 
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
drop table if exists #Batch_Seq_Process
END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Load_Log_FileBatchDetail_bkp_08092023]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
--EXEC [flex].[sp_ssis_Load_Log_FileBatchDetail] 279


MODIFICATIONS                              
 Initials		Date					Modification                              
------------------------------------------------------------   
 Srikanth       2022-10-07              Included Record Type 33 to pass Discretionary Data 1 for Aetna COVID V2  

*/                     
CREATE PROC [flex].[sp_ssis_Load_Log_FileBatchDetail_bkp_08092023]
(
	@FileTrackId INT
)
AS
BEGIN
SET NOCOUNT ON 
BEGIN TRY
BEGIN TRANSACTION RetrunFileInsert
drop table if exists #Batch_Seq_Process

Create table #Batch_Seq_Process 
(
 Id INT identity (1,1)
,BatchSeq varchar(6)
,[20_Record_Start_Position] INT
,[80_Record_Start_Position] INT
)


DECLARE
  @Counter int=1
 ,@Max_Row int=0
 ,@BatchHeaderTrailerId BIGINT 
 ,@FileHeaderTrailerId_For10 BIGINT
 ,@FileHeaderTrailerId_For90 BIGINT
 ,@Is_CI_Record INT=NULL
 select distinct @Is_CI_Record=  left(RecordData,2) from flex.StgReturnFileData where left(RecordData,2)in (30,60) and FileTrackID=@FileTrackId

---------------------File Header Insert ---------------------------------------
Insert Into flex.FileHeaderTrailer
(
	FileTrackID
	,RecordType
	,FileDate
	,FileTime
	,CompanyId
	,Version
	,LogFileIndicator
	,TestProdIndicator
	,Reserved
	,ProcessDate
	,ProcessTime
	,ClientLookup
	,HeaderFiller1
	,ProxyLookup
	,CompanyIdExtended
	,HeaderFiller2
	,Direction
	,CombinedRecord
	,ModifyDate
)
SELECT  
@FileTrackId
,RecordType
,FileDate
,FileTime
,CompanyID
,Version
,LogFileIndicator
,TestProdIndicator
,Reserved
,ProcessDate
,ProcessTime
,ClientLookup
,HeaderFiller1
,ProxyLookup
,CompanyIDExtended
,HeaderFiller2
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.RecordData  
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=10 and p.RecordType=10 and t.FileTrackID=@FileTrackId
)as Header
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (		RecordType
,FileDate
,FileTime
,CompanyID
,Version
,LogFileIndicator
,TestProdIndicator
,Reserved
,ProcessDate
,ProcessTime
,ClientLookup
,HeaderFiller1
,ProxyLookup
,CompanyIDExtended
,HeaderFiller2
 )
) AS Pvt
select @FileHeaderTrailerId_For10=@@identity
---------------------File Trailer Insert --------------------------------------- 
Insert Into flex.FileHeaderTrailer
(
	FileTrackID
	,RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
	,Direction
	,CombinedRecord
	,ModifyDate
)
select 
@FileTrackId
	,RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
	,'IN'
	,RecordData
	,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM 
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.RecordData 
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=90 and p.RecordType=90 and t.FileTrackID=@FileTrackId
) AS Trailer
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	
  RecordType
	,TotalRecords
	,BatchCount
	,DetailCount
	,TotalCredit
	,TotalDebit
	,TotalProcessed
	,TotalRejected
	,ValueProcessed
	,ValueRejected
	,TotalCashout
	,TotalEscheated
	,TrailerFiller
 )
) AS Pvt
select @FileHeaderTrailerId_For90=@@identity

INSERT INTO #Batch_Seq_Process
(
 BatchSeq
,[20_Record_Start_Position] 
,[80_Record_Start_Position] 
)
SELECT 
	 BatchSeq
	,[20] as [20_Record_Start_Position]
	,[80] as [80_Record_Start_Position] 
FROM
(
select
SUBSTRING(t.[RecordData],A.StartPosition,((A.EndPosition+1)-A.StartPosition)) as BatchSeq
,A.RecordType,t.StgReturnFileDataID
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.[FISFieldStartEndPositions] p WHERE FieldName='BatchSequence'
and p.recordType=left(t.RecordData,2) and t.FileTrackID=@FileTrackId
and p.RecordType in (20,80)) A
) as Loop
PIVOT
(
MAX([StgReturnFileDataID]) FOR [RecordType] in 
 (
 [20],[80]

  )
) AS Pvt
--select * from #Batch_Seq_Process
select @Max_Row=MAX(Id)From #Batch_Seq_Process

WHILE (@Counter<=@Max_Row)

Begin
Declare @Batch_Seq INT,@20_Record_Start_Position INT,@80_Record_Start_Position INT
select @Batch_Seq = BatchSeq From #Batch_Seq_Process where Id=@Counter
select @20_Record_Start_Position = [20_Record_Start_Position] From #Batch_Seq_Process where Id=@Counter
select @80_Record_Start_Position = [80_Record_Start_Position] From #Batch_Seq_Process where Id=@Counter

-----------Batch Header Insertion---------------------------------------

INSERT INTO [flex].[BatchHeaderTrailer]
(
FileHeaderTrailerId
,RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,CombinedRecord
,Direction
,RefBatchHeaderTrailerID
,ModifyDate
)
	SELECT 
@FileHeaderTrailerId_For10  
,RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,RecordData
,'IN'
,RefBatchHeaderTrailer
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
From(
Select 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=20 and p.RecordType=20 and t.StgReturnFileDataId=@20_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as Header
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (
RecordType
,BatchSequence
,ClientID
,SubprogramID
,PackageID
,CompanyCode
,SortCode
,ShippingAddressee
,ShippingAddress1
,ShippingAddress2
,ShippingCity
,HeaderFiller1
,ShippingState
,ShippingZip
,ShippingCountryCode
,ShippingAttention
,UserOnly
,SpecialDuplicateProcessing
,ProxyIndicatorProcessing
,GroupDemographicUpdateIndicator
,SpecialProcessingIndicators
,BulkShippingPhoneNumber
,PhoneFormatOverride
,GenerateOrderID
,GenerateClientUniqueID
,ClientIDExtended
,SubprogramIDExtended
,PackageIDExtended
,ShippingAddress1extended
,ShippingAddress2extended
,PhysicalExpirationinMonths
,HeaderFiller2
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,CombinedRecord
,RefBatchHeaderTrailer
  )
) AS Pvt

select @BatchHeaderTrailerId= @@IDENTITY 

-----------Insertion for 30 Record ---------------------------------------
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
	 @BatchHeaderTrailerId
,RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=30 and p.RecordType=30 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
RecordType
,ActionType
,FirstName
,MiddleInitial
,LastName
,Suffix
,SSN
,MailingAddr1
,MailingAddr2
,MailingCity
,MailingState
,MailingPostalCode
,MailingCountryCode
,HomeNumber
,DeliveryMethod 
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,Filler
,CardRecordStatusCode 
,ProcessingMessage 

 )
) AS Pvt
End

-----------Insertion for 31 Record ---------------------------------------
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
	 @BatchHeaderTrailerId
,RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=31 and p.RecordType=31 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
 RecordType
,ActionType
,LastName
,SSN
,DOB
,MothersMaidenName
,Filler_1_31
,EmailAddress
,OtherInformation
,Filler_2_31
,FourthLine
,NameonCard
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,[ClientUniquePersonIdentifier/FISPersonIdentifier]
,DeliveryMethod
,Filler
,CardRecordStatusCode
,ProcessingMessage  

 )
) AS Pvt
End



-----------Insertion for 33 Record --------------------------------------- Included by SD on 2022-10-07 to pass Discretionary Data 1 for Aetna COVID V2
If @Is_CI_Record=30
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)

select
@BatchHeaderTrailerId
,RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=33 and p.RecordType=33 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.Filetrackid=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
 RecordType
,ActionType
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,LastName
,SSN
,DiscretionaryData1
,DiscretionaryData2
,DiscretionaryData3
,OrderID
,Filler
,CardRecordStatusCode
,ProcessingMessage 

 )
) AS Pvt
End







-----------Insertion for 60 Record ---------------------------------------
if @Is_CI_Record=60
Begin
Insert into [flex].[DetailRecord]
(
BatchHeaderTrailerId
,RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
,Direction
,CombinedRecord
,ModifyDate
,ModifyUser
)
select
 @BatchHeaderTrailerId
,RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,SYSTEM_USER
From (
SELECT  
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value]
		,t.StgReturnFileDataId ,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(t.RecordData,2)=60 and P.RecordType=60 and t.StgReturnFileDataId>@20_Record_Start_Position and t.StgReturnFileDataId<@80_Record_Start_Position
and t.FileTrackId=@FileTrackId
)as CI_Details
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	 
RecordType
,ActionType
,ClientReferenceNumber
,LastName
,SSN
,ApplyDate
,PaymentAmount
,PromoCode
,[PAN/Proxy/ClientUniqueID/DirectAccess]
,AdditionalInfo1
,AdditionalInfo2
,Comment
,SetCardAssigned
,LoaduponActivation
,TransactionLogID
,Filler
,CardRecordStatusCode
,ProcessingMessage
 )
) AS Pvt
End
-----------Batch  Trailer Insertion---------------------------------------

INSERT INTO [flex].[BatchHeaderTrailer]
(
FileHeaderTrailerId  
,RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,Direction
,CombinedRecord
,ModifyDate
)

select 
	@FileHeaderTrailerId_for90
,RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller
,'IN'
,RecordData
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
FROM 
(SELECT 
		p.FieldName
		,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
		,t.StgReturnFileDataId,t.RecordData
FROM [flex].[StgReturnFileData] t 
CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
WHERE LEFT(RecordData,2)=80 and RecordType=80  and t.stgreturnfiledataid=@80_Record_Start_Position
and t.FileTrackId=@FileTrackId
) AS Trailer
PIVOT 
(
 MAX([Value]) FOR [FieldName] in 
 (	
RecordType
,BatchSequence
,TotalRecords
,TotalCredit
,TotalDebit
,TotalProcessed
,TotalRejected
,ValueProcessed
,ValueRejected
,TotalCashout
,TotalEscheated
,OrderID
,TrailerFiller

  )
) AS Pvt
set @Counter=@Counter+1
END
COMMIT TRANSACTION RetrunFileInsert
END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION RetrunFileInsert
	    DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
        @ErrorMessage = ERROR_MESSAGE(),
        @ErrorSeverity = ERROR_SEVERITY(),
        @ErrorState = ERROR_STATE(); 
		RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);
END CATCH
drop table if exists #Batch_Seq_Process
END
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Load_Txt_FileBatchDetail]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
																														
				 
  -- EXEC [flex].[sp_ssis_Load_Txt_FileBatchDetail] 49722 -- CI
  -- EXEC [flex].[sp_ssis_Load_Txt_FileBatchDetail] 148 -- FD	
  
  -- EXEC [flex].[sp_ssis_Load_Txt_FileBatchDetail] 246 -- CI	
  -- EXEC [flex].[sp_ssis_Load_Txt_FileBatchDetail] 3042 -- DF						
  
CREATE PROCEDURE [flex].[sp_ssis_Load_Txt_FileBatchDetail]( @FileTrackID bigint )
AS
-- Date				User				Description
-- 2021-08-23		Meenkumar			This Procedure is used for create flex Outbound file
-- Purse slot missing during top up's

BEGIN

DROP TABLE  IF EXISTS #FileHeaderTrailer
DROP TABLE  IF EXISTS #BatchHeaderTrailer
--DECLARE @FileTrackID bigint=1

DECLARE @FileSnapshotFlag varchar(10);
set @FileSnapshotFlag = (select SnapshotFlag from otcfunds.FileTrack where FileTrackID = @FileTrackID)
--print @FileSnapshotFlag;

SELECT CombinedRecord
,FileTrackID
,RecordType
,FileHeaderTrailerId 
INTO #FileHeaderTrailer 
FROM flex.FileHeaderTrailer 
WHERE FileTrackID =@FileTrackID

SELECT 
 BHTCombinedRecord=bht.CombinedRecord
,bht.BatchHeaderTrailerId
,BHTRecordType=bht.RecordType
,fhtCombinedRecord=fht.CombinedRecord
,fhtRecordType = fht.RecordType
,fhtFileHeaderTrailerId=fht.FileHeaderTrailerId
,bht.BatchSequence
INTO #BatchHeaderTrailer
FROM flex.BatchHeaderTrailer bht
INNER JOIN #FileHeaderTrailer fht
ON bht.FileHeaderTrailerId = fht.FileHeaderTrailerId


IF ( @FileSnapshotFlag IN ('CI','AU','OI') )
BEGIN

	SELECT CombinedRecord 
	FROM (
				SELECT CombinedRecord
					  ,RecordType
					  ,BatchSequence=CASE WHEN RecordType=10 THEN -1 
										  WHEN RecordType=90 THEN 999999999999 
										  END
					  ,CardBenefitLoadId=CASE WHEN RecordType=10 THEN -1 
										  WHEN RecordType=90 THEN 999999999999 
										  END 
				FROM #FileHeaderTrailer 

				UNION ALL

				SELECT BHTCombinedRecord
					  ,BHTRecordType
					  ,BatchSequence
					  ,CardBenefitLoadId=CASE WHEN BHTRecordType=20 THEN 0 
										  WHEN BHTRecordType=80 THEN 999999999998 
										  END  				  
				FROM #BatchHeaderTrailer 

				UNION ALL

				SELECT TOP 99999999999999999 dt.CombinedRecord
					   ,dt.RecordType
					   ,bt.BatchSequence
					   ,dt.CardBenefitLoadId
				FROM #BatchHeaderTrailer bt
				INNER JOIN flex.DetailRecord dt
				ON bt.BatchHeaderTrailerId=dt.BatchHeaderTrailerId
	 
				--ORDER BY CardBenefitLoadId, RecordType, BatchSequence

	) t ORDER BY BatchSequence,CardBenefitLoadId, RecordType

	--) t ORDER BY  BatchSequence, RecordType,CardBenefitLoadId
END


--IF ( @FileSnapshotFlag = 'FD')
IF ( @FileSnapshotFlag IN ('FD','DF') )
BEGIN

	SELECT CombinedRecord 
	FROM (
				SELECT CombinedRecord
					  ,RecordType
					  ,BatchSequence=CASE WHEN RecordType=10 THEN -1 
										  WHEN RecordType=90 THEN 999999999999 
										  END
					  ,CardBenefitLoadId=CASE WHEN RecordType=10 THEN -1 
										  WHEN RecordType=90 THEN 999999999999 
										  END 
				FROM #FileHeaderTrailer 

				UNION ALL

				SELECT BHTCombinedRecord
					  ,BHTRecordType
					  ,BatchSequence
					  ,CardBenefitLoadId=CASE WHEN BHTRecordType=20 THEN 0 
										  WHEN BHTRecordType=80 THEN 999999999998 
										  END  				  
				FROM #BatchHeaderTrailer 

				UNION ALL

				SELECT TOP 99999999999999999 dt.CombinedRecord
					   ,dt.RecordType
					   ,bt.BatchSequence
					   ,dt.CardBenefitLoadId
				FROM #BatchHeaderTrailer bt
				INNER JOIN flex.DetailRecord dt
				ON bt.BatchHeaderTrailerId=dt.BatchHeaderTrailerId
	 
				--ORDER BY CardBenefitLoadId, RecordType, BatchSequence

	--) t ORDER BY CardBenefitLoadId, RecordType, BatchSequence

	) t ORDER BY  BatchSequence, RecordType,CardBenefitLoadId
END

END

GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Update_Log_FileBatchDetail]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******                              
NAME: [flex].[sp_ssis_Update_Log_FileBatchDetail]
                             
DESCRIPTION : To update flags in all the flex tables. once we recevied retrun file from flex.                         
				
INPUT PARAMETERS:                              
 Name				DataType	Default Description                              
--------------------------------------------------------------------------                              
 @FileTrackId		int                           
          
OUTPUT PARAMETERS:                              
 Name     DataType  Default Description                              
------------------------------------------------------------                              
                               
USAGE EXAMPLES:                              
------------------------------------------------------------                              
  BEGIN TRAN          

 EXEC [flex].[sp_ssis_Update_Log_FileBatchDetail] @FileTrackId=57               
                           
AUTHOR INITIALS:                              
 Initials		Name                              
------------------------------------------------------------                              
 SC				Sreenivasulu Cheerala                        
                               
MODIFICATIONS                              
 Initials		Date					Modification                              
------------------------------------------------------------                              
 SC				2021-August-23			Initial Creation.  
 Srikanth       2021-November           changes made to card number update scripts  
 Srikanth       2021-December           Member ProxyNumber (otcfunds.CardBenefitLoad.BenefitCardNumber) should be updated in member.MemberCards.CardReferenceNumber instead of Master.Memberinsurancedetails.OTCSerialNumber     
 Srikanth       2022-02-23              CardIssue refactor - CI update statements has been changed to update table otcfunds.CardBenefitLoad_CI  
 Srikanth       2022-02-27              CardIssue refactor - FD update statements has been changed to update table otcfunds.CardBenefitLoad_FD    
 Srikanth       2022-04-20              Address Update - @Is_CI_Record updated to include RT 30 & AT 02 
 Srikanth		2023-09-08				Address Update - Failure file update overwriting Card Issue Records
 Meenkumar		2023-09-13				UID is updated to OtherInformation in CI to support new card and update existing card with UID
          
******/
CREATE PROC [flex].[sp_ssis_Update_Log_FileBatchDetail]
(
 @FileTrackId int 
,@OutBound_FileTrackId INT=NULL
)
AS
BEGIN


		SET NOCOUNT ON 
		BEGIN TRY  
		BEGIN TRANSACTION RefFileTrackIdsUpd  

		Declare @Is_CI_Record INT=NULL
		--,@IN_FileHeaderId BIGINT,@OUT_FileHeaderId BIGINT,@IN_FileTrailerId BIGINT,@OUT_FileTrailerId BIGINT
		,@Is_99_Record_Exists BIT=0

		--Select @IN_FileHeaderId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@FileTrackId and Fht.RecordType=10
		--Select @OUT_FileHeaderId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@OutBound_FileTrackId and Fht.RecordType=10
		--Select @IN_FileTrailerId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@FileTrackId and Fht.RecordType=90
		--Select @OUT_FileTrailerId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@OutBound_FileTrackId and Fht.RecordType=90
		select distinct @Is_CI_Record =  left(RecordData,4) from flex.StgReturnFileData where left(RecordData,2)in (30,60) And FileTrackId=@FileTrackId

		--------------------------------Insert Into [flex].[FileFailure]--------------------------
		Insert INTO [flex].[FileFailure]
		(
		FileTrackID
		,RecordType
		,Filler
		,ProcessingMessage
		,CombinedRecord
		,ProcessDate
		,ProcessTime
		,FileRecordStatusCode
		,RefFileTrackId
		,ModifyDate
		)
		select 
		@FileTrackId
		,RecordType
		,Filler
		,ProcessingMessage
		,RecordData
		,ProcessDate
		,ProcessTime
		,Left(Ltrim(Rtrim(ProcessingMessage)),3) FileRecordStatusCode
		,@OutBound_FileTrackId
		,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
		FROM 
		(SELECT 
				p.FieldName
				,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
				,t.StgReturnFileDataId,t.RecordData
		FROM [flex].[StgReturnFileData] t 
		CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
		WHERE LEFT(t.RecordData,2)=99 and p.RecordType=99 and t.Filetrackid=@FileTrackId
		) AS Trailer
		PIVOT 
		(
		 MAX([Value]) FOR [FieldName] in 
		 (	
		 RecordType
		,ProcessDate
		,ProcessTime
		,Filler
		,ProcessingMessage
		   )
		) AS Pvt
		Where Exists (select 1 from flex.StgReturnFileData where left(RecordData,2)=99 and FileTrackId=@FileTrackId)

		Insert INTO [flex].[FileFailureDetail]
		(
		[RefFileFailureID]
		,FileTrackID
		,RecordType
		,Filler
		,ProcessingMessage
		,CombinedRecord
		,ProcessDate
		,ProcessTime
		,FileRecordStatusCode
		,RefFileTrackId
		,ModifyDate
		)
		select DISTINCT
		f.FileFailureID
		,@FileTrackId
		,RecordType
		,Filler
		,ProcessingMessage
		,a.RecordData
		,ProcessDate
		,ProcessTime
		,Left(Ltrim(Rtrim(ProcessingMessage)),3) FileRecordStatusCode
		,@OutBound_FileTrackId
		,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
		FROM 
		(SELECT 
				t.FileTrackID,t.RecordData
		FROM [flex].[StgReturnFileData] t 
		CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
		WHERE LEFT(t.RecordData,2)!=99 and p.RecordType!=99 and t.Filetrackid=@FileTrackId
		)a
		JOIN [flex].[FileFailure] f on f.FileTrackID = a.FileTrackID
		Where Exists (select 1 from flex.StgReturnFileData where left(RecordData,2)=99 and FileTrackId=@FileTrackId)


		select @Is_99_Record_Exists=1 Where Exists (select 1 from flex.StgReturnFileData where left(RecordData,2)=99 And FileTrackId=@FileTrackId)

		-- Update Card Issue file failure on log file
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.CardBenefitLoad_CI Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END


		    -- Update Fund Disbursement file failure on log file
		    ELSE If ( @Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null


					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.CardBenefitLoad_FD Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
					
			END

         /*
		-- Update Address update file failure on log file -- added by SD by 2023-09-08
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.MemberAddressChange Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END
			*/


			/*
		-- Update UID response file failure on log file -- added by SD by 2023-09-13
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From [otcfunds].[CardBenefitLoad_CI_UID] Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoad_UID_ID=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END
			*/



			Else IF @Is_99_Record_Exists=0

			Begin


		            -- Card Issue Response Update
					If @Is_CI_Record = 3001
							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,Ot.[PAN/Proxy/ClientUniqueID/DirectAccess]=Inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 
								flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								--and @Is_CI_Record=30 
								and Bhtin.BatchSequence=Bhtot.BatchSequence


								/* Update BenefitCardNumber in otcfunds.CardBenefitLoad_CI*/
								update cbl 
								set cbl.BenefitCardNumber=LTRIM(RTRIM(drout.[PAN/Proxy/ClientUniqueID/DirectAccess]))
								,cbl.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,cbl.ResponseProcessedFileID=@FileTrackId 
								,cbl.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,cbl.ResponseRecordStatusCode=drout.CardRecordStatusCode
								,cbl.FirstTimeCardIssued = 'Y'
								FROM otcfunds.CardBenefitLoad_CI cbl
								inner join flex.DetailRecord drout
								ON cbl.CardBenefitLoadID=drout.CardBenefitLoadID and drout.RecordType = 30  and drout.ActionType = 1  
								--inner join flex.DetailRecord  drin
								--ON drout.RefDetailRecordID=drin.DetailRecordID
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								--and Drin.Direction='IN'
								and cbl.RecordType='CI'
								and cbl.BenefitCardNumber IS NULL
								and fht.FileTrackID = @OutBound_FileTrackId
								and cbl.RequestProcessedFileID = @OutBound_FileTrackId
								--And @Is_CI_Record=30

						
								/* Update BenefitCardNumber in elig.mstrEligBenefitData*/
								/*  Commented NOV 2022 
								Update mebd
								set mebd.BenefitCardNumber=cbl.BenefitCardNumber
								--,mebd.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								--,Mebd.ModifyUser=SYSTEM_USER
								From elig.mstrEligBenefitData mebd 
								Inner join otcfunds.CardBenefitLoad_CI cbl	ON 
								--mebd.NHLinkid=cbl.NHlinkId and 
								cbl.MemberDataID = mebd.mstrEligID
								where cbl.RecordType='CI'
								and cbl.MemberDataSource='ELIG'
								and cbl.BenefitCardNumber IS NOT NULL
								and (mebd.BenefitCardNumber IS NULL or mebd.BenefitCardNumber = '')
								and cbl.RequestProcessedFileID = @OutBound_FileTrackId
								and ISNULL(cbl.BenefitCardNumber,'') != ''
                                 */
								 

								 /*
								 Update bcm
                                set bcm.BenefitCardNumber=cbl.BenefitCardNumber
                                ,bcm.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
                                ,bcm.ModifyUser=SYSTEM_USER
                                From [otcfunds].[BenefitCardMapping] bcm
                                Inner join otcfunds.CardBenefitLoad_CI cbl    ON                               
                                bcm.BenefitCardMappingID = cbl.BenefitCardMappingID AND bcm.NHLinkID = cbl.NHLinkID
                                where cbl.RecordType='CI'
                                and cbl.MemberDataSource='ELIG'
                                and cbl.BenefitCardNumber IS NOT NULL
                                and (bcm.BenefitCardNumber IS NULL or bcm.BenefitCardNumber = '')
                                and cbl.RequestProcessedFileID = @OutBound_FileTrackId
                                and ISNULL(cbl.BenefitCardNumber,'') != ''

								 -- Multiple PAN Proxy not allowed yet
								-- Insert/Update PAN Proxy number to membercards from card issue table
								MERGE member.MemberCards mc
								USING ( 
										/*
										SELECT mi.InsuranceCarrierID, mi.InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber								
										FROM master.MemberInsurances mi
										INNER JOIN master.Members m ON m.MemberID = mi.MemberID
										*/
										SELECT mstr.insCarrierID InsuranceCarrierID, mstr.insHealthPlanID InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber
										,cbl.Level1ClientID
										FROM master.Members m 
										--INNER JOIN elig.mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID 
										INNER JOIN elig.vw_mstrEligBenefitData mstr ON mstr.MasterMemberID = m.MemberID  										
										INNER JOIN otcfunds.CardBenefitLoad_CI cbl ON cbl.MemberDataID = mstr.mstrEligID
										where cbl.RecordType='CI'
										AND cbl.BenefitCardNumber IS NOT NULL								
										AND cbl.RequestProcessedFileID = @OutBound_FileTrackId
										AND ISNULL(cbl.BenefitCardNumber,'') != ''
										and cbl.InsCarrierID not in (417,418,419,420,445)
									 ) prxy
								ON (mc.CardReferenceNumber = prxy.BenefitCardNumber AND mc.CardVendor= 'fis' AND mc.CardType = 'BenefitCard' AND mc.CardReferenceNumberType = 'ProxyId')

								WHEN MATCHED AND (prxy.InsuranceCarrierID != mc.InsuranceCarrierID OR prxy.InsuranceHealthPlanID != mc.InsuranceHealthPlanID OR prxy.NHMemberID != mc.NHMemberID) THEN

								UPDATE SET mc.InsuranceCarrierID = prxy.InsuranceCarrierID,
											mc.InsuranceHealthPlanID = prxy.InsuranceHealthPlanID,
											mc.NHMemberID = prxy.NHMemberID,
											mc.ModifyUser = SYSTEM_USER,
											mc.ModifyDate = GETDATE(),
											mc.[Source] = 'FIS'

								WHEN NOT MATCHED BY TARGET THEN

								INSERT (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate, CardIssuer,Level1ClientID)
								VALUES (prxy.InsuranceCarrierID, prxy.InsuranceHealthPlanID, prxy.NHMemberID, prxy.BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE()
										,CASE WHEN prxy.Level1ClientID = 718967 THEN 'METABANK'
											  WHEN prxy.Level1ClientID = 995407 THEN 'BANCORP'
											  ELSE 'BANCORP' END
										,Level1ClientID
									   );
                                



								/*
								MERGE member.MemberCards mc
								USING ( SELECT mi.InsuranceCarrierID, mi.InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber								
										FROM master.MemberInsurances mi
										INNER JOIN master.Members m ON m.MemberID = mi.MemberID
										--INNER JOIN elig.mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID 
                                        INNER JOIN elig.vm_mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID  										
										INNER JOIN otcfunds.CardBenefitLoad_CI cbl ON cbl.MemberDataID = mstr.mstrEligID
										where cbl.RecordType='CI'
										AND cbl.BenefitCardNumber IS NOT NULL								
										AND cbl.RequestProcessedFileID = @OutBound_FileTrackId
										AND ISNULL(cbl.BenefitCardNumber,'') != ''
										) prxy
								ON (mc.CardReferenceNumber = prxy.BenefitCardNumber AND mc.CardVendor= 'fis' AND mc.CardType = 'BenefitCard' AND mc.CardReferenceNumberType = 'ProxyId')

								WHEN MATCHED AND (prxy.InsuranceCarrierID != mc.InsuranceCarrierID OR prxy.InsuranceHealthPlanID != mc.InsuranceHealthPlanID OR prxy.NHMemberID != mc.NHMemberID) THEN

								UPDATE SET mc.InsuranceCarrierID = prxy.InsuranceCarrierID,
											mc.InsuranceHealthPlanID = prxy.InsuranceHealthPlanID,
											mc.NHMemberID = prxy.NHMemberID,
											mc.ModifyUser = SYSTEM_USER,
											mc.ModifyDate = GETDATE(),
											mc.[Source] = 'FIS'

								WHEN NOT MATCHED BY TARGET THEN

								INSERT (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate)
								VALUES (prxy.InsuranceCarrierID, prxy.InsuranceHealthPlanID, prxy.NHMemberID, prxy.BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE());
						        */


								/*

								One time insert

								INSERT into member.MemberCards (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate)
								select distinct t.InsCarrierID,t.InsHealthPlanID
								,m.nhmemberid
								,BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE()
								--,t.*
								--,m.*
								from otcfunds.BenefitCardMapping t
								join master.Members m on m.NHLinkID = t.NHLinkID
								join elig.vw_mstrEligBenefitData ms on ms.mstrEligID = t.mstrEligID  and ms.MasterMemberID = m.MemberID
								where t.benefitcardnumber in (

																select DISTINCT BenefitCardNumber
																from otcfunds.BenefitCardMapping
																where 1=1

																EXCEPT

																select distinct CardReferenceNumber
																from member.MemberCards
																where 1=1
																and CardVendor='fis'

														)
								and t.InsCarrierID not in (417,418,419,420)
								and cast(t.CreateDate as date)>= '11/01/2022'
								--and t.BenefitCardNumber = '0527822128936'


								*/
								  */

					      END

						

					-- Fund Disbursement & Deduct Funds Response Update
					ELSE IF ( @Is_CI_Record IN (6001,6003) )

							BEGIN

								update ot 
								Set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join flex.DetailRecord inn On 
										--ot.ssn=inn.ssn and 
								ot.ClientReferenceNumber=inn.ClientReferenceNumber
								And ot.[PAN/Proxy/ClientUniqueID/DirectAccess]=inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								Inner Join flex.BatchHeaderTrailer Bhtout
								On Bhtout.BatchheaderTrailerId=ot.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerId=Inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.FileHeaderTrailer Fht
								On Fht.FileHeaderTrailerId=Bhtin.FileHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where Fht.FileTrackId=@FileTrackId and bhtin.BatchSequence=Bhtout.BatchSequence
								And ot.direction='OUT' 
								and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId
								--and 
								--And @Is_CI_Record=60



								/* Update BenefitCardNumber in otcfunds.CardBenefitLoad*/
								update cbl 
								set cbl.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,cbl.ResponseProcessedFileID=@FileTrackId 
								,cbl.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,cbl.ResponseRecordStatusCode=drout.CardRecordStatusCode
								FROM otcfunds.CardBenefitLoad_FD cbl
								inner join flex.DetailRecord drout  ON cbl.CardBenefitLoadID=drout.CardBenefitLoadID
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								--ON drout.RefDetailRecordID=drin.DetailRecordID
								where drout.Direction='OUT'
								--and Drin.Direction='IN'
								and cbl.RecordType IN ('FD','DF')
								and fht.FileTrackID = @OutBound_FileTrackId
								--and @Is_CI_Record=60 					
							

					        END

/*

							-- Address Update
					ELSE IF @Is_CI_Record = 3002

							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 	flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								and Bhtin.BatchSequence=Bhtot.BatchSequence							



								/* Update ProcessingMessage from response file to MemberAddressChange*/
								update mac 
								set mac.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,mac.ResponseProcessedFileID=@FileTrackId 
								,mac.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,mac.ResponseRecordStatusCode=drout.CardRecordStatusCode								
								FROM otcfunds.MemberAddressChange mac
								inner join flex.DetailRecord drout
								ON mac.MemberAddressChangeID=drout.CardBenefitLoadID and drout.RecordType = 30 and drout.ActionType = 2
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								and mac.RecordType='AU'
								and fht.FileTrackID = @OutBound_FileTrackId
											
							

					        END



							ELSE IF @Is_CI_Record = 3106

							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 
								flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType and ot.[PAN/Proxy/ClientUniqueID/DirectAccess] = inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								and Bhtin.BatchSequence=Bhtot.BatchSequence							



								/* Update ProcessingMessage from response file to UUID Changes*/
								update mac 
								set mac.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,mac.ResponseProcessedFileID=@FileTrackId 
								,mac.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,mac.ResponseRecordStatusCode=drout.CardRecordStatusCode								
								FROM [otcfunds].[CardBenefitLoad_CI_UID] mac
								inner join flex.DetailRecord drout
								ON mac.CardBenefitLoad_UID_ID=drout.CardBenefitLoadID and drout.RecordType = 31 and drout.ActionType = 6
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								and mac.RecordType='OI'
								and fht.FileTrackID = @OutBound_FileTrackId
								and mac.RequestProcessedFileID = @OutBound_FileTrackId
											
							

					        END
*/
				
				 
			END
			COMMIT TRANSACTION RefFileTrackIdsUpd  
		END TRY  
		     BEGIN CATCH  
			  ROLLBACK TRANSACTION RefFileTrackIdsUpd  
				 DECLARE @ErrorMessage NVARCHAR(4000);  
					DECLARE @ErrorSeverity INT;  
					DECLARE @ErrorState INT;  
  
					SELECT   
					@ErrorMessage = ERROR_MESSAGE(),  
					@ErrorSeverity = ERROR_SEVERITY(),  
					@ErrorState = ERROR_STATE();   
			  RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);  
			END CATCH  
END 
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Update_Log_FileBatchDetail_bkp_beforeFileFailure]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******                              
NAME: [flex].[sp_ssis_Update_Log_FileBatchDetail]
                             
DESCRIPTION : To update flags in all the flex tables. once we recevied retrun file from flex.                         
				
INPUT PARAMETERS:                              
 Name				DataType	Default Description                              
--------------------------------------------------------------------------                              
 @FileTrackId		int                           
          
OUTPUT PARAMETERS:                              
 Name     DataType  Default Description                              
------------------------------------------------------------                              
                               
USAGE EXAMPLES:                              
------------------------------------------------------------                              
  BEGIN TRAN          

 EXEC [flex].[sp_ssis_Update_Log_FileBatchDetail] @FileTrackId=57               
                           
AUTHOR INITIALS:                              
 Initials		Name                              
------------------------------------------------------------                              
 SC				Sreenivasulu Cheerala                        
                               
MODIFICATIONS                              
 Initials		Date					Modification                              
------------------------------------------------------------                              
 SC				2021-August-23			Initial Creation.  
 Srikanth       2021-November           changes made to card number update scripts  
 Srikanth       2021-December           Member ProxyNumber (otcfunds.CardBenefitLoad.BenefitCardNumber) should be updated in member.MemberCards.CardReferenceNumber instead of Master.Memberinsurancedetails.OTCSerialNumber     
 Srikanth       2022-02-23              CardIssue refactor - CI update statements has been changed to update table otcfunds.CardBenefitLoad_CI  
 Srikanth       2022-02-27              CardIssue refactor - FD update statements has been changed to update table otcfunds.CardBenefitLoad_FD    
 Srikanth       2022-04-20              Address Update - @Is_CI_Record updated to include RT 30 & AT 02 
 Srikanth		2023-09-08				Address Update - Failure file update overwriting Card Issue Records
 Meenkumar		2023-09-13				UID is updated to OtherInformation in CI to support new card and update existing card with UID
          
******/
CREATE PROC [flex].[sp_ssis_Update_Log_FileBatchDetail_bkp_beforeFileFailure]
(
 @FileTrackId int 
,@OutBound_FileTrackId INT=NULL
)
AS
BEGIN


		SET NOCOUNT ON 
		BEGIN TRY  
		BEGIN TRANSACTION RefFileTrackIdsUpd  

		Declare @Is_CI_Record INT=NULL
		--,@IN_FileHeaderId BIGINT,@OUT_FileHeaderId BIGINT,@IN_FileTrailerId BIGINT,@OUT_FileTrailerId BIGINT
		,@Is_99_Record_Exists BIT=0

		--Select @IN_FileHeaderId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@FileTrackId and Fht.RecordType=10
		--Select @OUT_FileHeaderId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@OutBound_FileTrackId and Fht.RecordType=10
		--Select @IN_FileTrailerId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@FileTrackId and Fht.RecordType=90
		--Select @OUT_FileTrailerId=Fht.FileHeaderTrailerId from flex.FileHeaderTrailer Fht Where Fht.FileTrackID=@OutBound_FileTrackId and Fht.RecordType=90
		select distinct @Is_CI_Record =  left(RecordData,4) from flex.StgReturnFileData where left(RecordData,2)in (30,60) And FileTrackId=@FileTrackId

		--------------------------------Insert Into [flex].[FileFailure]--------------------------
		Insert INTO [flex].[FileFailure]
		(
		FileTrackID
		,RecordType
		,Filler
		,ProcessingMessage
		,CombinedRecord
		,ProcessDate
		,ProcessTime
		,FileRecordStatusCode
		,RefFileTrackId
		,ModifyDate
		)
		select 
		@FileTrackId
		,RecordType
		,Filler
		,ProcessingMessage
		,RecordData
		,ProcessDate
		,ProcessTime
		,Left(Ltrim(Rtrim(ProcessingMessage)),3) FileRecordStatusCode
		,@OutBound_FileTrackId
		,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
		FROM 
		(SELECT 
				p.FieldName
				,SUBSTRING(t.[RecordData],p.StartPosition,((p.EndPosition+1)-p.StartPosition)) AS [Value] 
				,t.StgReturnFileDataId,t.RecordData
		FROM [flex].[StgReturnFileData] t 
		CROSS APPLY(SELECT FieldName,RecordType,StartPosition,EndPosition FROM flex.FISFieldStartEndPositions) p
		WHERE LEFT(t.RecordData,2)=99 and p.RecordType=99 and t.Filetrackid=@FileTrackId
		) AS Trailer
		PIVOT 
		(
		 MAX([Value]) FOR [FieldName] in 
		 (	
		 RecordType
		,ProcessDate
		,ProcessTime
		,Filler
		,ProcessingMessage
		   )
		) AS Pvt
		Where Exists (select 1 from flex.StgReturnFileData where left(RecordData,2)=99 and FileTrackId=@FileTrackId)

		select @Is_99_Record_Exists=1 Where Exists (select 1 from flex.StgReturnFileData where left(RecordData,2)=99 And FileTrackId=@FileTrackId)

		-- Update Card Issue file failure on log file
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.CardBenefitLoad_CI Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END


		    -- Update Fund Disbursement file failure on log file
		    ELSE If ( @Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null


					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.CardBenefitLoad_FD Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
					
			END

         /*
		-- Update Address update file failure on log file -- added by SD by 2023-09-08
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From otcfunds.MemberAddressChange Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoadId=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END
			*/


			/*
		-- Update UID response file failure on log file -- added by SD by 2023-09-13
		If (@Is_99_Record_Exists=1  )
			Begin
					Update Dr
					Set Dr.CardRecordStatusCode=Ff.FileRecordStatusCode
					,Dr.ProcessingMessage=Ff.ProcessingMessage
					,Dr.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Dr.ModifyUser=SYSTEM_USER
					From flex.DetailRecord Dr
						Inner Join flex.BatchHeaderTrailer Bht
							ON Dr.BatchHeaderTrailerId=Bht.BatchHeaderTrailerId
						Inner Join flex.FileHeaderTrailer Fht
							ON Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
						Inner Join flex.FileFailure Ff
							ON Ff.FileTrackId=@FileTrackId
					Where Fht.FileTrackID=@OutBound_FileTrackId
						 And Dr.Direction='OUT'
						 and dr.CardRecordStatusCode is null

					Update	Cbf
					Set Cbf.ResponseRecordStatusCode=Dr.CardRecordStatusCode
					,Cbf.ResponseRecordStatus='ERROR'
					,Cbf.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
					,Cbf.ResponseProcessedFileID=@FileTrackId
					From [otcfunds].[CardBenefitLoad_CI_UID] Cbf
					Inner Join flex.DetailRecord Dr
					ON Cbf.CardBenefitLoad_UID_ID=Dr.CardBenefitLoadId
					Inner join flex.BatchHeaderTrailer Bht
					On Bht.BatchHeaderTrailerid=Dr.BatchHeaderTrailerId
					Inner Join flex.FileHeaderTrailer Fht
					On Fht.FileHeaderTrailerId=Bht.FileHeaderTrailerId
					Where Fht.FileTrackId=@OutBound_FileTrackId
					and Cbf.RequestProcessedFileID = @OutBound_FileTrackId
			END
			*/



			Else IF @Is_99_Record_Exists=0

			Begin


		            -- Card Issue Response Update
					If @Is_CI_Record = 3001
							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,Ot.[PAN/Proxy/ClientUniqueID/DirectAccess]=Inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 
								flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								--and @Is_CI_Record=30 
								and Bhtin.BatchSequence=Bhtot.BatchSequence


								/* Update BenefitCardNumber in otcfunds.CardBenefitLoad_CI*/
								update cbl 
								set cbl.BenefitCardNumber=LTRIM(RTRIM(drout.[PAN/Proxy/ClientUniqueID/DirectAccess]))
								,cbl.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,cbl.ResponseProcessedFileID=@FileTrackId 
								,cbl.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,cbl.ResponseRecordStatusCode=drout.CardRecordStatusCode
								,cbl.FirstTimeCardIssued = 'Y'
								FROM otcfunds.CardBenefitLoad_CI cbl
								inner join flex.DetailRecord drout
								ON cbl.CardBenefitLoadID=drout.CardBenefitLoadID and drout.RecordType = 30  and drout.ActionType = 1  
								--inner join flex.DetailRecord  drin
								--ON drout.RefDetailRecordID=drin.DetailRecordID
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								--and Drin.Direction='IN'
								and cbl.RecordType='CI'
								and cbl.BenefitCardNumber IS NULL
								and fht.FileTrackID = @OutBound_FileTrackId
								and cbl.RequestProcessedFileID = @OutBound_FileTrackId
								--And @Is_CI_Record=30

						
								/* Update BenefitCardNumber in elig.mstrEligBenefitData*/
								/*  Commented NOV 2022 
								Update mebd
								set mebd.BenefitCardNumber=cbl.BenefitCardNumber
								--,mebd.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								--,Mebd.ModifyUser=SYSTEM_USER
								From elig.mstrEligBenefitData mebd 
								Inner join otcfunds.CardBenefitLoad_CI cbl	ON 
								--mebd.NHLinkid=cbl.NHlinkId and 
								cbl.MemberDataID = mebd.mstrEligID
								where cbl.RecordType='CI'
								and cbl.MemberDataSource='ELIG'
								and cbl.BenefitCardNumber IS NOT NULL
								and (mebd.BenefitCardNumber IS NULL or mebd.BenefitCardNumber = '')
								and cbl.RequestProcessedFileID = @OutBound_FileTrackId
								and ISNULL(cbl.BenefitCardNumber,'') != ''
                                 */
								 

								 /*
								 Update bcm
                                set bcm.BenefitCardNumber=cbl.BenefitCardNumber
                                ,bcm.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
                                ,bcm.ModifyUser=SYSTEM_USER
                                From [otcfunds].[BenefitCardMapping] bcm
                                Inner join otcfunds.CardBenefitLoad_CI cbl    ON                               
                                bcm.BenefitCardMappingID = cbl.BenefitCardMappingID AND bcm.NHLinkID = cbl.NHLinkID
                                where cbl.RecordType='CI'
                                and cbl.MemberDataSource='ELIG'
                                and cbl.BenefitCardNumber IS NOT NULL
                                and (bcm.BenefitCardNumber IS NULL or bcm.BenefitCardNumber = '')
                                and cbl.RequestProcessedFileID = @OutBound_FileTrackId
                                and ISNULL(cbl.BenefitCardNumber,'') != ''

								 -- Multiple PAN Proxy not allowed yet
								-- Insert/Update PAN Proxy number to membercards from card issue table
								MERGE member.MemberCards mc
								USING ( 
										/*
										SELECT mi.InsuranceCarrierID, mi.InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber								
										FROM master.MemberInsurances mi
										INNER JOIN master.Members m ON m.MemberID = mi.MemberID
										*/
										SELECT mstr.insCarrierID InsuranceCarrierID, mstr.insHealthPlanID InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber
										,cbl.Level1ClientID
										FROM master.Members m 
										--INNER JOIN elig.mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID 
										INNER JOIN elig.vw_mstrEligBenefitData mstr ON mstr.MasterMemberID = m.MemberID  										
										INNER JOIN otcfunds.CardBenefitLoad_CI cbl ON cbl.MemberDataID = mstr.mstrEligID
										where cbl.RecordType='CI'
										AND cbl.BenefitCardNumber IS NOT NULL								
										AND cbl.RequestProcessedFileID = @OutBound_FileTrackId
										AND ISNULL(cbl.BenefitCardNumber,'') != ''
										and cbl.InsCarrierID not in (417,418,419,420,445)
									 ) prxy
								ON (mc.CardReferenceNumber = prxy.BenefitCardNumber AND mc.CardVendor= 'fis' AND mc.CardType = 'BenefitCard' AND mc.CardReferenceNumberType = 'ProxyId')

								WHEN MATCHED AND (prxy.InsuranceCarrierID != mc.InsuranceCarrierID OR prxy.InsuranceHealthPlanID != mc.InsuranceHealthPlanID OR prxy.NHMemberID != mc.NHMemberID) THEN

								UPDATE SET mc.InsuranceCarrierID = prxy.InsuranceCarrierID,
											mc.InsuranceHealthPlanID = prxy.InsuranceHealthPlanID,
											mc.NHMemberID = prxy.NHMemberID,
											mc.ModifyUser = SYSTEM_USER,
											mc.ModifyDate = GETDATE(),
											mc.[Source] = 'FIS'

								WHEN NOT MATCHED BY TARGET THEN

								INSERT (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate, CardIssuer,Level1ClientID)
								VALUES (prxy.InsuranceCarrierID, prxy.InsuranceHealthPlanID, prxy.NHMemberID, prxy.BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE()
										,CASE WHEN prxy.Level1ClientID = 718967 THEN 'METABANK'
											  WHEN prxy.Level1ClientID = 995407 THEN 'BANCORP'
											  ELSE 'BANCORP' END
										,Level1ClientID
									   );
                                



								/*
								MERGE member.MemberCards mc
								USING ( SELECT mi.InsuranceCarrierID, mi.InsuranceHealthPlanID, m.NHMemberID, cbl.BenefitCardNumber								
										FROM master.MemberInsurances mi
										INNER JOIN master.Members m ON m.MemberID = mi.MemberID
										--INNER JOIN elig.mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID 
                                        INNER JOIN elig.vm_mstrEligBenefitData mstr ON mstr.MemberInsuranceID = mi.ID  										
										INNER JOIN otcfunds.CardBenefitLoad_CI cbl ON cbl.MemberDataID = mstr.mstrEligID
										where cbl.RecordType='CI'
										AND cbl.BenefitCardNumber IS NOT NULL								
										AND cbl.RequestProcessedFileID = @OutBound_FileTrackId
										AND ISNULL(cbl.BenefitCardNumber,'') != ''
										) prxy
								ON (mc.CardReferenceNumber = prxy.BenefitCardNumber AND mc.CardVendor= 'fis' AND mc.CardType = 'BenefitCard' AND mc.CardReferenceNumberType = 'ProxyId')

								WHEN MATCHED AND (prxy.InsuranceCarrierID != mc.InsuranceCarrierID OR prxy.InsuranceHealthPlanID != mc.InsuranceHealthPlanID OR prxy.NHMemberID != mc.NHMemberID) THEN

								UPDATE SET mc.InsuranceCarrierID = prxy.InsuranceCarrierID,
											mc.InsuranceHealthPlanID = prxy.InsuranceHealthPlanID,
											mc.NHMemberID = prxy.NHMemberID,
											mc.ModifyUser = SYSTEM_USER,
											mc.ModifyDate = GETDATE(),
											mc.[Source] = 'FIS'

								WHEN NOT MATCHED BY TARGET THEN

								INSERT (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate)
								VALUES (prxy.InsuranceCarrierID, prxy.InsuranceHealthPlanID, prxy.NHMemberID, prxy.BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE());
						        */


								/*

								One time insert

								INSERT into member.MemberCards (InsuranceCarrierID, InsuranceHealthPlanID, NHMemberID, CardReferenceNumber, CardVendor, IsCardValId, CardType ,IsActive, [Source], CreateUser, CreateDate, CardReferenceNumberType, ModifyUser, ModifyDate)
								select distinct t.InsCarrierID,t.InsHealthPlanID
								,m.nhmemberid
								,BenefitCardNumber,'FIS',1,'BenefitCard',1, 'FIS', SYSTEM_USER, GETDATE(), 'ProxyId', SYSTEM_USER, GETDATE()
								--,t.*
								--,m.*
								from otcfunds.BenefitCardMapping t
								join master.Members m on m.NHLinkID = t.NHLinkID
								join elig.vw_mstrEligBenefitData ms on ms.mstrEligID = t.mstrEligID  and ms.MasterMemberID = m.MemberID
								where t.benefitcardnumber in (

																select DISTINCT BenefitCardNumber
																from otcfunds.BenefitCardMapping
																where 1=1

																EXCEPT

																select distinct CardReferenceNumber
																from member.MemberCards
																where 1=1
																and CardVendor='fis'

														)
								and t.InsCarrierID not in (417,418,419,420)
								and cast(t.CreateDate as date)>= '11/01/2022'
								--and t.BenefitCardNumber = '0527822128936'


								*/
								  */

					      END

						

					-- Fund Disbursement & Deduct Funds Response Update
					ELSE IF ( @Is_CI_Record IN (6001,6003) )

							BEGIN

								update ot 
								Set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join flex.DetailRecord inn On 
										--ot.ssn=inn.ssn and 
								ot.ClientReferenceNumber=inn.ClientReferenceNumber
								And ot.[PAN/Proxy/ClientUniqueID/DirectAccess]=inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								Inner Join flex.BatchHeaderTrailer Bhtout
								On Bhtout.BatchheaderTrailerId=ot.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerId=Inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.FileHeaderTrailer Fht
								On Fht.FileHeaderTrailerId=Bhtin.FileHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where Fht.FileTrackId=@FileTrackId and bhtin.BatchSequence=Bhtout.BatchSequence
								And ot.direction='OUT' 
								and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId
								--and 
								--And @Is_CI_Record=60



								/* Update BenefitCardNumber in otcfunds.CardBenefitLoad*/
								update cbl 
								set cbl.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,cbl.ResponseProcessedFileID=@FileTrackId 
								,cbl.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,cbl.ResponseRecordStatusCode=drout.CardRecordStatusCode
								FROM otcfunds.CardBenefitLoad_FD cbl
								inner join flex.DetailRecord drout  ON cbl.CardBenefitLoadID=drout.CardBenefitLoadID
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								--ON drout.RefDetailRecordID=drin.DetailRecordID
								where drout.Direction='OUT'
								--and Drin.Direction='IN'
								and cbl.RecordType IN ('FD','DF')
								and fht.FileTrackID = @OutBound_FileTrackId
								--and @Is_CI_Record=60 					
							

					        END

/*

							-- Address Update
					ELSE IF @Is_CI_Record = 3002

							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 	flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								and Bhtin.BatchSequence=Bhtot.BatchSequence							



								/* Update ProcessingMessage from response file to MemberAddressChange*/
								update mac 
								set mac.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,mac.ResponseProcessedFileID=@FileTrackId 
								,mac.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,mac.ResponseRecordStatusCode=drout.CardRecordStatusCode								
								FROM otcfunds.MemberAddressChange mac
								inner join flex.DetailRecord drout
								ON mac.MemberAddressChangeID=drout.CardBenefitLoadID and drout.RecordType = 30 and drout.ActionType = 2
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								and mac.RecordType='AU'
								and fht.FileTrackID = @OutBound_FileTrackId
											
							

					        END



							ELSE IF @Is_CI_Record = 3106

							BEGIN

								/* Update out bound file Detail Record based on inbound file responses*/
								update ot 
								set ot.RefDetailRecordID=inn.DetailRecordID 
								,ot.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,ot.CardRecordStatusCode=inn.CardRecordStatusCode
								,ot.ProcessingMessage=inn.ProcessingMessage
								from flex.DetailRecord ot 
								inner join 
								flex.DetailRecord inn 
								On ot.ssn=inn.ssn and ot.RecordType = inn.RecordType and ot.[PAN/Proxy/ClientUniqueID/DirectAccess] = inn.[PAN/Proxy/ClientUniqueID/DirectAccess]
								Inner Join flex.BatchHeaderTrailer Bhtin
								On Bhtin.BatchHeaderTrailerid=inn.BatchHeaderTrailerId
								Inner Join flex.BatchHeaderTrailer Bhtot
								On Bhtot.BatchHeaderTrailerid=ot.BatchHeaderTrailerId
								Inner join flex.Fileheadertrailer Fhtin
								On Fhtin.Fileheadertrailerid=Bhtin.Fileheadertrailerid
								Inner join flex.Fileheadertrailer Fhtot
								On Fhtot.Fileheadertrailerid=Bhtot.Fileheadertrailerid
								Where ot.direction='OUT' and inn.direction='IN'
								and Fhtot.FileTrackID=@OutBound_FileTrackId and Fhtin.Filetrackid=@FileTrackId
								and Bhtin.BatchSequence=Bhtot.BatchSequence							



								/* Update ProcessingMessage from response file to UUID Changes*/
								update mac 
								set mac.ResponseProcessedDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
								,mac.ResponseProcessedFileID=@FileTrackId 
								,mac.ResponseRecordStatus=case when drout.CardRecordStatusCode between 02 and 09 then 'SUCCESS' else 'ERROR' end
								,mac.ResponseRecordStatusCode=drout.CardRecordStatusCode								
								FROM [otcfunds].[CardBenefitLoad_CI_UID] mac
								inner join flex.DetailRecord drout
								ON mac.CardBenefitLoad_UID_ID=drout.CardBenefitLoadID and drout.RecordType = 31 and drout.ActionType = 6
								INNER JOIN flex.BatchHeaderTrailer bht ON bht.BatchHeaderTrailerId = drout.BatchHeaderTrailerId
								INNER JOIN flex.FileHeaderTrailer fht on fht.FileHeaderTrailerId = bht.FileHeaderTrailerId
								where drout.Direction='OUT'
								and mac.RecordType='OI'
								and fht.FileTrackID = @OutBound_FileTrackId
								and mac.RequestProcessedFileID = @OutBound_FileTrackId
											
							

					        END
*/
				
				 
			END
			COMMIT TRANSACTION RefFileTrackIdsUpd  
		END TRY  
		     BEGIN CATCH  
			  ROLLBACK TRANSACTION RefFileTrackIdsUpd  
				 DECLARE @ErrorMessage NVARCHAR(4000);  
					DECLARE @ErrorSeverity INT;  
					DECLARE @ErrorState INT;  
  
					SELECT   
					@ErrorMessage = ERROR_MESSAGE(),  
					@ErrorSeverity = ERROR_SEVERITY(),  
					@ErrorState = ERROR_STATE();   
			  RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);  
			END CATCH  
END 
GO
/****** Object:  StoredProcedure [flex].[sp_ssis_Update_RefFileTrackId]    Script Date: 6/26/2024 1:01:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******                                
NAME: [flex].[sp_ssis_Update_RefFileTrackId]  
                               
DESCRIPTION : To Update RefFileTrackid in the otcfunds.Filetrack table..  
      
INPUT PARAMETERS:                                
 Name    DataType  Default Description                                
--------------------------------------------------------------------------                                
 @FileTrackId  INT                            
            
OUTPUT PARAMETERS:                                
 Name     DataType  Default Description                                
------------------------------------------------------------                                
                                 
USAGE EXAMPLES:                                
------------------------------------------------------------                                
  BEGIN TRAN            
  
 EXEC [flex].[sp_ssis_Update_RefFileTrackId] @FileTrackId=1                 
                             
AUTHOR INITIALS:                                
 Initials  Name                                
------------------------------------------------------------                                
 SC    Sreenivasulu Cheerala                          
                                 
MODIFICATIONS                                
 Initials  Date     Modification                                
------------------------------------------------------------                                
 SC    2021-August-24   Initial Creation.                           
******/  
CREATE    PROC [flex].[sp_ssis_Update_RefFileTrackId]  
(  
  @FileTrackId INT  
)  
AS  
BEGIN  
SET NOCOUNT ON   
BEGIN TRY  
BEGIN TRANSACTION RefFileTrackIds  
  
Declare  @OutBound_FileTrackId BIGINT=NULL  
   ,@InBound_File_Name Varchar(225)   
   ,@FileStatusCode Int
  -- ,@FileTrackId INT  
  
Select @InBound_File_Name=case when fi.IsPGP='Y' then Replace(ft.FileName,'.log'+'.'+fi.PGPFileExtension,'')  else Replace(ft.FileName,'.log','') end 
From otcfunds.filetrack ft 
Inner Join otcfunds.fileinfo fi 
On ft.FileInfoId=ft.FileInfoid  
Where ft.FileTrackId=@FileTrackId And  fi.Direction='IN'


Select @OutBound_FileTrackId=ft.Filetrackid   
From otcfunds.FileTrack ft   
Where ft.FileName=@InBound_File_Name+'.txt'
AND ft.DirectionCode = 'OUT'   
 

Update ft set ft.StatusCode=111 
,ft.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,ft.ModifyUser=SYSTEM_USER
from otcfunds.filetrack ft 
Where ft.FileTrackId=@FileTrackId
And @OutBound_FileTrackId IS NULL 

Select @FileStatusCode=ft.StatusCode From otcfunds.filetrack ft Where ft.FileTrackID=@FileTrackId

Update  
 fk   
Set fk.RefFileTrackId=@FileTrackId   
,fk.ModifyDate=CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS datetime)
,fk.ModifyUser=SYSTEM_USER  
From otcfunds.FileTrack fk   
Where FileTrackID=@OutBound_FileTrackId  
And Exists (Select 1 from otcfunds.FileTrack ft where ft.FileTrackID=@FileTrackId and ft.StatusCode=100)

Select @FileStatusCode,@OutBound_FileTrackId
  
COMMIT TRANSACTION RefFileTrackIds  
END TRY  BEGIN CATCH  
  ROLLBACK TRANSACTION RefFileTrackIds  
     DECLARE @ErrorMessage NVARCHAR(4000);  
        DECLARE @ErrorSeverity INT;  
        DECLARE @ErrorState INT;  
  
        SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();   
  RAISERROR (@ErrorMessage,@ErrorSeverity,@ErrorState);  
END CATCH  
END 



GO
