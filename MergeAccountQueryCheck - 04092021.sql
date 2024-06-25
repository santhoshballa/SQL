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
declare @vOldMasterMemberInsuranceID bigint
declare @vOldProviderMemberInsuranceID bigint
declare @vOldCard nvarchar(20)
declare @vNewCard nvarchar(20)

declare @vMessage nvarchar(2000)
declare @vCount int

set @TicketNumber = '36820'
set @Technician = 'sballa'
set @RequestedBy = 'sballa'

set @OldNHMemberID = 'NH202002798539' 
set @NewNHMemberID = 'NH202005058950'

select @vOldCard = IsNull(CardNumber, '') from otc.Cards where NHMemberID = @OldNHMemberID -- Old Card
select @vNewCard = IsNull(CardNumber, '') from otc.Cards where NHMemberID = @NewNHMemberID -- Old Card
select @OldNHMemberID as OldNHMemberID, @NewNHMemberID as NewNHMemberID, @vOldCard as [otc.cards | Old Card], @vNewCard as [otc.cards | New Card]


select @vOldMasterMemberInsuranceID  =  cast(MemberInsuranceID as bigint) FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
                                     WHERE memberid IN (SELECT memberid FROM master.members 
                                                                       WHERE NHMemberid in (@OldNHMemberID)
                                                       )
                            )
--and OTCCardNumber is not null

select  @vOldProviderMemberInsuranceID = cast(MemberInsuranceID as bigint) FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN ( SELECT MemberInsuranceID FROM Provider.MemberInsurances 
                                     WHERE memberprofileid IN ( SELECT memberprofileid FROM provider.MemberProfiles
                                                                       WHERE NHMemberid in (@OldNHMemberID)
                                                                )
                            )
--and OTCCardNumber is not null

select @vOldMasterMemberInsuranceID as OldMasterMemberInsuranceID,  @vOldProviderMemberInsuranceID as OldProviderMemberInsuranceID

--select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @OldNHMemberID
----union all
--select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @NewNHMemberID


--Cards
select @OldNHMemberID as NHMemberID,  'otc.Cards.CardNumber' as TableName, 'Old Card' as CardType, CardNumber, IsActive from otc.Cards where NHMemberID = @OldNHMemberID
union
select @NewNHMemberID as NHMemberID,  'otc.Cards.CardNumber' as TableName, 'New Card' as CardType, CardNumber, IsActive from otc.Cards where NHMemberID = @NewNHMemberID



SELECT @OldNHMemberID as NHMemberID, 'Master.MemberInsuranceDetails.OTCCardNumber' TableName, 'Old Card' as CardType, [OTCCardNumber] as CardNumber, IsActive
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (@OldNHMemberID)
													   )
							)
and OTCCardNumber is not null
--and OTCCardNumber = @vOldCard
union all

SELECT @OldNHMemberID as NHMemberID, 'Provider.MemberInsuranceDetails.OTCCardNumber' TableName,'Old Card' as CardType, [OTCCardNumber] as CardNumber, IsActive 
FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN (SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@OldNHMemberID)
													   )
							)
--and OTCCardNumber is not null
--and OTCCardNumber = @vOldCard

union all
select @NewNHMemberID as NHMemberID,  'otc.Cards.CardNumber' as TableName, 'New Card' as CardType, CardNumber, IsActive from otc.Cards where NHMemberID = @NewNHMemberID

union all

SELECT @NewNHMemberID as NHMemberID, 'Master.MemberInsuranceDetails.OTCCardNumber' TableName, 'New Card' as CardType, [OTCCardNumber] as CardNumber, IsActive FROM [Master].[MemberInsuranceDetails]
WHERE MemberInsuranceID IN (SELECT ID FROM [Master].[MemberInsurances]  -- MemberInsuranceID is ID
									 WHERE MemberID IN (SELECT MemberID FROM master.members 
																	   WHERE NHMemberid in (@NewNHMemberID)
													   )
							)
--and OTCCardNumber is not null
--and OTCCardNumber = @vNewCard

union all

SELECT @NewNHMemberID as NHMemberID, 'Provider.MemberInsuranceDetails.OTCCardNumber' TableName,'New Card' as CardType,  [OTCCardNumber] as CardNumber, IsActive FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN (SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@NewNHMemberID)
													   )
							)
