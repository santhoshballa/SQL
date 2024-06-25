/****** Object:  StoredProcedure [dbo].[sp_SearchMemberPP]    Script Date: 8/6/2021 3:54:10 PM ******/
/*

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_SearchMemberPP](
       @NHMemberID         NVARCHAR(50) = NULL,                         
       @FirstName          NVARCHAR(250) = NULL,                        
       @LastName           NVARCHAR(50) = NULL,                        
       @DateOfBirth        VARCHAR(20) = NULL,                        
       @Address1           NVARCHAR(500) = NULL,                        
       @Address2           NVARCHAR(500) = NULL,                        
       @City               NVARCHAR(50) = NULL,                        
       @State              NVARCHAR(10) = NULL,                        
       @ZipCode            NVARCHAR(10) = NULL,                         
       @Phone               NVARCHAR(50) = NULL,            
       @ProviderID NVARCHAR(50) = NULL,                  
       @searchType NVARCHAR(50) = NULL,            
       @InsuranceHealthPlanNumber NVARCHAR(250) = NULL,        
       @ProviderCode NVARCHAR(20) = NULL        
  )                        
AS                        
BEGIN                  
DECLARE @SQLSubQuery AS NVARCHAR(4000)                  
DECLARE @condition AS NVARCHAR(5)        
if(@ProviderCode=NULL)        
begin        
SET @ProviderCode = (SELECT PROVIDERCODE FROM [provider].[ProviderProfiles] WHERE [ProviderId] = @ProviderID)        
end        
IF(@ProviderCode = '180000')        
BEGIN  
SET @SQLSubQuery = 'select distinct m.firstname,m.middlename,m.lastname,m.nhmemberid,convert(varchar(10), m.DateOfBirth, 101) as DateOfBirth,ml.address1,ml.address2,ml.city,ml.state,case when p.phonenumber = ''0'' then ''9999999999'' else p.phonenumber end phonenumber,ml.zipcode,                  
					convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) as appointmentDate,          
					row_number() over (partition by nhmemberid order by  convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) desc) AS Rownum,                 
					ISNULL(CONCAT(up.FirstName, '''',up.LastName),'''') AS AppointmentWith,CONCAT(l.Address1,'' '','','',l.address2,'' '','','',l.city,'' '',l.state,'' '','','',l.zip) AS ApptLocationAddress,INS.InsuranceCarrierName ,INS.InsuranceNbr            
					from [provider].[MemberProfiles] m                   
					inner join [provider].[MemberLocations] ml on ml.memberprofileid = m.memberprofileid and ml.isactive = 1   AND ml.IsPreferredAddress=1              
					left outer join [provider].[MemberPhoneNumbers] p on p.memberprofileid = m.memberprofileid and p.isactive = 1                 
					inner join [provider].[MemberChartData] d on  json_value(d.ProcessData, ''$.MemberProfileId'') = m.memberprofileid and d.isactive = 1 and d.minorprocessid = 16                  
					LEFT JOIN [provider].[HCPProviderProfile] h ON h.HCPID = JSON_VALUE(D.ProcessData, ''$.HCPUserProfileId'')                  
					LEFT JOIN [provider].[Locations] l ON l.LocationId = d.LocationId       
					LEFT JOIN [provider].[ProviderUserLocations] pul ON pul.LocationId = d.LocationId        
					LEFT JOIN [auth].[UserProfiles] up ON up.UserProfileId = pul.UserProfileId AND up.isactive = 1 and  json_value(d.ProcessData, ''$.HCPUserProfileId'') = up.UserProfileId and CONCAT(up.FirstName, '''',up.LastName) <> ''''           
					LEFT JOIN [dbo].[GetActiveInsuranceByMember] INS on INS.MemberProfileId=M.MemberProfileId  
					where m.isactive = 1 AND  ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''')<> '''''
END        
ELSE        
BEGIN   
     
SET @SQLSubQuery = 'select distinct m.firstname,m.middlename,m.lastname,m.nhmemberid,convert(varchar(10), m.DateOfBirth, 101) as DateOfBirth,ml.address1,ml.address2,ml.city,ml.state,case when p.phonenumber = ''0'' then ''9999999999'' else p.phonenumber end phonenumber,ml.zipcode,                  
					convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) as appointmentDate,row_number() over (partition by nhmemberid order by  convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) desc) AS Rownum,
					ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''') AS AppointmentWith,CONCAT(l.Address1,'' '','','',l.address2,'' '','','',l.city,'' '','','',l.state,'' '','','',l.zip) AS ApptLocationAddress,INS.InsuranceCarrierName ,INS.InsuranceNbr                     
					from [provider].[MemberProfiles] m                   
					inner join [provider].[MemberLocations] ml on ml.memberprofileid = m.memberprofileid and ml.isactive = 1   AND ml.IsPreferredAddress=1              
					left outer join [provider].[MemberPhoneNumbers] p on p.memberprofileid = m.memberprofileid and p.isactive = 1         
					inner join [provider].[MemberChartData] d on  json_value(d.ProcessData, ''$.MemberProfileId'') = m.memberprofileid and d.isactive = 1  and d.minorprocessid = 16               
					LEFT JOIN [provider].[HCPProviderProfile] h ON h.HCPID = JSON_VALUE(D.ProcessData, ''$.HCPUserProfileId'')                  
					LEFT JOIN [provider].[Locations] l ON l.LocationId = d.LocationId          
					LEFT JOIN [provider].[ProviderUserLocations] pul ON pul.LocationId = d.LocationId       
					LEFT JOIN [auth].[UserProfiles] up ON up.UserProfileId = pul.UserProfileId AND up.isactive = 1  and  json_value(d.ProcessData, ''$.HCPUserProfileId'') = up.UserProfileId  and CONCAT(up.FirstName, '''',up.LastName) <> ''''       
					LEFT JOIN [dbo].[GetActiveInsuranceByMember] INS on INS.MemberProfileId=M.MemberProfileId            
					where m.isactive = 1 AND  ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''') <> '''' and d.providerid = '''+@ProviderID +''''                  
END        
                    
     
   IF (@searchType = 'quick')              
   BEGIN          
   IF(@ProviderCode = '180000')        
   BEGIN            
    IF @FirstName IS NOT NULL        
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' OR m.lastname like ''%'+@FirstName+'%'')'              
    IF @LastName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@LastName+'%'' OR m.lastname like ''%'+@LastName+'%'')'              
                   
    IF @NHMemberID IS NOT NULL                             
      SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
    IF @DateOfBirth is not null                          
        set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''              
    IF @ZipCode is not null                          
      set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''              
    IF (@Phone is not null)                        
      set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
    IF (@Address1 is not null)                                         
       set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''               
    IF (@Address2 is not null)                                
      set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''              
    IF (@City is not null)                                 
      set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
    IF (@State is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
                    
    IF (@InsuranceHealthPlanNumber is not null)                        
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''                             
   END        
   ELSE        
   BEGIN        
     IF @FirstName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' OR m.lastname like ''%'+@FirstName+'%'')'              
     
    IF @LastName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@LastName+'%'' OR m.lastname like ''%'+@LastName+'%'')'              
                   
    IF @NHMemberID IS NOT NULL                             
      SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
    IF @DateOfBirth is not null                          
        set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''              
    IF @ZipCode is not null                    
      set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''              
    IF (@Phone is not null)                        
      set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
    IF (@Address1 is not null)                                         
       set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''               
    IF (@Address2 is not null)                                
      set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''              
    IF (@City is not null)                                 
      set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
    IF (@State is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
                    
    IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''             
   END         
  END              
              
  ELSE IF (@searchType = 'Advance')              
                 
   BEGIN              
    IF(@ProviderCode = '180000')        
       BEGIN            
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.firstname like ''%'+@FirstName+'%'''              
   IF ((@FirstName IS NULL) AND (@LastName IS NOT NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.lastname like ''%'+@LastName+'%'''              
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NOT NULL))              
   set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' AND m.lastname like ''%'+@LastName+'%'')'              
  IF @NHMemberID IS NOT NULL                             
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
  IF @DateOfBirth is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''           
  IF @ZipCode is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''               
  IF (@Phone is not null)                        
    set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
  IF (@Address1 is not null)                                         
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''                 
  IF (@Address2 is not null)                                
    set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''                 
  IF (@City is not null)                                 
    set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
  IF (@State is not null)                              
                set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
  IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''              
END              
ELSE        
BEGIN        
  IF ((@FirstName IS NOT NULL) AND (@LastName IS NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.firstname like ''%'+@FirstName+'%'''              
   IF ((@FirstName IS NULL) AND (@LastName IS NOT NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.lastname like ''%'+@LastName+'%'''              
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NOT NULL))              
   set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' AND m.lastname like ''%'+@LastName+'%'')'              
  IF @NHMemberID IS NOT NULL                             
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
  IF @DateOfBirth is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''           
  IF @ZipCode is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''               
  IF (@Phone is not null)                        
    set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
  IF (@Address1 is not null)                                         
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''                 
  IF (@Address2 is not null)                                
    set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''                 
  IF (@City is not null)                                 
    set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
  IF (@State is not null)                              
                set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
  IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''            
END              
  END              
           
   IF(@ProviderCode = '180000')        
   BEGIN         
   SET @SQLSubQuery = 'select top 50 ROW_NUMBER() OVER (ORDER BY C.RowNum) as RowID,firstname,middlename,lastname,nhmemberid,DateOfBirth,address1,address2,city,state,phonenumber,zipcode,appointmentDate,AppointmentWith,ApptLocationAddress,InsuranceCarrierName as healthplanname,InsuranceNbr as PlanProgramID  from ('+@SQLSubQuery+') C WHERE C.RowNum = 1 order by nhmemberid'        
   END        
   ELSE        
   BEGIN        
    SET @SQLSubQuery = 'select top 50 ROW_NUMBER() OVER (ORDER BY C.RowNum) as RowID,firstname,middlename,lastname,nhmemberid,DateOfBirth,address1,address2,city,state,phonenumber,zipcode,appointmentDate,AppointmentWith,ApptLocationAddress,InsuranceCarrierName as healthplanname,InsuranceNbr as PlanProgramID  from ('+@SQLSubQuery+') C WHERE C.RowNum = 1 order by nhmemberid'         
   END        
           
           
           
  PRINT @SQLSubQuery        
   exec sp_ExecuteSQL @SQLSubQuery        
           
           
             
    IF @@ERROR <> 0 GoTo ErrorHandler                        
    Set NoCount OFF                        
    Return(0)                        
                          
ErrorHandler:                  
    Return(@@ERROR)                        
                     
END 

GO

*/





