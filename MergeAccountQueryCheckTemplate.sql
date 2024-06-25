SET NOCOUNT ON
SET XACT_ABORT ON

declare @OldNHMemberID nvarchar(20)
declare @NewNHMemberID nvarchar(20)
declare @RequestedBy nvarchar(50)
declare	@Technician nvarchar(50)
declare @TicketNumber nvarchar(20)
declare @vNewProfileID bigint
declare @vOldProfileID bigint
declare @vNewInsCarrierID nvarchar(20)
declare @vNewInsHealthPlanID nvarchar(20)
declare @vOldInsCarrierID nvarchar(20)
declare @vOldInsHealthPlanID nvarchar(20)

declare @vOldCard nvarchar(20)
declare @vNewCard nvarchar(20)

declare @vMessage nvarchar(2000)
declare @vCount int

set @TicketNumber = '35551'
set @Technician = 'sballa'
set @RequestedBy = 'jkerfoot'

--set @OldNHMemberID = 'NH202106730667'
--set @NewNHMemberID = 'NH202106730672'


set @OldNHMemberID = 'NH202002194187'
--set @NewNHMemberID = 'NH202106688944'


select 'master.members' as TableName, 'old' as Type, a.datasource, a.NHMemberID, a.NHLinkID, a.MemberID
from Master.Members a where NHMemberID in (@OldNHMemberID ) union all
select 'master.members' as TableName, 'new' as Type, a.datasource, a.NHMemberID, a.NHLinkID, a.MemberID
from Master.Members a where NHMemberID in (@NewNHMemberID )


select @vNewProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @NewNHMemberID
select @vOldProfileID = MemberProfileID from [provider].[MemberProfiles] where NHMemberID = @OldNHMemberID

select @vNewInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID
select @vNewInsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) -- New NHMember ID

select @vOldInsCarrierID = insCarrierID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) -- Old NHMember ID
select @vOldInsHealthPlanID = insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) -- Old NHMember ID

select @vOldCard = CardNumber from otc.Cards where NHMemberID = @OldNHMemberID -- Old Card
select @vNewCard = CardNumber from otc.Cards where NHMemberID = @NewNHMemberID -- New Card

Print('@OldNHMemberID | '+ cast(@OldNHMemberID as nvarchar))
Print('@NewNHMemberID | '+ cast(@NewNHMemberID as nvarchar))
Print('@RequestedBy | '+ cast(@RequestedBy as nvarchar))
Print('@Technician | '+ cast(@Technician as nvarchar))
Print('@TicketNumber | '+ cast(@TicketNumber as nvarchar))
Print('@vNewProfileID | '+ isNull(cast(@vNewProfileID as nvarchar),'Not Found'))
Print('@vOldProfileID | '+ isNull(cast(@vOldProfileID as nvarchar),'Not Found'))
Print('@vOldInsCarrierID | '+ isNull(cast(@vOldInsCarrierID as nvarchar),'Not Found'))
Print('@vOldInsHealthPlanID | '+ isNull(cast(@vOldInsHealthPlanID as nvarchar),'Not Found'))
Print('@vNewInsCarrierID | '+ isNull(cast(@vNewInsCarrierID as nvarchar),'Not Found'))
Print('@vNewInsHealthPlanID | '+ isNull(cast(@vNewInsHealthPlanID as nvarchar),'Not Found'))
Print('@vOldCard | '+ isNull(cast(@vOldCard as nvarchar), 'Not Found'))
Print('@vNewCard | '+ isNull(cast(@vNewCard as nvarchar), 'Not Found'))