--and OTCCardNumber is not null
--and OTCCardNumber = @vNewCard


select
'insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber ) 
values (GETDATE(), ' 
+''''+ @OldNHMemberID +''''+ ',' 
+''''+ @NewNHMemberID +''''+ ',' 
+''''+ isNull(cast(@vOldMasterMemberInsuranceID as nvarchar),'Not Found') +''''+ ',' 
+''''+ isNull(cast(@vOldProviderMemberInsuranceID as nvarchar), 'Not Found') +''''+ ','
+''''+ IsNull (@vOldCard, 'Not Found') +''''+','
+''''+ @Technician +''''+ ',' 
+''''+ @Technician +''''+ ','
+ @TicketNumber + ')'


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
Print('@vOldCard | '+ isNull(cast(@vOldCard as nvarchar), 'Not Found in otc.cards'))
Print('@vNewCard | '+ isNull(cast(@vNewCard as nvarchar), 'Not Found in otc.cards'))

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


select @OldNHMemberID as NHMemberID, 'old' as Type, IsActive, * from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) and isActive = 1
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, IsActive, * from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) and isActive = 1

--Counts
select @OldNHMemberID as NHMemberID, 'old' as Type, 'Eligibility | elig.mstrEligBenefitData' as TableName, count(*) as IsAvailable from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @OldNHMemberID) and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Eligibility | elig.mstrEligBenefitData' as TableName,count(*) as IsAvailable  from elig.mstrEligBenefitData where NHLinkID = (select NHLinkID from master.members where NHMemberID = @NewNHMemberID) and IsActive = 1 union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'Eligibility | master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @OldNHMemberID  and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Eligibility | master.members' as TableName,count(*) as IsAvailable  from master.members where NHMemberID = @NewNHMemberID  and IsActive = 1 union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'Eligibility | provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID  = @OldNHMemberID and IsActive = 1  union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Eligibility | provider.MemberProfiles' as TableName,count(*) as IsAvailable  from provider.MemberProfiles where NHMemberID  = @NewNHMemberID and IsActive = 1  union all
select @OldNHMemberID as NHMemberID, 'old' as Type, 'OTC | otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @OldNHMemberID and IsActive = 1 union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'OTC | otc.cards' as TableName,count(*) as IsAvailable  from otc.cards where NHMemberID = @NewNHMemberID and IsActive = 1 union all

select  @OldNHMemberID as NHMemberID, 'old' as Type, 'Master | master.MemberInsuranceDetails' as TableName, count(*) as IsAvailable FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
                                     WHERE memberid IN (SELECT memberid FROM master.members 
                                                                       WHERE NHMemberid in (@OldNHMemberID)
                                                       )
                            )
and OTCCardNumber is not null
union all
SELECT  @OldNHMemberID as NHMemberID, 'new' as Type, 'Master | master.MemberInsuranceDetails' as TableName, count(*) as IsAvailable FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
                                     WHERE memberid IN (SELECT memberid FROM master.members 
                                                                       WHERE NHMemberid in (@NewNHMemberID)
                                                       )
                            )
and OTCCardNumber is not null
union all
-- Provider
SELECT @OldNHMemberID as NHMemberID, 'old' as Type, 'Provider | Provider.MemberInsuranceDetails' as TableName, count(*) as IsAvailable FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN ( SELECT MemberInsuranceID FROM Provider.MemberInsurances 
                                     WHERE memberprofileid IN ( SELECT memberprofileid FROM provider.MemberProfiles
                                                                       WHERE NHMemberid in (@OldNHMemberID)
                                                                )
                            )
and OTCCardNumber is not null
union all
-- Provider
SELECT @OldNHMemberID as NHMemberID, 'new' as Type, 'Provider | Provider.MemberInsuranceDetails' as TableName, count(*) as IsAvailable FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN ( SELECT MemberInsuranceID FROM Provider.MemberInsurances 
                                     WHERE memberprofileid IN ( SELECT memberprofileid FROM provider.MemberProfiles
                                                                       WHERE NHMemberid in (@NewNHMemberID)
                                                                )
                            )
