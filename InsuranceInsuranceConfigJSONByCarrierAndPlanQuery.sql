-- select distinct InsuranceCarrierID, InsuranceHealthPlanID from insurance.InsuranceConfig where InsuranceCarrierID = 285

--select * from insurance.InsuranceConfig where InsuranceCarrierID = 16
/*
declare @InsuranceCarrierID int = 444
declare @InsuranceHealthPlanID int  = 6939
*/

/*
select distinct
'insert into #InsuranceCarrierID (InsuranceCarrierID) values (' + cast(InsuranceCarrierID as varchar) + ')'
from Insurance.InsuranceConfig

select distinct
'insert into #InsuranceHealthPlanID (InsuranceHealthPlanID) values (' + cast(InsuranceHealthPlanID as varchar)  + ')'
from Insurance.InsuranceConfig

*/
drop table if exists #InsuranceCarrierID
Create table #InsuranceCarrierID
(InsuranceCarrierID int)

insert into #InsuranceCarrierID (InsuranceCarrierID) values (277)

drop table if exists #InsuranceHealthPlanID
Create table #InsuranceHealthPlanID
(InsuranceHealthPlanID int)

--insert into #InsuranceHealthPlanID (InsuranceHealthPlanID) values (3148)

-- CARRIERCONFIG
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
-- CarrierConfig
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[0]'), NULL) as CarrierConfig_BenefitTypes_1
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[1]'), NULL) as CarrierConfig_BenefitTypes_2
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[2]'), NULL) as CarrierConfig_BenefitTypes_3
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[3]'), NULL) as CarrierConfig_BenefitTypes_4
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.programType'), NULL) as CarrierConfig_ProgramType
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'CARRIERCONFIG' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

-- FISBenefits
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.TFN'), NULL) as FISBenefits_TFN
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.CarrierId'), NULL) as FISBenefits_CarrierId
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.PlanId'), NULL) as FISBenefits_PlanId
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.CarrierName'), NULL) as FISBenefits_CarrierName
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.CarrierCode'), NULL) as FISBenefits_CarrierCode
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.Amount'), NULL) as FISBenefits_Amount
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.BenefitStartDate'), NULL) as FISBenefits_BenefitStartDate
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.BenefitEndDate'), NULL) as FISBenefits_BenefitEndDate
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.BenefitOfferType'), NULL) as FISBenefits_BenefitOfferType
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.benefitType'), NULL) as FISBenefits_benefitType
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.BenefitSource'), NULL) as FISBenefits_BenefitSource
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0]'), NULL) as FISBenefits_LocalStores
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Name'), NULL) as FISBenefits_LocalStores_Name
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Address1'), NULL) as FISBenefits_Address1
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Address2'), NULL) as FISBenefits_Address2
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].State'), NULL) as FISBenefits_State
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Phone'), NULL) as FISBenefits_Phone
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Zip'), NULL) as FISBenefits_Zip
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1]'), NULL) as FISBenefits_LocalStores
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Name'), NULL) as FISBenefits_LocalStores_Name
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Address1'), NULL) as FISBenefits_Address1
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Address2'), NULL) as FISBenefits_Address2
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].State'), NULL) as FISBenefits_State
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Phone'), NULL) as FISBenefits_Phone
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Zip'), NULL) as FISBenefits_Zip
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'FISBENEFITS' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

-- MailTrackingInfo
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'MAILTRACKINGINFO', json_value(InsuranceConfig.ConfigData, '$.TrackingFromEmail'), NULL) as MailTrackingInfo_TrackingFromEmail
,IIF(ConfigType = 'MAILTRACKINGINFO', json_value(InsuranceConfig.ConfigData, '$.TrackingMailKey'), NULL) as MailTrackingInfo_TrackingMailKey
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'MAILTRACKINGINFO' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

--MealsContent
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'MEALSCONTENT', json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as MealsContent_hoursOfOperation
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.phone'), NULL)  as MealsContent_phone
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'MEALSCONTENT' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

