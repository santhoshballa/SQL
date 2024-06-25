
select CAST(FORMAT(GETDATE(),'yyyyMMddhhmmss') AS nvarchar)
select CAST(FORMAT(current_timestamp,'yyyyMMddhhmmss') AS nvarchar)
select DATETIME2FROMPARTS ( 2021, 03, 31, 16, 57, 00, 00, 00 )
-- There is a 4 hour difference between EST and Getdate(), EST | 

select * from auth.UserProfiles where username like '%cooper%'
-- CCPPuyo

select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 16, 52, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 17, 03, 00, 00, 00 )
or CreateUser like 'CCPPuyo' or MemberNHMemberID = 'NH201800642476'


select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 23, 59, 59, 00, 00 )
and CreateUser like 'CCPPuyo' and MemberNHMemberID = 'NH201800642476'

select MemberNHMemberID,AgentUserProfileName, CallEndSummary, CreateDate, CreateUser, EndCallSummaryEnd, EndCallSummaryStart 
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 21, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 22, 00, 00, 00, 00, 00 )
--and MemberNHMemberID = 'NH202002234074'


select * from callcenter.CallConversations where  StartTime between (Getdate() - 1) and getdate()
and CreateUser like '%Verna%' 

select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 03, 31, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 03, 31, 23, 59, 59, 00, 00 )
and CreateUser like '%Verna%' 


/*
Good afternoon IT, 
Can you please confirm if MEA added notes to member's account? I was not able to see any notes on the account from the MEA. Call details below:
Member: Verna Vittorioso - NH202002234074
       MEA: Teresita Moreno 70301
       Call Date and Time: 04/21 at 8:45am
*/

select top 1 * from auth.UserProfiles
select * from auth.UserProfiles where firstname like '%Teresita%' and LastName like 'Moreno'

select 'auth.UserProfiles' as TableName, Username, FirstName, LastName, PasswordHash, PasswordSalt, temproryKeyCode, ProviderCode from auth.UserProfiles where firstname like '%Teresita%' and LastName like 'Moreno'
--TMoreno

select * from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 21, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 21, 23, 59, 59, 00, 00 )
and CreateUser like '%TMoreno%' 

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 20, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 21, 23, 59, 59, 00, 00 )
and CreateUser like '%TMoreno%' 


/*
--38321
NH202004902080
JOSEPH LOVATO NH202004902080
*/


select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations 
where MemberNHMemberID = 'NH202004902080'

--where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 20, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 21, 23, 59, 59, 00, 00 )
and CreateUser like '%TMoreno%' 

JOSEPH LOVATO
NH202004902080

select * from master.members where firstname like 'JOSEPH' and lastname like 'LOVATO'


--# 38423
/*
Good morning IT Team,
Can you please confirm if MEA added notes to member's account? I was not able to see any notes on the account from the MEA. Call details below: 
Member: Dorothy GreenwoodNH202106629097
MEA Name and Ext:  Shanequa Perry Ext.70297
Call Date and Time:  04/22/21 10:12am
Thanking you in advance!
*/

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations 
where MemberNHMemberID = 'NH202106629097' or  EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 22, 23, 59, 59, 00, 00 )


select top 1 * from auth.UserProfiles
select * from auth.UserProfiles where firstname like '%Shanequa%' and LastName like 'Perry'

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 22, 23, 59, 59, 00, 00 )
and CreateUser like '%CCSPerry%' 



--38540
/*
Good afternoon,
Can you please confirm if MEA added notes to member's account?  Call details below: 
Member: Constance Dreger - NH202106551173
MEA Name and Ext:  Brane'a Brown 70209
Call Date and Time: 4/26/21   12:11pm
*/

select * from auth.UserProfiles where firstname like '%Brane%' and LastName like 'Brown'
--CCBBrown

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 26, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 26, 23, 59, 59, 00, 00 )
and CreateUser like '%CCBBrown%' or  MemberNHMemberID = 'NH202106551173' 