and OTCCardNumber is not null

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
select @OldNHMemberID as NHMemberID, 'old' as Type,  'Orders.Orders' as TableName, OrderID, CreateDate from Orders.Orders where NHMemberID = @OldNHMemberID
union all
select @NewNHMemberID as NHMemberID, 'new' as Type, 'Orders.Orders' as TableName, OrderID, CreateDate from Orders.Orders where NHMemberID = @NewNHMemberID

--Cards
select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @OldNHMemberID
union
select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @NewNHMemberID



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
select @OldNHMemberID as NHMemberID, 'old' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @OldNHMemberID
union
select @NewNHMemberID as NHMemberID, 'new' as Type, 'otc.Cards' as TableName, CardNumber, IsActive from otc.Cards where NHMemberID = @NewNHMemberID


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

/*
-- Check NHMemberID using CardNumber in the Master and Provider 
declare @CardNumber varchar (20)
set @CardNumber = '6363012521033828515'

select 'All Master' as TableName, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
master.Members a left join Master.MemberInsurances b on a.MemberID = b.MemberID
left join Master.MemberInsuranceDetails c on b.ID = c.MemberInsuranceID
where c.OTCCardNumber in (@CardNumber)

select 'All Provider' as TableName, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
provider.MemberProfiles a left join provider.MemberInsurances b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberInsuranceDetails c on b.MemberInsuranceID = c.MemberInsuranceID
where c.OTCCardNumber in (@CardNumber)
*/

/* Call Conversation Notes
select * from auth.UserProfiles where username like '%puyo%'
-- CCPPuyo

select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 16, 52, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 17, 03, 00, 00, 00 )
or CreateUser like 'CCPPuyo' or MemberNHMemberID = 'NH201800642476'


select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 23, 59, 59, 00, 00 )
and CreateUser like 'CCPPuyo' and MemberNHMemberID = 'NH201800642476'

select MemberNHMemberID,AgentUserProfileName, CallEndSummary, CreateDate, CreateUser, EndCallSummaryEnd, EndCallSummaryStart 
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 16, 52, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 17, 03, 00, 00, 00 )
or MemberNHMemberID = 'NH201800642476'

*/





/*
37301
Laura Coleman - NH202106640825 -- Primary ( contains the latest order)
Laura Coleman - OTC201901954918 
Laura Coleman - NH202002555611
Laura Coleman - NH202002707302

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'OTC201901954918','NH202106640825',null,null,null,'sballa','sballa',37301)

set @OldNHMemberID = 'OTC201901954918'
set @NewNHMemberID = 'NH202106640825'

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002555611','NH202106640825',null,null,null,'sballa','sballa',37301)

set @OldNHMemberID = 'NH202002555611'
set @NewNHMemberID = 'NH202106640825'


insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002707302','NH202106640825',null,null,null,'sballa','sballa',37301)

set @OldNHMemberID = 'NH202002707302'
set @NewNHMemberID = 'NH202106640825'


*/


/*37305
Member Name: Mary Silas
NH202106848265 current OTC card
NH202106636217 expired otc card

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106636217','NH202106848265',null,null,null,'sballa','sballa',37305)

set @OldNHMemberID = 'NH202106636217'
set @NewNHMemberID = 'NH202106848265'
*/


--37341
/*
OTC Card# 6102812831006702975.  
Stephen Bieber - NH202002591219
Steve Bieber - NH202002550865. 
Member ID 5365585639.

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002550865','NH202002591219',6877427,89206,Null,'sballa','sballa',37341)

set @OldNHMemberID = 'NH202002550865'
set @NewNHMemberID = 'NH202002591219'


*/


--37347 | 
/*
Barry Jacobs - NH202106640696
Barry Jacobs - NH202106640711

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106640696','NH202106640711',9839759,274954,Null,'sballa','sballa',37347)

set @OldNHMemberID = 'NH202106640696'
set @NewNHMemberID = 'NH202106640711'
*/



--37356 | Both are from OTC_Store, Merge to the max number of orders
/* Changed the given Member ID's, to what to keep and Merge the other
NH202106846803 (keep) -- Merge this into the other
NH202002623491 -- This is what we will keep, has a number of orders

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106846803','NH202002623491',null,null,Null,'sballa','sballa',37356)

set @OldNHMemberID = 'NH202106846803'
set @NewNHMemberID = 'NH202002623491'
*/


