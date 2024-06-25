/*
Naming Conventions
Environment	Naming Conventions	Description
TEST	H337_CAD2_NPP_MLY_TEST_YYYYMMDD_HHMI.txt	Card Activity Monetary Transactions Full Monthly File
Production 	H337_CAD2_NPP_MLY_PROD_YYYYMMDD_HHMI.txt	Card Activity Monetary Transactions Full Monthly File


*/

/*
SELECT 
a.NHMemberId
--,b.SubscriberID
,TRANSLATE(b.SubscriberID,'1234567890', REVERSE('1234567890')) as SubscriberID
--,b.FirstName as MemberFirstName
,UPPER(TRANSLATE(b.FirstName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as MemberFirstName
--,b.LastName as MemberLastName
,UPPER(TRANSLATE(b.LastName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as MemberLastName
--,c.HealthPlanName as PlanName
--,c.InsuranceHealthPlanID as InsuranceHealthPlanID
,CASE WHEN (c.InsuranceHealthPlanID = 4019) THEN 'H1016_023 Medicare Circle Miami Dade HMO'
     WHEN (c.InsuranceHealthPlanID = 4024) THEN 'H1016_ 024 Medicare Circle Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4030) THEN 'H1016_001 Medicare Choice Miami Dade HMO'
	 WHEN (c.InsuranceHealthPlanID = 4031) THEN 'H1016_021 Medicare Choice Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4032) THEN 'H1016_026 Medicare Access Broward County (HMO)'
	 WHEN (c.InsuranceHealthPlanID = 4023) THEN 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
	 END PlanName
/* Avmed HealthPlan Names
-- Avmed
H1016_023 Medicare Circle Miami Dade HMO 
H1016_ 024 Medicare Circle Broward HMO
H1016_001 Medicare Choice Miami Dade HMO
H1016_021 Medicare Choice Broward HMO
-- DHEAllPlans Avmed
H1016_026 Medicare Access Broward County (HMO)
H1016_025 Medicare Access (HMO-POS) Miami-Dade County
H1016_028 Medicare Premium Saver HMO Broward County
*/

/*
4019 replaced with 'H1016_023 Medicare Circle Miami Dade HMO'
4024 replace with 'H1016_ 024 Medicare Circle Broward HMO'
4030 replace with 'H1016_001 Medicare Choice Miami Dade HMO'
4031 replace with 'H1016_021 Medicare Choice Broward HMO'
4032 replace with 'H1016_026 Medicare Access Broward County (HMO)'
4023 replace with 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
*/

,d.TxnUID
,FORMAT(d.TxnLocDateTime,'MMddyyyy hh:mm:ss') as TxnLocDateTime
,FORMAT(d.WCSLocaLPostDate, 'MMddyyyy hh:mm:ss') as WCSLocalPostDate
,FORMAT(d.WCSUTCPostDate,'MMddyyyy hh:mm:ss') as WCSUTCPostDate
,d.PurseNo,d.PurseName 
--,d.AuthorizationAmount --  fisxtract.Monetary
,e.AuthorizationAmount as AuthorizationAmount --  fisxtract.[Authorization]
,d.SettleAmount, d.SettleBalance, d.MCCDescription, d.MerchantName, d.CardNumber, d.Reversed, d.ResponseDescription, d.TxnTypeName
from 
fisxtract.Monetary d 
left join elig.mstreligbenefitdata b on d.PANProxyNumber = b.BenefitCardNumber
left join master.members a on a.MemberID = b.MasterMemberID
left join insurance.InsuranceHealthPlans c on (b.inscarrierID = c.InsuranceCarrierid and b.insHealthPlanID = c.InsuranceHealthPlanID)
left join fisxtract.[Authorization] e on (e.PANProxyNumber = d.PANProxyNumber and e.TxnUID = d.TxnUID)

where
1=1 and
c.insuranceCarrierID = 380 
and (a.isActive =1 and b.IsActive =1 and c.IsActive = 1 )   -- and d.IsActive=1 is not present
-- and d.MerchantName <> 'MANUAL BATCH LOADER'
and d.PANProxyNumber in ('0701544156626','7880293579976','0326518075856','5793968081803','5782966918391','6043099962656','4383145994616','3185555433261','8997129144084','4542803336688','3856195467888')
*/



/*
Naming Conventions
Environment	Naming Conventions	Description
TEST	H337_CAD2_NPP_MLY_TEST_YYYYMMDD_HHMI.txt	Card Activity Monetary Transactions Full Monthly File
Production 	H337_CAD2_NPP_MLY_PROD_YYYYMMDD_HHMI.txt	Card Activity Monetary Transactions Full Monthly File


select 'H337_CAD2_NPP_MLY_TEST_'+ Format(getdate(),'yyyyMMdd_hhmm')+'.txt'

--H337_CAD2_NPP_MLY_TEST_20211029_0540.txt

*/


