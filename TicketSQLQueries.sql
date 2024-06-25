select * from otc.cards where NHMemberId = 'NH202106878192'

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 359

update otc.cards set clientcarrierid = null where cardid = 265888


select * from otc.cards where NHMemberId = 'NH202106692204'

select * from elig.mstrEligBenefitData where firstname = 'Linda' and lastname = 'rowe' and isActive =1 and city = 'largo'

select * from master.members where Nhlinkid = '000304170'

--NH202106745467


select * from otc.cards where NHMemberID = 'NH202002851424'

select * from insurance.insurancecarriers where insuranceCarrierName like '%Nations%'

select * from otc.cards where clientcarrierid = 258 and NHMemberID = 'NH202001998459'

select * from auth.UserProfiles where firstname like '%William%' and lastname like '%Kirbow%'
UserProfileID = 9624, Username = 1912192386


select HCPID, FirstName, LastName, userprofileid, * from provider.HCPProviderProfile where userprofileid = 9624

FirstName	LastName	HCPID	userprofileid
William	Kirbow	6211	9624


SELECT * FROM [dbo].[ProviderDataHCPs] WHERE HCPId = 6211  
SELECT * from [dbo].[ProviderDataHCPMapping] WHERE HCPId = 6211


declare @FromOrder int, @ToOrder int
set @FromOrder = 200315711		-- OrderStatus	: Returned
set @ToOrder = 200461535		-- OrderStatus 	: Initiated

/*
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @FromOrder -- From Order
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @ToOrder -- To Order
select @ToOrder, 'PAY',JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),1,GETDATE(), 'rsareddy',GETDATE(),'cxavier',1 FROM orders.ordertransactiondetails WHERE 1=1 AND orderid = @FromOrder AND OrderStatusCode = 'PAY' AND IsActive = 1  -- Record to Insert



select a.*, b.* from 
insurance.InsuranceCarriers a inner join insurance.InsuranceHealthPlans b on a.InsuranceCarrierID = b.InsuranceCarrierID
where a.insurancecarrierName like '%Anthem%' and b.Healthplanname like '%Anthem%'

select * from insurance.insurancecarriers where insurancecarriername like '%Anthem Funded%'

select * from elig.mstreligbenefitdata where inscarrierid = 24


update master.members set isActive = 0 where NHmemberID = 'NH202106563792'
update provider.MemberProfiles set isActive = 0 where NHMemberId = 'NH202106563792'

--Update MemberInsuranceDetails to Inactivate
update Master.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from Master.MemberInsuranceDetails
where MemberInsuranceID = 9652187

update Master.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from Master.MemberInsuranceDetails
where MemberInsuranceID = 10190658

update provider.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
--select * from provider.MemberInsuranceDetails
where MemberInsuranceID = 231536

update provider.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from provider.MemberInsuranceDetails
where MemberInsuranceID = 420257

-- Make cardNumber null
update otc.cards set cardnumber = null where NHMemberID = 'NH202106563792'



select * from otc.cards where NHMemberId = 'NH202106563792' 
select * from otc.cards where cardnumber = '6102812731000010393'

select * from master.members where NHmemberID = 'NH202106563792'
select * from provider.MemberProfiles where NHmemberID = 'NH202106563792'

select * from otc.cards where NHMemberId = 'NH202106563792'
select * from otc.cards where NHmemberid = 'NH202106563803'

update master.members set isActive = 0 where NHmemberID = 'NH202106563792'
update provider.MemberProfiles set isActive = 0 where NHMemberId = 'NH202106563792'

--Update MemberInsuranceDetails to Inactivate
update Master.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from Master.MemberInsuranceDetails
where MemberInsuranceID = 9652187

update Master.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from Master.MemberInsuranceDetails
where MemberInsuranceID = 10190658

update provider.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') where 
--select * from provider.MemberInsuranceDetails
MemberInsuranceID = 231536
update provider.MemberInsuranceDetails set InsuranceNbr = concat(InsuranceNbr,'A') 
-- select * from provider.MemberInsuranceDetails
where MemberInsuranceID = 420257

-- Make cardNumber null
update otc.cards set cardnumber = null where NHMemberID = 'NH202106563792'
update master.members set isActive = 0 where NHmemberID = '6563792'
update provider.MemberProfiles set isActive = 0 where MemberProfileID = '184995'


select * from auth.userprofiles where username like '%turner%'


select * from information_schema.columns where column_name like '%catalog%' order by column_name
select * from information_schema.columns where table_schema like '%otccatalog%'

--Ticket # 39585

INSERT INTO provider.ProviderUserLocations SELECT 747,2144,(SELECT UserProfileId FROM [auth].[UserProfiles] WHERE 1=1 AND UserName='LKeenan') ,GETDATE(),CURRENT_USER,1,GETDATE(),CURRENT_USER


/*
Ticket # 39585
Please add location 8523 & 8705 to PCC’s portal access. Thank you!
Username: LoriBennington
ProviderCode: 180842
Email: lobg@hearinglife.com

select top 1 * from provider.ProviderUserlocations
select * from [auth].[UserProfiles] where UserName='JenniferLafave'
select UserProfileID, ProviderCode, (ProviderCode - 180000) as ProviderID, * from [auth].[UserProfiles] where UserName='JenniferLafave'
SELECT UserProfileId FROM [auth].[UserProfiles] WHERE 1=1 AND UserName='JenniferLafave'
--12432

select * from provider.ProviderUserLocations where 1=1 
and providerid = 1112 
and LocationId in (16332, 12650, 4066, 4067) 
and UserProfileID = 10123
order by ModifyDate desc

*/

INSERT INTO provider.ProviderUserLocations SELECT 842,8523,(SELECT UserProfileId FROM [auth].[UserProfiles] WHERE 1=1 AND UserName='LoriBennington') ,GETDATE(),CURRENT_USER,1,GETDATE(),CURRENT_USER
INSERT INTO provider.ProviderUserLocations SELECT 842,8705,(SELECT UserProfileId FROM [auth].[UserProfiles] WHERE 1=1 AND UserName='LoriBennington') ,GETDATE(),CURRENT_USER,1,GETDATE(),CURRENT_USER




Ticket # 39674
Please transfer funds ($1000 out of $1500 total) from both order #s 200385782 and 200273809 to order # 200478863.

declare @FromOrder int, @ToOrder int
set @FromOrder = 200273809		-- OrderStatus	: Returned
set @ToOrder = 200478863		-- OrderStatus 	: Initiated

--/*
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @FromOrder -- From Order
select OrderID, OrderStatusCode, OrderTransactionData, IsComplete, CreateDate, CreateUSer, CreateDate, ModifyDate, isActive from Orders.OrderTransactionDetails where OrderID = @ToOrder -- To Order
select @ToOrder, 'PAY',JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),1,GETDATE(), 'rsareddy',GETDATE(),'cxavier',1 FROM orders.ordertransactiondetails WHERE 1=1 AND orderid = @FromOrder AND OrderStatusCode = 'PAY' AND IsActive = 1  -- Record to Insert
*/

INSERT INTO orders.ordertransactiondetails
SELECT @ToOrder, -- To Order
'PAY',
--OrderTransactionData,
JSON_MODIFY(OrderTransactionData,'$.transactions[0].transactionOrderRef',@ToOrder),   -- To Order
1,
GETDATE(), 
'rsareddy',
GETDATE(),
'cxavier',
1
FROM orders.ordertransactiondetails 
WHERE 1=1
AND orderid = @FromOrder              -- From Order
AND OrderStatusCode = 'PAY'
AND IsActive = 1

--From
select orderid, orderstatuscode, ordertransactiondata from orders.ordertransactiondetails where orderid in (200385782,200273809) and OrderStatusCode = 'PAY'
select orderid, orderstatuscode, ordertransactiondata from orders.ordertransactiondetails where orderid in (200385782,200273809) and OrderStatusCode = 'RET'

--to
select orderid, orderstatuscode, ordertransactiondata from orders.ordertransactiondetails where orderid in (200478863) and OrderStatusCode = 'RET'





-- Ticket # (37576, 37530, 37467,37465,37464, 37418  )
DELETE 
-- SELECT *
FROM otc.UserProfileSecretAnswers WHERE UserProfileId in (SELECT UserProfileId FROM otc.UserProfiles 
WHERE nhmemberId in ( 'NH202002821948' ))

 DELETE 
-- SELECT *
FROM otc.UserProfiles WHERE nhmemberId in ( 'NH202002821948' )


Ticket # 40512

select * from auth.userprofiles where firstname like '%Jorge%' and lastname like '%Estevez%'

select * from orders.orders where orderid in (200487222)


/*
Ticket # 40617
We remove the member from QMB status by assigning the NHMemberID to a different default ID ( 'NH202002615437' | Raj)

select * from master.QMBMembers where NHMemberID = 'NH202005227609' order by CreateDate Desc
select id, insuranceNbr, NHMemberID, * from master.QMBMembers where NHMemberID in ('NH202002615437', 'NH202005227609')
select * from master.QMBMembers where NHMemberID = 'NH202002615437' order by CreateDate Desc -- The ID belongs to Raj by default
*/

update master.QMBMembers
set InsuranceNbr = '101122113900A',   -- InsuranceNbr
NHMemberID = 'NH202002615437'   -- Raj's ID always
-- select * from master.QMBMembers
where id in (37566,61098,155154)
and NHMemberID = 'NH202005227609' -- To Member to Remove