--39257
Can you please confirm if NOTES were listed on this account -Ivy Cifizzari -NH202002571876, I received the callon 04/05 for MEA Lina Acre



select * from auth.UserProfiles where firstname like '%Lina%' and LastName like '%Arce%'
--CCBBrown

--AND
select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where 
EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 05, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 05, 23, 59, 59, 00, 00 )
and  CreateUser like '%CCLinaArce%'  
and MemberNHMemberID = 'NH202002571876' 

--OR
select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 04, 05, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 04, 05, 23, 59, 59, 00, 00 )
or  CreateUser like '%CCLinaArce%'  or MemberNHMemberID = 'NH202002571876' 


select * from elig.MergedNHMemberIDS where OldNHMemberID = 'NH202002571876' or NewNHMemberID = 'NH202002571876'


select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
 MemberNHMemberID = 'NH202002571876' or CreateUser like '%%'


 /*
I would like to submit a formal request, for notes that could be potentially missing from - NH202106949041
Call took place on 05/28/21 at 10:21 AM. (eastern)
Member : JOAN BARIST - NH202106949041
MEA: Gabriel Trujillo
If any other details are needed, please feel free to reach out to me.
*/

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
(MemberNHMemberID = 'NH202106949041' or  CreateUser like '%CCGTrujillo%') and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 05, 28, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 05, 28, 23, 59, 59, 00, 00 )


select * from auth.UserProfiles where firstname like '%Gabriel%' and LastName like '%Trujillo%'
CCGTrujillo

/*
NH202006058720

Alexis McCall documented notes in this account around 2:50pm on 6/4/2021, when she went back and looked at the account her note was not there. 
Is there a way to identify her note and have it entered into the account?
Thank you,

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
( CreateUser like '%AMcCall%') and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 04, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 04, 23, 59, 59, 00, 00 )


select * from auth.UserProfiles where firstname like '%Alexis%' and LastName like '%McCall%'
AMcCall

*/


/*
TIcket 40711
NH202106564124

Alexis McCall documented notes in this account around 2:50pm on 6/4/2021, when she went back and looked at the account her note was not there. 
Is there a way to identify her note and have it entered into the account?
Thank you,

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
( CreateUser like '%CCNClowers%') and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 15, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 15, 23, 59, 59, 00, 00 )
and MemberNHMemberID = 'NH202106564124'


select * from auth.UserProfiles where firstname like '%Nicole%' and LastName like '%Clowers%'
CCNClowers

*/



/*
Ticket # 41080

select * from auth.UserProfiles where firstname like '%Christi%' and LastName like '%Hernandez%'

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
( CreateUser like '%CCCHernandez%') and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 19, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 19, 23, 59, 59, 00, 00 )
and MemberNHMemberID = 'NH202106564124'


*/



/*
Ticket # 40975

LaShaundra Crowder

select * from auth.UserProfiles where firstname like '%LaShaundra%' or LastName like '%Crowder%'

select AgentUserProfileName, MemberNHMemberID, EndCallSummaryStart, EndCallSummaryEnd, CallBound, CallEndSummary, CallerTypeCode, Starttime
from callcenter.CallConversations where
( CreateUser like '%CCLCrowder%') and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 21, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 21, 23, 59, 59, 00, 00 )
and MemberNHMemberID = 'NH202004955429'


*/


