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

/* Work in Progress, the issue will be resolved by the end of day today. */

/*
insert into elig.MergedNHMemberIDS  
(createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid, provider_memberinsuranceid,OtcCardnumber, RequestedBy, Technician,	TicketNumber ) values 
(GETDATE(), 'NH202106687072', 'NH202106687083', '9895878, 10000889', '299635,347995' , null ,'sballa', 'sballa', 3000 ),
(GETDATE(), 'NH202106712141', 'NH202002559878', '9929280', '319015' , '6102812831001304785' ,'sballa', 'sballa', 37355 ),
*/

select * from elig.MergedNHMemberIDS where TicketNumber = 39081



/*
# 39267 Merge the account to resolve issue with Plan and order information
NH202106563792 -- CallCenter portal
NH202106563803 -- OTC_STORE

set @OldNHMemberID = 'NH202106563792'
set @NewNHMemberID = 'NH202106563803'

*/

/*
LETICIA ESTRADA-08.02.1954  
NH202002759821
NH202005646373
-- 36337
(GETDATE(), 'NH202002759821', 'NH202005646373', Null, Null, Null ,'sballa', 'sballa',  36337 ),

set @OldNHMemberID = 'NH202002759821'
set @NewNHMemberID = 'NH202005646373'
*/

/*
mbr name-libertad ruiz de martinez
dob-09.16.1943
NH202002718929
NH202005646527

-- 36336
(GETDATE(), 'NH202002718929', 'NH202005646527', Null, Null, Null ,'sballa', 'sballa',  36336 ),
*/


-- 45940
/*
Nancy Fitzpatrick - NH202005058950 (Keep)
Nancy Fitzpatrick - NH202002798539
(GETDATE(), 'NH202002798539', 'NH202005058950', Null, Null, Null ,'sballa', 'sballa',  45940 ),

( OldNHMemberID | NH202002798539 ), ( NewNHMemberID | NH202005058950 ), ( RequestedBy | sballa ), ( Technician | sballa ), ( TicketNumber | 36820 ), ( OldCardNumber | Not Found ), ( NewCardNumber | Not Found ), ( NewInsCarrierID | 16 ), ( NewInsHealthPlanID | 2810 ), ( OldInsCarrierID | Not Found ), ( OldInsHealthPlanID | Not Found ), ( NewProfileID | 338852 ), ( OldProfileID | 132208 ), 

*/
set @OldNHMemberID = 'NH202002798539' 
set @NewNHMemberID = 'NH202005058950'



/*
Hello!
I was working with a member Dolores Raffaele - NH202106780660 that had issues logging into their account on NationsOTC. 
I checked their plan details and it listed that it was on two accounts NH202106780660 and NH202106706733. 
The NH number that ends in 0660 has a different member id than the one provided by member which is: 120357100001.
Member was able to login but it will deny the first four digits initially but will take it the second time.

--  39224
(GETDATE(), 'NH202106780660', 'NH202106706733', '10008121', '352983', null ,'sballa', 'sballa',  39224 ),
set @OldNHMemberID = 'NH202106780660'
set @NewNHMemberID = 'NH202106706733'

*/



/*

Josephine Howard - NH202106665754
Josephine Howard - NH202106665688
-- 39261
(GETDATE(), 'NH202106665688', 'NH202106665754', '9868975', '293308', null ,'sballa', 'sballa',  39261 ),
set @OldNHMemberID = 'NH202106665688'
set @NewNHMemberID = 'NH202106665754'

*/




/*
NH202106776577 Old number: 6102812771000759300
NH202106915696.New number: 6102812771000900441
-- 39081
(GETDATE(), 'NH202106776577', 'NH202106915696', null, null, null ,'sballa', 'sballa',  39081 ),
set @OldNHMemberID = 'NH202106776577'
set @NewNHMemberID = 'NH202106915696'
*/