-- MemberPortalContent
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as MemberPortalContent_hoursOfOperation
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.phone'), NULL) as MemberPortalContent_phone
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.showOTCGuidelines'), NULL) as MemberPortalContent_showOTCGuidelines
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.showManageCardMenu'), NULL) as MemberPortalContent_showManageCardMenu
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.blockCardRequestInDays'), NULL) as MemberPortalContent_blockCardRequestInDays
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'MEMBERPORTALCONTENT' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


--OTCApp
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.alwaysViewCatalog'), NULL) as OTCApp_alwaysViewCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration'), NULL) as OTCApp_benefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration.showBenefitExpiration'), NULL) as OTCApp_benefitExpiration_showBenefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration.expireInDays'), NULL) as OTCApp_benefitExpiration_expireInDays
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.canSubscribe'), NULL) as OTCApp_canSubscribe
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.disablePromotions'), NULL) as OTCApp_disablePromotions
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.expressOrderEnabled'), NULL) as OTCApp_expressOrderEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isHealthProfileDisabled'), NULL) as OTCApp_isHealthProfileDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.offers'), NULL) as OTCApp_offers
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig'), NULL) as OTCApp_fisconfig
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowMyTransactions'), NULL) as OTCApp_allowMyTransactions
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowCheckEligProducts'), NULL) as OTCApp_allowCheckEligProducts
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowStoreLocator'), NULL) as OTCApp_allowStoreLocator
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowRequestCatalog'), NULL) as OTCApp_fisconfig_allowRequestCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest'), NULL) as OTCApp_fisconfig_reimbursementRequest
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.allowReimbursementRequest'), NULL) as OTCApp_fisconfig_reimbursementRequest_allowReimbursementRequest
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.check'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_check
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.card'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_card
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.isSelectionDisabled'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_isSelectionDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideProductEligibility'), NULL) as OTCApp_fisConfig_hideProductEligibility
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideStoreSearch'), NULL) as OTCApp_fisConfig_hideStoreSearch
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.enableFISFeatures'), NULL) as OTCApp_enableFISFeatures
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowMailCatalog'), NULL) as OTCApp_allowMailCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowEMailCatalog'), NULL) as OTCApp_allowEMailCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowSiteTranslation'), NULL) as OTCApp_allowSiteTranslation
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.twoFAConfig.is2FAEnabled'), NULL) as OTCApp_twoFAConfig_is2FAEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isActivateCardDisabledPreLogin'), NULL) as OTCApp_isActivateCardDisabledPreLogin
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.showfeeSummary'), NULL) as OTCApp_showfeeSummary
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowCourtesyOrders'), NULL) as OTCApp_allowCourtesyOrders
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.healthQuestionnaire'), NULL) as OTCApp_healthQuestionnaire
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.showBenefitExpiration'), NULL) as OTCApp_showBenefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Preferences.OrderUpdates.sendSMS'), NULL) as OTCApp_Preferences_OrderUpdates_sendSMS
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Preferences.OrderUpdates.sendEmail'), NULL) as OTCApp_Preferences_OrderUpdates_sendEmail
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isSelfAttestationAllowed'), NULL) as OTCApp_isSelfAttestationAllowed
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isRequestCatalogEnabled'), NULL) as OTCApp_isRequestCatalogEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.dheConfig'), NULL) as OTCApp_dheConfig
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.enableDHEFeatures'), NULL) as OTCApp_enableDHEFeatures
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isExternalUtilizationEnabled'), NULL) as OTCApp_isExternalUtilizationEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.notifyCustomModelPostLogin'), NULL) as OTCApp_notifyCustomModelPostLogin
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isSurveyEnabled'), NULL) as OTCApp_isSurveyEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.hideOTCShopingExperience'), NULL) as OTCApp_hideOTCShopingExperience
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'OTCAPP' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))



--OTCBenefit
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[0].benefitType'), NULL) as OTCBenefit_benefitsTypesForProductElig_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[0].benefitName'), NULL) as OTCBenefit_benefitsTypesForProductElig_benefitName

,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[1].benefitType'), NULL) as OTCBenefit_benefitsTypesForProductElig_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[1].benefitName'), NULL) as OTCBenefit_benefitsTypesForProductElig_benefitName

,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[0].benefitType'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[0].benefitName'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_benefitName

,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[1].benefitType'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[1].benefitName'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_benefitName