set @vMessage = '( OldNHMemberID | ' + cast(@OldNHMemberID as nvarchar) + ' ), ' + 
				'( NewNHMemberID | ' + cast(@NewNHMemberID as nvarchar)+ ' ), ' + 
				'( RequestedBy | ' + cast(@RequestedBy as nvarchar) + ' ), ' +
				'( Technician | ' + cast(@Technician as nvarchar) + ' ), ' + 
				'( TicketNumber | ' + cast(@TicketNumber as nvarchar) + ' ), '+
				'( OldCardNumber | ' + isNull(cast(@vOldCard as nvarchar), 'Not Found') + ' ), '+
				'( NewCardNumber | ' + isNull(cast(@vNewCard as nvarchar), 'Not Found') + ' ), '+
				'( NewInsCarrierID | ' + isNull(cast(@vNewInsCarrierID as nvarchar), 'Not Found') + ' ), ' +
				'( NewInsHealthPlanID | ' + isNull(cast(@vNewInsHealthPlanID as nvarchar),'Not Found') + ' ), ' +

				'( OldInsCarrierID | ' + isNull(cast(@vOldInsCarrierID as nvarchar), 'Not Found') + ' ), ' +
				'( OldInsHealthPlanID | ' + isNull(cast(@vOldInsHealthPlanID as nvarchar),'Not Found') + ' ), ' +

				'( NewProfileID | ' + isNull(cast(@vNewProfileID as nvarchar),'Not Found') + ' ), ' +
				'( OldProfileID | ' + isNull(cast(@vOldProfileID as nvarchar), 'Not Found') + ' ), ' 

select @vMessage


select @OldNHMemberID as NHMemberID, 'old' as Type,  * from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) and isActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type,  * from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) and isActive = 1

--Counts
select @OldNHMemberID as NHMemberID, 'old' as Type, 'elig.mstrEligBenefitData' as TableName, count(*) as IsAvailable from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'elig.mstrEligBenefitData' as TableName,count(*) as IsAvailable  from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) and IsActive = 1 union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @OldNHMemberID  and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @NewNHMemberID  and IsActive = 1 union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID  = @OldNHMemberID and IsActive = 1  union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID  = @NewNHMemberID and IsActive = 1  union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @OldNHMemberID and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @NewNHMemberID and IsActive = 1


--Master.Members
select @OldNHMemberID as NHMemberID, 'old' as Type,  'master.members' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'master.members' as TableName, * from [Master].[Members] WHERE [NHMemberID] = @NewNHMemberID

--provider.MemberProfiles
select @oldNHMemberID as NHMemberID, 'old' as Type, 'old' as ProfileID, 'provider.MemberProfiles' as TableName, * from provider.MemberProfiles WHERE [NHMemberID] = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'new' as ProfileID, 'provider.MemberProfiles' as TableName, * from provider.MemberProfiles WHERE [NHMemberID] = @NewNHMemberID


--ProcessData
select @OldNHMemberID as NHMemberID, 'old' as Type,  'provider.MemberChartData' as TableName, mcd.ProcessData, JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) as NewProcessData -- new nhmemberid
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vOldProfileID
					                                    )
						       )
union all

select @NewNHMemberID as NHMemberID, 'new' as Type, 'provider.MemberChartData' as TableName, mcd.ProcessData, JSON_MODIFY(mcd.ProcessData, '$.MemberProfileId', @vNewProfileID  ) as NewProcessData -- new nhmemberid
from provider.MemberChartData mcd
WHERE mcd.MemberChartDataId in ( select MemberChartDataID from [provider].[MemberChartData]
							     where MemberChartID in ( select MemberChartID from [provider].[MemberCharts] 
													      where MemberProfileID = @vNewProfileID
					                                    )
						       )

--ProfileID
select @OldNHMemberID as NHMemberID, 'old' as Type, 'provider.MemberCharts' as TableName, mc.MemberProfileID from [provider].[MemberCharts] mc where mc.MemberProfileID = @vOldProfileID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'provider.MemberCharts' as TableName, mc.MemberProfileID from [provider].[MemberCharts] mc where mc.MemberProfileID = @vNewProfileID

--InsCarrier and InsHealthPlan
select @OldNHMemberID as NHMemberID, 'old' as Type,  'elig.mstrEligBenefitData' as TableName, insCarrierID, insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) and IsActive = 1
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'elig.mstrEligBenefitData' as TableName, insCarrierID, insHealthPlanID from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) and IsActive = 1

