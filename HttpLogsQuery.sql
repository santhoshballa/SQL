
select top 1000 * from logs.HttpMessages where 1=1 and CreateDate > getdate()-1 and content like '%err%'


select
'Logs | Request Response' as QueryType
,a.id as requestID, a.refid as req_refid, a.Uri as req_uri, a.type as req_type, a.content as req_content, a. StatusCode as req_StatusCode, a.CreateDate as req_CreateDate
,b.id as reponseID, b.refid as res_refid, b.Uri as res_uri, b.type as res_type, b.content as res_content, b.StatusCode as res_StatusCode, b.CreateDate as res_CreateDate
from logs.HttpMessages a inner join logs.HttpMessages b on a.refid = b.refid and a.id <> b.id and a.type like '%Request%' and b.type like '%Response%' 



select * from

(select a.id as requestID, a.refid as req_refid, a.Uri as req_uri, a.type as req_type, a.content as req_content, a.StatusCode as req_StatusCode, a.CreateDate as req_CreateDate
 from logs.HttpMessages a) b
 join
(select b.id as reponseID, b.refid as res_refid, b.Uri as res_uri, b.type as res_type, b.content as res_content, b.StatusCode as res_StatusCode, b.CreateDate as res_CreateDate
 from logs.HttpMessages b) a
 on b.req_refid = a.res_refid and b.requestID <> a.reponseID and b.req_type like '%Request%' and a.res_type like '%Response%' and b.req_CreateDate > getdate() - 1 -- and (a.res_content like '%err%' and a.res_StatusCode = 500)
 order by b.req_CreateDate desc



 select top 1 * from

(select distinct a.id as requestID, a.refid as req_refid, a.Uri as req_uri, a.type as req_type, a.content as req_content, a.StatusCode as req_StatusCode, a.CreateDate as req_CreateDate
 from logs.HttpMessages a ) b
 join
(select distinct b.id as reponseID, b.refid as res_refid, b.Uri as res_uri, b.type as res_type, b.content as res_content, b.StatusCode as res_StatusCode, b.CreateDate as res_CreateDate
 from logs.HttpMessages b ) a
 on b.req_refid = a.res_refid and b.requestID <> a.reponseID and b.req_type like '%Request%' and a.res_type like '%Response%' and b.req_CreateDate > getdate() - 1
 order by b.req_CreateDate desc



 select top 10 * from logs.HttpMessages

