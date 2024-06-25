select * from [Insurance].[InsuranceCarriers] where InsuranceCarrierName like '%health first%'
select insuranceC

select * from otc.cards where cardnumber = '6102812711001278231'

select * from elig.MergedNHMemberIDS where TicketNumber in ( 38493, 38515, 38460)

select * from Master.MemberInsurances where  
select * from Master.MemberInsuranceDetails where MemberInsuranceID = '9648296'
select * from Provider.MemberInsuranceDetails where MemberInsuranceID = '228374'

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 362
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = (select InsuranceCarrierID FROM insurance.InsuranceCarriers where InsuranceCarrierID = 362)


insert into otc.cards values ('NH202106562577','NH202106562577','','','','',getdate(),getdate(),1,null,362,null)

select * from [Insurance].[InsuranceCarriers] where InsuranceCarrierName like '%health first%'
select insuranceC

select * from otc.cards where cardnumber = '6102812711001278231'

select * from elig.MergedNHMemberIDS where TicketNumber in ( 38493, 38515, 38460)

select * from Master.MemberInsurances where  
select * from Master.MemberInsuranceDetails where MemberInsuranceID = '9648296'
select * from Provider.MemberInsuranceDetails where MemberInsuranceID = '228374'

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 362
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = (select InsuranceCarrierID FROM insurance.InsuranceCarriers where InsuranceCarrierID = 362)

select * from otc.cards where CardNumber like '%NH%'

update otc set otc.IsActive = 0 from otc.cards otc where otc.cardnumber = '6102812711004271209' -- expired card number needs to be In Active


select
'curl -X POST "https://externalserviceotc.azurewebsites.net/api/OTC/Transact/BenefitInquiry" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d "{\"cardNumber\":\"'+CardNumber+'\"}"' + '>>'+CardNumber+'_OTCBenefits.txt' from otc.Cards
where
NHMemberID in (select a.NHMemberid
--, a.CardNumber, a.isActive, b.NHLinkID,b.NHMemberID, b.DataSource 
from 
otc.cards a inner join master.members b on a.NHMemberID = b.NHMemberID where datasource = 'ELIG_ALGN'
 )

update otc set otc.NHMemberID = null from otc.cards otc where otc.cardid = 224678
update otc set otc.IsActive = 0 from otc.cards otc where otc.cardid = 224678


select * from otc.cards where NHMemberID = 'NH202106560803'

select Cardid, NHMemberID, Cardnumber from otc.cards where NHMemberID is null
select count(*) from otc.cards where NHMemberID is null

select  len(cardnumber) LengthCardNumber,  count(*) as NoofRecords from otc.cards group by len(cardnumber)

select top 10 * from 

(
select * from otc.cards where len(cardnumber)  = 16
) a

select ClientCarrierID, count(*) as NoOfRecords from otc.cards group by ClientCarrierID order by 2

select * from insurance.insurancecarriers where InsuranceCarrierID in ( select distinct ClientCarrierID from otc.cards)

 /*

Ticket # 38273
Important Note : For all Cards that have expired, please make the Member ID and the associated CardNumber inactive by setting the NHMemberID to null and also setting the IsActive flag to 0

select Cardid, NHMemberID, Cardnumber from otc.cards where NHMemberID = 'NH202106744771'
select Cardid, NHMemberID, Cardnumber from otc.cards where NHMemberID is null

CardNumbers associated with the NHMember ID
6102812711004271209
6102812711003942271

*/

update otc set otc.NHMemberID = null from otc.cards otc where otc.cardid = 224678
--update otc set otc.IsActive = 0 from otc.cards otc where otc.cardid = 224678

update otc set otc.IsActive = 0 from otc.cards otc where otc.cardnumber = '6102812711004271209'



