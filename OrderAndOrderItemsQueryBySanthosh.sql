
declare @NHMemberId varchar(20)
set @NHMemberId = 'NH202106684620'

--If you need to look for multiple Member's
IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002562120') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002594431') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002572443') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002587342') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002586357') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002586357') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002584305') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106520728') -- OTC
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002591186') -- OTC
insert into #NHMemberIDTemp (NHMemberID) values ('NH202002125285') -- OTC

--, ('NH202002689003')

--select orderType, count(*) from orders.Orders group by orderType

-- This select provides you all the information (including JSON Key, value pairs) from the Orders.Orders table


select 
'Orders.Orders' as TableName,
*, -- all columns

--MemberData

MemberData
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName 
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber 
,json_value(orders.MemberData, '$.dob') as MemberData_dob

--MemberData | address
,json_value(orders.MemberData, '$.address.address') as MemberData_address
,json_value(orders.MemberData, '$.address.city') as MemberData_city
,json_value(orders.MemberData, '$.address.state') as MemberData_state 
,json_value(orders.MemberData, '$.address.zip') as MemberData_zip


--MemberData | insurance
,json_value(orders.MemberData, '$.insurance.carrierName') as MemberData_carrierName
,json_value(orders.MemberData, '$.insurance.planName') as MemberData_planName
,json_value(orders.MemberData, '$.insurance.programeName') as MemberData_programeName
,json_value(orders.MemberData, '$.insurance.insuranceMemberId') as MemberData_insuranceMemberId
,json_value(orders.MemberData, '$.insurance.nhMemberId') as MemberData_nhMemberId
,json_value(orders.MemberData, '$.insurance.insuranceBenefit') as MemberData_insuranceBenefit
,json_value(orders.MemberData, '$.insurance.benefitUsed') as MemberData_benefitUsed
,json_value(orders.MemberData, '$.insurance.lastBenefitUsedDate') as MemberData_lastBenefitUsedDate
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId


--OrderAmountData
,OrderAmountData
,json_value(orders.OrderAmountData, '$.productPrice') as OrderAmountData_productPrice
,json_value(orders.OrderAmountData, '$.insuranceBenefit') as OrderAmountData_insuranceBenefit
,json_value(orders.OrderAmountData, '$.benefitUsed') as OrderAmountData_benefitUsed
,json_value(orders.OrderAmountData, '$.benefitAvailable') as OrderAmountData_benefitAvailable
,json_value(orders.OrderAmountData, '$.memberResponsibility') as OrderAmountData_memberResponsibility
,json_value(orders.OrderAmountData, '$.itemcode') as OrderAmountData_itemcode
,json_value(orders.OrderAmountData, '$.vsPrice') as OrderAmountData_vsPrice
,json_value(orders.OrderAmountData, '$.vsTechLevel') as OrderAmountData_vsTechLevel

,'OTC_OrderAmountData' as OTC_LineOfBusiness
,json_value(orders.OrderAmountData, '$.price') as OrderAmountData_price
,json_value(orders.OrderAmountData, '$.amountCovered') as OrderAmountData_amountCovered
,json_value(orders.OrderAmountData, '$.outOfPocket') as OrderAmountData_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions0_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].originalWalletCode') as OrderAmountData_benefitTransactions0_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].benefitType') as OrderAmountData_benefitTransactions0_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].acctLast4Digits') as OrderAmountData_benefitTransactions0_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountCovered') as OrderAmountData_benefitTransactions0_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountRemaining') as OrderAmountData_benefitTransactions0_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].transactionId') as OrderAmountData_benefitTransactions0_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].outOfPocket') as OrderAmountData_benefitTransactions0_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].source') as OrderAmountData_benefitTransactions0_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].emiData') as OrderAmountData_benefitTransactions0_emiData
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions1_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].catalogName') as OrderAmountData_benefitTransactions1_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].originalWalletCode') as OrderAmountData_benefitTransactions1_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].benefitType') as OrderAmountData_benefitTransactions1_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].acctLast4Digits') as OrderAmountData_benefitTransactions1_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountCovered') as OrderAmountData_benefitTransactions1_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountRemaining') as OrderAmountData_benefitTransactions1_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].transactionId') as OrderAmountData_benefitTransactions1_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].outOfPocket') as OrderAmountData_benefitTransactions1_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].source') as OrderAmountData_benefitTransactions1_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].emiData') as OrderAmountData_benefitTransactions1_emiData