SELECT 
a.NHMemberId
--,b.SubscriberID
,TRANSLATE(b.SubscriberID,'1234567890', REVERSE('1234567890')) as SubscriberID
--,b.FirstName as MemberFirstName
,UPPER(TRANSLATE(b.FirstName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as MemberFirstName
--,b.LastName as MemberLastName
,UPPER(TRANSLATE(b.LastName, 'abcdefghijklmnopqrstuvwxyz', reverse('abcdefghijklmnopqrstuvwxyz'))) as MemberLastName
--,c.HealthPlanName as PlanName
--,c.InsuranceHealthPlanID as InsuranceHealthPlanID
,CASE WHEN (c.InsuranceHealthPlanID = 4019) THEN 'H1016_023 Medicare Circle Miami Dade HMO'
     WHEN (c.InsuranceHealthPlanID = 4024) THEN 'H1016_ 024 Medicare Circle Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4030) THEN 'H1016_001 Medicare Choice Miami Dade HMO'
	 WHEN (c.InsuranceHealthPlanID = 4031) THEN 'H1016_021 Medicare Choice Broward HMO'
	 WHEN (c.InsuranceHealthPlanID = 4032) THEN 'H1016_026 Medicare Access Broward County (HMO)'
	 WHEN (c.InsuranceHealthPlanID = 4023) THEN 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
	 END PlanName
/* Avmed HealthPlan Names
-- Avmed
H1016_023 Medicare Circle Miami Dade HMO 
H1016_ 024 Medicare Circle Broward HMO
H1016_001 Medicare Choice Miami Dade HMO
H1016_021 Medicare Choice Broward HMO
-- DHEAllPlans Avmed
H1016_026 Medicare Access Broward County (HMO)
H1016_025 Medicare Access (HMO-POS) Miami-Dade County
H1016_028 Medicare Premium Saver HMO Broward County
*/

/*
4019 replaced with 'H1016_023 Medicare Circle Miami Dade HMO'
4024 replace with 'H1016_ 024 Medicare Circle Broward HMO'
4030 replace with 'H1016_001 Medicare Choice Miami Dade HMO'
4031 replace with 'H1016_021 Medicare Choice Broward HMO'
4032 replace with 'H1016_026 Medicare Access Broward County (HMO)'
4023 replace with 'H1016_025 Medicare Access (HMO-POS) Miami-Dade County'
*/

,d.TxnUID
,FORMAT(d.TxnLocDateTime,'MMddyyyy hh:mm:ss') as TxnLocDateTime
,FORMAT(d.WCSLocaLPostDate, 'MMddyyyy hh:mm:ss') as WCSLocalPostDate
,FORMAT(d.WCSUTCPostDate,'MMddyyyy hh:mm:ss') as WCSUTCPostDate
,d.PurseNo,d.PurseName 
--,d.AuthorizationAmount --  fisxtract.Monetary
,e.AuthorizationAmount as AuthorizationAmount --  fisxtract.[Authorization]
,d.SettleAmount, d.SettleBalance, d.MCCDescription, d.MerchantName, d.CardNumber 
--d.Reversed 
,case when (ltrim(d.TxnTypeName) like 'Purchase%' and rtrim(d.TxnTypeName) like '%Return') then 1
      else 0
	  end Reversed

,d.ResponseDescription, d.TxnTypeName
from 
fisxtract.Monetary d 
left join elig.mstreligbenefitdata b on d.PANProxyNumber = b.BenefitCardNumber
left join master.members a on a.MemberID = b.MasterMemberID
left join insurance.InsuranceHealthPlans c on (b.inscarrierID = c.InsuranceCarrierid and b.insHealthPlanID = c.InsuranceHealthPlanID)
left join fisxtract.[Authorization] e on (e.PANProxyNumber = d.PANProxyNumber and e.TxnUID = d.TxnUID)

where
1=1 and
c.insuranceCarrierID = 380 
and (a.isActive =1 and b.IsActive =1 and c.IsActive = 1 )   -- and d.IsActive=1 is not present
-- and d.MerchantName <> 'MANUAL BATCH LOADER'
and d.PANProxyNumber in ('0701544156626','7880293579976','0326518075856','5793968081803','5782966918391','6043099962656','4383145994616','3185555433261','8997129144084','4542803336688','3856195467888')
-- and TRANSLATE(b.SubscriberID,'1234567890', REVERSE('1234567890')) = '3011331054496'
-- and TRANSLATE(b.SubscriberID,'1234567890', REVERSE('1234567890')) ='3111331035010'
Order by d.TxnLocDateTime