select top 10 * from master.QMBMembers order by CreateDate desc
select count(*) from master.QMBMembers


Jerry Thompson
select * from master.members where firstname like 'Jerry' and lastname like 'Thompson' and DateOfBirth =  '03/30/1939'


select * from auth.userprofiles where firstname like '%Mark%' and lastname like '%Baker%'
select * from elig.mstrEligBenefitData where FirstName = 'Glenn' and lastname like 'Owen'

-- Search Member using First and Last Name
select 'elig.mstrEligBenefitData' as TableName, mstrEligID, a.NHlinkID, b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID
-- a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) 
and a.FirstName = 'Glenn' and a.lastname like 'Owen'
order by a.mstrEligID desc


-- Search Member using First and Last Name
select 'elig.mstrEligBenefitData' as TableName, mstrEligID, a.NHlinkID, b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID
-- a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) 
and a.FirstName = 'Sharon' and a.lastname like 'Alexander' and a.DOB = '12/06/1943'
order by a.mstrEligID desc


Phyllis Marks

select 'elig.mstrEligBenefitData' as TableName, mstrEligID, a.NHlinkID, b.NHMemberid, a.Isactive, a.CreateDate, a.ModifyDate, a.dataSource, a.benefitstartdate, a.benefitenddate, a.recordEffDate, a.recordEndDate, a.firstname, a.lastname,  a.subscriberID, a.DOB, a.Isactive,    a.MasterMemberID, a.MemberInsuranceID, a.insCarrierID, a.insHealthPlanId, a.*
from elig.mstrEligBenefitData a , Master.members b 
where a.NHLinkID = b.NHLinkID
-- a.NHlinkID in (select b.NHLinkid from master.members where b.NHMemberID in (select NHmemberid from #NHmemberIDTemp )) 
and a.FirstName = 'Phyllis' and a.lastname like 'Marks' -- and a.DOB = '11/19/1956' 
order by a.mstrEligID desc



------ Start Ticket 40786 ------

-- Data from the 'Roster'
select
a.HCPID, d.providerid, c.locationid, 
a.HCPID, a.LocationID, a.NPINumber, a.HCPStatus, a.Classification, a.[First Name], a.[Last Name], a.LegalBusinesName,
/*
case (a.Classification)
	when 'AUD' Then 'AUD'
	when 'Central Time Zone' Then 'Central Time Zone'
	when 'D.O.' Then 'DO'
	when 'Fitter' then 'Fitter'
	when 'HAD' then 'HAD'
	when 'HAF' then 'HAF'
	when 'HAS' then 'HAS'
	when 'HID' then 'HID'
	when 'HIS' then 'His'
	when 'HS' then 'HS'
	when 'MD' then 'MD'
	when 'Specialist' then 'Specialist'
	else 'None'
end  as Classification,
*/
b.HCPID, b.IsActive, b.Classification, b.FirstName, b.LastName, b.NPINumber, b.LicenseNumber1, b.CredentialDate,
c.Providerid, c.LocationID, c.IsActive, c.ProviderDBA, c.NPINumber, c.Address1, c.Address2, c.City, c.State, c.Zip, c.TimeZone, c.LocationEmailAddress, c.LegalBusinessName, c.TaxID,
d.ProviderID, d.IsActive,  d.LegalBusinessName, d.OwnerLastName, d.OwnerFirstName, d.PrimaryEmailAddress, d.BillingAddress, d.BillingCity, d.BillingState, d.BillingZip, d.BillingCounty

from ProviderDataHCPMapping a
left join ProviderDataHCPs b on a.HCPID = b.HCPID
left join ProviderDataLocations c on a.LocationID = c.locationid
left join ProviderDataProviders d on c.providerid = d.providerid
where 1=1 
and a.HCPID in ( 2648, 7321, 7856)
and c.locationid in ( 24469)
--and d.providerid in (1648)
order by c.locationid


-- Step 1 | Check for the Provider UserProfileID and ProviderCode in the auth.UserProfiles
select '[auth.UserProfiles]' as TableName,UserProfileID, ProviderCode,IsActive,  * from auth.UserProfiles 
where 1=1 
--and UserProfileID = 11073 
and ProviderCode = 181835
--and (FirstName like '%Greggory%' and LastName like '%Richardson%') 
--or (Username like '%Andrew%' or UserName like '%Keiner%')
and ProviderCode is not null -- A Providercode has to be present, cannot be null.
and UserProfileID is not null


-- Step 2 | Check for the HCP ID
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileID, HCPID, ISActive, * from provider.HCPProviderProfile 
where FirstName like '%Greggory%' and LastName like '%Richardson%' 
--or UserProfileID = '11073' 
--or HCPID ='6803'
--11073,6803




-- You will need UserProfileID and the ProviderCode or ProviderID
select '[provider.providerProfiles]' as TableName, 'CRM' as 'FromCRM', ProviderID, DBA, IsActive, NPINumber, ProviderName, ProviderCode, ProviderDomain from provider.providerProfiles where providerid in ( 1835 )
select '[provider.HCPProviderProfile]' as TableName, 'CRM' as 'FromCRM', UserProfileId,HCPId,FirstName,LastName,IsActive from provider.HCPProviderProfile where UserProfileId IN (4353) --,12458,12741,14019)
select '[provider.ProviderUsers]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,IsActive from provider.ProviderUsers where UserProfileId IN (4353 ) --,12458,12741,14019)
select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM',ProviderID, LocationID, IsActive, * from Provider.ProviderLocations where ProviderID in ( 1835 ) and locationid in (24469)
select '[provider.ProviderUserLocations]' as TableName, 'CRM' as 'FromCRM', UserProfileId,ProviderId,LocationId,IsActive from provider.ProviderUserLocations where UserProfileId IN (4353 ) and locationid in (24469) --,12458,12741,14019)

------END Ticket 40786------


--Ticket # 40773

select * from auth.UserProfiles where firstname like '%kathleen%' and LastName like '%favor%'
select * from auth.UserProfiles where firstname like '%santhosh%' and LastName like '%balla%'

select * from auth.UserProfileSecretAnswers where UserProfileId = 10114
select * from auth.userprofiles where username like '%sballa%'
select * from auth.userprofiles where username like '%%'

select * from auth.UserProfiles where firstname in ('santhosh', 'Jitender')

select * from auth.UserProfileGroups where userprofileid in (12913,10985)

select * from auth.UserProfiles where Isregister = 0

select * from provider.locations where  zip = 47830
select City, State, zip, latitude, Longitude from provider.Locations where zip = 47830


select '[Provider.ProviderLocations]' as TableName,'CRM' as 'FromCRM', * from Provider.ProviderLocations where  locationid in 
(15842,15843,15844,15845,15846,15847,15848,15849,15850,15851,15852,15853,15854,15855,15856,15857,15858,15859,15860,15861,15862,15863,15864,15865,15866,15867,15868,15869,15870,15871,15872,15873,15874,15875,15876,15877,15878,15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15891,15892,15893,15894,15895,15896,15897,15898,15899,15900,15901,15902,15903,15904,15905,15906,15907,15908,15909,15910,15911,15912,15913,15914,15915,15916,15917,15918,15919,15920,15921,15922,15923,15924,15925,15926,15927,15928,15929,15930,15931,15932,15933,15934,15935,15936,15937,15938,15939,15940,15941,15942,15943,15944,15945,15946,15947,15948,15949,15950,15951,15952,15953,15954,15955,15956,15957,15958,15959,15960,15961,15962,15963,15964,15965,15966,15967,15968,15969,15970,15971,15972,15973,15974,15975,15976,15977,15978,15979,15980,15981,15982,15983,15984,15985,15986,15987,15988,15989,15990,15991,15992,15993,15994,15995,15996,15997,15998,15999,16000,16001,16016,16017,16018,16019,16021,16022,16023,16024,16025,16026,16027,16028,16029,16030,16031,16032,16033,16034,16035,16036,16037,16038,16039,16040,16041,16042,16043,16044,16045,16046,16047,16048,16049,16050,16051,16052,16053,16054,16055,16056,16057,16058,16059,16060,16061,16062,16063,16064,16065,16066,16067,16068,16069,16070,16071,16072,16073,16074,16075,16076,16077,16078,16079,16080,16081,16082,16083,16084,16085,16086,16087,16088,16089,16090,16091,16092,16093,16094,16095,16096,16097,16098,16099,16100,16101,16102,16103,16104,16105,16106,16107,16108,16109,16110,16111,16112,16113,16114,16115)