-- 37348
/*
Please assist with members duplicate account, they need to be merged.
Doreen Harmon  NH202106567456 and   NH202106564055

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106564055','NH202106567456',9679878,235088,Null,'sballa','sballa',37348)

set @OldNHMemberID = 'NH202106564055'
set @NewNHMemberID = 'NH202106567456'
*/






/*
Shawn Gallagher - NH202106690953
Shawn Gallagher - NH202002802743
*/

-- 37147
/*
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002802743','NH202106690953',7142049,161927,Null,'sballa','sballa',37147)
*/


/*
37019
Rose Damm
NH202106557711
Rose Damm
NH202106628028 (KEEP)

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106557711','NH202106628028',Null,Null,Null,'sballa','sballa',37019)
--set @OldNHMemberID = 'NH202106557711'
--set @NewNHMemberID = 'NH202106628028'
*/



/*37021
Debra Staley
NH202106524354 (KEEP)

this account below is the duplicate
Debra Staley NH202002488395

--37021 | Two different cards
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002488395','NH202106524354',Null,Null,Null,'sballa','sballa',37021)

set @OldNHMemberID = 'NH202002488395'
set @NewNHMemberID = 'NH202106524354'
*/



/*37057
Yolanda Withers - NH202106531685
Yolanda Withers - OTC201901955531

set @OldNHMemberID = 'NH202106531685'
set @NewNHMemberID = 'OTC201901955531'

-- 37057 | Two different accounts
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106531685','OTC201901955531',Null,Null,Null,'sballa','sballa',37057)
*/




/*
Member Name: Coretta Rogers
Correct NH Account: NH202106557707
Old NH Account: NH202106557712


set @OldNHMemberID = 'NH202106557707'
set @NewNHMemberID = 'NH202106557712'

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106557707','NH202106557712',9642226,224472,Null,'sballa','sballa',37058)
*/



/* 37058
Member Name: Nancy Adair
NH202005659504 (Alignment ) Keep this NH Account
NH202106656310 (Nations OTC) Delete or Merge
NH20200247701 (Nations OTC) Delete or Merge

-- 37058, Three cards have to be Merged | 6363012451024303049 should be made inActive
-- This card is lost and is replaced, Inactivate this card 6363012451024303049

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106656310','NH202005659504',null,null,Null,'sballa','sballa',37058)

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002477701','NH202005659504',null,null,Null,'sballa','sballa',37058)

update otc set isActive = 0 from otc.cards otc where CardNumber = '6363012451024303049'

*/

-- update otc set isActive = 0 from otc.cards otc where CardNumber = '6363012451024303049'





/*
#36631
LUCY
NH201800426004 (old account)-- This memberID is from a different carrier
NH202002555187 (old account) -- This member ID is OK
NH202005648649 (correct alignment account)
*/

--set @OldNHMemberID = 'NH202002555187'
--set @NewNHMemberID = 'NH202005648649'

/*
Member Name:Jesus Barriga
Correct NH Account:NH202005637276
Alignment Health Plan
Old NH Account:####NH201800644003 and NH202002722066 ( NH201800644003 member ID belongs to a different insurance carrier )
Health Care Plan:Central Health Plan and Nations OTC
OTC Card: 6102812311050663894
Member Id:00000151414
*/

--set @OldNHMemberID = 'NH202002722066'
--set @NewNHMemberID = 'NH202005637276'


/*
#36584
Member Name:Amelia Marquez
Correct NH Account:NH202106571932
Old NH Account:NH202002466888
Health Care Plan: Alignment
OTC Card: 6102812311040303841
Member Id:00000178780
*/

--set @OldNHMemberID = 'NH202002466888'
--set @NewNHMemberID = 'NH202106571932'


/*
# 36587 | Merge is not required because they are from two different carriers
Member Name:Jorge Rodriguez Guardado
Correct NH Account:NH202005639065 - Alignment
Old NH Account:NH201800412877 – Central Health Plan
Health Care Plan: Alignment
OTC Card: 6102812311003705545
Member Id:00000110507
*/

--set @OldNHMemberID = 'NH201800412877'
--set @NewNHMemberID = 'NH202005639065'


/*
#36591
Member Name:Diana Mccutchen
Correct NH Account:NH202005620170 - Alignment
Old NH Account:NH202002756685- Nations OTC
Health Care Plan: Alignment
OTC Card: 6363012451086909030
Member Id: 00000135663
*/
 