,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[0]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_1
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[1]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_2
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[2]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_3
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'OTCBENEFIT' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))



--OTCContent
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.phone'), NULL) as OTCContent_Phone
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cardNumberLoginInfo'), NULL) as OTCContent_cardNumberLoginInfo
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cardNumberLoginFieldLabel'), NULL) as OTCContent_cardNumberLoginFieldLabel
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as OTCContent_hoursOfOperation
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping[0].memberID'), NULL) as OTCContent_contentMapping_memberID
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping[0]."NationsOTC.com"'), NULL) as [OTCContent_contentMapping_NationsOTC.com] -- escape period by including in double quotes

,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.CardImage'), NULL) as OTCContent_CardImage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.logo'), NULL) as OTCContent_logo
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.Catalog'), NULL) as OTCContent_Catalog

,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMessage'), NULL) as OTCContent_loginMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginMessage'), NULL) as OTCContent_postLoginMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel'), NULL) as OTCContent_postLoginModel
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.Modeltitle'), NULL) as OTCContent_postLoginModel_Modeltitle
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.img'), NULL) as OTCContent_postLoginModel_img
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.ModelbodyContent'), NULL) as OTCContent_postLoginModel_ModelbodyContent
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.btntxt'), NULL) as OTCContent_postLoginModel_btntxt
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.isTrackingRequired'), NULL) as OTCContent_postLoginModel_isTrackingRequired
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMsgOnTemplateNote'), NULL) as OTCContent_loginMsgOnTemplateNote


,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.agentTemplateTitle'), NULL) as OTCContent_agentTemplateTitle
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMsgOnTemplate'), NULL) as OTCContent_loginMsgOnTemplate
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.preLoginHoursOfOperation'), NULL) as OTCContent_preLoginHoursOfOperation
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.exceedBenefitConfirmationKey'), NULL) as OTCContent_exceedBenefitConfirmationKey

,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.coveredByKey'), NULL) as OTCContent_coveredByKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartNotCoveredKey'), NULL) as OTCContent_cartNotCoveredKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartCoveredKey'), NULL) as OTCContent_cartCoveredKey

,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.showOTCGuidelines'), NULL) as OTCContent_showOTCGuidelines
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartNotCoveredKey'), NULL) as OTCContent_cartNotCoveredKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartCoveredKey'), NULL) as OTCContent_cartCoveredKey

,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.footerDisclaimer'), NULL) as OTCContent_footerDisclaimer
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'OTCCONTENT' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


--OTCLogin
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.allowAgentAccess'), NULL)  as  OTCLogin_allowAgentAccess
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.isLoginRestricted'), NULL)  as  OTCLogin_isLoginRestricted
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.isRegisterable'), NULL)  as  OTCLogin_isRegisterable
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.loginTemplate'), NULL)  as  OTCLogin_loginTemplate
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets'), NULL)  as  OTCLogin_MapWallets
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.loginTemplate'), NULL)  as  OTCLogin_loginTemplate
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashTemplage'), NULL)  as  OTCLogin_splashTemplage
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfigBackup'), NULL)  as  OTCLogin_splashConfigBackup
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfigBackup.splashTemplate'), NULL)  as  OTCLogin_splashConfigBackup_splashTemplate
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfigBackup.splashTitle'), NULL)  as  OTCLogin_splashConfigBackup_splashTitle
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfigBackup.splashContent'), NULL)  as  OTCLogin_splashConfigBackup_splashContent

,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $150"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$150
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $160"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$160
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $350"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$350
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $210"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$210
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $400"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$400
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $110"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$110
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $230"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$230
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $240"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$240
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $310"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$310
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $185" '), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$185
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $500"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$500
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $250"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$250
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $260"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$260
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $170"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$170
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $100"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$100
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $370"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$370
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $365"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$365
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $200"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$200
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $115"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$115
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $335"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$335
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $470"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$470
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $125"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$125
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $535"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$535
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $475"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$475
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $120"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$120
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $410"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$410
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $125"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$125
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $300"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$300
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $610"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$610
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $110"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$110
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $450"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$450
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $410"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$410
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $375"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$375
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $30"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$30
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $55"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$55
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $82"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$82
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $80"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$80
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $65"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$65
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $40"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$40
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $110"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$110
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $35"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$35
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $32"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$32
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $45"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$45
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $150"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$150
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $50"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$50
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $60"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$60
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $28"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$28
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 Food and Produce $85"'), NULL)  as  OTCLogin_MapWallets_CY23FoodandProduce$85
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $90"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$90
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $90"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$90
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $60"'), NULL)  as  OTCLogin_MapWallets_CY23OTC$60
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC $75"'), NULL) as  OTCLogin_MapWallets_CY23OTC$75

