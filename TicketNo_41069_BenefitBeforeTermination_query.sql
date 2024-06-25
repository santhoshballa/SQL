/*
Ticket # 41069
Received an OON Claim from Member John Danko NH202004865995
Member no longer with insurance provider currently. However,service was done before termination of plan.
If possible, please disclose member benefit amount before Termination.

Thank You in Advance.
*/

select executiondate,ID,is_processed,master_memberinsuranceid,NewNHMemberID,OldNHMemberID,OtcCardnumber,provider_memberinsuranceid,RequestedBy,Technician,TicketNumber
from elig.MergedNHMemberIDS where NewNHMemberID = 'NH202004865995' or OldNHMemberID = 'NH202004865995'


DECLARE @COLUMNS NVARCHAR(MAX) = null

SELECT @COLUMNS = (
SELECT ( STUFF (
  (
SELECT name as 'ListOfColumns' FROM sys.all_columns WHERE OBJECT_ID=OBJECT_ID('master.members') and name not in ('CreateUser','CreateDate','ModifyDate','ModifyUser')
	FOR XML PATH('')
  ),1,1,''
)
) AS COLUMNS
)

SELECT REPLACE(REPLACE(REPLACE(REPLACE(@COLUMNS, 'ListOfColumns', ''), '>',''), '<',''), '/',',')

select * from insurance.insuranceCarriers where InsuranceCarrierName like '%Aetna%' -- 16

select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = 16 and HealthPlanName like '%Prime Plus Plan%' --INsuranceHealthPlanID 2970


select distinct NHmemberID, FirstName, LastName from master.members where MemberID in (select MemberID from master.MemberInsurances where InsuranceCarrierID = 16 and InsuranceHealthPlanID = 2970)

select * from orders.orders where NHMemberID in 
(
select NHmemberID from master.members where MemberID in (select MemberID from master.MemberInsurances where InsuranceCarrierID = 16 and InsuranceHealthPlanID = 2970)
 )
and amount is not null and amount > 0 order by DateOrderInitiated, DateOrderReceived