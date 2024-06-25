--Ticket # 38729
/*
Important Note One: 
The MEA is unable to make changes to the HealthPlan that he incorrectly entered by error. Unable to make any changes through the UI, since it will not allow. 
The UI will check the otc.cards table to verify for the member ID, and display the right Health Insurance Carrier and Plan, a solution to the issue at hand.
*/

insert into otc.cards values ('NH202106560803','NH202106560803','','','','',getdate(),getdate(),1,null,362,null)

