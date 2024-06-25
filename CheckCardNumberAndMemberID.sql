

--select NHMemberID, count(*) from otc.cards group by NHMemberID having count(*)  > 2

/*
select * from otc.cards where NHMemberID in (select NHMemberID from otc.cards group by NHMemberID having count(*)  > 2)
order by NHMemberID, CardNumber
*/

-- Check NHMemberID using CardNumber in the OTC, Master and Provider 
declare @CardNumber varchar (20)
set @CardNumber = '6363012451091915329'

declare @NHMemberID varchar(20)
set @NHMemberID = 'NH202002370154'

select 'All OTC' as TableName,NHMemberID, CardNumber from otc.cards where CardNumber = @CardNumber

select 'All Master' as TableName, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
master.Members a left join Master.MemberInsurances b on a.MemberID = b.MemberID
left join Master.MemberInsuranceDetails c on b.ID = c.MemberInsuranceID
where c.OTCCardNumber in (@CardNumber)

select 'All Provider' as TableName, NHmemberID, c.OTCCardNumber, a.*, b.*, c.* from 
provider.MemberProfiles a left join provider.MemberInsurances b on a.MemberProfileId = b.MemberProfileId
left join provider.MemberInsuranceDetails c on b.MemberInsuranceID = c.MemberInsuranceID
where c.OTCCardNumber in (@CardNumber)


-- Get Card Information based on NHMemberID from OTC, Master and Provider

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

select * from otc.cards where cardnumber = '6363011891004669631'