--set @OldNHMemberID = 'NH202002756685'
--set @NewNHMemberID = 'NH202005620170'


/*
Duplicate accounts need merging.
Angelina Colon
NH202002741165
NH2002005607540-Alignment, this should be the correct account
--*/
--set @OldNHMemberID = 'NH202002741165'
--set @NewNHMemberID = 'NH2002005607540' -- incorrect ID Provided



/*
36513
Brenda Hale
NH202106682757- Order #200334188 on 03/15/2021 
NH202106792834
*/
--set @OldNHMemberID = 'NH202106792834'
--set @NewNHMemberID = 'NH202106682757'


/*
# 36512
This member has 2 NH #s. Can you please merge the two accounts
Sandra Lucas
NH202106629729 (KEEP)
NH202106814003

*/
--set @OldNHMemberID = 'NH202106814003'
--set @NewNHMemberID = 'NH202106629729'


--36389
/*
Member Name: Tina M King 
Correct NH Account: NH202002137557  (Healthfirst)
Old NH Account: NH202106810879 (Nations OTC)
Health Care Plan: Healthfirst (NY)
OTC Card: 6363011091015462353
Member Id: 114729211
*/

--set @OldNHMemberID = 'NH202106810879'
--set @NewNHMemberID = 'NH202002137557'




/*
--36388
Member Name: Maria Anguiano
Correct NH Account: NH202005653048   (Alignment)
Old NH Account: NH202002549329 (Nations OTC)
Health Care Plan: Alignment
*/

--set @OldNHMemberID = 'NH202002549329'
--set @NewNHMemberID = 'NH202005653048'

--36385
--set @OldNHMemberID = 'NH202106575397'
--set @NewNHMemberID = 'NH202106575504'


--36384
/*
Old NH Account: NH202002761010 (Nations OTC)
New NH Account: NH202001998459 (Healthfirst)
*/
--set @OldNHMemberID = 'NH202002761010'
--set @NewNHMemberID = 'NH202001998459'


-- 36379
--set @OldNHMemberID = 'NH202002822289'
--set @NewNHMemberID = 'NH202005614362'


---- 36376
--set @OldNHMemberID = 'NH202106766990'
--set @NewNHMemberID = 'NH202106799939'


-- 36314
--36313
--set @OldNHMemberID = 'NH201800427570'
--set @NewNHMemberID = 'NH202005657356'

--36312 
--set @OldNHMemberID = 'NH201800418835'
--set @NewNHMemberID = 'NH202005627626'

-- 36310
--set @OldNHMemberID = 'NH202002619738'
--set @NewNHMemberID = 'NH202005671544'

-- 36307
--set @OldNHMemberID = 'NH202106631649'
--set @NewNHMemberID = 'NH202106635209'

--35743
--set @OldNHMemberID = 'NH202002749921'
--set @NewNHMemberID = 'NH202002110352'



/*
Juanita Blake - NH201901966494 & NH202106688944
OTC CARD 610281275100668947
Member ID 5303563
Health Partners Medicare

--35498
set @OldNHMemberID = 'NH201901966494'
set @NewNHMemberID = 'NH202106688944'

*/

/*
--35316
hey I found a duplicate account
Marcial Matos - NH202002596000
1266 Delaware Ave , Fountain, PA - 18015386-216-7874
DUPLICATE ACCOUNT  
NH202002595980


set @OldNHMemberID = 'NH202002595980'
set @NewNHMemberID = 'NH202002596000'

*/


----35518
--set @OldNHMemberID = 'NH202002759857'
--set @NewNHMemberID = 'NH202002124001'

--35624
--set @OldNHMemberID = 'NH202106730667'
--set @NewNHMemberID = 'NH202106730672'


--35624
--set @OldNHMemberID = 'NH202106730667'
--set @NewNHMemberID = 'NH202106730672'


----35311
--set @OldNHMemberID = 'NH202106733324'
--set @NewNHMemberID = 'NH202002580869'


----35478
--set @OldNHMemberID = 'NH202002740638'
--set @NewNHMemberID = 'NH202005679035'