select '[dbo.ProviderDataLocations]' as TableName,'Roster' as 'FromRoster' , * from [dbo].[ProviderDataLocations] where locationID in 
(15842,15843,15844,15845,15846,15847,15848,15849,15850,15851,15852,15853,15854,15855,15856,15857,15858,15859,15860,15861,15862,15863,15864,15865,15866,15867,15868,15869,15870,15871,15872,15873,15874,15875,15876,15877,15878,15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15891,15892,15893,15894,15895,15896,15897,15898,15899,15900,15901,15902,15903,15904,15905,15906,15907,15908,15909,15910,15911,15912,15913,15914,15915,15916,15917,15918,15919,15920,15921,15922,15923,15924,15925,15926,15927,15928,15929,15930,15931,15932,15933,15934,15935,15936,15937,15938,15939,15940,15941,15942,15943,15944,15945,15946,15947,15948,15949,15950,15951,15952,15953,15954,15955,15956,15957,15958,15959,15960,15961,15962,15963,15964,15965,15966,15967,15968,15969,15970,15971,15972,15973,15974,15975,15976,15977,15978,15979,15980,15981,15982,15983,15984,15985,15986,15987,15988,15989,15990,15991,15992,15993,15994,15995,15996,15997,15998,15999,16000,16001,16016,16017,16018,16019,16021,16022,16023,16024,16025,16026,16027,16028,16029,16030,16031,16032,16033,16034,16035,16036,16037,16038,16039,16040,16041,16042,16043,16044,16045,16046,16047,16048,16049,16050,16051,16052,16053,16054,16055,16056,16057,16058,16059,16060,16061,16062,16063,16064,16065,16066,16067,16068,16069,16070,16071,16072,16073,16074,16075,16076,16077,16078,16079,16080,16081,16082,16083,16084,16085,16086,16087,16088,16089,16090,16091,16092,16093,16094,16095,16096,16097,16098,16099,16100,16101,16102,16103,16104,16105,16106,16107,16108,16109,16110,16111,16112,16113,16114,16115)

select * from provider.locations where locationid in 
(15842,15843,15844,15845,15846,15847,15848,15849,15850,15851,15852,15853,15854,15855,15856,15857,15858,15859,15860,15861,15862,15863,15864,15865,15866,15867,15868,15869,15870,15871,15872,15873,15874,15875,15876,15877,15878,15879,15880,15881,15882,15883,15884,15885,15886,15887,15888,15889,15890,15891,15892,15893,15894,15895,15896,15897,15898,15899,15900,15901,15902,15903,15904,15905,15906,15907,15908,15909,15910,15911,15912,15913,15914,15915,15916,15917,15918,15919,15920,15921,15922,15923,15924,15925,15926,15927,15928,15929,15930,15931,15932,15933,15934,15935,15936,15937,15938,15939,15940,15941,15942,15943,15944,15945,15946,15947,15948,15949,15950,15951,15952,15953,15954,15955,15956,15957,15958,15959,15960,15961,15962,15963,15964,15965,15966,15967,15968,15969,15970,15971,15972,15973,15974,15975,15976,15977,15978,15979,15980,15981,15982,15983,15984,15985,15986,15987,15988,15989,15990,15991,15992,15993,15994,15995,15996,15997,15998,15999,16000,16001,16016,16017,16018,16019,16021,16022,16023,16024,16025,16026,16027,16028,16029,16030,16031,16032,16033,16034,16035,16036,16037,16038,16039,16040,16041,16042,16043,16044,16045,16046,16047,16048,16049,16050,16051,16052,16053,16054,16055,16056,16057,16058,16059,16060,16061,16062,16063,16064,16065,16066,16067,16068,16069,16070,16071,16072,16073,16074,16075,16076,16077,16078,16079,16080,16081,16082,16083,16084,16085,16086,16087,16088,16089,16090,16091,16092,16093,16094,16095,16096,16097,16098,16099,16100,16101,16102,16103,16104,16105,16106,16107,16108,16109,16110,16111,16112,16113,16114,16115)


--Ticket # 40773


--# 39878

select * from information_schema.columns where column_name like  '%wallets%'

select top 10 * from otccatalog.wallets
select top 10 * from otccatalog.GetPlanWalletMap


select 
--a.*, b.*,c.*, d.* ,
a.Walletid, c.InsuranceCarrierID, d.InsuranceHealthPlanID,
a.WalletName, b.WalletSource,b.DisplayWalletName, c.InsuranceCarrierName, d.HealthPlanName
from
otccatalog.GetPlanWalletMap a left join otccatalog.wallets b on a.walletid = b.walletid
left join insurance.insuranceCarriers c on a.InsuranceCarrierid = c.InsuranceCarrierID
left join insurance.InsuranceHealthPlans d on a.InsuranceHealthPlanID = d.InsuranceHealthPlanID
where 1=1 and
a.walletid = 1 or a.walletName like '%All%Products%'
and (c.InsuranceCarrierID = 258 or c.InsuranceCarrierName like '%All%Products%')
and (d.InsuranceHealthPlanID is null or d.InsuranceHealthPlanID = -1 )
order by a.walletId asc

select distinct insurancecarriername from insurance.insuranceCarriers
select * from insurance.insuranceCarriers where insurancecarriername like '%health%first%'
--362

--# 39878


--Battery Configuration
INSERT [SupplOrders].[PlanItemsConfig] ([ItemMasterID], [InsuranceCarrierID], [InsuranceHealthPlanID], [CreateUser], [CreateDate], [ModifyUser], [ModifyDate], [IsActive], [Price]) 
VALUES (1, 281, NULL, N'mnanduri', CAST(N'2021-06-21T16:57:04.350' AS DateTime), N'mnanduri',CAST(N'2021-06-21T16:57:04.350' AS DateTime), 1, NULL)


INSERT [SupplOrders].[PlanItemsConfig] ([ItemMasterID], [InsuranceCarrierID], [InsuranceHealthPlanID], [CreateUser], [CreateDate], [ModifyUser], [ModifyDate], [IsActive], [Price]) 
VALUES (1, 281, NULL, N'mnanduri', getdate(), N'mnanduri',getdate(), 1, NULL)
--Battery Configuration



select * from auth.userprofiles where firstname like '%Kathleen%' and lastname like '%favor%'


--Ticket 38854
FRANCES
SAFFORD
NH202106584711	
01/31/1961	33734 DUNCAN AVENUE, FRASER, MI, 48026	
HAP Medicare
101572830


--Ticket 38854


select * from orders.orders where NHMemberID = 'NH202005659370' and orderid = '200529686'
select * from orders.orderItems where orderid = '200529686'
select * from orders.ordertransactiondetails where orderid ='200529686'
select * from orders.orderPOs where orderid = '200529686'
select * from orders.ordertracking where orderid = '200529686'

select * from information_schema.columns where column_name like 'orderID' and table_Schema = 'orders' order by table_name

/*
Ticket # 39450

select distinct insurancecarriername from insurance.insuranceCarriers
select * from insurance.insuranceCarriers where insurancecarriername like '%health%first%'

select * from insurance.insurancehealthplans where healthplanname like '%H2563_017_001 Optima Medicare Value HMO%'
select * from insurance.insurancecarriers where insurancecarrierid = 278

INSERT [SupplOrders].[PlanItemsConfig] ([ItemMasterID], [InsuranceCarrierID], [InsuranceHealthPlanID], [CreateUser], [CreateDate], [ModifyUser], [ModifyDate], [IsActive], [Price]) 
VALUES (1, 278, NULL, N'mnanduri', getdate(), N'mnanduri',getdate(), 1, NULL)

*/

Ticket# 41176
update c set ClientCarrierId = 359 from otc.Cards c where NHMemberId  = 'NH202107012042' and CardNumber = '6363012581012877636'

Ticket 41033 
update c set NHMemberId = 'NH202106825677', ClientCarrierId = 359 from otc.Cards c where CardNumber = '6102812731007798271'





select * from elig.mstrEligBenefitData where datasource = 'ELIG_CCARE' and inscarrierid = 292 and insHealthPlanID = 3315
select * from master.members where NHLinkID in (select NHLinkID from elig.mstrEligBenefitData where datasource = 'ELIG_CCARE' and inscarrierid = 292 and insHealthPlanID = 3315)
and NHMemberID in ( 'NH202002517664')

select * from orders.orders where NHMemberID in (select NHMemberID from master.members where NHLinkID in (select NHLinkID from elig.mstrEligBenefitData where datasource = 'ELIG_CCARE' and inscarrierid = 292 and insHealthPlanID = 3315))

select * from orders.orders where orderid = 200528206
select * from orders.OrderItems where orderid =  200528206

select * from insurance.InsuranceHealthPlans where HealthPlanName like '%Connecti%'
select distinct insuranceCarrierID, insurancecarriername from insurance.InsuranceCarriers where insurancecarrierid in (select insurancecarrierid from  insurance.InsuranceHealthPlans where HealthPlanName like '%Connecti%')
select distinct insuranceCarrierID, HealthPlanName, HealthPlanNumber from insurance.InsuranceHealthPlans where HealthPlanName like '%Connecti%'


DELETE 
-- SELECT *
FROM otc.UserProfileSecretAnswers WHERE UserProfileId = (SELECT UserProfileId FROM otc.UserProfiles WHERE nhmemberId = 'NH201800389772')

DELETE 
-- SELECT *
FROM otc.UserProfiles WHERE nhmemberId = 'NH201800389772'



select * from otc.UserProfiles where firstname like 'Dawn' Brown

select * from auth.UserProfiles where FirstName like '%Dawn%' or lastname like '%Brown%'

DELETE 
-- SELECT *
FROM otc.UserProfileSecretAnswers WHERE UserProfileId = (SELECT UserProfileId FROM otc.UserProfiles WHERE nhmemberId = 'NH202002319401')

 DELETE 
-- SELECT *
FROM otc.UserProfiles WHERE nhmemberId = 'NH202002319401'


EXEC [support].[ResetHCPCredentials]  'HIS', 'sforrest@beltoneamerica.com', '180609', 'StephanieForrest', 735 --Account Reset

update master.memberinsurances set IsActive = 0 where id = 6060860
update master.memberinsurances set InsuranceEndDate = '12-31-2019'  where id = 6060860