,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Flex 60"'), NULL)  as  OTCLogin_MapWallets_Flex60
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Flex 100"'), NULL)  as  OTCLogin_MapWallets_Flex100
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Flex 300"'), NULL)  as  OTCLogin_MapWallets_Flex300
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Flex 185"'), NULL)  as  OTCLogin_MapWallets_Flex185
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Incentives"'), NULL)  as  OTCLogin_MapWallets_Incentives
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Flex 320"'), NULL)  as  OTCLogin_MapWallets_Flex320
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."Grocery 25"'), NULL)  as  OTCLogin_MapWallets_Grocery25
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.tags'), NULL)  as  OTCLogin_tags
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.loginTemplate2022'), NULL)  as  OTCLogin_loginTemplate2022
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.isManaged'), NULL)  as  OTCLogin_isManaged
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.removeBBB'), NULL)  as  OTCLogin_removeBBB
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.agentLoginType'), NULL)  as  OTCLogin_agentLoginType
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.hideClientLogo'), NULL)  as  OTCLogin_hideClientLogo
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.allowDirectDebit'), NULL)  as  OTCLogin_allowDirectDebit
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets.ProgramManager'), NULL)  as  OTCLogin_ProgramManager
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."01"'), NULL)  as  OTCLogin_MapWallets_01
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."02"'), NULL)  as  OTCLogin_MapWallets_02
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."03"'), NULL)  as  OTCLogin_MapWallets_03
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."04"'), NULL)  as  OTCLogin_MapWallets_04
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."05"'), NULL)  as  OTCLogin_MapWallets_05
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."06"'), NULL)  as  OTCLogin_MapWallets_06
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."07"'), NULL)  as  OTCLogin_MapWallets_07
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."08"'), NULL)  as  OTCLogin_MapWallets_08
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."09"'), NULL)  as  OTCLogin_MapWallets_09
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."10"'), NULL)  as  OTCLogin_MapWallets_10
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."11"'), NULL)  as  OTCLogin_MapWallets_11
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."12"'), NULL)  as  OTCLogin_MapWallets_12
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."13"'), NULL)  as  OTCLogin_MapWallets_13
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."14"'), NULL)  as  OTCLogin_MapWallets_14
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."15"'), NULL)  as  OTCLogin_MapWallets_15
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."16"'), NULL)  as  OTCLogin_MapWallets_16
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."17"'), NULL)  as  OTCLogin_MapWallets_17
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."18"'), NULL)  as  OTCLogin_MapWallets_18
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."19"'), NULL)  as  OTCLogin_MapWallets_19
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."20"'), NULL)  as  OTCLogin_MapWallets_20
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."21"'), NULL)  as  OTCLogin_MapWallets_21
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."22"'), NULL)  as  OTCLogin_MapWallets_22
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."23"'), NULL)  as  OTCLogin_MapWallets_23
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."24"'), NULL)  as  OTCLogin_MapWallets_24
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."25"'), NULL)  as  OTCLogin_MapWallets_25
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."26"'), NULL)  as  OTCLogin_MapWallets_26
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."27"'), NULL)  as  OTCLogin_MapWallets_27
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."28"'), NULL)  as  OTCLogin_MapWallets_28
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."29"'), NULL)  as  OTCLogin_MapWallets_29
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."30"'), NULL)  as  OTCLogin_MapWallets_30
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."31"'), NULL)  as  OTCLogin_MapWallets_31
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."32"'), NULL)  as  OTCLogin_MapWallets_32
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."33"'), NULL)  as  OTCLogin_MapWallets_33
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."34"'), NULL)  as  OTCLogin_MapWallets_34
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."35"'), NULL)  as  OTCLogin_MapWallets_35
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."36"'), NULL)  as  OTCLogin_MapWallets_36
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."37"'), NULL)  as  OTCLogin_MapWallets_37
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."38"'), NULL)  as  OTCLogin_MapWallets_38
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."39"'), NULL)  as  OTCLogin_MapWallets_39
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."40"'), NULL)  as  OTCLogin_MapWallets_40
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."41"'), NULL)  as  OTCLogin_MapWallets_41
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."42"'), NULL)  as  OTCLogin_MapWallets_42
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."43"'), NULL)  as  OTCLogin_MapWallets_43
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."44"'), NULL)  as  OTCLogin_MapWallets_44
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."45"'), NULL)  as  OTCLogin_MapWallets_45
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."46"'), NULL)  as  OTCLogin_MapWallets_46
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."47"'), NULL)  as  OTCLogin_MapWallets_47
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."48"'), NULL)  as  OTCLogin_MapWallets_48
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."49"'), NULL)  as  OTCLogin_MapWallets_49
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."50"'), NULL)  as  OTCLogin_MapWallets_50
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."51"'), NULL)  as  OTCLogin_MapWallets_51
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."52"'), NULL)  as  OTCLogin_MapWallets_52
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."53"'), NULL)  as  OTCLogin_MapWallets_53
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."54"'), NULL)  as  OTCLogin_MapWallets_54
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."55"'), NULL)  as  OTCLogin_MapWallets_55
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."56"'), NULL)  as  OTCLogin_MapWallets_56
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."57"'), NULL)  as  OTCLogin_MapWallets_57
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."58"'), NULL)  as  OTCLogin_MapWallets_58
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."59"'), NULL)  as  OTCLogin_MapWallets_59
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."60"'), NULL)  as  OTCLogin_MapWallets_60
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."61"'), NULL)  as  OTCLogin_MapWallets_61
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."62"'), NULL)  as  OTCLogin_MapWallets_62
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."63"'), NULL)  as  OTCLogin_MapWallets_63
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."64"'), NULL)  as  OTCLogin_MapWallets_64
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."65"'), NULL)  as  OTCLogin_MapWallets_65
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."66"'), NULL)  as  OTCLogin_MapWallets_66
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."67"'), NULL)  as  OTCLogin_MapWallets_67
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."68"'), NULL)  as  OTCLogin_MapWallets_68
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."69"'), NULL)  as  OTCLogin_MapWallets_69
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."70"'), NULL)  as  OTCLogin_MapWallets_70
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."71"'), NULL)  as  OTCLogin_MapWallets_71
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."72"'), NULL)  as  OTCLogin_MapWallets_72
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."73"'), NULL)  as  OTCLogin_MapWallets_73
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."74"'), NULL)  as  OTCLogin_MapWallets_74
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."75"'), NULL)  as  OTCLogin_MapWallets_75
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."76"'), NULL)  as  OTCLogin_MapWallets_76
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."77"'), NULL)  as  OTCLogin_MapWallets_77
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."78"'), NULL)  as  OTCLogin_MapWallets_78
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."79"'), NULL)  as  OTCLogin_MapWallets_79
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."80"'), NULL)  as  OTCLogin_MapWallets_80
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."81"'), NULL)  as  OTCLogin_MapWallets_81
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."82"'), NULL)  as  OTCLogin_MapWallets_82
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."83"'), NULL)  as  OTCLogin_MapWallets_83
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."84"'), NULL)  as  OTCLogin_MapWallets_84
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."85"'), NULL)  as  OTCLogin_MapWallets_85
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."86"'), NULL)  as  OTCLogin_MapWallets_86
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."87"'), NULL)  as  OTCLogin_MapWallets_87
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."88"'), NULL)  as  OTCLogin_MapWallets_88
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."89"'), NULL)  as  OTCLogin_MapWallets_89
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."90"'), NULL)  as  OTCLogin_MapWallets_90
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."91"'), NULL)  as  OTCLogin_MapWallets_91
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."92"'), NULL)  as  OTCLogin_MapWallets_92
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."93"'), NULL)  as  OTCLogin_MapWallets_93
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."94"'), NULL)  as  OTCLogin_MapWallets_94
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."95"'), NULL)  as  OTCLogin_MapWallets_95
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."96"'), NULL)  as  OTCLogin_MapWallets_96
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."97"'), NULL)  as  OTCLogin_MapWallets_97
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."98"'), NULL)  as  OTCLogin_MapWallets_98
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."99"'), NULL)  as  OTCLogin_MapWallets_99
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."100"'), NULL)  as  OTCLogin_MapWallets_100