--ShippingData
,ShippingData
,json_value(orders.ShippingData, '$.providerBusinessName') as ShippingData_providerBusinessName
,json_value(orders.ShippingData, '$.dispenser') as ShippingData_dispenser
,json_value(orders.ShippingData, '$.dba') as ShippingData_dba -- What is this column used for?

--ShippingData | address
,json_value(orders.ShippingData, '$.address.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address2

,json_value(orders.ShippingData, '$.address.city') as ShippingData_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_zip
,json_value(orders.ShippingData, '$.address.country') as ShippingData_country

,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_shippingInstructions
,json_value(orders.ShippingData, '$.manufacturer') as ShippingData_manufacturer
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.faxNumber') as ShippingData_faxNumber




,'OTC_ShippingData' as OTC_LineOfBusiness_ShippingData
--ShippingData | address


,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address_address2
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address_zip
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address_county
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address_country
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_address_shippingInstructions
,json_value(orders.ShippingData, '$.verifyShippingAddress') as ShippingData_address_verifyShippingAddress


--ProviderData
--dba (doing business as)
,ProviderData
,json_value(orders.ProviderData, '$.providerLeagalBusinessName') as ProviderData_providerLeagalBusinessName
,json_value(orders.ProviderData, '$.dba') as ProviderData_dba
,json_value(orders.ProviderData, '$.dispenser') as ProviderData_dispenser
,json_value(orders.ProviderData, '$.emailId') as ProviderData_emailId

--ProviderData | address
,json_value(orders.ProviderData, '$.address.address') as ProviderData_address_address
,json_value(orders.ProviderData, '$.address.address1') as ProviderData_address_address1
,json_value(orders.ProviderData, '$.address.city') as ProviderData_address_city
,json_value(orders.ProviderData, '$.address.state') as ProviderData_address_state
,json_value(orders.ProviderData, '$.address.zip') as ProviderData_address_zip
,json_value(orders.ProviderData, '$.address.locationId') as ProviderData_address_locationId


--ProviderData | hcp
,json_value(orders.ProviderData, '$.hcp.firstName') as ProviderData_hcp_firstName
,json_value(orders.ProviderData, '$.hcp.lastName') as ProviderData_hcp_lastName
,json_value(orders.ProviderData, '$.hcp.npiNumber') as ProviderData_hcp_npinumber
,json_value(orders.ProviderData, '$.hcp.phoneNumber') as ProviderData_hcp_phoneNumber
,json_value(orders.ProviderData, '$.hcp.hcpid') as ProviderData_hcp_hcpid
,json_value(orders.ProviderData, '$.hcp.faxNumber') as ProviderData_hcp_faxNumber
,json_value(orders.ProviderData, '$.providerId') as ProviderData_providerId



-- BenefitsData
,json_value(orders.BenefitsData, '$.applied.benefitsLeft') as BenefitsData_applied_benefitsLeft
,json_value(orders.BenefitsData, '$.applied.benefitsRight') as BenefitsData_applied_benefitsRight
,json_value(orders.BenefitsData, '$.eligible.benefitsLeft') as BenefitsData_eligible_benefitsLeft
,json_value(orders.BenefitsData, '$.eligible.benefitsRight') as BenefitsData_eligible_benefitsRight
,json_value(orders.BenefitsData, '$.used.benefitsLeft') as BenefitsData_used_benefitsLeft
,json_value(orders.BenefitsData, '$.used.benefitsRight') as BenefitsData_used_benefitsRight
,json_value(orders.BenefitsData, '$.available.benefitsLeft') as BenefitsData_available_benefitsLeft
,json_value(orders.BenefitsData, '$.available.benefitsRight') as BenefitsData_available_benefitsRight
,json_value(orders.BenefitsData, '$.remaining.benefitsLeft') as BenefitsData_remaining_benefitsLeft
,json_value(orders.BenefitsData, '$.remaining.benefitsRight') as BenefitsData_remaining_benefitsRight
,json_value(orders.BenefitsData, '$.benefitAppliedAmount') as BenefitsData_benefitAppliedAmount
,json_value(orders.BenefitsData, '$.outOfPocket') as BenefitsData_outOfPocket
,json_value(orders.BenefitsData, '$.bencat') as BenefitsData_bencat
,json_value(orders.BenefitsData, '$.technologyLevel') as BenefitsData_technologyLevel
,json_value(orders.BenefitsData, '$.benfortype') as BenefitsData_benfortype
,json_value(orders.BenefitsData, '$.terminationDate') as BenefitsData_terminationDate
,json_value(orders.BenefitsData, '$.benfreqtype') as BenefitsData_benfreqtype

,json_value(orders.BenefitsData, '$.applied.benefitsLeft') as BenefitsData_applied_benefitsLeft
,json_value(orders.BenefitsData, '$.applied.benefitsRight') as BenefitsData_applied_benefitsRight
,json_value(orders.BenefitsData, '$.eligible.benefitsLeft') as BenefitsData_eligible_benefitsLeft
,json_value(orders.BenefitsData, '$.eligible.benefitsRight') as BenefitsData_eligible_benefitsRight
,json_value(orders.BenefitsData, '$.used.benefitsLeft') as BenefitsData_used_benefitsLeft
,json_value(orders.BenefitsData, '$.used.benefitsRight') as BenefitsData_used_benefitsRight
,json_value(orders.BenefitsData, '$.available.benefitsLeft') as BenefitsData_available_benefitsLeft
,json_value(orders.BenefitsData, '$.available.benefitsRight') as BenefitsData_available_benefitsRight
,json_value(orders.BenefitsData, '$.remaining.benefitsLeft') as BenefitsData_remaining_benefitsLeft
,json_value(orders.BenefitsData, '$.remaining.benefitsRight') as BenefitsData_remaining_benefitsRight

,json_value(orders.BenefitsData, '$.applied.devicesCount') as BenefitsData_applied_devicesCount
,json_value(orders.BenefitsData, '$.eligible.devicesCount') as BenefitsData_eligible_devicesCount
,json_value(orders.BenefitsData, '$.used.devicesCount') as BenefitsData_used_devicesCount
,json_value(orders.BenefitsData, '$.available.devicesCount') as BenefitsData_available_devicesCount
,json_value(orders.BenefitsData, '$.remaining.devicesCount') as BenefitsData_remaining_devicesCount
,json_value(orders.BenefitsData, '$.benefitAppliedAmount') as BenefitsData_benefitAppliedAmount
,json_value(orders.BenefitsData, '$.outOfPocket') as BenefitsData_outOfPocket
,json_value(orders.BenefitsData, '$.bencat') as BenefitsData_bencat
,json_value(orders.BenefitsData, '$.technologyLevel') as BenefitsData_technologyLevel
,json_value(orders.BenefitsData, '$.benfortype') as BenefitsData_benfortype
,json_value(orders.BenefitsData, '$.benfreqtype') as BenefitsData_benfreqtype


from orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp )



select
'Orders.orderitems' as TableName
, *
-- ItemData
,json_value(orderItems.ItemData, '$.color') as ItemData_color
,json_value(orderItems.ItemData, '$.batterySize') as ItemData_batterySize
,json_value(orderItems.ItemData, '$.receiverSize') as ItemData_receiverSize
,json_value(orderItems.ItemData, '$.receiverPower') as ItemData_receiverPower
,json_value(orderItems.ItemData, '$.earMold') as ItemData_earMold
,json_value(orderItems.ItemData, '$.serialNbr') as ItemData_serialNbr
,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.nationsId') as ItemData_nationsId
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName
,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
--Others
,json_value(orderItems.ItemData, '$.sendingImpression') as ItemData_sendingImpression

from Orders.orderItems where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))


select  * from otc.UserProfiles where NHMemberID = 'NH202002562120'





declare @NHMemberId varchar(20)
set @NHMemberId = 'NH201700005837'

--If you need to look for multiple Member's
IF OBJECT_ID('tempdb..#NHMemberIDTemp') IS NOT NULL DROP TABLE #NHMemberIDTemp
Create table #NHMemberIDTemp 
(NHMemberID varchar(20))
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002562120') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002594431') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002572443') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002587342') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002586357') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002586357') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202002584305') -- OTC
--insert into #NHMemberIDTemp (NHMemberID) values ('NH202106520728') -- OTC
-- insert into #NHMemberIDTemp (NHMemberID) values ('NH202002591186') -- OTC
 insert into #NHMemberIDTemp (NHMemberID) values ('NH202002691172') -- OTC