/*
-- 38892 | Have to be sent for verificaton
(GETDATE(), 'NH202106685040', 'NH202106685052', null, null , null ,'sballa', 'sballa', 38892 ),
04/01/1935
Thelma Asbury - NH202106685052
Thelma Asbury - NH202106685040
DOB - 04/01/1935
IBX - 121706713001
OTC - 6102812731004505976

set @OldNHMemberID = 'NH202106685040'
set @NewNHMemberID = 'NH202106685052'
*/



/*
Good afternoon, 
I have made this email to indicate duplicate accounts. 
The pair is for Thelma Mills [NH202106803757 + NH202002136645]. The member is with Wellcare; The later of the two accounts is showing that the member is with Healthfirst NY. I have included the member's account details below. Please let me know if there are any further questions. Thank you!
Afternoon team
Please assist with the account. 

Thank you  - 6363011131073831444 - (718) 953-2283
Member ID - N/A for Wellcare at the moment. 134374939 for Healthfirst NY (May be from last year)
Address - 1640 Sterling Place Apt 3-D, Brooklyn, NY - 11233
DOB - 10/08/1953
-- 38842 | Eligibility information is available, OTC store account will be merged into ELIG_HF account. OTC store account card will be deactivated and ELIG_HF will be activated.
(GETDATE(), 'NH202106803757', 'NH202002136645', '10034633', '361757' , '6363011131073831444' ,'sballa', 'sballa', 38842 ),
set @OldNHMemberID = 'NH202106803757'
set @NewNHMemberID = 'NH202002136645'

*/



/*
Ticket #  38910
Richard Sevigny - NH202005274037
Richard Sevigny - NH202002803366

(GETDATE(), 'NH202002803366', 'NH202005274037', null, null , null ,'sballa', 'sballa', 38910 ),


set @OldNHMemberID = 'NH202002803366'
set @NewNHMemberID = 'NH202005274037'
*/


/*
--38232
Mitza Centeno Melendez - NH202002809206 (Acct reflects “Members Support Program” amount of $100)
Mitza Centeno Melendez - NH202106891127 (recently create - with correct OTC card benefit amount of $125)

(GETDATE(), 'NH202106891127', 'NH202002809206', null, null , null ,'sballa', 'sballa', 38232 ),

set @OldNHMemberID = 'NH202106891127'
set @NewNHMemberID = 'NH202002809206'
*/



/*
Coral Bottaro  CCA    Member ID 5365607762, please merge accounts, unable to place order.

NH202106664875    
NH202002564295
--38783
(GETDATE(), 'NH202106664875', 'NH202002564295', '9867987', '291588' , null ,'sballa', 'sballa', 38783 ),
set @OldNHMemberID = 'NH202106664875'
set @NewNHMemberID = 'NH202002564295'
*/



/*
I accidently made a duplicate account for Joy McGrew Joy McGrew
-- 38514
NH202106893946
NH201901364929 -- Keep
set @OldNHMemberID = 'NH202106893946'
set @NewNHMemberID = 'NH201901364929'
(GETDATE(), 'NH202106893946', 'NH201901364929', null, null, null ,'sballa', 'sballa', 38514 ),
set @OldNHMemberID = 'NH202106893946'
set @NewNHMemberID = 'NH201901364929'

*/



/*
--38727
NH202002791822 -- new -- Eligibility File
NH202106538485 -- Old -- callcenter
NH202106690020 -- old -- callcenter

(GETDATE(), 'NH202106538485', 'NH202002791822', null,null, '6363012641019127391' ,'sballa', 'sballa', 38727 ),
(GETDATE(), 'NH202106690020', 'NH202002791822', null, null, null ,'sballa', 'sballa', 38727 ),

set @OldNHMemberID = 'NH202106538485'
set @NewNHMemberID = 'NH202002791822'

6363012641019127391 -- NH202106538485

set @OldNHMemberID = 'NH202106690020'
set @NewNHMemberID = 'NH202002791822'

*/