from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'OTCLOGIN' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


--OTCRewards
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.isRewardAllowed'), NULL)  as  OTCRewards_isRewardAllowed
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].rewardCode'), NULL)  as  OTCRewards_rewardData_RewardCode
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[0]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_0
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[1]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_1
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[2]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_2
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[3]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_3
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].source'), NULL)  as  OTCRewards_rewardData_0_Source
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].displayName'), NULL)  as  OTCRewards_rewardData_DisplayName

,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].rewardCode'), NULL)  as  OTCRewards_rewardData_RewardCode
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[0]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_0
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[1]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_1
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[2]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_2
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[3]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_3
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].source'), NULL)  as  OTCRewards_rewardData_1_Source
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].displayName'), NULL)  as  OTCRewards_rewardData_DisplayName
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.isRewardRestrictedForApple'), NULL)  as  OTCRewards_isRewardRestrictedForApple
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'OTCREWARDS' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


 
--CardType
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].cardType'), NULL)  as  CardType_CardType
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].Template'), NULL)  as  CardType_Template
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].cardType'), NULL)  as  CardType_CardType
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets'), NULL)  as  CardType_CatalogAccessWallets
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets.WalletCode'), NULL)  as  CardType_CatalogAccessWallets_WalletCode
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets.HAUPCCode'), NULL)  as  CardType_CatalogAccessWallets_HAUPCCode
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'CARDTYPE' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

