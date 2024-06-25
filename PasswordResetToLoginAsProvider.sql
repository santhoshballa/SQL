/*
Password Reset of the Provider to login as him in STG
*/

select * from auth.UserProfiles where UserName like '%HammersHearing%' --182065

update auth.UserProfiles set PasswordHash = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.VfoNlRKq.sU2L81YDGQJObMRTi371hm' where UserProfileID = 13802
update auth.UserProfiles set PasswordSalt = '$2a$10$0w8nEjvlQvy8Q9ZrfVsUf.' where UserProfileID = 13802