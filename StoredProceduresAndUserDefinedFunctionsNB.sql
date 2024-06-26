USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [provider].[sp_OTCMergeAccountsCheck]    Script Date: 6/26/2024 12:33:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create procedure [provider].[sp_OTCMergeAccountsCheck]

AS
BEGIN

SET NOCOUNT ON
SET XACT_ABORT ON

declare @OldNHMemberID nvarchar(20)
declare @NewNHMemberID nvarchar(20)
declare @RequestedBy nvarchar(50)
declare	@Technician nvarchar(50)
declare @TicketNumber nvarchar(20)
declare @vNewProfileID bigint
declare @vOldProfileID bigint
declare @vInsCarrierID nvarchar(20)
declare @vInsHealthPlanID nvarchar(20)
declare @vCard nvarchar(20)
declare @vMessage nvarchar(2000)
declare @vCount int

set @OldNHMemberID = 'NH202106684854'
set @NewNHMemberID = 'NH202002721621'
set @TicketNumber = '34760'
set @Technician = 'sballa'
set @RequestedBy = 'jrodriguez'

select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID
select @vInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vInsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID

Print('@OldNHMemberID | '+ cast(@OldNHMemberID as nvarchar))
Print('@NewNHMemberID | '+ cast(@NewNHMemberID as nvarchar))
Print('@RequestedBy | '+ cast(@RequestedBy as nvarchar))
Print('@Technician | '+ cast(@Technician as nvarchar))
Print('@TicketNumber | '+ cast(@TicketNumber as nvarchar))
Print('@vNewProfileID | '+ isNull(cast(@vNewProfileID as nvarchar),'Not Found'))
Print('@vOldProfileID | '+ isNull(cast(@vOldProfileID as nvarchar),'Not Found'))
Print('@vInsCarrierID | '+ isNull(cast(@vInsCarrierID as nvarchar),'Not Found'))
Print('@vInsHealthPlanID | '+ isNull(cast(@vInsHealthPlanID as nvarchar),'Not Found'))
Print('@vCard | '+ isNull(cast(@vCard as nvarchar), 'Not Found'))

set @vMessage = '( OldNHMemberID | ' + cast(@OldNHMemberID as nvarchar) + ' ), ' + 
				'( NewNHMemberID | ' + cast(@NewNHMemberID as nvarchar)+ ' ), ' + 
				'( RequestedBy | ' + cast(@RequestedBy as nvarchar) + ' ), ' +
				'( Technician | ' + cast(@Technician as nvarchar) + ' ), ' + 
				'( TicketNumber | ' + cast(@TicketNumber as nvarchar) + ' ), '+
				'( CardNumber | ' + isNull(cast(@vCard as nvarchar), 'Not Found') + ' ), '+
				'( InsCarrierID | ' + isNull(cast(@vInsCarrierID as nvarchar), 'Not Found') + ' ), ' +
				'( InsHealthPlanID | ' + isNull(cast(@vInsHealthPlanID as nvarchar),'Not Found') + ' ), ' +
				'( NewProfileID | ' + isNull(cast(@vNewProfileID as nvarchar),'Not Found') + ' ), ' +
				'( OldProfileID | ' + isNull(cast(@vOldProfileID as nvarchar), 'Not Found') + ' ), ' 

select @vMessage


--Counts
select 'old' as NHMemberID, 'elig.mstrEligBenefitData' as TableName, count(*) as IsAvailable from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
select 'new' as NHMemberID, 'elig.mstrEligBenefitData' as TableName,count(*) as IsAvailable  from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID)
select 'old' as NHMemberID, 'master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @OldNHMemberID
select 'new' as NHMemberID, 'master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @NewNHMemberID
select 'old' as NHMemberID, 'provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID = @OldNHMemberID
select 'new' as NHMemberID, 'provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID = @NewNHMemberID
select 'old' as NHMemberID, 'otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @OldNHMemberID
select 'new' as NHMemberID, 'otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @NewNHMemberID


--Master.Members
select 'old' as NHMemberID, 'master.members' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @OldNHMemberID
union all
select 'new' as NHMemberID, 'master.members' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @NewNHMemberID

--provider.MemberProfiles
select 'old' as ProfileID, 'provider.MemberProfiles' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @OldNHMemberID
union all
select 'new' as ProfileID, 'provider.MemberProfiles' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @NewNHMemberID


--ProcessData
select 'old' as 'NHMemberID'  , 'provider.MemberChartData' as TableName, mcd.ProcessData, JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) as NewProcessData -- new nhmemberid
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )
union all

select 'new' as 'NHMemberID' , 'provider.MemberChartData' as TableName, mcd.ProcessData, JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) as NewProcessData -- new nhmemberid
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vNewProfileID
					                                    )
						       )

--ProfileID
select 'old' as ProfileID, 'provider.MemberCharts' as TableName, mc.MemberProfileID from [provider].[MemberCharts] mc where mc.MemberProfileID = @vOldProfileID
union all
select 'new' as ProfileID, 'provider.MemberCharts' as TableName, mc.MemberProfileID from [provider].[MemberCharts] mc where mc.MemberProfileID = @vNewProfileID

--InsCarrier and InsHealthPlan
select 'old' as NHMemberID, 'elig.mstrEligBenefitData' as TableName, insCarrierID, insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
union all
select 'new' as NHMemberID, 'elig.mstrEligBenefitData' as TableName, insCarrierID, insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID)

--MemberData
select 'old' as NHMemberID, 'Orders.Orders' as TableName, o.OrderBy, o.MemberData, JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) as NewMemberData 
from orders.orders o where 1=1 and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID ) and o.IsActive=1
union
select 'new' as NHMemberID, 'Orders.Orders' as TableName, o.OrderBy, o.MemberData, JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) as NewMemberData 
from orders.orders o where 1=1 and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @NewNHMemberID ) and o.IsActive=1

--OrderID
select 'old' as NHMemberID, 'Orders.Orders' as TableName, OrderID from Orders.Orders where NHMemberID = @OldNHMemberID
union all
select 'new' as NHMemberID, 'Orders.Orders' as TableName, OrderID from Orders.Orders where NHMemberID = @NewNHMemberID

--Cards
select 'old' as NHMemberID, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @OldNHMemberID
union
select 'new' as NHMemberID, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @NewNHMemberID



--ReferenceIDsData 
select 'old' as NHMemberID, 'callcenter.callpageevents' as TableName, cpe.ReferenceIDsData from callcenter.callpageevents cpe where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID
union all
select 'new' as NHMemberID, 'callcenter.callpageevents' as TableName, cpe.ReferenceIDsData from callcenter.callpageevents cpe where ltrim(rtrim(cpe.ReferenceIDsData)) = @NewNHMemberID

--MemberNHMemberID
select 'old' as NHMemberID, 'callcenter.callconversations' as TableName, cc.MemberNHMemberId from callcenter.callconversations cc where cc.MemberNHMemberId = @OldNHMemberID
union all
select 'new' as NHMemberID, 'callcenter.callconversations' as TableName, cc.MemberNHMemberId from callcenter.callconversations cc where cc.MemberNHMemberId = @NewNHMemberID


-- MemberProfiles, MemberCharts, MemberChartsData for old and new Member ID's
select 'old' as NHMemberID, 'provider.MemberProfiles' as TableName, a.*, 'provider.MemberCharts' as TableName ,b.*, 'provider.MemberChartsData' as TableName, c.*
from provider.MemberProfiles a 
left join provider.MemberCharts b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberChartData c on b.MemberChartId = c.MemberChartId
where a.MemberProfileId = ( select MemberProfileId from provider.MemberProfiles where NHMemberID = @OldNHMemberID)
union all
select 'new' as NHMemberID, 'provider.MemberProfiles', a.*, 'provider.MemberCharts' ,b.*, 'provider.MemberChartsData', c.*
from provider.MemberProfiles a 
left join provider.MemberCharts b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberChartData c on b.MemberChartId = c.MemberChartId
where a.MemberProfileId = ( select MemberProfileId from provider.MemberProfiles where NHMemberID = @NewNHMemberID)

END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [provider].[sp_OTCMergeAccounts_v3]    Script Date: 6/26/2024 12:33:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Santhosh Balla
-- Create date: 02-15-2021>
-- Description:	Merge Accounts | OTC
-- =============================================

/*
To execute the procedure use the following example

exec [provider].[sp_OTCMergeAccounts_v3] 'NH202106684854', 'NH202002721621', 'jrodriguez', 'sballa', '34760'

Important Notes
ProviderID and LocationID in the provider.MemberChartsData belongs to the Nations Hearing and the Location ID belongs to Nations Benefits, when we Merge accounts you do not have to update.
One way to recognise all OTC orders created by the the call center folks after merged accounts.

*/
CREATE PROCEDURE [provider].[sp_OTCMergeAccounts_v3] 
	-- Add the parameters for the stored procedure here
	@OldNHMemberID nvarchar(50), 
	@NewNHMemberID nvarchar(50),
	@RequestedBy nvarchar(50),
	@Technician nvarchar(50),
    @TicketNumber nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
    SET XACT_ABORT ON


BEGIN TRY

BEGIN TRANSACTION
Print(GetDate())

declare @vCount int
declare @vMessage nvarchar(2000)
declare @vNewProfileID bigint
declare @vOldProfileID bigint
declare @vInsCarrierID nvarchar(20)
declare @vInsHealthPlanID nvarchar(20)
declare @vCard nvarchar(20)

select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID
select @vInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vInsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID

Print('@OldNHMemberID | '+ cast(@OldNHMemberID as nvarchar))
Print('@NewNHMemberID | '+ cast(@NewNHMemberID as nvarchar))
Print('@RequestedBy | '+ cast(@RequestedBy as nvarchar))
Print('@Technician | '+ cast(@Technician as nvarchar))
Print('@TicketNumber | '+ cast(@TicketNumber as nvarchar))
Print('@vNewProfileID | '+ isNull(cast(@vNewProfileID as nvarchar),'Not Found'))
Print('@vOldProfileID | '+ isNull(cast(@vOldProfileID as nvarchar),'Not Found'))
Print('@vInsCarrierID | '+ isNull(cast(@vInsCarrierID as nvarchar),'Not Found'))
Print('@vInsHealthPlanID | '+ isNull(cast(@vInsHealthPlanID as nvarchar),'Not Found'))
Print('@vCard | '+ isNull(cast(@vCard as nvarchar), 'Not Found'))

set @vMessage = '( OldNHMemberID | ' + cast(@OldNHMemberID as nvarchar) + ' ), ' + 
				'( NewNHMemberID | ' + cast(@NewNHMemberID as nvarchar)+ ' ), ' + 
				'( RequestedBy | ' + cast(@RequestedBy as nvarchar) + ' ), ' +
				'( Technician | ' + cast(@Technician as nvarchar) + ' ), ' + 
				'( TicketNumber | ' + cast(@TicketNumber as nvarchar) + ' ), '+
				'( CardNumber | ' + isNull(cast(@vCard as nvarchar), 'Not Found') + ' ), '+
				'( InsCarrierID | ' + isNull(cast(@vInsCarrierID as nvarchar), 'Not Found') + ' ), ' +
				'( InsHealthPlanID | ' + isNull(cast(@vInsHealthPlanID as nvarchar),'Not Found') + ' ), ' +
				'( NewProfileID | ' + isNull(cast(@vNewProfileID as nvarchar),'Not Found') + ' ), ' +
				'( OldProfileID | ' + isNull(cast(@vOldProfileID as nvarchar), 'Not Found') + ' ), ' 

select @vMessage

--Check if the OLD Member ID exists in the Eligibility Table
select @vCount = count(*) from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
if @vCount <> 0 THROW 50010, 'The OLD Member ID is not a call center created ID', 1;

--Check if the OLD Member ID exists in the master
select @vCount = count(*) from master.members where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50020, 'The OLD Member ID does not exist', 1;

--Check if the NEW Member ID exists in the master.members table
select @vCount = count(*) from master.members where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50030, 'The NEW Member ID does not exist', 1;

--Check if the OLD Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50040, 'The OLD Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the NEW Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50050, 'The New Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the card number exists for the OLD Member ID in the otc.cards
select @vCount = count(*) from otc.cards where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50060, 'The 19 digit OTC card is NOT AVAILABLE for the OLD Member ID', 1;

--Check if the card number exists for the New Member ID in the otc.cards, IT SHOULD NOT EXIST
select @vCount = count(*) from otc.cards where NHMemberID = @NewNHMemberID
if @vCount = 1 THROW 50070, 'The 19 digit OTC card is ALREADY AVAILABLE for the NEW Member ID', 1;

insert into [elig].[MergedNHMemberIDS]  (CreateDate, OldNHMemberID, NewNHMemberID, RequestedBy, Technician, TicketNumber)
values (GETDATE(), @OldNHMemberID, @NewNHMemberID, @RequestedBy, @Technician, @TicketNumber);


--Update the MemberProfileID in the JSON document column ProcessData before updating the Profile ID in the MemberCharts table.


update mcd
set mcd.ProcessData = JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) -- new nhmemberid
  , mcd.ModifyDate = GETDATE()
  , mcd.ModifyUser = CURRENT_USER 
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )

--Then Update MemberCharts to the New Profile ID

update mc
SET mc.MemberProfileID = @vNewProfileID -- New Profile ID
   ,mc.ModifyDate = GETDATE()
   ,mc.ModifyUser = CURRENT_USER 
from [provider].[MemberCharts] mc
where mc.MemberProfileID = @vOldProfileID


-- Update the Order ID's of the OLD Member ID with the New Member ID

set @vMessage = @vMessage + ' InsCarrierID | ' + @vInsCarrierID + ',' +
							' InsHealthPlanID | ' + @vInsHealthPlanID + ',' 

-- First update the data belonging to the Old Member ID with the New Member ID details
update o
set o.OrderBy	 = @NewNHMemberID
   ,o.MemberData = JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) -- New NHMember ID
   ,o.ModifyDate = GETDATE() 
   ,o.ModifyUser = CURRENT_USER
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

--Then update the Old Member ID with the New Member ID, The Old Member ID no longer exists in the Orders.Orders table
update o
set o.NHMemberId = @NewNHMemberID
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

-- Update the old NHMember ID to the New NHMember ID in the otc.cards



-- Once the update is completed the old Member ID should not exist in the otc.cards table
update c
set c.NHMemberID = @NewNHMemberID, 
    c.ModifyDate = GETDATE(), 
	c.ModifyUser = CURRENT_USER 
from otc.Cards c
where c.CardNumber = @vCard


-- Update the Column ReferenceIDsData which contains the Old Member to the New Member ID
-- Update the callcenter.conversations from the OLD Member ID to the NEW MemberID

/* To preserve history of the conversations, this may or may not be required
update cpe
set cpe.ReferenceIDsData = @NewNHMemberID
from callcenter.callpageevents cpe
where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID

--Then update the Old Member ID to the New Member ID
update cc
set cc.MemberNHMemberId = @NewNHMemberID
    cc.ModifyDate = GETDATE(), 
	cc.ModifyUser = CURRENT_USER
from callcenter.callconversations cc
where cc.MemberNHMemberId = @OldNHMemberID
*/


update [Master].[Members] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER where [NHMemberID] = @OldNHMemberID      -- Old NHMemberID
update [provider].[MemberProfiles] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER  where [NHMemberID] = @OldNHMemberID -- Old NHMemberID

COMMIT TRANSACTION

select @vMessage
select 'The Procedure [provider].[sp_OTCMergeAccounts] executed successfully'

END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION
		select @vMessage
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
		VALUES ('[provider].[sp_OTCMergeAccounts]', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [provider].[sp_OTCMergeAccounts_v2]    Script Date: 6/26/2024 12:33:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Santhosh Balla
-- Create date: 02-15-2021>
-- Description:	Merge Accounts | OTC
-- =============================================

/*
To execute the procedure use the following example

exec [provider].[sp_OTCMergeAccounts] 'NH202106684854', 'NH202002721621', 'jrodriguez', 'sballa', '34760'

Important Notes
ProviderID and LocationID in the provider.MemberChartsData belongs to the Nations Hearing and the Location ID belongs to Nations Benefits, when we Merge accounts you do not have to update.
One way to recognise all OTC orders created by the the call center folks after merged accounts.

*/
create PROCEDURE [provider].[sp_OTCMergeAccounts_v2] 
	-- Add the parameters for the stored procedure here
	@OldNHMemberID nvarchar(50), 
	@NewNHMemberID nvarchar(50),
	@RequestedBy nvarchar(50),
	@Technician nvarchar(50),
    @TicketNumber nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
    SET XACT_ABORT ON

BEGIN TRANSACTION
BEGIN TRY

Print(GetDate())

declare @vCount int
declare @vMessage nvarchar(2000)

set @vMessage = ' OldNHMemberID | ' + @OldNHMemberID + ',' + 
				' NewNHMemberID | ' + @NewNHMemberID + ',' + 
				' RequestedBy | ' + @RequestedBy+ ',' +
				' Technician | ' + @Technician + ',' + 
				' TicketNumber | ' + @TicketNumber + ','

select @vMessage

--Check if the OLD Member ID exists in the Eligibility Table
select @vCount = count(*) from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
if @vCount <> 0 THROW 50010, 'The OLD Member ID is not a call center created ID', 1;

--Check if the OLD Member ID exists in the master
select @vCount = count(*) from master.members where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50020, 'The OLD Member ID does not exist', 1;

--Check if the NEW Member ID exists in the master.members table
select @vCount = count(*) from master.members where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50030, 'The NEW Member ID does not exist', 1;

--Check if the OLD Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50040, 'The OLD Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the NEW Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50050, 'The New Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the card number exists for the OLD Member ID in the otc.cards
select @vCount = count(*) from otc.cards where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50060, 'The 19 digit OTC card is NOT AVAILABLE for the OLD Member ID', 1;

--Check if the card number exists for the New Member ID in the otc.cards, IT SHOULD NOT EXIST
select @vCount = count(*) from otc.cards where NHMemberID = @NewNHMemberID
if @vCount = 1 THROW 50070, 'The 19 digit OTC card is ALREADY AVAILABLE for the NEW Member ID', 1;

insert into [elig].[MergedNHMemberIDS]  (CreateDate, OldNHMemberID, NewNHMemberID, RequestedBy, Technician, TicketNumber)
values (GETDATE(), @OldNHMemberID, @NewNHMemberID, @RequestedBy, @Technician, @TicketNumber);


--Update the MemberProfileID in the JSON document column ProcessData before updating the Profile ID in the MemberCharts table.

declare @vNewProfileID bigint
declare @vOldProfileID bigint

select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID

set @vMessage = @vMessage + ' NewProfileID | ' + cast(@vNewProfileID as nvarchar) + ',' +
							' OldProfileID | ' + cast(@vOldProfileID as nvarchar) + ',' 

update mcd
set mcd.ProcessData = JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) -- new nhmemberid
  , mcd.ModifyDate = GETDATE()
  , mcd.ModifyUser = CURRENT_USER 
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )

--Then Update MemberCharts to the New Profile ID

update mc
SET mc.MemberProfileID = @vNewProfileID -- New Profile ID
   ,mc.ModifyDate = GETDATE()
   ,mc.ModifyUser = CURRENT_USER 
from [provider].[MemberCharts] mc
where mc.MemberProfileID = @vOldProfileID


-- Update the Order ID's of the OLD Member ID with the New Member ID
declare @vInsCarrierID nvarchar(20)
declare @vInsHealthPlanID nvarchar(20)

select @vInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vinsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID

set @vMessage = @vMessage + ' InsCarrierID | ' + @vInsCarrierID + ',' +
							' InsHealthPlanID | ' + @vInsHealthPlanID + ',' 

-- First update the data belonging to the Old Member ID with the New Member ID details
update o
set o.OrderBy	 = @NewNHMemberID
   ,o.MemberData = JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) -- New NHMember ID
   ,o.ModifyDate = GETDATE() 
   ,o.ModifyUser = CURRENT_USER
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

--Then update the Old Member ID with the New Member ID, The Old Member ID no longer exists in the Orders.Orders table
update o
set o.NHMemberId = @NewNHMemberID
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

-- Update the old NHMember ID to the New NHMember ID in the otc.cards

declare @vCard nvarchar(20)
select @vCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID

set @vMessage = @vMessage + ' CardNumber | ' + @vCard + ',' 

-- Once the update is completed the old Member ID should not exist in the otc.cards table
update c
set c.NHMemberID = @NewNHMemberID, 
    c.ModifyDate = GETDATE(), 
	c.ModifyUser = CURRENT_USER 
from otc.Cards c
where c.CardNumber = @vCard


-- Update the Column ReferenceIDsData which contains the Old Member to the New Member ID
-- Update the callcenter.conversations from the OLD Member ID to the NEW MemberID

/* To preserve history of the conversations, this may or may not be required
update cpe
set cpe.ReferenceIDsData = @NewNHMemberID
from callcenter.callpageevents cpe
where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID

--Then update the Old Member ID to the New Member ID
update cc
set cc.MemberNHMemberId = @NewNHMemberID
    cc.ModifyDate = GETDATE(), 
	cc.ModifyUser = CURRENT_USER
from callcenter.callconversations cc
where cc.MemberNHMemberId = @OldNHMemberID
*/


update [Master].[Members] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER where [NHMemberID] = @OldNHMemberID      -- Old NHMemberID
update [provider].[MemberProfiles] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER  where [NHMemberID] = @OldNHMemberID -- Old NHMemberID

COMMIT TRANSACTION

select @vMessage
select 'The Procedure [provider].[sp_OTCMergeAccounts] executed successfully'

END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION
		select @vMessage
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
		VALUES ('[provider].[sp_OTCMergeAccounts]', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [provider].[sp_OTCMergeAccounts_v1]    Script Date: 6/26/2024 12:33:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Santhosh Balla
-- Create date: 02-15-2021>
-- Description:	Merge Accounts | OTC
-- =============================================

/*
To execute the procedure use the following example

exec [provider].[sp_OTCMergeAccounts] 'NH202106684854', 'NH202002721621', 'jrodriguez', 'sballa', '34760'

Important Notes
ProviderID and LocationID in the provider.MemberChartsData belongs to the Nations Hearing and the Location ID belongs to Nations Benefits, when we Merge accounts you do not have to update.
One way to recognise all OTC orders created by the the call center folks after merged accounts.

*/
CREATE PROCEDURE [provider].[sp_OTCMergeAccounts_v1] 
	-- Add the parameters for the stored procedure here
	@OldNHMemberID nvarchar(50), 
	@NewNHMemberID nvarchar(50),
	@RequestedBy nvarchar(50),
	@Technician nvarchar(50),
    @TicketNumber nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
    SET XACT_ABORT ON

BEGIN TRANSACTION
BEGIN TRY

Print(GetDate())

declare @vCount int
declare @vMessage nvarchar(2000)

set @vMessage = ' OldNHMemberID | ' + @OldNHMemberID + ',' + 
				' NewNHMemberID | ' + @NewNHMemberID + ',' + 
				' RequestedBy | ' + @RequestedBy+ ',' +
				' Technician | ' + @Technician + ',' + 
				' TicketNumber | ' + @TicketNumber + ','

select @vMessage

--Check if the OLD Member ID exists in the Eligibility Table
select @vCount = count(*) from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
if @vCount <> 0 THROW 50001, 'The OLD Member ID is not a call center created ID', 1;

--Check if the OLD Member ID exists in the master
select @vCount = count(*) from master.members where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50001, 'The OLD Member ID does not exist', 1;

--Check if the NEW Member ID exists in the master.members table
select @vCount = count(*) from master.members where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50002, 'The NEW Member ID does not exist', 1;

--Check if the OLD Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50003, 'The OLD Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the NEW Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50004, 'The New Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the card number exists for the OLD Member ID in the otc.cards
select @vCount = count(*) from otc.cards where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50005, 'The 19 digit OTC card is NOT AVAILABLE for the OLD Member ID', 1;

--Check if the card number exists for the New Member ID in the otc.cards, IT SHOULD NOT EXIST
select @vCount = count(*) from otc.cards where NHMemberID = @NewNHMemberID
if @vCount = 1 THROW 50006, 'The 19 digit OTC card is ALREADY AVAILABLE for the NEW Member ID', 1;

insert into [elig].[MergedNHMemberIDS]  (CreateDate, OldNHMemberID, NewNHMemberID, RequestedBy, Technician, TicketNumber)
values (GETDATE(), @OldNHMemberID, @NewNHMemberID, @RequestedBy, @Technician, @TicketNumber);


--Update the MemberProfileID in the JSON document column ProcessData before updating the Profile ID in the MemberCharts table.

declare @vNewProfileID bigint
declare @vOldProfileID bigint

select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID

set @vMessage = @vMessage + ' NewProfileID | ' + cast(@vNewProfileID as nvarchar) + ',' +
							' OldProfileID | ' + cast(@vOldProfileID as nvarchar) + ',' 

update mcd
set mcd.ProcessData = JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) -- new nhmemberid
  , mcd.ModifyDate = GETDATE()
  , mcd.ModifyUser = CURRENT_USER 
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )

--Then Update MemberCharts to the New Profile ID

update mc
SET mc.MemberProfileID = @vNewProfileID -- New Profile ID
   ,mc.ModifyDate = GETDATE()
   ,mc.ModifyUser = CURRENT_USER 
from [provider].[MemberCharts] mc
where mc.MemberProfileID = @vOldProfileID


-- Update the Order ID's of the OLD Member ID with the New Member ID
declare @vInsCarrierID nvarchar(20)
declare @vInsHealthPlanID nvarchar(20)

select @vInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vinsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID

set @vMessage = @vMessage + ' InsCarrierID | ' + @vInsCarrierID + ',' +
							' InsHealthPlanID | ' + @vInsHealthPlanID + ',' 

-- First update the data belonging to the Old Member ID with the New Member ID details
update o
set o.OrderBy	 = @NewNHMemberID
   ,o.MemberData = JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) -- New NHMember ID
   ,o.ModifyDate = GETDATE() 
   ,o.ModifyUser = CURRENT_USER
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

--Then update the Old Member ID with the New Member ID, The Old Member ID no longer exists in the Orders.Orders table
update o
set o.NHMemberId = @NewNHMemberID
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

-- Update the old NHMember ID to the New NHMember ID in the otc.cards

declare @vCard nvarchar(20)
select @vCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID

set @vMessage = @vMessage + ' CardNumber | ' + @vCard + ',' 

-- Once the update is completed the old Member ID should not exist in the otc.cards table
update c
set c.NHMemberID = @NewNHMemberID, 
    c.ModifyDate = GETDATE(), 
	c.ModifyUser = CURRENT_USER 
from otc.Cards c
where c.CardNumber = @vCard


-- Update the Column ReferenceIDsData which contains the Old Member to the New Member ID
-- Update the callcenter.conversations from the OLD Member ID to the NEW MemberID

/* To preserve history of the conversations, this may or may not be required
update cpe
set cpe.ReferenceIDsData = @NewNHMemberID
from callcenter.callpageevents cpe
where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID

--Then update the Old Member ID to the New Member ID
update cc
set cc.MemberNHMemberId = @NewNHMemberID
    cc.ModifyDate = GETDATE(), 
	cc.ModifyUser = CURRENT_USER
from callcenter.callconversations cc
where cc.MemberNHMemberId = @OldNHMemberID
*/


update [Master].[Members] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER where [NHMemberID] = @OldNHMemberID      -- Old NHMemberID
update [provider].[MemberProfiles] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER  where [NHMemberID] = @OldNHMemberID -- Old NHMemberID

COMMIT TRANSACTION

select @vMessage
select 'The Procedure [provider].[sp_OTCMergeAccounts] executed successfully'

END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION
		select @vMessage
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
		VALUES ('[provider].[sp_OTCMergeAccounts]', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [provider].[sp_OTCMergeAccounts]    Script Date: 6/26/2024 12:33:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Santhosh Balla
-- Create date: 02-15-2021>
-- Description:	Merge Accounts | OTC
-- =============================================

/*
To execute the procedure use the following example

exec [provider].[sp_OTCMergeAccounts_v3] 'NH202106684854', 'NH202002721621', 'jrodriguez', 'sballa', '34760'

Important Notes
ProviderID and LocationID in the provider.MemberChartsData belongs to the Nations Hearing and the Location ID belongs to Nations Benefits, when we Merge accounts you do not have to update.
One way to recognise all OTC orders created by the the call center folks after merged accounts.

*/
CREATE PROCEDURE [provider].[sp_OTCMergeAccounts] 
	-- Add the parameters for the stored procedure here
	@OldNHMemberID nvarchar(50), 
	@NewNHMemberID nvarchar(50),
	@RequestedBy nvarchar(50),
	@Technician nvarchar(50),
    @TicketNumber nvarchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON
    SET XACT_ABORT ON

BEGIN TRANSACTION
BEGIN TRY

Print(GetDate())

declare @vCount int
declare @vMessage nvarchar(2000)
declare @vNewProfileID bigint
declare @vOldProfileID bigint
declare @vInsCarrierID nvarchar(20)
declare @vInsHealthPlanID nvarchar(20)
declare @vCard nvarchar(20)

select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID
select @vInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vinsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID

set @vMessage = ' OldNHMemberID | ' + @OldNHMemberID + ' ,' + 
				' NewNHMemberID | ' + @NewNHMemberID + ' ,' + 
				' RequestedBy | ' + @RequestedBy + ' ,' +
				' Technician | ' + @Technician + ' ,' + 
				' TicketNumber | ' + @TicketNumber + ' ,' +
				' CardNumber | ' + isNull(cast(@vCard as nvarchar), 'Not Found') + ', '+
				' InsCarrierID | ' + isNull(cast(@vInsCarrierID as nvarchar), 'Not Found') + ',' +
				' InsHealthPlanID | ' + isNull(@vInsHealthPlanID,'Not Found') + ',' +
				' NewProfileID | ' + isNull(cast(@vNewProfileID as nvarchar),'Not Found') + ',' +
				' OldProfileID | ' + isNull(cast(@vOldProfileID as nvarchar), 'Not Found') + ',' 

select @vMessage

--Check if the OLD Member ID exists in the Eligibility Table
select @vCount = count(*) from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID)
if @vCount <> 0 THROW 50010, 'The OLD Member ID is not a call center created ID', 1;

--Check if the OLD Member ID exists in the master
select @vCount = count(*) from master.members where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50020, 'The OLD Member ID does not exist', 1;

--Check if the NEW Member ID exists in the master.members table
select @vCount = count(*) from master.members where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50030, 'The NEW Member ID does not exist', 1;

--Check if the OLD Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50040, 'The OLD Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the NEW Member ID exists in the table provider.MemberProfiles 
select @vCount = count(*) from provider.MemberProfiles where NHMemberID = @NewNHMemberID
if @vCount <> 1 THROW 50050, 'The New Member ID does not exist in the provider.MemberProfiles', 1;

--Check if the card number exists for the OLD Member ID in the otc.cards
select @vCount = count(*) from otc.cards where NHMemberID = @OldNHMemberID
if @vCount <> 1 THROW 50060, 'The 19 digit OTC card is NOT AVAILABLE for the OLD Member ID', 1;

--Check if the card number exists for the New Member ID in the otc.cards, IT SHOULD NOT EXIST
select @vCount = count(*) from otc.cards where NHMemberID = @NewNHMemberID
if @vCount = 1 THROW 50070, 'The 19 digit OTC card is ALREADY AVAILABLE for the NEW Member ID', 1;

insert into [elig].[MergedNHMemberIDS]  (CreateDate, OldNHMemberID, NewNHMemberID, RequestedBy, Technician, TicketNumber)
values (GETDATE(), @OldNHMemberID, @NewNHMemberID, @RequestedBy, @Technician, @TicketNumber);


--Update the MemberProfileID in the JSON document column ProcessData before updating the Profile ID in the MemberCharts table.


update mcd
set mcd.ProcessData = JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) -- new nhmemberid
  , mcd.ModifyDate = GETDATE()
  , mcd.ModifyUser = CURRENT_USER 
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )

--Then Update MemberCharts to the New Profile ID

update mc
SET mc.MemberProfileID = @vNewProfileID -- New Profile ID
   ,mc.ModifyDate = GETDATE()
   ,mc.ModifyUser = CURRENT_USER 
from [provider].[MemberCharts] mc
where mc.MemberProfileID = @vOldProfileID


-- Update the Order ID's of the OLD Member ID with the New Member ID

set @vMessage = @vMessage + ' InsCarrierID | ' + @vInsCarrierID + ',' +
							' InsHealthPlanID | ' + @vInsHealthPlanID + ',' 

-- First update the data belonging to the Old Member ID with the New Member ID details
update o
set o.OrderBy	 = @NewNHMemberID
   ,o.MemberData = JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vInsCarrierID ), '$.insPlanId' , @vinsHealthPlanID ) -- New NHMember ID
   ,o.ModifyDate = GETDATE() 
   ,o.ModifyUser = CURRENT_USER
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

--Then update the Old Member ID with the New Member ID, The Old Member ID no longer exists in the Orders.Orders table
update o
set o.NHMemberId = @NewNHMemberID
from orders.orders o
where 1=1
and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID )  -- Old NHMember ID
and o.IsActive=1

-- Update the old NHMember ID to the New NHMember ID in the otc.cards
-- Once the update is completed the old Member ID should not exist in the otc.cards table
update c
set c.NHMemberID = @NewNHMemberID, 
    c.ModifyDate = GETDATE(), 
	c.ModifyUser = CURRENT_USER 
from otc.Cards c
where c.CardNumber = @vCard


-- Update the Column ReferenceIDsData which contains the Old Member to the New Member ID
-- Update the callcenter.conversations from the OLD Member ID to the NEW MemberID

/* To preserve history of the conversations, this may or may not be required
update cpe
set cpe.ReferenceIDsData = @NewNHMemberID
from callcenter.callpageevents cpe
where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID

--Then update the Old Member ID to the New Member ID
update cc
set cc.MemberNHMemberId = @NewNHMemberID
    cc.ModifyDate = GETDATE(), 
	cc.ModifyUser = CURRENT_USER
from callcenter.callconversations cc
where cc.MemberNHMemberId = @OldNHMemberID
*/


update [Master].[Members] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER where [NHMemberID] = @OldNHMemberID      -- Old NHMemberID
update [provider].[MemberProfiles] set IsActive=0, ModifyDate = GETDATE(), ModifyUser = CURRENT_USER  where [NHMemberID] = @OldNHMemberID -- Old NHMemberID

COMMIT TRANSACTION

select @vMessage
select 'The Procedure [provider].[sp_OTCMergeAccounts] executed successfully'

END TRY

BEGIN CATCH
		ROLLBACK TRANSACTION
		select @vMessage
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
		VALUES ('[provider].[sp_OTCMergeAccounts]', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [elig].[sp_ProductRecommendationEngine]    Script Date: 6/26/2024 12:33:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*
Author : Santhosh Balla
Date : 07-12-2022

Product Recommendation Engine
This stored procedure will create the list of products based on a few strategies

1.	If a member buys a product, he is more likely to buy it again.
2.	If another member in his plan buys a product, more than likely he might have an interest to buy
3.	If most members bought a product, more than likely a particular member would love to buy, the top ten products bought during the last 6 months or a frequency period. This includes All Carriers
4.	Browsing history of the member -- This is current not available
5.	Products in his cart and not bought. This is currently not available

The input parameters/variables are the members NHMemberID, Insurance Carrier ID and the Insurance Health Plan ID.

exec [elig].[sp_ProductRecommendationEngine] 'NH202210707408',258,2433 -- works
exec [elig].[sp_ProductRecommendationEngine] 'NH202210707408',258, NULL -- works


declare @vInsuranceCarrierID int = 20
declare @vInsuranceHealthPlanID int = 224

select distinct b.InsuranceCarrierID, c.InsuranceCarrierName, b.InsuranceHealthPlanID, d.HealthPlanName
from master.members a 
left join master.MemberInsurances b on a.MemberID = b.MemberID
left join insurance.InsuranceCarriers c on b.InsuranceCarrierID = c.InsuranceCarrierID
left join insurance.InsuranceHealthPlans d on b.InsuranceHealthPlanID = d.InsuranceHealthPlanID
where a.IsActive = 1 and b.IsActive = 1 -- order by b.InsuranceCarrierID
--and b.InsuranceCarrierID =  @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )
order by b.InsuranceCarrierID

declare @vInsuranceCarrierID int = 302
declare @vInsuranceHealthPlanID int = 2697

-- Sample MemberID's, InsuranceCarrierID and InsuranceHealthPlanID
select top 100 a.NHMemberID, b.InsuranceCarrierID, b.InsuranceHealthPlanID
from master.members a left join master.MemberInsurances b on a.MemberID = b.MemberID
where a.IsActive = 1 and b.IsActive = 1 -- order by b.InsuranceCarrierID
and b.InsuranceCarrierID =  @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )
order by b.InsuranceCarrierID

declare @vInsuranceCarrierID int = 302
declare @vInsuranceHealthPlanID int = 2697


-- Generate the execute statements for Testing
select top 10 
'exec [elig].[sp_ProductRecommendationEngine] ' + ''''+ a.NHMemberID + '''' + ',' + Cast(b.InsuranceCarrierID as nvarchar) + ',' + cast(b.InsuranceHealthPlanID as nvarchar)
from master.members a left join master.MemberInsurances b on a.MemberID = b.MemberID
where a.IsActive = 1 and b.IsActive = 1
and b.InsuranceCarrierID = @vInsuranceCarrierID and b.InsuranceHealthPlanID = @vInsuranceHealthPlanID
and a.NHMemberID in (select NHMemberID from orders.orders where orderType = 'OTC' and createDate > '01-01-2022' and Status = 'Active' and OrderStatusCode = 'SHI'  )


exec [elig].[sp_ProductRecommendationEngine] 'NH201901959511',5,12
exec [elig].[sp_ProductRecommendationEngine] 'NH202005639868',5,12

exec [elig].[sp_ProductRecommendationEngine] 'NH202005604639',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605229',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605320',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005605855',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005606854',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005607826',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005608010',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005608452',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005609797',302,2697
exec [elig].[sp_ProductRecommendationEngine] 'NH202005610906',302,2697

*/


Create PROCEDURE [elig].[sp_ProductRecommendationEngine]
(
  @NHMemberID nvarchar(20)
 ,@InsuranceCarrierID int
 ,@InsuranceHealthPlanID int
)
AS

declare @procedureName VARCHAR(100) = 'sp_ProductRecommendationEngine'
declare @vNHMemberID nvarchar(20)
declare @vInsuranceCarrierID int
declare @vInsuranceHealthPlanID int
declare @vAllItems float
declare @vPlanItems float
declare @vMemberItems float

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
SET NOCOUNT ON

BEGIN TRY

set @vNHMemberID = @NHMemberID
set @vInsuranceCarrierID = @InsuranceCarrierID
set @vInsuranceHealthPlanID = @InsuranceHealthPlanID

If @vNHMemberID is null or @vNHMemberID = ''
begin
		select 'NHMemberID is not Provided'
		Return 0
end

If @vInsuranceCarrierID is null or @vInsuranceCarrierID = ''
begin
		select 'Insurance Carrier ID is not Provided'
		Return 0
end

If @vInsuranceHealthPlanID is null or @vInsuranceCarrierID = ''
begin
		select 'Insurance Health Plan ID is not Provided'
		Return 0
end

BEGIN TRANSACTION RecommendationEngine

IF OBJECT_ID('tempdb..#TAllOrdersOrderItems') IS NOT NULL DROP TABLE #TAllOrdersOrderItems 


select 'Step 1 | Select All Orders '

select * into #TAllOrdersOrderItems from (
select
a.OrderID, a.OrderType, a.Status OrderStatus, a.NHMemberID, a.OrderStatusCode
,json_value(a.MemberData, '$.insCarrierId') as InsuranceCarrierID
,json_value(a.MemberData, '$.insPlanId') as InsuranceHealthPlanID

,b.ItemCode
,json_value(b.ItemData, '$.nationsId') as NationsID
,b.Status as OrderItemStatus
,b.Quantity
,b.UnitPrice
,b.PairPrice
,b.IsActive

,c.ItemCode as ItemMasterItemCode
,c.ItemName

from Orders.orders a 
left join Orders.OrderItems b on a.OrderID = b.OrderID
left join otcCatalog.ItemMaster c on b.ItemCode = c.ItemCode
where a.orderType = 'OTC' and a.createDate > '01-01-2022' and a.Status = 'Active' and a.OrderStatusCode = 'SHI' and b.ItemType = 'OTC' and b.ItemCode not in ('NB_VOUCHER')
) a


select 'Step 2 | Select Orders at Plan Level '

IF OBJECT_ID('tempdb..#TOrdersOrderItems') IS NOT NULL DROP TABLE #TOrdersOrderItems 
select * into #TOrdersOrderItems from (
select
a.OrderID, a.OrderType, a.Status OrderStatus, a.NHMemberID, a.OrderStatusCode
,json_value(a.MemberData, '$.insCarrierId') as InsuranceCarrierID
,json_value(a.MemberData, '$.insPlanId') as InsuranceHealthPlanID

,b.ItemCode
,json_value(b.ItemData, '$.nationsId') as NationsID
,b.Status as OrderItemStatus
,b.Quantity
,b.UnitPrice
,b.PairPrice
,b.IsActive

,c.ItemCode as ItemMasterItemCode
,c.ItemName

from Orders.orders a 
left join Orders.OrderItems b on a.OrderID = b.OrderID
left join otcCatalog.ItemMaster c on b.ItemCode = c.ItemCode
where a.orderType = 'OTC' and a.createDate > '01-01-2022' and a.Status = 'Active' and a.OrderStatusCode = 'SHI' and b.ItemType = 'OTC' and b.ItemCode not in ('NB_VOUCHER')
and json_value(a.MemberData, '$.insCarrierId') = @vInsuranceCarrierID and json_value(a.MemberData, '$.insPlanId') = @vInsuranceHealthPlanID
) a

--select top 10 * from #TOrdersOrderItems

-- Ratio of all Items


select 'Step 3 | Find total number of Items at all three levels (All Plans, Plan level, Member Level )'

select @vAllItems = sum(Quantity) from #TAllOrdersOrderItems
select @vPlanItems = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vMemberItems = Sum(Quantity) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @vNHMemberID  -- Particular Member

/*
select @vAllTotalItems = Count(*) from #TAllOrdersOrderItems
select @vTotalItems = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID  -- All Items
select @vTotalItemsNHMemberID = Count(*) from #TOrdersOrderItems where InsuranceCarrierID = @vInsuranceCarrierID and InsuranceHealthPlanID = @vInsuranceHealthPlanID and NHMemberID =  @VNHMemberID  -- Particular Member
*/

-- ALL Products All Carriers

select 'Step 4 | Calculate attribution Ratios for all plans )'

IF OBJECT_ID('tempdb..#TAllItems') IS NOT NULL DROP TABLE #TAllItems 

select * into #TAllItems from (
select ItemCode as AllItemCode, ItemName as AllItemName, Sum(Quantity) as AllNumberOfItems, Round(Cast((Sum(Quantity)/@vAllItems) as float), 4) as AllItemRatio  from #TALLOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TAllTotalItemRatio order by AllTotalItemRatio desc


select 'Step 5 | Calculate attribution Ratios for a plan )'
-- All Products within a Carrier and a Health Plan
IF OBJECT_ID('tempdb..#TPlanItems') IS NOT NULL DROP TABLE #TPlanItems

select * into #TPlanItems from (
select ItemCode as PlanLevelItemCode, ItemName as PlanLevelItemName, Sum(Quantity) as PlanNumberOfItems, Round(Cast((Sum(Quantity)/@vPlanItems) as float), 4) as PlanLevelItemRatio  from #TOrdersOrderItems
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

--select * from #TTotalItemRatio


select 'Step 6 | Calculate attribution Ratios for a member )'
-- All Products bought by a Member
IF OBJECT_ID('tempdb..#TMemberItems') IS NOT NULL DROP TABLE #TMemberItems 
select * into #TMemberItems from (
select ItemCode as MemberItemCode, ItemName as MemberItemName, Sum(Quantity) as MemberNumberOfItems, Round(Cast((Sum(Quantity)/@vMemberItems) as float), 4) as MemberLevelRatio  from #TOrdersOrderItems where NHMemberID =  @vNHMemberID
group by Itemcode, ItemName
-- Order by Sum(Quantity) desc
) a

select 'Step 6 | Calculate attribution Ratios for a member ) | Complete'
--select * from #TTotalItemNHMemberIDRatio

select 'Step 7 | Final attribution ratio )'

select top 10  @vNHMemberID as 'NHMemberID', a.*, b.*, c.* , (isnull(AllItemRatio,0) + isnull(PlanLevelItemRatio,0) + isnull(MemberLevelRatio, 0)) as WeightedValue 
from #TAllItems a 
left join #TPlanItems b on a.AllItemCode = b.PlanLevelItemCode
left join #TMemberItems c on b.PlanLevelItemCode = c.MemberItemCode
where MemberLevelRatio is not null
order by WeightedValue desc

commit transaction RecommendationEngine

END try


BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION RecommendationEngine
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END

GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [elig].[sp_load_stg_to_BCBSKCRewardsData]    Script Date: 6/26/2024 12:33:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:      <Santhosh Balla>
-- Create Date: <12-01-2021>
-- Description: <Implements SCD 2 on all columns that have been modified in the elig.BCBSKCRewardsData table>
-- Execute:		exec [elig].[sp_load_stg_to_BCBSKCRewardsData] <FileTrackID>
-- 				exec [elig].[sp_load_stg_to_BCBSKCRewardsData] 29945
--				select * from elig.BCBSKCRewardsData
--				select * from [elig].[FileTrack] where ClientCode = 'H488_RE'
--				select * from #TstgEligBenefitData order by stgELigID_stg desc
/*
				select * from elig.rawEligBenefitData where fileTrackID = 29945
				select * from elig.stgEligBenefitData where fileTrackID = 29945
*/
--				select * from elig.BCBSKCRewardsData
--				update elig.FileTrack set StatusCode = 100 where ClientCode = 'H488_RE'
--              select distinct DataSource,MemberID, IncentiveType, IncentiveCategory, IncentiveCode, ContractNbr, PBPID from elig.BCBSKCRewardsData -- These Columns make the record unique
--				select * from elig.BCBSKCRewardsData
--				truncate table elig.BCBSKCRewardsData
--				DELETE FROM elig.BCBSKCRewardsData WHERE FIRSTNAME LIKE '%SANTHOSH%' OR BCBSKCRewardsDataID = 11
/*
				select * from elig.BCBSKCRewardsData
				delete from elig.BCBSKCRewardsData where BCBSKCRewardsDataID in (16,17,18,19,20)
				update elig.BCBSKCRewardsData set IsActive =1 where BCBSKCRewardsDataID in (8)
				select * from elig.BCBSKCRewardsData

*/
/*

select * from #TstgEligBenefitData 
select * from #TBCBSKCRewardsData
select * from #TStgClient
select * from elig.BCBSKCRewardsData
delete from elig.BCBSKCRewardsData where MemberID = 999999999 and  BCBSKCRewardsDataID = 21
delete from elig.BCBSKCRewardsData where BCBSKCRewardsDataID = 19
update elig.BCBSKCRewardsData set IsActive = 1
select elig.fdate(NULL)


*/
-- =============================================
CREATE PROCEDURE [elig].[sp_load_stg_to_BCBSKCRewardsData]
(
 @FileTrackID BIGINT
)
AS

DECLARE @procedureName VARCHAR(100) = 'sp_load_stg_to_BCBSKCRewardsData'
DECLARE @dataSource NVARCHAR(50)
DECLARE @LogMessage VARCHAR(max)
DECLARE @UserName VARCHAR(100) = SUSER_SNAME()
DECLARE @ClientCode VARCHAR(100)
DECLARE @FileType VARCHAR(100)
DECLARE @SnapShot VARCHAR(100)
DECLARE @FileInfoID BIGINT
DECLARE @FileID BIGINT

DECLARE @stepName VARCHAR(200);

DECLARE @fileTrackStatusCode varchar(20)
DECLARE @strWhereClause VARCHAR(max) 
DECLARE @strChangeClause VARCHAR(max)
DECLARE @strCrossWalkWhereClause VARCHAR(max)
DECLARE @strNHLink VARCHAR(500)
DECLARE @sql VARCHAR(max)
DECLARE @statusFlag NVARCHAR(10) = 'N'
DECLARE @NewRecordCount INTEGER
DECLARE @RecordsProcessed INTEGER
DECLARE @ErrorRecordCount INTEGER
DECLARE @ChangeRecordCount INTEGER
DECLARE @DropRecordCount INTEGER
DECLARE @NoChangeRecordCount INTEGER
DECLARE @fullFile INT

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
SET NOCOUNT ON

BEGIN TRY



-- select DataSource, SnapShotFlag, FileInfoID, ClientCode, FileType, StatusCode from elig.filetrack where FileTrackID = 298860000 
-- select * from elig.jobAuditLog where ProcedureName = 'sp_elig_load_stg_to_BCBSKCRewardsData' and FileTrackID = 29886 and CreateDate >= '2021-12-01 23:43:07.470' order by CreateDate

select   @dataSource = Datasource
		,@snapshot = Snapshotflag
		,@FileInfoID = FileInfoID
		,@ClientCode = ClientCode
		,@FileType = FileType
		,@fileTrackStatusCode = StatusCode
	from elig.filetrack
	where FileTrackID = @FileTrackID

select @dataSource ,@snapshot, @FileInfoID,@ClientCode,@FileType,@fileTrackStatusCode

if isnull(@fileTrackStatusCode,'999') <> '300'
	begin
		print('no file')
		Return 0
	end 

	print (@ClientCode)
	print (@FileType)
	print (@FileTrackId)

BEGIN TRANSACTION stg_to_BCBSKCRewardsData

set @stepName = 'Start the process to load records from elig.stgEligBenefitData to elig.BCBSKCRewardsData'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'


set @stepName = 'Select the records from elig.stgEligBenefitData'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'

IF OBJECT_ID('tempdb..#TstgEligBenefitData') IS NOT NULL DROP TABLE #TstgEligBenefitData
-- select all the records in the staging table using the FileTrackID, remove all preceding and following spaces from the column data, and remove duplicates
select * into #TstgEligBenefitData from 
(
	select * from (
					select
					'elig.stgEligBenefitData' as TableName_stgEligBenefitData
					,stgEligId as stgEligId_stg
					,elig.fnvarchar(a.Datasource) as Datasource_stg
					,elig.fnvarchar(a.SubscriberID) as MemberID_stg
					,elig.fnvarchar(a.FirstName) as FirstName_stg
					,elig.fnvarchar(a.LastName) as LastName_stg
					,elig.fnvarchar(a.MaintenanceType) as IncentiveType_stg
					,elig.fnvarchar(a.BusinessCategory) as IncentiveCategory_stg
					,elig.fnvarchar(a.MedicalCode) as IncentiveCode_stg
					,elig.fnvarchar(a.MedicalCodeQualifier) as IncentiveCodeDesc_stg
					,elig.fdecimal(a.Premium) as IncentiveValue_stg
					,elig.fdate(a.BenefitStartDate)  as IncentiveFromDate_stg
					,elig.fdate(a.BenefitEndDate) as IncentiveToDate_stg  -- IncentiveToDate is '1900-01-01' if the value is NULL
					,elig.fnvarchar(a.HomePhoneNbr) as PhoneNbr_stg
					,elig.fnvarchar(a.ContractNbr) as ContractNbr_stg
					,elig.fnvarchar(a.PBPID) as PBPID_stg
					,elig.fnvarchar(a.Address1) as ResidentialAddress1_stg
					,elig.fnvarchar(a.Address2) as ResidentialAddress2_stg
					,elig.fnvarchar(a.City) as ResidentialCity_stg
					,elig.fnvarchar(a.State) as ResidentialState_stg
					,elig.fnvarchar(a.ZipCode) as ResidentialZipCode_stg

					,ROW_NUMBER() OVER (
											PARTITION BY  elig.fnvarchar(a.Datasource), elig.fnvarchar(a.SubscriberID),elig.fnvarchar(a.FirstName),elig.fnvarchar(a.MaintenanceType),elig.fnvarchar(a.BusinessCategory)
														 ,elig.fnvarchar(a.MedicalCode),elig.fnvarchar(a.MedicalCodeQualifier),elig.fdecimal(a.Premium),elig.fdate(a.BenefitStartDate),elig.fdate(a.BenefitEndDate),elig.fnvarchar(a.HomePhoneNbr)
														 ,elig.fnvarchar(a.ContractNbr),elig.fnvarchar(a.PBPID),elig.fnvarchar(a.Address1),elig.fnvarchar(a.Address2),elig.fnvarchar(a.City),elig.fnvarchar(a.State),elig.fnvarchar(a.ZipCode)

											ORDER BY      elig.fnvarchar(a.Datasource), elig.fnvarchar(a.SubscriberID),elig.fnvarchar(a.FirstName),elig.fnvarchar(a.MaintenanceType),elig.fnvarchar(a.BusinessCategory)
														 ,elig.fnvarchar(a.MedicalCode),elig.fnvarchar(a.MedicalCodeQualifier),elig.fdecimal(a.Premium),elig.fdate(a.BenefitStartDate),elig.fdate(a.BenefitEndDate),elig.fnvarchar(a.HomePhoneNbr)
														 ,elig.fnvarchar(a.ContractNbr),elig.fnvarchar(a.PBPID),elig.fnvarchar(a.Address1),elig.fnvarchar(a.Address2),elig.fnvarchar(a.City),elig.fnvarchar(a.State),elig.fnvarchar(a.ZipCode)

										)	AS rowid_stg
					from elig.stgEligBenefitData a where a.FileTrackID = 29945--@FileTrackID
					) a
	where a.rowid_stg = 1
) b

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'

-- select * from #TstgEligBenefitData

set @stepName = 'Select the records from elig.BCBSKCRewardsData'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'

IF OBJECT_ID('tempdb..#TBCBSKCRewardsData') IS NOT NULL DROP TABLE #TBCBSKCRewardsData
select * into #TBCBSKCRewardsData from 
(
		select * from (
						select 'elig.BCBSKCRewardsData' as TableName_BCBSKCRewardsData
						,a.BCBSKCRewardsDataID          
						,elig.fnvarchar(a.Datasource) as DataSource
						,elig.fnvarchar(a.MemberID) as MemberID
						,elig.fnvarchar(a.FirstName) as FirstName
						,elig.fnvarchar(a.LastName) as Lastname
						,elig.fnvarchar(a.IncentiveType) as IncentiveType
						,elig.fnvarchar(a.IncentiveCategory) as IncentiveCategory
						,elig.fnvarchar(a.IncentiveCode) as IncentiveCode
						,elig.fnvarchar(a.IncentiveCodeDesc) as IncentiveCodeDesc
						,elig.fdecimal(a.IncentiveValue) as IncentiveValue  -- decimal
						,elig.fdate(a.IncentiveFromDate) as IncentiveFromDate -- date
						,elig.fdate(a.IncentiveToDate) as IncentiveToDate -- date
						,elig.fnvarchar(a.PhoneNbr) as PhoneNbr
						,elig.fnvarchar(a.ContractNbr) as ContractNbr
						,elig.fnvarchar(a.PBPID) as PBPID
						,elig.fnvarchar(a.ResidentialAddress1) as ResidentialAddress1
						,elig.fnvarchar(a.ResidentialAddress2) as ResidentialAddress2
						,elig.fnvarchar(a.ResidentialCity) as ResidentialCity
						,elig.fnvarchar(a.ResidentialState) as ResidentialState
						,elig.fnvarchar(a.ResidentialZipCode) as ResidentialZipCode 
						,a.isActive 
					    ,ROW_NUMBER() OVER ( 
											PARTITION BY elig.fnvarchar(a.Datasource), elig.fnvarchar(a.MemberID),elig.fnvarchar(a.FirstName),elig.fnvarchar(a.LastName),elig.fnvarchar(a.IncentiveType)
														,elig.fnvarchar(a.IncentiveCategory),elig.fnvarchar(a.IncentiveCode),elig.fnvarchar(a.IncentiveCodeDesc),elig.fdecimal(a.IncentiveValue)
														,elig.fdate(a.IncentiveFromDate),elig.fdate(a.IncentiveToDate),elig.fnvarchar(a.PhoneNbr),elig.fnvarchar(a.ContractNbr)
														,elig.fnvarchar(a.PBPID),elig.fnvarchar(a.ResidentialAddress1),elig.fnvarchar(a.ResidentialAddress2) ,elig.fnvarchar(a.ResidentialCity),elig.fnvarchar(a.ResidentialState),elig.fnvarchar(a.ResidentialZipCode)
												    
												ORDER BY elig.fnvarchar(a.Datasource), elig.fnvarchar(a.MemberID),elig.fnvarchar(a.FirstName),elig.fnvarchar(a.LastName),elig.fnvarchar(a.IncentiveType)
														,elig.fnvarchar(a.IncentiveCategory),elig.fnvarchar(a.IncentiveCode),elig.fnvarchar(a.IncentiveCodeDesc),elig.fdecimal(a.IncentiveValue)
														,elig.fdate(a.IncentiveFromDate),elig.fdate(a.IncentiveToDate),elig.fnvarchar(a.PhoneNbr),elig.fnvarchar(a.ContractNbr)
														,elig.fnvarchar(a.PBPID),elig.fnvarchar(a.ResidentialAddress1),elig.fnvarchar(a.ResidentialAddress2) ,elig.fnvarchar(a.ResidentialCity),elig.fnvarchar(a.ResidentialState),elig.fnvarchar(a.ResidentialZipCode)
												    
										   ) AS rowid

						from elig.BCBSKCRewardsData a where a.IsActive = 1 and a.MemberID in (select distinct b.MemberID_stg from #TstgEligBenefitData b)
					  ) a
		where a.rowid = 1
) b

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'

-- select * from #TstgEligBenefitData 
-- select * from #TBCBSKCRewardsData

set @stepName = 'Join the records from elig.stgEligBenefitData and elig.BCBSKCRewardsData'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'

IF OBJECT_ID('tempdb..#TStgClient') IS NOT NULL DROP TABLE #TStgClient
-- Join Stage and Rewards Data
select *, NULL as RecordStatus into #TStgClient from 
(
		select '#TstgEligBenefitData' as TableName_TstgEligBenefitData, a.*, '#TBCBSKCRewardsData' as TableName_TBCBSKCRewardsData, b.* from #TstgEligBenefitData a left join #TBCBSKCRewardsData b 
				on (     a.DataSource_stg = b.DataSource
					 and a.MemberID_stg = b.MemberID
					 --and a.FirstName_stg = b.FirstName
					 --and a.LastName_stg = b.LastName
					 and a.IncentiveType_stg = b.IncentiveType
					 and a.IncentiveCategory_stg = b.IncentiveCategory
					 and a.IncentiveCode_stg = b.IncentiveCode
					 -- and a.IncentiveCodeDesc_stg = b.IncentiveCodeDesc
					 -- and a.IncentiveValue_stg = b.IncentiveValue
					 -- and a.IncentiveFromDate_stg = b.IncentiveFromDate
					 -- and a.IncentiveToDate_stg = b.IncentiveToDate
					 -- and a.PhoneNbr_stg = b.PhoneNbr
					 and a.ContractNbr_stg = b.ContractNbr
					 and a.PBPID_stg = b.PBPID
					 -- and a.ResidentialAddress1_stg = b.ResidentialAddress1
					 -- and a.ResidentialAddress2_stg = b.ResidentialAddress2
					 -- and a.ResidentialCity_stg = b.ResidentialCity
					 -- and a.ResidentialState_stg = b.ResidentialState
					 -- and a.ResidentialZipcode_stg = b.ResidentialZipcode
			)
) a

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'


/*
-- Query to count the various RecordStatus, New (Insert) | Present (None) | Change (Insert and Update)
select case when RecordStatus = 1 then 'New Record' 
			when RecordStatus = 2 then 'Record Present'
			when RecordStatus = 3 then 'Record Insert and Update'
		end as RecordStatus,
count(*) as recordCount from #TStgClient group by RecordStatus
*/

/*
select * from #TstgEligBenefitData 
select * from #TBCBSKCRewardsData
select * from #TStgClient order by stgEligId_stg
*/
-- update #TStgClient set RecordStatus = 'New' where (SubscriberID is null or SubscriberID = '')

-- set 1 as RecordStatus for all new records
set @stepName = 'Set the RecordStatus Flag to 1 for all new records'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'

update #TStgClient set RecordStatus = 1 where (MemberID is null or MemberID = '')

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'

set @stepName = 'Set the RecordStatus Flag to 2 for records already present'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'
--set 2 as RecordStatus for all records that are the same in both stg and client
update #TStgClient set RecordStatus = 2 
where (		 DataSource_stg = DataSource
		 and MemberID_stg = MemberID
		 and FirstName_stg = FirstName
		 and LastName_stg = LastName
		 and IncentiveType_stg = IncentiveType
		 and IncentiveCategory_stg = IncentiveCategory
		 and IncentiveCode_stg = IncentiveCode
		 and IncentiveCodeDesc_stg = IncentiveCodeDesc
		 and IncentiveValue_stg = IncentiveValue
		 and IncentiveFromDate_stg = IncentiveFromDate
		 and IncentiveToDate_stg = IncentiveToDate
		 and PhoneNbr_stg = PhoneNbr
		 and ContractNbr_stg = ContractNbr
		 and PBPID_stg = PBPID
		 and ResidentialAddress1_stg = ResidentialAddress1
		 and ResidentialAddress2_stg = ResidentialAddress2
		 and ResidentialCity_stg = ResidentialCity
		 and ResidentialState_stg = ResidentialState
		 and ResidentialZipcode_stg = ResidentialZipcode
	 )

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'


set @stepName = 'Set the RecordStatus Flag to 3 for all modified records'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'
--set 3 as RecordStatus for all records that are different in both stg and client
update #TStgClient set RecordStatus = 3
where (	    DataSource_stg <> DataSource
		 or MemberID_stg <> MemberID
		 or FirstName_stg <> FirstName
		 or LastName_stg <> LastName
		 or IncentiveType_stg <> IncentiveType
		 or IncentiveCategory_stg <> IncentiveCategory
		 or IncentiveCode_stg <> IncentiveCode
		 or IncentiveCodeDesc_stg <> IncentiveCodeDesc
		 or IncentiveValue_stg <> IncentiveValue
		 or IncentiveFromDate_stg <> IncentiveFromDate
		 or IncentiveToDate_stg <> IncentiveToDate
		 or PhoneNbr_stg <> PhoneNbr
		 or ContractNbr_stg <> ContractNbr
		 or PBPID_stg <> PBPID
		 or ResidentialAddress1_stg <> ResidentialAddress1
		 or ResidentialAddress2_stg <> ResidentialAddress2
		 or ResidentialCity_stg <> ResidentialCity
		 or ResidentialState_stg <> ResidentialState
		 or ResidentialZipcode_stg <> ResidentialZipcode
	 )


-- Start processing updated and new records

set @stepName = 'Insert and update new records and records that have been updated'
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'Start'


-- select * from #TStgClient

DECLARE  @vstgELigId_stg int
		,@vMemberID_stg nvarchar(100) 
		,@vIncentiveType_stg nvarchar(100) 
		,@vIncentiveCategory_stg nvarchar(100)
		,@vIncentiveCode_stg nvarchar(100)
		,@vContractNbr_stg nvarchar(100) 
		,@vPBPID_stg nvarchar(100)
		,@vMessage nvarchar(500)
		,@vBCBSKCRewardsDataID int
		,@vROWCOUNT int

DECLARE cTStgClient CURSOR FOR
-- New and Updated Records
SELECT
stgELigId_stg, MemberID_stg,IncentiveType_stg,IncentiveCategory_stg,IncentiveCode_stg, ContractNbr_stg, PBPID_stg
from #TStgClient where RecordStatus in (1,3) order by stgELigId_stg

--select * from elig.BCBSKCRewardsData

OPEN cTStgClient

FETCH NEXT FROM cTStgClient
INTO @vstgELigId_stg, @vMemberID_stg, @vIncentiveType_stg, @vIncentiveCategory_stg,@vIncentiveCode_stg, @vContractNbr_stg, @vPBPID_stg

select @vstgELigId_stg, @vMemberID_stg, @vIncentiveType_stg, @vIncentiveCategory_stg,@vIncentiveCode_stg, @vContractNbr_stg, @vPBPID_stg


WHILE @@FETCH_STATUS = 0
BEGIN
		PRINT ' '
		SELECT @vMessage = 'Start to process updated and new records'
		PRINT @vMessage
		select @vstgELigId_stg, @vMemberID_stg, @vIncentiveType_stg, @vIncentiveCategory_stg,@vIncentiveCode_stg, @vContractNbr_stg, @vPBPID_stg

		select top 1 @vBCBSKCRewardsDataID  = BCBSKCRewardsDataID from elig.BCBSKCRewardsData 
		where 1=1
		and isActive = 1
		and MemberID = @vMemberID_stg
		and IncentiveType = @vIncentiveType_stg
		and IncentiveCategory = @vIncentiveCategory_stg
		and IncentiveCode = @vIncentiveCode_stg
		and ContractNbr = @vContractNbr_stg
		and PBPID = @vPBPID_stg
		-- and RecordEndDate = '2099-12-31'

		select @vROWCOUNT = @@ROWCOUNT
		select @vROWCOUNT, @vBCBSKCRewardsDataID,  @vstgELigId_stg
		
		IF (@vROWCOUNT > 0 )  -- Updated Records, insert a new record and make IsActive and RecordEndDate to current date minus one
		BEGIN
				select '1' as Rcount, @vstgELigId_stg, @vBCBSKCRewardsDataID
				
				insert into elig.BCBSKCRewardsData 
				(DataSource,MemberID,FirstName,LastName,IncentiveType,IncentiveCategory,IncentiveCode,IncentiveCodeDesc,IncentiveValue,IncentiveFromDate,IncentiveToDate,PhoneNbr,ContractNbr,PBPID,ResidentialAddress1,ResidentialAddress2,ResidentialCity,ResidentialState,ResidentialZipcode,IsActive, RecordEffDate, RecordEndDate) 
				(
				select DataSource_stg, MemberID_stg,FirstName_stg,LastName_stg,IncentiveType_stg,IncentiveCategory_stg,IncentiveCode_stg,IncentiveCodeDesc_stg,IncentiveValue_stg,IncentiveFromDate_stg,IncentiveToDate_stg,PhoneNbr_stg,ContractNbr_stg,PBPID_stg,ResidentialAddress1_stg,ResidentialAddress2_stg,ResidentialCity_stg,ResidentialState_stg,ResidentialZipcode_stg,1, try_convert(date, getdate()), try_cast('2099-12-31' as date)
				from #TStgClient where stgELigId_stg = @vstgELigId_stg
				)

				update elig.BCBSKCRewardsData set IsActive = 0, RecordEndDate = try_cast((getdate() -1) as date) where BCBSKCRewardsDataID = @vBCBSKCRewardsDataID

		END

		IF (@vROWCOUNT = 0 )  -- New Records, insert a new record and set RecordEffDate to current date and RecordEndDate to '2099-12-31'
		BEGIN
			
			select '0' as RCount, @vstgELigId_stg, @vBCBSKCRewardsDataID

			insert into elig.BCBSKCRewardsData 
			(DataSource,MemberID,FirstName,LastName,IncentiveType,IncentiveCategory,IncentiveCode,IncentiveCodeDesc,IncentiveValue,IncentiveFromDate,IncentiveToDate,PhoneNbr,ContractNbr,PBPID,ResidentialAddress1,ResidentialAddress2,ResidentialCity,ResidentialState,ResidentialZipcode,IsActive, RecordEffDate, RecordEndDate) 
			(
			select DataSource_stg, MemberID_stg,FirstName_stg,LastName_stg,IncentiveType_stg,IncentiveCategory_stg,IncentiveCode_stg,IncentiveCodeDesc_stg,IncentiveValue_stg,IncentiveFromDate_stg,IncentiveToDate_stg,PhoneNbr_stg,ContractNbr_stg,PBPID_stg,ResidentialAddress1_stg,ResidentialAddress2_stg,ResidentialCity_stg,ResidentialState_stg,ResidentialZipcode_stg,1, try_convert(date, getdate()), try_cast('2099-12-31' as date)
			from #TStgClient where stgELigId_stg = @vstgELigId_stg
			)
		END

		FETCH NEXT FROM cTStgClient
		INTO @vstgELigId_stg, @vMemberID_stg, @vIncentiveType_stg, @vIncentiveCategory_stg,@vIncentiveCode_stg, @vContractNbr_stg, @vPBPID_stg

END

CLOSE cTStgClient;  
DEALLOCATE cTStgClient;  

exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'


commit transaction stg_to_BCBSKCRewardsData

set @stepName = 'End of the process to Load data from elig.stgEligBenefitData table into BCBSKCRewardsData table '
exec elig.auditlog @ClientCode, @FileTrackID,@procedureName,@stepName,'End'

print 'SUCCESS'
	

END TRY
	
BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION stg_to_BCBSKCRewardsData
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END

GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [elig].[auditlog]    Script Date: 6/26/2024 12:33:05 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [elig].[auditlog] (
	 @ClientCode VARCHAR(20)
    ,@FileTrackId bigint
	,@ProcedureName VARCHAR(MAX)
	,@stepName VARCHAR(MAX)
	,@status varchar(10)
	)
AS


BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON

	Begin  Tran InnerTran

	INSERT INTO elig.jobAuditLog (
		 ClientCode
		,FileTrackID
		,ProcedureName
		,StepName
		,Statuscode
		)
	VALUES (
		 @ClientCode
		 ,@FileTrackId
		,@ProcedureName
		,@stepName
		,@status
		)
	Commit  Tran InnerTran
	print ('Done Commit')
END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[TableExists]    Script Date: 6/26/2024 12:32:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[TableExists] 
(
@TableName varchar(10)
)
AS

BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
SET NOCOUNT ON

BEGIN TRY
SELECT 1 FROM sysobjects WHERE name= @TableName and xtype='U'
SELECT cast(@@ROWCOUNT as int) AS RC
END TRY
	
BEGIN CATCH

	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
	IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION stg_to_BCBSKCRewardsData
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_FISCCXDataLoad]    Script Date: 6/26/2024 12:32:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Santhosh Balla
-- Create date: December 2022
-- Description:	This procedure extracts the different categories into separate tables
-- =============================================
/*
EXEC sp_FISCCXDataLoad

*/

CREATE PROCEDURE [dbo].[sp_FISCCXDataLoad]
	
AS
BEGIN
SET NOCOUNT ON;

/*

-- To verify to check if all the records have been accounted for
select 'AllTables' as TableName, sum(RecordCount) as RecordCount from (
select 'FISCCX_DCST' as TableName,count(*) as RecordCount from FISCCX_DCST union 
select 'FISCCX_DIIA' as TableName,count(*) as RecordCount from FISCCX_DIIA union 
select 'FISCCX_DODL' as TableName,count(*) as RecordCount from FISCCX_DODL union 
select 'FISCCX_DPKG' as TableName,count(*) as RecordCount from FISCCX_DPKG union 
select 'FISCCX_DPRY' as TableName,count(*) as RecordCount from FISCCX_DPRY union 
select 'FISCCX_DPUR' as TableName,count(*) as RecordCount from FISCCX_DPUR union 
select 'FISCCX_DSPG' as TableName,count(*) as RecordCount from FISCCX_DSPG union 
select 'FISCCX_DUSR' as TableName,count(*) as RecordCount from FISCCX_DUSR union 
select 'FISCCX_Header' as TableName,count(*) as RecordCount from FISCCX_Header union 
select 'FISCCX_Trailer' as TableName,count(*) as RecordCount from FISCCX_Trailer
) a
union
select 'StageTable' as TableName, count(*) as RecordCount from [FISCCXStg]
union
select 'FISCCX_Trailer' as TableName, (sum(cast(RecordCount as int)) + count(FileName)*2 ) from FISCCX_Trailer


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Header_Action' and xtype='U')
CREATE TABLE FISCCX_Header_Action  
    (ExistingCode nchar(3),  
     ExistingName nvarchar(50),  
     ExistingDate datetime,  
     ActionTaken nvarchar(10),  
     NewCode nchar(3),  
     NewName nvarchar(50),  
     NewDate datetime  
    );  
*/

-- Header --
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Header' and xtype='U')
CREATE TABLE FISCCX_Header 
(
ID int Identity (1,1),
StgID int not null,
RecordType varchar(max),
ProcessorName varchar(max),
ReportDataFeedName varchar(max),
FileDate varchar(max),
WorkOfDate varchar(max),
ClientID varchar(max),
BankID varchar(max),
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- Trailer --
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Trailer' and xtype='U')
CREATE TABLE FISCCX_Trailer
(
ID int Identity (1,1),
StgID int not null,
RecordType [varchar](max) NULL,
RecordCount [varchar](max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DODL | Tolerance and Overdraft
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DODL' and xtype='U')
CREATE TABLE FISCCX_DODL
(
ID int Identity (1,1),
StgID int not null,
RecordType [varchar](max) NULL,
SubProgramID [varchar](max) NULL,
MCCGroup [varchar](max) NULL,
Fudge [varchar](max) NULL,
IncAuthHoldTimeMCCGroup [varchar](max) NULL,
AuthHoldTimeDays [varchar](max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DPUR | Purse setup
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPUR' and xtype='U')
CREATE TABLE FISCCX_DPUR
(
ID int Identity (1,1),
StgID int not null,
RecordType					varchar(max) NULL,
SubProgramID			    varchar(max) NULL,
PurseID			        varchar(max) NULL,
PurseName			        varchar(max) NULL,
PurseStrategy			    varchar(max) NULL,
AllowedMCCGroups			varchar(max) NULL,
NetworkName			    varchar(max) NULL,
PurseValueLimits			varchar(max) NULL,
MinimumValue			    varchar(max) NULL,
MaximumValue			    varchar(max) NULL,
MinimumLoad			    varchar(max) NULL,
MaximumLoad			    varchar(max) NULL,
[Status]			            varchar(max) NULL,
EffectiveDate			    varchar(max) NULL,
ExpirationDate			    varchar(max) NULL,
ExtensionDate			    varchar(max) NULL,
ExtensionFlagName			varchar(max) NULL,
IsDeleted			        varchar(max) NULL,
PurseHandle			    varchar(max) NULL,
DefaultPurseForAuth	    varchar(max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)


-- DCST | Cash Attribute Parameters
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DCST' and xtype='U')
CREATE TABLE FISCCX_DCST
(
ID int Identity (1,1),
StgID int not null,
RecordType varchar(max) NULL,
SubProgramID varchar(max) NULL,
PurseID varchar(max) NULL,
CashType varchar(max) NULL,
TotalAmountLimit varchar(max) NULL,
TotalCountLimit varchar(max) NULL,
MaxAmountPerTrans varchar(max) NULL,
MinAmountPerTrans varchar(max) NULL,
CycleAmountLimit varchar(max) NULL,
CycleCountLimit varchar(max) NULL,
CycleDays varchar(max) NULL,
IsDeleted varchar(max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DPRY | MCC Purse priority
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPRY' and xtype='U')
CREATE TABLE FISCCX_DPRY			
(			
ID	int	Identity(1,1),
StgID	int	not null,
RecordType	varchar	(max),
SubProgramID	varchar	(max),
PurseID	varchar	(max),
GroupID	varchar	(max),
MCCGroup	varchar	(max),
MCCDesc	varchar	(max),
Priority	varchar	(max),
IsDeleted	varchar	(max),
[FileName]	varchar	(max),	
[IsActive] 	int	default 1,
[CreateUser]	varchar	(max),
[CreateDate]	datetime	default getdate(),
[ModifyUser] 	varchar	(max)	,
[ModifyDate]	datetime	default getdate()
)


-- DUSR | Application Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DUSR' and xtype='U')
CREATE TABLE FISCCX_DUSR			
(			
ID	int	Identity(1,1),
StgID	int	not null,
RecordType	varchar	(max),
ClientID	varchar	(max),
ClientIDName	varchar	(max),
SourceName	varchar	(max),
Username	varchar	(max),
SecurityLevelName	varchar	(max),
Active	varchar	(max),
[FileName]	varchar	(max),
[IsActive] 	int	default 1,
[CreateUser]	varchar	(max) default system_user,
[CreateDate]	datetime	default getdate(),
[ModifyUser] 	varchar	(max) default system_user,
[ModifyDate]	datetime	default getdate(),
)

/*
-- DSPG | Category,General Program Information,Card Parameters,Card Expiration,Auto Renewal,Account Value Limits,Card Fulfillment Embossing,Embossing Options,Additional Attributes,Value Load Velocity Limits,Address Change Velocity Limits,Negative Balance and Dispute Processing,Auto -Chargeback Process,Statement Setup,Direct Access Setup,ACH Trial Deposit Verification,Client Sponsored Consumer ACH File,Private Label ACH Enrollment,Remote Data Capture,PPDB Number,Account to Account Transfer,MCC Restrictions,New additional Attributes,Statement Setup Extended,Direct Access Setup Extended,Copay Configuration,Pay & Chase Configuration,PBM Configuration,
*/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DSPG' and xtype='U')
CREATE TABLE FISCCX_DSPG			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
SubProgramName	varchar	(max)	,
SubProgramActiveFlag	varchar	(max)	,
ProgramID	varchar	(max)	,
ProgramName	varchar	(max)	,
ClientID	varchar	(max)	,
ClientName	varchar	(max)	,
ClientAltValue	varchar	(max)	,
TemplateSubProgramID	varchar	(max)	,
FISAssumeFraudLiability	varchar	(max)	,
ProxyName	varchar	(max)	,
AKAName	varchar	(max)	,
PseudoBIN	varchar	(max)	,
MarketSegment	varchar	(max)	,
ProgramLevel	varchar	(max)	,
ProgramUseProxyNumbers	varchar	(max)	,
ProxyType	varchar	(max)	,
IVRAuthenticationMethod	varchar	(max)	,
CardType	varchar	(max)	,
ProgramType	varchar	(max)	,
PINBased	varchar	(max)	,
PINTries	varchar	(max)	,
NumberOfDaysPINLocked	varchar	(max)	,
RePlastic	varchar	(max)	,
AdvanceExpire	varchar	(max)	,
PrivacyOptOut	varchar	(max)	,
LoadSuspend	varchar	(max)	,
ApproveMissingTransaction	varchar	(max)	,
SkipExpiredClosedCardDDA	varchar	(max)	,
AreCardsReloadable	varchar	(max)	,
InitialCardStatus	varchar	(max)	,
ActiveMethod	varchar	(max)	,
HowWillCardsBeActivated	varchar	(max)	,
PhysicalExpirationMethod	varchar	(max)	,
PhysicalExpirationDate	varchar	(max)	,
PhysicalExpirationMonth	varchar	(max)	,
Logical	varchar	(max)	,
LogicalDynamic	varchar	(max)	,
LogicalExpireEvent	varchar	(max)	,
AutoRenewal	varchar	(max)	,
RenewalWindow	varchar	(max)	,
RenewalMonths	varchar	(max)	,
RenewalCardStatus	varchar	(max)	,
BalanceThreshold	varchar	(max)	,
FinancialActivityWindowInDays	varchar	(max)	,
PositiveFinancialActivityWindow	varchar	(max)	,
UtilizeReplacementPackage	varchar	(max)	,
AccountValueLimits	varchar	(max)	,
FixedValue	varchar	(max)	,
MinValue	varchar	(max)	,
MaxValue	varchar	(max)	,
MinLoadOnCard	varchar	(max)	,
MaxLoadOnCard	varchar	(max)	,
ThirdLineEmbossing	varchar	(max)	,
ThirdLineEmbossStaticName	varchar	(max)	,
FourthLineEmbossing	varchar	(max)	,
FourthLineEmbossStaticName	varchar	(max)	,
EmbossOrPrintBeginDates	varchar	(max)	,
EmbossOrPrintExpireDates	varchar	(max)	,
EmbossOrPrintSecurityCode	varchar	(max)	,
SendPIN	varchar	(max)	,
PINMailerLag	varchar	(max)	,
PINMethod	varchar	(max)	,
CarrierSlotType	varchar	(max)	,
ReturnAddress1	varchar	(max)	,
ReturnAddress2	varchar	(max)	,
ReturnAddress3	varchar	(max)	,
ReturnAddress4	varchar	(max)	,
PrintLine1AccountNumber	varchar	(max)	,
PrintLine2ExpirationDate	varchar	(max)	,
PrintLine3CardholderName	varchar	(max)	,
PrintLine4	varchar	(max)	,
PrintProxy	varchar	(max)	,
PrintIndentCardNumber	varchar	(max)	,
PrintSecurityCodeOnIndent	varchar	(max)	,
IssueDuplicateCard	varchar	(max)	,
EmbossFullDate	varchar	(max)	,
SortBySequentialProxyNumber	varchar	(max)	,
PassCardHolderPhoneNumber	varchar	(max)	,
PassCardholderEmail	varchar	(max)	,
PassCardholderDARoutingInfo	varchar	(max)	,
PassCountry	varchar	(max)	,
PassOtherInformation	varchar	(max)	,
PassClientAltValue	varchar	(max)	,
ParsingRulesToAddress	varchar	(max)	,
ShipmentRecordsFlag	varchar	(max)	,
MagName	varchar	(max)	,
FulfillmentInstructions1	varchar	(max)	,
FulfillmentInstructions2	varchar	(max)	,
DiscretionaryData1	varchar	(max)	,
DiscretionaryData2	varchar	(max)	,
DiscretionaryData3	varchar	(max)	,
CardNumberEmbossingMask	varchar	(max)	,
SecondaryCardsFlag	varchar	(max)	,
NumberOfSecondaryCards	varchar	(max)	,
MaxActivationAttempts	varchar	(max)	,
AllowBillPayFunctionality	varchar	(max)	,
BlockBillingTransactionFlag	varchar	(max)	,
ValueLoadUponActivation	varchar	(max)	,
ExpiredCardConfig	varchar	(max)	,
RetailReloadNetworkServices	varchar	(max)	,
MoneyTransferSetupFlag	varchar	(max)	,
SetupMasterCardMoneySend	varchar	(max)	,
PFraudConfig	varchar	(max)	,
EnableOpenToBuyBalanceAtPOS	varchar	(max)	,
BlockCountry	varchar	(max)	,
UnblockCountry	varchar	(max)	,
IncludeCountry	varchar	(max)	,
VelocityLimitPeriodInDays	varchar	(max)	,
ValueLoadNumberPerPeriod	varchar	(max)	,
ValueLoadAmountPerPeriod	varchar	(max)	,
FrozenFromActivationInDays	varchar	(max)	,
FreqLimitForAddressChange	varchar	(max)	,
MaxNumberOfAddressChanges	varchar	(max)	,
ApplNotConsideredForAddressVelocity	varchar	(max)	,
ClearNegativeBalances	varchar	(max)	,
LiabilityOnNegativeBalances	varchar	(max)	,
MaxNegativeBalanceAutoCleared	varchar	(max)	,
AccountStatusNotAutoCleared	varchar	(max)	,
MaxNegativeBalanceManuallyCleared	varchar	(max)	,
ClearNegativeBalancesAfterEventInDays	varchar	(max)	,
DisputeResolutionServiceFlag	varchar	(max)	,
DisputeProcessGuideLine	varchar	(max)	,
TempCreditToApplyInDays	varchar	(max)	,
TempCreditDisputeToApplyInDays	varchar	(max)	,
DisputeLettersMailed	varchar	(max)	,
SettleServiceAndMoneyMove	varchar	(max)	,
CustomerServicePhoneNumber	varchar	(max)	,
MinAutoChargeBackReviewInDays	varchar	(max)	,
AccountWithPositiveBalance	varchar	(max)	,
Statements	varchar	(max)	,
OnlineStatements	varchar	(max)	,
PaperStatements	varchar	(max)	,
PrintBydefaultOrCHOption	varchar	(max)	,
StatementCycle	varchar	(max)	,
TransactionActivity	varchar	(max)	,
BalanceGreaterThan	varchar	(max)	,
BalanceLessThan	varchar	(max)	,
AccountStatus	varchar	(max)	,
StatementPaper	varchar	(max)	,
StatementTemplate	varchar	(max)	,
StatementFileFormat	varchar	(max)	,
DirectAccessConfig	varchar	(max)	,
DDASponsorBank	varchar	(max)	,
RoutingTransitNumber	varchar	(max)	,
BankPrefix	varchar	(max)	,
Withdrawal	varchar	(max)	,
ValueLoadDirectDepositLimitCheck	varchar	(max)	,
CardStatusUpdate	varchar	(max)	,
CardStatusToPFraud	varchar	(max)	,
FAXNumber	varchar	(max)	,
NameMatchForIRSTaxRefunds	varchar	(max)	,
ACHTrialDepositVerificationConfig	varchar	(max)	,
UserInputAttemptsPermitted	varchar	(max)	,
ValidationInDays	varchar	(max)	,
ACHAccountDisplay	varchar	(max)	,
ValueLoadWaitPeriod	varchar	(max)	,
NumberOfExternalBankAccounts	varchar	(max)	,
ClientACHAccountDisplay	varchar	(max)	,
EffectiveEntryDays	varchar	(max)	,
Active	varchar	(max)	,
ReturnCVV2	varchar	(max)	,
ReturnExpirationDate	varchar	(max)	,
InstantConfigured	varchar	(max)	,
StandardConfigured	varchar	(max)	,
StandardWaitPeriodInDays	varchar	(max)	,
PPDBNumber	varchar	(max)	,
AccountToAccountTransferConfig	varchar	(max)	,
SenderMaxNumberOfRecipients	varchar	(max)	,
SenderLengthOfPeriod	varchar	(max)	,
SenderMaxTransfersPerPeriod	varchar	(max)	,
SenderMaxTransferAmountPerPeriod	varchar	(max)	,
SenderTransfersInDays	varchar	(max)	,
SenderMaxTransferAmountPerDay	varchar	(max)	,
SenderMaxAmountPerTransaction	varchar	(max)	,
SenderMinAmountPerTransaction	varchar	(max)	,
SenderAllowFeeReversal	varchar	(max)	,
SenderQualifiedStatus	varchar	(max)	,
SenderDestinationClients	varchar	(max)	,
SearchReceiverCriteria	varchar	(max)	,
TieBreakerRules	varchar	(max)	,
ReceiverLengthOfPeriod	varchar	(max)	,
ReceiverMaxNumberOfTransfersPerPeriod	varchar	(max)	,
ReceiverMaxTransferAmountPerPeriod	varchar	(max)	,
ReceiverMaxNumberOfTransfersPerDay	varchar	(max)	,
ReceiverMaxTransferAmountPerDay	varchar	(max)	,
ReceiverMaxAmountPerTransaction	varchar	(max)	,
ReceiverMinAmountPerTransaction	varchar	(max)	,
ReceiverQualifiedStatus	varchar	(max)	,
ReceiverDestinationClients	varchar	(max)	,
BlockGamblingMerchantsMCC7995	varchar	(max)	,
BlockCashAndQuasiCash	varchar	(max)	,
OtherMCCsRestricted	varchar	(max)	,
AdditionalProxyLength	varchar	(max)	,
IVRSecondaryAuthMethod	varchar	(max)	,
AutoRenewalOnValueLoad	varchar	(max)	,
SetupRegionalNetworkMoneyTransfer	varchar	(max)	,
DisputeFormTempCredit	varchar	(max)	,
TokenizationAllowed	varchar	(max)	,
IsACHFastPayEnabled	varchar	(max)	,
SenderReversalDays	varchar	(max)	,
ReceiverAllowFeeReversal	varchar	(max)	,
ReceiverReversalDays	varchar	(max)	,
IVROrMyAccountPINOptions	varchar	(max)	,
RestrictAdjust	varchar	(max)	,
FulfillmentRequestType	varchar	(max)	,
StatementMessageContents	varchar	(max)	,
StartDate	varchar	(max)	,
EndDate	varchar	(max)	,
DefaultPurseForDirectAccess	varchar	(max)	,
Copay	varchar	(max)	,
MCCGroupCopay	varchar	(max)	,
FutureUse2	varchar	(max)	,
FutureUse3	varchar	(max)	,
PBM	varchar	(max)	,
MCCGroupPayAndChase	varchar	(max)	,
NetworkName	varchar	(max)	,
PurseStatusAutoRenewal	varchar	(max)	,
RandomPINCardGeneration	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)

-- DIIA | IIAS Group (Healthcare Program Configuration)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DIIA' and xtype='U')
CREATE TABLE FISCCX_DIIA			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
PurseID	varchar	(max)	,
IIAS	varchar	(max)	,
IIASDesc	varchar	(max)	,
IIASGroupID	varchar	(max)	,
IIASGroupDesc	varchar	(max)	,
[Priority]	varchar	(max)	,
IsDeleted	varchar	(max)	,
IIASGroupPriority	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)


-- DPKG | Package Setup, Authorization Parameters
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPKG' and xtype='U')
CREATE TABLE FISCCX_DPKG			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
PackageID	varchar	(max)	,
PackageName	varchar	(max)	,
ArtworkName	varchar	(max)	,
BIN	varchar	(max)	,
PrinAndAgentRange	varchar	(max)	,
FulfillmentHouse	varchar	(max)	,
CardCountThreshold	varchar	(max)	,
CardIssuedSequentFlag	varchar	(max)	,
BarcodeType	varchar	(max)	,
FormFactor	varchar	(max)	,
ReplacementPackageID	varchar	(max)	,
DuplicateSettlementAwaitInDays	varchar	(max)	,
AuthAwaitSettlementInDays	varchar	(max)	,
EncodingMethod	varchar	(max)	,
PartialAuth	varchar	(max)	,
IsDeleted	varchar	(max)	,
ImmediateCredit	varchar	(max)	,
ApprovedProductList	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)

BEGIN TRY

BEGIN TRANSACTION FISCCX_Transaction

MERGE [dbo].[FISCCX_Header] AS tgt  
    USING (SELECT ID as STGID, F1, F2, F3, F4, F5, F6, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'H' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName])  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,ProcessorName,ReportDataFeedName,FileDate,WorkOfDate, ClientID, [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,[FileName]) ; 
    -- OUTPUT deleted.*, $action, inserted.* INTO FISCCX_Header_Action; 


MERGE [dbo].[FISCCX_Trailer] AS tgt  
    USING (SELECT ID as STGID, F1, F2, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'T' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType = src.F1 and tgt.RecordCount = src.F2)  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType, RecordCount, [FileName] )  
        VALUES (STGID,F1,F2,[FileName]) ; 
    -- OUTPUT deleted.*, $action, inserted.* INTO FISCCX_Header_Action; 


MERGE [dbo].[FISCCX_DODL] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DODL' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType= src.F1 and tgt.SubProgramID = src.F2 and tgt.MCCGroup=src.F3 and tgt.Fudge=src.F4 and tgt.IncAuthHoldTimeMCCGroup=src.F5 and  tgt.AuthHoldTimeDays=src.F6 )  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,SubProgramID,MCCGroup,Fudge,IncAuthHoldTimeMCCGroup,AuthHoldTimeDays, [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,[FileName]) ; 


MERGE [dbo].[FISCCX_DPUR] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPUR' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType = src.F1 and tgt.SubProgramID = src.F2 and tgt.PurseID = src.F3 and tgt.PurseName = src.F4 and tgt.PurseStrategy = src.F5 and tgt.AllowedMCCGroups = src.F6 and tgt.NetworkName = src.F7 and tgt.PurseValueLimits = src.F8 and tgt.MinimumValue = src.F9 and tgt.MaximumValue = src.F10 and tgt.MinimumLoad = src.F11 and tgt.MaximumLoad = src.F12 and tgt.[Status] = src.F13 and tgt.EffectiveDate = src.F14 and tgt.ExpirationDate= src.F15 and tgt.ExtensionDate= src.F16 and tgt.ExtensionFlagName= src.F17 and tgt.IsDeleted= src.F18 and tgt.PurseHandle= src.F19 and tgt.DefaultPurseForAuth = src.F20 )
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,	SubProgramID,	PurseID,	PurseName,	PurseStrategy,	AllowedMCCGroups,	NetworkName,	PurseValueLimits,	MinimumValue,	MaximumValue,	MinimumLoad,	MaximumLoad,	[Status],	EffectiveDate,	ExpirationDate,	ExtensionDate,	ExtensionFlagName,	IsDeleted,	PurseHandle,	DefaultPurseForAuth,  [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName]) ; 



/*
(STGID, RecordType,	SubProgramID,	PurseID,	CashType,	TotalAmountLimit,	TotalCountLimit,	MaxAmountPerTrans,	MinAmountPerTrans,	CycleAmountLimit,	CycleCountLimit,	CycleDays,	IsDeleted, [FileName])
src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.CashType and	src.F5=tgt.TotalAmountLimit and	src.F6=tgt.TotalCountLimit and	src.F7=tgt.MaxAmountPerTrans and	src.F8=tgt.MinAmountPerTrans and	src.F9=tgt.CycleAmountLimit and	src.F10=tgt.CycleCountLimit and	src.F11=tgt.CycleDays and	src.F12=tgt.IsDeleted and

*/

MERGE [dbo].[FISCCX_DCST] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DCST' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.CashType and	src.F5=tgt.TotalAmountLimit and	src.F6=tgt.TotalCountLimit and	src.F7=tgt.MaxAmountPerTrans and	src.F8=tgt.MinAmountPerTrans and	src.F9=tgt.CycleAmountLimit and	src.F10=tgt.CycleCountLimit and	src.F11=tgt.CycleDays and	src.F12=tgt.IsDeleted)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,SubProgramID,PurseID,CashType,TotalAmountLimit,TotalCountLimit,MaxAmountPerTrans,MinAmountPerTrans,CycleAmountLimit,CycleCountLimit,CycleDays,IsDeleted,[FileName])
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,[FileName]) ; 

/*
												
[FileName],	RecordType,	SubProgramID,	PurseID,	GroupID,	MCCGroup,	MCCDesc,	Priority,	IsDeleted				
src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.GroupID and	src.F5=tgt.MCCGroup and	src.F6=tgt.MCCDesc and	src.F7=tgt.Priority and	src.F8=tgt.IsDeleted and				
												
*/
MERGE [dbo].[FISCCX_DPRY] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPRY' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.GroupID and	src.F5=tgt.MCCGroup and	src.F6=tgt.MCCDesc and	src.F7=tgt.[Priority] and	src.F8=tgt.IsDeleted)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,	SubProgramID,	PurseID,	GroupID,	MCCGroup,	MCCDesc,	Priority,	IsDeleted, [FileName]	)
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,[FileName]) ; 


MERGE [dbo].[FISCCX_DUSR] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DUSR' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and src.F7=tgt.Active and src.F6=tgt.SecurityLevelName and src.F5=tgt.Username and src.F4=tgt.SourceName and src.F3=tgt.ClientIDName and src.F2=tgt.ClientID and src.F1=tgt.RecordType)

	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,ClientID,ClientIDName,SourceName,Username,SecurityLevelName,Active,[FileName]	)
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,[FileName]) ; 

/*
RecordType,ClientID,ClientIDName,SourceName,Username,SecurityLevelName,Active,[FileName]
src.[FileName]=tgt.[FileName] and src.F7=tgt.Active and src.F6=tgt.SecurityLevelName and src.F5=tgt.Username and src.F4=tgt.SourceName and src.F3=tgt.ClientIDName and src.F2=tgt.ClientID and src.F1=tgt.RecordType and 
*/

MERGE [dbo].[FISCCX_DSPG] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DSPG' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.SubProgramName and src.F4=tgt.SubProgramActiveFlag and src.F5=tgt.ProgramID and src.F6=tgt.ProgramName and src.F7=tgt.ClientID and src.F8=tgt.ClientName and src.F9=tgt.ClientAltValue and src.F10=tgt.TemplateSubProgramID and src.F11=tgt.FISAssumeFraudLiability and src.F12=tgt.ProxyName and src.F13=tgt.AKAName and src.F14=tgt.PseudoBIN and src.F15=tgt.MarketSegment and src.F16=tgt.ProgramLevel and src.F17=tgt.ProgramUseProxyNumbers and src.F18=tgt.ProxyType and src.F19=tgt.IVRAuthenticationMethod and src.F20=tgt.CardType and src.F21=tgt.ProgramType and src.F22=tgt.PINBased and src.F23=tgt.PINTries and src.F24=tgt.NumberOfDaysPINLocked and src.F25=tgt.RePlastic and src.F26=tgt.AdvanceExpire and src.F27=tgt.PrivacyOptOut and src.F28=tgt.LoadSuspend and src.F29=tgt.ApproveMissingTransaction and src.F30=tgt.SkipExpiredClosedCardDDA and src.F31=tgt.AreCardsReloadable and src.F32=tgt.InitialCardStatus and src.F33=tgt.ActiveMethod and src.F34=tgt.HowWillCardsBeActivated and src.F35=tgt.PhysicalExpirationMethod and src.F36=tgt.PhysicalExpirationDate and src.F37=tgt.PhysicalExpirationMonth and src.F38=tgt.Logical and src.F39=tgt.LogicalDynamic and src.F40=tgt.LogicalExpireEvent and src.F41=tgt.AutoRenewal and src.F42=tgt.RenewalWindow and src.F43=tgt.RenewalMonths and src.F44=tgt.RenewalCardStatus and src.F45=tgt.BalanceThreshold and src.F46=tgt.FinancialActivityWindowInDays and src.F47=tgt.PositiveFinancialActivityWindow and src.F48=tgt.UtilizeReplacementPackage and src.F49=tgt.AccountValueLimits and src.F50=tgt.FixedValue and src.F51=tgt.MinValue and src.F52=tgt.MaxValue and src.F53=tgt.MinLoadOnCard and src.F54=tgt.MaxLoadOnCard and src.F55=tgt.ThirdLineEmbossing and src.F56=tgt.ThirdLineEmbossStaticName and src.F57=tgt.FourthLineEmbossing and src.F58=tgt.FourthLineEmbossStaticName and src.F59=tgt.EmbossOrPrintBeginDates and src.F60=tgt.EmbossOrPrintExpireDates and src.F61=tgt.EmbossOrPrintSecurityCode and src.F62=tgt.SendPIN and src.F63=tgt.PINMailerLag and src.F64=tgt.PINMethod and src.F65=tgt.CarrierSlotType and src.F66=tgt.ReturnAddress1 and src.F67=tgt.ReturnAddress2 and src.F68=tgt.ReturnAddress3 and src.F69=tgt.ReturnAddress4 and src.F70=tgt.PrintLine1AccountNumber and src.F71=tgt.PrintLine2ExpirationDate and src.F72=tgt.PrintLine3CardholderName and src.F73=tgt.PrintLine4 and src.F74=tgt.PrintProxy and src.F75=tgt.PrintIndentCardNumber and src.F76=tgt.PrintSecurityCodeOnIndent and src.F77=tgt.IssueDuplicateCard and src.F78=tgt.EmbossFullDate and src.F79=tgt.SortBySequentialProxyNumber and src.F80=tgt.PassCardHolderPhoneNumber and src.F81=tgt.PassCardHolderEmail and src.F82=tgt.PassCardHolderDARoutingInfo and src.F83=tgt.PassCountry and src.F84=tgt.PassOtherInformation and src.F85=tgt.PassClientAltValue and src.F86=tgt.ParsingRulesToAddress and src.F87=tgt.ShipmentRecordsFlag and src.F88=tgt.MagName and src.F89=tgt.FulfillmentInstructions1 and src.F90=tgt.FulfillmentInstructions2 and src.F91=tgt.DiscretionaryData1 and src.F92=tgt.DiscretionaryData2 and src.F93=tgt.DiscretionaryData3 and src.F94=tgt.CardNumberEmbossingMask and src.F95=tgt.SecondaryCardsFlag and src.F96=tgt.NumberOfSecondaryCards and src.F97=tgt.MaxActivationAttempts and src.F98=tgt.AllowBillPayFunctionality and src.F99=tgt.BlockBillingTransactionFlag and src.F100=tgt.ValueLoadUponActivation and src.F101=tgt.ExpiredCardConfig and src.F102=tgt.RetailReloadNetworkServices and src.F103=tgt.MoneyTransferSetupFlag and src.F104=tgt.SetupMasterCardMoneySend and src.F105=tgt.PFraudConfig and src.F106=tgt.EnableOpenToBuyBalanceAtPOS and src.F107=tgt.BlockCountry and src.F108=tgt.UnblockCountry and src.F109=tgt.IncludeCountry and src.F110=tgt.VelocityLimitPeriodInDays and src.F111=tgt.ValueLoadNumberPerPeriod and src.F112=tgt.ValueLoadAmountPerPeriod and src.F113=tgt.FrozenFromActivationInDays and src.F114=tgt.FreqLimitForAddressChange and src.F115=tgt.MaxNumberOfAddressChanges and src.F116=tgt.ApplNotConsideredForAddressVelocity and src.F117=tgt.ClearNegativeBalances and src.F118=tgt.LiabilityOnNegativeBalances and src.F119=tgt.MaxNegativeBalanceAutoCleared and src.F120=tgt.AccountStatusNotAutoCleared and src.F121=tgt.MaxNegativeBalanceManuallyCleared and src.F122=tgt.ClearNegativeBalancesAfterEventInDays and src.F123=tgt.DisputeResolutionServiceFlag and src.F124=tgt.DisputeProcessGuideLine and src.F125=tgt.TempCreditToApplyInDays and src.F126=tgt.TempCreditDisputeToApplyInDays and src.F127=tgt.DisputeLettersMailed and src.F128=tgt.SettleServiceAndMoneyMove and src.F129=tgt.CustomerServicePhoneNumber and src.F130=tgt.MinAutoChargeBackReviewInDays and src.F131=tgt.AccountWithPositiveBalance and src.F132=tgt.Statements and src.F133=tgt.OnlineStatements and src.F134=tgt.PaperStatements and src.F135=tgt.PrintBydefaultOrCHOption and src.F136=tgt.StatementCycle and src.F137=tgt.TransactionActivity and src.F138=tgt.BalanceGreaterThan and src.F139=tgt.BalanceLessThan and src.F140=tgt.AccountStatus and src.F141=tgt.StatementPaper and src.F142=tgt.StatementTemplate and src.F143=tgt.StatementFileFormat and src.F144=tgt.DirectAccessConfig and src.F145=tgt.DDASponsorBank and src.F146=tgt.RoutingTransitNumber and src.F147=tgt.BankPrefix and src.F148=tgt.Withdrawal and src.F149=tgt.ValueLoadDirectDepositLimitCheck and src.F150=tgt.CardStatusUpdate and src.F151=tgt.CardStatusToPFraud and src.F152=tgt.FAXNumber and src.F153=tgt.NameMatchForIRSTaxRefunds and src.F154=tgt.ACHTrialDepositVerificationConfig and src.F155=tgt.UserInputAttemptsPermitted and src.F156=tgt.ValidationInDays and src.F157=tgt.ACHAccountDisplay and src.F158=tgt.ValueLoadWaitPeriod and src.F159=tgt.NumberOfExternalBankAccounts and src.F160=tgt.ClientACHAccountDisplay and src.F161=tgt.EffectiveEntryDays and src.F162=tgt.Active and src.F163=tgt.ReturnCVV2 and src.F164=tgt.ReturnExpirationDate and src.F165=tgt.InstantConfigured and src.F166=tgt.StandardConfigured and src.F167=tgt.StandardWaitPeriodInDays and src.F168=tgt.PPDBNumber and src.F169=tgt.AccountToAccountTransferConfig and src.F170=tgt.SenderMaxNumberOfRecipients and src.F171=tgt.SenderLengthOfPeriod and src.F172=tgt.SenderMaxTransfersPerPeriod and src.F173=tgt.SenderMaxTransferAmountPerPeriod and src.F174=tgt.SenderTransfersInDays and src.F175=tgt.SenderMaxTransferAmountPerDay and src.F176=tgt.SenderMaxAmountPerTransaction and src.F177=tgt.SenderMinAmountPerTransaction and src.F178=tgt.SenderAllowFeeReversal and src.F179=tgt.SenderQualifiedStatus and src.F180=tgt.SenderDestinationClients and src.F181=tgt.SearchReceiverCriteria and src.F182=tgt.TieBreakerRules and src.F183=tgt.ReceiverLengthofPeriod and src.F184=tgt.ReceiverMaxNumberOfTransfersPerPeriod and src.F185=tgt.ReceiverMaxTransferAmountPerPeriod and src.F186=tgt.ReceiverMaxNumberofTransfersPerDay and src.F187=tgt.ReceiverMaxTransferAmountPerDay and src.F188=tgt.ReceiverMaxAmountPerTransaction and src.F189=tgt.ReceiverMinAmountPerTransaction and src.F190=tgt.ReceiverQualifiedStatus and src.F191=tgt.ReceiverDestinationClients and src.F192=tgt.BlockGamblingMerchantsMCC7995 and src.F193=tgt.BlockCashandQuasiCash and src.F194=tgt.OtherMCCsRestricted and src.F195=tgt.AdditionalProxyLength and src.F196=tgt.IVRSecondaryAuthMethod and src.F197=tgt.AutoRenewalOnValueLoad and src.F198=tgt.SetupRegionalNetworkMoneyTransfer and src.F199=tgt.DisputeFormTempCredit and src.F200=tgt.TokenizationAllowed and src.F201=tgt.IsACHFastPayEnabled and src.F202=tgt.SenderReversalDays and src.F203=tgt.ReceiverAllowFeeReversal and src.F204=tgt.ReceiverReversalDays and src.F205=tgt.IVROrMyAccountPINOptions and src.F206=tgt.RestrictAdjust and src.F207=tgt.FulfillmentRequestType and src.F208=tgt.StatementMessageContents and src.F209=tgt.StartDate and src.F210=tgt.EndDate and src.F211=tgt.DefaultPurseForDirectAccess and src.F212=tgt.Copay and src.F213=tgt.MCCGroupCopay and src.F214=tgt.FutureUse2 and src.F215=tgt.FutureUse3 and src.F216=tgt.PBM and src.F217=tgt.MCCGroupPayAndChase and src.F218=tgt.NetworkName and src.F219=tgt.PurseStatusAutoRenewal and src.F220=tgt.RandomPINCardGeneration)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,SubProgramName,SubProgramActiveFlag,ProgramID,ProgramName,ClientID,ClientName,ClientAltValue,TemplateSubProgramID,FISAssumeFraudLiability,ProxyName,AKAName,PseudoBIN,MarketSegment,ProgramLevel,ProgramUseProxyNumbers,ProxyType,IVRAuthenticationMethod,CardType,ProgramType,PINBased,PINTries,NumberOfDaysPINLocked,RePlastic,AdvanceExpire,PrivacyOptOut,LoadSuspend,ApproveMissingTransaction,SkipExpiredClosedCardDDA,AreCardsReloadable,InitialCardStatus,ActiveMethod,HowWillCardsBeActivated,PhysicalExpirationMethod,PhysicalExpirationDate,PhysicalExpirationMonth,Logical,LogicalDynamic,LogicalExpireEvent,AutoRenewal,RenewalWindow,RenewalMonths,RenewalCardStatus,BalanceThreshold,FinancialActivityWindowInDays,PositiveFinancialActivityWindow,UtilizeReplacementPackage,AccountValueLimits,FixedValue,MinValue,MaxValue,MinLoadOnCard,MaxLoadonCard,ThirdLineEmbossing,ThirdLineEmbossStaticName,FourthLineEmbossing,FourthLineEmbossStaticName,EmbossOrPrintBeginDates,EmbossOrPrintExpireDates,EmbossOrPrintSecurityCode,SendPIN,PINMailerLag,PINMethod,CarrierSlotType,ReturnAddress1,ReturnAddress2,ReturnAddress3,ReturnAddress4,PrintLine1AccountNumber,PrintLine2ExpirationDate,PrintLine3CardholderName,PrintLine4,PrintProxy,PrintIndentCardNumber,PrintSecurityCodeOnIndent,IssueDuplicateCard,EmbossFullDate,SortBySequentialProxyNumber,PassCardHolderPhoneNumber,PassCardholderEmail,PassCardholderDARoutingInfo,PassCountry,PassOtherInformation,PassClientAltValue,ParsingRulesToAddress,ShipmentRecordsFlag,MagName,FulfillmentInstructions1,FulfillmentInstructions2,DiscretionaryData1,DiscretionaryData2,DiscretionaryData3,CardNumberEmbossingMask,SecondaryCardsFlag,NumberOfSecondaryCards,MaxActivationAttempts,AllowBillPayFunctionality,BlockBillingTransactionFlag,ValueLoaduponActivation,ExpiredCardConfig,RetailReloadNetworkServices,MoneyTransferSetupFlag,SetupMasterCardMoneySend,PFraudConfig,EnableOpenToBuyBalanceAtPOS,BlockCountry,UnblockCountry,IncludeCountry,VelocityLimitPeriodInDays,ValueLoadNumberPerPeriod,ValueLoadAmountPerPeriod,FrozenFromActivationInDays,FreqLimitForAddressChange,MaxNumberOfAddressChanges,ApplNotConsideredForAddressVelocity,ClearNegativeBalances,LiabilityOnNegativeBalances,MaxNegativeBalanceAutoCleared,AccountStatusNotAutoCleared,MaxNegativeBalanceManuallyCleared,ClearNegativeBalancesAfterEventInDays,DisputeResolutionServiceFlag,DisputeProcessGuideLine,TempCreditToApplyInDays,TempCreditDisputeToApplyInDays,DisputeLettersMailed,SettleServiceAndMoneyMove,CustomerServicePhoneNumber,MinAutoChargeBackReviewInDays,AccountWithPositiveBalance,Statements,OnlineStatements,PaperStatements,PrintBydefaultOrCHOption,StatementCycle,TransactionActivity,BalanceGreaterThan,BalanceLessThan,AccountStatus,StatementPaper,StatementTemplate,StatementFileFormat,DirectAccessConfig,DDASponsorBank,RoutingTransitNumber,BankPrefix,Withdrawal,ValueLoadDirectDepositLimitCheck,CardStatusUpdate,CardStatusToPFraud,FAXNumber,NameMatchForIRSTaxRefunds,ACHTrialDepositVerificationConfig,UserInputAttemptsPermitted,ValidationInDays,ACHAccountDisplay,ValueLoadWaitPeriod,NumberOfExternalBankAccounts,ClientACHAccountDisplay,EffectiveEntryDays,Active,ReturnCVV2,ReturnExpirationDate,InstantConfigured,StandardConfigured,StandardWaitPeriodInDays,PPDBNumber,AccountToAccountTransferConfig,SenderMaxNumberOfRecipients,SenderLengthOfPeriod,SenderMaxTransfersPerPeriod,SenderMaxTransferAmountPerPeriod,SenderTransfersInDays,SenderMaxTransferAmountPerDay,SenderMaxAmountPerTransaction,SenderMinAmountPerTransaction,SenderAllowFeeReversal,SenderQualifiedStatus,SenderDestinationClients,SearchReceiverCriteria,TieBreakerRules,ReceiverLengthofPeriod,ReceiverMaxNumberOfTransfersPerPeriod,ReceiverMaxTransferAmountPerPeriod,ReceiverMaxNumberofTransfersPerDay,ReceiverMaxTransferAmountPerDay,ReceiverMaxAmountPerTransaction,ReceiverMinAmountPerTransaction,ReceiverQualifiedStatus,ReceiverDestinationClients,BlockGamblingMerchantsMCC7995,BlockCashandQuasiCash,OtherMCCsRestricted,AdditionalProxyLength,IVRSecondaryAuthMethod,AutoRenewalOnValueLoad,SetupRegionalNetworkMoneyTransfer,DisputeFormTempCredit,TokenizationAllowed,IsACHFastPayEnabled,SenderReversalDays,ReceiverAllowFeeReversal,ReceiverReversalDays,IVROrMyAccountPINOptions,RestrictAdjust,FulfillmentRequestType,StatementMessageContents,StartDate,EndDate,DefaultPurseForDirectAccess,Copay,MCCGroupCopay,FutureUse2,FutureUse3,PBM,MCCGroupPayAndChase,NetworkName,PurseStatusAutoRenewal,RandomPINCardGeneration,[FileName]	)
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName]
) ; 

/* -- DSPG
F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName]
RecordType,SubProgramID,SubProgramName,SubProgramActiveFlag,ProgramID,ProgramName,ClientID,ClientName,ClientAltValue,TemplateSubProgramID,FISAssumeFraudLiability,ProxyName,AKAName,PseudoBIN,MarketSegment,ProgramLevel,ProgramUseProxyNumbers,ProxyType,IVRAuthenticationMethod,CardType,ProgramType,PINBased,PINTries,NumberOfDaysPINLocked,RePlastic,AdvanceExpire,PrivacyOptOut,LoadSuspend,ApproveMissingTransaction,SkipExpiredClosedCardDDA,AreCardsReloadable,InitialCardStatus,ActiveMethod,HowWillCardsBeActivated,PhysicalExpirationMethod,PhysicalExpirationDate,PhysicalExpirationMonth,Logical,LogicalDynamic,LogicalExpireEvent,AutoRenewal,RenewalWindow,RenewalMonths,RenewalCardStatus,BalanceThreshold,FinancialActivityWindowInDays,PositiveFinancialActivityWindow,UtilizeReplacementPackage,AccountValueLimits,FixedValue,MinValue,MaxValue,MinLoadOnCard,MaxLoadonCard,ThirdLineEmbossing,ThirdLineEmbossStaticName,FourthLineEmbossing,FourthLineEmbossStaticName,EmbossOrPrintBeginDates,EmbossOrPrintExpireDates,EmbossOrPrintSecurityCode,SendPIN,PINMailerLag,PINMethod,CarrierSlotType,ReturnAddress1,ReturnAddress2,ReturnAddress3,ReturnAddress4,PrintLine1AccountNumber,PrintLine2ExpirationDate,PrintLine3CardholderName,PrintLine4,PrintProxy,PrintIndentCardNumber,PrintSecurityCodeOnIndent,IssueDuplicateCard,EmbossFullDate,SortBySequentialProxyNumber,PassCardHolderPhoneNumber,PassCardholderEmail,PassCardholderDARoutingInfo,PassCountry,PassOtherInformation,PassClientAltValue,ParsingRulesToAddress,ShipmentRecordsFlag,MagName,FulfillmentInstructions1,FulfillmentInstructions2,DiscretionaryData1,DiscretionaryData2,DiscretionaryData3,CardNumberEmbossingMask,SecondaryCardsFlag,NumberOfSecondaryCards,MaxActivationAttempts,AllowBillPayFunctionality,BlockBillingTransactionFlag,ValueLoaduponActivation,ExpiredCardConfig,RetailReloadNetworkServices,MoneyTransferSetupFlag,SetupMasterCardMoneySend,PFraudConfig,EnableOpenToBuyBalanceAtPOS,BlockCountry,UnblockCountry,IncludeCountry,VelocityLimitPeriodInDays,ValueLoadNumberPerPeriod,ValueLoadAmountPerPeriod,FrozenFromActivationInDays,FreqLimitForAddressChange,MaxNumberOfAddressChanges,ApplNotConsideredForAddressVelocity,ClearNegativeBalances,LiabilityOnNegativeBalances,MaxNegativeBalanceAutoCleared,AccountStatusNotAutoCleared,MaxNegativeBalanceManuallyCleared,ClearNegativeBalancesAfterEventInDays,DisputeResolutionServiceFlag,DisputeProcessGuideLine,TempCreditToApplyInDays,TempCreditDisputeToApplyInDays,DisputeLettersMailed,SettleServiceAndMoneyMove,CustomerServicePhoneNumber,MinAutoChargeBackReviewInDays,AccountWithPositiveBalance,Statements,OnlineStatements,PaperStatements,PrintBydefaultOrCHOption,StatementCycle,TransactionActivity,BalanceGreaterThan,BalanceLessThan,AccountStatus,StatementPaper,StatementTemplate,StatementFileFormat,DirectAccessConfig,DDASponsorBank,RoutingTransitNumber,BankPrefix,Withdrawal,ValueLoadDirectDepositLimitCheck,CardStatusUpdate,CardStatusToPFraud,FAXNumber,NameMatchForIRSTaxRefunds,ACHTrialDepositVerificationConfig,UserInputAttemptsPermitted,ValidationInDays,ACHAccountDisplay,ValueLoadWaitPeriod,NumberOfExternalBankAccounts,ClientACHAccountDisplay,EffectiveEntryDays,Active,ReturnCVV2,ReturnExpirationDate,InstantConfigured,StandardConfigured,StandardWaitPeriodInDays,PPDBNumber,AccountToAccountTransferConfig,SenderMaxNumberOfRecipients,SenderLengthOffPeriod,SenderMaxTransfersPerPeriod,SenderMaxTransferAmountPerPeriod,SenderTransfersInDays,SenderMaxTransferAmountPerDay,SenderMaxAmountPerTransaction,SenderMinAmountPerTransaction,SenderAllowFeeReversal,SenderQualifiedStatus,SenderDestinationClients,SearchReceiverCriteria,TieBreakerRules,ReceiverLengthofPeriod,ReceiverMaxNumberOfTransfersPerPeriod,ReceiverMaxTransferAmountPerPeriod,ReceiverMaxNumberofTransfersPerDay,ReceiverMaxTransferAmountPerDay,ReceiverMaxAmountPerTransaction,ReceiverMinAmountPerTransaction,ReceiverQualifiedStatus,ReceiverDestinationClients,BlockGamblingMerchantsMCC7995,BlockCashandQuasiCash,OtherMCCsRestricted,AdditionalProxyLength,IVRSecondaryAuthMethod,AutoRenewalOnValueLoad,SetupRegionalNetworkMoneyTransfer,DisputeFormTempCredit,TokenizationAllowed,IsACHFastPayEnabled,SenderReversalDays,ReceiverAllowFeeReversal,ReceiverReversalDays,IVROrMyAccountPINOptions,RestrictAdjust,FulfillmentRequestType,StatementMessageContents,StartDate,EndDate,DefaultPurseForDirectAccess,Copay,MCCGroupCopay,FutureUse2,FutureUse3,PBM,MCCGroupPayAndChase,NetworkName,PurseStatusAutoRenewal,RandomPINCardGeneration,[FileName],
(src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.SubProgramName and src.F4=tgt.SubProgramActiveFlag and src.F5=tgt.ProgramID and src.F6=tgt.ProgramName and src.F7=tgt.ClientID and src.F8=tgt.ClientName and src.F9=tgt.ClientAltValue and src.F10=tgt.TemplateSubProgramID and src.F11=tgt.FISAssumeFraudLiability and src.F12=tgt.ProxyName and src.F13=tgt.AKAName and src.F14=tgt.PseudoBIN and src.F15=tgt.MarketSegment and src.F16=tgt.ProgramLevel and src.F17=tgt.ProgramUseProxyNumbers and src.F18=tgt.ProxyType and src.F19=tgt.IVRAuthenticationMethod and src.F20=tgt.CardType and src.F21=tgt.ProgramType and src.F22=tgt.PINBased and src.F23=tgt.PINTries and src.F24=tgt.NumberOfDaysPINLocked and src.F25=tgt.RePlastic and src.F26=tgt.AdvanceExpire and src.F27=tgt.PrivacyOptOut and src.F28=tgt.LoadSuspend and src.F29=tgt.ApproveMissingTransaction and src.F30=tgt.SkipExpiredClosedCardDDA and src.F31=tgt.AreCardsReloadable and src.F32=tgt.InitialCardStatus and src.F33=tgt.ActiveMethod and src.F34=tgt.HowWillCardsBeActivated and src.F35=tgt.PhysicalExpirationMethod and src.F36=tgt.PhysicalExpirationDate and src.F37=tgt.PhysicalExpirationMonth and src.F38=tgt.Logical and src.F39=tgt.LogicalDynamic and src.F40=tgt.LogicalExpireEvent and src.F41=tgt.AutoRenewal and src.F42=tgt.RenewalWindow and src.F43=tgt.RenewalMonths and src.F44=tgt.RenewalCardStatus and src.F45=tgt.BalanceThreshold and src.F46=tgt.FinancialActivityWindowInDays and src.F47=tgt.PositiveFinancialActivityWindow and src.F48=tgt.UtilizeReplacementPackage and src.F49=tgt.AccountValueLimits and src.F50=tgt.FixedValue and src.F51=tgt.MinValue and src.F52=tgt.MaxValue and src.F53=tgt.MinLoadOnCard and src.F54=tgt.MaxLoadonCard and src.F55=tgt.ThirdLineEmbossing and src.F56=tgt.ThirdLineEmbossStaticName and src.F57=tgt.FourthLineEmbossing and src.F58=tgt.FourthLineEmbossStaticName and src.F59=tgt.EmbossOrPrintBeginDates and src.F60=tgt.EmbossOrPrintExpireDates and src.F61=tgt.EmbossOrPrintSecurityCode and src.F62=tgt.SendPIN and src.F63=tgt.PINMailerLag and src.F64=tgt.PINMethod and src.F65=tgt.CarrierSlotType and src.F66=tgt.ReturnAddress1 and src.F67=tgt.ReturnAddress2 and src.F68=tgt.ReturnAddress3 and src.F69=tgt.ReturnAddress4 and src.F70=tgt.PrintLine1AccountNumber and src.F71=tgt.PrintLine2ExpirationDate and src.F72=tgt.PrintLine3CardholderName and src.F73=tgt.PrintLine4 and src.F74=tgt.PrintProxy and src.F75=tgt.PrintIndentCardNumber and src.F76=tgt.PrintSecurityCodeOnIndent and src.F77=tgt.IssueDuplicateCard and src.F78=tgt.EmbossFullDate and src.F79=tgt.SortBySequentialProxyNumber and src.F80=tgt.PassCardHolderPhoneNumber and src.F81=tgt.PassCardholderEmail and src.F82=tgt.PassCardholderDARoutingInfo and src.F83=tgt.PassCountry and src.F84=tgt.PassOtherInformation and src.F85=tgt.PassClientAltValue and src.F86=tgt.ParsingRulesToAddress and src.F87=tgt.ShipmentRecordsFlag and src.F88=tgt.MagName and src.F89=tgt.FulfillmentInstructions1 and src.F90=tgt.FulfillmentInstructions2 and src.F91=tgt.DiscretionaryData1 and src.F92=tgt.DiscretionaryData2 and src.F93=tgt.DiscretionaryData3 and src.F94=tgt.CardNumberEmbossingMask and src.F95=tgt.SecondaryCardsFlag and src.F96=tgt.NumberOfSecondaryCards and src.F97=tgt.MaxActivationAttempts and src.F98=tgt.AllowBillPayFunctionality and src.F99=tgt.BlockBillingTransactionFlag and src.F100=tgt.ValueLoaduponActivation and src.F101=tgt.ExpiredCardConfig and src.F102=tgt.RetailReloadNetworkServices and src.F103=tgt.MoneyTransferSetupFlag and src.F104=tgt.SetupMasterCardMoneySend and src.F105=tgt.PFraudConfig and src.F106=tgt.EnableOpenToBuyBalanceAtPOS and src.F107=tgt.BlockCountry and src.F108=tgt.UnblockCountry and src.F109=tgt.IncludeCountry and src.F110=tgt.VelocityLimitPeriodInDays and src.F111=tgt.ValueLoadNumberPerPeriod and src.F112=tgt.ValueLoadAmountPerPeriod and src.F113=tgt.FrozenFromActivationInDays and src.F114=tgt.FreqLimitForAddressChange and src.F115=tgt.MaxNumberOfAddressChanges and src.F116=tgt.ApplNotConsideredForAddressVelocity and src.F117=tgt.ClearNegativeBalances and src.F118=tgt.LiabilityOnNegativeBalances and src.F119=tgt.MaxNegativeBalanceAutoCleared and src.F120=tgt.AccountStatusNotAutoCleared and src.F121=tgt.MaxNegativeBalanceManuallyCleared and src.F122=tgt.ClearNegativeBalancesAfterEventInDays and src.F123=tgt.DisputeResolutionServiceFlag and src.F124=tgt.DisputeProcessGuideLine and src.F125=tgt.TempCreditToApplyInDays and src.F126=tgt.TempCreditDisputeToApplyInDays and src.F127=tgt.DisputeLettersMailed and src.F128=tgt.SettleServiceAndMoneyMove and src.F129=tgt.CustomerServicePhoneNumber and src.F130=tgt.MinAutoChargeBackReviewInDays and src.F131=tgt.AccountWithPositiveBalance and src.F132=tgt.Statements and src.F133=tgt.OnlineStatements and src.F134=tgt.PaperStatements and src.F135=tgt.PrintBydefaultOrCHOption and src.F136=tgt.StatementCycle and src.F137=tgt.TransactionActivity and src.F138=tgt.BalanceGreaterThan and src.F139=tgt.BalanceLessThan and src.F140=tgt.AccountStatus and src.F141=tgt.StatementPaper and src.F142=tgt.StatementTemplate and src.F143=tgt.StatementFileFormat and src.F144=tgt.DirectAccessConfig and src.F145=tgt.DDASponsorBank and src.F146=tgt.RoutingTransitNumber and src.F147=tgt.BankPrefix and src.F148=tgt.Withdrawal and src.F149=tgt.ValueLoadDirectDepositLimitCheck and src.F150=tgt.CardStatusUpdate and src.F151=tgt.CardStatusToPFraud and src.F152=tgt.FAXNumber and src.F153=tgt.NameMatchForIRSTaxRefunds and src.F154=tgt.ACHTrialDepositVerificationConfig and src.F155=tgt.UserInputAttemptsPermitted and src.F156=tgt.ValidationInDays and src.F157=tgt.ACHAccountDisplay and src.F158=tgt.ValueLoadWaitPeriod and src.F159=tgt.NumberOfExternalBankAccounts and src.F160=tgt.ClientACHAccountDisplay and src.F161=tgt.EffectiveEntryDays and src.F162=tgt.Active and src.F163=tgt.ReturnCVV2 and src.F164=tgt.ReturnExpirationDate and src.F165=tgt.InstantConfigured and src.F166=tgt.StandardConfigured and src.F167=tgt.StandardWaitPeriodInDays and src.F168=tgt.PPDBNumber and src.F169=tgt.AccountToAccountTransferConfig and src.F170=tgt.SenderMaxNumberOfRecipients and src.F171=tgt.SenderLengthOfPeriod and src.F172=tgt.SenderMaxTransfersPerPeriod and src.F173=tgt.SenderMaxTransferAmountPerPeriod and src.F174=tgt.SenderTransfersInDays and src.F175=tgt.SenderMaxTransferAmountPerDay and src.F176=tgt.SenderMaxAmountPerTransaction and src.F177=tgt.SenderMinAmountPerTransaction and src.F178=tgt.SenderAllowFeeReversal and src.F179=tgt.SenderQualifiedStatus and src.F180=tgt.SenderDestinationClients and src.F181=tgt.SearchReceiverCriteria and src.F182=tgt.TieBreakerRules and src.F183=tgt.ReceiverLengthofPeriod and src.F184=tgt.ReceiverMaxNumberOfTransfersPerPeriod and src.F185=tgt.ReceiverMaxTransferAmountPerPeriod and src.F186=tgt.ReceiverMaxNumberofTransfersPerDay and src.F187=tgt.ReceiverMaxTransferAmountPerDay and src.F188=tgt.ReceiverMaxAmountPerTransaction and src.F189=tgt.ReceiverMinAmountPerTransaction and src.F190=tgt.ReceiverQualifiedStatus and src.F191=tgt.ReceiverDestinationClients and src.F192=tgt.BlockGamblingMerchantsMCC7995 and src.F193=tgt.BlockCashandQuasiCash and src.F194=tgt.OtherMCCsRestricted and src.F195=tgt.AdditionalProxyLength and src.F196=tgt.IVRSecondaryAuthMethod and src.F197=tgt.AutoRenewalOnValueLoad and src.F198=tgt.SetupRegionalNetworkMoneyTransfer and src.F199=tgt.DisputeFormTempCredit and src.F200=tgt.TokenizationAllowed and src.F201=tgt.IsACHFastPayEnabled and src.F202=tgt.SenderReversalDays and src.F203=tgt.ReceiverAllowFeeReversal and src.F204=tgt.ReceiverReversalDays and src.F205=tgt.IVROrMyAccountPINOptions and src.F206=tgt.RestrictAdjust and src.F207=tgt.FulfillmentRequestType and src.F208=tgt.StatementMessageContents and src.F209=tgt.StartDate and src.F210=tgt.EndDate and src.F211=tgt.DefaultPurseForDirectAccess and src.F212=tgt.Copay and src.F213=tgt.MCCGroupCopay and src.F214=tgt.FutureUse2 and src.F215=tgt.FutureUse3 and src.F216=tgt.PBM and src.F217=tgt.MCCGroupPayAndChase and src.F218=tgt.NetworkName and src.F219=tgt.PurseStatusAutoRenewal and src.F220=tgt.RandomPINCardGeneration)
*/


MERGE [dbo].[FISCCX_DIIA] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DIIA' and IsActive = 1 ) as src 
    ON (src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PurseID and src.F4=tgt.IIAS and src.F5=tgt.IIASDesc and src.F6=tgt.IIASGroupID and src.F7=tgt.IIASGroupDesc and src.F8=tgt.Priority and src.F9=tgt.IsDeleted and src.F10=tgt.IIASGroupPriority and src.[FileName]=tgt.[FileName] )
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,PurseID,IIAS,IIASDesc,IIASGroupID,IIASGroupDesc,[Priority],IsDeleted,IIASGroupPriority,[FileName])	
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,[FileName]) ; 

/*
RecordType,SubProgramID,PurseID,IIAS,IIASDesc,IIASGroupID,IIASGroupDesc,Priority,IsDeleted,IIASGroupPriority,[FileName]		
src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PurseID and src.F4=tgt.IIAS and src.F5=tgt.IIASDesc and src.F6=tgt.IIASGroupID and src.F7=tgt.IIASGroupDesc and src.F8=tgt.Priority and src.F9=tgt.IsDeleted and src.F10=tgt.IIASGroupPriority and src.[FileName]=tgt.[FileName] and 
*/

MERGE [dbo].[FISCCX_DPKG] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPKG' and IsActive = 1 ) as src 
	  ON (src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PackageID and src.F4=tgt.PackageName and src.F5=tgt.ArtworkName and src.F6=tgt.BIN and src.F7=tgt.PrinAndAgentRange and src.F8=tgt.FulfillmentHouse and src.F9=tgt.CardCountThreshold and src.F10=tgt.CardIssuedSequentFlag and src.F11=tgt.BarcodeType and src.F12=tgt.FormFactor and src.F13=tgt.ReplacementPackageID and src.F14=tgt.DuplicateSettlementAwaitInDays and src.F15=tgt.AuthAwaitSettlementInDays and src.F16=tgt.EncodingMethod and src.F17=tgt.PartialAuth and src.F18=tgt.IsDeleted and src.F19=tgt.ImmediateCredit and src.F20=tgt.ApprovedProductList )
	--WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,PackageID,PackageName,ArtworkName,BIN,PrinAndAgentRange,FulfillmentHouse,CardCountThreshold,CardIssuedSequentFlag,BarcodeType,FormFactor,ReplacementPackageID,DuplicateSettlementAwaitInDays,AuthAwaitSettlementInDays,EncodingMethod,PartialAuth,IsDeleted,ImmediateCredit,ApprovedProductList,[FileName])	
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName]);

/*
RecordType,SubProgramID,PackageID,PackageName,ArtworkName,BIN,PrinAndAgentRange,FulfillmentHouse,CardCountThreshold,CardIssuedSequentFlag,BarcodeType,FormFactor,ReplacementPackageID,DuplicateSettlementAwaitInDays,AuthAwaitSettlementInDays,EncodingMethod,PartialAuth,IsDeleted,ImmediateCredit,ApprovedProductList,[FileName],
src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PackageID and src.F4=tgt.PackageName and src.F5=tgt.ArtworkName and src.F6=tgt.BIN and src.F7=tgt.PrinAndAgentRange and src.F8=tgt.FulfillmentHouse and src.F9=tgt.CardCountThreshold and src.F10=tgt.CardIssuedSequentFlag and src.F11=tgt.BarcodeType and src.F12=tgt.FormFactor and src.F13=tgt.ReplacementPackageID and src.F14=tgt.DuplicateSettlementAwaitInDays and src.F15=tgt.AuthAwaitSettlementInDays and src.F16=tgt.EncodingMethod and src.F17=tgt.PartialAuth and src.F18=tgt.IsDeleted and src.F19=tgt.ImmediateCredit and src.F20=tgt.ApprovedProductList and src.[FileName]=tgt.[FileName] and 
*/
COMMIT TRANSACTION FISCCX_Transaction
PRINT 'Success'

END TRY

	BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION FISCCX_Transaction
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END



GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_FileTrackCardBenefitReport]    Script Date: 6/26/2024 12:32:48 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[sp_FileTrackCardBenefitReport]
/*
exec [dbo].[sp_FileTrackCardBenefitReport] 'CI',NULL, NULL,'NH202005650528'
exec [dbo].[sp_FileTrackCardBenefitReport] 'FD',NULL, NULL,'NH202005650528'
exec [dbo].[sp_FileTrackCardBenefitReport] 'CI',302, 2694,NULL
exec [dbo].[sp_FileTrackCardBenefitReport] 'FD',302, 2694,NULL

Author		| Santhosh Balla
Description | Provides an audit report for records sent to FIS for Card Iniitated and Fund Disbursement
Execution	| The procedure takes in the Snapshot flag, InsuranceCarrierID and InsuranceHealthPlanID and the NHMemberID. The snapshot flag is required and other are optional (NULL's)
Date		| Dec 2022
*/


(
@SnapshotFlag varchar(20), 
@InsuranceCarrierID int, 
@InsuranceHealthPlanID int, 
@NHMemberID varchar(20)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY

declare @vWhereCondition varchar(1000) = ''
declare @vSnapshotFlag varchar(20) = '' 
declare @vInsuranceCarrierID int
declare @vInsuranceHealthPlanID int
declare @vNHMemberID varchar(20) = ''
declare @vSQL nvarchar(4000) = ''

set @vSnapshotFlag = @SnapshotFlag
set @vInsuranceCarrierID = @InsuranceCarrierID
set @vInsuranceHealthPlanID = @InsuranceHealthPlanID
set @vNHMemberID = @NHMemberID

if @vSnapshotFlag = 'CI' or  @vSnapshotFlag = 'FD'
	begin
		if @vInsuranceCarrierID is not null and @vInsuranceCarrierID <> ''
			begin
			set @vWhereCondition = 'insCarrierID ' + ' = ' + cast(@vInsuranceCarrierID as varchar) + ' and '
			select @vWhereCondition
			end
		if @vInsuranceHealthPlanID is not null and @vInsuranceHealthPlanID <> ''
			begin
			set @vWhereCondition = @vWhereCondition + 'insHealthPlanId ' + ' = ' + cast(@vInsuranceHealthPlanID as varchar) + ' and '
			select @vWhereCondition
			end
		if @vNHMemberID is not null and @vNHMemberID <> ''
			begin
			set @vWhereCondition = @vWhereCondition + 'NHLinkID ' + ' = ' + ''''+ (select top 1 cast(isnull(NHLInkID, '') as varchar)+'''' from Master.Members where NHMemberID = @vNHMemberID and  isActive =1) + ' and '
			select @vWhereCondition
		end
	end

if @vWhereCondition is null or @vWhereCondition = ''
	begin
	set  @vWhereCondition = isnull(@vWhereCondition, '2=2 and ')
	end

if @vSnapshotFlag = 'CI'
	begin 

		drop table if exists #FileTrack_CI
		select * into #FileTrack_CI from (
		select
		'[otcfunds].[FileTrack][OUT]' as TableNameFileTrack_OUT,a.[FileTrackID] as FileTrackID_OUT,a.[FileInfoID] as FileInfoID_OUT,a.[ClientCode] as ClientCode_OUT,a.[DirectionCode] as DirectionCode_OUT,a.[FileName] as FileName_OUT,a.[FileFormat] as FileFormat_OUT,a.[FileType] as FileType_OUT,a.[DataSource] as DataSource_OUT,a.[DateReceived] as DateReceived_OUT,a.[DateProcessed] as DateProcessed_OUT,a.[TotalRecords] as TotalRecords_OUT,a.[RecordsProcessed] as RecordsProcessed_OUT,a.[RecordsErrored] as RecordsErrored_OUT,a.[LoadStartTime] as LoadStartTime_OUT,a.[LoadEndTime] as LoadEndTime_OUT,a.[StatusCode] as StatusCode_OUT,a.[CreateDate] as CreateDate_OUT,a.[CreateUser] as CreateUser_OUT,a.[ModifyDate] as ModifyDate_OUT,a.[ModifyUser] as ModifyUser_OUT,a.[RefFileTrackID] as RefFileTrackID_OUT,a.[SnapshotFlag] as SnapshotFlag_OUT, 
		'[otcfunds].[FileTrack][IN]'  as TableNameFileTrack_IN, b.[FileTrackID] as FileTrackID_IN,b.[FileInfoID] as FileInfoID_IN,b.[ClientCode] as ClientCode_IN,b.[DirectionCode] as DirectionCode_IN,b.[FileName] as FileName_IN,b.[FileFormat] as FileFormat_IN,b.[FileType] as FileType_IN,b.[DataSource] as DataSource_IN,b.[DateReceived] as DateReceived_IN,b.[DateProcessed] as DateProcessed_IN,b.[TotalRecords] as TotalRecords_IN,b.[RecordsProcessed] as RecordsProcessed_IN,b.[RecordsErrored] as RecordsErrored_IN,b.[LoadStartTime] as LoadStartTime_IN,b.[LoadEndTime] as LoadEndTime_IN,b.[StatusCode] as StatusCode_IN,b.[CreateDate] as CreateDate_IN,b.[CreateUser] as CreateUser_IN,b.[ModifyDate] as ModifyDate_IN,b.[ModifyUser] as ModifyUser_IN,b.[RefFileTrackID] as RefFileTrackID_IN,b.[SnapshotFlag] as SnapshotFlag_IN,
		--(b.DateReceived - a.CreateDate) as DifferenceDate
		DATEDIFF(DAY, a.CreateDate,b.DateReceived ) as DifferenceInDays
		from [otcfunds].[FileTrack] a left Join [otcfunds].[FileTrack] b on a.RefFileTrackID = b.FileTrackID  where a.ClientCode is not null and a.[SnapshotFlag]= @vSnapshotFlag
		) a

		drop table if exists #CardBenefitLoad_CI
		select * into #CardBenefitLoad_CI from (
		select  '[otcfunds].[CardBenefitLoad_CI]' as TableName_otcfunds_CardBenefitLoad_CI,[CardBenefitLoadID],[MemberDataID],[ClientCode],[NHLinkID],[RecordType],[MemberDataSource],[InsCarrierID],[InsHealthPlanID],[BenefitCardNumber],[LastName],[MiddleInitial],[FirstName],[DOB],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[MailingCountry],[HomePhoneNbr],[BenefitType],[BenefitSource],[NBWalletCode],[BenefitAmount],[BenefitValidFrom],[BenefitValidTo],[BenefitFreqInMonth],[BenefitYear],[BenefitPeriod],[IsActive],[RequestRecordStatus],[RequestToBeProcessed],[RequestProcessedFileID],[RequestProcessedDate],[ResponseRecordStatus],[ResponseRecordStatusCode],[ResponseProcessedFileID],[ResponseProcessedDate],[FirstTimeCardIssued],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],[RefCardBenefitLoadID],[ErrorProcessed],[Language],[DiscretionaryData1],[FourthLine],[CarrierMessage],[ClientID],[ProgramID],[SubProgramID],[PackageID],[FileGenInd],[Level1ClientID],[BenefitCardMappingID],
		ROW_NUMBER () OVER (PARTITION BY [ClientCode], isnull([NHLinkID], MemberDataID) ORDER BY [ClientCode], isnull([NHLinkID], MemberDataID), [CreateDate] asc) as rn
		from [otcfunds].[CardBenefitLoad_CI] 
		where 1=1 
		) a

		drop table if exists #FileTrackCardBenefitLoad_CI
		select * into #FileTrackCardBenefitLoad_CI from (
		select  a.*, b.*
		from #CardBenefitLoad_CI a join #FileTrack_CI b on a.RequestProcessedFileID = FileTrackID_OUT and a.ResponseProcessedFileID = FileTrackID_IN
		where RN > 0
		--and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
		) a

		select @vSQL = 'select SnapshotFlag_OUT, a.ClientCode,
		ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
		NHLinkID, 
		insCarrierID,
		InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers b where b.InsuranceCarrierID = a.InsCarrierID), 
		InsHealthPlanID, 
		InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans b where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
		IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN,RequestRecordStatus, ResponseRecordStatus, ResponseRecordStatusCode, rn as NoOfTimesSent,
		CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
		RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse

		from #FileTrackCardBenefitLoad_CI a
		where 1 = 1 and ' + @vWhereCondition + '3 = 3 order by NHLInkID, NoOfTimesSent'

		select 2, @vSQL
		EXEC sp_executesql @vSQL;
	end

if @vSnapshotFlag = 'FD'
begin
	
	drop table if exists #FileTrack_FD
	select * into #FileTrack_FD from (
	select
	'[otcfunds].[FileTrack][OUT]' as TableNameFileTrack_OUT,a.[FileTrackID] as FileTrackID_OUT,a.[FileInfoID] as FileInfoID_OUT,a.[ClientCode] as ClientCode_OUT,a.[DirectionCode] as DirectionCode_OUT,a.[FileName] as FileName_OUT,a.[FileFormat] as FileFormat_OUT,a.[FileType] as FileType_OUT,a.[DataSource] as DataSource_OUT,a.[DateReceived] as DateReceived_OUT,a.[DateProcessed] as DateProcessed_OUT,a.[TotalRecords] as TotalRecords_OUT,a.[RecordsProcessed] as RecordsProcessed_OUT,a.[RecordsErrored] as RecordsErrored_OUT,a.[LoadStartTime] as LoadStartTime_OUT,a.[LoadEndTime] as LoadEndTime_OUT,a.[StatusCode] as StatusCode_OUT,a.[CreateDate] as CreateDate_OUT,a.[CreateUser] as CreateUser_OUT,a.[ModifyDate] as ModifyDate_OUT,a.[ModifyUser] as ModifyUser_OUT,a.[RefFileTrackID] as RefFileTrackID_OUT,a.[SnapshotFlag] as SnapshotFlag_OUT, 
	'[otcfunds].[FileTrack][IN]'  as TableNameFileTrack_IN, b.[FileTrackID] as FileTrackID_IN,b.[FileInfoID] as FileInfoID_IN,b.[ClientCode] as ClientCode_IN,b.[DirectionCode] as DirectionCode_IN,b.[FileName] as FileName_IN,b.[FileFormat] as FileFormat_IN,b.[FileType] as FileType_IN,b.[DataSource] as DataSource_IN,b.[DateReceived] as DateReceived_IN,b.[DateProcessed] as DateProcessed_IN,b.[TotalRecords] as TotalRecords_IN,b.[RecordsProcessed] as RecordsProcessed_IN,b.[RecordsErrored] as RecordsErrored_IN,b.[LoadStartTime] as LoadStartTime_IN,b.[LoadEndTime] as LoadEndTime_IN,b.[StatusCode] as StatusCode_IN,b.[CreateDate] as CreateDate_IN,b.[CreateUser] as CreateUser_IN,b.[ModifyDate] as ModifyDate_IN,b.[ModifyUser] as ModifyUser_IN,b.[RefFileTrackID] as RefFileTrackID_IN,b.[SnapshotFlag] as SnapshotFlag_IN,
	--(b.DateReceived - a.CreateDate) as DifferenceDate
	DATEDIFF(DAY, a.CreateDate,b.DateReceived ) as DifferenceInDays
	from [otcfunds].[FileTrack] a left Join [otcfunds].[FileTrack] b on a.RefFileTrackID = b.FileTrackID  where a.ClientCode is not null and a.[SnapshotFlag]= @vSnapshotFlag
	) a

	drop table if exists #CardBenefitLoad_FD
	select * into #CardBenefitLoad_FD from (
	select  '[otcfunds].[CardBenefitLoad_FD]' as TableName_otcfunds_CardBenefitLoad_FD,[CardBenefitLoadID],[MemberDataID],[ClientCode],[NHLinkID],[RecordType],[MemberDataSource],[InsCarrierID],[InsHealthPlanID],[BenefitCardNumber],[LastName],[MiddleInitial],[FirstName],[DOB],[MailingAddress1],[MailingAddress2],[MailingCity],[MailingState],[MailingZipCode],[MailingCountry],[HomePhoneNbr],[BenefitType],[BenefitSource],[NBWalletCode],[BenefitAmount],[BenefitValidFrom],[BenefitValidTo],[BenefitFreqInMonth],[BenefitYear],[BenefitPeriod],[IsActive],[RequestRecordStatus],[RequestToBeProcessed],[RequestProcessedFileID],[RequestProcessedDate],[ResponseRecordStatus],[ResponseRecordStatusCode],[ResponseProcessedFileID],[ResponseProcessedDate],[FirstTimeCardIssued],[CreateDate],[CreateUser],[ModifyDate],[ModifyUser],[RefCardBenefitLoadID],[ErrorProcessed],[Language],[MemberDataSourceFile],[Level1ClientID],[ClientID],[SubProgramID],[PackageID],[FIS_PurseSlot],
	ROW_NUMBER () OVER (PARTITION BY [ClientCode], isnull([NHLinkID], MemberDataID) ORDER BY [ClientCode], isnull([NHLinkID], MemberDataID), [CreateDate] asc) as rn
	from [otcfunds].[CardBenefitLoad_FD] 
	where 1=1 
	) a

	drop table if exists #FileTrackCardBenefitLoad_FD
	select * into #FileTrackCardBenefitLoad_FD from (
	select  a.*, b.*
	from #CardBenefitLoad_FD a join #FileTrack_FD b on a.RequestProcessedFileID = FileTrackID_OUT and a.ResponseProcessedFileID = FileTrackID_IN
	where RN > 0
	-- and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
	) a

	select @vSQL = 'select SnapshotFlag_OUT, ClientCode, 
	ClientName = (select ClientName from elig.ClientCodes b where b.ClientCode = a.ClientCode),
	NHLinkID, 
	insCarrierID,
	InsCarrierName = (select InsuranceCarrierName from insurance.InsuranceCarriers b where b.InsuranceCarrierID = a.InsCarrierID), 
	InsHealthPlanID, 
	InsHealthPlanName = (select HealthPlanName from insurance.InsuranceHealthPlans b where b.InsuranceHealthPlanID = a.InsHealthPlanID), 
	IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN, RequestRecordStatus, ResponseRecordStatus,ResponseRecordStatusCode, rn as NoOfTimesSent,
	CreateDate as CIRecordCreateDate, CreateDate_OUT as ToFISDateSent, DateReceived_IN FromFISDateReceived, DIfferenceInDays as DifferenceInDaysFISRequestResponse,
	RequestProcessedDate, ResponseProcessedDate, DATEDIFF(DAY, RequestProcessedDate,ResponseProcessedDate ) as DifferenceInDaysProcessedDateRequestResponse,
	BenefitType, BenefitSource, NBWalletCode, BenefitAmount, BenefitValidFrom, BenefitValidTo, BenefitFreqInMonth, BenefitYear, IsActive as IsActive_Benefit
	from #FileTrackCardBenefitLoad_FD a
	where 1 = 1 and ' + @vWhereCondition + ' 3 = 3 order by NHLInkID, NoOfTimesSent'

	select 3, @vSQL
	EXEC sp_executesql @vSQL;

end




/*
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_OUT, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
and NHLinkID = '00000103561'
order by NHLInkID, NoOfTimesSent


select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_OUT, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'SUCCESS' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent



-- zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN,RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (ResponseRecordStatus is NULL or ResponseRecordStatus = '') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, DirectionCode_OUT, FileName_OUT, DirectionCode_IN, FileName_IN, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (ResponseRecordStatus is NULL or ResponseRecordStatus = '') 
order by NHLInkID, NoOfTimesSent


--zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = '' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus ='' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent


-- Zero Records 
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (isnull(RequestRecordStatus,'') = '' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (isnull(RequestRecordStatus,'') = '' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

-- Zero Records 
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus is NULL and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus is NULL and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

--should get zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'ERROR') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'ERROR')
order by NHLInkID, NoOfTimesSent

-- should get zero records
select SnapshotFlag_OUT,ClientCode,NHLinkID, ClientID,  InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus ResponseRecordCode, rn as NoOfTimesSent, CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_CI
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'SUCCESS') 
order by NHLInkID, NoOfTimesSent

select SnapshotFlag_IN, ClientCode, NHLinkID, InsCarrierID, InsHealthPlanID, IsActive, RequestRecordStatus, ResponseRecordStatus, rn as NoOfTimesSent,CreateDate, CreateDate_OUT, DateReceived_IN, DIfferenceInDays from #FileTrackCardBenefitLoad_FD
where 1 = 1 
and (RequestRecordStatus = 'ERROR' and ResponseRecordStatus = 'SUCCESS')
order by NHLInkID, NoOfTimesSent
*/

 

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
		VALUES ('dbo.sp_FileTrackCardBenefitLoadReport', ERROR_NUMBER(),ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE())
		END CATCH

END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v4]    Script Date: 6/26/2024 12:32:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v4]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date
DECLARE @CurrentDateEST date
DECLARE @DATA_DATE date

SET @CurrentDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @DATA_DATE = FORMAT(@CurrentDateEST , 'yyyy-MM-dd')

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = GetDate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

--SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
SET @FileSubmitGrpId =  CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (SELECT DISTINCT OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
SELECT * FROM Orders.OrderItems where OrderItemID in (SELECT DISTINCT OrderItemID from #OrderIDAndOrderItemIDTemp)
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
--,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE
,@DATA_DATE as DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
	 WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE ''
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

CAST(
		(
		CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)*(-1.0)
			 WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)
		ELSE NULL
		END 
		) 
		AS VARCHAR
	) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]

,O.orderID as [ORIG_TRANSACTION_ID_OrderID],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(O.OrderId as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_ID]


,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER_OrderItemID],
(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(OI.orderitemID as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_LINE_NUMBER]


,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1




 

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
GO




USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v3]    Script Date: 6/26/2024 12:32:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO





--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v3]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date
DECLARE @CurrentDateEST date
DECLARE @DATA_DATE date

SET @CurrentDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @DATA_DATE = FORMAT(@CurrentDateEST , 'yyyy-MM-dd')

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = GetDate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

--SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
SET @FileSubmitGrpId =  CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (SELECT DISTINCT OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
SELECT * FROM Orders.OrderItems where OrderItemID in (SELECT DISTINCT OrderItemID from #OrderIDAndOrderItemIDTemp)
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
--,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE
,@DATA_DATE as DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
	 WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE ''
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

CAST(
		(
		CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)*(-1.0)
			 WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)
		ELSE NULL
		END 
		) 
		AS VARCHAR
	) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]

,O.orderID as [ORIG_TRANSACTION_ID_OrderID],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(O.OrderId as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_ID]


,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER_OrderItemID],
(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(OI.orderitemID as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_LINE_NUMBER]


,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1




 

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
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v2]    Script Date: 6/26/2024 12:32:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v2]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = getdate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

--SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
SET @FileSubmitGrpId =  CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (SELECT DISTINCT OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
SELECT * FROM Orders.OrderItems where OrderItemID in (SELECT DISTINCT OrderItemID from #OrderIDAndOrderItemIDTemp)
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
	 WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE ''
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND OI.Amount >= 0.0 THEN OI.Amount*(-1.0)
	  WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND OI.Amount >= 0.0 THEN OI.Amount
ELSE 0.00
 END 
) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]

,O.orderID as [ORIG_TRANSACTION_ID_OrderID],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN O.OrderId
ELSE NULL
END 
) AS [ORIG_TRANSACTION_ID]


,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER_OrderItemID],
(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN OI.orderitemID
ELSE NULL
END 
) AS [ORIG_TRANSACTION_LINE_NUMBER]


,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1



 

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
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v1]    Script Date: 6/26/2024 12:32:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v1]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = getdate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (Select distinct OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
	 WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE ''
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND OI.Amount >= 0.0 THEN OI.Amount*(-1.0)
	  WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND OI.Amount >= 0.0 THEN OI.Amount
ELSE 0.00
 END 
) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]
,O.orderID as [ORIG_TRANSACTION_ID]
,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER]
,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1





 

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
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization]    Script Date: 6/26/2024 12:32:21 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO







--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date

SET @DataSource = 'ELIG_BAYC'
SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
--SET @GetDateEST = getdate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (Select distinct OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE]
,O.OrderStatusCode as [TRANSACTION_STATUS]
,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'PostedDate' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,0 AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED','LSANDD') THEN OI.Amount*(-1)
	  WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND OI.Amount > 0 THEN OI.Amount
ELSE OI.Amount 
 END 
) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'SalesTxAmt' AS [SALES_TAX_AMT]
,'ConsumerUseTax' AS [CONSUMER_USE_TAX]
,'SellerUseTax' AS [SELLER_USE_TAX]
,'AdminFeeAmt' AS [ADMIN_FEE_AMT]
,'RefundAmt' as [REFUND_AMT]
,'RestockAmt' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

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
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp




SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1




 

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
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitEntitySpecs]    Script Date: 6/26/2024 12:32:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:      <Author, , Name>
-- Create Date: <Create Date, , >
-- Description: <Description, , >
-- =============================================
CREATE PROCEDURE [dbo].[sp_BenefitEntitySpecs]

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

update [dbo].[BenefitsEntitySpecs] set BusinessTaxIDNumber = replace(BusinessTaxIDNumber, '-','')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddressZIPCode = replicate ('0', 5 - len(PhysicalAddressZIPCode)) + cast (PhysicalAddressZIPCode as varchar)

/*
select
'update [dbo].[BenefitsEntitySpecs] set ' + column_name + '= replace(replace(' + column_name + ', char(13), '+''''+''''+'), char(10), '+''''+''''+')'
from information_schema.columns where table_name  = 'BenefitsEntitySpecs'

*/
update [dbo].[BenefitsEntitySpecs] set ClientServicesMember = replace(replace(ClientServicesMember, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ClientName = replace(replace(ClientName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set OTCRetailCard = replace(replace(OTCRetailCard, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set UniqueProgramID = replace(replace(UniqueProgramID, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set UniqueSubProgramID = replace(replace(UniqueSubProgramID, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set AccountNumber = replace(replace(AccountNumber, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ContractedPartyName = replace(replace(ContractedPartyName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ContractedPartyDBA = replace(replace(ContractedPartyDBA, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddress1 = replace(replace(PhysicalAddress1, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddress2 = replace(replace(PhysicalAddress2, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddressCity = replace(replace(PhysicalAddressCity, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddressState = replace(replace(PhysicalAddressState, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PhysicalAddressZIPCode = replace(replace(PhysicalAddressZIPCode, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set Country = replace(replace(Country, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set YearsAtPhysicalLocation = replace(replace(YearsAtPhysicalLocation, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set BusinessTaxIDNumber = replace(replace(BusinessTaxIDNumber, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CompanyWebsite = replace(replace(CompanyWebsite, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PublicallyTradedStockTicker = replace(replace(PublicallyTradedStockTicker, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set StockExchange = replace(replace(StockExchange, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set FDICCreditUnionNumber = replace(replace(FDICCreditUnionNumber, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactFullName = replace(replace(PrimaryContactFullName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactTitle = replace(replace(PrimaryContactTitle, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactDepartment = replace(replace(PrimaryContactDepartment, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactDirectPhone = replace(replace(PrimaryContactDirectPhone, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactPhoneExt = replace(replace(PrimaryContactPhoneExt, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactFax = replace(replace(PrimaryContactFax, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactCell = replace(replace(PrimaryContactCell, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrimaryContactEmailAddress = replace(replace(PrimaryContactEmailAddress, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set TypeOfIncorporation = replace(replace(TypeOfIncorporation, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CEOFullName = replace(replace(CEOFullName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CFOFullName = replace(replace(CFOFullName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set COOFullName = replace(replace(COOFullName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddressLine1 = replace(replace(PrincipalAddressLine1, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddressLine2 = replace(replace(PrincipalAddressLine2, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddressCity = replace(replace(PrincipalAddressCity, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddressState = replace(replace(PrincipalAddressState, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddressZIPCode = replace(replace(PrincipalAddressZIPCode, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set PrincipalAddresCountry = replace(replace(PrincipalAddresCountry, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationName = replace(replace(RegistrationName, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationAddressLine1 = replace(replace(RegistrationAddressLine1, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationAddressLine2 = replace(replace(RegistrationAddressLine2, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationAddressCity = replace(replace(RegistrationAddressCity, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationAddressState = replace(replace(RegistrationAddressState, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RegistrationAddressZIPCode = replace(replace(RegistrationAddressZIPCode, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set AnnualRevenue = replace(replace(AnnualRevenue, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ProductsOfferedMarketsServed = replace(replace(ProductsOfferedMarketsServed, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set NumberOfEmployees = replace(replace(NumberOfEmployees, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set RevenueOutsideUS = replace(replace(RevenueOutsideUS, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set EstimateLoadAvg = replace(replace(EstimateLoadAvg, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CardUsage = replace(replace(CardUsage, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CardOutsideUSFlag = replace(replace(CardOutsideUSFlag, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CardOutsideUSPercent = replace(replace(CardOutsideUSPercent, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CardOutsideUSSent = replace(replace(CardOutsideUSSent, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set NAICSCode = replace(replace(NAICSCode, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CashWithdrawalAvailable = replace(replace(CashWithdrawalAvailable, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set IntendedCardUsage = replace(replace(IntendedCardUsage, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set CoBranderFlag = replace(replace(CoBranderFlag, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ExpectedACHActivityVolume = replace(replace(ExpectedACHActivityVolume, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ExpectedWireTransferVolume = replace(replace(ExpectedWireTransferVolume, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ExpectedCheckActivityVolume = replace(replace(ExpectedCheckActivityVolume, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ExpectedCashActivityVolume = replace(replace(ExpectedCashActivityVolume, char(13), ''), char(10), '')
update [dbo].[BenefitsEntitySpecs] set ExpectedRemoteDepositActivityVolume = replace(replace(ExpectedRemoteDepositActivityVolume, char(13), ''), char(10), '')


select Output from (

select 1 as forOrder, (
'RecordType' + '|' + 'Header' + '|' + 'CompanyProgramManagerName' + '|' + 'ReportDataFeedName' + '|' + 'FileTransmitDate' + '|' + 'WorkOfDate' + '|' + 'EndOfRecord' ) as Output
UNION ALL
select 2 forOrder,
('H'+ '|' +'HEADER'+'|' + 'NationsBenefits' + '|' + 'BUSINESENTITY' + '|' + format(getdate(),'MMddyyyy') + '|' + format(DATEADD(day, -1, CAST(GETDATE() AS date)),'MMddyyyy')  ) as Output
UNION ALL
select 3 as forOrder,
(
'RecordType' + '|' + 
--'ClientServicesMember' + '|' + 
--'ClientName' + '|' + 
--'OTCRetailCard' + '|' + 
'UniqueProgramID' + '|' + 
'UniqueSubProgramID' + '|' + 
'AccountNumber' + '|' + 
'ContractedPartyName' + '|' + 
'ContractedPartyDBA' + '|' + 
'PhysicalAddress1' + '|' + 
'PhysicalAddress2' + '|' + 
'PhysicalAddressCity' + '|' + 
'PhysicalAddressState' + '|' + 
'PhysicalAddressZIPCode' + '|' + 
'Country' + '|' + 
'YearsAtPhysicalLocation' + '|' + 
'BusinessTaxIDNumber' + '|' + 
'CompanyWebsite' + '|' + 
'PublicallyTradedStockTicker' + '|' + 
'StockExchange' + '|' + 
'FDICCreditUnionNumber' + '|' + 
'PrimaryContactFullName' + '|' + 
'PrimaryContactTitle' + '|' + 
'PrimaryContactDepartment' + '|' + 
'PrimaryContactDirectPhone' + '|' + 
'PrimaryContactPhoneExt' + '|' + 
'PrimaryContactFax' + '|' + 
'PrimaryContactCell' + '|' + 
'PrimaryContactEmailAddress' + '|' + 
'TypeOfIncorporation' + '|' + 
'CEOFullName' + '|' + 
'CFOFullName' + '|' + 
'COOFullName' + '|' + 
'PrincipalAddressLine1' + '|' + 
'PrincipalAddressLine2' + '|' + 
'PrincipalAddressCity' + '|' + 
'PrincipalAddressState' + '|' + 
'PrincipalAddressZIPCode' + '|' + 
'PrincipalAddresCountry' + '|' + 
'RegistrationName' + '|' + 
'RegistrationAddressLine1' + '|' + 
'RegistrationAddressLine2' + '|' + 
'RegistrationAddressCity' + '|' + 
'RegistrationAddressState' + '|' + 
'RegistrationAddressZIPCode' + '|' + 
'AnnualRevenue' + '|' + 
'ProductsOfferedMarketsServed' + '|' + 
'NumberOfEmployees' + '|' + 
'RevenueOutsideUS' + '|' + 
'EstimateLoadAvg' + '|' + 
'CardUsage' + '|' + 
'CardOutsideUSFlag' + '|' + 
'CardOutsideUSPercent' + '|' + 
'CardOutsideUSSent' + '|' + 
'NAICSCode' + '|' + 
'CashWithdrawalAvailable' + '|' + 
'IntendedCardUsage' + '|' + 
'CoBranderFlag' + '|' + 
'ExpectedACHActivityVolume' + '|' + 
'ExpectedWireTransferVolume' + '|' + 
'ExpectedCheckActivityVolume' + '|' + 
'ExpectedCashActivityVolume' + '|' + 
'ExpectedRemoteDepositActivityVolume' 
) as Output
UNION
Select 4 as ForOrder,
(
ltrim(rtrim(cast(isnull('D','') as varchar))) + '|'+
-- ltrim(rtrim(cast(isnull(ClientServicesMember,'') as varchar))) + '|'+
-- ltrim(rtrim(cast(isnull(ClientName,'') as varchar))) + '|'+
-- ltrim(rtrim(cast(isnull(OTCRetailCard,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(UniqueProgramID,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(UniqueSubProgramID,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(AccountNumber,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ContractedPartyName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ContractedPartyDBA,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PhysicalAddress1,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PhysicalAddress2,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PhysicalAddressCity,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PhysicalAddressState,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PhysicalAddressZIPCode,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(Country,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(YearsAtPhysicalLocation,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(BusinessTaxIDNumber,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CompanyWebsite,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PublicallyTradedStockTicker,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(StockExchange,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(FDICCreditUnionNumber,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactFullName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactTitle,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactDepartment,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactDirectPhone,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactPhoneExt,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactFax,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactCell,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrimaryContactEmailAddress,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(TypeOfIncorporation,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CEOFullName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CFOFullName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(COOFullName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddressLine1,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddressLine2,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddressCity,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddressState,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddressZIPCode,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(PrincipalAddresCountry,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationName,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationAddressLine1,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationAddressLine2,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationAddressCity,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationAddressState,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RegistrationAddressZIPCode,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(AnnualRevenue,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ProductsOfferedMarketsServed,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(NumberOfEmployees,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(RevenueOutsideUS,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(EstimateLoadAvg,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CardUsage,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CardOutsideUSFlag,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CardOutsideUSPercent,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CardOutsideUSSent,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(NAICSCode,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CashWithdrawalAvailable,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(IntendedCardUsage,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(CoBranderFlag,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ExpectedACHActivityVolume,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ExpectedWireTransferVolume,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ExpectedCheckActivityVolume,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ExpectedCashActivityVolume,'') as varchar)))  + '|'+
ltrim(rtrim(cast(isnull(ExpectedRemoteDepositActivityVolume,'') as varchar))) 
) as Output
from [dbo].[BenefitsEntitySpecs] where lower(ltrim(rtrim(ClientName))) not like 'required' and BenefitsEntitySpecsID <> 1

UNION

select 5 as ForOrder,
(
'RecordType' + '|' + 'Trailer' + '|' + '[Count]' 
) as Output

UNION

select 6 as ForOrder,
(
cast(isnull('T','') as varchar) + '|'+
cast(isnull('Trailer','') as varchar) + '|'+
cast(isnull((select count(*) as rc from [dbo].[BenefitsEntitySpecs] where lower(ltrim(rtrim(ClientName))) not like 'required' and BenefitsEntitySpecsID <> 1 ),'') as varchar)
) as Output

) a

where a.ForOrder in (2, 4, 6)
order by a.ForOrder
    
END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BayCareBenefitUtil]    Script Date: 6/26/2024 12:32:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




--exec [dbo].[sp_BayCareBenefitUtil] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BayCareBenefitUtil]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    SET NOCOUNT ON
	SET XACT_ABORT ON

	BEGIN TRY
	--SELECT 1/0

			
			DECLARE @FileSubmitGrpId nvarchar(20)
			SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
						

			IF OBJECT_ID('tempdb..#BayCareTemp') IS NOT NULL DROP TABLE #BayCareTemp

			SELECT * INTO #BayCareTemp FROM
			(SELECT TOP 10
					'NATIONSOTC' as [SOURCE_SENDER]
					,'NBCRM' as [SOURCE_SYSTEM]
					,FORMAT(GETDATE(), 'yyyy-MM-dd') AS DATA_DATE

					,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, GETDATE())-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
					,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, GETDATE())-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

					--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
					,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

					,'OTC' AS [BENEFIT_TYPE]
					,O.orderID as [TRANSACTION_ID]
					,OI.orderitemID as [TRANSACTION_LINE_NUMBER]
					,O.Status as [TRANSACTION_TYPE]
					,O.OrderStatusCode as [TRANSACTION_STATUS]
					,NULL as [NDC]
					,IMC.ModelShortDescription as [PRODUCT_NAME]
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
			 
			
			--SELECT * FROM #BayCareTemp



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
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[ExtractXmlDataIntoTable]    Script Date: 6/26/2024 12:32:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExtractXmlDataIntoTable]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @XmlData XML;
	DECLARE @FileName NVARCHAR(500);
    DECLARE @TempTable TABLE (
        -- Define columns for extracted data
		FileName NVARCHAR(500),
        NodeName NVARCHAR(100),
        AttributeName NVARCHAR(100),
        AttributeValue NVARCHAR(100),
        NodeValue NVARCHAR(MAX)
    );

    -- Replace 'YourTableName' and 'YourXmlColumn' with actual table and XML column names
    DECLARE XmlCursor CURSOR LOCAL FOR
    SELECT F1XML, FileName
    FROM FISXML
	
	OPEN XmlCursor;
    FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
		select @FileName
        INSERT INTO @TempTable ( NodeName, AttributeName, AttributeValue, NodeValue, FileName)
        SELECT
            Node.value('local-name(.)', 'NVARCHAR(100)') AS NodeName,
            Attribute.value('local-name(.)', 'NVARCHAR(100)') AS AttributeName,
            Attribute.value('.', 'NVARCHAR(100)') AS AttributeValue,
            Node.value('.', 'NVARCHAR(MAX)') AS NodeValue,
			@FileName as FileName
        FROM @XmlData.nodes('//*') AS T(Node) -- Get all nodes in the XML document
        OUTER APPLY Node.nodes('@*') AS T2(Attribute); -- Get attributes of each node
		select @FileName
        FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
    END

    CLOSE XmlCursor;
    DEALLOCATE XmlCursor;

    -- Insert the extracted data into a new table
    INSERT INTO FISXMLExtract (FileName, NodeName, AttributeName, AttributeValue, NodeValue)
    SELECT FileName,NodeName, AttributeName, AttributeValue, NodeValue
    FROM @TempTable;
END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_ProductSummary]    Script Date: 6/26/2024 12:32:01 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */


-- Exec [bireports].[sp_rpt_NationsOTC_Business_ProductSummary] 258,NULL,NULL,'YTD'

CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_ProductSummary] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  =  dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END



---- Top Product Summary 

DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 



select Top 30 @StartDate as Startdate,@EndDate as EndDate,B.ProductName AS Item,B.ProductCategory AS Category,sum(productquantity) QuantityPurchased
from [bireports].[BI_OTC_OrderDetail_Data_2021] A 
join [bireports].[BI_OTC_OrderItemDetail_Data_2021] B
ON A.OrderID=B.OrderID
where A.status='ACTIVE' 
and b.ItemCode_iml not like '%VOUCHER%' -- Exclude Vouchers 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Refunds
AND RefOrderID IS NULL -- Exclude Reships 
and CarrierId=@Carrier_ID 
and A.Orderdate BETWEEN @StartDate AND @EndDate
group by B.ProductName,B.ProductCategory
order by sum(productquantity) desc


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_Products]    Script Date: 6/26/2024 12:31:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_Products] 356,'01-01-2021','01-31-2022','X'
--Exec [bireports].[sp_rpt_NationsOTC_Business_Products] 258,NULL,NULL,'YTD'
CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_Products] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  =  dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END



---- Top Products 

DROP TABLE IF EXISTS #subquery
DROP TABLE IF EXISTS #rowtable
DROP TABLE IF EXISTS #Caltotal



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 




select B.ProductName,B.ProductCategory AS Category,Month(a.OrderDate) as month_num,year(a.OrderDate) as month_yr
,sum(productquantity) Count_OrdersPlaced
into #subquery
from [bireports].[BI_OTC_OrderDetail_Data_2021] A 
join [bireports].[BI_OTC_OrderItemDetail_Data_2021] B
ON A.OrderID=B.OrderID
where A.status='ACTIVE' 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude  Full Refunds 
and b.ItemCode_iml not like '%VOUCHER%' -- Exclude Vouchers 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and Cast(A.Orderdate as date) BETWEEN @StartDate AND @EndDate
group by B.ProductName,B.ProductCategory,Month(a.OrderDate) ,year(a.OrderDate) 
order by sum(productquantity) desc




--select * from #subquery
--select * from #rowtable
select month_num,month_yr,
Category,ProductName,Count_OrdersPlaced,Row_number() over(partition by ProductName  order by month_num,month_yr) as row_no
into #rowtable
from #subquery
group by ProductName,Count_OrdersPlaced,Category,month_num,month_yr

--select * from #Caltotal
Select top 30 ProductName,Category,Sum(Count_OrdersPlaced) as QuantityPurchasedYTD
into #Caltotal
from #rowtable
group by ProductName,Category
order by QuantityPurchasedYTD desc

-- Final Table 
select @StartDate as Startdate,@EndDate as EndDate,a.month_num,a.month_yr,
a.ProductName,a.Category,a.Count_OrdersPlaced,QuantityPurchasedYTD
from #rowtable a 
join #Caltotal b 
on ltrim(rtrim(a.ProductName))=ltrim(rtrim(b.ProductName))
order by QuantityPurchasedYTD desc


DROP TABLE IF EXISTS #subquery
DROP TABLE IF EXISTS #rowtable
DROP TABLE IF EXISTS #Caltotal
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_CartOverview]    Script Date: 6/26/2024 12:31:51 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_CartOverview] 302,NULL,NULL,'YTD'
-- Exec [bireports].[sp_rpt_NationsOTC_Business_CartOverview] 302,'01/01/2021','05/31/2021','X'
CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_CartOverview] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;


SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END


--------- Cart overview


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
DROP TABLE IF EXISTS #Orders
DROP TABLE IF EXISTS #EligibleMembers
DROP TABLE IF EXISTS #FirstTimeMembersMTD
DROP TABLE IF EXISTS #FirstTimeMembersYTD


--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 

---- Order Count 
DECLARE @TodaysDate DATE;
SET @TodaysDate = @EndDate


select @Carrier_ID as CarrierID,
COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) OrderCount_MTD
,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) OrderCount_YTD
,ISNULL(SUM( CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                 WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)
                 ELSE NULL END),0) TotalProductPrice_MTD 
,ISNULL(SUM( CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate)  AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                  WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN (A.Price-A.TotalRefundAmount) 
                  ELSE NULL END),0) TotalProductPrice_YTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE
ISNULL(SUM( CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                 WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)
                 ELSE NULL END),0)/
CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) AS FLOAT)
END AvgDollarPerOrder_MTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE
ISNULL(SUM( CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate)  AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                  WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)  
                  ELSE NULL END),0)/
CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) AS FLOAT)
END AvgDollarPerOrder_YTD
,COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN a.NHMemberId ELSE NULL END) OrdererdEligibleMem_MTD
,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN a.NHMemberId ELSE NULL END) OrdererdEligibleMem_YTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND ((a.OrderChannel='Online' and a.Source='OTC_Mail') or (a.OrderChannel='MEA' and a.Source='OTC_Mail'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerMailOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND ((a.OrderChannel='Online' and a.Source='OTC_Mail') or (a.OrderChannel='MEA' and a.source='OTC_Mail'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerMailOrderCount_YTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerPhoneOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerPhoneOrderCount_YTD 
 ,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND  ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerOnlineOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND  ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerOnlineOrderCount_YTD 
Into #Orders
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
Left join #Refund B 
on a.OrderID=b.OrderID
where a.Status='ACTIVE'  
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.OrderDate BETWEEN @StartDate AND @EndDate
and a.CarrierID=@Carrier_ID



-- Total Eligible Members 
select @Carrier_ID AS CARRIERID,
A.CurrentActiveCnt AS EligibleMembers into #EligibleMembers
FROM
(
    select cc.InsuranceCarrierID
            ,es.CurrentActiveCnt
            ,es.FileTrackId
            ,CAST(ft.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) FileProcessedDate
            ,rank() over (partition by es.CarrierId order by es.FileTrackId DESC) [FileRank]
    from elig.EligibilityStats es
    join elig.FileTrack ft on ft.FileTrackID = es.FileTrackId and ft.SnapshotFlag = 'FULL'
    join elig.ClientCodes cc on cc.ClientCode = es.ClientCode where 1=1
    and es.CarrierId = @Carrier_ID
    and es.StatsType = 'CARRIER'
    and MONTH(CAST(ft.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) = DATEPART(MM,@TodaysDate)
) A
where [FileRank] = 1 
and InsuranceCarrierID=@Carrier_ID



-- First time Members MTD
select @Carrier_ID AS CARRIERID ,
COUNT(DISTINCT CASE WHEN DATEPART(MM,t.OrderDate) = DATEPART(MM,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_MTD
--,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,t.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_YTD
Into #FirstTimeMembersMTD  
from [bireports].[BI_OTC_OrderDetail_Data_2021]  t
LEFT JOIN [bireports].[BI_OTC_OrderDetail_Data_2021]  t1 on (t1.nhmemberid=t.nhmemberid and DATEPART(MM,t1.OrderDate) != DATEPART(MM,@TodaysDate))
where t1.OrderID IS NULL 
AND t.CarrierID=@Carrier_ID
and t.OrderDate BETWEEN @StartDate AND @EndDate




-- First time Members YTD
select @Carrier_ID AS CARRIERID ,
--COUNT(DISTINCT CASE WHEN DATEPART(MM,t.OrderDate) = DATEPART(MM,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_MTD
COUNT(DISTINCT CASE WHEN DATEPART(YYYY,t.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_YTD
Into #FirstTimeMembersYTD  
from [bireports].[BI_OTC_OrderDetail_Data_2021]  t
LEFT JOIN [bireports].[BI_OTC_OrderDetail_Data_2021]  t1 on (t1.nhmemberid=t.nhmemberid and DATEPART(YYYY,t1.OrderDate) != DATEPART(YYYY,@TodaysDate))
where t1.OrderID IS NULL 
AND t.CarrierID=@Carrier_ID
and t.OrderDate BETWEEN @StartDate AND @EndDate

--SELECT * fROM #FirstTimeMembersYTD

-- Final Query

Select  @StartDate as Startdate,@EndDate as EndDate,
OrderCount_MTD as OrderCount_MTD
,TotalProductPrice_MTD as TotalProductPrice_MTD
,AvgDollarPerOrder_MTD as AvgDollarPerOrder_MTD
,ISNULL(EM.EligibleMembers,0) as TotEligMembers_MTD
,OrdererdEligibleMem_MTD AS EligibleMemordered_MTD
,ISNULL(FMM.UniqueMembers_MTD,0) AS UniqueMembers_MTD
,ISNULL((OrdererdEligibleMem_MTD / CAST(EM.EligibleMembers AS FLOAT) ),0) AS EligMem_Per_MTD
,ISNULL((FMM.UniqueMembers_MTD / CAST(EM.EligibleMembers AS FLOAT) ),0) AS UniqueMem_Per_MTD
,PerMailOrderCount_MTD as MailOrder_Per_MTD 
,PerPhoneOrderCount_MTD as MailPhone_Per_MTD
,PerOnlineOrderCount_MTD as MailOnline_Per_MTD
,OrderCount_YTD as OrderCount_YTD
,TotalProductPrice_YTD as TotalProductPrice_YTD
,AvgDollarPerOrder_YTD as AvgDollarPerOrder_YTD
,OrdererdEligibleMem_YTD AS EligibleMemordered_YTD
,ISNULL(FMY.UniqueMembers_YTD,0) AS UniqueMembers_YTD
,ISNULL((OrdererdEligibleMem_YTD/CAST( EM.EligibleMembers AS FLOAT)),0) AS EligMem_Per_YTD
,ISNULL((FMY.UniqueMembers_YTD/ CAST(EM.EligibleMembers AS FLOAT)),0) AS UniqueMem_Per_YTD
,PerMailOrderCount_YTD as MailOrder_Per_YTD 
,PerPhoneOrderCount_YTD as MailPhone_Per_YTD
,PerOnlineOrderCount_YTD as MailOnline_Per_YTD
from #Orders O 
LEFT join #EligibleMembers EM 
ON O.CARRIERID=EM.CARRIERID
LEFT JOIN #FirstTimeMembersMTD FMM
ON O.CARRIERID=FMM.CARRIERID
LEFT JOIN #FirstTimeMembersYTD FMY
ON O.CARRIERID=FMY.CARRIERID


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
DROP TABLE IF EXISTS #Orders
DROP TABLE IF EXISTS #EligibleMembers
DROP TABLE IF EXISTS #FirstTimeMembersMTD
DROP TABLE IF EXISTS #FirstTimeMembersYTD
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders]    Script Date: 6/26/2024 12:31:42 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] 356,'01-01-2021','01-31-2022','X'
-- Exec [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] 258,'01-01-2021','01-31-2022','YTD'

CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  END



DROP TABLE IF EXISTS #callVolume
DROP TABLE IF EXISTS #ordersplaced
DROP TABLE IF EXISTS #DaystoShip
DROP TABLE IF EXISTS #SubQuery
DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund


--- Call Volume 


select @CarrierID as CarrierID,month(cast(MidnightStartDate as date)) As Month_Num,
Year(cast(MidnightStartDate as date)) as Month_Year
,sum(QueueOffered) Call_Volume
into #callVolume
from 
(
   select * from bireports.Mitel_QueuePerformanceByPeriodStats with (nolock)
   where 1=1
   and cast(MidnightStartDate as date) between @StartDate and @EndDate
) qp 
join bireports.Mitel_QueueGroup qg on ( 'P'+qg.Reporting = qp.QueueReporting 
											  AND qg.QueueGroupType = 'OTC'				
											  AND qg.InsCarrierID = @Carrier_ID
									  )
LEFT JOIN Insurance.InsuranceCarriers ic  on (ic.InsuranceCarrierID = qg.InsCarrierID)
where 1=1
group by  month(cast(MidnightStartDate as date)),Year(cast(MidnightStartDate as date))
ORDER BY Month_Num,Month_Year



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 


	--select * from #manualRefund

---------- Orders 

select @CarrierID as CarrierID, month(a.OrderDate) as Month_Num,year(a.OrderDate) as Month_Year
,COUNT(DISTINCT a.OrderID) OrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
       THEN a.OrderID ELSE NULL END) OnlineOrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
       THEN a.OrderID ELSE NULL END) PhoneOrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_Mail') or (a.OrderChannel='MEA' and a.source='OTC_Mail'))
       THEN a.OrderID ELSE NULL END) MailOrdersCount
into #ordersplaced
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
where a.Status='ACTIVE' 
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and a.OrderDate BETWEEN @StartDate AND @EndDate
group by month(a.OrderDate),year(a.OrderDate)
Order by Month_Num,Month_Year


------ Days to Ship  

select @CarrierID as CarrierID,a.ShippingDate,a.OrderDate,substring(a.ShippingDate,1,10) as ShippingDate_Substring ,len(a.ShippingDate) ShippingDate_Len 
into #SubQuery
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
where a.Status='ACTIVE'  
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and a.OrderDate BETWEEN @StartDate AND @EndDate
group by a.ShippingDate,a.OrderDate

update A
set A.ShippingDate = NULL
--select * 
from #SubQuery A
where ShippingDate_Len <> 10 

update A
set A.ShippingDate = A.OrderDate
--select * 
from #SubQuery A
where A.ShippingDate IS NULL



select @CarrierID as CarrierID,month(orderdate) as Month_Num,year(orderdate) as Month_Year
,sum(datediff(DD, orderdate, ShippingDate)) as TotalDays,COUNT(OrderDate) Countoforders
,ISNULL(SUM( datediff(DD, orderdate, ShippingDate))/CAST(COUNT(OrderDate) AS FLOAT),0) DaystoShip
into #DaystoShip
from #SubQuery
group by month(orderdate),year(orderdate) 
Order by Month_Num






--- Final Query

select @StartDate as Startdate,@EndDate as EndDate,
A.Month_Num,A.Month_Year,
ISNULL(B.Call_Volume,0) CallVolume
,A.OrdersCount,A.OnlineOrdersCount,A.PhoneOrdersCount,A.MailOrdersCount,C.DaystoShip,C.Countoforders,C.TotalDays
from #ordersplaced A 
LEFT JOIN #callVolume B 
ON A.Month_Num=B.Month_Num
AND A.Month_Year=B.Month_Year
left join #DaystoShip C 
ON A.Month_Num=C.Month_Num
AND A.Month_Year=C.Month_Year
order by a.Month_Num,a.Month_Year


DROP TABLE IF EXISTS #callVolume
DROP TABLE IF EXISTS #ordersplaced
DROP TABLE IF EXISTS #DaystoShip
DROP TABLE IF EXISTS #SubQuery
DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund

/*
select @CarrierID as CarrierID, month(orderdate) as Month_Num,year(orderdate) as Month_Year
,COALESCE(NULL,avg(convert(decimal(10,2),datediff(DD, orderdate, ShippingDate)))) as DaystoShip
into #DaystoShip
from #SubQuery
group by month(orderdate),year(orderdate) 
Order by Month_Num

*/
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[parseJSON_Modified]    Script Date: 6/26/2024 11:31:50 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[parseJSON_Modified]( @JSON NVARCHAR(MAX), @InsuranceCarrierID int, @InsuranceHealthPlanID int, @ConfigType nvarchar(max))

/*

Santhosh Balla modified this procedure to be used at Nations Benefits to parse JSON, on the table InsuranceConfig
select  'Select * from parseJSON_Modified(' + ''''+ replace(configData, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(InsuranceHealthPlanID, 999) as nvarchar) + ','+ ''''+ConfigType+''''+')' + ' Union ALL ' from [insurance].[InsuranceConfig] where ConfigData is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(configData, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(InsuranceHealthPlanID, 999) as nvarchar) + ','+ ''''+ConfigType+''''+')' + ' Union ALL ' from [insurance].[InsuranceConfig] where ConfigData is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(CarrierConfig, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(NULL, 999) as nvarchar) + ','+ ''''+CarrierConfig+''''+')' + ' Union ALL ' from [insurance].[InsuranceCarriers] where CarrierConfig is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(OldCarrierConfig, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(NULL, 999) as nvarchar) + ','+ ''''+OldCarrierConfig+''''+')' + ' Union ALL ' from [insurance].[InsuranceCarriers] where OldCarrierConfig is not null and OldCarrierConfig <> ''

*/



/**
Summary: >
  The code for the JSON Parser/Shredder will run in SQL Server 2005, 
  and even in SQL Server 2000 (with some modifications required).
 
  First the function replaces all strings with tokens of the form @Stringxx,
  where xx is the foreign key of the table variable where the strings are held.
  This takes them, and their potentially difficult embedded brackets, out of 
  the way. Names are  always strings in JSON as well as  string values.
 
  Then, the routine iteratively finds the next structure that has no structure 
  Contained within it, (and is, by definition the leaf structure), and parses it,
  replacing it with an object token of the form ‘@Objectxxx‘, or ‘@arrayxxx‘, 
  where xxx is the object id assigned to it. The values, or name/value pairs 
  are retrieved from the string table and stored in the hierarchy table. G
  radually, the JSON document is eaten until there is just a single root
  object left.
Why: case-insensitive version
Example: >
  Select * from parseJSON('{    "Person": 
      {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
           {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
           },
       "PhoneNumbers": 
           {
           "home":"212 555-1234",
          "fax":"646 555-4567"
           }
        }
     }
  ')
Returns: >
  nothing
**/
	RETURNS @hierarchy TABLE
	  (
	   InsuranceCarrierID int null,
	   InsuranceHealthPlanID int null,
	   ConfigType nvarchar(max),
	   Element_ID INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   SequenceNo [int] NULL, /* the place in the sequence for the element */
	   Parent_ID INT null, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT null, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   Name NVARCHAR(2000) NULL, /* the Name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	  /*
 
	   */
	AS
	BEGIN
	  DECLARE
	  	@vInsuranceCarrierID int,   -- By Santhosh Balla
		@vInsuranceHealthPlanID int,   -- By Santhosh Balla
		@vConfigType nvarchar(max), --  By Santhosh Balla
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @Name NVARCHAR(200), --the Name as a string
	    @Parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character

		set @vInsuranceCarrierID = @InsuranceCarrierID
		set @vInsuranceHealthPlanID = @InsuranceHealthPlanID
		set @vConfigType = @ConfigType
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the Names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
	    @Parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)='"' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --either the end or no end delimiter to last string
	        BEGIN-- check if ending with a double slash...
             SET @end=PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
 		     IF @end=0 --we really have reached the end 
				BEGIN
				BREAK --assume all tokens found
				END
			END 
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FromString, ToString)
	      FROM
	        (SELECT           '\b', CHAR(08)
	         UNION ALL SELECT '\f', CHAR(12)
	         UNION ALL SELECT '\n', CHAR(10)
	         UNION ALL SELECT '\r', CHAR(13)
	         UNION ALL SELECT '\t', CHAR(09)
			 UNION ALL SELECT '\"', '"'
	         UNION ALL SELECT '\/', '/'
	        ) substitutions(FromString, ToString)
		SELECT @token=Replace(@token, '\\', '\')
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    '@string'+CONVERT(NCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @Parent_ID=@Parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)='{') 
	    SELECT @NextCloseDelimiterChar='}', @type='object'
	  ELSE 
	    SELECT @NextCloseDelimiterChar=']', @type='array'
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+'|')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{' 
	        SELECT @NextCloseDelimiterChar='}', @type='object'
	      ELSE 
	        SELECT @NextCloseDelimiterChar=']', @type='array'
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or Name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                '@'+@type+CONVERT(NCHAR(5), @Parent_ID))
	  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type='object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based Name.
	          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
              SELECT @token=RTrim(Substring(' '+@contents, @start+1, @End-@Start-1)),
	            @endofName=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofName+1)
	          SELECT
	            @token=LEFT(@token, @endofName-1),
	            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
	          SELECT  @Name=StringValue FROM @strings
	            WHERE string_id=@param --fetch the Name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
                IF @end=0
	        --HR Engineering notation bugfix start
	          IF ISNUMERIC(@contents) = 1
		    SELECT @end = LEN(@contents) + 1
	          Else
	        --HR Engineering notation bugfix end 
		  SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents+' ' collate SQL_Latin1_General_CP850_Bin) + 1
	       SELECT
	        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+'|'), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
	      IF SUBSTRING(@value, 1, 7)='@object' 
	        INSERT INTO @hierarchy
	          (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), 'object' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)='@array' 
	          INSERT INTO @hierarchy
	              (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	            SELECT  @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), 'array' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)='@string' 
	            INSERT INTO @hierarchy
	              (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	              SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, StringValue, 'string'
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN ('true', 'false') 
	              INSERT INTO @hierarchy
	                (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, @value, 'boolean'
	            ELSE
	              IF @value='null' 
	                INSERT INTO @hierarchy
	                  (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType,Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                  SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, @value, 'null'
	              ELSE
	                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, @value, 'real'
	                ELSE
	                  INSERT INTO @hierarchy
	                    (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, @value, 'int'
	      if @Contents=' ' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	  SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,'-',1, NULL, '', @Parent_ID-1, @type
	--
	   RETURN
	END
GO




USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[parseJSON]    Script Date: 6/26/2024 11:31:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[parseJSON]( @JSON NVARCHAR(MAX))
/**
Summary: >
  The code for the JSON Parser/Shredder will run in SQL Server 2005, 
  and even in SQL Server 2000 (with some modifications required).
 
  First the function replaces all strings with tokens of the form @Stringxx,
  where xx is the foreign key of the table variable where the strings are held.
  This takes them, and their potentially difficult embedded brackets, out of 
  the way. Names are  always strings in JSON as well as  string values.
 
  Then, the routine iteratively finds the next structure that has no structure 
  Contained within it, (and is, by definition the leaf structure), and parses it,
  replacing it with an object token of the form ‘@Objectxxx‘, or ‘@arrayxxx‘, 
  where xxx is the object id assigned to it. The values, or name/value pairs 
  are retrieved from the string table and stored in the hierarchy table. G
  radually, the JSON document is eaten until there is just a single root
  object left.
Why: case-insensitive version
Example: >
  Select * from parseJSON('{    "Person": 
      {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
           {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
           },
       "PhoneNumbers": 
           {
           "home":"212 555-1234",
          "fax":"646 555-4567"
           }
        }
     }
  ')
Returns: >
  nothing
**/
	RETURNS @hierarchy TABLE
	  (
	   Element_ID INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   SequenceNo [int] NULL, /* the place in the sequence for the element */
	   Parent_ID INT null, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT null, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   Name NVARCHAR(2000) NULL, /* the Name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	  /*
 
	   */
	AS
	BEGIN
	  DECLARE
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @Name NVARCHAR(200), --the Name as a string
	    @Parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the Names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
	    @Parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)='"' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --either the end or no end delimiter to last string
	        BEGIN-- check if ending with a double slash...
             SET @end=PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
 		     IF @end=0 --we really have reached the end 
				BEGIN
				BREAK --assume all tokens found
				END
			END 
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FromString, ToString)
	      FROM
	        (SELECT           '\b', CHAR(08)
	         UNION ALL SELECT '\f', CHAR(12)
	         UNION ALL SELECT '\n', CHAR(10)
	         UNION ALL SELECT '\r', CHAR(13)
	         UNION ALL SELECT '\t', CHAR(09)
			 UNION ALL SELECT '\"', '"'
	         UNION ALL SELECT '\/', '/'
	        ) substitutions(FromString, ToString)
		SELECT @token=Replace(@token, '\\', '\')
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    '@string'+CONVERT(NCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @Parent_ID=@Parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)='{') 
	    SELECT @NextCloseDelimiterChar='}', @type='object'
	  ELSE 
	    SELECT @NextCloseDelimiterChar=']', @type='array'
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+'|')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{' 
	        SELECT @NextCloseDelimiterChar='}', @type='object'
	      ELSE 
	        SELECT @NextCloseDelimiterChar=']', @type='array'
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or Name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                '@'+@type+CONVERT(NCHAR(5), @Parent_ID))
	  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type='object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based Name.
	          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
              SELECT @token=RTrim(Substring(' '+@contents, @start+1, @End-@Start-1)),
	            @endofName=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofName+1)
	          SELECT
	            @token=LEFT(@token, @endofName-1),
	            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
	          SELECT  @Name=StringValue FROM @strings
	            WHERE string_id=@param --fetch the Name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
                IF @end=0
	        --HR Engineering notation bugfix start
	          IF ISNUMERIC(@contents) = 1
		    SELECT @end = LEN(@contents) + 1
	          Else
	        --HR Engineering notation bugfix end 
		  SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents+' ' collate SQL_Latin1_General_CP850_Bin) + 1
	       SELECT
	        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+'|'), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
	      IF SUBSTRING(@value, 1, 7)='@object' 
	        INSERT INTO @hierarchy
	          (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), 'object' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)='@array' 
	          INSERT INTO @hierarchy
	            (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	            SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), 'array' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)='@string' 
	            INSERT INTO @hierarchy
	              (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	              SELECT @Name, @SequenceNo, @Parent_ID, StringValue, 'string'
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN ('true', 'false') 
	              INSERT INTO @hierarchy
	                (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                SELECT @Name, @SequenceNo, @Parent_ID, @value, 'boolean'
	            ELSE
	              IF @value='null' 
	                INSERT INTO @hierarchy
	                  (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                  SELECT @Name, @SequenceNo, @Parent_ID, @value, 'null'
	              ELSE
	                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'real'
	                ELSE
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'int'
	      if @Contents=' ' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	  SELECT '-',1, NULL, '', @Parent_ID-1, @type
	--
	   RETURN
	END
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_BenefitUtilization_v4]    Script Date: 6/26/2024 11:30:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






--exec [dbo].[sp_BenefitUtilization] 'H428','H428','ELIG'

CREATE PROCEDURE [dbo].[sp_BenefitUtilization_v4]
(
@InClientCode varchar(20), -- H428 for Baycare
@OutClientCode varchar(20), --Not in use
@Filetype varchar(10) --FULL/Delta
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
SET NOCOUNT ON
SET XACT_ABORT ON

BEGIN TRY
--SELECT 1/0
DECLARE @DataSource nvarchar(20)
DECLARE @FileSubmitGrpId nvarchar(20)
DECLARE @GetDateEST date
DECLARE @PreviousMonthFirst date
DECLARE @PreviousMonthLast date
DECLARE @CurrentDateEST date
DECLARE @DATA_DATE date

SET @CurrentDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @DATA_DATE = FORMAT(@CurrentDateEST , 'yyyy-MM-dd')

SET @DataSource = 'ELIG_BAYC'
--SET @GetDateEST = CAST(getdate() AT TIME ZONE 'UTC'  AT TIME ZONE 'Eastern Standard Time' as date )
SET @GetDateEST = GetDate() + 30

SET @PreviousMonthFirst = FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd')
SET @PreviousMonthLast =  FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd')

--SELECT @FileSubmitGrpId =  (SUBSTRING(FileName, charindex('_', FileName)+1, 14))  from elig.FileInfo where upper(FileName) Like '%BENEFITUTIL%' -- Chech the SSIS package, Parse the FileSubmitGrpId from the FileName
SET @FileSubmitGrpId =  CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)

Print(GetDate())
Print(@GetDateEST)
Print(@PreviousMonthFirst)
Print(@PreviousMonthLast)
Print(@FileSubmitGrpId)			

IF OBJECT_ID('tempdb..#OrderIDAndOrderItemIDTemp') IS NOT NULL DROP TABLE #OrderIDAndOrderItemIDTemp
IF OBJECT_ID('tempdb..#OrderShippingInfoTemp') IS NOT NULL DROP TABLE #OrderShippingInfoTemp
IF OBJECT_ID('tempdb..#BenefitUtilizationTemp') IS NOT NULL DROP TABLE #BenefitUtilizationTemp

SELECT * INTO #OrderIDAndOrderItemIDTemp FROM
(
SELECT oi.[OrderId],oi.[OrderItemId],oi.[Quantity],oi.[Amount],oi.[ItemCode],oi.[UnitPrice],oi.[PairPrice]
FROM Orders.OrderItems oi WHERE [OrderId] IN (	SELECT o.[OrderID] 
												FROM Orders.Orders o
												WHERE [NHMemberId] IN ( SELECT m.[NHMemberID]
																		FROM [Master].[Members] m
																		WHERE NHlinkID IN ( SELECT mefd.[NHLinkid]
																							FROM [elig].[mstrEligBenefitData] mefd
																							WHERE [DataSource] = @DataSource --AND NHLinkID = '110099003' 
																							and
																								(
																									--Returns the previous month's day 1
																									(@PreviousMonthFirst between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthFirst between [BenefitStartDate] and [BenefitEndDate])
																								)
																								and
																								( 
																									--Returns the Last Month's last day of the month
																									(@PreviousMonthLast between [RecordEffDate] and [RecordEndDate]) and 
																									(@PreviousMonthLast between [BenefitStartDate] and [BenefitEndDate])
																								)
																							)
																		)
											AND DateOrderReceived BETWEEN @PreviousMonthFirst AND @PreviousMonthLast 
											)
) A

SELECT * FROM #OrderIDAndOrderItemIDTemp

SELECT * FROM Orders.Orders where OrderID in (SELECT DISTINCT OrderID from #OrderIDAndOrderItemIDTemp) Order by DateOrderReceived
SELECT * FROM Orders.OrderItems where OrderItemID in (SELECT DISTINCT OrderItemID from #OrderIDAndOrderItemIDTemp)
--This temp table contains the OrderShipping information stored as a JSON document inside a varchar column
SELECT * INTO #OrderShippingInfoTemp FROM
(
SELECT DISTINCT orderID, OrderTransactionID,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER,
JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING,
'' AS SHIPMENT_AMT,

JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipDate') as SHIPMENT_DT_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShippingMethod') as SHIPMENT_CARRIER_1,
JSON_VALUE(OTD.OrderTransactionData, '$[1].ShipmentTracking') as SHIPMENT_TRACKING_1
FROM Orders.OrderTransactionDetails OTD 
WHERE ISJSON(OrderTransactionData) > 0 and OrderStatusCode = 'SHI' and OrderID in (SELECT DISTINCT OrderID FROM #OrderIDAndOrderItemIDTemp)
) B

SELECT COUNT(*) AS RecordCount from #OrderShippingInfoTemp


SELECT * INTO #BenefitUtilizationTemp FROM
(SELECT Distinct
'NATIONSOTC' as [SOURCE_SENDER]
,'NBCRM' as [SOURCE_SYSTEM]
--,FORMAT(@GetDateEST, 'yyyy-MM-dd') AS DATA_DATE
,@DATA_DATE as DATA_DATE

,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, 0, @GetDateEST)-1, 0)),'yyyy-MM-dd') as PERIOD_BEGIN_DATE
,FORMAT((DATEADD(MONTH, DATEDIFF(MONTH, -1, @GetDateEST)-1, -1)),'yyyy-MM-dd') as PERIOD_END_DATE

--,CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar) as FILE_SUBMIT_GRP_ID
,@FileSubmitGrpId AS FILE_SUBMIT_GRP_ID

,'OTC' AS [BENEFIT_TYPE]
,O.orderID as [TRANSACTION_ID]
,OI.orderitemID as [TRANSACTION_LINE_NUMBER]

,OTD.OrderTransactionID as OrderTransactionID

,OI.Status as [TRANSACTION_TYPE_Status],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'CANCELLED' THEN 'Cancellation'
     WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'RETURNED' THEN 'Return'
	 WHEN UPPER(LTRIM(RTRIM(OI.Status))) = 'ACTIVE' THEN 'Purchase'
ELSE ''
END
) as [TRANSACTION_TYPE]

,O.OrderStatusCode as [TRANSACTION_STATUS_OrderStatusCode],

(
CASE WHEN UPPER(LTRIM(RTRIM(O.OrderStatusCode))) = 'SHI' THEN 'Fulfilled'
ELSE ''
END
) as [TRANSACTION_STATUS]


,NULL as [NDC]
,IMC.ModelShortDescription as [PRODUCT_NAME]
,IMC.ModelLongDescription as [PRODUCT_NAME_LONG]
,IMC.ModelShortDescription as [PRODUCT_NAME_SHORT]
,FORMAT(O.DateOrderReceived, 'yyyy-MM-dd')  as [ORDER_DT]
,FORMAT(O.DateOrderInitiated, 'yyyy-MM-dd')  as[SVC_DT]
,'' as [POSTED_DT]
--,M.MemberID as [MEMBER_ID]
,M.NHLinkID as [MEMBER_ID]
,'0.00' AS [PLAN_RESP_AMT]
,O.Amount as [ORDERS_BILL_AMT],

CAST(
		(
		CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)*(-1.0)
			 WHEN UPPER(LTRIM(RTRIM(OI.status))) = 'ACTIVE' AND CAST(OI.Amount AS FLOAT) >= 0.0 THEN CAST(OI.Amount AS FLOAT)
		ELSE NULL
		END 
		) 
		AS VARCHAR
	) AS BILL_AMT

,OI.UnitPrice as [BILL_UNIT_AMT]
,'' AS [SALES_TAX_AMT]
,'' AS [CONSUMER_USE_TAX]
,'' AS [SELLER_USE_TAX]
,'' AS [ADMIN_FEE_AMT]
,'' as [REFUND_AMT]
,'' as [RESTOCK_AMT]

,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipDate') as SHIPMENT_DT
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShippingMethod') as SHIPMENT_CARRIER
,JSON_VALUE(OTD.OrderTransactionData, '$[0].ShipmentTracking') as SHIPMENT_TRACKING
,'' AS SHIPMENT_AMT
/*
,'ShipmentDate' as [SHIPMENT_DT]
,'ShipmentCarrier' as [SHIPMENT_CARRIER]
,'ShipmentTracking' as [SHIPMENT_TRACKING]
,'ShipmentAmt' as [SHIPMENT_AMT]
*/

,'' as [EXTERNAL_TRANSACTION_ID]
,'' as [EXTERNAL_TRANSACTION_LINE_NUMBER]

,O.orderID as [ORIG_TRANSACTION_ID_OrderID],

(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(O.OrderId as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_ID]


,OI.orderitemID  as [ORIG_TRANSACTION_LINE_NUMBER_OrderItemID],
(
CASE WHEN UPPER(LTRIM(RTRIM(OI.status))) in ('CANCELLED', 'RETURNED') THEN cast(OI.orderitemID as varchar)
ELSE ''
END 
) AS [ORIG_TRANSACTION_LINE_NUMBER]


,'' as [CONDITION_1_CD]
,'' as [CONDITION_2_CD]
,'' as [CONDITION_3_CD]
,'' as [FEED_SPECIFIC_TXT1]
,'' as [FEED_SPECIFIC_TXT2]
,'' as [FEED_SPECIFIC_TXT3]
,'' as [FEED_SPECIFIC_TXT4]
,'' as [FEED_SPECIFIC_TXT5]
FROM
Orders.OrderItems OI
left join Orders.Orders O on (O.OrderID = OI.OrderID )
left join Orders.OrderTransactionDetails OTD on (O.OrderID = OTD.OrderID and OTD.OrderStatusCode = 'SHI')
left join Master.Members M on (O.NHMemberID = M.NHMemberID)
left join cms.ItemMasterContent IMC on (IMC.ItemCode = OI.ItemCode)
)  C
WHERE 
C.TRANSACTION_LINE_NUMBER in (SELECT [OrderItemId] FROM #OrderIDAndOrderItemIDTemp) 

			 
SELECT * FROM #BenefitUtilizationTemp
SELECT COUNT(*) AS RecordCount_1 FROM #BenefitUtilizationTemp

SELECT 1 as fororder,
'SOURCE_SENDER|SOURCE_SYSTEM|DATA_DATE|PERIOD_BEGIN_DATE|PERIOD_END_DATE|FILE_SUBMIT_GRP_ID|BENEFIT_TYPE|TRANSACTION_ID|TRANSACTION_LINE_NUMBER|TRANSACTION_TYPE|TRANSACTION_STATUS|NDC|PRODUCT_NAME|ORDER_DT|SVC_DT|POSTED_DT|MEMBER_ID|PLAN_RESP_AMT|BILL_AMT|BILL_UNIT_AMT|SALES_TAX_AMT|CONSUMER_USE_TAX|SELLER_USE_TAX|ADMIN_FEE_AMT|REFUND_AMT|RESTOCK_AMT|SHIPMENT_DT|SHIPMENT_CARRIER|SHIPMENT_TRACKING|SHIPMENT_AMT|EXTERNAL_TRANSACTION_ID|EXTERNAL_TRANSACTION_LINE_NUMBER|ORIG_TRANSACTION_ID|ORIG_TRANSACTION_LINE_NUMBER|CONDITION_1_CD|CONDITION_2_CD|CONDITION_3_CD|FEED_SPECIFIC_TXT1|FEED_SPECIFIC_TXT2|FEED_SPECIFIC_TXT3|FEED_SPECIFIC_TXT4|FEED_SPECIFIC_TXT5'
as Outputtext
UNION
SELECT
2 as fororder,
+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SENDER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SOURCE_SYSTEM,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.DATA_DATE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_BEGIN_DATE,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PERIOD_END_DATE,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FILE_SUBMIT_GRP_ID,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BENEFIT_TYPE,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_ID,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_TYPE,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.TRANSACTION_STATUS,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.NDC,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PRODUCT_NAME,''),'|',''),1,100) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORDER_DT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SVC_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.POSTED_DT,''),'|',''),1,20)


+'|'+SUBSTRING(REPLACE(ISNULL(bu.MEMBER_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.PLAN_RESP_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.BILL_UNIT_AMT,''),'|',''),1,20) 	
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SALES_TAX_AMT,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONSUMER_USE_TAX,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SELLER_USE_TAX,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ADMIN_FEE_AMT,''),'|',''),1,20) 
			
+'|'+SUBSTRING(REPLACE(ISNULL(bu.REFUND_AMT,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.RESTOCK_AMT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_DT,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_CARRIER,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_TRACKING,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.SHIPMENT_AMT,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_ID,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.EXTERNAL_TRANSACTION_LINE_NUMBER,''),'|',''),1,20)

+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_ID,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.ORIG_TRANSACTION_LINE_NUMBER,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_1_CD,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_2_CD,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.CONDITION_3_CD,''),'|',''),1,20) 					
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT1,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT2,''),'|',''),1,20) 
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT3,''),'|',''),1,20)
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT4,''),'|',''),1,20) 		
+'|'+SUBSTRING(REPLACE(ISNULL(bu.FEED_SPECIFIC_TXT5,''),'|',''),1,20) 
 as OutputText
 from #BenefitUtilizationTemp bu
 order by 1




 

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
GO




USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[ExtractXmlDataIntoTable]    Script Date: 6/26/2024 11:29:04 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ExtractXmlDataIntoTable]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @XmlData XML;
	DECLARE @FileName NVARCHAR(500);
    DECLARE @TempTable TABLE (
        -- Define columns for extracted data
		FileName NVARCHAR(500),
        NodeName NVARCHAR(100),
        AttributeName NVARCHAR(100),
        AttributeValue NVARCHAR(100),
        NodeValue NVARCHAR(MAX)
    );

    -- Replace 'YourTableName' and 'YourXmlColumn' with actual table and XML column names
    DECLARE XmlCursor CURSOR LOCAL FOR
    SELECT F1XML, FileName
    FROM FISXML
	
	OPEN XmlCursor;
    FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
		select @FileName
        INSERT INTO @TempTable ( NodeName, AttributeName, AttributeValue, NodeValue, FileName)
        SELECT
            Node.value('local-name(.)', 'NVARCHAR(100)') AS NodeName,
            Attribute.value('local-name(.)', 'NVARCHAR(100)') AS AttributeName,
            Attribute.value('.', 'NVARCHAR(100)') AS AttributeValue,
            Node.value('.', 'NVARCHAR(MAX)') AS NodeValue,
			@FileName as FileName
        FROM @XmlData.nodes('//*') AS T(Node) -- Get all nodes in the XML document
        OUTER APPLY Node.nodes('@*') AS T2(Attribute); -- Get attributes of each node
		select @FileName
        FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
    END

    CLOSE XmlCursor;
    DEALLOCATE XmlCursor;

    -- Insert the extracted data into a new table
    INSERT INTO FISXMLExtract (FileName, NodeName, AttributeName, AttributeValue, NodeValue)
    SELECT FileName,NodeName, AttributeName, AttributeValue, NodeValue
    FROM @TempTable;
END
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [dbo].[sp_FISCCXDataLoad]    Script Date: 6/26/2024 11:27:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Santhosh Balla
-- Create date: December 2022
-- Description:	This procedure extracts the different categories into separate tables
-- =============================================
/*
EXEC sp_FISCCXDataLoad

*/

CREATE PROCEDURE [dbo].[sp_FISCCXDataLoad]
	
AS
BEGIN
SET NOCOUNT ON;

/*

-- To verify to check if all the records have been accounted for
select 'AllTables' as TableName, sum(RecordCount) as RecordCount from (
select 'FISCCX_DCST' as TableName,count(*) as RecordCount from FISCCX_DCST union 
select 'FISCCX_DIIA' as TableName,count(*) as RecordCount from FISCCX_DIIA union 
select 'FISCCX_DODL' as TableName,count(*) as RecordCount from FISCCX_DODL union 
select 'FISCCX_DPKG' as TableName,count(*) as RecordCount from FISCCX_DPKG union 
select 'FISCCX_DPRY' as TableName,count(*) as RecordCount from FISCCX_DPRY union 
select 'FISCCX_DPUR' as TableName,count(*) as RecordCount from FISCCX_DPUR union 
select 'FISCCX_DSPG' as TableName,count(*) as RecordCount from FISCCX_DSPG union 
select 'FISCCX_DUSR' as TableName,count(*) as RecordCount from FISCCX_DUSR union 
select 'FISCCX_Header' as TableName,count(*) as RecordCount from FISCCX_Header union 
select 'FISCCX_Trailer' as TableName,count(*) as RecordCount from FISCCX_Trailer
) a
union
select 'StageTable' as TableName, count(*) as RecordCount from [FISCCXStg]
union
select 'FISCCX_Trailer' as TableName, (sum(cast(RecordCount as int)) + count(FileName)*2 ) from FISCCX_Trailer


IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Header_Action' and xtype='U')
CREATE TABLE FISCCX_Header_Action  
    (ExistingCode nchar(3),  
     ExistingName nvarchar(50),  
     ExistingDate datetime,  
     ActionTaken nvarchar(10),  
     NewCode nchar(3),  
     NewName nvarchar(50),  
     NewDate datetime  
    );  
*/

-- Header --
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Header' and xtype='U')
CREATE TABLE FISCCX_Header 
(
ID int Identity (1,1),
StgID int not null,
RecordType varchar(max),
ProcessorName varchar(max),
ReportDataFeedName varchar(max),
FileDate varchar(max),
WorkOfDate varchar(max),
ClientID varchar(max),
BankID varchar(max),
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- Trailer --
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_Trailer' and xtype='U')
CREATE TABLE FISCCX_Trailer
(
ID int Identity (1,1),
StgID int not null,
RecordType [varchar](max) NULL,
RecordCount [varchar](max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DODL | Tolerance and Overdraft
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DODL' and xtype='U')
CREATE TABLE FISCCX_DODL
(
ID int Identity (1,1),
StgID int not null,
RecordType [varchar](max) NULL,
SubProgramID [varchar](max) NULL,
MCCGroup [varchar](max) NULL,
Fudge [varchar](max) NULL,
IncAuthHoldTimeMCCGroup [varchar](max) NULL,
AuthHoldTimeDays [varchar](max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DPUR | Purse setup
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPUR' and xtype='U')
CREATE TABLE FISCCX_DPUR
(
ID int Identity (1,1),
StgID int not null,
RecordType					varchar(max) NULL,
SubProgramID			    varchar(max) NULL,
PurseID			        varchar(max) NULL,
PurseName			        varchar(max) NULL,
PurseStrategy			    varchar(max) NULL,
AllowedMCCGroups			varchar(max) NULL,
NetworkName			    varchar(max) NULL,
PurseValueLimits			varchar(max) NULL,
MinimumValue			    varchar(max) NULL,
MaximumValue			    varchar(max) NULL,
MinimumLoad			    varchar(max) NULL,
MaximumLoad			    varchar(max) NULL,
[Status]			            varchar(max) NULL,
EffectiveDate			    varchar(max) NULL,
ExpirationDate			    varchar(max) NULL,
ExtensionDate			    varchar(max) NULL,
ExtensionFlagName			varchar(max) NULL,
IsDeleted			        varchar(max) NULL,
PurseHandle			    varchar(max) NULL,
DefaultPurseForAuth	    varchar(max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)


-- DCST | Cash Attribute Parameters
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DCST' and xtype='U')
CREATE TABLE FISCCX_DCST
(
ID int Identity (1,1),
StgID int not null,
RecordType varchar(max) NULL,
SubProgramID varchar(max) NULL,
PurseID varchar(max) NULL,
CashType varchar(max) NULL,
TotalAmountLimit varchar(max) NULL,
TotalCountLimit varchar(max) NULL,
MaxAmountPerTrans varchar(max) NULL,
MinAmountPerTrans varchar(max) NULL,
CycleAmountLimit varchar(max) NULL,
CycleCountLimit varchar(max) NULL,
CycleDays varchar(max) NULL,
IsDeleted varchar(max) NULL,
[FileName] [varchar](max) NULL,
[IsActive] int default 1,
[CreateUser] [varchar](max) default system_user,
[CreateDate] [datetime] default getdate(),
[ModifyUser] [varchar](max) default system_user,
[ModifyDate] [datetime] default getdate()
)

-- DPRY | MCC Purse priority
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPRY' and xtype='U')
CREATE TABLE FISCCX_DPRY			
(			
ID	int	Identity(1,1),
StgID	int	not null,
RecordType	varchar	(max),
SubProgramID	varchar	(max),
PurseID	varchar	(max),
GroupID	varchar	(max),
MCCGroup	varchar	(max),
MCCDesc	varchar	(max),
Priority	varchar	(max),
IsDeleted	varchar	(max),
[FileName]	varchar	(max),	
[IsActive] 	int	default 1,
[CreateUser]	varchar	(max),
[CreateDate]	datetime	default getdate(),
[ModifyUser] 	varchar	(max)	,
[ModifyDate]	datetime	default getdate()
)


-- DUSR | Application Users
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DUSR' and xtype='U')
CREATE TABLE FISCCX_DUSR			
(			
ID	int	Identity(1,1),
StgID	int	not null,
RecordType	varchar	(max),
ClientID	varchar	(max),
ClientIDName	varchar	(max),
SourceName	varchar	(max),
Username	varchar	(max),
SecurityLevelName	varchar	(max),
Active	varchar	(max),
[FileName]	varchar	(max),
[IsActive] 	int	default 1,
[CreateUser]	varchar	(max) default system_user,
[CreateDate]	datetime	default getdate(),
[ModifyUser] 	varchar	(max) default system_user,
[ModifyDate]	datetime	default getdate(),
)

/*
-- DSPG | Category,General Program Information,Card Parameters,Card Expiration,Auto Renewal,Account Value Limits,Card Fulfillment Embossing,Embossing Options,Additional Attributes,Value Load Velocity Limits,Address Change Velocity Limits,Negative Balance and Dispute Processing,Auto -Chargeback Process,Statement Setup,Direct Access Setup,ACH Trial Deposit Verification,Client Sponsored Consumer ACH File,Private Label ACH Enrollment,Remote Data Capture,PPDB Number,Account to Account Transfer,MCC Restrictions,New additional Attributes,Statement Setup Extended,Direct Access Setup Extended,Copay Configuration,Pay & Chase Configuration,PBM Configuration,
*/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DSPG' and xtype='U')
CREATE TABLE FISCCX_DSPG			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
SubProgramName	varchar	(max)	,
SubProgramActiveFlag	varchar	(max)	,
ProgramID	varchar	(max)	,
ProgramName	varchar	(max)	,
ClientID	varchar	(max)	,
ClientName	varchar	(max)	,
ClientAltValue	varchar	(max)	,
TemplateSubProgramID	varchar	(max)	,
FISAssumeFraudLiability	varchar	(max)	,
ProxyName	varchar	(max)	,
AKAName	varchar	(max)	,
PseudoBIN	varchar	(max)	,
MarketSegment	varchar	(max)	,
ProgramLevel	varchar	(max)	,
ProgramUseProxyNumbers	varchar	(max)	,
ProxyType	varchar	(max)	,
IVRAuthenticationMethod	varchar	(max)	,
CardType	varchar	(max)	,
ProgramType	varchar	(max)	,
PINBased	varchar	(max)	,
PINTries	varchar	(max)	,
NumberOfDaysPINLocked	varchar	(max)	,
RePlastic	varchar	(max)	,
AdvanceExpire	varchar	(max)	,
PrivacyOptOut	varchar	(max)	,
LoadSuspend	varchar	(max)	,
ApproveMissingTransaction	varchar	(max)	,
SkipExpiredClosedCardDDA	varchar	(max)	,
AreCardsReloadable	varchar	(max)	,
InitialCardStatus	varchar	(max)	,
ActiveMethod	varchar	(max)	,
HowWillCardsBeActivated	varchar	(max)	,
PhysicalExpirationMethod	varchar	(max)	,
PhysicalExpirationDate	varchar	(max)	,
PhysicalExpirationMonth	varchar	(max)	,
Logical	varchar	(max)	,
LogicalDynamic	varchar	(max)	,
LogicalExpireEvent	varchar	(max)	,
AutoRenewal	varchar	(max)	,
RenewalWindow	varchar	(max)	,
RenewalMonths	varchar	(max)	,
RenewalCardStatus	varchar	(max)	,
BalanceThreshold	varchar	(max)	,
FinancialActivityWindowInDays	varchar	(max)	,
PositiveFinancialActivityWindow	varchar	(max)	,
UtilizeReplacementPackage	varchar	(max)	,
AccountValueLimits	varchar	(max)	,
FixedValue	varchar	(max)	,
MinValue	varchar	(max)	,
MaxValue	varchar	(max)	,
MinLoadOnCard	varchar	(max)	,
MaxLoadOnCard	varchar	(max)	,
ThirdLineEmbossing	varchar	(max)	,
ThirdLineEmbossStaticName	varchar	(max)	,
FourthLineEmbossing	varchar	(max)	,
FourthLineEmbossStaticName	varchar	(max)	,
EmbossOrPrintBeginDates	varchar	(max)	,
EmbossOrPrintExpireDates	varchar	(max)	,
EmbossOrPrintSecurityCode	varchar	(max)	,
SendPIN	varchar	(max)	,
PINMailerLag	varchar	(max)	,
PINMethod	varchar	(max)	,
CarrierSlotType	varchar	(max)	,
ReturnAddress1	varchar	(max)	,
ReturnAddress2	varchar	(max)	,
ReturnAddress3	varchar	(max)	,
ReturnAddress4	varchar	(max)	,
PrintLine1AccountNumber	varchar	(max)	,
PrintLine2ExpirationDate	varchar	(max)	,
PrintLine3CardholderName	varchar	(max)	,
PrintLine4	varchar	(max)	,
PrintProxy	varchar	(max)	,
PrintIndentCardNumber	varchar	(max)	,
PrintSecurityCodeOnIndent	varchar	(max)	,
IssueDuplicateCard	varchar	(max)	,
EmbossFullDate	varchar	(max)	,
SortBySequentialProxyNumber	varchar	(max)	,
PassCardHolderPhoneNumber	varchar	(max)	,
PassCardholderEmail	varchar	(max)	,
PassCardholderDARoutingInfo	varchar	(max)	,
PassCountry	varchar	(max)	,
PassOtherInformation	varchar	(max)	,
PassClientAltValue	varchar	(max)	,
ParsingRulesToAddress	varchar	(max)	,
ShipmentRecordsFlag	varchar	(max)	,
MagName	varchar	(max)	,
FulfillmentInstructions1	varchar	(max)	,
FulfillmentInstructions2	varchar	(max)	,
DiscretionaryData1	varchar	(max)	,
DiscretionaryData2	varchar	(max)	,
DiscretionaryData3	varchar	(max)	,
CardNumberEmbossingMask	varchar	(max)	,
SecondaryCardsFlag	varchar	(max)	,
NumberOfSecondaryCards	varchar	(max)	,
MaxActivationAttempts	varchar	(max)	,
AllowBillPayFunctionality	varchar	(max)	,
BlockBillingTransactionFlag	varchar	(max)	,
ValueLoadUponActivation	varchar	(max)	,
ExpiredCardConfig	varchar	(max)	,
RetailReloadNetworkServices	varchar	(max)	,
MoneyTransferSetupFlag	varchar	(max)	,
SetupMasterCardMoneySend	varchar	(max)	,
PFraudConfig	varchar	(max)	,
EnableOpenToBuyBalanceAtPOS	varchar	(max)	,
BlockCountry	varchar	(max)	,
UnblockCountry	varchar	(max)	,
IncludeCountry	varchar	(max)	,
VelocityLimitPeriodInDays	varchar	(max)	,
ValueLoadNumberPerPeriod	varchar	(max)	,
ValueLoadAmountPerPeriod	varchar	(max)	,
FrozenFromActivationInDays	varchar	(max)	,
FreqLimitForAddressChange	varchar	(max)	,
MaxNumberOfAddressChanges	varchar	(max)	,
ApplNotConsideredForAddressVelocity	varchar	(max)	,
ClearNegativeBalances	varchar	(max)	,
LiabilityOnNegativeBalances	varchar	(max)	,
MaxNegativeBalanceAutoCleared	varchar	(max)	,
AccountStatusNotAutoCleared	varchar	(max)	,
MaxNegativeBalanceManuallyCleared	varchar	(max)	,
ClearNegativeBalancesAfterEventInDays	varchar	(max)	,
DisputeResolutionServiceFlag	varchar	(max)	,
DisputeProcessGuideLine	varchar	(max)	,
TempCreditToApplyInDays	varchar	(max)	,
TempCreditDisputeToApplyInDays	varchar	(max)	,
DisputeLettersMailed	varchar	(max)	,
SettleServiceAndMoneyMove	varchar	(max)	,
CustomerServicePhoneNumber	varchar	(max)	,
MinAutoChargeBackReviewInDays	varchar	(max)	,
AccountWithPositiveBalance	varchar	(max)	,
Statements	varchar	(max)	,
OnlineStatements	varchar	(max)	,
PaperStatements	varchar	(max)	,
PrintBydefaultOrCHOption	varchar	(max)	,
StatementCycle	varchar	(max)	,
TransactionActivity	varchar	(max)	,
BalanceGreaterThan	varchar	(max)	,
BalanceLessThan	varchar	(max)	,
AccountStatus	varchar	(max)	,
StatementPaper	varchar	(max)	,
StatementTemplate	varchar	(max)	,
StatementFileFormat	varchar	(max)	,
DirectAccessConfig	varchar	(max)	,
DDASponsorBank	varchar	(max)	,
RoutingTransitNumber	varchar	(max)	,
BankPrefix	varchar	(max)	,
Withdrawal	varchar	(max)	,
ValueLoadDirectDepositLimitCheck	varchar	(max)	,
CardStatusUpdate	varchar	(max)	,
CardStatusToPFraud	varchar	(max)	,
FAXNumber	varchar	(max)	,
NameMatchForIRSTaxRefunds	varchar	(max)	,
ACHTrialDepositVerificationConfig	varchar	(max)	,
UserInputAttemptsPermitted	varchar	(max)	,
ValidationInDays	varchar	(max)	,
ACHAccountDisplay	varchar	(max)	,
ValueLoadWaitPeriod	varchar	(max)	,
NumberOfExternalBankAccounts	varchar	(max)	,
ClientACHAccountDisplay	varchar	(max)	,
EffectiveEntryDays	varchar	(max)	,
Active	varchar	(max)	,
ReturnCVV2	varchar	(max)	,
ReturnExpirationDate	varchar	(max)	,
InstantConfigured	varchar	(max)	,
StandardConfigured	varchar	(max)	,
StandardWaitPeriodInDays	varchar	(max)	,
PPDBNumber	varchar	(max)	,
AccountToAccountTransferConfig	varchar	(max)	,
SenderMaxNumberOfRecipients	varchar	(max)	,
SenderLengthOfPeriod	varchar	(max)	,
SenderMaxTransfersPerPeriod	varchar	(max)	,
SenderMaxTransferAmountPerPeriod	varchar	(max)	,
SenderTransfersInDays	varchar	(max)	,
SenderMaxTransferAmountPerDay	varchar	(max)	,
SenderMaxAmountPerTransaction	varchar	(max)	,
SenderMinAmountPerTransaction	varchar	(max)	,
SenderAllowFeeReversal	varchar	(max)	,
SenderQualifiedStatus	varchar	(max)	,
SenderDestinationClients	varchar	(max)	,
SearchReceiverCriteria	varchar	(max)	,
TieBreakerRules	varchar	(max)	,
ReceiverLengthOfPeriod	varchar	(max)	,
ReceiverMaxNumberOfTransfersPerPeriod	varchar	(max)	,
ReceiverMaxTransferAmountPerPeriod	varchar	(max)	,
ReceiverMaxNumberOfTransfersPerDay	varchar	(max)	,
ReceiverMaxTransferAmountPerDay	varchar	(max)	,
ReceiverMaxAmountPerTransaction	varchar	(max)	,
ReceiverMinAmountPerTransaction	varchar	(max)	,
ReceiverQualifiedStatus	varchar	(max)	,
ReceiverDestinationClients	varchar	(max)	,
BlockGamblingMerchantsMCC7995	varchar	(max)	,
BlockCashAndQuasiCash	varchar	(max)	,
OtherMCCsRestricted	varchar	(max)	,
AdditionalProxyLength	varchar	(max)	,
IVRSecondaryAuthMethod	varchar	(max)	,
AutoRenewalOnValueLoad	varchar	(max)	,
SetupRegionalNetworkMoneyTransfer	varchar	(max)	,
DisputeFormTempCredit	varchar	(max)	,
TokenizationAllowed	varchar	(max)	,
IsACHFastPayEnabled	varchar	(max)	,
SenderReversalDays	varchar	(max)	,
ReceiverAllowFeeReversal	varchar	(max)	,
ReceiverReversalDays	varchar	(max)	,
IVROrMyAccountPINOptions	varchar	(max)	,
RestrictAdjust	varchar	(max)	,
FulfillmentRequestType	varchar	(max)	,
StatementMessageContents	varchar	(max)	,
StartDate	varchar	(max)	,
EndDate	varchar	(max)	,
DefaultPurseForDirectAccess	varchar	(max)	,
Copay	varchar	(max)	,
MCCGroupCopay	varchar	(max)	,
FutureUse2	varchar	(max)	,
FutureUse3	varchar	(max)	,
PBM	varchar	(max)	,
MCCGroupPayAndChase	varchar	(max)	,
NetworkName	varchar	(max)	,
PurseStatusAutoRenewal	varchar	(max)	,
RandomPINCardGeneration	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)

-- DIIA | IIAS Group (Healthcare Program Configuration)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DIIA' and xtype='U')
CREATE TABLE FISCCX_DIIA			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
PurseID	varchar	(max)	,
IIAS	varchar	(max)	,
IIASDesc	varchar	(max)	,
IIASGroupID	varchar	(max)	,
IIASGroupDesc	varchar	(max)	,
[Priority]	varchar	(max)	,
IsDeleted	varchar	(max)	,
IIASGroupPriority	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)


-- DPKG | Package Setup, Authorization Parameters
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='FISCCX_DPKG' and xtype='U')
CREATE TABLE FISCCX_DPKG			
(			
ID	int	Identity(1,1)	,
StgID	int	not null	,
RecordType	varchar	(max)	,
SubProgramID	varchar	(max)	,
PackageID	varchar	(max)	,
PackageName	varchar	(max)	,
ArtworkName	varchar	(max)	,
BIN	varchar	(max)	,
PrinAndAgentRange	varchar	(max)	,
FulfillmentHouse	varchar	(max)	,
CardCountThreshold	varchar	(max)	,
CardIssuedSequentFlag	varchar	(max)	,
BarcodeType	varchar	(max)	,
FormFactor	varchar	(max)	,
ReplacementPackageID	varchar	(max)	,
DuplicateSettlementAwaitInDays	varchar	(max)	,
AuthAwaitSettlementInDays	varchar	(max)	,
EncodingMethod	varchar	(max)	,
PartialAuth	varchar	(max)	,
IsDeleted	varchar	(max)	,
ImmediateCredit	varchar	(max)	,
ApprovedProductList	varchar	(max)	,
[FileName]	varchar	(max)	,
[IsActive] 	int	default 1	,
[CreateUser]	varchar	(max) default system_user	,
[CreateDate]	datetime	default getdate()	,
[ModifyUser] 	varchar	(max) default system_user	,
[ModifyDate]	datetime	default getdate()	,
)

BEGIN TRY

BEGIN TRANSACTION FISCCX_Transaction

MERGE [dbo].[FISCCX_Header] AS tgt  
    USING (SELECT ID as STGID, F1, F2, F3, F4, F5, F6, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'H' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName])  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,ProcessorName,ReportDataFeedName,FileDate,WorkOfDate, ClientID, [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,[FileName]) ; 
    -- OUTPUT deleted.*, $action, inserted.* INTO FISCCX_Header_Action; 


MERGE [dbo].[FISCCX_Trailer] AS tgt  
    USING (SELECT ID as STGID, F1, F2, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'T' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType = src.F1 and tgt.RecordCount = src.F2)  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType, RecordCount, [FileName] )  
        VALUES (STGID,F1,F2,[FileName]) ; 
    -- OUTPUT deleted.*, $action, inserted.* INTO FISCCX_Header_Action; 


MERGE [dbo].[FISCCX_DODL] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DODL' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType= src.F1 and tgt.SubProgramID = src.F2 and tgt.MCCGroup=src.F3 and tgt.Fudge=src.F4 and tgt.IncAuthHoldTimeMCCGroup=src.F5 and  tgt.AuthHoldTimeDays=src.F6 )  
    --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,SubProgramID,MCCGroup,Fudge,IncAuthHoldTimeMCCGroup,AuthHoldTimeDays, [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,[FileName]) ; 


MERGE [dbo].[FISCCX_DPUR] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPUR' and IsActive = 1 ) as src 
    ON (tgt.[FileName] = src.[FileName] and tgt.RecordType = src.F1 and tgt.SubProgramID = src.F2 and tgt.PurseID = src.F3 and tgt.PurseName = src.F4 and tgt.PurseStrategy = src.F5 and tgt.AllowedMCCGroups = src.F6 and tgt.NetworkName = src.F7 and tgt.PurseValueLimits = src.F8 and tgt.MinimumValue = src.F9 and tgt.MaximumValue = src.F10 and tgt.MinimumLoad = src.F11 and tgt.MaximumLoad = src.F12 and tgt.[Status] = src.F13 and tgt.EffectiveDate = src.F14 and tgt.ExpirationDate= src.F15 and tgt.ExtensionDate= src.F16 and tgt.ExtensionFlagName= src.F17 and tgt.IsDeleted= src.F18 and tgt.PurseHandle= src.F19 and tgt.DefaultPurseForAuth = src.F20 )
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID,RecordType,	SubProgramID,	PurseID,	PurseName,	PurseStrategy,	AllowedMCCGroups,	NetworkName,	PurseValueLimits,	MinimumValue,	MaximumValue,	MinimumLoad,	MaximumLoad,	[Status],	EffectiveDate,	ExpirationDate,	ExtensionDate,	ExtensionFlagName,	IsDeleted,	PurseHandle,	DefaultPurseForAuth,  [FileName] )  
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName]) ; 



/*
(STGID, RecordType,	SubProgramID,	PurseID,	CashType,	TotalAmountLimit,	TotalCountLimit,	MaxAmountPerTrans,	MinAmountPerTrans,	CycleAmountLimit,	CycleCountLimit,	CycleDays,	IsDeleted, [FileName])
src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.CashType and	src.F5=tgt.TotalAmountLimit and	src.F6=tgt.TotalCountLimit and	src.F7=tgt.MaxAmountPerTrans and	src.F8=tgt.MinAmountPerTrans and	src.F9=tgt.CycleAmountLimit and	src.F10=tgt.CycleCountLimit and	src.F11=tgt.CycleDays and	src.F12=tgt.IsDeleted and

*/

MERGE [dbo].[FISCCX_DCST] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DCST' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.CashType and	src.F5=tgt.TotalAmountLimit and	src.F6=tgt.TotalCountLimit and	src.F7=tgt.MaxAmountPerTrans and	src.F8=tgt.MinAmountPerTrans and	src.F9=tgt.CycleAmountLimit and	src.F10=tgt.CycleCountLimit and	src.F11=tgt.CycleDays and	src.F12=tgt.IsDeleted)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,SubProgramID,PurseID,CashType,TotalAmountLimit,TotalCountLimit,MaxAmountPerTrans,MinAmountPerTrans,CycleAmountLimit,CycleCountLimit,CycleDays,IsDeleted,[FileName])
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,[FileName]) ; 

/*
												
[FileName],	RecordType,	SubProgramID,	PurseID,	GroupID,	MCCGroup,	MCCDesc,	Priority,	IsDeleted				
src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.GroupID and	src.F5=tgt.MCCGroup and	src.F6=tgt.MCCDesc and	src.F7=tgt.Priority and	src.F8=tgt.IsDeleted and				
												
*/
MERGE [dbo].[FISCCX_DPRY] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPRY' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and	src.F1=tgt.RecordType and	src.F2=tgt.SubProgramID and	src.F3=tgt.PurseID and	src.F4=tgt.GroupID and	src.F5=tgt.MCCGroup and	src.F6=tgt.MCCDesc and	src.F7=tgt.[Priority] and	src.F8=tgt.IsDeleted)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,	SubProgramID,	PurseID,	GroupID,	MCCGroup,	MCCDesc,	Priority,	IsDeleted, [FileName]	)
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,[FileName]) ; 


MERGE [dbo].[FISCCX_DUSR] AS tgt  
    USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DUSR' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and src.F7=tgt.Active and src.F6=tgt.SecurityLevelName and src.F5=tgt.Username and src.F4=tgt.SourceName and src.F3=tgt.ClientIDName and src.F2=tgt.ClientID and src.F1=tgt.RecordType)

	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
        INSERT (STGID, RecordType,ClientID,ClientIDName,SourceName,Username,SecurityLevelName,Active,[FileName]	)
        VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,[FileName]) ; 

/*
RecordType,ClientID,ClientIDName,SourceName,Username,SecurityLevelName,Active,[FileName]
src.[FileName]=tgt.[FileName] and src.F7=tgt.Active and src.F6=tgt.SecurityLevelName and src.F5=tgt.Username and src.F4=tgt.SourceName and src.F3=tgt.ClientIDName and src.F2=tgt.ClientID and src.F1=tgt.RecordType and 
*/

MERGE [dbo].[FISCCX_DSPG] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DSPG' and IsActive = 1 ) as src 
    ON (src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.SubProgramName and src.F4=tgt.SubProgramActiveFlag and src.F5=tgt.ProgramID and src.F6=tgt.ProgramName and src.F7=tgt.ClientID and src.F8=tgt.ClientName and src.F9=tgt.ClientAltValue and src.F10=tgt.TemplateSubProgramID and src.F11=tgt.FISAssumeFraudLiability and src.F12=tgt.ProxyName and src.F13=tgt.AKAName and src.F14=tgt.PseudoBIN and src.F15=tgt.MarketSegment and src.F16=tgt.ProgramLevel and src.F17=tgt.ProgramUseProxyNumbers and src.F18=tgt.ProxyType and src.F19=tgt.IVRAuthenticationMethod and src.F20=tgt.CardType and src.F21=tgt.ProgramType and src.F22=tgt.PINBased and src.F23=tgt.PINTries and src.F24=tgt.NumberOfDaysPINLocked and src.F25=tgt.RePlastic and src.F26=tgt.AdvanceExpire and src.F27=tgt.PrivacyOptOut and src.F28=tgt.LoadSuspend and src.F29=tgt.ApproveMissingTransaction and src.F30=tgt.SkipExpiredClosedCardDDA and src.F31=tgt.AreCardsReloadable and src.F32=tgt.InitialCardStatus and src.F33=tgt.ActiveMethod and src.F34=tgt.HowWillCardsBeActivated and src.F35=tgt.PhysicalExpirationMethod and src.F36=tgt.PhysicalExpirationDate and src.F37=tgt.PhysicalExpirationMonth and src.F38=tgt.Logical and src.F39=tgt.LogicalDynamic and src.F40=tgt.LogicalExpireEvent and src.F41=tgt.AutoRenewal and src.F42=tgt.RenewalWindow and src.F43=tgt.RenewalMonths and src.F44=tgt.RenewalCardStatus and src.F45=tgt.BalanceThreshold and src.F46=tgt.FinancialActivityWindowInDays and src.F47=tgt.PositiveFinancialActivityWindow and src.F48=tgt.UtilizeReplacementPackage and src.F49=tgt.AccountValueLimits and src.F50=tgt.FixedValue and src.F51=tgt.MinValue and src.F52=tgt.MaxValue and src.F53=tgt.MinLoadOnCard and src.F54=tgt.MaxLoadOnCard and src.F55=tgt.ThirdLineEmbossing and src.F56=tgt.ThirdLineEmbossStaticName and src.F57=tgt.FourthLineEmbossing and src.F58=tgt.FourthLineEmbossStaticName and src.F59=tgt.EmbossOrPrintBeginDates and src.F60=tgt.EmbossOrPrintExpireDates and src.F61=tgt.EmbossOrPrintSecurityCode and src.F62=tgt.SendPIN and src.F63=tgt.PINMailerLag and src.F64=tgt.PINMethod and src.F65=tgt.CarrierSlotType and src.F66=tgt.ReturnAddress1 and src.F67=tgt.ReturnAddress2 and src.F68=tgt.ReturnAddress3 and src.F69=tgt.ReturnAddress4 and src.F70=tgt.PrintLine1AccountNumber and src.F71=tgt.PrintLine2ExpirationDate and src.F72=tgt.PrintLine3CardholderName and src.F73=tgt.PrintLine4 and src.F74=tgt.PrintProxy and src.F75=tgt.PrintIndentCardNumber and src.F76=tgt.PrintSecurityCodeOnIndent and src.F77=tgt.IssueDuplicateCard and src.F78=tgt.EmbossFullDate and src.F79=tgt.SortBySequentialProxyNumber and src.F80=tgt.PassCardHolderPhoneNumber and src.F81=tgt.PassCardHolderEmail and src.F82=tgt.PassCardHolderDARoutingInfo and src.F83=tgt.PassCountry and src.F84=tgt.PassOtherInformation and src.F85=tgt.PassClientAltValue and src.F86=tgt.ParsingRulesToAddress and src.F87=tgt.ShipmentRecordsFlag and src.F88=tgt.MagName and src.F89=tgt.FulfillmentInstructions1 and src.F90=tgt.FulfillmentInstructions2 and src.F91=tgt.DiscretionaryData1 and src.F92=tgt.DiscretionaryData2 and src.F93=tgt.DiscretionaryData3 and src.F94=tgt.CardNumberEmbossingMask and src.F95=tgt.SecondaryCardsFlag and src.F96=tgt.NumberOfSecondaryCards and src.F97=tgt.MaxActivationAttempts and src.F98=tgt.AllowBillPayFunctionality and src.F99=tgt.BlockBillingTransactionFlag and src.F100=tgt.ValueLoadUponActivation and src.F101=tgt.ExpiredCardConfig and src.F102=tgt.RetailReloadNetworkServices and src.F103=tgt.MoneyTransferSetupFlag and src.F104=tgt.SetupMasterCardMoneySend and src.F105=tgt.PFraudConfig and src.F106=tgt.EnableOpenToBuyBalanceAtPOS and src.F107=tgt.BlockCountry and src.F108=tgt.UnblockCountry and src.F109=tgt.IncludeCountry and src.F110=tgt.VelocityLimitPeriodInDays and src.F111=tgt.ValueLoadNumberPerPeriod and src.F112=tgt.ValueLoadAmountPerPeriod and src.F113=tgt.FrozenFromActivationInDays and src.F114=tgt.FreqLimitForAddressChange and src.F115=tgt.MaxNumberOfAddressChanges and src.F116=tgt.ApplNotConsideredForAddressVelocity and src.F117=tgt.ClearNegativeBalances and src.F118=tgt.LiabilityOnNegativeBalances and src.F119=tgt.MaxNegativeBalanceAutoCleared and src.F120=tgt.AccountStatusNotAutoCleared and src.F121=tgt.MaxNegativeBalanceManuallyCleared and src.F122=tgt.ClearNegativeBalancesAfterEventInDays and src.F123=tgt.DisputeResolutionServiceFlag and src.F124=tgt.DisputeProcessGuideLine and src.F125=tgt.TempCreditToApplyInDays and src.F126=tgt.TempCreditDisputeToApplyInDays and src.F127=tgt.DisputeLettersMailed and src.F128=tgt.SettleServiceAndMoneyMove and src.F129=tgt.CustomerServicePhoneNumber and src.F130=tgt.MinAutoChargeBackReviewInDays and src.F131=tgt.AccountWithPositiveBalance and src.F132=tgt.Statements and src.F133=tgt.OnlineStatements and src.F134=tgt.PaperStatements and src.F135=tgt.PrintBydefaultOrCHOption and src.F136=tgt.StatementCycle and src.F137=tgt.TransactionActivity and src.F138=tgt.BalanceGreaterThan and src.F139=tgt.BalanceLessThan and src.F140=tgt.AccountStatus and src.F141=tgt.StatementPaper and src.F142=tgt.StatementTemplate and src.F143=tgt.StatementFileFormat and src.F144=tgt.DirectAccessConfig and src.F145=tgt.DDASponsorBank and src.F146=tgt.RoutingTransitNumber and src.F147=tgt.BankPrefix and src.F148=tgt.Withdrawal and src.F149=tgt.ValueLoadDirectDepositLimitCheck and src.F150=tgt.CardStatusUpdate and src.F151=tgt.CardStatusToPFraud and src.F152=tgt.FAXNumber and src.F153=tgt.NameMatchForIRSTaxRefunds and src.F154=tgt.ACHTrialDepositVerificationConfig and src.F155=tgt.UserInputAttemptsPermitted and src.F156=tgt.ValidationInDays and src.F157=tgt.ACHAccountDisplay and src.F158=tgt.ValueLoadWaitPeriod and src.F159=tgt.NumberOfExternalBankAccounts and src.F160=tgt.ClientACHAccountDisplay and src.F161=tgt.EffectiveEntryDays and src.F162=tgt.Active and src.F163=tgt.ReturnCVV2 and src.F164=tgt.ReturnExpirationDate and src.F165=tgt.InstantConfigured and src.F166=tgt.StandardConfigured and src.F167=tgt.StandardWaitPeriodInDays and src.F168=tgt.PPDBNumber and src.F169=tgt.AccountToAccountTransferConfig and src.F170=tgt.SenderMaxNumberOfRecipients and src.F171=tgt.SenderLengthOfPeriod and src.F172=tgt.SenderMaxTransfersPerPeriod and src.F173=tgt.SenderMaxTransferAmountPerPeriod and src.F174=tgt.SenderTransfersInDays and src.F175=tgt.SenderMaxTransferAmountPerDay and src.F176=tgt.SenderMaxAmountPerTransaction and src.F177=tgt.SenderMinAmountPerTransaction and src.F178=tgt.SenderAllowFeeReversal and src.F179=tgt.SenderQualifiedStatus and src.F180=tgt.SenderDestinationClients and src.F181=tgt.SearchReceiverCriteria and src.F182=tgt.TieBreakerRules and src.F183=tgt.ReceiverLengthofPeriod and src.F184=tgt.ReceiverMaxNumberOfTransfersPerPeriod and src.F185=tgt.ReceiverMaxTransferAmountPerPeriod and src.F186=tgt.ReceiverMaxNumberofTransfersPerDay and src.F187=tgt.ReceiverMaxTransferAmountPerDay and src.F188=tgt.ReceiverMaxAmountPerTransaction and src.F189=tgt.ReceiverMinAmountPerTransaction and src.F190=tgt.ReceiverQualifiedStatus and src.F191=tgt.ReceiverDestinationClients and src.F192=tgt.BlockGamblingMerchantsMCC7995 and src.F193=tgt.BlockCashandQuasiCash and src.F194=tgt.OtherMCCsRestricted and src.F195=tgt.AdditionalProxyLength and src.F196=tgt.IVRSecondaryAuthMethod and src.F197=tgt.AutoRenewalOnValueLoad and src.F198=tgt.SetupRegionalNetworkMoneyTransfer and src.F199=tgt.DisputeFormTempCredit and src.F200=tgt.TokenizationAllowed and src.F201=tgt.IsACHFastPayEnabled and src.F202=tgt.SenderReversalDays and src.F203=tgt.ReceiverAllowFeeReversal and src.F204=tgt.ReceiverReversalDays and src.F205=tgt.IVROrMyAccountPINOptions and src.F206=tgt.RestrictAdjust and src.F207=tgt.FulfillmentRequestType and src.F208=tgt.StatementMessageContents and src.F209=tgt.StartDate and src.F210=tgt.EndDate and src.F211=tgt.DefaultPurseForDirectAccess and src.F212=tgt.Copay and src.F213=tgt.MCCGroupCopay and src.F214=tgt.FutureUse2 and src.F215=tgt.FutureUse3 and src.F216=tgt.PBM and src.F217=tgt.MCCGroupPayAndChase and src.F218=tgt.NetworkName and src.F219=tgt.PurseStatusAutoRenewal and src.F220=tgt.RandomPINCardGeneration)
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,SubProgramName,SubProgramActiveFlag,ProgramID,ProgramName,ClientID,ClientName,ClientAltValue,TemplateSubProgramID,FISAssumeFraudLiability,ProxyName,AKAName,PseudoBIN,MarketSegment,ProgramLevel,ProgramUseProxyNumbers,ProxyType,IVRAuthenticationMethod,CardType,ProgramType,PINBased,PINTries,NumberOfDaysPINLocked,RePlastic,AdvanceExpire,PrivacyOptOut,LoadSuspend,ApproveMissingTransaction,SkipExpiredClosedCardDDA,AreCardsReloadable,InitialCardStatus,ActiveMethod,HowWillCardsBeActivated,PhysicalExpirationMethod,PhysicalExpirationDate,PhysicalExpirationMonth,Logical,LogicalDynamic,LogicalExpireEvent,AutoRenewal,RenewalWindow,RenewalMonths,RenewalCardStatus,BalanceThreshold,FinancialActivityWindowInDays,PositiveFinancialActivityWindow,UtilizeReplacementPackage,AccountValueLimits,FixedValue,MinValue,MaxValue,MinLoadOnCard,MaxLoadonCard,ThirdLineEmbossing,ThirdLineEmbossStaticName,FourthLineEmbossing,FourthLineEmbossStaticName,EmbossOrPrintBeginDates,EmbossOrPrintExpireDates,EmbossOrPrintSecurityCode,SendPIN,PINMailerLag,PINMethod,CarrierSlotType,ReturnAddress1,ReturnAddress2,ReturnAddress3,ReturnAddress4,PrintLine1AccountNumber,PrintLine2ExpirationDate,PrintLine3CardholderName,PrintLine4,PrintProxy,PrintIndentCardNumber,PrintSecurityCodeOnIndent,IssueDuplicateCard,EmbossFullDate,SortBySequentialProxyNumber,PassCardHolderPhoneNumber,PassCardholderEmail,PassCardholderDARoutingInfo,PassCountry,PassOtherInformation,PassClientAltValue,ParsingRulesToAddress,ShipmentRecordsFlag,MagName,FulfillmentInstructions1,FulfillmentInstructions2,DiscretionaryData1,DiscretionaryData2,DiscretionaryData3,CardNumberEmbossingMask,SecondaryCardsFlag,NumberOfSecondaryCards,MaxActivationAttempts,AllowBillPayFunctionality,BlockBillingTransactionFlag,ValueLoaduponActivation,ExpiredCardConfig,RetailReloadNetworkServices,MoneyTransferSetupFlag,SetupMasterCardMoneySend,PFraudConfig,EnableOpenToBuyBalanceAtPOS,BlockCountry,UnblockCountry,IncludeCountry,VelocityLimitPeriodInDays,ValueLoadNumberPerPeriod,ValueLoadAmountPerPeriod,FrozenFromActivationInDays,FreqLimitForAddressChange,MaxNumberOfAddressChanges,ApplNotConsideredForAddressVelocity,ClearNegativeBalances,LiabilityOnNegativeBalances,MaxNegativeBalanceAutoCleared,AccountStatusNotAutoCleared,MaxNegativeBalanceManuallyCleared,ClearNegativeBalancesAfterEventInDays,DisputeResolutionServiceFlag,DisputeProcessGuideLine,TempCreditToApplyInDays,TempCreditDisputeToApplyInDays,DisputeLettersMailed,SettleServiceAndMoneyMove,CustomerServicePhoneNumber,MinAutoChargeBackReviewInDays,AccountWithPositiveBalance,Statements,OnlineStatements,PaperStatements,PrintBydefaultOrCHOption,StatementCycle,TransactionActivity,BalanceGreaterThan,BalanceLessThan,AccountStatus,StatementPaper,StatementTemplate,StatementFileFormat,DirectAccessConfig,DDASponsorBank,RoutingTransitNumber,BankPrefix,Withdrawal,ValueLoadDirectDepositLimitCheck,CardStatusUpdate,CardStatusToPFraud,FAXNumber,NameMatchForIRSTaxRefunds,ACHTrialDepositVerificationConfig,UserInputAttemptsPermitted,ValidationInDays,ACHAccountDisplay,ValueLoadWaitPeriod,NumberOfExternalBankAccounts,ClientACHAccountDisplay,EffectiveEntryDays,Active,ReturnCVV2,ReturnExpirationDate,InstantConfigured,StandardConfigured,StandardWaitPeriodInDays,PPDBNumber,AccountToAccountTransferConfig,SenderMaxNumberOfRecipients,SenderLengthOfPeriod,SenderMaxTransfersPerPeriod,SenderMaxTransferAmountPerPeriod,SenderTransfersInDays,SenderMaxTransferAmountPerDay,SenderMaxAmountPerTransaction,SenderMinAmountPerTransaction,SenderAllowFeeReversal,SenderQualifiedStatus,SenderDestinationClients,SearchReceiverCriteria,TieBreakerRules,ReceiverLengthofPeriod,ReceiverMaxNumberOfTransfersPerPeriod,ReceiverMaxTransferAmountPerPeriod,ReceiverMaxNumberofTransfersPerDay,ReceiverMaxTransferAmountPerDay,ReceiverMaxAmountPerTransaction,ReceiverMinAmountPerTransaction,ReceiverQualifiedStatus,ReceiverDestinationClients,BlockGamblingMerchantsMCC7995,BlockCashandQuasiCash,OtherMCCsRestricted,AdditionalProxyLength,IVRSecondaryAuthMethod,AutoRenewalOnValueLoad,SetupRegionalNetworkMoneyTransfer,DisputeFormTempCredit,TokenizationAllowed,IsACHFastPayEnabled,SenderReversalDays,ReceiverAllowFeeReversal,ReceiverReversalDays,IVROrMyAccountPINOptions,RestrictAdjust,FulfillmentRequestType,StatementMessageContents,StartDate,EndDate,DefaultPurseForDirectAccess,Copay,MCCGroupCopay,FutureUse2,FutureUse3,PBM,MCCGroupPayAndChase,NetworkName,PurseStatusAutoRenewal,RandomPINCardGeneration,[FileName]	)
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName]
) ; 

/* -- DSPG
F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,F21,F22,F23,F24,F25,F26,F27,F28,F29,F30,F31,F32,F33,F34,F35,F36,F37,F38,F39,F40,F41,F42,F43,F44,F45,F46,F47,F48,F49,F50,F51,F52,F53,F54,F55,F56,F57,F58,F59,F60,F61,F62,F63,F64,F65,F66,F67,F68,F69,F70,F71,F72,F73,F74,F75,F76,F77,F78,F79,F80,F81,F82,F83,F84,F85,F86,F87,F88,F89,F90,F91,F92,F93,F94,F95,F96,F97,F98,F99,F100,F101,F102,F103,F104,F105,F106,F107,F108,F109,F110,F111,F112,F113,F114,F115,F116,F117,F118,F119,F120,F121,F122,F123,F124,F125,F126,F127,F128,F129,F130,F131,F132,F133,F134,F135,F136,F137,F138,F139,F140,F141,F142,F143,F144,F145,F146,F147,F148,F149,F150,F151,F152,F153,F154,F155,F156,F157,F158,F159,F160,F161,F162,F163,F164,F165,F166,F167,F168,F169,F170,F171,F172,F173,F174,F175,F176,F177,F178,F179,F180,F181,F182,F183,F184,F185,F186,F187,F188,F189,F190,F191,F192,F193,F194,F195,F196,F197,F198,F199,F200,F201,F202,F203,F204,F205,F206,F207,F208,F209,F210,F211,F212,F213,F214,F215,F216,F217,F218,F219,F220, [FileName]
RecordType,SubProgramID,SubProgramName,SubProgramActiveFlag,ProgramID,ProgramName,ClientID,ClientName,ClientAltValue,TemplateSubProgramID,FISAssumeFraudLiability,ProxyName,AKAName,PseudoBIN,MarketSegment,ProgramLevel,ProgramUseProxyNumbers,ProxyType,IVRAuthenticationMethod,CardType,ProgramType,PINBased,PINTries,NumberOfDaysPINLocked,RePlastic,AdvanceExpire,PrivacyOptOut,LoadSuspend,ApproveMissingTransaction,SkipExpiredClosedCardDDA,AreCardsReloadable,InitialCardStatus,ActiveMethod,HowWillCardsBeActivated,PhysicalExpirationMethod,PhysicalExpirationDate,PhysicalExpirationMonth,Logical,LogicalDynamic,LogicalExpireEvent,AutoRenewal,RenewalWindow,RenewalMonths,RenewalCardStatus,BalanceThreshold,FinancialActivityWindowInDays,PositiveFinancialActivityWindow,UtilizeReplacementPackage,AccountValueLimits,FixedValue,MinValue,MaxValue,MinLoadOnCard,MaxLoadonCard,ThirdLineEmbossing,ThirdLineEmbossStaticName,FourthLineEmbossing,FourthLineEmbossStaticName,EmbossOrPrintBeginDates,EmbossOrPrintExpireDates,EmbossOrPrintSecurityCode,SendPIN,PINMailerLag,PINMethod,CarrierSlotType,ReturnAddress1,ReturnAddress2,ReturnAddress3,ReturnAddress4,PrintLine1AccountNumber,PrintLine2ExpirationDate,PrintLine3CardholderName,PrintLine4,PrintProxy,PrintIndentCardNumber,PrintSecurityCodeOnIndent,IssueDuplicateCard,EmbossFullDate,SortBySequentialProxyNumber,PassCardHolderPhoneNumber,PassCardholderEmail,PassCardholderDARoutingInfo,PassCountry,PassOtherInformation,PassClientAltValue,ParsingRulesToAddress,ShipmentRecordsFlag,MagName,FulfillmentInstructions1,FulfillmentInstructions2,DiscretionaryData1,DiscretionaryData2,DiscretionaryData3,CardNumberEmbossingMask,SecondaryCardsFlag,NumberOfSecondaryCards,MaxActivationAttempts,AllowBillPayFunctionality,BlockBillingTransactionFlag,ValueLoaduponActivation,ExpiredCardConfig,RetailReloadNetworkServices,MoneyTransferSetupFlag,SetupMasterCardMoneySend,PFraudConfig,EnableOpenToBuyBalanceAtPOS,BlockCountry,UnblockCountry,IncludeCountry,VelocityLimitPeriodInDays,ValueLoadNumberPerPeriod,ValueLoadAmountPerPeriod,FrozenFromActivationInDays,FreqLimitForAddressChange,MaxNumberOfAddressChanges,ApplNotConsideredForAddressVelocity,ClearNegativeBalances,LiabilityOnNegativeBalances,MaxNegativeBalanceAutoCleared,AccountStatusNotAutoCleared,MaxNegativeBalanceManuallyCleared,ClearNegativeBalancesAfterEventInDays,DisputeResolutionServiceFlag,DisputeProcessGuideLine,TempCreditToApplyInDays,TempCreditDisputeToApplyInDays,DisputeLettersMailed,SettleServiceAndMoneyMove,CustomerServicePhoneNumber,MinAutoChargeBackReviewInDays,AccountWithPositiveBalance,Statements,OnlineStatements,PaperStatements,PrintBydefaultOrCHOption,StatementCycle,TransactionActivity,BalanceGreaterThan,BalanceLessThan,AccountStatus,StatementPaper,StatementTemplate,StatementFileFormat,DirectAccessConfig,DDASponsorBank,RoutingTransitNumber,BankPrefix,Withdrawal,ValueLoadDirectDepositLimitCheck,CardStatusUpdate,CardStatusToPFraud,FAXNumber,NameMatchForIRSTaxRefunds,ACHTrialDepositVerificationConfig,UserInputAttemptsPermitted,ValidationInDays,ACHAccountDisplay,ValueLoadWaitPeriod,NumberOfExternalBankAccounts,ClientACHAccountDisplay,EffectiveEntryDays,Active,ReturnCVV2,ReturnExpirationDate,InstantConfigured,StandardConfigured,StandardWaitPeriodInDays,PPDBNumber,AccountToAccountTransferConfig,SenderMaxNumberOfRecipients,SenderLengthOffPeriod,SenderMaxTransfersPerPeriod,SenderMaxTransferAmountPerPeriod,SenderTransfersInDays,SenderMaxTransferAmountPerDay,SenderMaxAmountPerTransaction,SenderMinAmountPerTransaction,SenderAllowFeeReversal,SenderQualifiedStatus,SenderDestinationClients,SearchReceiverCriteria,TieBreakerRules,ReceiverLengthofPeriod,ReceiverMaxNumberOfTransfersPerPeriod,ReceiverMaxTransferAmountPerPeriod,ReceiverMaxNumberofTransfersPerDay,ReceiverMaxTransferAmountPerDay,ReceiverMaxAmountPerTransaction,ReceiverMinAmountPerTransaction,ReceiverQualifiedStatus,ReceiverDestinationClients,BlockGamblingMerchantsMCC7995,BlockCashandQuasiCash,OtherMCCsRestricted,AdditionalProxyLength,IVRSecondaryAuthMethod,AutoRenewalOnValueLoad,SetupRegionalNetworkMoneyTransfer,DisputeFormTempCredit,TokenizationAllowed,IsACHFastPayEnabled,SenderReversalDays,ReceiverAllowFeeReversal,ReceiverReversalDays,IVROrMyAccountPINOptions,RestrictAdjust,FulfillmentRequestType,StatementMessageContents,StartDate,EndDate,DefaultPurseForDirectAccess,Copay,MCCGroupCopay,FutureUse2,FutureUse3,PBM,MCCGroupPayAndChase,NetworkName,PurseStatusAutoRenewal,RandomPINCardGeneration,[FileName],
(src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.SubProgramName and src.F4=tgt.SubProgramActiveFlag and src.F5=tgt.ProgramID and src.F6=tgt.ProgramName and src.F7=tgt.ClientID and src.F8=tgt.ClientName and src.F9=tgt.ClientAltValue and src.F10=tgt.TemplateSubProgramID and src.F11=tgt.FISAssumeFraudLiability and src.F12=tgt.ProxyName and src.F13=tgt.AKAName and src.F14=tgt.PseudoBIN and src.F15=tgt.MarketSegment and src.F16=tgt.ProgramLevel and src.F17=tgt.ProgramUseProxyNumbers and src.F18=tgt.ProxyType and src.F19=tgt.IVRAuthenticationMethod and src.F20=tgt.CardType and src.F21=tgt.ProgramType and src.F22=tgt.PINBased and src.F23=tgt.PINTries and src.F24=tgt.NumberOfDaysPINLocked and src.F25=tgt.RePlastic and src.F26=tgt.AdvanceExpire and src.F27=tgt.PrivacyOptOut and src.F28=tgt.LoadSuspend and src.F29=tgt.ApproveMissingTransaction and src.F30=tgt.SkipExpiredClosedCardDDA and src.F31=tgt.AreCardsReloadable and src.F32=tgt.InitialCardStatus and src.F33=tgt.ActiveMethod and src.F34=tgt.HowWillCardsBeActivated and src.F35=tgt.PhysicalExpirationMethod and src.F36=tgt.PhysicalExpirationDate and src.F37=tgt.PhysicalExpirationMonth and src.F38=tgt.Logical and src.F39=tgt.LogicalDynamic and src.F40=tgt.LogicalExpireEvent and src.F41=tgt.AutoRenewal and src.F42=tgt.RenewalWindow and src.F43=tgt.RenewalMonths and src.F44=tgt.RenewalCardStatus and src.F45=tgt.BalanceThreshold and src.F46=tgt.FinancialActivityWindowInDays and src.F47=tgt.PositiveFinancialActivityWindow and src.F48=tgt.UtilizeReplacementPackage and src.F49=tgt.AccountValueLimits and src.F50=tgt.FixedValue and src.F51=tgt.MinValue and src.F52=tgt.MaxValue and src.F53=tgt.MinLoadOnCard and src.F54=tgt.MaxLoadonCard and src.F55=tgt.ThirdLineEmbossing and src.F56=tgt.ThirdLineEmbossStaticName and src.F57=tgt.FourthLineEmbossing and src.F58=tgt.FourthLineEmbossStaticName and src.F59=tgt.EmbossOrPrintBeginDates and src.F60=tgt.EmbossOrPrintExpireDates and src.F61=tgt.EmbossOrPrintSecurityCode and src.F62=tgt.SendPIN and src.F63=tgt.PINMailerLag and src.F64=tgt.PINMethod and src.F65=tgt.CarrierSlotType and src.F66=tgt.ReturnAddress1 and src.F67=tgt.ReturnAddress2 and src.F68=tgt.ReturnAddress3 and src.F69=tgt.ReturnAddress4 and src.F70=tgt.PrintLine1AccountNumber and src.F71=tgt.PrintLine2ExpirationDate and src.F72=tgt.PrintLine3CardholderName and src.F73=tgt.PrintLine4 and src.F74=tgt.PrintProxy and src.F75=tgt.PrintIndentCardNumber and src.F76=tgt.PrintSecurityCodeOnIndent and src.F77=tgt.IssueDuplicateCard and src.F78=tgt.EmbossFullDate and src.F79=tgt.SortBySequentialProxyNumber and src.F80=tgt.PassCardHolderPhoneNumber and src.F81=tgt.PassCardholderEmail and src.F82=tgt.PassCardholderDARoutingInfo and src.F83=tgt.PassCountry and src.F84=tgt.PassOtherInformation and src.F85=tgt.PassClientAltValue and src.F86=tgt.ParsingRulesToAddress and src.F87=tgt.ShipmentRecordsFlag and src.F88=tgt.MagName and src.F89=tgt.FulfillmentInstructions1 and src.F90=tgt.FulfillmentInstructions2 and src.F91=tgt.DiscretionaryData1 and src.F92=tgt.DiscretionaryData2 and src.F93=tgt.DiscretionaryData3 and src.F94=tgt.CardNumberEmbossingMask and src.F95=tgt.SecondaryCardsFlag and src.F96=tgt.NumberOfSecondaryCards and src.F97=tgt.MaxActivationAttempts and src.F98=tgt.AllowBillPayFunctionality and src.F99=tgt.BlockBillingTransactionFlag and src.F100=tgt.ValueLoaduponActivation and src.F101=tgt.ExpiredCardConfig and src.F102=tgt.RetailReloadNetworkServices and src.F103=tgt.MoneyTransferSetupFlag and src.F104=tgt.SetupMasterCardMoneySend and src.F105=tgt.PFraudConfig and src.F106=tgt.EnableOpenToBuyBalanceAtPOS and src.F107=tgt.BlockCountry and src.F108=tgt.UnblockCountry and src.F109=tgt.IncludeCountry and src.F110=tgt.VelocityLimitPeriodInDays and src.F111=tgt.ValueLoadNumberPerPeriod and src.F112=tgt.ValueLoadAmountPerPeriod and src.F113=tgt.FrozenFromActivationInDays and src.F114=tgt.FreqLimitForAddressChange and src.F115=tgt.MaxNumberOfAddressChanges and src.F116=tgt.ApplNotConsideredForAddressVelocity and src.F117=tgt.ClearNegativeBalances and src.F118=tgt.LiabilityOnNegativeBalances and src.F119=tgt.MaxNegativeBalanceAutoCleared and src.F120=tgt.AccountStatusNotAutoCleared and src.F121=tgt.MaxNegativeBalanceManuallyCleared and src.F122=tgt.ClearNegativeBalancesAfterEventInDays and src.F123=tgt.DisputeResolutionServiceFlag and src.F124=tgt.DisputeProcessGuideLine and src.F125=tgt.TempCreditToApplyInDays and src.F126=tgt.TempCreditDisputeToApplyInDays and src.F127=tgt.DisputeLettersMailed and src.F128=tgt.SettleServiceAndMoneyMove and src.F129=tgt.CustomerServicePhoneNumber and src.F130=tgt.MinAutoChargeBackReviewInDays and src.F131=tgt.AccountWithPositiveBalance and src.F132=tgt.Statements and src.F133=tgt.OnlineStatements and src.F134=tgt.PaperStatements and src.F135=tgt.PrintBydefaultOrCHOption and src.F136=tgt.StatementCycle and src.F137=tgt.TransactionActivity and src.F138=tgt.BalanceGreaterThan and src.F139=tgt.BalanceLessThan and src.F140=tgt.AccountStatus and src.F141=tgt.StatementPaper and src.F142=tgt.StatementTemplate and src.F143=tgt.StatementFileFormat and src.F144=tgt.DirectAccessConfig and src.F145=tgt.DDASponsorBank and src.F146=tgt.RoutingTransitNumber and src.F147=tgt.BankPrefix and src.F148=tgt.Withdrawal and src.F149=tgt.ValueLoadDirectDepositLimitCheck and src.F150=tgt.CardStatusUpdate and src.F151=tgt.CardStatusToPFraud and src.F152=tgt.FAXNumber and src.F153=tgt.NameMatchForIRSTaxRefunds and src.F154=tgt.ACHTrialDepositVerificationConfig and src.F155=tgt.UserInputAttemptsPermitted and src.F156=tgt.ValidationInDays and src.F157=tgt.ACHAccountDisplay and src.F158=tgt.ValueLoadWaitPeriod and src.F159=tgt.NumberOfExternalBankAccounts and src.F160=tgt.ClientACHAccountDisplay and src.F161=tgt.EffectiveEntryDays and src.F162=tgt.Active and src.F163=tgt.ReturnCVV2 and src.F164=tgt.ReturnExpirationDate and src.F165=tgt.InstantConfigured and src.F166=tgt.StandardConfigured and src.F167=tgt.StandardWaitPeriodInDays and src.F168=tgt.PPDBNumber and src.F169=tgt.AccountToAccountTransferConfig and src.F170=tgt.SenderMaxNumberOfRecipients and src.F171=tgt.SenderLengthOfPeriod and src.F172=tgt.SenderMaxTransfersPerPeriod and src.F173=tgt.SenderMaxTransferAmountPerPeriod and src.F174=tgt.SenderTransfersInDays and src.F175=tgt.SenderMaxTransferAmountPerDay and src.F176=tgt.SenderMaxAmountPerTransaction and src.F177=tgt.SenderMinAmountPerTransaction and src.F178=tgt.SenderAllowFeeReversal and src.F179=tgt.SenderQualifiedStatus and src.F180=tgt.SenderDestinationClients and src.F181=tgt.SearchReceiverCriteria and src.F182=tgt.TieBreakerRules and src.F183=tgt.ReceiverLengthofPeriod and src.F184=tgt.ReceiverMaxNumberOfTransfersPerPeriod and src.F185=tgt.ReceiverMaxTransferAmountPerPeriod and src.F186=tgt.ReceiverMaxNumberofTransfersPerDay and src.F187=tgt.ReceiverMaxTransferAmountPerDay and src.F188=tgt.ReceiverMaxAmountPerTransaction and src.F189=tgt.ReceiverMinAmountPerTransaction and src.F190=tgt.ReceiverQualifiedStatus and src.F191=tgt.ReceiverDestinationClients and src.F192=tgt.BlockGamblingMerchantsMCC7995 and src.F193=tgt.BlockCashandQuasiCash and src.F194=tgt.OtherMCCsRestricted and src.F195=tgt.AdditionalProxyLength and src.F196=tgt.IVRSecondaryAuthMethod and src.F197=tgt.AutoRenewalOnValueLoad and src.F198=tgt.SetupRegionalNetworkMoneyTransfer and src.F199=tgt.DisputeFormTempCredit and src.F200=tgt.TokenizationAllowed and src.F201=tgt.IsACHFastPayEnabled and src.F202=tgt.SenderReversalDays and src.F203=tgt.ReceiverAllowFeeReversal and src.F204=tgt.ReceiverReversalDays and src.F205=tgt.IVROrMyAccountPINOptions and src.F206=tgt.RestrictAdjust and src.F207=tgt.FulfillmentRequestType and src.F208=tgt.StatementMessageContents and src.F209=tgt.StartDate and src.F210=tgt.EndDate and src.F211=tgt.DefaultPurseForDirectAccess and src.F212=tgt.Copay and src.F213=tgt.MCCGroupCopay and src.F214=tgt.FutureUse2 and src.F215=tgt.FutureUse3 and src.F216=tgt.PBM and src.F217=tgt.MCCGroupPayAndChase and src.F218=tgt.NetworkName and src.F219=tgt.PurseStatusAutoRenewal and src.F220=tgt.RandomPINCardGeneration)
*/


MERGE [dbo].[FISCCX_DIIA] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DIIA' and IsActive = 1 ) as src 
    ON (src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PurseID and src.F4=tgt.IIAS and src.F5=tgt.IIASDesc and src.F6=tgt.IIASGroupID and src.F7=tgt.IIASGroupDesc and src.F8=tgt.Priority and src.F9=tgt.IsDeleted and src.F10=tgt.IIASGroupPriority and src.[FileName]=tgt.[FileName] )
	 --WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,PurseID,IIAS,IIASDesc,IIASGroupID,IIASGroupDesc,[Priority],IsDeleted,IIASGroupPriority,[FileName])	
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,[FileName]) ; 

/*
RecordType,SubProgramID,PurseID,IIAS,IIASDesc,IIASGroupID,IIASGroupDesc,Priority,IsDeleted,IIASGroupPriority,[FileName]		
src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PurseID and src.F4=tgt.IIAS and src.F5=tgt.IIASDesc and src.F6=tgt.IIASGroupID and src.F7=tgt.IIASGroupDesc and src.F8=tgt.Priority and src.F9=tgt.IsDeleted and src.F10=tgt.IIASGroupPriority and src.[FileName]=tgt.[FileName] and 
*/

MERGE [dbo].[FISCCX_DPKG] AS tgt  
USING (SELECT ID as STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName] from [dbo].[FISCCXStg] where ltrim(rtrim(F1)) = 'DPKG' and IsActive = 1 ) as src 
	  ON (src.[FileName]=tgt.[FileName] and src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PackageID and src.F4=tgt.PackageName and src.F5=tgt.ArtworkName and src.F6=tgt.BIN and src.F7=tgt.PrinAndAgentRange and src.F8=tgt.FulfillmentHouse and src.F9=tgt.CardCountThreshold and src.F10=tgt.CardIssuedSequentFlag and src.F11=tgt.BarcodeType and src.F12=tgt.FormFactor and src.F13=tgt.ReplacementPackageID and src.F14=tgt.DuplicateSettlementAwaitInDays and src.F15=tgt.AuthAwaitSettlementInDays and src.F16=tgt.EncodingMethod and src.F17=tgt.PartialAuth and src.F18=tgt.IsDeleted and src.F19=tgt.ImmediateCredit and src.F20=tgt.ApprovedProductList )
	--WHEN MATCHED THEN
        --UPDATE SET Name = src.Name  
    WHEN NOT MATCHED THEN  
			INSERT (STGID,RecordType,SubProgramID,PackageID,PackageName,ArtworkName,BIN,PrinAndAgentRange,FulfillmentHouse,CardCountThreshold,CardIssuedSequentFlag,BarcodeType,FormFactor,ReplacementPackageID,DuplicateSettlementAwaitInDays,AuthAwaitSettlementInDays,EncodingMethod,PartialAuth,IsDeleted,ImmediateCredit,ApprovedProductList,[FileName])	
			VALUES (STGID,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,F18,F19,F20,[FileName]);

/*
RecordType,SubProgramID,PackageID,PackageName,ArtworkName,BIN,PrinAndAgentRange,FulfillmentHouse,CardCountThreshold,CardIssuedSequentFlag,BarcodeType,FormFactor,ReplacementPackageID,DuplicateSettlementAwaitInDays,AuthAwaitSettlementInDays,EncodingMethod,PartialAuth,IsDeleted,ImmediateCredit,ApprovedProductList,[FileName],
src.F1=tgt.RecordType and src.F2=tgt.SubProgramID and src.F3=tgt.PackageID and src.F4=tgt.PackageName and src.F5=tgt.ArtworkName and src.F6=tgt.BIN and src.F7=tgt.PrinAndAgentRange and src.F8=tgt.FulfillmentHouse and src.F9=tgt.CardCountThreshold and src.F10=tgt.CardIssuedSequentFlag and src.F11=tgt.BarcodeType and src.F12=tgt.FormFactor and src.F13=tgt.ReplacementPackageID and src.F14=tgt.DuplicateSettlementAwaitInDays and src.F15=tgt.AuthAwaitSettlementInDays and src.F16=tgt.EncodingMethod and src.F17=tgt.PartialAuth and src.F18=tgt.IsDeleted and src.F19=tgt.ImmediateCredit and src.F20=tgt.ApprovedProductList and src.[FileName]=tgt.[FileName] and 
*/
COMMIT TRANSACTION FISCCX_Transaction
PRINT 'Success'

END TRY

	BEGIN CATCH
	DECLARE @ErrorMessage NVARCHAR(4000);  
    DECLARE @ErrorSeverity INT;  
    DECLARE @ErrorState INT;  

    SELECT   
        @ErrorMessage = ERROR_MESSAGE(),  
        @ErrorSeverity = ERROR_SEVERITY(),  
        @ErrorState = ERROR_STATE();  
	
		IF (@@TRANCOUNT > 0)
		BEGIN
			ROLLBACK TRANSACTION FISCCX_Transaction
			RAISERROR(@ErrorMessage,@ErrorSeverity,@ErrorState);
			PRINT 'FAILED'
		END

	END CATCH
END



GO



select * from (
select distinct  'select top 10 ' +' '+ ('''['+ table_schema +']'+ '.' +'['+ replace(replace(replace(table_name,' ','_'),'-','_'),'.','_') +']'' as TableName_'+  table_schema + '_' + replace(replace(replace(table_name,' ','_'),'-','_'),'.','_') +','  )  +  STRING_AGG(CONVERT(NVARCHAR(max), ('['+column_name+']')),',') + ' from ' + '['+ table_schema +']'+ '.' +'['+ table_name +']' AS selectList from information_schema.columns
where table_name in ( select distinct table_name from information_schema.columns) and table_name in ((select top 100 name from sys.tables order by create_date desc) )
group by table_schema, table_name
) a





USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[parseJSON_Original]    Script Date: 6/26/2024 12:47:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[parseJSON_Original]( @JSON NVARCHAR(MAX))
/**
Summary: >
  The code for the JSON Parser/Shredder will run in SQL Server 2005, 
  and even in SQL Server 2000 (with some modifications required).
 
  First the function replaces all strings with tokens of the form @Stringxx,
  where xx is the foreign key of the table variable where the strings are held.
  This takes them, and their potentially difficult embedded brackets, out of 
  the way. Names are  always strings in JSON as well as  string values.
 
  Then, the routine iteratively finds the next structure that has no structure 
  Contained within it, (and is, by definition the leaf structure), and parses it,
  replacing it with an object token of the form ‘@Objectxxx‘, or ‘@arrayxxx‘, 
  where xxx is the object id assigned to it. The values, or name/value pairs 
  are retrieved from the string table and stored in the hierarchy table. G
  radually, the JSON document is eaten until there is just a single root
  object left.
Why: case-insensitive version
Example: >
  Select * from parseJSON('{    "Person": 
      {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
           {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
           },
       "PhoneNumbers": 
           {
           "home":"212 555-1234",
          "fax":"646 555-4567"
           }
        }
     }
  ')
Returns: >
  nothing
**/
	RETURNS @hierarchy TABLE
	  (
	   Element_ID INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   SequenceNo [int] NULL, /* the place in the sequence for the element */
	   Parent_ID INT null, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT null, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   Name NVARCHAR(2000) NULL, /* the Name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	  /*
 
	   */
	AS
	BEGIN
	  DECLARE
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @Name NVARCHAR(200), --the Name as a string
	    @Parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the Names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
	    @Parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)='"' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --either the end or no end delimiter to last string
	        BEGIN-- check if ending with a double slash...
             SET @end=PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
 		     IF @end=0 --we really have reached the end 
				BEGIN
				BREAK --assume all tokens found
				END
			END 
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FromString, ToString)
	      FROM
	        (SELECT           '\b', CHAR(08)
	         UNION ALL SELECT '\f', CHAR(12)
	         UNION ALL SELECT '\n', CHAR(10)
	         UNION ALL SELECT '\r', CHAR(13)
	         UNION ALL SELECT '\t', CHAR(09)
			 UNION ALL SELECT '\"', '"'
	         UNION ALL SELECT '\/', '/'
	        ) substitutions(FromString, ToString)
		SELECT @token=Replace(@token, '\\', '\')
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    '@string'+CONVERT(NCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @Parent_ID=@Parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)='{') 
	    SELECT @NextCloseDelimiterChar='}', @type='object'
	  ELSE 
	    SELECT @NextCloseDelimiterChar=']', @type='array'
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+'|')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{' 
	        SELECT @NextCloseDelimiterChar='}', @type='object'
	      ELSE 
	        SELECT @NextCloseDelimiterChar=']', @type='array'
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or Name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                '@'+@type+CONVERT(NCHAR(5), @Parent_ID))
	  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type='object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based Name.
	          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
              SELECT @token=RTrim(Substring(' '+@contents, @start+1, @End-@Start-1)),
	            @endofName=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofName+1)
	          SELECT
	            @token=LEFT(@token, @endofName-1),
	            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
	          SELECT  @Name=StringValue FROM @strings
	            WHERE string_id=@param --fetch the Name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
                IF @end=0
	        --HR Engineering notation bugfix start
	          IF ISNUMERIC(@contents) = 1
		    SELECT @end = LEN(@contents) + 1
	          Else
	        --HR Engineering notation bugfix end 
		  SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents+' ' collate SQL_Latin1_General_CP850_Bin) + 1
	       SELECT
	        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+'|'), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
	      IF SUBSTRING(@value, 1, 7)='@object' 
	        INSERT INTO @hierarchy
	          (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), 'object' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)='@array' 
	          INSERT INTO @hierarchy
	            (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	            SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), 'array' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)='@string' 
	            INSERT INTO @hierarchy
	              (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	              SELECT @Name, @SequenceNo, @Parent_ID, StringValue, 'string'
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN ('true', 'false') 
	              INSERT INTO @hierarchy
	                (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                SELECT @Name, @SequenceNo, @Parent_ID, @value, 'boolean'
	            ELSE
	              IF @value='null' 
	                INSERT INTO @hierarchy
	                  (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                  SELECT @Name, @SequenceNo, @Parent_ID, @value, 'null'
	              ELSE
	                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'real'
	                ELSE
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'int'
	      if @Contents=' ' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	  SELECT '-',1, NULL, '', @Parent_ID-1, @type
	--
	   RETURN
	END
GO




USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[parseJSON_Modified]    Script Date: 6/26/2024 12:47:11 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[parseJSON_Modified]( @JSON NVARCHAR(MAX), @InsuranceCarrierID int, @InsuranceHealthPlanID int, @ConfigType nvarchar(max))

/*

Santhosh Balla modified this procedure to be used at Nations Benefits to parse JSON, on the table InsuranceConfig
select  'Select * from parseJSON_Modified(' + ''''+ replace(configData, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(InsuranceHealthPlanID, 999) as nvarchar) + ','+ ''''+ConfigType+''''+')' + ' Union ALL ' from [insurance].[InsuranceConfig] where ConfigData is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(configData, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(InsuranceHealthPlanID, 999) as nvarchar) + ','+ ''''+ConfigType+''''+')' + ' Union ALL ' from [insurance].[InsuranceConfig] where ConfigData is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(CarrierConfig, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(NULL, 999) as nvarchar) + ','+ ''''+CarrierConfig+''''+')' + ' Union ALL ' from [insurance].[InsuranceCarriers] where CarrierConfig is not null
select  'Select * from parseJSON_Modified(' + ''''+ replace(OldCarrierConfig, '''', '`') + ''''+ ',' + cast(InsuranceCarrierID as nvarchar) + ',' + cast(isnull(NULL, 999) as nvarchar) + ','+ ''''+OldCarrierConfig+''''+')' + ' Union ALL ' from [insurance].[InsuranceCarriers] where OldCarrierConfig is not null and OldCarrierConfig <> ''

*/



/**
Summary: >
  The code for the JSON Parser/Shredder will run in SQL Server 2005, 
  and even in SQL Server 2000 (with some modifications required).
 
  First the function replaces all strings with tokens of the form @Stringxx,
  where xx is the foreign key of the table variable where the strings are held.
  This takes them, and their potentially difficult embedded brackets, out of 
  the way. Names are  always strings in JSON as well as  string values.
 
  Then, the routine iteratively finds the next structure that has no structure 
  Contained within it, (and is, by definition the leaf structure), and parses it,
  replacing it with an object token of the form ‘@Objectxxx‘, or ‘@arrayxxx‘, 
  where xxx is the object id assigned to it. The values, or name/value pairs 
  are retrieved from the string table and stored in the hierarchy table. G
  radually, the JSON document is eaten until there is just a single root
  object left.
Why: case-insensitive version
Example: >
  Select * from parseJSON('{    "Person": 
      {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
           {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
           },
       "PhoneNumbers": 
           {
           "home":"212 555-1234",
          "fax":"646 555-4567"
           }
        }
     }
  ')
Returns: >
  nothing
**/
	RETURNS @hierarchy TABLE
	  (
	   InsuranceCarrierID int null,
	   InsuranceHealthPlanID int null,
	   ConfigType nvarchar(max),
	   Element_ID INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   SequenceNo [int] NULL, /* the place in the sequence for the element */
	   Parent_ID INT null, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT null, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   Name NVARCHAR(2000) NULL, /* the Name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	  /*
 
	   */
	AS
	BEGIN
	  DECLARE
	  	@vInsuranceCarrierID int,   -- By Santhosh Balla
		@vInsuranceHealthPlanID int,   -- By Santhosh Balla
		@vConfigType nvarchar(max), --  By Santhosh Balla
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @Name NVARCHAR(200), --the Name as a string
	    @Parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character

		set @vInsuranceCarrierID = @InsuranceCarrierID
		set @vInsuranceHealthPlanID = @InsuranceHealthPlanID
		set @vConfigType = @ConfigType
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the Names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
	    @Parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)='"' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --either the end or no end delimiter to last string
	        BEGIN-- check if ending with a double slash...
             SET @end=PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
 		     IF @end=0 --we really have reached the end 
				BEGIN
				BREAK --assume all tokens found
				END
			END 
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FromString, ToString)
	      FROM
	        (SELECT           '\b', CHAR(08)
	         UNION ALL SELECT '\f', CHAR(12)
	         UNION ALL SELECT '\n', CHAR(10)
	         UNION ALL SELECT '\r', CHAR(13)
	         UNION ALL SELECT '\t', CHAR(09)
			 UNION ALL SELECT '\"', '"'
	         UNION ALL SELECT '\/', '/'
	        ) substitutions(FromString, ToString)
		SELECT @token=Replace(@token, '\\', '\')
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    '@string'+CONVERT(NCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @Parent_ID=@Parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)='{') 
	    SELECT @NextCloseDelimiterChar='}', @type='object'
	  ELSE 
	    SELECT @NextCloseDelimiterChar=']', @type='array'
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+'|')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{' 
	        SELECT @NextCloseDelimiterChar='}', @type='object'
	      ELSE 
	        SELECT @NextCloseDelimiterChar=']', @type='array'
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or Name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                '@'+@type+CONVERT(NCHAR(5), @Parent_ID))
	  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type='object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based Name.
	          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
              SELECT @token=RTrim(Substring(' '+@contents, @start+1, @End-@Start-1)),
	            @endofName=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofName+1)
	          SELECT
	            @token=LEFT(@token, @endofName-1),
	            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
	          SELECT  @Name=StringValue FROM @strings
	            WHERE string_id=@param --fetch the Name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
                IF @end=0
	        --HR Engineering notation bugfix start
	          IF ISNUMERIC(@contents) = 1
		    SELECT @end = LEN(@contents) + 1
	          Else
	        --HR Engineering notation bugfix end 
		  SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents+' ' collate SQL_Latin1_General_CP850_Bin) + 1
	       SELECT
	        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+'|'), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
	      IF SUBSTRING(@value, 1, 7)='@object' 
	        INSERT INTO @hierarchy
	          (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), 'object' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)='@array' 
	          INSERT INTO @hierarchy
	              (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	            SELECT  @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), 'array' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)='@string' 
	            INSERT INTO @hierarchy
	              (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	              SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, StringValue, 'string'
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN ('true', 'false') 
	              INSERT INTO @hierarchy
	                (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, @value, 'boolean'
	            ELSE
	              IF @value='null' 
	                INSERT INTO @hierarchy
	                  (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType,Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                  SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,@Name, @SequenceNo, @Parent_ID, @value, 'null'
	              ELSE
	                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, @value, 'real'
	                ELSE
	                  INSERT INTO @hierarchy
	                    (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType, @Name, @SequenceNo, @Parent_ID, @value, 'int'
	      if @Contents=' ' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	  SELECT @vInsuranceCarrierID, @vInsuranceHealthPlanID, @vConfigType,'-',1, NULL, '', @Parent_ID-1, @type
	--
	   RETURN
	END
GO




USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[parseJSON]    Script Date: 6/26/2024 12:47:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create FUNCTION [dbo].[parseJSON]( @JSON NVARCHAR(MAX))
/**
Summary: >
  The code for the JSON Parser/Shredder will run in SQL Server 2005, 
  and even in SQL Server 2000 (with some modifications required).
 
  First the function replaces all strings with tokens of the form @Stringxx,
  where xx is the foreign key of the table variable where the strings are held.
  This takes them, and their potentially difficult embedded brackets, out of 
  the way. Names are  always strings in JSON as well as  string values.
 
  Then, the routine iteratively finds the next structure that has no structure 
  Contained within it, (and is, by definition the leaf structure), and parses it,
  replacing it with an object token of the form ‘@Objectxxx‘, or ‘@arrayxxx‘, 
  where xxx is the object id assigned to it. The values, or name/value pairs 
  are retrieved from the string table and stored in the hierarchy table. G
  radually, the JSON document is eaten until there is just a single root
  object left.
Why: case-insensitive version
Example: >
  Select * from parseJSON('{    "Person": 
      {
       "firstName": "John",
       "lastName": "Smith",
       "age": 25,
       "Address": 
           {
          "streetAddress":"21 2nd Street",
          "city":"New York",
          "state":"NY",
          "postalCode":"10021"
           },
       "PhoneNumbers": 
           {
           "home":"212 555-1234",
          "fax":"646 555-4567"
           }
        }
     }
  ')
Returns: >
  nothing
**/
	RETURNS @hierarchy TABLE
	  (
	   Element_ID INT IDENTITY(1, 1) NOT NULL, /* internal surrogate primary key gives the order of parsing and the list order */
	   SequenceNo [int] NULL, /* the place in the sequence for the element */
	   Parent_ID INT null, /* if the element has a parent then it is in this column. The document is the ultimate parent, so you can get the structure from recursing from the document */
	   Object_ID INT null, /* each list or object has an object id. This ties all elements to a parent. Lists are treated as objects here */
	   Name NVARCHAR(2000) NULL, /* the Name of the object */
	   StringValue NVARCHAR(MAX) NOT NULL,/*the string representation of the value of the element. */
	   ValueType VARCHAR(10) NOT null /* the declared type of the value represented as a string in StringValue*/
	  )
	  /*
 
	   */
	AS
	BEGIN
	  DECLARE
	    @FirstObject INT, --the index of the first open bracket found in the JSON string
	    @OpenDelimiter INT,--the index of the next open bracket found in the JSON string
	    @NextOpenDelimiter INT,--the index of subsequent open bracket found in the JSON string
	    @NextCloseDelimiter INT,--the index of subsequent close bracket found in the JSON string
	    @Type NVARCHAR(10),--whether it denotes an object or an array
	    @NextCloseDelimiterChar CHAR(1),--either a '}' or a ']'
	    @Contents NVARCHAR(MAX), --the unparsed contents of the bracketed expression
	    @Start INT, --index of the start of the token that you are parsing
	    @end INT,--index of the end of the token that you are parsing
	    @param INT,--the parameter at the end of the next Object/Array token
	    @EndOfName INT,--the index of the start of the parameter at end of Object/Array token
	    @token NVARCHAR(200),--either a string or object
	    @value NVARCHAR(MAX), -- the value as a string
	    @SequenceNo int, -- the sequence number within a list
	    @Name NVARCHAR(200), --the Name as a string
	    @Parent_ID INT,--the next parent ID to allocate
	    @lenJSON INT,--the current length of the JSON String
	    @characters NCHAR(36),--used to convert hex to decimal
	    @result BIGINT,--the value of the hex symbol being parsed
	    @index SMALLINT,--used for parsing the hex value
	    @Escape INT --the index of the next escape character
	    
	  DECLARE @Strings TABLE /* in this temporary table we keep all strings, even the Names of the elements, since they are 'escaped' in a different way, and may contain, unescaped, brackets denoting objects or lists. These are replaced in the JSON string by tokens representing the string */
	    (
	     String_ID INT IDENTITY(1, 1),
	     StringValue NVARCHAR(MAX)
	    )
	  SELECT--initialise the characters to convert hex to ascii
	    @characters='0123456789abcdefghijklmnopqrstuvwxyz',
	    @SequenceNo=0, --set the sequence no. to something sensible.
	  /* firstly we process all strings. This is done because [{} and ] aren't escaped in strings, which complicates an iterative parse. */
	    @Parent_ID=0;
	  WHILE 1=1 --forever until there is nothing more to do
	    BEGIN
	      SELECT
	        @start=PATINDEX('%[^a-zA-Z]["]%', @json collate SQL_Latin1_General_CP850_Bin);--next delimited string
	      IF @start=0 BREAK --no more so drop through the WHILE loop
	      IF SUBSTRING(@json, @start+1, 1)='"' 
	        BEGIN --Delimited Name
	          SET @start=@Start+1;
	          SET @end=PATINDEX('%[^\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
	        END
	      IF @end=0 --either the end or no end delimiter to last string
	        BEGIN-- check if ending with a double slash...
             SET @end=PATINDEX('%[\][\]["]%', RIGHT(@json, LEN(@json+'|')-@start) collate SQL_Latin1_General_CP850_Bin);
 		     IF @end=0 --we really have reached the end 
				BEGIN
				BREAK --assume all tokens found
				END
			END 
	      SELECT @token=SUBSTRING(@json, @start+1, @end-1)
	      --now put in the escaped control characters
	      SELECT @token=REPLACE(@token, FromString, ToString)
	      FROM
	        (SELECT           '\b', CHAR(08)
	         UNION ALL SELECT '\f', CHAR(12)
	         UNION ALL SELECT '\n', CHAR(10)
	         UNION ALL SELECT '\r', CHAR(13)
	         UNION ALL SELECT '\t', CHAR(09)
			 UNION ALL SELECT '\"', '"'
	         UNION ALL SELECT '\/', '/'
	        ) substitutions(FromString, ToString)
		SELECT @token=Replace(@token, '\\', '\')
	      SELECT @result=0, @escape=1
	  --Begin to take out any hex escape codes
	      WHILE @escape>0
	        BEGIN
	          SELECT @index=0,
	          --find the next hex escape sequence
	          @escape=PATINDEX('%\x[0-9a-f][0-9a-f][0-9a-f][0-9a-f]%', @token collate SQL_Latin1_General_CP850_Bin)
	          IF @escape>0 --if there is one
	            BEGIN
	              WHILE @index<4 --there are always four digits to a \x sequence   
	                BEGIN
	                  SELECT --determine its value
	                    @result=@result+POWER(16, @index)
	                    *(CHARINDEX(SUBSTRING(@token, @escape+2+3-@index, 1),
	                                @characters)-1), @index=@index+1 ;
	         
	                END
	                -- and replace the hex sequence by its unicode value
	              SELECT @token=STUFF(@token, @escape, 6, NCHAR(@result))
	            END
	        END
	      --now store the string away 
	      INSERT INTO @Strings (StringValue) SELECT @token
	      -- and replace the string with a token
	      SELECT @JSON=STUFF(@json, @start, @end+1,
	                    '@string'+CONVERT(NCHAR(5), @@identity))
	    END
	  -- all strings are now removed. Now we find the first leaf.  
	  WHILE 1=1  --forever until there is nothing more to do
	  BEGIN
	 
	  SELECT @Parent_ID=@Parent_ID+1
	  --find the first object or list by looking for the open bracket
	  SELECT @FirstObject=PATINDEX('%[{[[]%', @json collate SQL_Latin1_General_CP850_Bin)--object or array
	  IF @FirstObject = 0 BREAK
	  IF (SUBSTRING(@json, @FirstObject, 1)='{') 
	    SELECT @NextCloseDelimiterChar='}', @type='object'
	  ELSE 
	    SELECT @NextCloseDelimiterChar=']', @type='array'
	  SELECT @OpenDelimiter=@firstObject
	  WHILE 1=1 --find the innermost object or list...
	    BEGIN
	      SELECT
	        @lenJSON=LEN(@JSON+'|')-1
	  --find the matching close-delimiter proceeding after the open-delimiter
	      SELECT
	        @NextCloseDelimiter=CHARINDEX(@NextCloseDelimiterChar, @json,
	                                      @OpenDelimiter+1)
	  --is there an intervening open-delimiter of either type
	      SELECT @NextOpenDelimiter=PATINDEX('%[{[[]%',
	             RIGHT(@json, @lenJSON-@OpenDelimiter)collate SQL_Latin1_General_CP850_Bin)--object
	      IF @NextOpenDelimiter=0 
	        BREAK
	      SELECT @NextOpenDelimiter=@NextOpenDelimiter+@OpenDelimiter
	      IF @NextCloseDelimiter<@NextOpenDelimiter 
	        BREAK
	      IF SUBSTRING(@json, @NextOpenDelimiter, 1)='{' 
	        SELECT @NextCloseDelimiterChar='}', @type='object'
	      ELSE 
	        SELECT @NextCloseDelimiterChar=']', @type='array'
	      SELECT @OpenDelimiter=@NextOpenDelimiter
	    END
	  ---and parse out the list or Name/value pairs
	  SELECT
	    @contents=SUBSTRING(@json, @OpenDelimiter+1,
	                        @NextCloseDelimiter-@OpenDelimiter-1)
	  SELECT
	    @JSON=STUFF(@json, @OpenDelimiter,
	                @NextCloseDelimiter-@OpenDelimiter+1,
	                '@'+@type+CONVERT(NCHAR(5), @Parent_ID))
	  WHILE (PATINDEX('%[A-Za-z0-9@+.e]%', @contents collate SQL_Latin1_General_CP850_Bin))<>0 
	    BEGIN
	      IF @Type='object' --it will be a 0-n list containing a string followed by a string, number,boolean, or null
	        BEGIN
	          SELECT
	            @SequenceNo=0,@end=CHARINDEX(':', ' '+@contents)--if there is anything, it will be a string-based Name.
	          SELECT  @start=PATINDEX('%[^A-Za-z@][@]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)--AAAAAAAA
              SELECT @token=RTrim(Substring(' '+@contents, @start+1, @End-@Start-1)),
	            @endofName=PATINDEX('%[0-9]%', @token collate SQL_Latin1_General_CP850_Bin),
	            @param=RIGHT(@token, LEN(@token)-@endofName+1)
	          SELECT
	            @token=LEFT(@token, @endofName-1),
	            @Contents=RIGHT(' '+@contents, LEN(' '+@contents+'|')-@end-1)
	          SELECT  @Name=StringValue FROM @strings
	            WHERE string_id=@param --fetch the Name
	        END
	      ELSE 
	        SELECT @Name=null,@SequenceNo=@SequenceNo+1 
	      SELECT
	        @end=CHARINDEX(',', @contents)-- a string-token, object-token, list-token, number,boolean, or null
                IF @end=0
	        --HR Engineering notation bugfix start
	          IF ISNUMERIC(@contents) = 1
		    SELECT @end = LEN(@contents) + 1
	          Else
	        --HR Engineering notation bugfix end 
		  SELECT  @end=PATINDEX('%[A-Za-z0-9@+.e][^A-Za-z0-9@+.e]%', @contents+' ' collate SQL_Latin1_General_CP850_Bin) + 1
	       SELECT
	        @start=PATINDEX('%[^A-Za-z0-9@+.e][A-Za-z0-9@+.e]%', ' '+@contents collate SQL_Latin1_General_CP850_Bin)
	      --select @start,@end, LEN(@contents+'|'), @contents  
	      SELECT
	        @Value=RTRIM(SUBSTRING(@contents, @start, @End-@Start)),
	        @Contents=RIGHT(@contents+' ', LEN(@contents+'|')-@end)
	      IF SUBSTRING(@value, 1, 7)='@object' 
	        INSERT INTO @hierarchy
	          (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	          SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 8, 5),
	            SUBSTRING(@value, 8, 5), 'object' 
	      ELSE 
	        IF SUBSTRING(@value, 1, 6)='@array' 
	          INSERT INTO @hierarchy
	            (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	            SELECT @Name, @SequenceNo, @Parent_ID, SUBSTRING(@value, 7, 5),
	              SUBSTRING(@value, 7, 5), 'array' 
	        ELSE 
	          IF SUBSTRING(@value, 1, 7)='@string' 
	            INSERT INTO @hierarchy
	              (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	              SELECT @Name, @SequenceNo, @Parent_ID, StringValue, 'string'
	              FROM @strings
	              WHERE string_id=SUBSTRING(@value, 8, 5)
	          ELSE 
	            IF @value IN ('true', 'false') 
	              INSERT INTO @hierarchy
	                (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                SELECT @Name, @SequenceNo, @Parent_ID, @value, 'boolean'
	            ELSE
	              IF @value='null' 
	                INSERT INTO @hierarchy
	                  (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                  SELECT @Name, @SequenceNo, @Parent_ID, @value, 'null'
	              ELSE
	                IF PATINDEX('%[^0-9]%', @value collate SQL_Latin1_General_CP850_Bin)>0 
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'real'
	                ELSE
	                  INSERT INTO @hierarchy
	                    (Name, SequenceNo, Parent_ID, StringValue, ValueType)
	                    SELECT @Name, @SequenceNo, @Parent_ID, @value, 'int'
	      if @Contents=' ' Select @SequenceNo=0
	    END
	  END
	INSERT INTO @hierarchy (Name, SequenceNo, Parent_ID, StringValue, Object_ID, ValueType)
	  SELECT '-',1, NULL, '', @Parent_ID-1, @type
	--
	   RETURN
	END
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[JsonKeyValuePairs]    Script Date: 6/26/2024 12:47:02 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[JsonKeyValuePairs](
@Json nvarchar(400) 
--,@JsonKey nvarchar(400)
)
returns table as
return select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) Keyvalue   FROM STRING_SPLIT(@Json,',') where value not like '%null%' and value <>''  -- and SUBSTRING(value, 1, (charindex(':',value,0)-1)) = @JsonKey


GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [elig].[fnvarchar]    Script Date: 6/26/2024 12:48:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [elig].[fnvarchar](@ColumnName nvarchar(max)) returns nvarchar(200)
begin
return isnull(ltrim(rtrim(@ColumnName)), '')
END
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [elig].[fdecimal]    Script Date: 6/26/2024 12:48:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [elig].[fdecimal](@ColumnName nvarchar(max)) returns decimal(10,2)
begin
return isnull(try_cast(ltrim(rtrim(@ColumnName)) as decimal(10,2)), 0.00)
END
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [elig].[fdate]    Script Date: 6/26/2024 12:48:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE function [elig].[fdate] (@ColumnName nvarchar(max))  returns date
begin
return isnull(try_cast(ltrim(rtrim(@ColumnName)) as date), '')
END
GO


USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[JsonValue]    Script Date: 6/26/2024 12:48:26 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[JsonValue] (
@Value nvarchar(100)
)
returns nvarchar(100)
as
begin
declare @vValue nvarchar(100)

select @vValue = ltrim(rtrim(substring(@Value,charindex(':',@Value)+1, len(@Value)) ))
return @vValue

end
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[jsonReplace]    Script Date: 6/26/2024 12:48:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[jsonReplace] (
	-- Add the parameters for the function here
	 @JsonString nvarchar(4000) = null
	)

/*
declare @JsonString nvarchar(4000) = '{"insCarrierId":258,"insPlanId":2433,"subdomain":"alignment","clientCarrierId":302,"clientPlanId":2692,"cardNumber":"6102812311092566733","healthPlanCode":null,"programCode":null,"groupNumber":null,"firstName":"PHUNG","middleName":null,"lastName":"TRAN","phoneNumber":"4086856011","email":null,"address":{"address1":"1120 Fairlands Court ","address2":"","city":"Campbell","state":"CA","zip":"95008","county":null,"country":null},"insuranceNbr":null,"dateOfBirth":null}'
select dbo.jsonReplace(@JsonString)
select value FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''
select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) value   FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''

declare @JsonString nvarchar(4000) = '{"insCarrierId":258,"insPlanId":2433,"subdomain":"alignment","clientCarrierId":302,"clientPlanId":2692,"cardNumber":"6102812311092566733","healthPlanCode":null,"programCode":null,"groupNumber":null,"firstName":"PHUNG","middleName":null,"lastName":"TRAN","phoneNumber":"4086856011","email":null,"address":{"address1":"1120 Fairlands Court ","address2":"","city":"Campbell","state":"CA","zip":"95008","county":null,"country":null},"insuranceNbr":null,"dateOfBirth":null}'
select dbo.jsonReplace(@JsonString)
select value FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''
select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) value   FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''

select dbo.jsonReplace(@JsonString)
select * from JsonKeyValuePairs(dbo.jsonReplace(@JsonString));

declare @JsonString nvarchar(4000) = '{"insCarrierId":258,"insPlanId":2433,"subdomain":"alignment","clientCarrierId":302,"clientPlanId":2692,"cardNumber":"6102812311092566733","healthPlanCode":null,"programCode":null,"groupNumber":null,"firstName":"PHUNG","middleName":null,"lastName":"TRAN","phoneNumber":"4086856011","email":null,"address":{"address1":"1120 Fairlands Court ","address2":"","city":"Campbell","state":"CA","zip":"95008","county":null,"country":null},"insuranceNbr":null,"dateOfBirth":null}'
select dbo.jsonReplace(@JsonString)
select value FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''
select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) keyvalue   FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''
select dbo.jsonReplace(@JsonString)
declare @keyvalue nvarchar(400) = 'insCarrierId'
select * from JsonKeyValuePairs(dbo.jsonReplace(@JsonString), @keyvalue)
select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) Keyvalue   FROM STRING_SPLIT(@Json,',') where value not like '%null%' and value <>''  and SUBSTRING(value, 1, (charindex(':',value,0)-1)) = @JsonKey

*/


RETURNS  nvarchar(4000)
AS
Begin
	-- Declare the return variable here
	DECLARE @Json nvarchar(4000)
	--SELECT @Json = (replace(replace(replace(     replace(      replace(@JsonString,' ',''), ':{', ':null,')                       ,'"',''), '{',''), '}',''))
	SELECT @Json = (replace(replace(replace(     replace(      @JsonString, '{', ',')                       ,'"',''), '{',''), '}',''))
	RETURN @Json
	--RETURN select value, SUBSTRING(value, 1, (charindex(':',value,0)-1)) keys, SUBSTRING(value, charindex(':',value,0)+1, len(value)) value   FROM STRING_SPLIT(dbo.jsonReplace(@JsonString),',') where value not like '%null%' and value <>''
end
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[JsonParse]    Script Date: 6/26/2024 12:48:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[JsonParse] 
(
@JsonString nvarchar(4000) = null, @KeyValue nvarchar(100)
)
returns nvarchar(100)
as
begin
declare @vValue nvarchar(4000), @vKeyValue nvarchar(200)

select @vKeyValue = ('%' + @KeyValue + '%')

select @vValue = cast(value as nvarchar) from string_split(@JsonString, ',') where rtrim (value) <> '' and value like @vKeyValue
return @vValue

END
GO



USE [NHCRM_STG]
GO

/****** Object:  UserDefinedFunction [dbo].[JsonKeyValue]    Script Date: 6/26/2024 12:48:14 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE function [dbo].[JsonKeyValue] 
(
@JsonString nvarchar(max), @JsonKey nvarchar(max)
/*
		  Author | Santhosh Balla
			Date | 09/30/2021
	 Description | This function returns the value of a key anywhere in the JSON string. 
	 Parameters  | The parameters to pass are the valid JSON string and the key for which you want the value
*** How to execute ***
declare @JsonString nvarchar(4000) = '{"insCarrierId":257,"insCarrierId":256,"insCarrierId":255,"insPlanId":2433,"subdomain":"alignment","clientCarrierId":302,"clientPlanId":2692,"cardNumber":"6102812311092566733","healthPlanCode":null,"programCode":null,"groupNumber":null,"firstName":"PHUNG","middleName":null,"lastName":"TRAN","phoneNumber":"4086856011","email":null,"address":{"address1":"1120 Fairlands Court ","address2":"","city":"Campbell","state":"CA","zip":"95008","county":null,"country":null},"insuranceNbr":null,"dateOfBirth":null}'
declare @JsonKey nvarchar(200) = 'insCarrierId'
select dbo.JsonKeyValue (@JsonString, @JsonKey)  -- returns the first value found for the key anywhere in the JSON string. 

*/
)
returns nvarchar(max) as
begin
declare @vJsonString nvarchar(max), @vJsonKey nvarchar(max), @vKeyValue nvarchar(max), @vValue nvarchar(max)
select @vJsonKey = ('%'+ @JsonKey + '%')

select @vJsonString = (replace(replace(replace(@JsonString,'"',''), '{',''), '}',''))  -- replace all Open, close curly bracket, and double quotes with blank
select @vKeyValue = cast(value as nvarchar(max)) from string_split(@vJsonString, ',') where rtrim (value) <> '' and value like @vJsonKey
select @vValue = ltrim(rtrim(substring(@vKeyValue,charindex(':',@vKeyValue)+1, len(@vKeyValue)) ))

--return @vJsonString
--return @vKeyValue
return @vValue

end
GO




USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_ProductSummary]    Script Date: 6/26/2024 12:53:27 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */


-- Exec [bireports].[sp_rpt_NationsOTC_Business_ProductSummary] 258,NULL,NULL,'YTD'

CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_ProductSummary] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  =  dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END



---- Top Product Summary 

DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 



select Top 30 @StartDate as Startdate,@EndDate as EndDate,B.ProductName AS Item,B.ProductCategory AS Category,sum(productquantity) QuantityPurchased
from [bireports].[BI_OTC_OrderDetail_Data_2021] A 
join [bireports].[BI_OTC_OrderItemDetail_Data_2021] B
ON A.OrderID=B.OrderID
where A.status='ACTIVE' 
and b.ItemCode_iml not like '%VOUCHER%' -- Exclude Vouchers 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Refunds
AND RefOrderID IS NULL -- Exclude Reships 
and CarrierId=@Carrier_ID 
and A.Orderdate BETWEEN @StartDate AND @EndDate
group by B.ProductName,B.ProductCategory
order by sum(productquantity) desc


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
GO


USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_Products]    Script Date: 6/26/2024 12:53:23 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_Products] 356,'01-01-2021','01-31-2022','X'
--Exec [bireports].[sp_rpt_NationsOTC_Business_Products] 258,NULL,NULL,'YTD'
CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_Products] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  =  dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END



---- Top Products 

DROP TABLE IF EXISTS #subquery
DROP TABLE IF EXISTS #rowtable
DROP TABLE IF EXISTS #Caltotal



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 




select B.ProductName,B.ProductCategory AS Category,Month(a.OrderDate) as month_num,year(a.OrderDate) as month_yr
,sum(productquantity) Count_OrdersPlaced
into #subquery
from [bireports].[BI_OTC_OrderDetail_Data_2021] A 
join [bireports].[BI_OTC_OrderItemDetail_Data_2021] B
ON A.OrderID=B.OrderID
where A.status='ACTIVE' 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude  Full Refunds 
and b.ItemCode_iml not like '%VOUCHER%' -- Exclude Vouchers 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and Cast(A.Orderdate as date) BETWEEN @StartDate AND @EndDate
group by B.ProductName,B.ProductCategory,Month(a.OrderDate) ,year(a.OrderDate) 
order by sum(productquantity) desc




--select * from #subquery
--select * from #rowtable
select month_num,month_yr,
Category,ProductName,Count_OrdersPlaced,Row_number() over(partition by ProductName  order by month_num,month_yr) as row_no
into #rowtable
from #subquery
group by ProductName,Count_OrdersPlaced,Category,month_num,month_yr

--select * from #Caltotal
Select top 30 ProductName,Category,Sum(Count_OrdersPlaced) as QuantityPurchasedYTD
into #Caltotal
from #rowtable
group by ProductName,Category
order by QuantityPurchasedYTD desc

-- Final Table 
select @StartDate as Startdate,@EndDate as EndDate,a.month_num,a.month_yr,
a.ProductName,a.Category,a.Count_OrdersPlaced,QuantityPurchasedYTD
from #rowtable a 
join #Caltotal b 
on ltrim(rtrim(a.ProductName))=ltrim(rtrim(b.ProductName))
order by QuantityPurchasedYTD desc


DROP TABLE IF EXISTS #subquery
DROP TABLE IF EXISTS #rowtable
DROP TABLE IF EXISTS #Caltotal
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_CartOverview]    Script Date: 6/26/2024 12:53:18 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_CartOverview] 302,NULL,NULL,'YTD'
-- Exec [bireports].[sp_rpt_NationsOTC_Business_CartOverview] 302,'01/01/2021','05/31/2021','X'
CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_CartOverview] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;


SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  
       END


--------- Cart overview


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
DROP TABLE IF EXISTS #Orders
DROP TABLE IF EXISTS #EligibleMembers
DROP TABLE IF EXISTS #FirstTimeMembersMTD
DROP TABLE IF EXISTS #FirstTimeMembersYTD


--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 

---- Order Count 
DECLARE @TodaysDate DATE;
SET @TodaysDate = @EndDate


select @Carrier_ID as CarrierID,
COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) OrderCount_MTD
,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) OrderCount_YTD
,ISNULL(SUM( CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                 WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)
                 ELSE NULL END),0) TotalProductPrice_MTD 
,ISNULL(SUM( CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate)  AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                  WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN (A.Price-A.TotalRefundAmount) 
                  ELSE NULL END),0) TotalProductPrice_YTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE
ISNULL(SUM( CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                 WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)
                 ELSE NULL END),0)/
CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) AS FLOAT)
END AvgDollarPerOrder_MTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE
ISNULL(SUM( CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate)  AND B.RefundStatus IN ('Partial Refund') THEN B.Price
                  WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN (A.Price-A.TotalRefundAmount)  
                  ELSE NULL END),0)/
CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) AS FLOAT)
END AvgDollarPerOrder_YTD
,COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN a.NHMemberId ELSE NULL END) OrdererdEligibleMem_MTD
,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN a.NHMemberId ELSE NULL END) OrdererdEligibleMem_YTD
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND ((a.OrderChannel='Online' and a.Source='OTC_Mail') or (a.OrderChannel='MEA' and a.Source='OTC_Mail'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerMailOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND ((a.OrderChannel='Online' and a.Source='OTC_Mail') or (a.OrderChannel='MEA' and a.source='OTC_Mail'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerMailOrderCount_YTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerPhoneOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerPhoneOrderCount_YTD 
 ,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) AND  ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(MM,a.OrderDate) = DATEPART(MM,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerOnlineOrderCount_MTD 
,CASE WHEN COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID ELSE NULL END) = 0
THEN 0
ELSE (COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) AND  ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
	  THEN A.OrderID ELSE NULL END)/CAST(COUNT(DISTINCT CASE WHEN DATEPART(YYYY,a.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN A.OrderID END) AS FLOAT))
 END PerOnlineOrderCount_YTD 
Into #Orders
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
Left join #Refund B 
on a.OrderID=b.OrderID
where a.Status='ACTIVE'  
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.OrderDate BETWEEN @StartDate AND @EndDate
and a.CarrierID=@Carrier_ID



-- Total Eligible Members 
select @Carrier_ID AS CARRIERID,
A.CurrentActiveCnt AS EligibleMembers into #EligibleMembers
FROM
(
    select cc.InsuranceCarrierID
            ,es.CurrentActiveCnt
            ,es.FileTrackId
            ,CAST(ft.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE) FileProcessedDate
            ,rank() over (partition by es.CarrierId order by es.FileTrackId DESC) [FileRank]
    from elig.EligibilityStats es
    join elig.FileTrack ft on ft.FileTrackID = es.FileTrackId and ft.SnapshotFlag = 'FULL'
    join elig.ClientCodes cc on cc.ClientCode = es.ClientCode where 1=1
    and es.CarrierId = @Carrier_ID
    and es.StatsType = 'CARRIER'
    and MONTH(CAST(ft.CreateDate AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) = DATEPART(MM,@TodaysDate)
) A
where [FileRank] = 1 
and InsuranceCarrierID=@Carrier_ID



-- First time Members MTD
select @Carrier_ID AS CARRIERID ,
COUNT(DISTINCT CASE WHEN DATEPART(MM,t.OrderDate) = DATEPART(MM,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_MTD
--,COUNT(DISTINCT CASE WHEN DATEPART(YYYY,t.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_YTD
Into #FirstTimeMembersMTD  
from [bireports].[BI_OTC_OrderDetail_Data_2021]  t
LEFT JOIN [bireports].[BI_OTC_OrderDetail_Data_2021]  t1 on (t1.nhmemberid=t.nhmemberid and DATEPART(MM,t1.OrderDate) != DATEPART(MM,@TodaysDate))
where t1.OrderID IS NULL 
AND t.CarrierID=@Carrier_ID
and t.OrderDate BETWEEN @StartDate AND @EndDate




-- First time Members YTD
select @Carrier_ID AS CARRIERID ,
--COUNT(DISTINCT CASE WHEN DATEPART(MM,t.OrderDate) = DATEPART(MM,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_MTD
COUNT(DISTINCT CASE WHEN DATEPART(YYYY,t.OrderDate) = DATEPART(YYYY,@TodaysDate) THEN t.nhmemberid ELSE NULL END) UniqueMembers_YTD
Into #FirstTimeMembersYTD  
from [bireports].[BI_OTC_OrderDetail_Data_2021]  t
LEFT JOIN [bireports].[BI_OTC_OrderDetail_Data_2021]  t1 on (t1.nhmemberid=t.nhmemberid and DATEPART(YYYY,t1.OrderDate) != DATEPART(YYYY,@TodaysDate))
where t1.OrderID IS NULL 
AND t.CarrierID=@Carrier_ID
and t.OrderDate BETWEEN @StartDate AND @EndDate

--SELECT * fROM #FirstTimeMembersYTD

-- Final Query

Select  @StartDate as Startdate,@EndDate as EndDate,
OrderCount_MTD as OrderCount_MTD
,TotalProductPrice_MTD as TotalProductPrice_MTD
,AvgDollarPerOrder_MTD as AvgDollarPerOrder_MTD
,ISNULL(EM.EligibleMembers,0) as TotEligMembers_MTD
,OrdererdEligibleMem_MTD AS EligibleMemordered_MTD
,ISNULL(FMM.UniqueMembers_MTD,0) AS UniqueMembers_MTD
,ISNULL((OrdererdEligibleMem_MTD / CAST(EM.EligibleMembers AS FLOAT) ),0) AS EligMem_Per_MTD
,ISNULL((FMM.UniqueMembers_MTD / CAST(EM.EligibleMembers AS FLOAT) ),0) AS UniqueMem_Per_MTD
,PerMailOrderCount_MTD as MailOrder_Per_MTD 
,PerPhoneOrderCount_MTD as MailPhone_Per_MTD
,PerOnlineOrderCount_MTD as MailOnline_Per_MTD
,OrderCount_YTD as OrderCount_YTD
,TotalProductPrice_YTD as TotalProductPrice_YTD
,AvgDollarPerOrder_YTD as AvgDollarPerOrder_YTD
,OrdererdEligibleMem_YTD AS EligibleMemordered_YTD
,ISNULL(FMY.UniqueMembers_YTD,0) AS UniqueMembers_YTD
,ISNULL((OrdererdEligibleMem_YTD/CAST( EM.EligibleMembers AS FLOAT)),0) AS EligMem_Per_YTD
,ISNULL((FMY.UniqueMembers_YTD/ CAST(EM.EligibleMembers AS FLOAT)),0) AS UniqueMem_Per_YTD
,PerMailOrderCount_YTD as MailOrder_Per_YTD 
,PerPhoneOrderCount_YTD as MailPhone_Per_YTD
,PerOnlineOrderCount_YTD as MailOnline_Per_YTD
from #Orders O 
LEFT join #EligibleMembers EM 
ON O.CARRIERID=EM.CARRIERID
LEFT JOIN #FirstTimeMembersMTD FMM
ON O.CARRIERID=FMM.CARRIERID
LEFT JOIN #FirstTimeMembersYTD FMY
ON O.CARRIERID=FMY.CARRIERID


DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund
DROP TABLE IF EXISTS #Orders
DROP TABLE IF EXISTS #EligibleMembers
DROP TABLE IF EXISTS #FirstTimeMembersMTD
DROP TABLE IF EXISTS #FirstTimeMembersYTD
GO



USE [NHCRM_STG]
GO

/****** Object:  StoredProcedure [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders]    Script Date: 6/26/2024 12:53:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




/* Bhavana :  6/10/2021 - Change to exclude Vochers, Refunds and Reships 
   Bhavana : 6/17/2021  - Change to exclude Manual Refunds */

-- Exec [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] 356,'01-01-2021','01-31-2022','X'
-- Exec [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] 258,'01-01-2021','01-31-2022','YTD'

CREATE PROC [bireports].[sp_rpt_NationsOTC_Business_CallVolume_Orders] (@CarrierID INT, @Start_Date DATE, @End_Date DATE, @DateRange CHAR(5))

AS 

DECLARE @StartDate DATE;
DECLARE @EndDate DATE;
DECLARE @Carrier_ID INT;

SET @Carrier_ID = @CarrierID;
  
		-- Custom Date Range
		IF @DateRange='X'
		BEGIN

			SET @StartDate =  @Start_Date				  
			SET @EndDate =  @End_Date				
		END

		-- Returns previous day 
		IF @DateRange='D'
		BEGIN
			SET @StartDate = DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 	  
			SET @EndDate =   DATEADD(DAY,-1,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) 			
		END

		-- Today
		IF @DateRange='C'
		BEGIN
			SET @StartDate = CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			  
			SET @EndDate =   CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))			
		END

		-- Returns first and last day of previous month
		IF @DateRange='M'
		BEGIN
			SET @EndDate = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
			SET @StartDate = cast(cast(year(@EndDate) AS VARCHAR(4))+'/'+cast(month(@EndDate) AS VARCHAR(2))+'/1' as date);			
		END

		-- Returns first and last day of previous week - first day of week starts with Sunday
		IF @DateRange='W'
		BEGIN
			SET @StartDate = DATEADD(wk, -1, DATEADD(DAY, 1-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
			SET @EndDate = DATEADD(wk, 0, DATEADD(DAY, 0-DATEPART(WEEKDAY, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), DATEDIFF(dd, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))))
		END


		-- Returns first day and yesterday of the current month as start and end dates when run on any day except 1st day of any month, if run on 1st of any month gives first and last date of the previous month
		-- Use this for reports that should include MTD data and runs every day in a month.
		IF @DateRange='MTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0) 

								  WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1 
									THEN DATEADD(MONTH, DATEDIFF(MONTH, 0, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, 0)  
							  END

			SET @EndDate  = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) <> 1
									THEN DATEADD(DAY, DATEDIFF(DAY, 0, CAST(GETDATE()-1 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)), 0)								

								WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
									THEN DATEADD(MONTH, DATEDIFF(MONTH, -1, CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))-1, -1)								
							  END
		END


		-- First day of year to current date
		IF @DateRange='YTD'
		BEGIN
			SET @StartDate = CASE WHEN DATEPART(DAY,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
			                           AND DATEPART(MONTH,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) = 1
								  THEN CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE()-20 AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE) 

								  ELSE CAST('01/01/' + CAST(DATEPART(YEAR,CONVERT(DATE,CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE))) AS VARCHAR) AS DATE)   
							  END

			SET @EndDate  = dateadd(dd,-1,cast(cast(year(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(4))+'/'+cast(month(CAST(GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Eastern Standard Time' AS DATE)) AS VARCHAR(2))+'/1' as date))
							  END



DROP TABLE IF EXISTS #callVolume
DROP TABLE IF EXISTS #ordersplaced
DROP TABLE IF EXISTS #DaystoShip
DROP TABLE IF EXISTS #SubQuery
DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund


--- Call Volume 


select @CarrierID as CarrierID,month(cast(MidnightStartDate as date)) As Month_Num,
Year(cast(MidnightStartDate as date)) as Month_Year
,sum(QueueOffered) Call_Volume
into #callVolume
from 
(
   select * from bireports.Mitel_QueuePerformanceByPeriodStats with (nolock)
   where 1=1
   and cast(MidnightStartDate as date) between @StartDate and @EndDate
) qp 
join bireports.Mitel_QueueGroup qg on ( 'P'+qg.Reporting = qp.QueueReporting 
											  AND qg.QueueGroupType = 'OTC'				
											  AND qg.InsCarrierID = @Carrier_ID
									  )
LEFT JOIN Insurance.InsuranceCarriers ic  on (ic.InsuranceCarrierID = qg.InsCarrierID)
where 1=1
group by  month(cast(MidnightStartDate as date)),Year(cast(MidnightStartDate as date))
ORDER BY Month_Num,Month_Year



--- Exclude Refunds 

 
 select a.OrderID,sum(b.productquantity) ProductQuantity, sum(b.refunditemquantity) RefundQuantity,
 Case when sum(b.productquantity)= sum(b.refunditemquantity) Then 'Full Refund'
      When sum(b.productquantity)<> sum(b.refunditemquantity) Then 'Partial Refund' End RefundStatus
 , Case When sum(b.productquantity)<> sum(b.refunditemquantity) then (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) 
		 Else (Sum(b.ProductQuantity*b.ProductUnitPrice)-ISNULL(Sum(b.RefundAmount),0)) END AS PRICE
 ,A.CarrierID 
 INTO #Refund
FROM 
[bireports].[BI_OTC_OrderDetail_Data_2021] a 
JOIN  [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
on a.OrderID=b.OrderID
JOIN [Orders].[OrderChangeRequests] C 
ON A.OrderID=C.OrderId
where a.Status='ACTIVE'  
and b.ItemCode_iml not in ('NB_VOUCHER_REFUND') -- Exclude Item line Vouchers 
and c.Status='APPROVED'
and c.ChangeType='REFUND' 
AND a.CarrierID=@Carrier_ID 
group by a.OrderID,A.CarrierID


-- Exclude Manual Refunds before 4/24

    select distinct a.orderid into #manualRefund
	from [bireports].[BI_OTC_OrderDetail_Data_2021]  a 
	join [bireports].[BI_OTC_OrderItemDetail_Data_2021] b 
	on a.OrderID=b.OrderID
	Left JOIN [Orders].[OrderChangeRequests] C 
    ON A.OrderID=C.OrderId
	where C.OrderId IS NULL 
	and a.Status='ACTIVE'  
	AND a.RefOrderID IS NULL -- Exclude Reships 
	and a.Price=0.00 -- Manual Full Refund 
	and not exists ( select * from [bireports].[NationsOTC_BathroomSafety_ItemCodes] where [CarrierID]=@Carrier_ID 
	                                                                                  and  [ItemCode]=b.ItemCode_iml
	                                                                                      and [NationsId]=b.Nations_ProductCode)  -- Exclude Bathroom Safety 
	and a.CarrierID=@Carrier_ID 


	--select * from #manualRefund

---------- Orders 

select @CarrierID as CarrierID, month(a.OrderDate) as Month_Num,year(a.OrderDate) as Month_Year
,COUNT(DISTINCT a.OrderID) OrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_STORE') or (a.OrderChannel='MEA' and a.source='OTC_STORE')
                            OR (a.OrderChannel='Online' and a.source='AGENT_USER')  OR (a.OrderChannel='Online' and a.source='OTC_Subscription'))
       THEN a.OrderID ELSE NULL END) OnlineOrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_MEA') or (a.OrderChannel='MEA' and a.source='OTC_MEA'))
       THEN a.OrderID ELSE NULL END) PhoneOrdersCount
,COUNT(DISTINCT CASE WHEN ((a.OrderChannel='Online' and a.source='OTC_Mail') or (a.OrderChannel='MEA' and a.source='OTC_Mail'))
       THEN a.OrderID ELSE NULL END) MailOrdersCount
into #ordersplaced
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
where a.Status='ACTIVE' 
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and a.OrderDate BETWEEN @StartDate AND @EndDate
group by month(a.OrderDate),year(a.OrderDate)
Order by Month_Num,Month_Year


------ Days to Ship  

select @CarrierID as CarrierID,a.ShippingDate,a.OrderDate,substring(a.ShippingDate,1,10) as ShippingDate_Substring ,len(a.ShippingDate) ShippingDate_Len 
into #SubQuery
from [bireports].[BI_OTC_OrderDetail_Data_2021] a
where a.Status='ACTIVE'  
and a.OrderID NOT IN ( select OrderID from [bireports].[BI_OTC_OrderItemDetail_Data_2021]
                       where ItemCode_iml like 'NB_%_VOUCHER') -- Exclude Vouchers 
AND a.OrderID NOT IN ( SELECT ORDERID FROM #Refund WHERE RefundStatus IN ('Full Refund'))  -- Exclude Full Refunds 
AND A.OrderID NOT IN ( SELECT ORDERID FROM #manualRefund ) -- Exclude Manual Full Refunds
AND a.RefOrderID IS NULL -- Exclude Reships 
and a.CarrierID=@Carrier_ID 
and a.OrderDate BETWEEN @StartDate AND @EndDate
group by a.ShippingDate,a.OrderDate

update A
set A.ShippingDate = NULL
--select * 
from #SubQuery A
where ShippingDate_Len <> 10 

update A
set A.ShippingDate = A.OrderDate
--select * 
from #SubQuery A
where A.ShippingDate IS NULL



select @CarrierID as CarrierID,month(orderdate) as Month_Num,year(orderdate) as Month_Year
,sum(datediff(DD, orderdate, ShippingDate)) as TotalDays,COUNT(OrderDate) Countoforders
,ISNULL(SUM( datediff(DD, orderdate, ShippingDate))/CAST(COUNT(OrderDate) AS FLOAT),0) DaystoShip
into #DaystoShip
from #SubQuery
group by month(orderdate),year(orderdate) 
Order by Month_Num






--- Final Query

select @StartDate as Startdate,@EndDate as EndDate,
A.Month_Num,A.Month_Year,
ISNULL(B.Call_Volume,0) CallVolume
,A.OrdersCount,A.OnlineOrdersCount,A.PhoneOrdersCount,A.MailOrdersCount,C.DaystoShip,C.Countoforders,C.TotalDays
from #ordersplaced A 
LEFT JOIN #callVolume B 
ON A.Month_Num=B.Month_Num
AND A.Month_Year=B.Month_Year
left join #DaystoShip C 
ON A.Month_Num=C.Month_Num
AND A.Month_Year=C.Month_Year
order by a.Month_Num,a.Month_Year


DROP TABLE IF EXISTS #callVolume
DROP TABLE IF EXISTS #ordersplaced
DROP TABLE IF EXISTS #DaystoShip
DROP TABLE IF EXISTS #SubQuery
DROP TABLE IF EXISTS #Refund
DROP TABLE IF EXISTS #manualRefund

/*
select @CarrierID as CarrierID, month(orderdate) as Month_Num,year(orderdate) as Month_Year
,COALESCE(NULL,avg(convert(decimal(10,2),datediff(DD, orderdate, ShippingDate)))) as DaystoShip
into #DaystoShip
from #SubQuery
group by month(orderdate),year(orderdate) 
Order by Month_Num

*/
GO
















