/*
Ticket # 41088

May I please ask for a check on this account  LINDA MARTY - NH202005093029 for non documentation.
MEA made several comments that she was having compute issues at the time. MEA is Krizia Torres.

select username, * from auth.UserProfiles where firstname like '%LINDA%' or LastName like '%MARTY%'

select AgentUserProfileName as ProfileName, MemberNHMemberID as Member, EndCallSummaryStart as 'Start', EndCallSummaryEnd as 'End', CallBound, CallEndSummary as 'CallNotes', CallerTypeCode as'CallCode', Starttime
from callcenter.CallConversations where 1=1 
--and ( CreateUser like '%CCLCrowder%') 
and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 22, 23, 59, 59, 00, 00 )
and MemberNHMemberID = 'NH202005093029'


select 
a.CreateUser, a.CreateDate, a.Note,
b.AgentUserProfileName as ProfileName, b.MemberNHMemberID as Member, b.EndCallSummaryStart as 'Start', b.EndCallSummaryEnd as 'End', b.CallBound, b.CallEndSummary as 'CallNotes', b.CallerTypeCode as'CallCode', b.Starttime
from callcenter.CallConversations b left join callcenter.CallNotes a on a.CallConversationId = b.CallConversationId
where 1=1 
and ( b.CreateUser like '%CCCHernandez%') 
--and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 22, 23, 59, 59, 00, 00 )
and b.MemberNHMemberID = 'NH202106757249'


*/



/*
Ticket # 41089

Can someone please check this account for non documentation on the account the MEA is Christina Hernandez.
SANDRA JONES - NH202106757249 Aet

select username, * from auth.UserProfiles where firstname like '%Christina%' and LastName like '%Hernandez%'

select AgentUserProfileName as ProfileName, MemberNHMemberID as Member, EndCallSummaryStart as 'Start', EndCallSummaryEnd as 'End', CallBound, CallEndSummary as 'CallNotes', CallerTypeCode as'CallCode', Starttime
from callcenter.CallConversations where 1=1 
and ( CreateUser like '%CCCHernandez%') 
--and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 22, 23, 59, 59, 00, 00 )
and MemberNHMemberID = 'NH202106757249'


select 
a.CreateUser, a.CreateDate, a.Note,
b.AgentUserProfileName as ProfileName, b.MemberNHMemberID as Member, b.EndCallSummaryStart as 'Start', b.EndCallSummaryEnd as 'End', b.CallBound, b.CallEndSummary as 'CallNotes', b.CallerTypeCode as'CallCode', b.Starttime
from callcenter.CallConversations b left join callcenter.CallNotes a on a.CallConversationId = b.CallConversationId
where 1=1 
and ( b.CreateUser like '%CCCHernandez%') 
--and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 22, 23, 59, 59, 00, 00 )
and b.MemberNHMemberID = 'NH202106757249'



*/

/*
Ticket # | 42259
Please investigate if there are any call notes associated to the Member’s Account Larry Coplin - NH202107078866  (Aetna) entered by MEA David Cope on July 8.
Thank you!
Kindest Regards,



*/

/*
Ticket #
On 06/23 member Linda Moton called and spoke with MEA Maureen Garvey.   
MEA scheduled ana appointment for this member for Jul 08th , butthere is no notes or date/time stamp that MEA entered the account.
However the appointment that was schedule does show on the account 07/08 with Michigan Avenue Hearing Health P.C.
Can you please confirm if notes were entered by MEA MG .
*/



select username, * from auth.UserProfiles where firstname like '%Maureen%' and LastName like '%Garvey%'
--CCMGarvey
select top 10 * from callcenter.CallConversations
select top 10 * from callcenter.CallNotes

select 
a.CreateUser, a.CreateDate, a.Note,
b.AgentUserProfileName as ProfileName, b.MemberNHMemberID as Member, b.EndCallSummaryStart as 'Start', b.EndCallSummaryEnd as 'End', b.CallBound, b.CallEndSummary as 'CallNotes', b.CallerTypeCode as'CallCode', b.Starttime
from callcenter.CallConversations b left join callcenter.CallNotes a on a.CallConversationId = b.CallConversationId
where 1=1 
and ( b.CreateUser like '%CCMGarvey%') 
--and EndCallSummaryStart between DATETIME2FROMPARTS ( 2021, 06, 22, 00, 00, 00, 00, 00 ) and DATETIME2FROMPARTS ( 2021, 06, 22, 23, 59, 59, 00, 00 )
and b.MemberNHMemberID = 'NH202006003455'




