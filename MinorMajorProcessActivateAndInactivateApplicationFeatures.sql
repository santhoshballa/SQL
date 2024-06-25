/****** Object:  StoredProcedure [dbo].[GetDetailMajorMinorInsuranceProviderLocation]    Script Date: 7/30/2021 8:28:28 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*
	Mohan deployed to Stage on 7 May 2020
	Mohan deployed to Production on 9 May 2020
*/
--CREATE PROCEDURE [dbo].[GetDetailMajorMinorInsuranceProviderLocation]
--(
--   @Type NVARCHAR(20)
--)
--AS
--BEGIN

    declare @Type nvarchar(20)
	SET @Type = 'OTC Benefits';
    DECLARE @InsuranceCarrierID BIGINT,@InsuranceHealthPlanID BIGINT,@ProviderCode NVARCHAR(100),@ProviderId BIGINT,@MinorProcessId BIGINT,@MajorProcessId BIGINT,@UserProfileId BIGINT,@LocationId BIGINT,@MemberId BIGINT
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

 

    -- Insert statements for procedure here
    SELECT @InsuranceCarrierID=InsuranceCarrierID,@InsuranceHealthPlanID=InsuranceHealthPlanID FROM [Insurance].[InsuranceHealthPlans] WHERE HealthPlanName LIKE  @Type + '%'
	SELECT @InsuranceCarrierID
    SELECT @ProviderCode=ProviderCode,@ProviderId=ProviderId FROM [Provider].[ProviderProfiles] WHERE ProviderName  LIKE 'OTC Provider%'
	SELECT @ProviderCode, @ProviderId
    SELECT @LocationId=LocationId from [provider].[ProviderLocations] where providerid=@ProviderId
	SELECT @LocationId
    SELECT @MinorProcessId=MinorProcessId FROM [Provider].[MinorProcess] WHERE MinorProcessName  LIKE 'OTC Order Created%'
	SELECT @MajorProcessId=MajorProcessId FROM [Provider].[MajorProcess] WHERE MajorProcessName  LIKE  'OTC Member%'
    SELECT @UserProfileId=UserProfileId  FROM  [auth].[UserProfiles] WHERE USERNAME like 'OTCUSER%'
    SELECT @MemberId=MemberID  FROM  [Master].[MemberInsurances] WHERE [InsuranceHealthPlanID]=@InsuranceHealthPlanID and [InsuranceCarrierID]=@InsuranceCarrierID 
    IF (ISNULL(@InsuranceCarrierID,0)!=0)
    BEGIN
    SELECT 1 as RowID, @InsuranceCarrierID AS InsuranceCarrierID,@InsuranceHealthPlanID AS InsuranceHealthPlanID,@ProviderCode as ProviderCode,@ProviderId as ProviderId,@LocationId AS ProviderLocationId,@MinorProcessId as MinorProcessId,@MajorProcessId as MajorProcessId,@UserProfileId AS UserProfileId,isnull(@MemberId,0) as MemberId
    END
    ELSE
    SELECT 0
    
--END
--GO

select count(*) from [Provider].[MajorProcess]
--8
select count(*) from [Provider].[MinorProcess]
--39

select * from [Provider].[ProviderProfiles] where ProviderName  LIKE 'OTC Provider%'
select * from [Provider].[MinorProcess] WHERE MinorProcessName  LIKE 'OTC Order Created%'
select * from [Provider].[MajorProcess] WHERE MajorProcessName  LIKE  'OTC Member%'


select a.*, b.*
from [Provider].[MinorProcess] a join [Provider].[MajorProcess] b on a.majorprocessid= b.majorprocessid

select 
a.majorprocessid, a.minorprocessid, a.isActive, a.minorProcessHelp, a.MinorProcessName, a.MinorProcessSequence, a.minorprocesscode,
b.MajorPredecessor, b.MajorProcessSequence,
a.*, b.*
from [Provider].[MinorProcess] a join [Provider].[MajorProcess] b on a.majorprocessid= b.majorprocessid
order by a.majorprocessid


/*
[11:20 AM] Bhanu Prakash Inturi
OTCOrderHistory.cshtml -- CallCenter Portal
[Route("/OTCOrderHistoryView/{????????nhmemberid}????????")] -- MembersController - CallCenter Portal
GetDetailMajorMinorInsuranceProviderLocation -- OTC Service

?[11:20 AM] Bhanu Prakash Inturi
    Every SubDomain will fetch from Insurance.InsuranceCarriers Table CarrierConfig Column
?[11:21 AM] Bhanu Prakash Inturi
    And SubDomain Configuration will fetch from Insurance.InsuranceConfig table based on CarrierId
?[11:21 AM] Bhanu Prakash Inturi
    For OTC and HA
?[11:21 AM] Bhanu Prakash Inturi
    based On Type


*/

select carrierconfig, * from Insurance.InsuranceCarriers where InsuranceCarrierName like '%island%'

select * from master.members where datasource like '%BCBS%'

select top 100 * from orders.orders where NHMemberId in (select NHmemberid from master.members where datasource like '%BCBSRI%' )