update master.memberinsurances set IsActive = 0 where id = 8328353
update master.memberinsurances set InsuranceEndDate = '12-31-2019' where id = 8328353

update provider.memberinsurances set IsActive = 0 where MemberInsuranceID = 443859
update provider.memberinsurances set InsuranceEndDate = '12-31-2019'  where MemberInsuranceID = 443859

update provider.memberinsurances set IsActive = 0 where MemberInsuranceID = 443860
update provider.memberinsurances set InsuranceEndDate = '12-31-2019'  where MemberInsuranceID = 443860


INSERT [SupplOrders].[PlanItemsConfig] ([ItemMasterID], [InsuranceCarrierID], [InsuranceHealthPlanID], [CreateUser], [CreateDate], [ModifyUser], [ModifyDate], [IsActive], [Price]) 
VALUES (1, 281, NULL, N'mnanduri', CAST(N'2021-06-21T16:57:04.350' AS DateTime), N'mnanduri',CAST(N'2021-06-21T16:57:04.350' AS DateTime), 1, NULL)


INSERT [SupplOrders].[PlanItemsConfig] ([ItemMasterID], [InsuranceCarrierID], [InsuranceHealthPlanID], [CreateUser], [CreateDate], [ModifyUser], [ModifyDate], [IsActive], [Price]) 
VALUES (1, 281, NULL, N'mnanduri', getdate(), N'mnanduri',getdate(), 1, NULL)



/*
Ticket No # 42522

/****** Object:  StoredProcedure [SupplOrders].[sp_GetSuppleOrderitems]    Script Date: 7/23/2021 10:47:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 /* 
-- =============================================                                    
-- Author:      Baji Thota                                     
-- Create Date: 10/14/2020                                    
-- Description: Get Suppleorder Items           
-- ============================================= --    
--EXEC SupplOrders.[sp_GetSuppleOrderitems] 'OTC',258,2433,'NH202106672039'      
-- =============================================    '

-- Modified By: Ramakrishna P
-- Modified Date: 17th March 2021 
-- Modified Date: 04/07/2021 Added top 1 and order by while fetching Client CarrieriD


  */
--CREATE PROCEDURE [SupplOrders].[sp_GetSuppleOrderitems] (

-- Contains 4 catalogs for alignment
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '302'     
 --declare @InsurenceHealthPlanId BIGINT = '2692' 
 --declare @NhMemberId varchar(50)= 'NH202005680622'    


 --Ticket # 42522
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '373'     
 --declare @InsurenceHealthPlanId BIGINT = '3971' 
 --declare @NhMemberId varchar(50)= 'NH202107098791'    

 /*
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID = 258
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) and InsuranceHealthPlanID  = 2433 --and IsActive = 1

select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc
select * from otc.cards where NHMemberID =  'NH202107098791'


 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202107098791'    
 */
 
 /*
 The insuranceCarrierID in the master insurance table and the client Carrier ID in the otc.cards can be different. This is to make the UI work as intended.

 */

 select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)
--and a.IsActive in ( 1)
 
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in ( 258, 155, 373)
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) -- and InsuranceHealthPlanID  = 2433 --and IsActive = 1
select * from otc.cards where NHMemberID =  'NH202106779994'
-- select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc



 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202106779994' 

 select * from [supplOrders].[PlanItemsConfig] where ItemmasterID =3
 select * from  [supplOrders].[PlanItemsConfig] where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 --update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 
    
BEGIN    
     declare @CliendCarrierId BIGINT;    
  -- Added by suneetha to cliend id for nations otc    
 set @CliendCarrierId =(select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by 1 desc );
 if @CliendCarrierId is Not null    
 begin    
    
 set @InsurenceCarrierId=@CliendCarrierId ;
 --Ramu commented out. 3/26    
 --set @InsurenceHealthPlanId =Null;    
 end    
 print @InsurenceCarrierId     
     
 DECLARE @PriceCalculations TABLE (    
  itemcode NVARCHAR(100),    
  carrierid BIGINT,    
  planid BIGINT,    
  price DECIMAL(18, 2)    
  )    
    
 -- Validate InsurenceHealthPlanId    
 IF NOT EXISTS (    
   SELECT 1    
   FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
   INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
   WHERE spi.insurancecarrierid = @InsurenceCarrierId    
    AND spi.insurancehealthplanid = @InsurenceHealthPlanId and im.ItemType=@OrderType    
   )    
 BEGIN    
  SET @InsurenceHealthPlanId = NULL    
 END    
    
 IF (    
   @InsurenceCarrierId IS NULL    
   AND @InsurenceHealthPlanId IS NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   imp.insurancecarrierid,    
   imp.insurancehealthplanid,    
   price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] imp WITH (NOLOCK) ON im.ItemMasterID = imp.ItemMasterID    
  WHERE im.ItemType = @OrderType    
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL    
   AND @InsurenceHealthPlanId IS NOT NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1    
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL     
   AND @InsurenceHealthPlanId IS NULL      
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1    
 END    
    
 --Add nations id into temp table    
 SELECT NationsId,    
  value    
 INTO #tempNationsIds    
 FROM [SupplOrders].[NationsIds]    
 CROSS APPLY STRING_SPLIT(ltemAttributeOptionIDs, ',')    
    
 SELECT ROW_NUMBER() OVER (    
   ORDER BY im.ItemMasterID ASC    
   ) 'itemId',    
  im.ItemDisplayName AS 'ItemName',    
  im.ItemCode AS 'ItemCode',    
  im.ItemType AS 'ItemType',    
  ia.AttributeCode AS 'AttributeCode',    
  iao.AttributeOptionValue AS 'AttributeOptionValue',    
  iao.ltemAttributeOptionID AS 'ltemAttributeOptionID',    
  ia.AttributeDisplayname AS 'AttributeDisplayname',    
  CASE     
   WHEN ia.IsMandate IS NULL    
    THEN CAST(0 AS BIT)    
   ELSE ia.IsMandate    
   END AS 'IsMandate',    
  im.MaxQuantityPerOrder AS 'MaxQuantityPerOrder',    
  ni.NationsId AS 'NationsId',    
  CASE     
   WHEN PC.price IS NULL    
    THEN 0    
   ELSE PC.price    
   END AS 'Price'  ,  
   (select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by  1 desc) as ClientCarrierId -- ClientCarrierId Added by Ramakrishna  
 FROM [SupplOrders].[ItemMaster] im WITH (NOLOCK)    
 LEFT JOIN [SupplOrders].[ItemAttributes] ia WITH (NOLOCK) ON ia.itemmasterId = im.itemmasterId    
 LEFT JOIN [SupplOrders].[ItemAttributeOptions] iao WITH (NOLOCK) ON ia.ItemattributeId = iao.ItemattributeId    
 LEFT JOIN #tempNationsIds ni ON iao.ltemAttributeOptionID = ni.value    
 INNER JOIN @PriceCalculations pc ON pc.itemcode = im.itemcode    
 WHERE im.isactive = 1 
  AND im.itemtype = @OrderType    
    
 DROP TABLE #tempNationsIds    
END    
GO




 select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)











Ticket No # 42522
*/
Supplemental Orders, Catalogs


/****** Object:  StoredProcedure [SupplOrders].[sp_GetSuppleOrderitems]    Script Date: 7/23/2021 4:16:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 /* 
-- =============================================                                    
-- Author:      Baji Thota                                     
-- Create Date: 10/14/2020                                    
-- Description: Get Suppleorder Items           
-- ============================================= --    
--EXEC SupplOrders.[sp_GetSuppleOrderitems] 'OTC',258,2433,'NH202106672039'      
-- =============================================    '

-- Modified By: Ramakrishna P
-- Modified Date: 17th March 2021 
-- Modified Date: 04/07/2021 Added top 1 and order by while fetching Client CarrieriD


  */
 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = 258     
 declare @InsurenceHealthPlanId BIGINT =  2433
 declare @NhMemberId varchar(50)= 'NH202107098791' 

 select 0, @OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId
 
