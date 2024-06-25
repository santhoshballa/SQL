select * from auth.userprofiles where FirstName like '%Gabriel%' and LastName like '%Dias%'

select * from orders.orders where orderID = 202501180 -- the source is 'OTC_MEAL'

select * from orders.orders where Source = 'OTC_MEAL' and status = 'ACTIVE'
select distinct orderstatuscode from orders.orders where Source = 'OTC_MEAL' and status = 'ACTIVE' -- (ACK, INI, SHI, VOI)
select * from otc.UserProfiles where UserName like '%optimahealthmedicaid%'

select * from information_schema.columns where column_name like 'Username' order by table_schema


select * from agent.UserProfiles where Username in ( 

select distinct orderstatuscode, * from orders.orders where Source = 'OTC_MEAL' and status = 'ACTIVE' and orderstatuscode = 'SHI' -- (ACK, INI, SHI, VOI)