--ALTER PROCEDURE [dbo].[sp_SearchMemberPP](
declare
       @NHMemberID         NVARCHAR(50) = 'NH202004832037',                         
       @FirstName          NVARCHAR(250) = null,                        
       @LastName           NVARCHAR(50) = null,                        
       @DateOfBirth        VARCHAR(20) = NULL,                        
       @Address1           NVARCHAR(500) = NULL,                        
       @Address2           NVARCHAR(500) = NULL,                        
       @City               NVARCHAR(50) = NULL,                        
       @State              NVARCHAR(10) = NULL,                        
       @ZipCode            NVARCHAR(10) = NULL,                         
       @Phone               NVARCHAR(50) = NULL,            
       @ProviderID NVARCHAR(50) = null,                  
       @searchType NVARCHAR(50) = 'quick',            
       @InsuranceHealthPlanNumber NVARCHAR(250) = NULL,        
       @ProviderCode NVARCHAR(20) = '180000'        
--  )                        
                        
BEGIN                  
DECLARE @SQLSubQuery AS NVARCHAR(4000)                  
DECLARE @condition AS NVARCHAR(5)        
if(@ProviderCode=NULL)        
begin        
SET @ProviderCode = (SELECT PROVIDERCODE FROM [provider].[ProviderProfiles] WHERE [ProviderId] = @ProviderID)        
end 