BEGIN    
     declare @CliendCarrierId BIGINT;    
  -- Added by suneetha to cliend id for nations otc    
 set @CliendCarrierId =(select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by 1 desc );
 if @CliendCarrierId is Not null    
 begin    
    
 set @InsurenceCarrierId=@CliendCarrierId ;
 --Ramu commented out. 3/26    
 --set @InsurenceHealthPlanId =Null;    
 end    
 --print @InsurenceCarrierId     
  select 1, @OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId
 

 DECLARE @PriceCalculations TABLE (    
  itemcode NVARCHAR(100),    
  carrierid BIGINT,    
  planid BIGINT,    
  price DECIMAL(18, 2)    
  )
  
  select 2,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
    
 -- Validate InsurenceHealthPlanId    
 IF NOT EXISTS (    
   SELECT 1    
   FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
   INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
   WHERE spi.insurancecarrierid = @InsurenceCarrierId    
    AND spi.insurancehealthplanid = @InsurenceHealthPlanId and im.ItemType=@OrderType    
   )    
 BEGIN    
  SET @InsurenceHealthPlanId = NULL    
 END 
 
 select 3,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
    
 IF (    
   @InsurenceCarrierId IS NULL    
   AND @InsurenceHealthPlanId IS NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   imp.insurancecarrierid,    
   imp.insurancehealthplanid,    
   price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] imp WITH (NOLOCK) ON im.ItemMasterID = imp.ItemMasterID    
  WHERE im.ItemType = @OrderType
  
   select 4,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END



 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL    
   AND @InsurenceHealthPlanId IS NOT NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1
   
    select 5,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL     
   AND @InsurenceHealthPlanId IS NULL      
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1
   
    select 6,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END    
    
 --Add nations id into temp table    
 SELECT NationsId,    
  value    
 INTO #tempNationsIds    
 FROM [SupplOrders].[NationsIds]    
 CROSS APPLY STRING_SPLIT(ltemAttributeOptionIDs, ',') 
 
 select 7,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 select 7, tni.* from #tempNationsIds tni
  

 SELECT ROW_NUMBER() OVER (    
   ORDER BY im.ItemMasterID ASC    
   ) 'itemId',    
  im.ItemDisplayName AS 'ItemName',    
  im.ItemCode AS 'ItemCode',    
  im.ItemType AS 'ItemType',    
  ia.AttributeCode AS 'AttributeCode',    
  iao.AttributeOptionValue AS 'AttributeOptionValue',    
  iao.ltemAttributeOptionID AS 'ltemAttributeOptionID',    
  ia.AttributeDisplayname AS 'AttributeDisplayname',    
  CASE     
   WHEN ia.IsMandate IS NULL    
    THEN CAST(0 AS BIT)    
   ELSE ia.IsMandate    
   END AS 'IsMandate',    
  im.MaxQuantityPerOrder AS 'MaxQuantityPerOrder',    
  ni.NationsId AS 'NationsId',    
  CASE     
   WHEN PC.price IS NULL    
    THEN 0    
   ELSE PC.price    
   END AS 'Price'  ,  
   (select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by  1 desc) as ClientCarrierId -- ClientCarrierId Added by Ramakrishna  
 FROM [SupplOrders].[ItemMaster] im WITH (NOLOCK)    
 LEFT JOIN [SupplOrders].[ItemAttributes] ia WITH (NOLOCK) ON ia.itemmasterId = im.itemmasterId    
 LEFT JOIN [SupplOrders].[ItemAttributeOptions] iao WITH (NOLOCK) ON ia.ItemattributeId = iao.ItemattributeId    
 LEFT JOIN #tempNationsIds ni ON iao.ltemAttributeOptionID = ni.value    
 INNER JOIN @PriceCalculations pc ON pc.itemcode = im.itemcode    
 WHERE im.isactive = 1    
  AND im.itemtype = @OrderType
  
  select 8,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
  select 8, tni.* from #tempNationsIds tni
    
 DROP TABLE #tempNationsIds    
END    
GO


/*
select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'

SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = 155 and im.ItemType = 'OTC'   
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1


select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155)
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155 and ItemMasterID = 3 )
select * from [SupplOrders].[PlanItemsConfig] where InsuranceCarrierID = 155

update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 62 and InsuranceCarrierID = 155
*/



select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'

SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = 155 and im.ItemType = 'OTC'   
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1


select * from otc.cards where clientcarrierId = 373 and NHMemberID = 'NH202107098791'
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 373)
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 373 and ItemMasterID = 3 )
select * from [SupplOrders].[PlanItemsConfig] where InsuranceCarrierID = 373

update [SupplOrders].[PlanItemsConfig] set InsuranceHealthPlanID = NULL where PlanItemsConfigID = 233



select * from [SupplOrders].[PlanItemsConfig] where PlanItemsConfigID = 233
update [SupplOrders].[PlanItemsConfig] set InsuranceHealthPlanID = NULL where PlanItemsConfigID = 233

select * from otc.cards where cardnumber = '636301109105559426x'
select * from otc.cards where cardnumber = '6363011091055594263'

update otc.cards set cardnumber = '636301109105559426x' where cardid = 281848

update otc.cards set Cardnumber = '636301109105559426x' where cardid = 281848


/*
select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'

SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = 155 and im.ItemType = 'OTC'   
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1


select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155)
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155 and ItemMasterID = 3 )
select * from [SupplOrders].[PlanItemsConfig] where InsuranceCarrierID = 155

update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 62 and InsuranceCarrierID = 155
*/



select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'

SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = 155 and im.ItemType = 'OTC'   
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1


select * from otc.cards where clientcarrierId = 373 and NHMemberID = 'NH202107098791'
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 373)
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 373 and ItemMasterID = 3 )
select * from [SupplOrders].[PlanItemsConfig] where InsuranceCarrierID = 373

select * from  [SupplOrders].[PlanItemsConfig] where PlanItemsConfigID = 233
update [SupplOrders].[PlanItemsConfig] set InsuranceHealthPlanID = NULL where PlanItemsConfigID = 233




select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'

SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = 155 and im.ItemType = 'OTC'   
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1


select * from otc.cards where clientcarrierId = 155 and NHMemberID = 'NH202106779994'
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155)
select * from [SupplOrders].[itemmaster]  where itemmasterID in ( select distinct itemmasterid from [SupplOrders].[PlanItemsConfig] where insurancecarrierID = 155 and ItemMasterID = 3 )
select * from [SupplOrders].[PlanItemsConfig] where InsuranceCarrierID = 155

update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 62 and InsuranceCarrierID = 155


6363011091055594263

select * from otc.cards where cardnumber = '6363011091055594263'

select * from auth.UserProfiles where username = 'sballa'

$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm

$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.

select * from auth.UserProfiles where username = 'sballa'

update auth.UserProfiles set PasswordHash = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm' where Username = 'sballa'
update auth.UserProfiles set PasswordSalt=  '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.' where username = 'sballa'



/****** Object:  StoredProcedure [SupplOrders].[sp_GetSuppleOrderitems]    Script Date: 7/23/2021 4:16:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 /* 
-- =============================================                                    
-- Author:      Baji Thota                                     
-- Create Date: 10/14/2020                                    
-- Description: Get Suppleorder Items           
-- ============================================= --    
--EXEC SupplOrders.[sp_GetSuppleOrderitems] 'OTC',258,2433,'NH202106672039'      
-- =============================================    '

-- Modified By: Ramakrishna P
-- Modified Date: 17th March 2021 
-- Modified Date: 04/07/2021 Added top 1 and order by while fetching Client CarrieriD


  */
 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = 258     
 declare @InsurenceHealthPlanId BIGINT =  2433
 declare @NhMemberId varchar(50)= 'NH202106779994' 

 select 0, @OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId
 
BEGIN    
     declare @CliendCarrierId BIGINT;    
  -- Added by suneetha to cliend id for nations otc    
 set @CliendCarrierId =(select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by 1 desc );
 if @CliendCarrierId is Not null    
 begin    
    
 set @InsurenceCarrierId=@CliendCarrierId ;
 --Ramu commented out. 3/26    
 --set @InsurenceHealthPlanId =Null;    
 end    
 --print @InsurenceCarrierId     
  select 1, @OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId
 

 DECLARE @PriceCalculations TABLE (    
  itemcode NVARCHAR(100),    
  carrierid BIGINT,    
  planid BIGINT,    
  price DECIMAL(18, 2)    
  )
  
  select 2,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
    
 -- Validate InsurenceHealthPlanId    
 IF NOT EXISTS (    
   SELECT 1    
   FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
   INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
   WHERE spi.insurancecarrierid = @InsurenceCarrierId    
    AND spi.insurancehealthplanid = @InsurenceHealthPlanId and im.ItemType=@OrderType    
   )    
 BEGIN    
  SET @InsurenceHealthPlanId = NULL    
 END 
 
 select 3,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
    
 IF (    
   @InsurenceCarrierId IS NULL    
   AND @InsurenceHealthPlanId IS NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   imp.insurancecarrierid,    
   imp.insurancehealthplanid,    
   price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] imp WITH (NOLOCK) ON im.ItemMasterID = imp.ItemMasterID    
  WHERE im.ItemType = @OrderType
  
   select 4,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END



 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL    
   AND @InsurenceHealthPlanId IS NOT NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1
   
    select 5,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL     
   AND @InsurenceHealthPlanId IS NULL      
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1
   
    select 6,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 END    
    
 --Add nations id into temp table    
 SELECT NationsId,    
  value    
 INTO #tempNationsIds    
 FROM [SupplOrders].[NationsIds]    
 CROSS APPLY STRING_SPLIT(ltemAttributeOptionIDs, ',') 
 
 select 7,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
 select 7, tni.* from #tempNationsIds tni
  

 SELECT ROW_NUMBER() OVER (    
   ORDER BY im.ItemMasterID ASC    
   ) 'itemId',    
  im.ItemDisplayName AS 'ItemName',    
  im.ItemCode AS 'ItemCode',    
  im.ItemType AS 'ItemType',    
  ia.AttributeCode AS 'AttributeCode',    
  iao.AttributeOptionValue AS 'AttributeOptionValue',    
  iao.ltemAttributeOptionID AS 'ltemAttributeOptionID',    
  ia.AttributeDisplayname AS 'AttributeDisplayname',    
  CASE     
   WHEN ia.IsMandate IS NULL    
    THEN CAST(0 AS BIT)    
   ELSE ia.IsMandate    
   END AS 'IsMandate',    
  im.MaxQuantityPerOrder AS 'MaxQuantityPerOrder',    
  ni.NationsId AS 'NationsId',    
  CASE     
   WHEN PC.price IS NULL    
    THEN 0    
   ELSE PC.price    
   END AS 'Price'  ,  
   (select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by  1 desc) as ClientCarrierId -- ClientCarrierId Added by Ramakrishna  
 FROM [SupplOrders].[ItemMaster] im WITH (NOLOCK)    
 LEFT JOIN [SupplOrders].[ItemAttributes] ia WITH (NOLOCK) ON ia.itemmasterId = im.itemmasterId    
 LEFT JOIN [SupplOrders].[ItemAttributeOptions] iao WITH (NOLOCK) ON ia.ItemattributeId = iao.ItemattributeId    
 LEFT JOIN #tempNationsIds ni ON iao.ltemAttributeOptionID = ni.value    
 INNER JOIN @PriceCalculations pc ON pc.itemcode = im.itemcode    
 WHERE im.isactive = 1    
  AND im.itemtype = @OrderType
  
  select 8,@OrderType,@InsurenceCarrierId, @InsurenceHealthPlanId, @NhMemberId, pc.* from @PriceCalculations pc
  select 8, tni.* from #tempNationsIds tni
    
 DROP TABLE #tempNationsIds    