--, ('NH202002689003')

select orderType, count(*) from orders.Orders group by orderType

-- This select provides you all the information (including JSON Key, value pairs) from the Orders.Orders table


select 
'Orders.Orders' as TableName,
*, -- all columns

--MemberData

MemberData
,json_value(orders.MemberData, '$.firstName') as MemberData_firstName
,json_value(orders.MemberData, '$.lastName') as MemberData_lastName 
,json_value(orders.MemberData, '$.phoneNumber') as MemberData_phoneNumber 
,json_value(orders.MemberData, '$.dob') as MemberData_dob

--MemberData | address
,json_value(orders.MemberData, '$.address.address') as MemberData_address
,json_value(orders.MemberData, '$.address.city') as MemberData_city
,json_value(orders.MemberData, '$.address.state') as MemberData_state 
,json_value(orders.MemberData, '$.address.zip') as MemberData_zip


--MemberData | insurance
,json_value(orders.MemberData, '$.insurance.carrierName') as MemberData_carrierName
,json_value(orders.MemberData, '$.insurance.planName') as MemberData_planName
,json_value(orders.MemberData, '$.insurance.programeName') as MemberData_programeName
,json_value(orders.MemberData, '$.insurance.insuranceMemberId') as MemberData_insuranceMemberId
,json_value(orders.MemberData, '$.insurance.nhMemberId') as MemberData_nhMemberId
,json_value(orders.MemberData, '$.insurance.insuranceBenefit') as MemberData_insuranceBenefit
,json_value(orders.MemberData, '$.insurance.benefitUsed') as MemberData_benefitUsed
,json_value(orders.MemberData, '$.insurance.lastBenefitUsedDate') as MemberData_lastBenefitUsedDate
,json_value(orders.MemberData, '$.insCarrierId') as MemberData_insCarrierId
,json_value(orders.MemberData, '$.insPlanId') as MemberData_insPlanId


--OrderAmountData
,OrderAmountData
,json_value(orders.OrderAmountData, '$.productPrice') as OrderAmountData_productPrice
,json_value(orders.OrderAmountData, '$.insuranceBenefit') as OrderAmountData_insuranceBenefit
,json_value(orders.OrderAmountData, '$.benefitUsed') as OrderAmountData_benefitUsed
,json_value(orders.OrderAmountData, '$.benefitAvailable') as OrderAmountData_benefitAvailable
,json_value(orders.OrderAmountData, '$.memberResponsibility') as OrderAmountData_memberResponsibility
,json_value(orders.OrderAmountData, '$.itemcode') as OrderAmountData_itemcode
,json_value(orders.OrderAmountData, '$.vsPrice') as OrderAmountData_vsPrice
,json_value(orders.OrderAmountData, '$.vsTechLevel') as OrderAmountData_vsTechLevel