/*
-- 38515
Name: Veronica Waters
DOB: 11/20/1948
Address: 1310 South Ruby Street, Philadelphia, PA 19143
Plan Name: Health Partners Plans
Member ID#: 5619804

NH#: NH202106552986
OTC#: 6102812751005577659
Plan Name: Health Partners Plans
Plan#: 5619804  5619804
Effective From: 02/01/2021

Issues(s): 1) Plan# is duplicate - 2) account was created on 02/01/2021
NH#: NH202106631504 Correct ACCT
OTC#: 6102812751005577659
OTC orders processed under this account
Effective From: 1/22/21
Comment: suggesting to keep this account as OTC orders record is under this account and (2) catalog request history also under this account
(GETDATE(), 'NH202106552986', 'NH202106631504', '9637303', '216864' , null ,'sballa', 'sballa', 38515 ),

set @OldNHMemberID = 'NH202106552986'
set @NewNHMemberID = 'NH202106631504'


*/



/*
# 38493
Joanna Dombrowki - NH202106636236  
Mail in order form received to place otc order but member has duplicate accounts. Otc Card number is associated with NH202106721849.
(GETDATE(), 'NH202106636236', 'NH202106721849', '9834134', '273142' , null ,'sballa', 'sballa', 38493 ),
set @OldNHMemberID = 'NH202106636236'
set @NewNHMemberID = 'NH202106721849'
*/




/*
Member Name: SHEILA ATTONG 
NH202002826398 (Not Active Account)
Sheila Attong 
NH202005291299 (Active Account)
Health Care Plan: Aetna
Member Id: 101143876200

--# 38460
(GETDATE(), 'NH202002826398', 'NH202005291299', null, null , null ,'sballa', 'sballa', 38460 ),
set @OldNHMemberID = 'NH202002826398'
set @NewNHMemberID = 'NH202005291299'
*/



/*
--38401
NADINE LEE NH202106780192
NADINE LEE NH202106805154 (KEEP) -- 

(GETDATE(), 'NH202106780192', 'NH202106805154', null, null , null ,'sballa', 'sballa', 38401 ),

set @OldNHMemberID = 'NH202106780192'
set @NewNHMemberID = 'NH202106805154'

*/



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
-- 38409
Correct and current account w/ Quartz (NVA) health plan:
Jay Baukin - NH202106555967 -- Keep, has the latest order

duplicate/previous accounts:
Jay Baukin NH202002375196  -- First Account

duplicate/previous accounts:
Jay Baukin -NH202002411718  -- Second Account

Thank you,
Jeanette Rodriguez
-- Request a Merge between 3 accounts
(GETDATE(), 'NH202002375196', 'NH202106555967', null, null , null ,'sballa', 'sballa',  38409 ), -- old card is not present, no card to reassign to 
--First Card
set @OldNHMemberID = 'NH202002375196'
set @NewNHMemberID = 'NH202106555967'
--Second Card
set @OldNHMemberID = 'NH202002411718'
set @NewNHMemberID = 'NH202106555967'

(GETDATE(), 'NH202002411718', 'NH202106555967', null, null , null ,'sballa', 'sballa',  38409 ), - No need to change or reassign card
set @OldNHMemberID = 'NH202002411718'
set @NewNHMemberID = 'NH202106555967'
*/


/*
# 38345
Poonpoksua Nasakolnakorn - NH202002556034 
Poonpoksua Nasakolnakorn - NH202002556053 (KEEP)

insert into elig.MergedNHMemberIDS  
(createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid, provider_memberinsuranceid,OtcCardnumber, RequestedBy, Technician,	TicketNumber ) values 
(GETDATE(), 'NH202002556034', 'NH202002556053', '6884400', '90357', null ,'sballa', 'sballa', 38345 ),

set @OldNHMemberID = 'NH202002556034'
set @NewNHMemberID = 'NH202002556053'
*/





/*
Please merge the accounts below. Member is unable to access the OTC store. Thank you,
Barry Jacobs - NH202106640696
Barry Jacobs - NH202106640711

set @OldNHMemberID = 'NH202106640696'
set @NewNHMemberID = 'NH202106640711'
*/