END    
GO





/*
Ticket No # 42522

/****** Object:  StoredProcedure [SupplOrders].[sp_GetSuppleOrderitems]    Script Date: 7/23/2021 10:47:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 /* 
-- =============================================                                    
-- Author:      Baji Thota                                     
-- Create Date: 10/14/2020                                    
-- Description: Get Suppleorder Items           
-- ============================================= --    
--EXEC SupplOrders.[sp_GetSuppleOrderitems] 'OTC',258,2433,'NH202106672039'      
-- =============================================    '

-- Modified By: Ramakrishna P
-- Modified Date: 17th March 2021 
-- Modified Date: 04/07/2021 Added top 1 and order by while fetching Client CarrieriD


  */
--CREATE PROCEDURE [SupplOrders].[sp_GetSuppleOrderitems] (

-- Contains 4 catalogs for alignment
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '302'     
 --declare @InsurenceHealthPlanId BIGINT = '2692' 
 --declare @NhMemberId varchar(50)= 'NH202005680622'    


 --Ticket # 42522
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '373'     
 --declare @InsurenceHealthPlanId BIGINT = '3971' 
 --declare @NhMemberId varchar(50)= 'NH202107098791'    

 /*
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID = 258
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) and InsuranceHealthPlanID  = 2433 --and IsActive = 1

select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc
select * from otc.cards where NHMemberID =  'NH202107098791'


 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202107098791'    
 */
 
 /*
 The insuranceCarrierID in the master insurance table and the client Carrier ID in the otc.cards can be different. This is to make the UI work as intended.

 */

 select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)
--and a.IsActive in ( 1)
 
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in ( 258, 155, 373)
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) -- and InsuranceHealthPlanID  = 2433 --and IsActive = 1
select * from otc.cards where NHMemberID =  'NH202106779994'
-- select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc



 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202106779994' 

 select * from [supplOrders].[PlanItemsConfig] where ItemmasterID =3
 select * from  [supplOrders].[PlanItemsConfig] where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 --update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 
    
BEGIN    
     declare @CliendCarrierId BIGINT;    
  -- Added by suneetha to cliend id for nations otc    
 set @CliendCarrierId =(select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by 1 desc );
 if @CliendCarrierId is Not null    
 begin    
    
 set @InsurenceCarrierId=@CliendCarrierId ;
 --Ramu commented out. 3/26    
 --set @InsurenceHealthPlanId =Null;    
 end    
 print @InsurenceCarrierId     
     
 DECLARE @PriceCalculations TABLE (    
  itemcode NVARCHAR(100),    
  carrierid BIGINT,    
  planid BIGINT,    
  price DECIMAL(18, 2)    
  )    
    
 -- Validate InsurenceHealthPlanId    
 IF NOT EXISTS (    
   SELECT 1    
   FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
   INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
   WHERE spi.insurancecarrierid = @InsurenceCarrierId    
    AND spi.insurancehealthplanid = @InsurenceHealthPlanId and im.ItemType=@OrderType    
   )    
 BEGIN    
  SET @InsurenceHealthPlanId = NULL    
 END    
    
 IF (    
   @InsurenceCarrierId IS NULL    
   AND @InsurenceHealthPlanId IS NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   imp.insurancecarrierid,    
   imp.insurancehealthplanid,    
   price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] imp WITH (NOLOCK) ON im.ItemMasterID = imp.ItemMasterID    
  WHERE im.ItemType = @OrderType    
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL    
   AND @InsurenceHealthPlanId IS NOT NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1    
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL     
   AND @InsurenceHealthPlanId IS NULL      
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1    
 END    
    
 --Add nations id into temp table    
 SELECT NationsId,    
  value    
 INTO #tempNationsIds    
 FROM [SupplOrders].[NationsIds]    
 CROSS APPLY STRING_SPLIT(ltemAttributeOptionIDs, ',')    
    
 SELECT ROW_NUMBER() OVER (    
   ORDER BY im.ItemMasterID ASC    
   ) 'itemId',    
  im.ItemDisplayName AS 'ItemName',    
  im.ItemCode AS 'ItemCode',    
  im.ItemType AS 'ItemType',    
  ia.AttributeCode AS 'AttributeCode',    
  iao.AttributeOptionValue AS 'AttributeOptionValue',    
  iao.ltemAttributeOptionID AS 'ltemAttributeOptionID',    
  ia.AttributeDisplayname AS 'AttributeDisplayname',    
  CASE     
   WHEN ia.IsMandate IS NULL    
    THEN CAST(0 AS BIT)    
   ELSE ia.IsMandate    
   END AS 'IsMandate',    
  im.MaxQuantityPerOrder AS 'MaxQuantityPerOrder',    
  ni.NationsId AS 'NationsId',    
  CASE     
   WHEN PC.price IS NULL    
    THEN 0    
   ELSE PC.price    
   END AS 'Price'  ,  
   (select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by  1 desc) as ClientCarrierId -- ClientCarrierId Added by Ramakrishna  
 FROM [SupplOrders].[ItemMaster] im WITH (NOLOCK)    
 LEFT JOIN [SupplOrders].[ItemAttributes] ia WITH (NOLOCK) ON ia.itemmasterId = im.itemmasterId    
 LEFT JOIN [SupplOrders].[ItemAttributeOptions] iao WITH (NOLOCK) ON ia.ItemattributeId = iao.ItemattributeId    
 LEFT JOIN #tempNationsIds ni ON iao.ltemAttributeOptionID = ni.value    
 INNER JOIN @PriceCalculations pc ON pc.itemcode = im.itemcode    
 WHERE im.isactive = 1 
  AND im.itemtype = @OrderType    
    
 DROP TABLE #tempNationsIds    
END    
GO

Ticket No # 42522
*/


/****** Object:  StoredProcedure [SupplOrders].[sp_GetSuppleOrderitems]    Script Date: 7/23/2021 10:47:54 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



 /* 
-- =============================================                                    
-- Author:      Baji Thota                                     
-- Create Date: 10/14/2020                                    
-- Description: Get Suppleorder Items           
-- ============================================= --    
--EXEC SupplOrders.[sp_GetSuppleOrderitems] 'OTC',258,2433,'NH202106672039'      
-- =============================================    '

-- Modified By: Ramakrishna P
-- Modified Date: 17th March 2021 
-- Modified Date: 04/07/2021 Added top 1 and order by while fetching Client CarrieriD


  */
--CREATE PROCEDURE [SupplOrders].[sp_GetSuppleOrderitems] (

-- Contains 4 catalogs for alignment
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '302'     
 --declare @InsurenceHealthPlanId BIGINT = '2692' 
 --declare @NhMemberId varchar(50)= 'NH202005680622'    


 --Ticket # 42522
 --declare @OrderType VARCHAR(10) = 'OTC'
 --declare @InsurenceCarrierId BIGINT = '373'     
 --declare @InsurenceHealthPlanId BIGINT = '3971' 
 --declare @NhMemberId varchar(50)= 'NH202107098791'    

 /*
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID = 258
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) and InsuranceHealthPlanID  = 2433 --and IsActive = 1

select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc
select * from otc.cards where NHMemberID =  'NH202107098791'


 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202107098791'    
 */
 
 /*
 The insuranceCarrierID in the master insurance table and the client Carrier ID in the otc.cards can be different. This is to make the UI work as intended.

 */

 select * from [SupplOrders].[ItemAttributes]
 select * from [SupplOrders].[ItemAttributeOptions]

 select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)
and a.IsActive in ( 1)
 
select * from otc.cards where NHMemberID =  'NH202106779994'
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in ( 258, 155)
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID in ( 2433)
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG' or ItemMasterId in (3, 71,112)
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) and IsActive = 1

-- select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc



 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = 258     
 declare @InsurenceHealthPlanId BIGINT =  2433
 declare @NhMemberId varchar(50)= 'NH202106779994' 

 DECLARE @PriceCalculations TABLE (    
  itemcode NVARCHAR(100),    
  carrierid BIGINT,    
  planid BIGINT,    
  price DECIMAL(18, 2)
  )  

 --select * from [supplOrders].[PlanItemsConfig] where ItemmasterID =3
 --select * from  [supplOrders].[PlanItemsConfig] where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 --update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 
    