,'OTC_OrderAmountData' as OTC_LineOfBusiness
,json_value(orders.OrderAmountData, '$.price') as OrderAmountData_price
,json_value(orders.OrderAmountData, '$.amountCovered') as OrderAmountData_amountCovered
,json_value(orders.OrderAmountData, '$.outOfPocket') as OrderAmountData_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions0_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].catalogName') as OrderAmountData_benefitTransactions0_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].originalWalletCode') as OrderAmountData_benefitTransactions0_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].benefitType') as OrderAmountData_benefitTransactions0_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].acctLast4Digits') as OrderAmountData_benefitTransactions0_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountCovered') as OrderAmountData_benefitTransactions0_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].amountRemaining') as OrderAmountData_benefitTransactions0_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].transactionId') as OrderAmountData_benefitTransactions0_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].outOfPocket') as OrderAmountData_benefitTransactions0_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].source') as OrderAmountData_benefitTransactions0_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[0].emiData') as OrderAmountData_benefitTransactions0_emiData
,json_value(orders.OrderAmountData, '$.benefitTransactions[0]') as OrderAmountData_benefitTransactions1_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].catalogName') as OrderAmountData_benefitTransactions1_catalogName
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].originalWalletCode') as OrderAmountData_benefitTransactions1_originalWalletCode
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].benefitType') as OrderAmountData_benefitTransactions1_benefitType
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].acctLast4Digits') as OrderAmountData_benefitTransactions1_acctLast4Digits
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountCovered') as OrderAmountData_benefitTransactions1_amountCovered
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].amountRemaining') as OrderAmountData_benefitTransactions1_amountRemaining
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].transactionId') as OrderAmountData_benefitTransactions1_transactionId
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].outOfPocket') as OrderAmountData_benefitTransactions1_outOfPocket
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].source') as OrderAmountData_benefitTransactions1_source
,json_value(orders.OrderAmountData, '$.benefitTransactions[1].emiData') as OrderAmountData_benefitTransactions1_emiData



--ShippingData
,ShippingData
,json_value(orders.ShippingData, '$.providerBusinessName') as ShippingData_providerBusinessName
,json_value(orders.ShippingData, '$.dispenser') as ShippingData_dispenser
,json_value(orders.ShippingData, '$.dba') as ShippingData_dba -- What is this column used for?

