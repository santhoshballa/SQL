/****** Script for SelectTopNRows command from SSMS  ******/
IF OBJECT_ID('tempdb..#TClientCode') IS NOT NULL DROP TABLE #TClientCode
create table #TClientCode ( 
ClientCode nvarchar(10)
)

insert into #TClientCode (ClientCode) values ('H462_RE')
--declare @ClientCode nvarchar(10) = 'H628'

--select * from elig.clientcodes where clientName like '%KC%' 


select top 100 'elig.ClientCodes' as TableName,  *  from elig.ClientCodes where ClientCode in (select ClientCode from #TClientCode) order by CreateDate
--select top 100 * from elig.ClientCodes order by CreateDate desc
select top 100 'elig.FTPUserInfo' as TableName, * from elig.FTPUserInfo where ClientCode in (select ClientCode from #TClientCode)
select top 100 'elig.FileTrack' as TableName, * from elig.FileTrack where ClientCode in (select ClientCode from #TClientCode)
select top 100 'elig.FileInfo' as TableName, * from elig.FileInfo where ClientCode in (select ClientCode from #TClientCode)
select top 100 'elig.EligibilityColumnValidation' as TableName, * from elig.EligibilityColumnValidation where ClientCode in (select ClientCode from #TClientCode)
select top 100 'elig.rawEligBenefitData' as TableName, * from elig.rawEligBenefitData where ClientCode in (select ClientCode from #TClientCode)
select top 100 'elig.EligibilityStats' as TableName, * from elig.EligibilityStats where ClientCode in (select ClientCode from #TClientCode)


select * from information_schema.columns where column_name = 'clientCode' and table_schema = 'elig'
select * from information_schema.columns where column_name  like '%ClientRewardsData%'


-- Provided By Sujay
select * from elig.ClientCodes where ClientCode='H462_RE'
select * from elig.FTPUserInfo where ClientCode='H462_RE'
select * from elig.FileInfo where ClientCode='H462_RE'
 
select * from elig.FileTrack where DataSource ='ELIG_ALGN_CA' and  ClientCode='H462_RE'  order by 1 desc
select * from elig.rawEligBenefitData where FileTrackId = 29886
select * from elig.stgEligBenefitData where FileTrackId = 29886
 
--move to elig.ClientRewardsData and create resp.. file
--use 3_BCBSKC_H488_Full_StgToMstr.bat (3_BCBSKC_H488_Full_StgToMstr.dtsConfig)


select  top 1
    ft.FileinfoId as FileinfoId,
    ft.FileTrackID as FileTrackId,
    ft.FileName as FileName,
    fi.ToLocation as SourceFolder,
    fi.FileExtension as FileExtension,
    fi.FileFormatValue as FileDelimiter,

case when ELIG_ACK_FileName is null then 'Elig_Ack_' + ft.FileName else replace([elig].[GetOutFileName](ft.FileName,ELIG_ACK_FileName),fi.FileExtension,AckFileExtension) end as ELIG_ACK_FileName,
case when EAck.fromlocation is null then fi.ToLocation +'Archive\' else EAck.fromlocation end as EAckfromlocation,
 isnull(EAck.tolocation,'') as EAcktolocation,
isnull(EAck.isAckFileToFTP,'N') as EAckOutFTPFlag,

case when ELIG_ERR_FileName is null then 'Elig_Err_' + ft.FileName else replace([elig].[GetOutFileName](ft.FileName,ELIG_ERR_FileName),fi.FileExtension,ErrFileExtension) end as ELIG_ERR_FileName,
case when EErr.fromlocation is null then fi.ToLocation +'Archive\' else EErr.fromlocation end as EErrfromlocation,
 isnull(EErr.tolocation,'') as EErrtolocation,
isnull(EErr.isAckFileToFTP,'N') as EErrOutFTPFlag,

case when ELIG_STAT_FileName is null then 'Elig_Stat_' + ft.FileName else replace([elig].[GetOutFileName](ft.FileName,ELIG_STAT_FileName),fi.FileExtension,StatFileExtension) end as ELIG_STAT_FileName,
case when stat.fromlocation is null then fi.ToLocation +'Archive\' else stat.fromlocation end as statfromlocation,
 isnull(stat.tolocation,'') as Stattolocation,
isnull(stat.isAckFileToFTP,'N') as StatOutFTPFlag,

case when ELIG_TBA_FileName is null then 'Elig_TBA_' + ft.FileName else replace([elig].[GetOutFileName](ft.FileName,ELIG_TBA_FileName),fi.FileExtension,TBAFileExtension) end as ELIG_TBA_FileName,
case when TBA.fromlocation is null then fi.ToLocation +'Archive\' else TBA.fromlocation end as TBAfromlocation,
 isnull(TBA.tolocation,'') as TBAtolocation,
isnull(TBA.isAckFileToFTP,'N') as TBAOutFTPFlag,

isnull(Estat.OutFileEmail,'') as OutFileEmail,
isnull(Estat.isOutFileEmail,'N') as isOutFileEmail


from elig.filetrack ft
join elig.fileinfo fi on ft.FileInfoID = fi.FileInfoId
left join ( select filename as ELIG_ACK_FileName,clientcode,snapshotflag,fromlocation,tolocation,isAckFileToFTP,FileExtension as AckFileExtension
			,isOutFileEmail,OutFileEmail
            from elig.fileinfo
            where 1=1
            and filetype = 'ELIG_ACK'
            and direction = 'OUT'
            and isAckFileToFTP = 'Y'
) EAck on fi.clientcode = EAck.clientcode and fi.snapshotflag = EAck.snapshotflag
left join ( select filename as ELIG_ERR_FileName,clientcode,snapshotflag,fromlocation,tolocation,isAckFileToFTP,FileExtension as ERRFileExtension
			,isOutFileEmail,OutFileEmail
            from elig.fileinfo
            where 1=1
            and filetype = 'ELIG_ERR'
            and direction = 'OUT'
            and isAckFileToFTP = 'Y'
) EErr on fi.clientcode = EErr.clientcode and fi.snapshotflag = EErr.snapshotflag
left join ( select a.filename as ELIG_STAT_FileName,a.clientcode,a.snapshotflag,a.fromlocation,a.tolocation,a.isAckFileToFTP,a.FileExtension as STATFileExtension
			,isOutFileEmail,OutFileEmail
            from elig.fileinfo a
            where 1=1
            and filetype = 'ELIG_STAT'
            and direction = 'OUT'
            and isAckFileToFTP = 'Y'
) stat on fi.clientcode = stat.clientcode and fi.snapshotflag = stat.snapshotflag
left join ( select a.filename as ELIG_TBA_FileName,a.clientcode,a.snapshotflag,a.fromlocation,a.tolocation,a.isAckFileToFTP,a.FileExtension as TBAFileExtension
			,a.isOutFileEmail,a.OutFileEmail
            from elig.fileinfo a
            where 1=1
            and filetype = 'ELIG_TBA'
            and direction = 'OUT'
            and isAckFileToFTP = 'Y'
) TBA on fi.clientcode = TBA.clientcode and fi.snapshotflag = TBA.snapshotflag
left join ( select filename as E_ELIG_STAT_FileName,clientcode,snapshotflag,fromlocation,isAckFileToFTP,FileExtension as E_STATFileExtension,
			isOutFileEmail,OutFileEmail
            from elig.fileinfo
            where 1=1
            and filetype = 'ELIG_STAT'
            and direction = 'OUT'
            and isOutFileEmail = 'Y'
) Estat on fi.clientcode = Estat.clientcode and fi.snapshotflag = Estat.snapshotflag

where 1=1
and ft.ClientCode = ?
and fi.FileType = ?
and fi.SnapshotFlag = ?
 and fi.direction = 'IN'
and ft.StatusCode = '300'
order by ft.FileInfoID,ft.FileTrackID

elig.sp_Elig_Audit_Response_File




SELECT TOP (1000) [ID]
      ,[ClientCode]
      ,[FileTrackId]
      ,[ProcedureName]
      ,[StepName]
      ,[Statuscode]
      ,[CreateUser]
      ,[CreateDate]
  FROM [elig].[jobAuditLog] order by createdate desc

  select distinct ProcedureName, stepname from [elig].[jobAuditLog] 
  select distinct ProcedureName from [elig].[jobAuditLog]


  /****** Object:  StoredProcedure [elig].[sp_elig_load_stg_to_elig]    Script Date: 11/24/2021 6:41:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- EXEC [elig].[sp_elig_load_stg_to_elig] 29886

CREATE PROCEDURE [elig].[sp_elig_load_stg_to_elig] (@FileTrackID BIGINT)
--- Version 1.0  --           - Mohan Bekkary -- New Procedure
--- Version 1.00 -- 01/01/2020 - Raj/ Srikanth -- Error Handling & Audit Log, Changed Phone Nbrs to varchar, 
--- Version 1.01 -- 01/06/2020 - Raj Sareddy   -- Changed Error type to be ERR_, 
--- Version 1.02 -- 01/07/2020 - Raj/ Srikanth -- Dates check and change to UTC datetime issue
--- Version 1.03 -- 01/07/2020 - Raj Sareddy   -- Added Stats Procedure
--- Version 1.04 -- 06/23/2020 - Raj/Srikanth -- Excluding RecordStatus like ERR
--- Version 1.05 -- 07/26/2021 - Shashi/Srikanth -- Added error type Err_multiIns 
AS
DECLARE @procedureName VARCHAR(100) = 'sp_elig_load_stg_to_elig'
DECLARE @strWhereClause VARCHAR(max) 
DECLARE @strChangeClause VARCHAR(max)
DECLARE @strCrossWalkWhereClause VARCHAR(max)
DECLARE @strNHLink VARCHAR(500)
DECLARE @sql VARCHAR(max)
DECLARE @statusFlag NVARCHAR(10) = 'N'
DECLARE @dataSource NVARCHAR(50)
DECLARE @NewRecordCount INTEGER
DECLARE @RecordsProcessed INTEGER
DECLARE @ErrorRecordCount INTEGER
DECLARE @ChangeRecordCount INTEGER
DECLARE @DropRecordCount INTEGER
DECLARE @NoChangeRecordCount INTEGER
DECLARE @LogMessage VARCHAR(max)
DECLARE @UserName VARCHAR(100) = SUSER_SNAME()
DECLARE @ClientCode VARCHAR(100)
DECLARE @FileType VARCHAR(100)
DECLARE @SnapShot VARCHAR(100)
DECLARE @FileInfoID BIGINT
DECLARE @FileID BIGINT
DECLARE @fullFile INT
DECLARE @stepName VARCHAR(200);
declare @fileTrackStatusCode varchar(20)

BEGIN
	BEGIN TRY
	BEGIN TRANSACTION elig_load_stg_to_elig

	--- Get File Info from file track table for FileTrackID
	/*Notes by Santhosh
	select datasource, snapshotflag, fileinfoid, clientcode, filetype, statuscode from elig.filetrack where filetrackid = 29886
	datasource	snapshotflag	fileinfoid	clientcode	filetype	statuscode
		ELIG_ALGN_CA	FULL	370	H462_Re	REWARDS	300

	SELECT @dataSource = Datasource
		,@snapshot = Snapshotflag
		,@FileInfoID = FileInfoID
		,@ClientCode = ClientCode
		,@FileType = FileType
		,@fileTrackStatusCode = StatusCode
	FROM elig.filetrack
	WHERE FileTrackID = @FileTrackID


	*/
	SELECT @dataSource = Datasource
		,@snapshot = Snapshotflag
		,@FileInfoID = FileInfoID
		,@ClientCode = ClientCode
		,@FileType = FileType
		,@fileTrackStatusCode = StatusCode
	FROM elig.filetrack
	WHERE FileTrackID = @FileTrackID
	--DONE --- RAJ added status code if status code not found then log saying no data found
	-- Notes Santhosh Balla | checks for the file that has been processed. Checks for status code = 300 to process a file
	if isnull(@fileTrackStatusCode,'999') <> '300'
	begin
		print('no file')
		Return 0
	end 

	PRINT (@ClientCode)
	PRINT (@FileType)
	PRINT (@FileTrackId)

	SET @stepName = '110 Update BenefitEndDate'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

	update elig.stgEligBenefitData 
	set BenefitEndDate = '20991231'
	where FileTrackID = @FileTrackID
	and isnull(BenefitEndDate,'') = ''


	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

	
	IF @snapshot = 'FULL'
		SET @fullFile = 1
	ELSE
		SET @fullFile = 0
		--LATER LOW Priority RAJ MAY be move all clauses to one priority low
	--- Get Mandatory Where condition between Stage and Master tales.
	SET @strWhereClause = [elig].[getEligWhereClause](@ClientCode, @FileType)
	PRINT @strWhereClause

	--- Get Change fileds comparison between stage and elig master table
	SET @strChangeClause = [elig].[getEligChangeClause](@ClientCode, @FileType)
	--- Get CrossWalk Where condition between Stage and Master tales.
	SET @strCrossWalkWhereClause = [elig].[getCrossWalkWhereClause](@ClientCode, @FileType)
	SET @strNHLink = [elig].[getLinkID](@ClientCode, @FileType)

	
	-- Validate for Span Errors in Stage Table
	--BEGIN TRY
		DECLARE @RC INT

	SET @stepName = '120 Duplicate Check'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		EXECUTE @RC = [elig].[sp_elig_validate_duplicate_stage_data] @ClientCode
			,@FileType
			,@FileTrackID

	SET @stepName = '130 OlD SPAN Check'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		EXECUTE @RC = [elig].[sp_elig_validate_oldspan_stage_data] @ClientCode
			,@FileType
			,@FileTrackID

	SET @stepName = '160 Validate Other Stage Data'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		-- Validate data in stage for any data errors
		EXECUTE @RC = [elig].[sp_elig_validate_stage_data] @ClientCode
			,@FileType
			,@FileTrackId

	SET @stepName = '150 Span Errors'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		EXECUTE @RC = [elig].[sp_elig_mark_span_errors_stage_data] @ClientCode
			,@FileType
			,@FileTrackID

	SET @stepName = '140 Cross Walk Check'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		EXECUTE @RC = [elig].[sp_elig_validate_xwalk_stage_data] @ClientCode
			,@FileType
			,@FileTrackID
	
	if @ClientCode = 'H376' 
	Begin
		SET @stepName = '170 Multiple insurances Check'
		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

			EXECUTE @RC = [elig].[sp_elig_validate_Multipleinsurances_stage_data] @ClientCode
				,@FileType
				,@FileTrackID
	End

	SET @stepName = '200 Update NR'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		--update New records to Status New Records with record status "NR" for all records in stage not in elig master 
		-- DONE RAJ add filetrackID to where clause
	--NOT USED	SET @statusFlag = 'NR'
		SET @sql = 'update [elig].stgEligBenefitData set stgEligBenefitData.recordstatus = ''NR'' 	where recordstatus =''ZZ'' and   datasource = ''' + @dataSource + ''' and filetrackid = ' + convert(VARCHAR, @FileTrackId) + ' and not exists (select 1 from elig.mstrEligBenefitData where  datasource = ''' + @dataSource + ''' and  isactive=1 and  ' + @strWhereClause + '	)';

		PRINT 'New Record Query'
		PRINT @sql;

		EXEC (@sql);

		SELECT @NewRecordCount = @@ROWCOUNT 

		IF @fullFile = 1
			--flag members who are in master stage table but not in stage table for datasource and filetrack
			-- DONE RAJ addd where getdate() between record start and record also as a saftey measure
			-- Excluding RecordStatus like ERR
		BEGIN
				SET @stepName = '210 Update TR'
				EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

			--below line commented by DPSR on 12152020 and add split string
			--SET @sql = 'update  elig.mstrEligBenefitData Set mstrEligBenefitData.recordstatus = ''TR'' ,  tobeprocessed =''Y''  ,  BenefitEndDate  = DATEADD (day,-1, CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE)), ModifyDate = getdate(), ModifyUser = ''' + @UserName + '''   where  datasource = ''' + @dataSource + ''' and  isActive = 1 and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between benefitstartdate and benefitenddate  and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between RecordEffDate and RecordENDDate  and not exists (select 1 from [elig].stgEligBenefitData where RecordStatus NOT LIKE ''ERR_%'' AND  filetrackid = ' + convert(VARCHAR, @FileTrackId) + ' and  datasource = ''' + @dataSource + ''' and  ' + @strWhereClause + ')'
			SET @sql = 'update  elig.mstrEligBenefitData Set mstrEligBenefitData.recordstatus = ''TR'' ,  tobeprocessed =''Y''  ,  '
			set @sql = @sql +'BenefitEndDate  = DATEADD (day,-1, CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE)), '
			set @sql = @sql +'ModifyDate = getdate(), ModifyUser = ''' + @UserName + '''   '
			set @sql = @sql +'where  datasource = ''' + @dataSource + ''' and  isActive = 1 and '
			set @sql = @sql +' (('
			set @sql = @sql +'CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between benefitstartdate and benefitenddate  '
			set @sql = @sql +')  or (benefitstartdate > CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) and BenefitEndDate > BenefitStartDate)   ) '
			set @sql = @sql +'and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between RecordEffDate and RecordENDDate  '
			set @sql = @sql +'and not exists (select 1 from [elig].stgEligBenefitData where RecordStatus NOT LIKE ''ERR_%'' '
			set @sql = @sql +'AND  filetrackid = ' + convert(VARCHAR, @FileTrackId) + ' and  datasource = ''' + @dataSource + ''' and  ' + @strWhereClause + ')'


			PRINT 'Termed by Absence Query'
			PRINT @sql
			EXEC (@sql);
			SELECT @DropRecordCount = @@ROWCOUNT
		END 

-- DOne RAJ addd isactive = 1 and getdate() betwen record eff and record end
	SET @stepName = '220 Update CH'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		SET @sql = 'update [elig].stgEligBenefitData set recordstatus = ''CH'' where recordstatus =''ZZ'' and filetrackid = ' + convert(VARCHAR, @FileTrackId) + ' and   datasource = ''' + @dataSource + ''' and  exists (select 1 from [elig].mstrEligBenefitData where  datasource = ''' + @dataSource + ''' and  (' + @strChangeClause + ') 			 and ' + @strWhereClause + '  and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between RecordEffDate and RecordENDDate and isactive= 1)';

		PRINT 'Change Query'
		PRINT @sql

		EXEC (@sql);

		SELECT @ChangeRecordCount = @@ROWCOUNT
--Done RAJ high priority need to check if mstrEligBenefitData  record is isactive = 1 then only update because there will be multiple records for the same member what if address changes etc.
--Done  RAJ add also if the record span is also active
	SET @stepName = '230 Update Master for CH'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		SET @sql = 'update [elig].mstrEligBenefitData set  isactive = 0, RecordEndDate  = DATEADD (day,-1, CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE)), tobeprocessed =''Y'' , ModifyDate = getdate(), ModifyUser = ''' + @UserName + '''      where   datasource = ''' + @dataSource + '''   and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between RecordEffDate and RecordENDDate and isactive= 1 and  exists (select 1 from [elig].stgEligBenefitData where ' + @strWhereClause + '  AND stgEligBenefitData.filetrackid =' + convert(VARCHAR, @FileTrackId) + ' and  datasource = ''' + @dataSource + '''   and stgEligBenefitData.recordstatus = ''CH'')';

				PRINT 'Existing Change record in Eligmstr update Query'
		PRINT @sql
		EXEC (@sql);

	SET @stepName = '240 Update NC'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		-- DOne RAJwhen comparing to eli chedck for isactive and getdate() betwwen record effect and end date 
		SET @sql = 'update [elig].stgEligBenefitData set recordstatus = ''NC'' where recordstatus = ''ZZ'' and  filetrackid = ' + convert(VARCHAR, @FileTrackId) + ' and   datasource = ''' + @dataSource + ''' and  NOT exists (select 1 from [elig].mstrEligBenefitData where  datasource = ''' + @dataSource + '''    and CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE) between RecordEffDate and RecordENDDate and isactive= 1   and  (' + @strChangeClause + ') 			 and ' + @strWhereClause + ')';

		PRINT 'No Change Record Query'
		PRINT @sql

		EXEC (@sql);


		--UPDATE [elig].stgEligBenefitData
		--SET recordstatus = 'NC'
		--WHERE recordstatus = 'ZZ'
		--	AND FileTrackID = @FileTrackID

		SELECT @NoChangeRecordCount = @@ROWCOUNT

	SET @stepName = '300 Before Insert into mstr'
	EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

/*
INSERT INTO [elig].[mstrEligBenefitData] (
[DataSource],[RecordStatus],[LastName],[FirstName],[Middleinitial],[DOB],[SSN],[SubscriberID],[MemberSuffix],[GroupNbr],[SubGroupNbr],[FamilyLinkID],[AlternateID],
[MedicaidID],[MedicareID],[ClientMemberNumber],ContractNbr,[PBPID],[ProductID],[BenefitLevel],[Language],[Gender],[HomePhoneNbr],[OtherPhoneNbr],[MemberEmail],
[Address1],[Address2],[City],[State],[ZipCode],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[OtherAddress1],[OtherAddress2]
,[OtherCity],[OtherState],[OtherZipCode],[OtherAddressType],[SubscriberIndFlag],[RelationShipCode],[MaintenanceType],[MaintenanceReason],[BenefitStatus],[MedicarePlanCode]
,[EligReasonCode],[COBRAEvent],[EmploymentStatusCode],[StudentStatusCode],[HandicapInd],[DisabilityType],[MedicalCodeQualifier],[MedicalCode],[MaintenanceCode]
,[InsuranceLineCode],[CoverageLevel],[LateEnrollment],[CoInsurance],[CoPayment],[Deductible],[Premium],[SpendDown],[LineNbr],[PCPName],[PCPNPI]
,[PCPAddress1],[PCPAddress2],[PCPCity],[PCPState],[PCPZipCode],[PCPBusinessPhone],[COBFlag],[COBCarrierName],[COBPolicyNumber]
,[COBGroup],[COBRespcode],[COBcode],[COBServiceType],[BusinessCategory],[LineOfBusiness],[EligibilityStartDate],[EligibilityEndDate]
,[FileID],[FileTrackId],[BenefitStartDate],[BenefitEndDate],[PCPEffDate],[PCPTermDate],[RecordEffDate],[RecordEndDate]
,[isActive],[ToBeProcessed],IsMailingAddressForeign,IsMemberAddressForeign
)
SELECT [DataSource],[RecordStatus],[LastName],[FirstName],[Middleinitial],[DOB],[SSN],[SubscriberID],[MemberSuffix],[GroupNbr],[SubGroupNbr],[FamilyLinkID],[AlternateID]
,[MedicaidID],[MedicareID],[ClientMemberNumber],ContractNbr,[PBPID],[ProductID],[BenefitLevel],[Language],[Gender],[HomePhoneNbr],[OtherPhoneNbr],[MemberEmail]
,[Address1],[Address2],[City],[State],[ZipCode],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[OtherAddress1],[OtherAddress2]
,[OtherCity],[OtherState],[OtherZipCode],[OtherAddressType],[SubscriberIndFlag],[RelationShipCode],[MaintenanceType],[MaintenanceReason],[BenefitStatus],[MedicarePlanCode]
,[EligReasonCode],[COBRAEvent],[EmploymentStatusCode],[StudentStatusCode],[HandicapInd],[DisabilityType],[MedicalCodeQualifier],[MedicalCode],[MaintenanceCode]
,[InsuranceLineCode],[CoverageLevel],[LateEnrollment],[CoInsurance],[CoPayment],[Deductible],[Premium],[SpendDown],[LineNbr],[PCPName],[PCPNPI]
,[PCPAddress1],[PCPAddress2],[PCPCity],[PCPState],[PCPZipCode],[PCPBusinessPhone],[COBFlag],[COBCarrierName],[COBPolicyNumber]
,[COBGroup],[COBRespcode],[COBcode],[COBServiceType],[BusinessCategory],[LineOfBusiness],[EligibilityStartDate],[EligibilityEndDate]
,@fileInfoID,@FileTrackID
,CONVERT(DATE, [BenefitStartDate]) ,CONVERT(DATE, [BenefitEndDate]) ,CONVERT(DATE, [PCPEffDate]) ,CONVERT(DATE, [PCPTermDate])
,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE),CONVERT(DATE, '20991231')
,1 ,'Y',IsMailingAddressForeign,IsMemberAddressForeign
FROM [elig].[stgEligBenefitData]
WHERE RecordStatus IN ('NR','CH')
and RecordStatus not like 'ERR_%'
AND FileTrackID = @FileTrackID;
*/
---------------------------------------------------
--/*
--get stg to mstr columns from EligibilityColumnValidation table
declare @sqlstr nvarchar(max),
		@mstrTableColumns nvarchar(max),
		@stgtableColumns nvarchar(max),
		@mstrtablename varchar(50)
			   
SELECT DISTINCT 
	 SUBSTRING(
        (
            SELECT case when ST1.SourceColumn in ('BenefitStartDate','BenefitEndDate','PCPEffDate','PCPTermDate' ) then ',CONVERT(DATE, r.' + ST1.SourceColumn + ')'  else ',r.'+ ST1.SourceColumn end  AS [text()]
			--SELECT case when st1.FileType='DFLT' then ','''+ st1.ClientColumn +''' as ' + ST1.rawtableColumn else ',r.'+ ST1.rawtableColumn end  AS [text()]
            FROM [elig].[EligibilityColumnValidation] ST1
            WHERE 1=1
			and ST1.ActiveFlag=1
			and ST1.ClientCode = ST2.ClientCode --and ST1.ID = ST2.ID
            ORDER BY ST1.ID
            FOR XML PATH ('')
        ), 2, 8000) [stgTableColumns],
	SUBSTRING(
        (
            SELECT ','+ST3.TargetColumn  AS [text()]
            FROM [elig].[EligibilityColumnValidation] ST3
            WHERE 1=1
			and ST3.ActiveFlag=1
			and ST3.ClientCode = ST2.ClientCode --and ST1.ID = ST2.ID
            ORDER BY ST3.ID
            FOR XML PATH ('')
        ), 2, 8000) [mstrtableColumns]
		into #temp
FROM [elig].[EligibilityColumnValidation] ST2
where 1=1
and ST2.ActiveFlag = 1
and ST2.ClientCode = @ClientCode
and ST2.FileType in ('ELIG','DFLT') 

select @stgtableColumns = stgTableColumns ,
	   @mstrtableColumns = mstrtableColumns 
from #temp

select distinct @mstrtablename = ST2.TargetTable,
				@FileType = ST2.FileType
FROM [elig].[EligibilityColumnValidation] ST2
where 1=1
and ST2.ActiveFlag=1
and ST2.ClientCode = @ClientCode 
and ST2.FileType in ('ELIG')

set @sqlstr = 'Insert into elig.mstrEligBenefitData (FileTrackID,DataSource,RecordStatus,toBeProcessed,' + @mstrTableColumns + ',FileID,RecordEffDate,RecordEndDate,isActive) 
				SELECT r.FileTrackID,r.DataSource,r.RecordStatus'+','+char(39)+'Y'+char(39)+',' + @stgtableColumns +',' + cast(@fileInfoID as varchar)+
				' ,CAST(GETDATE() AT TIME ZONE ''UTC'' AT TIME ZONE ''Eastern Standard Time'' AS DATE),CONVERT(DATE, ''20991231''),1
				from elig.stgEligBenefitData r
				WHERE RecordStatus IN (''NR'',''CH'') and RecordStatus not like ''ERR_%''
				and r.FileTrackID = ' +cast(@FileTrackId as varchar)

	print (@sqlstr)
	EXEC (@sqlstr)

drop table #temp
--*/
---------------------------------------------------
		SET @stepName = '400 Update Carrier and Health Plan'
		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		--EXEC sp_executesql @sql;
		--	RETURN 1
		--- Update elig.mstrEligBenefitData with insurence carrier id and insurence health plan id 
		set @sql = 'update elig.mstrEligBenefitData set mstrEligBenefitData.insCarrierID =  BenefitCrossWalk.InsuranceCarrierId	,mstrEligBenefitData.insHealthPlanID =  BenefitCrossWalk.InsuranceHealthPlanId	,mstrEligBenefitData.NHLinkID = ' + @strNHLink + '  from 	elig.mstrEligBenefitData Join    [elig].[BenefitCrossWalk] on ' + @strCrossWalkWhereClause + '   and   [BenefitCrossWalk].Isactive = 1 and  [BenefitCrossWalk].ClientCode = ''' + @ClientCode + '''where mstrEligBenefitData.FileTrackID =' + convert(VARCHAR, @FileTrackId) + ' and mstrEligBenefitData.toBeProcessed = ''Y''  and   mstrEligBenefitData.datasource = ''' + @dataSource + '''  and (mstrEligBenefitData.inscarrierid is null or mstrEligBenefitData.inshealthPlanID is null or  mstrEligBenefitData.NHLinkID is null )'

		PRINT 'CARRIER and HEALTHPLAN Update query'
		print (@sql)
		EXEC (@sql)

		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		SELECT @ErrorRecordCount = count(*)
		FROM [elig].[stgEligBenefitData]
		WHERE 1 = 1
		--and RecordStatus IN ('SE','ER','OLD_SPAN','XW_ERROR','DUP')
		and RecordStatus like 'ERR_%'
		and FileTrackID = @FileTrackID

		SET @stepName = '450 Update FileTrack Table'
		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		UPDATE [elig].[FileTrack]
		SET RecordsProcessed = @NewRecordCount + @ChangeRecordCount + @NoChangeRecordCount
			,RecordsErrored = @ErrorRecordCount
			,StatusCode = 400 -- added by Sujay
		WHERE FileTrackID = @FileTrackID

		SET @stepName = '500 Insert Stats - Start'
		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		exec elig.sp_load_elig_stats @FileTrackID

		SET @stepName = '500 Insert Stats - End'
		EXEC elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'S'

		/* RAJ
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		--   DECLARE @ErrorMessage NVARCHAR(4000);  
		--   DECLARE @ErrorSeverity INT;  
		--   DECLARE @ErrorState INT;  
		--   SELECT   
		--       @ErrorMessage = ERROR_MESSAGE(),  
		--       @ErrorSeverity = ERROR_SEVERITY(),  
		--       @ErrorState = ERROR_STATE();  
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION

			INSERT INTO dbo.DB_Errors (
				UserName
				,ErrorNumber
				,ErrorSeverity
				,ErrorState
				,ErrorProcedure
				,ErrorLine
				,ErrorMessage
				,ErrorDateTime
				)
			VALUES (
				@UserName
				,ERROR_NUMBER()
				,ERROR_SEVERITY()
				,ERROR_STATE()
				,@procedureName
				,ERROR_LINE()
				,ERROR_MESSAGE()
				,getdate()
				)

			-- RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END
	END CATCH
	RAJ */
	
	--Start Threshold add on 02232021  
	Declare  
	     @IsThresholdCheck varchar(1),@ThresholdValue varchar(500)
		,@Thresholdtype varchar(10),@Total VARCHAR(1),@ERR_DUP VARCHAR(1),@ERR_SPAN VARCHAR(1)
		,@ERR_XWALK VARCHAR(1),@ERR_REC VARCHAR(1),@ERR_OLDSPAN VARCHAR(1),@RecordsReceived bigint
		,@ERR_Message NVARCHAR(500),@ERR_Message_tracker VARCHAR(1),@ERR_DUP_Cnt bigint,@ERR_SPAN_Cnt bigint
		,@ERR_XWALK_Cnt bigint,@ERR_REC_Cnt bigint,@ERR_OLDSPAN_Cnt bigint
		,@TermedByAbsence_Cnt bigint,@TerminatedMembers_Cnt bigint
		,@TermedByAbsence VARCHAR(1),@TerminatedMembers VARCHAR(1);

		SELECT   @IsThresholdCheck = fi.IsThresholdCheck
				,@ThresholdValue = fi.ThresholdValue
				,@RecordsReceived = ft.RecordsReceived
		FROM elig.filetrack ft
		join elig.FileInfo fi on ft.ClientCode = fi.ClientCode 
								and ft.FileType = fi.FileType
								and ft.SnapshotFlag = fi.SnapshotFlag
		WHERE 1=1
		and ft.FileType='ELIG'
		and ft.FileTrackID = @FileTrackID

		if @Snapshot ='FULL' and @IsThresholdCheck = 'Y'  
		begin
			
			set @ERR_Message_tracker='N';
			set @ERR_Message = 'Threshold Msg Start:';

			if JSON_VALUE(@ThresholdValue,'$.ThresholdType') ='Number' 
			begin
				select 
					 @ERR_DUP=case when sum(case when RecordStatus = 'ERR_DUP' then 1 else 0 end) > cast(JSON_VALUE(@ThresholdValue,'$.ERR_DUP') as int) then 'Y' else 'N' end  --as ERR_DUP
					,@ERR_SPAN =case when sum(case when RecordStatus = 'ERR_SPAN' then 1 else 0 end)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_SPAN') as int) then 'Y' else 'N' end --as ERR_SPAN
					,@ERR_XWALK=case when sum(case when RecordStatus = 'ERR_XWALK' then 1 else 0 end)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_XWALK') as int) then 'Y' else 'N' end --as ERR_XWALK
					,@ERR_REC=case when sum(case when RecordStatus = 'ERR_REC' then 1 else 0 end)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_REC') as int) then 'Y' else 'N' end --as ERR_REC
					,@ERR_OLDSPAN=case when sum(case when RecordStatus = 'ERR_OLDSPAN' then 1 else 0 end)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_OLDSPAN') as int) then 'Y' else 'N' end --as ERR_OLDSPAN

					,@ERR_DUP_Cnt=sum(case when RecordStatus = 'ERR_DUP' then 1 else 0 end)
					,@ERR_SPAN_Cnt =sum(case when RecordStatus = 'ERR_SPAN' then 1 else 0 end)
					,@ERR_XWALK_Cnt=sum(case when RecordStatus = 'ERR_XWALK' then 1 else 0 end)
					,@ERR_REC_Cnt=sum(case when RecordStatus = 'ERR_REC' then 1 else 0 end)
					,@ERR_OLDSPAN_Cnt=sum(case when RecordStatus = 'ERR_OLDSPAN' then 1 else 0 end)

				from elig.errEligBenefitData
				where 1 = 1
				and filetrackid = @FileTrackID

				--For TR
				select 
						@TermedByAbsence = case when sum(TermedByAbsence) > cast(JSON_VALUE(@ThresholdValue,'$.TERMEDBY_ABSENCE') as int) then 'Y' else 'N' end  --as TermedByAbsence
--,@TerminatedMembers = case when sum(terminatedmembers) > cast(JSON_VALUE(@ThresholdValue,'$.TERMINATED_MEMBERS') as int) then 'Y' else 'N' end  --as TerminatedMembers --if necessary will enable  
					  ,@TermedByAbsence_Cnt = sum(TermedByAbsence) --TermedByAbsence
					  ,@TerminatedMembers_Cnt = sum(terminatedmembers) --TerminatedMembers
				from elig.EligibilityStats 
				where 1=1
				and FileTrackId = @FileTrackID
				and StatsType ='GENERAL'
			end

			if JSON_VALUE(@ThresholdValue,'$.ThresholdType') ='Percentage'
			begin
				select 'Percentage',@RecordsReceived RecordsReceived
				select 
					 @ERR_DUP=case when cast(round(((sum(case when RecordStatus = 'ERR_DUP' then 1 else 0 end) * 1.0 / @RecordsReceived ) * 100),2) as float) > cast(JSON_VALUE(@ThresholdValue,'$.ERR_DUP') as float) then 'Y' else 'N' end  --as ERR_DUP
					,@ERR_SPAN =case when cast(round(((sum(case when RecordStatus = 'ERR_SPAN' then 1 else 0 end) * 1.0 / @RecordsReceived ) * 100),2) as float)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_SPAN') as float) then 'Y' else 'N' end --as ERR_SPAN
					,@ERR_XWALK=case when cast(round(((sum(case when RecordStatus = 'ERR_XWALK' then 1 else 0 end) * 1.0 / @RecordsReceived ) * 100),2) as float)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_XWALK') as float) then 'Y' else 'N' end --as ERR_XWALK
					,@ERR_REC=case when cast(round(((sum(case when RecordStatus = 'ERR_REC' then 1 else 0 end) * 1.0 / @RecordsReceived ) * 100),2) as float) > cast(JSON_VALUE(@ThresholdValue,'$.ERR_REC') as float) then 'Y' else 'N' end --as ERR_REC
					,@ERR_OLDSPAN=case when cast(round(((sum(case when RecordStatus = 'ERR_OLDSPAN' then 1 else 0 end) * 1.0 / @RecordsReceived ) * 100),2) as float)  > cast(JSON_VALUE(@ThresholdValue,'$.ERR_OLDSPAN') as float) then 'Y' else 'N' end --as ERR_OLDSPAN

					,@ERR_DUP_Cnt=sum(case when RecordStatus = 'ERR_DUP' then 1 else 0 end)
					,@ERR_SPAN_Cnt =sum(case when RecordStatus = 'ERR_SPAN' then 1 else 0 end)
					,@ERR_XWALK_Cnt=sum(case when RecordStatus = 'ERR_XWALK' then 1 else 0 end)
					,@ERR_REC_Cnt=sum(case when RecordStatus = 'ERR_REC' then 1 else 0 end)
					,@ERR_OLDSPAN_Cnt=sum(case when RecordStatus = 'ERR_OLDSPAN' then 1 else 0 end)
				from elig.errEligBenefitData
				where 1 = 1
				and filetrackid = @FileTrackID

				--For TR
				select 
  					 @TermedByAbsence = case when cast(round(((sum(TermedByAbsence) * 1.0 / @RecordsReceived ) * 100),2) as float)  > cast(JSON_VALUE(@ThresholdValue,'$.TERMEDBY_ABSENCE') as float) then 'Y' else 'N' end  --as TermedByAbsence
-- @TerminatedMembers = case when cast(round(((sum(terminatedmembers) * 1.0 / @RecordsReceived ) * 100),2) as float)  > cast(JSON_VALUE(@ThresholdValue,'$.TERMINATED_MEMBERS') as float) then 'Y' else 'N' end --as TerminatedMembers --if necessary will enable  
					,@TermedByAbsence_Cnt = sum(TermedByAbsence) --TermedByAbsence
					,@TerminatedMembers_Cnt = sum(terminatedmembers) --TerminatedMembers
				from elig.EligibilityStats 
				where 1=1
				and FileTrackId = @FileTrackID
				and StatsType ='GENERAL'
			end

			if @ERR_DUP = 'Y'
			begin
			set @ERR_Message_tracker='Y';
			set @ERR_Message = @ERR_Message + ' Error @ ERR_DUP Count:' + cast(@ERR_DUP_Cnt as varchar); 
			print 'Error @ ERR_DUP'
			end-----------------------
				if @ERR_SPAN = 'Y'
				begin
				set @ERR_Message_tracker='Y';
				set @ERR_Message = @ERR_Message + ' Error @ ERR_SPAN Count:' + cast(@ERR_SPAN_Cnt as varchar);
				print 'Error @ ERR_SPAN'
				end-------------------
			if @ERR_XWALK = 'Y'
			begin
			set @ERR_Message_tracker='Y';
			set @ERR_Message = @ERR_Message + ' Error @ ERR_XWALK Count:' + cast(@ERR_XWALK_Cnt as varchar);
			print 'Error @ ERR_XWALK'
			end-----------------------
				if @ERR_REC = 'Y'
				begin
				set @ERR_Message_tracker='Y';
				set @ERR_Message = @ERR_Message + ' Error @ ERR_REC Count:' + cast(@ERR_REC_Cnt as varchar);
				print 'Error @ ERR_REC'
				end-------------------
			if @ERR_OLDSPAN ='Y'
			begin
			set @ERR_Message_tracker='Y';
			set @ERR_Message = @ERR_Message  + ' Error @ ERR_OLDSPAN Count:' + cast(@ERR_OLDSPAN_Cnt as varchar);
			print 'Error @ ERR_OLDSPAN'
			end-----------------------
				if @TermedByAbsence = 'Y'
				begin
				set @ERR_Message_tracker='Y';
				set @ERR_Message = @ERR_Message + ' Error @ TermedByAbsence Count:' + cast(@TermedByAbsence_Cnt as varchar); 
				print 'Error @ TermedByAbsence'
				end-----------------------
			if @TerminatedMembers = 'Y'
			begin
			set @ERR_Message_tracker='Y';
			set @ERR_Message = @ERR_Message + ' Error @ TerminatedMembers Count:' + cast(@TerminatedMembers_Cnt as varchar); 
			print 'Error @ TerminatedMembers'
			end-----------------------

		--Final to fail the process
		if @ERR_Message_tracker = 'Y'
		begin
			print @ERR_Message;
			select 1/0 as Thresholderror;
		end
	end
	--End Of Threshold add on 02232021  

	COMMIT TRANSACTION elig_load_stg_to_elig
	PRINT 'SUCCESS'
	

	END TRY
	

	BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
	--Added for Threshold
	if @ERR_Message_tracker = 'Y'
	begin
	set @ErrorMessage = @ErrorMessage +' **Custom Message** '+ @ERR_Message;
	end
	--E.O.Threshold

		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION elig_load_stg_to_elig
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END



GO


SELECT DISTINCT 
	 SUBSTRING(
        (
            SELECT case when ST1.SourceColumn in ('BenefitStartDate','BenefitEndDate','PCPEffDate','PCPTermDate' ) then ',CONVERT(DATE, r.' + ST1.SourceColumn + ')'  else ',r.'+ ST1.SourceColumn end  AS [text()]
			--SELECT case when st1.FileType='DFLT' then ','''+ st1.ClientColumn +''' as ' + ST1.rawtableColumn else ',r.'+ ST1.rawtableColumn end  AS [text()]
            FROM [elig].[EligibilityColumnValidation] ST1
            WHERE 1=1
			and ST1.ActiveFlag=1
			and ST1.ClientCode = ST2.ClientCode --and ST1.ID = ST2.ID
            ORDER BY ST1.ID
            FOR XML PATH ('')
        ), 2, 8000) [stgTableColumns],
	SUBSTRING(
        (
            SELECT ','+ST3.TargetColumn  AS [text()]
            FROM [elig].[EligibilityColumnValidation] ST3
            WHERE 1=1
			and ST3.ActiveFlag=1
			and ST3.ClientCode = ST2.ClientCode --and ST1.ID = ST2.ID
            ORDER BY ST3.ID
            FOR XML PATH ('')
        ), 2, 8000) [mstrtableColumns]
		into #temp1
FROM [elig].[EligibilityColumnValidation] ST2
where 1=1
and ST2.ActiveFlag = 1
and ST2.ClientCode = 'H223'
and ST2.FileType in ('ELIG','DFLT') 

select * from #temp1

select top 10 * from [elig].[EligibilityColumnValidation]


SELECT DISTINCT 
	 SUBSTRING(
        (
            SELECT case when ST1.SourceColumn in ('BenefitStartDate','BenefitEndDate','PCPEffDate','PCPTermDate' ) then ',CONVERT(DATE, r.' + ST1.SourceColumn + ')'  else ',r.'+ ST1.SourceColumn end  AS [text()]
			--SELECT case when st1.FileType='DFLT' then ','''+ st1.ClientColumn +''' as ' + ST1.rawtableColumn else ',r.'+ ST1.rawtableColumn end  AS [text()]
            FROM [elig].[EligibilityColumnValidation] ST1
            WHERE 1=1
			and ST1.ActiveFlag=1
			and ST1.ClientCode = ST2.ClientCode --and ST1.ID = ST2.ID
            ORDER BY ST1.ID
            FOR XML PATH ('')
       ), 2, 8000) [stgTableColumns],



select
('a.'+'['+COLUMN_NAME +']'+ ', ') as [text()] from information_schema.columns where 1=1   
and TABLE_NAME = 'EligibilityColumnValidation' 
order by ORDINAL_POSITION
FOR XML PATH ('')