IF(@ProviderCode = '180000')        
BEGIN
select 1

SET @SQLSubQuery = 'select distinct m.firstname,m.middlename,m.lastname,m.nhmemberid,convert(varchar(10), m.DateOfBirth, 101) as DateOfBirth,ml.address1,ml.address2,ml.city,ml.state,case when p.phonenumber = ''0'' then ''9999999999'' else p.phonenumber end phonenumber,ml.zipcode,                  
					convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) as appointmentDate,          
					row_number() over (partition by nhmemberid order by  convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) desc) AS Rownum,                 
					ISNULL(CONCAT(up.FirstName, '''',up.LastName),'''') AS AppointmentWith,CONCAT(l.Address1,'' '','','',l.address2,'' '','','',l.city,'' '',l.state,'' '','','',l.zip) AS ApptLocationAddress,INS.InsuranceCarrierName ,INS.InsuranceNbr            
					from [provider].[MemberProfiles] m                   
					inner join [provider].[MemberLocations] ml on ml.memberprofileid = m.memberprofileid and ml.isactive = 1   AND ml.IsPreferredAddress=1              
					left outer join [provider].[MemberPhoneNumbers] p on p.memberprofileid = m.memberprofileid and p.isactive = 1                 
					inner join [provider].[MemberChartData] d on  json_value(d.ProcessData, ''$.MemberProfileId'') = m.memberprofileid and d.isactive = 1 and d.minorprocessid = 16                  
					LEFT JOIN [provider].[HCPProviderProfile] h ON h.HCPID = JSON_VALUE(D.ProcessData, ''$.HCPUserProfileId'')                  
					LEFT JOIN [provider].[Locations] l ON l.LocationId = d.LocationId       
					LEFT JOIN [provider].[ProviderUserLocations] pul ON pul.LocationId = d.LocationId        
					LEFT JOIN [auth].[UserProfiles] up ON up.UserProfileId = pul.UserProfileId AND up.isactive = 1 and  json_value(d.ProcessData, ''$.HCPUserProfileId'') = up.UserProfileId and CONCAT(up.FirstName, '''',up.LastName) <> ''''           
					LEFT JOIN [dbo].[GetActiveInsuranceByMember] INS on INS.MemberProfileId=M.MemberProfileId  
					where m.isactive = 1 AND  ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''')<> '''''
END

ELSE        
BEGIN   
select 2,@SQLSubQuery 
SET @SQLSubQuery = 'select distinct m.firstname,m.middlename,m.lastname,m.nhmemberid,convert(varchar(10), m.DateOfBirth, 101) as DateOfBirth,ml.address1,ml.address2,ml.city,ml.state,case when p.phonenumber = ''0'' then ''9999999999'' else p.phonenumber end phonenumber,ml.zipcode,                  
					convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) as appointmentDate,row_number() over (partition by nhmemberid order by  convert(varchar(10),json_value(d.ProcessData, ''$.appointmentDate''),101) desc) AS Rownum,
					ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''') AS AppointmentWith,CONCAT(l.Address1,'' '','','',l.address2,'' '','','',l.city,'' '','','',l.state,'' '','','',l.zip) AS ApptLocationAddress,INS.InsuranceCarrierName ,INS.InsuranceNbr                     
					from [provider].[MemberProfiles] m                   
					inner join [provider].[MemberLocations] ml on ml.memberprofileid = m.memberprofileid and ml.isactive = 1   AND ml.IsPreferredAddress=1              
					left outer join [provider].[MemberPhoneNumbers] p on p.memberprofileid = m.memberprofileid and p.isactive = 1         
					inner join [provider].[MemberChartData] d on  json_value(d.ProcessData, ''$.MemberProfileId'') = m.memberprofileid and d.isactive = 1  and d.minorprocessid = 16               
					LEFT JOIN [provider].[HCPProviderProfile] h ON h.HCPID = JSON_VALUE(D.ProcessData, ''$.HCPUserProfileId'')                  
					LEFT JOIN [provider].[Locations] l ON l.LocationId = d.LocationId          
					LEFT JOIN [provider].[ProviderUserLocations] pul ON pul.LocationId = d.LocationId       
					LEFT JOIN [auth].[UserProfiles] up ON up.UserProfileId = pul.UserProfileId AND up.isactive = 1  and  json_value(d.ProcessData, ''$.HCPUserProfileId'') = up.UserProfileId  and CONCAT(up.FirstName, '''',up.LastName) <> ''''       
					LEFT JOIN [dbo].[GetActiveInsuranceByMember] INS on INS.MemberProfileId=M.MemberProfileId            
					where m.isactive = 1 AND  ISNULL(CONCAT(up.FirstName, '''',up. LastName),'''') <> '''' and d.providerid = '''+@ProviderID +''''                  
END        

select 3,@SQLSubQuery                   
     
   IF (@searchType = 'quick')              
   BEGIN          
   IF(@ProviderCode = '180000')        
   BEGIN            
    IF @FirstName IS NOT NULL        
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' OR m.lastname like ''%'+@FirstName+'%'')'              
    IF @LastName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@LastName+'%'' OR m.lastname like ''%'+@LastName+'%'')'              
                   
    IF @NHMemberID IS NOT NULL                             
      SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
    IF @DateOfBirth is not null                          
        set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''              
    IF @ZipCode is not null                          
      set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''              
    IF (@Phone is not null)                        
      set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
    IF (@Address1 is not null)                                         
       set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''               
    IF (@Address2 is not null)                                
      set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''              
    IF (@City is not null)                                 
      set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
    IF (@State is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
                    
    IF (@InsuranceHealthPlanNumber is not null)                        
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''                             
   END        
   ELSE        
   BEGIN        
     IF @FirstName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' OR m.lastname like ''%'+@FirstName+'%'')'              
     
    IF @LastName IS NOT NULL              
    set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@LastName+'%'' OR m.lastname like ''%'+@LastName+'%'')'              
                   
    IF @NHMemberID IS NOT NULL                             
      SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
    IF @DateOfBirth is not null                          
        set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''              
    IF @ZipCode is not null                    
      set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''              
    IF (@Phone is not null)                        
      set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
    IF (@Address1 is not null)                                         
       set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''               
    IF (@Address2 is not null)                                
      set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''              
    IF (@City is not null)                                 
      set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
    IF (@State is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
                    
    IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''             
   END         
  END              
              
  ELSE IF (@searchType = 'Advance')              
                 
   BEGIN              
    IF(@ProviderCode = '180000')        
       BEGIN            
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.firstname like ''%'+@FirstName+'%'''              
   IF ((@FirstName IS NULL) AND (@LastName IS NOT NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.lastname like ''%'+@LastName+'%'''              
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NOT NULL))              
   set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' AND m.lastname like ''%'+@LastName+'%'')'              
  IF @NHMemberID IS NOT NULL                             
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
  IF @DateOfBirth is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''           
  IF @ZipCode is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''               
  IF (@Phone is not null)                        
    set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
  IF (@Address1 is not null)                                         
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''                 
  IF (@Address2 is not null)                                
    set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''                 
  IF (@City is not null)                                 
    set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
  IF (@State is not null)                              
                set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
  IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''              
END              
ELSE        
BEGIN        
  IF ((@FirstName IS NOT NULL) AND (@LastName IS NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.firstname like ''%'+@FirstName+'%'''              
   IF ((@FirstName IS NULL) AND (@LastName IS NOT NULL))              
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.lastname like ''%'+@LastName+'%'''              
   IF ((@FirstName IS NOT NULL) AND (@LastName IS NOT NULL))              
   set @SQLSubQuery = @SQLSubQuery + ' and (m.firstname like ''%'+@FirstName+'%'' AND m.lastname like ''%'+@LastName+'%'')'              
  IF @NHMemberID IS NOT NULL                             
   SET @SQLSubQuery = @SQLSubQuery + ' and  m.NHMemberID = '''+@NHMemberID+''''              
  IF @DateOfBirth is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  m.DateOfBirth = '''+@DateOfBirth+''''           
  IF @ZipCode is not null                          
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.ZipCode = '''+@ZipCode+''''               
  IF (@Phone is not null)                        
    set @SQLSubQuery = @SQLSubQuery+ ' and  p.phonenumber = '''+@Phone+''''              
  IF (@Address1 is not null)                                         
    set @SQLSubQuery = @SQLSubQuery + ' and  ml.Address1 = '''+@Address1+''''                 
  IF (@Address2 is not null)                                
    set @SQLSubQuery = @SQLSubQuery +' and ml.Address2 = '''+@Address2+''''                 
  IF (@City is not null)                                 
    set @SQLSubQuery = @SQLSubQuery +' and  ml.City = '''+@City+''''                     
  IF (@State is not null)                              
                set @SQLSubQuery = @SQLSubQuery +' and ml.State = '''+@State+''''                
  IF (@InsuranceHealthPlanNumber is not null)                              
                 set @SQLSubQuery = @SQLSubQuery +' and INS.InsuranceNbr = '''+@InsuranceHealthPlanNumber+''''            
END              
  END              
           
   IF(@ProviderCode = '180000')
   BEGIN         
   SET @SQLSubQuery = 'select top 50 ROW_NUMBER() OVER (ORDER BY C.RowNum) as RowID,firstname,middlename,lastname,nhmemberid,DateOfBirth,address1,address2,city,state,phonenumber,zipcode,appointmentDate,AppointmentWith,ApptLocationAddress,InsuranceCarrierName as healthplanname,InsuranceNbr as PlanProgramID  from ('+@SQLSubQuery+') C WHERE C.RowNum = 1 order by nhmemberid'        
   END        
   ELSE        
   BEGIN        
    SET @SQLSubQuery = 'select top 50 ROW_NUMBER() OVER (ORDER BY C.RowNum) as RowID,firstname,middlename,lastname,nhmemberid,DateOfBirth,address1,address2,city,state,phonenumber,zipcode,appointmentDate,AppointmentWith,ApptLocationAddress,InsuranceCarrierName as healthplanname,InsuranceNbr as PlanProgramID  from ('+@SQLSubQuery+') C WHERE C.RowNum = 1 order by nhmemberid'         
   END        

END 

select 4, @SQLSubQuery 
       
   --exec sp_ExecuteSQL @SQLSubQuery        
 

select 
top 50 ROW_NUMBER() OVER (ORDER BY C.RowNum) as RowID,firstname,middlename,lastname,nhmemberid,DateOfBirth,address1,address2,city,state,
phonenumber,zipcode,appointmentDate,AppointmentWith,ApptLocationAddress,InsuranceCarrierName as healthplanname,InsuranceNbr as PlanProgramID  
from 
(
select distinct m.firstname,m.middlename,m.lastname,m.nhmemberid,convert(varchar(10), m.DateOfBirth, 101) as DateOfBirth,
ml.address1,ml.address2,ml.city,ml.state,case when p.phonenumber = '0' then '9999999999' else p.phonenumber end phonenumber,ml.zipcode,
convert(varchar(10),json_value(d.ProcessData, '$.appointmentDate'),101) as appointmentDate,
row_number() over (partition by nhmemberid order by  convert(varchar(10),json_value(d.ProcessData, '$.appointmentDate'),101) desc) AS Rownum,  -- pick the latest appointment date using row number
ISNULL(CONCAT(up.FirstName, '',up.LastName),'') AS AppointmentWith,
CONCAT(l.Address1,' ',',',l.address2,' ',',',l.city,' ',l.state,' ',',',l.zip) AS ApptLocationAddress,
INS.InsuranceCarrierName ,INS.InsuranceNbr from [provider].[MemberProfiles] m 
inner join [provider].[MemberLocations] ml on ml.memberprofileid = m.memberprofileid and ml.isactive = 1  AND ml.IsPreferredAddress=1  
left outer join [provider].[MemberPhoneNumbers] p on p.memberprofileid = m.memberprofileid and p.isactive = 1 
inner join [provider].[MemberChartData] d on  json_value(d.ProcessData, '$.MemberProfileId') = m.memberprofileid and d.isactive = 1 and d.minorprocessid = 16
LEFT JOIN [provider].[HCPProviderProfile] h ON h.HCPID = JSON_VALUE(D.ProcessData, '$.HCPUserProfileId')
LEFT JOIN [provider].[Locations] l ON l.LocationId = d.LocationId
LEFT JOIN [provider].[ProviderUserLocations] pul ON pul.LocationId = d.LocationId

LEFT JOIN [auth].[UserProfiles] up ON up.UserProfileId = pul.UserProfileId AND up.isactive = 1 and  json_value(d.ProcessData, '$.HCPUserProfileId') = up.UserProfileId and CONCAT(up.FirstName, '',up.LastName) <> '' 
LEFT JOIN [dbo].[GetActiveInsuranceByMember] INS on INS.MemberProfileId=M.MemberProfileId         
where m.isactive = 1 AND  ISNULL(CONCAT(up.FirstName, '',up. LastName),'')<> '' and  m.NHMemberID = 'NH202004832037') C 
WHERE C.RowNum = 1 order by nhmemberid



select * from [provider].[MemberProfiles] m where m.NHMemberID = 'NH202004832037' -- 234568
select * from [provider].[MemberLocations] ml where ml.IsActive =1 and ml.IsPreferredAddress = 1 and ml.MemberProfileId = 234568 -- 368711 location id
select * from [provider].[MemberPhoneNumbers] p where p.MemberProfileId = 234568
select * from [provider].[MemberChartData] d where  json_value(d.ProcessData, '$.MemberProfileId') = 234568 and d.isactive = 1 and d.minorprocessid = 16 -- MemberChardDataID | 618489, HCPUserProfileId: 109, locationID = 1028
select * from [provider].[HCPProviderProfile] h where h.hcpid = 109  -- IsActive = 0
select * from [provider].[Locations] l where l.locationid = 1028
select * from [provider].[ProviderUserLocations] pul where pul.locationid = 1028 order by IsActive desc
select * from [auth].[UserProfiles] up 
where up.UserProfileId in ( select userProfileId from [provider].[ProviderUserLocations] pul where pul.locationid = 1028) and up.IsActive = 1 and up.UserProfileID =  109 and CONCAT(up.FirstName, '',up.LastName) <> ''

select * from [provider].[MemberChartData] d where json_value(d.ProcessData, '$.HCPUserProfileId') in ( select UserProfileId from [auth].[UserProfiles] up where up.UserProfileID =  109 and up.IsActive = 1 and CONCAT(up.FirstName, '',up.LastName) <> '' )

select * from auth.userprofiles up where up.UserProfileID =  109
select * from auth.userprofiles where FirstName = 'Jennifer' and LastName like 'Robinson'
select userprofileid, designation , isactive, firstname, lastname, Username from auth.userprofiles where FirstName = 'Jennifer' and LastName like 'Robinson'