select
'curl -X POST "https://externalserviceotc.azurewebsites.net/api/OTC/Transact/BenefitInquiry" -H "accept: application/json" -H "Content-Type: application/json-patch+json" -d "{\"cardNumber\":\"'+CardNumber+'\"}"' + '>>OTCBenefits.txt' from otc.Cards
where
NHMemberID in (select a.NHMemberid
--, a.CardNumber, a.isActive, b.NHLinkID,b.NHMemberID, b.DataSource 
from 
otc.cards a inner join master.members b on a.NHMemberID = b.NHMemberID where datasource = 'ELIG_ALGN'
 )
 
 
 
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


Ticket # 42880

select * from master.members where firstname like '%Bernadette%' and LastName like 'Si%'

select * from orders.orders where OrderID in  (200326799, 200525643)

select * from orders.orders where NHmemberID = 'NH202106779718'

select * from orders.orders where ShippingData like '%bernadette%' and ShippingData like '%simmons%' and shippingdata like '%4920%'
select OrderID, OrderType, NhMemberID from orders.orders where NHmemberID = 'NH202106779718'

select * from insurance.InsuranceCarriers where InsuranceCarrierID = 258
select * from otc.cards where NHMemberId = 'NH202106779718'

select * from master.MemberInsuranceDetails where InsuranceNbr = '00115334601'



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


select * from auth.UserProfiles where FirstName like '%Swetha%'

update auth.UserProfiles set IsActive  = 1 where UserProfileID = 10727


/*
Ticket 45001 | August Health Plans
Insurance Carriers and Health Plans Configuration
 
--Preh | ** Already Present **
DAS Companies, Inc.
Lower Dauphin School District
Zimmerman Truck Lines
Mount Airy Casino Resort
City of Ocean City
Standard Steel, LLC
Lapeer Community Schools
Summit Polymers
Liberty Chevrolet
Wayne Westland Community Schools
City of Spring Hill
Leonhardt Manufacturing
Lycoming / Clinton Joinder Board
Perfumania
Prism Edcation
Ruthman Pump
Secrest Wardle
Tri County Equipment


('Preh','DAS Companies, Inc.','Lower Dauphin School District','Zimmerman Truck Lines','Mount Airy Casino Resort','City of Ocean City','Standard Steel, LLC','Lapeer Community Schools','Summit Polymers','Liberty Chevrolet','Wayne Westland Community Schools','City of Spring Hill','Leonhardt Manufacturing','Lycoming / Clinton Joinder Board','Perfumania','Prism Edcation','Ruthman Pump','Secrest Wardle','Tri County Equipment')

--Insurance Carriers and Health Plans Configuration
select * from insurance.insurancehealthplans where HealthPlanName in
-- **Preh already present** ('Preh','DAS Companies, Inc.','Lower Dauphin School District','Zimmerman Truck Lines','Mount Airy Casino Resort','City of Ocean City','Standard Steel, LLC','Lapeer Community Schools','Summit Polymers','Liberty Chevrolet','Wayne Westland Community Schools','City of Spring Hill','Leonhardt Manufacturing','Lycoming / Clinton Joinder Board','Perfumania','Prism Edcation','Ruthman Pump','Secrest Wardle','Tri County Equipment')
('Preh','DAS Companies, Inc.','Lower Dauphin School District','Zimmerman Truck Lines','Mount Airy Casino Resort','City of Ocean City','Standard Steel, LLC','Lapeer Community Schools','Summit Polymers','Liberty Chevrolet','Wayne Westland Community Schools','City of Spring Hill','Leonhardt Manufacturing','Lycoming / Clinton Joinder Board','Perfumania','Prism Edcation','Ruthman Pump','Secrest Wardle','Tri County Equipment')

*/


--INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
--(getdate(), N'Rsareddy', N'Preh', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'DAS Companies, Inc.', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Lower Dauphin School District', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Zimmerman Truck Lines', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Mount Airy Casino Resort', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'City of Ocean City', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Standard Steel, LLC', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Lapeer Community Schools', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Summit Polymers', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Liberty Chevrolet', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Wayne Westland Community Schools', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'City of Spring Hill', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Leonhardt Manufacturing', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Lycoming / Clinton Joinder Board', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Perfumania', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Prism Edcation', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Ruthman Pump', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Secrest Wardle', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))
INSERT INTO insurance.InsuranceHealthPlans (CreateDate, CreateUser, HealthPlanName, HealthPlanNumber, IsActive, IsDiscountProgram, ModifyDate, ModifyUser, IsMedicaid, IsMedicare, PlanConfigData, IsProgramCode, InsuranceCarrierID) VALUES
(getdate(), N'Rsareddy', N'Tri County Equipment', NULL, CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'),(select InsuranceCarrierID FROM insurance.InsuranceCarriers WHERE InsuranceCarrierName = 'NVA Groups'))




SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [auth].[AppModuleRoleMenus](
	[AppModuleRoleMenuId] [bigint] IDENTITY(1,1) NOT NULL,
	[AppModuleRoleId] [bigint] NOT NULL,
	[AppModuleRoleMenuIconImage] [varbinary](max) NULL,
	[AppModuleRoleMenuName] [nvarchar](50) NULL,
	[AppModuleRoleMenuPage] [nvarchar](50) NULL,
	[CreateDate] [datetime2](7) NOT NULL,
	[CreateUser] [nvarchar](150) NULL,
	[IsActive] [bit] NOT NULL,
	[ModifyDate] [datetime2](7) NULL,
	[ModifyUser] [nvarchar](150) NULL,
 CONSTRAINT [PK_AppModuleRoleMenus] PRIMARY KEY CLUSTERED 
(
	[AppModuleRoleMenuId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


declare @AppModuleRoleMenuIconImage nvarchar(500)
set @AppModuleRoleMenuIconImage = convert(VARBINARY(500), '0x66612D66696C652D746578742D6F', 1);


insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, @AppModuleRoleMenuIconImage , 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')


insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, convert(VARBINARY(500), '0x66612D66696C652D746578742D6F', 1) , 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')



select * from [auth].[AppModuleRoleMenus] 



SELECT CONVERT(VARBINARY(25), '0x9473FBCCBC01AF', 1);




select * from [auth].[AppModuleRoles] where AppModuleRoleID = 1
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 1

declare	@UserProfileId bigint = 15631,
		@AppmoduleId int = 1

select 'PROD' as 'ENV',
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]


	--Select * from auth.UserProfiles where FirstName like '%Madison%' and isActive =1 and LastName like '%Mcgee%'
--15631 | UserProfileID
--181783 | Provider Code


--EXEC [auth].[GetUserMenusAndFeatures] 5, 1191,1


declare
	@UserProfileId bigint = 15631, 
	@ProviderId bigint = 181783, 
	@AppmoduleId bigint = 1


select * from (
select
	ROW_NUMBER() OVER(ORDER BY c.MenuId, c.SubMenuId ASC) AS RowId,@UserProfileId as 'UserProfileId', @ProviderId as 'ProviderId',c.RoleId as 'RoleId', c.RoleName as 'RoleName',
	c.MenuId,case when (@AppmoduleId = 4 and c.MenuName = 'Today''s Appointments') then 'Home' else c.MenuName end as MenuName,c.MenuPage,cast(c.MenuIcon as varchar) as MenuIcon,c.SubMenuId,c.SubMenuName,c.SubMenuPage,cast(c.SubMenuIcon as varchar) as SubMenuIcon
	,af.[AppFeatureId], af.[FeatureSectionName], af.[FeatureName], af.[FeatureCode], af.[IsSystemFeature]
	,cast((case puf.[IsCreate] when 0 then 0 else (case when af.[IsCreate]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsCreate'
	,cast((case puf.[IsRead] when 0 then 0 else (case when af.[IsRead]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsRead'
	,cast((case puf.[IsUpdate] when 0 then 0 else (case when af.[IsUpdate]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsUpdate'
	,cast((case puf.[IsDelete] when 0 then 0 else (case when af.[IsDelete]=1 then 1 when af.[FeatureCode] is not null then 0 else null end) end) as bit) as 'IsDelete'
	from (
	select
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]
	) c

	left outer join [auth].[AppModuleRoleMenuSubMenuFeatures] pfmap on pfmap.[AppModuleRoleMenuId]=c.MenuId and (pfmap.[AppModuleRoleMenuSubMenuId]=c.SubMenuId or c.SubMenuId is null)
	left outer join [auth].[ApplicationFeatures] af on af.[FeatureCode] = pfmap.[AppFeatureCode]
	left outer join [auth].[ProviderUserFeatures] puf on puf.[AppFeatureCode]=af.[FeatureCode] and puf.[UserProfileId]=@UserProfileId and puf.[ProviderID]=@ProviderId
where not exists (select * from [auth].[ProviderFeatures] pf where pf.[AppFeatureCode]=af.[FeatureCode] and pf.[ProviderId]=@ProviderId and pf.[IsActive]=1)
)a where (a.IsCreate <> 0 or a.IsRead <> 0 or a.IsUpdate <> 0) or a.MenuName = 'Today''s Appointments' or a.MenuName = 'Home' or a.SubMenuName = 'Engagement' or a.MenuName = 'Documents Library' or a.MenuName = 'Provider Network'
ORDER BY
(CASE WHEN a.MenuName = 'Home' THEN 0 ELSE 1 END)



declare	@UserProfileId bigint = 15631,
		@AppmoduleId int = 1

select 'STG' as 'ENV',
	min(r.[AppModuleRoleId]) 'RoleId',min(r.[AppModuleRoleName]) as 'RoleName',min(mn.[AppModuleRoleMenuId]) as 'MenuId',mn.[AppModuleRoleMenuName] as 'MenuName'
	,mn.[AppModuleRoleMenuPage] as 'MenuPage',min(mn.[AppModuleRoleMenuIconImage]) as 'MenuIcon'
	,min(smn.[AppModuleRoleMenuSubmenuId]) as 'SubMenuId',smn.[AppModuleRoleMenuSubmenuName] as 'SubMenuName'
	,smn.[AppModuleRoleMenuSubmenuPage] as 'SubMenuPage',min(smn.[AppModuleRoleMenuSubmenuIconImage]) as 'SubMenuIcon'
	from [auth].[AppModuleRoleMenus] mn
	inner join [auth].[AppModuleRoles] r on mn.[AppModuleRoleId] = r.[AppModuleRoleId]
	inner join [auth].[UserGroupModuleRoles] ugmr on ugmr.[AppModuleRoleId]=r.[AppModuleRoleId]
	inner join [auth].[UserProfileGroups] ugrps on ugrps.[UserGroupId] = ugmr.[UserGroupId]

	left join [auth].[AppModuleRoleMenuSubmenus] smn on smn.[AppModuleRoleMenuId] = mn.[AppModuleRoleMenuId]
	where ugrps.[UserProfileId] = @UserProfileId and r.[AppModuleId] = @AppmoduleId and r.[IsActive]=1 and ugmr.[IsActive]=1 and ugrps.[IsActive]=1 and mn.[IsActive]=1 and (smn.[IsActive]=1 or smn.[IsActive] is null)
	group by mn.[AppModuleRoleMenuName], mn.[AppModuleRoleMenuPage], smn.[AppModuleRoleMenuSubmenuName], smn.[AppModuleRoleMenuSubmenuPage]

select * from [auth].[AppModuleRoles] where AppModuleRoleID = 12
select * from [auth].[AppModuleRoleMenus] where AppModuleRoleID = 12

insert into [auth].[AppModuleRoleMenus] (AppModuleRoleID, AppModuleRoleMenuIconImage, AppModuleRoleMenuName, AppModuleRoleMenuPage, CreateDate, ModifyDate, IsActive, CreateUser, Modifyuser)
values (12, '0x66612D66696C652D746578742D6F', 'Documents Library','/DownloadDocuments', getdate(), getdate(),1,'AppTestUser', 'AppTestUser')