--set @TicketNumber = '35364'
--set @OldNHMemberID = 'NH202106503852'
--set @NewNHMemberID = 'NH202106513203'

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

 
 --34898
 /*
Marcia Kontney Has two accounts:
NH202106635376  -Correct account with confirmed OTC card number                                    
NH202106635230  -Incorrect account with G. Wallace’s OTC card number in it
*/

--set @OldNHMemberID = 'NH202106730667'
--set @NewNHMemberID = 'NH202106730672'

/*
Juanita Blake - NH201901966494 & NH202106688944
OTC CARD 610281275100668947
Member ID 5303563
Health Partners Medicare
*/



/*
Name: Karen Kummer
OTC: 6102812811009265774
Member ID:  C1111255001
Plan: iCare
Old :NH202106629739-C1111255001 not active, old
New :NH202106631805-iCare-active and up to date
*/



/*
--36804
NH202106745883 - KEEP
NH202106745891
*/


/* 	# 36809
Two accounts for MICHAEL CARSON
NH202106692617- Closed
NH202106692704 -Open
*/



/*
#36828
May Watson
NH202106703846
NH202106704169 (Keep)
*/


/*
--36807
NH202002415168 - new
NH202002415166 - old

*/

/*
36798
Lester Martin
NH202002415166 - old
08/10/1958
27 Aborn Rd , Ellington , CT, 06029
InComm OTC

LesterMartin
NH202002415168 - new
27 Aborn Rd , Ellington , CT, 06029
NationsOTC Program
*/

/*
----36312 | Merge Not Required | Member ID's from Eligibility
--set @OLDNHMemberID = 'NH201800418835'
--set @NEWNHMemberID = 'NH202005627626'


----36313 | Merge Not Required | Member ID's from Eligibility
--set @OLDNHMemberID = 'NH201800427570'
--set @NEWNHMemberID = 'NH202005657356'

--36314  | Merge Not Required | Member ID's from Eligibility
--set @OLDNHMemberID = 'NH201800418834'
--set @NEWNHMemberID = 'NH202005675653'

----36376 | Same Card Number, Contains two cards, Card update is not required
--set @OLDNHMemberID = 'NH202106766990'
--set @NEWNHMemberID = 'NH202106799939'

----36379 | 
--set @OLDNHMemberID = 'NH202002822289'
--set @NEWNHMemberID = 'NH202005614362'

--36384
--set @OLDNHMemberID = 'NH202002761010'
--set @NEWNHMemberID = 'NH202001998459'

--36385 | Old Card is already made void
--set @OLDNHMemberID = 'NH202106575397'
--set @NEWNHMemberID = 'NH202106575504'

--36388
--set @OLDNHMemberID = 'NH202002549329'
--set @NEWNHMemberID = 'NH202005653048'

--36389 | Old Card is already made void
--set @OLDNHMemberID = 'NH202106810879'
--set @NEWNHMemberID = 'NH202002137557'

--36583 | No need to make card inactive in , no need to update card number to new Member ID
--set @OLDNHMemberID = 'NH202002722066'
--set @NEWNHMemberID = 'NH202005637276'

--36591 |No need to make card inactive in , no need to update card number to new Member ID
--set @OLDNHMemberID = 'NH202002756685'
--set @NEWNHMemberID = 'NH202005620170'

--36631 | No need to make card inactive in , no need to update card number to new Member ID
--set @OLDNHMemberID = 'NH202002555187'
--set @NEWNHMemberID = 'NH202005648649'

*/


/*
#36820
NH202002419526 -- new
NH202002415521 -- old
*/


/* 36946
Carmen Torres NH202106655594, NH202106557619
*/
--set @OldNHMemberID = 'NH202106655594'
--set @NewNHMemberID = 'NH202106557619'


/*
OTC201901955452 (old profile, most recent order from 2019)
OTC201901961689 (appears to be current, multiple orders from this year)
*/
--set @OldNHMemberID = 'OTC201901955452'
--set @NewNHMemberID = 'OTC201901961689'


/*--36949
Lester Martin - NH202002415168 (KEEP)
Lester Martin - NH202002415166 
set @OldNHMemberID = 'NH202002415166'
set @NewNHMemberID = 'NH202002415168'
*/

--36958
/*
Joan Politi - NH202106548768 -- new
Joan Politi - NH202106575423 -- old
*/
----36958
--set @OldNHMemberID = 'NH202106575423'
--set @NewNHMemberID = 'NH202106548768'