/*
--37347
Barry Jacobs NH202106640711 11/11/1942 8900 Roosevelt Blvd, Apt 920, Philadelphia , PA, 19115 NationsOTC Program
Barry Jacobs NH202106640696 11/11/1942 8900 Roosevelt Blvd , Apt 920, Philadelphia , PA, 19115 NationsOTC Program
1248967780010 Plan or Program ID
1248967780010 Plan or Program ID
(GETDATE(), 'NH202106640696', 'NH202106640711', null, null , null ,'sballa', 'sballa', 37347 ),  -- Looks like the MemberID have been Merged already
set @OldNHMemberID = 'NH202106640696'
set @NewNHMemberID = 'NH202106640711'

*/



/*
Valerie Bentley 
NH202002809911 & 
NH202106641387
840 NE 90th Ave, Portland, OR - 97220
Phone : 503-607-6283
Date of Birth,May 12, 1957
Member ID # mzl0517a
Good  OTC card # 6363012910789908474
(GETDATE(), 'NH202002809911', 'NH202106641387', null, null , null ,'sballa', 'sballa', 37474 ), -- Two different card numbers are associate with the two cards

set @OldNHMemberID = 'NH202002809911'
set @NewNHMemberID = 'NH202106641387'
*/




/*
--38024
Hello team, please assist with merging the profiles we have for this member. She is unable to login and place an order. Thank you. 

CHERYLE EBINGER - NH202106687083
CHERYLE EBINGER - NH202106687072

(GETDATE(), 'NH202106687072', 'NH202106687083', null, null , null ,'sballa', 'sballa', 38024 ),
set @OldNHMemberID = 'NH202106687072'
set @NewNHMemberID = 'NH202106687083'
*/




/*
Please merge accounts as member is not able to place orders.
Margarita Adorno-Panpoja - NH202106561435
Margarita Adorno - NH202106692097

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values 
(GETDATE(), 'NH202106692097','NH202106561435',9906416,305006,null,'sballa','sballa', 38197)

set @OldNHMemberID = 'NH202106692097'
set @NewNHMemberID = 'NH202106561435'

*/



/*
LONNIE GAST - NH202005715612 
LONNIE GAST- NH202002728753
Member has a duplicate account Experience health

-- 38200 | Two different card numbers associated with the Member ID's
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values 

(GETDATE(), 'NH202002728753','NH202005715612',null,null,null,'sballa','sballa', 38200)

set @OldNHMemberID = 'NH202002728753'
set @NewNHMemberID = 'NH202005715612'

*/


/*
Valerie Bentley 
NH202002809911 & NH202106641387
840 NE 90th Ave, Portland, OR - 97220
Phone : 503-607-6283
Date of Birth
May 12, 1957
Member ID # mzl0517a
Good  OTC card # 6363012910789908474

-- 37474 | Two different card numbers associated with the Member ID's
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106548469','NH202106712170',null,null,null,'sballa','sballa', 37474)



*/


/*
IT
Can you have these accounts merged for this member please?
Ronald Norton - NH202106712170 *KEEP
Ronald Norton - NH202106548469 - duplicate

--37971 | Two different card numbers associated with the Member ID's
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106548469','NH202106712170',null,null,null,'sballa','sballa',37971)

set @OldNHMemberID = 'NH202106548469'
set @NewNHMemberID = 'NH202106712170'
*/




/*
Can you please merge these two accounts?
Luisa Salabarria NH202002604555 (KEEP) 
Luisa Salabarria NH202106636505
HP: Humana Custom

--37980 | Two different card numbers associated with the Member ID's
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106636505','NH202002604555',9834408,273737,null,'sballa','sballa',37980)

set @OldNHMemberID = 'NH202106636505'
set @NewNHMemberID = 'NH202002604555'

*/