--MemberData
select @OldNHMemberID as NHMemberID, 'old' as Type,  'Orders.Orders' as TableName, o.OrderBy, o.MemberData, JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vOldInsCarrierID ), '$.insPlanId' , @vOldinsHealthPlanID ) as NewMemberData 
from orders.orders o where 1=1 and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @OldNHMemberID ) and o.IsActive=1
union
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Orders.Orders' as TableName, o.OrderBy, o.MemberData, JSON_MODIFY( JSON_MODIFY( o.MemberData, '$.insCarrierId' , @vNewInsCarrierID ), '$.insPlanId' , @vNewinsHealthPlanID ) as NewMemberData 
from orders.orders o where 1=1 and o.OrderID in ( select OrderID from Orders.Orders where NHMemberID = @NewNHMemberID ) and o.IsActive=1

--OrderID
select @OldNHMemberID as NHMemberID, 'old' as Type,  'Orders.Orders' as TableName, OrderID from Orders.Orders where NHMemberID = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Orders.Orders' as TableName, OrderID from Orders.Orders where NHMemberID = @NewNHMemberID

--Cards
select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @OldNHMemberID
union
select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @NewNHMemberID



--ReferenceIDsData 
select @OldNHMemberID as NHMemberID, 'old' as Type,  'callcenter.callpageevents' as TableName, cpe.ReferenceIDsData from callcenter.callpageevents cpe where ltrim(rtrim(cpe.ReferenceIDsData)) = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'callcenter.callpageevents' as TableName, cpe.ReferenceIDsData from callcenter.callpageevents cpe where ltrim(rtrim(cpe.ReferenceIDsData)) = @NewNHMemberID

--MemberNHMemberID
select @OldNHMemberID as NHMemberID, 'old' as Type,  'callcenter.callconversations' as TableName, cc.MemberNHMemberId from callcenter.callconversations cc where cc.MemberNHMemberId = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'callcenter.callconversations' as TableName, cc.MemberNHMemberId from callcenter.callconversations cc where cc.MemberNHMemberId = @NewNHMemberID


-- MemberProfiles, MemberCharts, MemberChartsData for old and new Member ID's
select @OldNHMemberID as NHMemberID, 'old' as Type, c.MemberChartDataID, 'provider.MemberProfiles' as TableName,  a.*, 'provider.MemberCharts' as TableName ,b.*, 'provider.MemberChartsData' as TableName, c.*
from provider.MemberProfiles a 
left join provider.MemberCharts b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberChartData c on b.MemberChartId = c.MemberChartId
where a.MemberProfileId = ( select MemberProfileId from provider.MemberProfiles where NHMemberID = @OldNHMemberID)
union all
select @NewNHMemberID as NHMemberID, 'new' as Type,c.MemberChartDataID,'provider.MemberProfiles',  a.*, 'provider.MemberCharts' ,b.*, 'provider.MemberChartsData', c.*
from provider.MemberProfiles a 
left join provider.MemberCharts b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberChartData c on b.MemberChartId = c.MemberChartId
where a.MemberProfileId = ( select MemberProfileId from provider.MemberProfiles where NHMemberID = @NewNHMemberID)



--Old Card numbers should be appended with an A, to inactivate them

--Cards
select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @OldNHMemberID
union
select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.Cards' as TableName, CardNumber from otc.Cards where NHMemberID = @NewNHMemberID


SELECT 'Master.MemberInsuranceDetails' TableName, 'Old Card' as CardType, id,  
  MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  [OTCCardNumber],  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (@OldNHMemberID)
													   )
							)
and OTCCardNumber is not null
--and OTCCardNumber = @vOldCard


SELECT 'Provider.MemberInsuranceDetails' TableName,'Old Card' as CardType, id,  
   MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  [OTCCardNumber],  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN (SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@OldNHMemberID)
													   )
							)
and OTCCardNumber is not null
--and OTCCardNumber = @vOldCard


SELECT 'Master.MemberInsuranceDetails' TableName, 'New Card' as CardType, id,  
  MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  [OTCCardNumber],  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE MemberInsuranceID IN (SELECT ID FROM [Master].[MemberInsurances]  -- MemberInsuranceID is ID
									 WHERE MemberID IN (SELECT MemberID FROM master.members 
																	   WHERE NHMemberid in (@NewNHMemberID)
													   )
							)