--Claim
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.IsClaimRequired'),NULL) as Claim_IsClaimRequired
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.NobleInsuranceID'),NULL) as Claim_NobleInsuranceID
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.GroupAllServicesBy'),NULL) as Claim_GroupAllServicesBy
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.IncludeBeneftsAppliedInClaim'),NULL) as Claim_IncludeBeneftsAppliedInClaim
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.DefaultClaimAmount'),NULL) as Claim_DefaultClaimAmount
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.UseNationsAsBillingProvider'),NULL) as Claim_UseNationsAsBillingProvider
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.UseNationsAsRenderingProvider'),NULL) as Claim_UseNationsAsRenderingProvider
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.IsZeroClaim'),NULL) as Claim_IsZeroClaim
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.IsEncounter'),NULL) as Claim_IsEncounter
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.SubmissionThroughClearingHouse'),NULL) as Claim_SubmissionThroughClearingHouse
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.NeedPGPEncryption'),NULL) as Claim_NeedPGPEncryption
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.ClaimDueDays'),NULL) as Claim_ClaimDueDays
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.PlaceofService'),NULL) as Claim_PlaceofService
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.ApplyCoPay'),NULL) as Claim_ApplyCoPay
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.CopyPrimaryAsSecondaryInsu'),NULL) as Claim_CopyPrimaryAsSecondaryInsu
,IIF(ConfigType = 'CLAIM', json_value(InsuranceConfig.ConfigData, '$.IsClaimToNoble'),NULL) as Claim_IsClaimToNoble
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'CLAIM' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


--DHELOGIN
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig'),NULL) as DHELOGIN_splashConfig
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTemplate'),NULL) as DHELOGIN_splashConfig_splashTemplate
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTitle'),NULL) as DHELOGIN_splashConfig_splashTitle
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashContent'),NULL) as DHELOGIN_splashConfig_splashContent
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'DHELOGIN' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))


--FISCONFIGURATION
select IsActive,InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData 
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.CarrierPlanlogourl'),NULL) as FISCONFIGURATION_CarrierPlanlogourl
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.ClientID'),NULL) as FISCONFIGURATION_ClientID
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.SubProgID'),NULL) as FISCONFIGURATION_SubProgID
from insurance.InsuranceConfig 
where 1=1 and
ConfigType = 'FISCONFIGURATION' and
(isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) or isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