/*
Good Morning.
Arlene Marquez -NH202106844553 and NH202106877544 
Please  merge these account
--38000 | Two different card numbers associated with the Member ID's
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106844553','NH202106877544',null,null,null,'sballa','sballa',38000)

set @OldNHMemberID = 'NH202106844553'
set @NewNHMemberID = 'NH202106877544'
*/





/*
Good morning,
To Whom It May Concern
Please assist in merging account, as we are not able to place order.
Member is Linda Swigonski - 
NH202002494279 + 
NH202002485823. OTC #6363011021091759778.
--38001
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002485823','NH202002494279',6022803,82120,null,'sballa','sballa',38001)
set @OldNHMemberID = 'NH202002485823'
set @NewNHMemberID = 'NH202002494279'

*/





/*
Good morning,
To Whom It May Concern
Please assist in merging accounts as we are not able to place order.
NH202106548121 & NH202106548065 Kathleen Torres.

--38007
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106548065','NH202106548121',9632148,209436,null,'sballa','sballa',38007)

set @OldNHMemberID = 'NH202106548065'
set @NewNHMemberID = 'NH202106548121'
*/




/*
--37867
Member Name: Patricia Misiolek 
NH202106721979- Current
NH202106722052-Old (Delete/Merge) -- Keep This 
Health Plan: BCBS MI
Member Id: 916295881
OTC Card #: 6102812771005961273
--37867
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106721979','NH202106722052',9940180,321039,null,'sballa','sballa',37867)

set @OldNHMemberID = 'NH202106721979'
set @NewNHMemberID = 'NH202106722052'
*/



/*
37881
Hello team, 
Please assist with merging the profiles below. Thank you.
LONNIE GAST - NH202005715612 --Keep
LONNIE GAST - NH202002728753
--37881
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002728753','NH202005715612',null,null,'6102812711005072630','sballa','sballa',37881)
set @OldNHMemberID = 'NH202002728753'
set @NewNHMemberID = 'NH202005715612'

*/




/*
Please assist with merging the profiles below. Thank you. 
Faye Eckely - NH202002612958 
Faye Eckely - NH202002612958 
*/





--36512
/*
Sandra Lucas
NH202106629729 (KEEP)
NH202106814003

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106814003','NH202106629729',10046170,371947, null,'sballa','sballa',36512)
*/





--36513
/*
Brenda Hale
NH202106682757- Order #200334188 on 03/15/2021 
NH202106792834

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106792834','NH202106682757',10022345,357869, null,'sballa','sballa',36513)

set @OldNHMemberID = 'NH202106792834'
set @NewNHMemberID = 'NH202106682757'

*/


--36574
/*
Please assist with merging the accounts below for William Bivens
NH202106805686
NH202106805695

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106805695','NH202106805686',10036708,364937, null,'sballa','sballa',36574)

set @OldNHMemberID = 'NH202106805695'
set @NewNHMemberID = 'NH202106805686'

*/



/*
--36592 | Merge Not required different insurance carriers
NH202106699368 
NH202106395269

ELIG_Aetna	NH202106699368
ELIG_FLBLUE	NH202106395269

--insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
--values (GETDATE(), 'NH202002820813','NH202005679449',9637370,217019, null,'sballa','sballa',36786)

set @OldNHMemberID = 'NH202106699368'
set @NewNHMemberID = 'NH202106395269'
*/




/*
36786
VIET PHAM - NH202005679449 (KEEP)
VIET PHAM - NH202002820813

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002820813','NH202005679449',null,null, null,'sballa','sballa',36786)
set @OldNHMemberID = 'NH202002820813'
set @NewNHMemberID = 'NH202005679449'
*/




/*
--36797
DIANN KENNEDY NH202005620365
Diann Kennedy NH202106656910

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106656910','NH202005620365',null,null, null,'sballa','sballa',36797)


set @OldNHMemberID = 'NH202106656910'
set @NewNHMemberID = 'NH202005620365'
*/

