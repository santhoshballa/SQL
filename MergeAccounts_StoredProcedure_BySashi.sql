/****** Object:  StoredProcedure [support].[Merge_Members]    Script Date: 3/30/2021 3:08:04 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

  
  
CREATE procedure [support].[Merge_Members]  
(  
 @ID int    
)  
AS  
  
-- =============================================  
-- Name : support.Merge_Members   
-- Purpose : Merge the members data and keep the new member active  
-- Usage : Support merge member requests.   
-- Author : Shashidhar neela  
-- Change History :   
-- Name        Date  Comment  
-- Shashidhar   3/19/2021 Created  
--  exec support.Merge_Members     
-- =============================================  
   
  
  
Begin  
  
-- Declare variables   
Declare @OldNHMemberID Varchar(100)  
Declare @NewNHMemberID Varchar(100)  
Declare @master_memberinsuranceid varchar(100)  
Declare @provider_memberinsuranceid varchar(100)  
Declare @OtcCardnumber varchar(50)   
Declare @user varchar(100) ;   
Declare @today datetime ;   
Declare @ErrorMessage NVARCHAR(4000);    
Declare @ErrorSeverity INT;    
Declare @ErrorState INT;    
  
-- Assign variables   
set @user = suser_name ()   
set @today = getdate ()   
  
select top 1   
 @OldNHMemberID = OldNHMemberID,  
 @NewNHMemberID = NewNHMemberID,  
 @master_memberinsuranceid = master_memberinsuranceid,  
 @provider_memberinsuranceid = provider_memberinsuranceid,  
 @OtcCardnumber = OtcCardnumber  
from   
 elig.MergedNHMemberIDS   
where   
 ID = @ID   
  
 Begin Try   
  
 Begin Transaction mergemebers  
  if not exists ( select 1 from elig.MergedNHMemberIDS where ID = @ID      )   
  Begin   
   print ' The member details does not exist in the MergedNHMemberIDS table  '  
  End  
  
  
  else if  exists ( select 1 from elig.MergedNHMemberIDS where ID = @ID  and is_processed =1    )   
  Begin   
   print ' The members are already merged '  
  End  
  
  Else Begin   
    
  --100   
   print concat ( 100, '-update callcenter.callconversations' );   
   update   
    cc  
   set   
    cc.MemberNHMemberId = @NEWNHMemberID,   
    ModifyDate = @today,   
    ModifyUser =  @user     
   FROM   
       callcenter.callconversations cc  
    LEFT OUTER JOIN (SELECT  
         callconversationid,  
         createDate EventCreateDate,  
         createUser EventCreateUser,  
         EventName = (SELECT EventName FROM [CallCenter].[Events] ce WHERE ce.ID = cpe.eventID AND EventTriggerBy = 'DISPOSITION'),  
         ReferenceIDsData  
         FROM callcenter.callpageevents cpe  
         WHERE 1 = 1 AND EXISTS (SELECT 1 FROM [CallCenter].[Events] ce1 WHERE ce1.ID = cpe.eventid AND EventTriggerBy = 'DISPOSITION')  
        ) e ON   
     (e.callconversationid = cc.callconversationid)  
     WHERE membernhmemberid = @OLDNHMemberID   
  
   print concat ( @@rowcount , ' - Rows are updated in callcenter.callconversations' )  
  
  --200  
   print concat ( 200, '-update provider.MemberCharts' );   
   update mc  
   set   
    mc.memberprofileid = (select memberprofileid from [provider].[MemberProfiles] where nhmemberid = @NEWNHMemberID),   
    ModifyDate = @today,   
    ModifyUser =  @user      
   from [provider].[MemberCharts] mc  
   where   
    memberprofileid in (select memberprofileid from [provider].[MemberProfiles] where nhmemberid = @OLDNHMemberID)   
  
   print concat ( @@rowcount , ' - Rows are updated in [provider].[MemberCharts]' )  
  
  --300  
   print concat ( 300, '-update provider.MemberChartData' );  
   update mcd  
   set   
    mcd.ProcessData = JSON_MODIFY(ProcessData, '$.MemberProfileId', (select memberprofileid from [provider].[MemberProfiles] where nhmemberid = @NEWNHMemberID)  ),   
    ModifyDate = @today,   
    ModifyUser =  @user      
   from provider.MemberChartData mcd  
   where memberchartid in (  
      select memberchartid from [provider].[MemberCharts]  
      where memberprofileid in (  
       select memberprofileid from [provider].[MemberProfiles]  
       where nhmemberid = @OLDNHMemberID ))  
  
   print concat ( @@rowcount , ' - Rows are updated in provider.MemberChartData' )  
  
  --400  
   print concat ( 400, '- update master.Members , provider.Memberprofiles' );  
    
   UPDATE  
    master.Members   
   SET   
    IsActive=0,   
    ModifyDate = @today,   
    ModifyUser =  @user   
   WHERE   
    NHMemberID = @OLDNHMemberID  
   print concat ( @@rowcount , ' - Rows are updated in master.Members' )  
  
   UPDATE   
    provider.Memberprofiles   
   SET   
    IsActive=0,  
    ModifyDate = @today,   
    ModifyUser =  @user      
   WHERE   
    NHMemberID = @OLDNHMemberID  
   print concat ( @@rowcount , ' - Rows are updated in provider.Memberprofiles' )  
  
  
  --500  
   print concat ( 500, '-update orders.orders' );    
   update o  
   set    
    o.NHMemberId = @NEWNHMemberID,   
       o.OrderBy = @NEWNHMemberID,  
    ModifyDate = @today,   
    ModifyUser =  @user    
   from orders.orders o  
   where   
    o.nhmemberid = @OLDNHMemberID  
    and o.IsActive = 1  
  
   print concat ( @@rowcount , ' - Rows are updated in orders.orders' )  
  
  
  --600  
   if @master_memberinsuranceid is not null   
   begin   
    print concat ( 600, '-update master.MemberInsuranceDetails,  provider.MemberInsuranceDetails' );    
    update   
     mid  
    set   
     otccardnumber = concat (otccardnumber, 'A' ) ,
	 OTCSerialNumber = concat (OTCSerialNumber, 'A' ) 
    from master.MemberInsuranceDetails mid  
    where MemberInsuranceID in (select value from string_split ( @master_memberinsuranceid, ',' ) )  
  
    print concat ( @@rowcount , ' - Rows are updated in master.MemberInsuranceDetails' )  
   end  
     
  
   if @provider_memberinsuranceid is not null  
   begin   
    update pid   
    set   
     otccardnumber = concat (otccardnumber, 'A' ),  
	 OTCSerialNumber = concat (OTCSerialNumber, 'A' ) ,
     ModifyDate = @today,   
     ModifyUser =  @user   
    from   
     provider.MemberInsuranceDetails pid  
    where   
     MemberInsuranceID in (select value from string_split ( @provider_memberinsuranceid, ',' ))  
    print concat ( @@rowcount , ' - Rows are updated in provider.MemberInsuranceDetails' )  
   end  
  
  --700  
   if @OtcCardnumber is not null   
   begin   
    print concat ( 700, '-update otc.Cards' );  
    update   
     otc.Cards   
    set   
     nhmemberid = @NEWNHMemberID,  
     ModifyDate = @today,   
     ModifyUser =  @user   
    where   
     CardNumber = @OtcCardnumber and  
     nhmemberid = @OLDNHMemberID   
     print concat ( @@rowcount , ' - Rows are updated in otc.Cards' )  
   end  
  
  End   
  
  --800  
  print concat ( 800, '-update MergedNHMemberIDS' )    
  update   
   elig.MergedNHMemberIDS  
  set   
   is_processed =1 ,    
   executiondate = getdate()     
  where   
   ID = @ID   
  print concat ( @@rowcount , ' - Rows are updated in MergedNHMemberIDS' )  
      
  
  Commit transaction mergemebers;   
  Print 'Success'  
  
 End try   
  
  
 Begin catch   
  
  SELECT     
   @ErrorMessage = ERROR_MESSAGE(),    
   @ErrorSeverity = ERROR_SEVERITY(),    
   @ErrorState = ERROR_STATE();   
    
  Rollback Transaction mergemebers   
  
   RAISERROR (  
     @ErrorMessage,     
     @ErrorSeverity,   
     @ErrorState   
                    );    
  Print 'Failed'  
  
 end catch;  
  
END
GO