BEGIN    
     declare @CliendCarrierId BIGINT;    
  -- Added by suneetha to cliend id for nations otc    
 set @CliendCarrierId =(select top 1 ClientCarrierId from Otc.Cards where NHMemberId =@NhMemberId order by 1 desc );
 if @CliendCarrierId is Not null    
 begin    
    
 set @InsurenceCarrierId=@CliendCarrierId ;
 --Ramu commented out. 3/26    
 --set @InsurenceHealthPlanId =Null;    
 end    
 print  @InsurenceCarrierId
 select 1, @InsurenceCarrierId, @CliendCarrierId
 
     
 -- Validate InsurenceHealthPlanId    
 IF NOT EXISTS (    
   SELECT 1    
   FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
   INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
   WHERE spi.insurancecarrierid = @InsurenceCarrierId    
    AND spi.insurancehealthplanid = @InsurenceHealthPlanId and im.ItemType=@OrderType    
   )    
 BEGIN    
  SET @InsurenceHealthPlanId = NULL    
 END
 print @InsurenceHealthPlanId
 select 2, @InsurenceCarrierId, @InsurenceHealthPlanId 
    
 IF (    
   @InsurenceCarrierId IS NULL    
   AND @InsurenceHealthPlanId IS NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   imp.insurancecarrierid,    
   imp.insurancehealthplanid,    
   price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] imp WITH (NOLOCK) ON im.ItemMasterID = imp.ItemMasterID    
  WHERE im.ItemType = @OrderType 
  
  select 3,  @InsurenceCarrierId, @InsurenceHealthPlanId
  select 4, pc.* from @PriceCalculations pc


 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL    
   AND @InsurenceHealthPlanId IS NOT NULL    
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1
   
   select  5, pc.* from @PriceCalculations pc
 END    
 ELSE IF (    
   @InsurenceCarrierId IS NOT NULL     
   AND @InsurenceHealthPlanId IS NULL      
   )    
 BEGIN    
  INSERT INTO @PriceCalculations (    
   itemcode,    
   carrierid,    
   planid,    
   price    
   )    
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1 
   select  6, pc.* from @PriceCalculations pc
 END    
    
 --Add nations id into temp table  
 drop table #tempNationsIds 
 SELECT NationsId, Value    
 INTO #tempNationsIds    
 FROM [SupplOrders].[NationsIds]    
 CROSS APPLY STRING_SPLIT(ltemAttributeOptionIDs, ',')
 
 select  7, ni.* from #tempNationsIds ni
 
 --select * from [SupplOrders].[NationsIds]
 --select * from #tempNationsIds 
    
 SELECT ROW_NUMBER() OVER (    
   ORDER BY im.ItemMasterID ASC    
   ) 'itemId',    
  im.ItemDisplayName AS 'ItemName',    
  im.ItemCode AS 'ItemCode',    
  im.ItemType AS 'ItemType',    
  ia.AttributeCode AS 'AttributeCode',    
  iao.AttributeOptionValue AS 'AttributeOptionValue',    
  iao.ltemAttributeOptionID AS 'ltemAttributeOptionID',    
  ia.AttributeDisplayname AS 'AttributeDisplayname',    
  CASE     
   WHEN ia.IsMandate IS NULL    
    THEN CAST(0 AS BIT)    
   ELSE ia.IsMandate    
   END AS 'IsMandate',    
  im.MaxQuantityPerOrder AS 'MaxQuantityPerOrder',    
  ni.NationsId AS 'NationsId',    
  CASE     
   WHEN PC.price IS NULL    
    THEN 0    
   ELSE PC.price    
   END AS 'Price'  ,  
   (select top 1 ClientCarrierId from Otc.Cards where NHMemberId = 'NH202106779994' order by  1 desc) as ClientCarrierId -- ClientCarrierId Added by Ramakrishna  
 FROM [SupplOrders].[ItemMaster] im WITH (NOLOCK)    
 LEFT JOIN [SupplOrders].[ItemAttributes] ia WITH (NOLOCK) ON ia.itemmasterId = im.itemmasterId 
 LEFT JOIN [SupplOrders].[ItemAttributeOptions] iao WITH (NOLOCK) ON ia.ItemattributeId = iao.ItemattributeId    
 LEFT JOIN #tempNationsIds ni ON iao.ltemAttributeOptionID = ni.value    
 INNER JOIN @PriceCalculations pc ON pc.itemcode = im.itemcode    
 WHERE im.isactive = 1 
  AND im.itemtype = 'OTC' 
  
 select 8 
    
 DROP TABLE #tempNationsIds    
END    
GO

select IM.*, a.*, b.*, ni.*
from 
[SupplOrders].[ItemMaster] im 
LEFT Join [SupplOrders].[ItemAttributes] a  on a.itemmasterId = im.itemmasterId
LEFT JOIN [SupplOrders].[ItemAttributeOptions] b WITH (NOLOCK) ON a.ItemattributeId = b.ItemattributeId  
LEFT JOIN [SupplOrders].[NationsIds] ni ON b.ltemAttributeOptionID = ni.ltemAttributeOptionIDs


 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = 258     
 declare @InsurenceHealthPlanId BIGINT =  2433
 declare @NhMemberId varchar(50)= 'NH202106779994' 

  
  SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price 
   
  --into  #PriceCalculations  
  
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  INNER JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON im.ItemMasterID = spi.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   --AND spi.insurancehealthplanid = @InsurenceHealthPlanId    
   AND spi.isactive = 1

   select * from [SupplOrders].[PlanItemsConfig] where insuranceHealthPlanID is null and  insuranceCarrierID = 258


   SELECT DISTINCT im.itemcode,    
   spi.insurancecarrierid,    
   spi.insurancehealthplanid,    
   spi.price    
  FROM [SupplOrders].[itemmaster] im WITH (NOLOCK)    
  LEFT JOIN [SupplOrders].[PlanItemsConfig] spi WITH (NOLOCK) ON spi.ItemMasterID = im.ItemMasterID    
  WHERE spi.insurancecarrierid = @InsurenceCarrierId and im.ItemType = @OrderType    
   AND spi.InsuranceHealthPlanID IS NULL    
   AND spi.isactive = 1 


   update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258

select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)

update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258



 select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258)
--and a.IsActive in ( 1)
 
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in ( 258, 155, 373)
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (258) and InsuranceHealthPlanID  = 2433 --and IsActive = 1

select * from SupplOrders.Orders where insuranceCarrierID =  '258' order by CreateDate desc
select * from otc.cards where NHMemberID =  'NH202106779994'


 declare @OrderType VARCHAR(10) = 'OTC'
 declare @InsurenceCarrierId BIGINT = '258'     
 declare @InsurenceHealthPlanId BIGINT = '2433' 
 declare @NhMemberId varchar(50)= 'NH202106779994' 

 select * from [supplOrders].[PlanItemsConfig] where ItemmasterID =3
 select * from  [supplOrders].[PlanItemsConfig] where PlanItemsConfigID = 80 and InsuranceCarrierID = 258
 update [supplOrders].[PlanItemsConfig] set IsActive = 1 where PlanItemsConfigID = 80 and InsuranceCarrierID = 258



 select * from insurance.InsuranceCarriers where InsuranceCarrierID = 373 
select * from insurance.InsuranceHealthPlans where HealthPlanName like '%elder Plan%' --insurance carrier ID = 373

select * from [supplOrders].[ItemMaster] where ItemCode = 'BATTERY' or ItemMasterID in ( 1 )
select * from [supplOrders].[PlanItemsConfig] where InsuranceCarrierID = 373
select * from [supplOrders].[PlanItemsConfig] where InsuranceHealthPlanID is not null or InsuranceHealthPlanID = 3971

select * from [supplOrders].[ItemMaster]  where ItemDisplayName like '%Elder%'

Incomm Catalog | ItemMasterID = 3
InsuranceCarrierID = 373
insuranceHealthPlanId = 3971



select
--a.*, b.*, c.*,
a.ItemMasterID, a.InsuranceCarrierID, a.isActive,
b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.InsuranceCarrierName, c.IsActive
from
[supplOrders].[PlanItemsConfig] a
left join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
left join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID =
and a.InsuranceCarrierID = 373




-- update the provider to is active 
update pp 
set isactive = 1 
--select * 
from provider.ProviderProfiles pp
where ProviderId = 1945 

update pdp 
set isactive = 1 
--SELECT * 
from [dbo].[ProviderDataProviders]  pdp 
WHERE ProviderId = 1945    


-- update location to active 
update l 
set 
	isactive = 1 
--select *
from provider.Locations  l 
where LocationId in ( 20455 )


update pdl
set isactive = 1
--select * 
from 
	provider.providerlocations pdl
where 
	locationid in (  20455 )


update pul
set isactive = 1
-- select *
from provider.ProviderUserLocations pul
where userprofileid = 13140 and 
	  LocationId = 20455



update pdl
set isactive = 1
--select isactive,*
from [dbo].[ProviderDataLocations] pdl
where locationid in (  20455 )