/*
37222
Blue cross blue sheild PA
Bernard Hurst - NH202106553053
2nd NH # NH202106733397

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106553053','NH202106733397',9637370,217019, null,'sballa','sballa',37222)
set @OldNHMemberID = 'NH202106553053'
set @NewNHMemberID = 'NH202106733397'

*/


/*
37256
Evelyn	Moore	NH202106507284	08/19/1952	111 East 18th St Apt 326 , NorFolk, VA, 23517	--	--	--
EVELYN	MOORE	NH202106520944	08/19/1952	111 E 18TH ST APT 326 , NORFOLK, VA, 23517	OptimaHealth		
This NH - NH202106520944 is the active account. 

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106507284','NH202106520944',null,null, null,'sballa','sballa',37256)

set @OldNHMemberID = 'NH202106507284'
set @NewNHMemberID = 'NH202106520944'

*/



--37294
/*
Zhanna Mirkin - NH202106538939 (Dupl)
Zhanna Mirkin - NH202106511377 (KEEP) 

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106538939','NH202106511377',9236076,204805, null,'sballa','sballa',37294)

set @OldNHMemberID = 'NH202106538939'
set @NewNHMemberID = 'NH202106511377'

*/


/*
37297
Barry Jacobs - NH202106640696
Barry Jacobs - NH202106640711

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106640696','NH202106640711',9839759,274954, null,'sballa','sballa',37297)

set @OldNHMemberID = 'NH202106640696'
set @NewNHMemberID = 'NH202106640711'

*/


/*
37298
Margarete Small - NH202106779734
Margarete Small - NH202106779740

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106779734','NH202106779740',7152000,165778, null,'sballa','sballa',37298)

set @OldNHMemberID = 'NH202106779734'
set @NewNHMemberID = 'NH202106779740'
*/



/*
37299
Rebecca Reisman - NH202002811600
Rebecca Reisman - NH202002822174

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202002811600','NH202002822174',7152000,165778, null,'sballa','sballa',37299)

set @OldNHMemberID = 'NH202002811600'
set @NewNHMemberID = 'NH202002822174'
*/

/*
37745 | Merge Happened multiple, This NH202106560968 is no more used for OTC
To Whom It May Concern
Please assist in merging accounts.
Nancy Molinaro   NH202106560968   
Nancy Molinaro   NH202106560989 -- Keep
*/


/*
37824
Sharon
Strachan
NH202106777585 (KEEP)
Sharon
Strachan
NH202106805220

set @OldNHMemberID = 'NH202106805220'
set @NewNHMemberID = 'NH202106777585'

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106805220','NH202106777585',10036217,363910, null,'sballa','sballa',37824)

*/

/*
Have to work on this request
# 37474
Valerie Bentley 
NH202002809911 & NH202106641387
840 NE 90th Ave, Portland, OR - 97220
Phone : 503-607-6283
Date of Birth
May 12, 1957
Member ID # mzl0517a
Good  OTC card # 6363012910789908474
*/




/*
--37711
Please assist with merging these accounts. Thank you.

Wilmou Christopher - NH202106658411
Wilmouth Christopher - NH202106575918

insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106658411','NH202106575918',9860800,284545, null,'sballa','sballa',37711)

set @OldNHMemberID = 'NH202106658411'
set @NewNHMemberID = 'NH202106575918'

*/




--37713
/*
NH202002612958 
NH202106560978
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106560978','NH202002612958',9648470,228801, null,'sballa','sballa',37713)

set @OldNHMemberID = 'NH202106560978'
set @NewNHMemberID = 'NH202002612958'
*/




--37745
/*
NH202106560968      
NH202106560989
insert into elig.MergedNHMemberIDS (createdate, OldNHMemberID, NewNHMemberID, master_memberinsuranceid,provider_memberinsuranceid, OtcCardnumber, RequestedBy, Technician, TicketNumber )
values (GETDATE(), 'NH202106814003','NH202106629729',9648461,228770, null,'sballa','sballa',37745)

set @OldNHMemberID = 'NH202106560968'
set @NewNHMemberID = 'NH202106560989'
*/