--ShippingData | address
,json_value(orders.ShippingData, '$.address.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address2

,json_value(orders.ShippingData, '$.address.city') as ShippingData_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_zip
,json_value(orders.ShippingData, '$.address.country') as ShippingData_country

,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_shippingInstructions
,json_value(orders.ShippingData, '$.manufacturer') as ShippingData_manufacturer
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.faxNumber') as ShippingData_faxNumber




,'OTC_ShippingData' as OTC_LineOfBusiness_ShippingData
--ShippingData | address


,json_value(orders.ShippingData, '$.firstName') as ShippingData_firstName
,json_value(orders.ShippingData, '$.lastName') as ShippingData_lastName
,json_value(orders.ShippingData, '$.phoneNumber') as ShippingData_phoneNumber
,json_value(orders.ShippingData, '$.email') as ShippingData_email
,json_value(orders.ShippingData, '$.address') as ShippingData_address
,json_value(orders.ShippingData, '$.address.address1') as ShippingData_address_address1
,json_value(orders.ShippingData, '$.address.address2') as ShippingData_address_address2
,json_value(orders.ShippingData, '$.address.city') as ShippingData_address_city
,json_value(orders.ShippingData, '$.address.state') as ShippingData_address_state
,json_value(orders.ShippingData, '$.address.zip') as ShippingData_address_zip
,json_value(orders.ShippingData, '$.address.county') as ShippingData_address_county
,json_value(orders.ShippingData, '$.address.country') as ShippingData_address_country
,json_value(orders.ShippingData, '$.shippingInstructions') as ShippingData_address_shippingInstructions
,json_value(orders.ShippingData, '$.verifyShippingAddress') as ShippingData_address_verifyShippingAddress


--ProviderData
--dba (doing business as)
,ProviderData
,json_value(orders.ProviderData, '$.providerLeagalBusinessName') as ProviderData_providerLeagalBusinessName
,json_value(orders.ProviderData, '$.dba') as ProviderData_dba
,json_value(orders.ProviderData, '$.dispenser') as ProviderData_dispenser
,json_value(orders.ProviderData, '$.emailId') as ProviderData_emailId

--ProviderData | address
,json_value(orders.ProviderData, '$.address.address') as ProviderData_address_address
,json_value(orders.ProviderData, '$.address.address1') as ProviderData_address_address1
,json_value(orders.ProviderData, '$.address.city') as ProviderData_address_city
,json_value(orders.ProviderData, '$.address.state') as ProviderData_address_state
,json_value(orders.ProviderData, '$.address.zip') as ProviderData_address_zip
,json_value(orders.ProviderData, '$.address.locationId') as ProviderData_address_locationId


--ProviderData | hcp
,json_value(orders.ProviderData, '$.hcp.firstName') as ProviderData_hcp_firstName
,json_value(orders.ProviderData, '$.hcp.lastName') as ProviderData_hcp_lastName
,json_value(orders.ProviderData, '$.hcp.npiNumber') as ProviderData_hcp_npinumber
,json_value(orders.ProviderData, '$.hcp.phoneNumber') as ProviderData_hcp_phoneNumber
,json_value(orders.ProviderData, '$.hcp.hcpid') as ProviderData_hcp_hcpid
,json_value(orders.ProviderData, '$.hcp.faxNumber') as ProviderData_hcp_faxNumber
,json_value(orders.ProviderData, '$.providerId') as ProviderData_providerId



-- BenefitsData
,json_value(orders.BenefitsData, '$.applied.benefitsLeft') as BenefitsData_applied_benefitsLeft
,json_value(orders.BenefitsData, '$.applied.benefitsRight') as BenefitsData_applied_benefitsRight
,json_value(orders.BenefitsData, '$.eligible.benefitsLeft') as BenefitsData_eligible_benefitsLeft
,json_value(orders.BenefitsData, '$.eligible.benefitsRight') as BenefitsData_eligible_benefitsRight
,json_value(orders.BenefitsData, '$.used.benefitsLeft') as BenefitsData_used_benefitsLeft
,json_value(orders.BenefitsData, '$.used.benefitsRight') as BenefitsData_used_benefitsRight
,json_value(orders.BenefitsData, '$.available.benefitsLeft') as BenefitsData_available_benefitsLeft
,json_value(orders.BenefitsData, '$.available.benefitsRight') as BenefitsData_available_benefitsRight
,json_value(orders.BenefitsData, '$.remaining.benefitsLeft') as BenefitsData_remaining_benefitsLeft
,json_value(orders.BenefitsData, '$.remaining.benefitsRight') as BenefitsData_remaining_benefitsRight
,json_value(orders.BenefitsData, '$.benefitAppliedAmount') as BenefitsData_benefitAppliedAmount
,json_value(orders.BenefitsData, '$.outOfPocket') as BenefitsData_outOfPocket
,json_value(orders.BenefitsData, '$.bencat') as BenefitsData_bencat
,json_value(orders.BenefitsData, '$.technologyLevel') as BenefitsData_technologyLevel
,json_value(orders.BenefitsData, '$.benfortype') as BenefitsData_benfortype
,json_value(orders.BenefitsData, '$.terminationDate') as BenefitsData_terminationDate
,json_value(orders.BenefitsData, '$.benfreqtype') as BenefitsData_benfreqtype

,json_value(orders.BenefitsData, '$.applied.benefitsLeft') as BenefitsData_applied_benefitsLeft
,json_value(orders.BenefitsData, '$.applied.benefitsRight') as BenefitsData_applied_benefitsRight
,json_value(orders.BenefitsData, '$.eligible.benefitsLeft') as BenefitsData_eligible_benefitsLeft
,json_value(orders.BenefitsData, '$.eligible.benefitsRight') as BenefitsData_eligible_benefitsRight
,json_value(orders.BenefitsData, '$.used.benefitsLeft') as BenefitsData_used_benefitsLeft
,json_value(orders.BenefitsData, '$.used.benefitsRight') as BenefitsData_used_benefitsRight
,json_value(orders.BenefitsData, '$.available.benefitsLeft') as BenefitsData_available_benefitsLeft
,json_value(orders.BenefitsData, '$.available.benefitsRight') as BenefitsData_available_benefitsRight
,json_value(orders.BenefitsData, '$.remaining.benefitsLeft') as BenefitsData_remaining_benefitsLeft
,json_value(orders.BenefitsData, '$.remaining.benefitsRight') as BenefitsData_remaining_benefitsRight

,json_value(orders.BenefitsData, '$.applied.devicesCount') as BenefitsData_applied_devicesCount
,json_value(orders.BenefitsData, '$.eligible.devicesCount') as BenefitsData_eligible_devicesCount
,json_value(orders.BenefitsData, '$.used.devicesCount') as BenefitsData_used_devicesCount
,json_value(orders.BenefitsData, '$.available.devicesCount') as BenefitsData_available_devicesCount
,json_value(orders.BenefitsData, '$.remaining.devicesCount') as BenefitsData_remaining_devicesCount
,json_value(orders.BenefitsData, '$.benefitAppliedAmount') as BenefitsData_benefitAppliedAmount
,json_value(orders.BenefitsData, '$.outOfPocket') as BenefitsData_outOfPocket
,json_value(orders.BenefitsData, '$.bencat') as BenefitsData_bencat
,json_value(orders.BenefitsData, '$.technologyLevel') as BenefitsData_technologyLevel
,json_value(orders.BenefitsData, '$.benfortype') as BenefitsData_benfortype
,json_value(orders.BenefitsData, '$.benfreqtype') as BenefitsData_benfreqtype


from orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp )
and DateOrderinitiated > '2020-07-21' and DateOrderinitiated < '2020-08-21'