and OTCCardNumber is not null
--and OTCCardNumber = @vNewCard


SELECT 'Provider.MemberInsuranceDetails' TableName,'New Card' as CardType, id,  
   MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  [OTCCardNumber],  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN (SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@NewNHMemberID)
													   )
							)
and OTCCardNumber is not null
--and OTCCardNumber = @vNewCard

--All provider insurance tables with memberProfile
select 'All' as TableName,  'old' as Type, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
provider.MemberProfiles a left join provider.MemberInsurances b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberInsuranceDetails c on b.MemberInsuranceID = c.MemberInsuranceID
where a.NHMemberID in (@OldNHMemberID)
Union All
select 'All' as TableName,  'new' as Type, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
provider.MemberProfiles a left join provider.MemberInsurances b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberInsuranceDetails c on b.MemberInsuranceID = c.MemberInsuranceID
where a.NHMemberID in (@NewNHMemberID)


---- 35478
--set @OldNHMemberID = 'NH202002740638'
--set @NewNHMemberID = 'NH202005679035'



-- 35478
--set @OldNHMemberID = 'NH202002740638'
--set @NewNHMemberID = 'NH202005679035'


--# 35495
--set @OldNHMemberID = 'NH202106567514'
--set @NewNHMemberID = 'NH202005622795'


--35316 -- This needs to be done
--set @OldNHMemberID = 'NH202002595980'
--set @NewNHMemberID = 'NH202002596000'

--35311
--set @OldNHMemberID = 'NH202106733324'
--set @NewNHMemberID = 'NH202002580869'


--35342
--set @OldNHMemberID = 'NH202002317738'
--set @NewNHMemberID = 'NH202002175823'



/*
--35354 
JohnAdams
120 Dreiser Loop, 22H, BRONX, NY - 10475
OTC201901950213
NH202002480714
NH202002544956
this member needs to be merged so he can use his benefit

--35354 
--set @OldNHMemberID = 'NH202002544956'  -- duplicate account
--set @NewNHMemberID = 'NH202002480714'  -- keep account

*/

--35320
--set @NewNHMemberID = 'NH202005659750' -- keep account
--set @OldNHMemberID = 'NH202002702942' -- duplicate account


-- 35325
--set @NewNHMemberID = 'NH202002211567' --keep Account
--set @OldNHMemberID = 'NH202002685906' --duplicate Account


--35326
--set @NewNHMemberID = 'NH202005713283' --keep Account
--set @OldNHMemberID = 'NH202002527209' --duplicate Account


--# 35193
--set @NewNHMemberID = 'NH202005613858' -- Alignment
--set @OldNHMemberID = 'NH202002556378' -- Nation

-- # 35176 | submitted for verification
--Gloria Campo
--NH202002031242 
--NH202106688683
--set @NewNHMemberID = 'NH202002031242' 
--set @OldNHMemberID = 'NH202106688683'


--Tinh Nguyen 03/28/1941
--set @NewNHMemberID = 'NH202002728804'
--set @OldNHMemberID = 'NH202005677528'

--Tinh Nguyen 03/28/1941
--set @OldNHMemberID = 'NH202002728804'
--set @NewNHMemberID = 'NH202005677528'

-- # 35176 | submitted for verification
--Gloria Campo
--NH202002031242 
--NH202106688683

--set @NewNHMemberID = 'NH202002031242' 
--set @OldNHMemberID = 'NH202106688683'

--35067
--set @OldNHMemberID = 'NH202106563816'
--set @NewNHMemberID = 'NH202002230578'

--35069
--set @OldNHMemberID = 'NH202002728804'
--set @NewNHMemberID = 'NH202005677528'

--35105
--set @OldNHMemberID = 'NH202002720744'
--set @NewNHMemberID = 'NH202106665883'

--35073
--set @OldNHMemberID = 'NH202106511216'
--set @NewNHMemberID = 'NH202001997695'

--35103
--set @OldNHMemberID = 'NH202106379445'
--set @NewNHMemberID = 'NH202106513722'

--set @OldNHMemberID = 'NH202001997695'
--set @NewNHMemberID = 'NH202106511216'