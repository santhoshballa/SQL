select * from insurance.InsuranceCarriers where InsuranceCarrierID = 355
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = (select InsuranceCarrierID FROM insurance.InsuranceCarriers where InsuranceCarrierID = 355)
select * from elig.BenefitCrossWalk where InsuranceCarrierId =  355
select * from elig.ClientCodes where InsuranceCarrierID  = 355
select * from elig.mstrEligBenefitData where insCarrierID = 355
select distinct insHealthPlanID from elig.mstrEligBenefitData where insCarrierID = 355

select * from elig.BenefitCrossWalk where InsuranceCarrierId =  355

select top 10 * from elig.BenefitCrossWalk where PBPID = '803'

select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+'|'    +''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+ '|'     +'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME+ '|'    +''''+ ' as COLUMN_NAME,'
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where TABLE_NAME IN ('BenefitCrossWalk' ) 
and TABLE_SCHEMA IN ('elig')
--and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')
and COLUMN_NAME NOT IN ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')


select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'ID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ID] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'ClientCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ClientCode] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'ContractNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ContractNbr] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'GroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([GroupNbr] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'ProductID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductID] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'PlanID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanID] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'PBPID|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PBPID] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'LOB|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([LOB] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'PlanName|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([PlanName] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'IncommPlanCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IncommPlanCode] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'HealthPlanNumber|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([HealthPlanNumber] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'InsuranceCarrierId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierId] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'InsuranceHealthPlanId|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanId] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'Isactive|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Isactive] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'SubGroupNbr|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([SubGroupNbr] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'BusinessCategory|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BusinessCategory] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a union 
select top 100 * from  (select distinct  'elig|' as TABLE_SCHEMA,'BenefitCrossWalk|' as TABLE_NAME,'ProductValueCode|' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ProductValueCode] as nvarchar))),'"') as VALUE from elig.[BenefitCrossWalk]) a



select * from elig.mstrEligBenefitData where insCarrierID =  355 and InsuranceCarrierName = 
select * from insurance.InsuranceCarriers where InsuranceCarrierID = 355
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = (select InsuranceCarrierID FROM insurance.InsuranceCarriers where InsuranceCarrierID = 355)
select * from elig.BenefitCrossWalk where InsuranceCarrierId =  355
select * from elig.EligibilityColumnValidation where clientCode = 'H447' and XWalkFlag = 1
select * from elig.ClientCodes where InsuranceCarrierID  = 355


select distinct insCarrierID, insHealthPlanID, dataSource, isActive, GroupNbr, SubGroupNbr, ContractNbr, PBPID from
elig.mstrEligBenefitData
where 1=1 and
insCarrierID = '355' 
--insHealthPlanID = '' or
--GroupNbr = '' or
--dataSource = ''

select distinct insCarrierID, insHealthPlanID, dataSource,ContractNbr, PBPID from
elig.mstrEligBenefitData
where 1=1 and
insCarrierID = '355'

select * from information_schema.columns where column_name  like '%err%' and table_schema = 'elig'

select top 10 * from elig.errEligBenefitData
select  errEligID, FileTrackID, DataSource, GroupNbr, SubGroupNbr, ContractNbr, PBPID, a.* from elig.errEligBenefitData a where dataSource = 'ELIG_CVTG_ND' and fileTrackID = (select max(fileTrackID) from elig.errEligBenefitData where dataSource = 'ELIG_CVTG_ND')


select a.* from elig.errEligBenefitDataDetails a where errEligID in (select errEligID from elig.errEligBenefitData a where dataSource = 'ELIG_CVTG_ND' and fileTrackID = (select max(fileTrackID) from elig.errEligBenefitData where dataSource = 'ELIG_CVTG_ND'))


select a.insuranceCarrierID, insuranceCarrierName, b.InsuranceHealthPlanID, b.HealthPlanNumber, b.HealthPlanName, c.ID, c.ClientCode, c.ContractNbr, c.GroupNbr, c.ProductID, c.PlanID, c.PBPID, c.PlanName, c.HealthPlanNumber, c.InsuranceCarrierID, c.InsuranceHealthPlanId
from 
insurance.InsuranceCarriers a inner join insurance.InsuranceHealthPlans b on a.InsuranceCarrierID = b.InsuranceCarrierID
inner join elig.BenefitCrossWalk c on b.InsuranceCarrierID = c.InsuranceCarrierId and b.InsuranceHealthPlanID = c.InsuranceHealthPlanId
where 1=1 and
--a.insuranceCarrierName = 'NextBlue of North Dakota' or
a.InsuranceCarrierID = 355
--b.HealthPlanName = '' or
--c.ClientCode = '' or 
--c.ContractNbr = '' or
--c.PBPID = '001'

order by a.insuranceCarrierID, ClientCode

select * from elig.ClientCodes where InsuranceCarrierID  = 355



/*
Here are the tables to look at for plans related to data source 'ELIG_CVTG_ND'

insurance.insuranceCarrier
insurance.insuranceHealthPlans
elig.CrosswalkBenefitData
elig.errEligBenefitData -- to check what HealthPlans were not loaded.
elig.
*/

declare @ClientCode varchar(20) = 'H447'
declare @DataSource varchar(40) = 'ELIG_CVTG_ND'
declare @insCarrierID int =  355
declare @HealthPlanName varchar(20) = 'Next Blue of ND'
declare @HealthPlanNumber varchar(20) = 'H6202-803'
declare @CreateUser varchar(20) = N'Rsareddy'
declare @ModifyUser varchar(20) = N'Rsareddy'
declare @PBPID varchar(20) = '803'
declare @GroupNbr varchar(20) = 'H6202803'
declare @ContractNbr varchar(20) = 'H6202'

select distinct 'elig.errEligBenefitData' as TableName, dataSource, ContractNbr, PBPID, GroupNbr from elig.errEligBenefitData a where dataSource = 'ELIG_CVTG_ND' and fileTrackID = (select max(fileTrackID) from elig.errEligBenefitData where dataSource = 'ELIG_CVTG_ND')

--This query will provide the ContractNbr, PBPID and GroupNbr that is not present in the elig.CrosswalkBenefitData
select distinct 'elig.errEligBenefitData' as TableName, dataSource, ContractNbr, PBPID, GroupNbr from elig.errEligBenefitData a where dataSource = @DataSource and fileTrackID = (select max(fileTrackID) from elig.errEligBenefitData where dataSource = @DataSource)

--Check the BenefitCrosswalk table to check for the Insurance carrier and the Plan
select 'elig.BenefitCrossWalk' as TableName, * from elig.BenefitCrossWalk where InsuranceCarrierId =  355
select 'elig.BenefitCrossWalk' as TableName, * from elig.BenefitCrossWalk where InsuranceCarrierId =  @insCarrierID

select 'insurance.InsuranceCarriers' as TableName,* from insurance.InsuranceCarriers where InsuranceCarrierID = 355
select 'insurance.InsuranceCarriers' as TableName,* from insurance.InsuranceCarriers where InsuranceCarrierID =  @insCarrierID

select 'insurance.InsuranceHealthPlans' as TableName,* from insurance.InsuranceHealthPlans where InsuranceCarrierID = 355
select 'insurance.InsuranceHealthPlans' as TableName,* from insurance.InsuranceHealthPlans where InsuranceCarrierID =  @insCarrierID

select distinct 'elig.mstrEligBenefitData' as TableName, datasource, insCarrierID, insHealthPlanID, GroupNbr, ContractNbr, PBPID from elig.mstrEligBenefitData a where insCarrierID = @insCarrierID
select distinct 'elig.mstrEligBenefitData' as TableName, insHealthPlanID from elig.mstrEligBenefitData where insCarrierID = @insCarrierID

select  'elig.BenefitCrossWalk' as TableName, * from elig.BenefitCrossWalk where InsuranceCarrierId =  355
select  'elig.BenefitCrossWalk' as TableName, * from elig.BenefitCrossWalk where InsuranceCarrierId =  @insCarrierID

--Insert records into three tables in this Order
-- 1. Insurance.insuranceCarrrier  -- If the Insurance Carrier is already not present
-- 2. Insurance.insuranceHealthPlanID -- If the Insurance Health Plan is already not present, use the insurance carrier 
-- 3. elig.BenefitCrossWalk -- To make sure that the Health Plan Information is not blocked or errored out while loading the eligibility information containing HealthPlans.


--insurance.insuranceCarrier
-- The insurance carrier is already present and so do not have to insert the insurance carrier
/*
INSERT INTO insurance.InsuranceCarriers (ClaimsAddress1, ClaimsAddress2, ClaimsCity, ClaimsEmailAddress, ClaimsPhoneNbr, ClaimsState, ClaimsZipCode, CreateDate, CreateUser, CustServiceAddress1, CustServiceAddress2, CustServiceCity, CustServiceEmailAddress, CustServicePhoneNbr, CustServiceState, CustServiceZipCode, InsuranceCarrierName, IsActive, IsContracted, IsDiscountProgram, MemberDataFileProvided, ModifyDate, ModifyUser, IsAutoSendPaymentReceipt, CarrierConfig, IsNHDiscount, AllowAdditionalServices) 
VALUES (NULL, NULL, NULL, NULL, NULL, NULL, NULL, GETDATE(), N'Rsareddy', NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'NVA Groups', CONVERT(bit, 'True'), CONVERT(bit, 'True'), CONVERT(bit, 'True'), CONVERT(bit, 'False'), NULL, NULL, CONVERT(bit, 'False'), NULL, CONVERT(bit, 'False'), CONVERT(bit, 'False'))
*/


--insurance.insuranceHealthPlans
INSERT [Insurance].[InsuranceHealthPlans] 
( [CreateDate], [CreateUser], [HealthPlanName], [HealthPlanNumber], [InsuranceCarrierID], [IsActive], [IsDiscountProgram], [ModifyDate], [ModifyUser], [IsMedicaid], [IsMedicare], [PlanConfigData], [IsProgramCode]) 
VALUES (GETDATE(), @CreateUser, @HealthPlanName, @HealthPlanNumber, @insCarrierID, 1, 0, GETDATE(), @ModifyUser, 0, 0, NULL, 0)

--elig.BenefitCrossWalk
declare @InsuranceHealthPlanId varchar(20)
select  @InsuranceHealthPlanId = InsuranceHealthPlanId from [Insurance].[InsuranceHealthPlans] where InsuranceCarrierID = @insCarrierID and HealthPlanName = @HealthPlanName and HealthPlanNumber = @HealthPlanNumber


INSERT [elig].[BenefitCrossWalk] 
([ClientCode], [ContractNbr], [GroupNbr], [ProductID], [PlanID], [PBPID], [LOB], [PlanName], [IncommPlanCode], [HealthPlanNumber], [InsuranceCarrierId], [InsuranceHealthPlanId], [Isactive], [CreateDate], [CreateUser], [ModifyDate], [ModifyUser], [SubGroupNbr], [BusinessCategory], [ProductValueCode]) 
VALUES (@ClientCode, @ContractNbr, @GroupNbr, N'', N'', @PBPID , N'', @HealthPlanName, N'', N'H6202-803', @insCarrierID, @InsuranceHealthPlanId, 1, Getdate(), @CreateUser ,Getdate(), @ModifyUser , NULL, NULL, NULL)


/*
-- Check, Verfiy the insert Statements

select * from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota'
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = ( select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota') -- and HealthPlanName = 'Next Blue of ND'
select * from elig.BenefitCrossWalk where InsuranceCarrierId = ( select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota') --and ContractNbr = 'H6202' and PBPID = '803'

*/


/*


begin tran

declare @DataSource varchar(40) = 'ELIG_CVTG_ND'
declare @insCarrierID int =  355
declare @HealthPlanName varchar(40) = 'Next Blue of ND H6202-803'
declare @HealthPlanNumber varchar(20) = 'H6202-803'
declare @CreateUser varchar(20) = N'Rsareddy'
declare @ModifyUser varchar(20) = N'Rsareddy'
declare @PBPID varchar(20) = '803'

-- insurance.insuranceHealthPlans
INSERT [Insurance].[InsuranceHealthPlans] 
( [CreateDate], [CreateUser], [HealthPlanName], [HealthPlanNumber], [InsuranceCarrierID], [IsActive], [IsDiscountProgram], [ModifyDate], [ModifyUser], [IsMedicaid], [IsMedicare], [PlanConfigData], [IsProgramCode]) 
VALUES (GETDATE(), @CreateUser, @HealthPlanName, @HealthPlanNumber, @insCarrierID, 1, 0, GETDATE(), @ModifyUser, 0, 0, NULL, 0)

-- set the insuranceHealthPlanID to insert into the CrossWalk table
declare @InsuranceHealthPlanId varchar(20)
select  @InsuranceHealthPlanId = InsuranceHealthPlanId from [Insurance].[InsuranceHealthPlans] where InsuranceCarrierID = @insCarrierID and HealthPlanName = @HealthPlanName and HealthPlanNumber = @HealthPlanNumber

-- elig.BenefitCrossWalk
INSERT [elig].[BenefitCrossWalk] 
([ClientCode], [ContractNbr], [GroupNbr], [ProductID], [PlanID], [PBPID], [LOB], [PlanName], [IncommPlanCode], [HealthPlanNumber], [InsuranceCarrierId], [InsuranceHealthPlanId], [Isactive], [CreateDate], [CreateUser], [ModifyDate], [ModifyUser], [SubGroupNbr], [BusinessCategory], [ProductValueCode]) 
VALUES (N'H447', N'H6202', N'H6202803', N'', N'', N'803', N'', N'Next Blue of ND', N'', N'H6202-803', @insCarrierID, @InsuranceHealthPlanId, 1, Getdate(), @CreateUser ,Getdate(), @ModifyUser , NULL, NULL, NULL)


-- Check, Verfiy the insert Statements

select * from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota'
select * from insurance.InsuranceHealthPlans where InsuranceCarrierID = ( select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota') -- and HealthPlanName = 'Next Blue of ND'
select * from elig.BenefitCrossWalk where InsuranceCarrierId = ( select InsuranceCarrierID from insurance.InsuranceCarriers where InsuranceCarrierName = 'NextBlue of North Dakota') --and ContractNbr = 'H6202' and PBPID = '803'

rollback tran

*/


select distinct datasource, inscarrierID, insHealthPlanID, GroupNbr, SubGroupNbr, ContractNbr, PBPID, MaintenanceType, InsuranceLineCode from elig.mstrEligBenefitData where insCarrierID = 355
select distinct datasource, inscarrierID, insHealthPlanID, GroupNbr, SubGroupNbr, ContractNbr, PBPID, MaintenanceType, InsuranceLineCode from elig.mstrEligBenefitData