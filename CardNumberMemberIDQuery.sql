
-- Get Card Information based on NHMemberID from otc, Master and Provider

declare @NHMemberID varchar(20)
set @NHMemberID = 'NH202107256820'

-- Cards
select @NHMemberID as NHMemberID, CardNumber, 'otc.Cards' as TableName, 'OTC' as Card from otc.Cards where NHMemberID = @NHMemberID

-- Master
SELECT @NHMemberID as NHMemberID, [OTCCardNumber],'Master.MemberInsuranceDetails' TableName, 'Master' as Card, 
  id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],    [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE memberinsuranceid IN (SELECT ID FROM [Master].[MemberInsurances]  --MemberInsuranceID is ID
									 WHERE memberid IN (SELECT memberid FROM master.members 
																	   WHERE NHMemberid in (@NHMemberID)
													   )
							)
and OTCCardNumber is not null

-- Provider
SELECT @NHMemberID as NHMemberID, [OTCCardNumber],'Provider.MemberInsuranceDetails' TableName,'Provider' as Card, 
	id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],    [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
WHERE memberinsuranceid IN ( SELECT MemberInsuranceID FROM Provider.MemberInsurances 
									 WHERE memberprofileid IN ( SELECT memberprofileid FROM provider.MemberProfiles
																	   WHERE NHMemberid in (@NHMemberID)
																)
							)
and OTCCardNumber is not null


--Check all three card numbers

declare @CardNumber varchar(20)
set @CardNumber = '6102812361069419697'

-- Cards
select NHMemberID, CardNumber, 'otc.Cards' as TableName, 'OTC' as Card, * from otc.Cards where CardNumber = @CardNumber

-- Master
SELECT [OTCCardNumber] as 'Master CardNumber','Master.MemberInsuranceDetails' TableName, 'Master' as Card, 
  id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  OTCCardNumber,  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE OTCCardNumber = @CardNumber

-- Provider
SELECT  [OTCCardNumber] as 'Provider CardNumber','Provider.MemberInsuranceDetails' TableName,'Provider' as Card, 
	id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  OTCCardNumber,  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
  where OTCCardNumber = @CardNumber


  /*
  select * from elig.mstrEligBenefitData where SubscriberID = '94107485801'
  select * from elig.mstrEligBenefitData where DOB like '1949-05-29' and FirstName like 'Carolyne' --or  LastName like 'Sherer') or 
  */

  select top 10 * from Master.MemberInsuranceDetails where OTCCardNumber is null

  select count(*) from Master.MemberInsuranceDetails where OTCCardNumber is null
  select count(*) from Master.MemberInsuranceDetails where OTCCardNumber is not null


declare @CardNumber nvarchar(38)
set @CardNumber = '6102812361069419697'

-- Cards
select NHMemberID, CardNumber, 'otc.Cards' as TableName, 'OTC' as Card, * from otc.Cards where CardNumber = @CardNumber

-- Master
SELECT [OTCCardNumber] as 'Master CardNumber','Master.MemberInsuranceDetails' TableName, 'Master' as Card, 
  id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  OTCCardNumber,  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
FROM [Master].[MemberInsuranceDetails]
WHERE OTCCardNumber = @CardNumber

-- Provider
SELECT  [OTCCardNumber] as 'Provider CardNumber','Provider.MemberInsuranceDetails' TableName,'Provider' as Card, 
	id, MemberInsuranceID,
  [GroupNbr],  [InsuranceNbr],  [InsurerInsuranceNbr],  OTCCardNumber,  [OTCSerialNumber],  [IsActive],  isInsuranceEligibilityVerified,  [PatientName],  [PrimaryInsuredName],  [PrimaryInsuredRelationShip],  [CreateDate],  [CreateUser],  [ModifyDate],  [ModifyUser]
  FROM [Provider].[MemberInsuranceDetails]
  where OTCCardNumber = @CardNumber

select * from orders.orders where NHMemberID = (select NHMemberID from otc.Cards where CardNumber = @CardNumber )