/*
OrderID | 200494052

select * from orders.Orders where orderID =  200494052
select * from orders.OrderItems where orderID = 200494052
select * from orders.OrderTransactionDetails where orderID = 200494052


Provider ID | 1083
HCP ID | 1983 | Tonya Janicek
HCP ID | 464 | Cassie M Clark -- correct HCP

UserProfile ID | 14551 -- Cassie M Clark created the order

-- Checking Orders
select * from orders.Orders where orderID =  200494052
select * from orders.OrderItems where orderID = 200494052
select * from orders.orderitemdetails where orderid = 200494052 
select * from orders.OrderTransactionDetails where orderID = 200494052


select isactive,* from provider.ProviderProfiles pp where ProviderId = 1083 
select isactive,* from provider.HCPProviderProfile where HCPID in (1983,464) and  FirstName like '%TONYA%' and lastname like '%JANICEK%' -- HCPID 1983
select isactive, * from auth.userprofiles where ProviderCode = 181083 and UserProfileID = 14551
select isActive,* from provider.ProviderUsers where UserProfileID = 14551 - To check if the user is active who processed the order

select isactive,* from provider.Locations l where LocationId in ( 3506 ) or LocationID in (3504,3505,11647)
select isactive,* from provider.providerlocations pdl where locationid in (  3506 )
select isactive,* from provider.ProviderUserLocations pul where userprofileid = 14551 and  LocationId = 3506

-- Roster
select isactive,* from [dbo].[ProviderDataProviders] WHERE ProviderId = 1083
select isactive,* from [dbo].[ProviderDataLocations] where locationid in (3506)
select isactive,* from [dbo].[ProviderDataHCPMapping] where hcpid in ( 1983,464)

--Roster
select
--a.IsActive as PDHCP_IsActive,
d.IsActive as 'PDP_IsActive',
c.IsActive as 'PDL_IsActive', 
b.isActive as 'PDHCP_IsActive', 

a.HCPID, d.providerid, c.locationid, 
a.HCPID, a.LocationID, a.NPINumber, a.HCPStatus, a.Classification, a.[First Name], a.[Last Name], a.LegalBusinesName,
b.HCPID, b.IsActive, b.Classification, b.FirstName, b.LastName, b.NPINumber, b.LicenseNumber1, b.CredentialDate,
c.Providerid, c.LocationID, c.IsActive, c.ProviderDBA, c.NPINumber, c.Address1, c.Address2, c.City, c.State, c.Zip, c.TimeZone, c.LocationEmailAddress, c.LegalBusinessName, c.TaxID,
d.ProviderID, d.IsActive,  d.LegalBusinessName, d.OwnerLastName, d.OwnerFirstName, d.PrimaryEmailAddress, d.BillingAddress, d.BillingCity, d.BillingState, d.BillingZip, d.BillingCounty

from ProviderDataHCPMapping a
left join ProviderDataHCPs b on a.HCPID = b.HCPID
left join ProviderDataLocations c on a.LocationID = c.locationid
left join ProviderDataProviders d on c.providerid = d.providerid
where 1=1 
and a.HCPID = 1083 or a.HCPID = 464
and c.locationid in (3506)
and d.providerid in (1083)
order by c.locationid
*/



select * from  provider.HCPProviderProfile where hcpid = 1983
select * from  provider.providerProfiles where providerid = 1083
select * from  Provider.ProviderLocations where providerid = 1083 and locationid = 3506
select * from  provider.ProviderUserLocations where UserProfileID = 3547 and ProviderID = 1083 and locationId = 3506



-- update the provider to is active 
update pp 
set isactive = 1 
--select * 
from provider.ProviderProfiles pp
where ProviderId = 1083 

update pdp 
set isactive = 1 
--SELECT * 
from [dbo].[ProviderDataProviders]  pdp 
WHERE ProviderId = 1083    

update pdl
set isactive = 1
--select * 
from 
	provider.providerlocations pdl
where 
	locationid in (  3506 )


update l 
set 
	isactive = 1 
--select *
from provider.Locations  l 
where LocationId in ( 3506 )

update pul
set isactive = 1
-- select *
from provider.ProviderUserLocations pul
where 
	userprofileid = 14551 and 
	  LocationId = 3506


update pdl
set isactive = 1
--select isactive,*
from [dbo].[ProviderDataLocations] pdl
where locationid in (  3506 )


select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
left join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
left join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 258, 373, 302)

select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in ( 258, 373)
select * from [supplOrders].[ItemMaster] where ItemMasterID in (3)
select * from [Insurance].[InsuranceCarriers] where insuranceCarrierID in ( 258, 373)

select * from supplOrders.orders where insuranceCarrierID in (258) and OrderID = 12 order by Createdate desc
select * from supplOrders.orders where insuranceCarrierID in (258) order by Createdate desc
select * from supplOrders.orderitems where itemCode in ('INCOMMCATALOG')

select * from SupplOrders.ItemMaster where ItemCode = 'INCOMMCATALOG'

Select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID in (2433)

select * from insurance.InsuranceHealthPlans where insuranceCarrierID in ( 258, 373, 362)

select a.*, b.*
from 
supplOrders.orderitems a join supplOrders.orders b on a.orderid = b.orderid
where
a.ItemCode in ('INCOMMCATALOG')
order by a.CreateDate desc


select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where InsuranceCarrierName like '%Health First%'
select * from insurance.InsuranceHealthPlans where HealthPlanName like '%HFHP%'


STG
NH202005680622
insuranceCarrierID 302	
InsuranceHealthPlanID 2692
ItemCode = INCOMMCATALOG
OrderID | 4745

select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID = 302
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2692
select * from [supplOrders].[ItemMaster] where ItemCode = 'INCOMMCATALOG'
select * from [supplOrders].[PlanItemsConfig] where insuranceCarrierID  in (302)


select 
--a.*, b.*, c.*,
a.IsActive as 'PIC_IsActive', a.ItemMasterID, a.InsuranceCarrierID, a.InsuranceHealthPlanID,
b.IsActive as 'IM_IsActive', b.ItemCode, b.ItemDisplayName, b.ItemDescription, b.ItemType, b.MaxQuantityPerOrder,
c.IsActive as 'IC_IsActive', c.InsuranceCarrierName
from
[supplOrders].[PlanItemsConfig] a 
join [supplOrders].[ItemMaster] b on a.ItemMasterID =b.ItemMasterId
join [Insurance].[InsuranceCarriers] c on a.InsuranceCarrierID = c.InsuranceCarrierID
where 1=1
--a.ItemMasterID = 
and a.InsuranceCarrierID in ( 302)
and a.IsActive = 1

--NH202005680622
select InsuranceCarrierID, InsuranceCarrierName, IsActive, * from [Insurance].[InsuranceCarriers] where insuranceCarrierID = 302 and IsActive = 1
select InsuranceCarrierID, InsuranceHealthPlanID, * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2692 and IsActive = 1 and InsuranceCarrierID = 302
select * from [supplOrders].[ItemMaster] where ItemMasterID in (select distinct ItemMasterID from [supplOrders].[PlanItemsConfig] where InsuranceCarrierID = 302 and isActive = 1)
select * from [supplOrders].[PlanItemsConfig] where InsuranceCarrierID = 302 and IsActive = 1 order by ItemMasterID 

/*
Ticket No 42495 | Update Card Number
AKOSSIWA YIBOKOU Jul 17, 1988
6363011091055594263
131607931 - HealthFirst of NY
1192 WALTON AVE APT B7 BRONX NY 10452
3477557441

select * from otc.cards where cardnumber = '6363011091055594263'
select * from otc.cards where NHMemberID = 'NH202001969506' and cardid = 274924
select * from master.memberinsurances where id = 10044525
select * from provider.memberinsurances where MemberInsuranceID= 369153

select OTCCardNumber, OTCSerialNumber, * from master.MemberInsuranceDetails  where id =5549368
select OTCCardNumber, OTCSerialNumber, * from provider.MemberInsuranceDetails  where id =369153


*/

-- update card, master and provider. The plan is inactive

--update otc.cards set cardnumber = '6363011091055594263' where NHMemberID = 'NH202001969506' and cardid = 274924
--update otc.cards set SerialNbr = '119719756' where NHMemberID = 'NH202001969506' and cardid = 274924

-- Card number is unique, update NHMemberID
update otc.cards set NHMemberID = 'NH202001969506' where CardNumber = '6363011091055594263'

-- update the isActive flag to 1
update master.memberinsurances set IsActive = 1 where id = 10044525
update provider.memberinsurances set IsActive = 1 where MemberInsuranceID= 369153

-- update master OTCCardNumber and OTCSerialNumber
update master.MemberInsuranceDetails set OTCCardNumber = '6363011091055594263' where id =5549368
update master.MemberInsuranceDetails set OTCSerialNumber = '119719756' where id = 5549368

-- update provider OTCCardNumber and OTCSerialNumber
update provider.MemberInsuranceDetails set OTCCardNumber = '6363011091055594263' where id =369153
update provider.MemberInsuranceDetails set OTCSerialNumber = '119719756' where id =369153

--Ticket # 
select * from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024
select ID from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024
select OTCCardNumber, * from master.MemberInsuranceDetails where MemberInsuranceID in (select id from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024) and OTCCardNumber is not null

select * from otc.cards where cardnumber = '6363012671016798209'

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 349
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 349
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 2433


select * from insurance.InsuranceCarriers where InsuranceCarrierID = 380
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 349
select * from insurance.InsuranceHealthPlans where InsuranceHealthPlanID = 4024


select * from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024
select ID from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024
select OTCCardNumber, * from master.MemberInsuranceDetails where MemberInsuranceID in (select id from master.MemberInsurances where InsuranceCarrierID = 380 and InsuranceHealthPlanID= 4024) and OTCCardNumber is not null