select
'Orders.orderitems' as TableName
--, *
,ItemCode
,Quantity
,Amount
,Status
,UnitPrice
,ItemData
,json_value(orderItems.ItemData, '$.color') as ItemData_color
,json_value(orderItems.ItemData, '$.batterySize') as ItemData_batterySize
,json_value(orderItems.ItemData, '$.receiverSize') as ItemData_receiverSize
,json_value(orderItems.ItemData, '$.receiverPower') as ItemData_receiverPower
,json_value(orderItems.ItemData, '$.earMold') as ItemData_earMold
,json_value(orderItems.ItemData, '$.serialNbr') as ItemData_serialNbr
,json_value(orderItems.ItemData, '$.quantity') as ItemData_quantity
,json_value(orderItems.ItemData, '$.measuredIn') as ItemData_measuredIn
,json_value(orderItems.ItemData, '$.nationsId') as ItemData_nationsId
,json_value(orderItems.ItemData, '$.catalogName') as ItemData_catalogName
,json_value(orderItems.ItemData, '$.catalogColorCode') as ItemData_catalogColorCode
,json_value(orderItems.ItemData, '$.categories') as ItemData_categories
,json_value(orderItems.ItemData, '$.healthConditions') as ItemData_healthConditions
--Others
,json_value(orderItems.ItemData, '$.sendingImpression') as ItemData_sendingImpression

from Orders.orderItems where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))
and CreateDate > '2020-07-21' and CreateDate < '2020-08-21'

select  * from otc.UserProfiles where NHMemberID = 'NH202002562120'


select
'Orders.orderitems' as TableName
--, *
,a.ItemCode
,a.Quantity
,a.Amount
,a.Status
,a.UnitPrice
from Orders.orderItems a where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))
and CreateDate > '2020-07-21' and CreateDate < '2020-08-21'

select * from catalog.ItemMasterList where ItemCode in (select itemcode from orders.orderitems where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))
and CreateDate > '2020-07-21' and CreateDate < '2020-08-21')

select * from catalog.ItemMasterAttributeValues where ItemCode in (select itemcode from orders.orderitems where orderId in (select orderid from Orders.orders where NHMemberId in (select NHMemberID from #NHMemberIDTemp ))
and CreateDate > '2020-07-21' and CreateDate < '2020-08-21')


select * from orders.orders where nhmemberid = 'NH202106684620'

select Orderid, status, amount, NhmemberID, CreateDate, modifydate from orders.orders where nhmemberid = 'NH202106684620'and orderid  = '200604877'
select * from orders.OrderItemDetails where orderid in (select Orderid from orders.orders where nhmemberid = 'NH202106684620' and orderid  = '200604877')
select * from orders.OrderTransactionDetails where orderid in (select Orderid from orders.orders where nhmemberid = 'NH202106684620' and orderid  = '200604877')
select * from orders.OrderPOs where orderid in (select Orderid from orders.orders where nhmemberid = 'NH202106684620' and orderid = '200604877' )
