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

insert into #InsuranceHealthPlanID (InsuranceHealthPlanID) values (2509)

drop table if exists #InsuranceConfig
select * into #InsuranceConfig from (
-- CARRIERCONFIG
select IsActive, InsuranceCarrierID, isNull(InsuranceHealthPlanID, 999) as InsuranceHealthPlanID, ConfigType, ConfigData 
-- CarrierConfig

,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.isCopayVerbiageInHeader'), NULL) as CarrierConfig_IsCopayVerbiageInHeader
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.allowAddMember'), NULL) as CarrierConfig_AllowAddMember
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.allowAddMemberUserGroups'), NULL) as CarrierConfig_allowAddMemberUserGroups
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[0]'), NULL) as CarrierConfig_BenefitTypes_1
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[1]'), NULL) as CarrierConfig_BenefitTypes_2
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[2]'), NULL) as CarrierConfig_BenefitTypes_3
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[3]'), NULL) as CarrierConfig_BenefitTypes_4
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[4]'), NULL) as CarrierConfig_BenefitTypes_5
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[5]'), NULL) as CarrierConfig_BenefitTypes_6
,IIF(ConfigType = 'CARRIERCONFIG', json_value(InsuranceConfig.ConfigData, '$.programType'), NULL) as CarrierConfig_ProgramType

-- FISBenefits
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
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0]'), NULL) as FISBenefits_LocalStores_0
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Name'), NULL) as FISBenefits_LocalStores_0_Name
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Address1'), NULL) as FISBenefits_LocalStores_0_Address1
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Address2'), NULL) as FISBenefits_LocalStores_0_Address2
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].State'), NULL) as FISBenefits_LocalStores_0_State
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Phone'), NULL) as FISBenefits_LocalStores_0_Phone
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[0].Zip'), NULL) as FISBenefits_LocalStores_0_Zip
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1]'), NULL) as FISBenefits_LocalStores_1
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Name'), NULL) as FISBenefits_LocalStores_1_Name
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Address1'), NULL) as FISBenefits_LocalStores_1_Address1
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Address2'), NULL) as FISBenefits_LocalStores_1_Address2
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].State'), NULL) as FISBenefits_LocalStores_1_State
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Phone'), NULL) as FISBenefits_LocalStores_1_Phone
,IIF(ConfigType = 'FISBENEFITS',json_value(InsuranceConfig.ConfigData, '$.LocalStores[1].Zip'), NULL) as FISBenefits_LocalStores_1_Zip

-- MailTrackingInfo
,IIF(ConfigType = 'MAILTRACKINGINFO', json_value(InsuranceConfig.ConfigData, '$.TrackingFromEmail'), NULL) as MailTrackingInfo_TrackingFromEmail
,IIF(ConfigType = 'MAILTRACKINGINFO', json_value(InsuranceConfig.ConfigData, '$.TrackingMailKey'), NULL) as MailTrackingInfo_TrackingMailKey

--MealsContent
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as MealsContent_hoursOfOperation
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.civilRightsDisclaimer'), NULL)  as MealsContent_civilRightsDisclaimer
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.phone'), NULL)  as MealsContent_phone
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes[0]'), NULL)  as MealsContent_mealBundleTypes
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes[0].bundleName'), NULL)  as MealsContent_mealBundleTypes_bundleName
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.mealBundleTypes[0].bundleValue'), NULL)  as MealsContent_mealBundleTypes_bundleValue
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.maxMealCount'), NULL)  as MealsContent_maxMealCount
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.mealsPerDay'), NULL)  as MealsContent_mealsPerDay
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.maxLimitPerYear'), NULL)  as MealsContent_maxLimitPerYear
,IIF(ConfigType = 'MEALSCONTENT',json_value(InsuranceConfig.ConfigData, '$.enableFISFeatures'), NULL)  as MealsContent_enableFISFeatures


-- MemberPortalContent
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as MemberPortalContent_hoursOfOperation
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.phone'), NULL) as MemberPortalContent_phone
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.showOTCGuidelines'), NULL) as MemberPortalContent_showOTCGuidelines
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.showManageCardMenu'), NULL) as MemberPortalContent_showManageCardMenu
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.blockCardRequestInDays'), NULL) as MemberPortalContent_blockCardRequestInDays
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.civilRightsDisclaimer'), NULL) as MemberPortalContent_civilRightsDisclaimer
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.splashConfig'), NULL) as MemberPortalContent_splashConfig
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTemplate'), NULL) as MemberPortalContent_splashConfig_splashTemplate
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTitle'), NULL) as MemberPortalContent_splashConfig_splashTitle
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashContent'), NULL) as MemberPortalContent_splashConfig_splashContent
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.expiryMsgTimePeriodInMonths'), NULL) as MemberPortalContent_expiryMsgTimePeriodInMonths
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.displayBenefitNotice'), NULL) as MemberPortalContent_displayBenefitNotice
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.displayReceiptAlert'), NULL) as MemberPortalContent_displayReceiptAlert
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.isRewardTermsRequired'), NULL) as MemberPortalContent_isRewardTermsRequired
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.rewardCDNLink'), NULL) as MemberPortalContent_rewardCDNLink
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.copyChanges'), NULL) as MemberPortalContent_copyChanges
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.copyChanges[0].memberId'), NULL) as MemberPortalContent_copyChanges_memberId
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.copyChanges[0].memberIdRequired'), NULL) as MemberPortalContent_copyChanges_memberIdRequired
,IIF(ConfigType = 'MEMBERPORTALCONTENT', json_value(InsuranceConfig.ConfigData, '$.copyChanges[0].enterMemberInfoMsg'), NULL) as MemberPortalContent_copyChanges_enterMemberInfoMsg

--OTCApp
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.alwaysViewCatalog'), NULL) as OTCApp_alwaysViewCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowAgentCardActivation'), NULL) as OTCApp_allowAgentCardActivation
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowCheckEligProducts'), NULL) as OTCApp_allowCheckEligProducts
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowCourtesyOrders'), NULL) as OTCApp_allowCourtesyOrders
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowDownloadCatalog'), NULL) as OTCApp_allowDownloadCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowEMailCatalog'), NULL) as OTCApp_allowEMailCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowMailCatalog'), NULL) as OTCApp_allowMailCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowMyTransactions'), NULL) as OTCApp_allowMyTransactions
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowReimbursementRequest'), NULL) as OTCApp_allowReimbursementRequest
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowRequestCatalog'), NULL) as OTCApp_allowRequestCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowSiteTranslation'), NULL) as OTCApp_allowSiteTranslation
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.allowStoreLocator'), NULL) as OTCApp_allowStoreLocator
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration'), NULL) as OTCApp_benefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration.expireInDays'), NULL) as OTCApp_benefitExpiration_expireInDays
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitExpiration.showBenefitExpiration'), NULL) as OTCApp_benefitExpiration_showBenefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.canIgnoreHealthQuestionnaire'), NULL) as OTCApp_canIgnoreHealthQuestionnaire
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.canSubscribe'), NULL) as OTCApp_canSubscribe
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.card'), NULL) as OTCApp_card
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.check'), NULL) as OTCApp_check
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.dheConfig'), NULL) as OTCApp_dheConfig
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.disablePromotions'), NULL) as OTCApp_disablePromotions
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.displayFAQ'), NULL) as OTCApp_displayFAQ
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.enableDHEFeatures'), NULL) as OTCApp_enableDHEFeatures
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.enableFISFeatures'), NULL) as OTCApp_enableFISFeatures
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.expireInDays'), NULL) as OTCApp_expireInDays
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.expressOrderEnabled'), NULL) as OTCApp_expressOrderEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.expressOrdersDisabled'), NULL) as OTCApp_expressOrdersDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig'), NULL) as OTCApp_fisconfig
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowCheckEligProducts'), NULL) as OTCApp_fisConfig_allowCheckEligProducts
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowMyTransactions'), NULL) as OTCApp_fisConfig_allowMyTransactions
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowRequestCatalog'), NULL) as OTCApp_fisconfig_allowRequestCatalog
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.allowStoreLocator'), NULL) as OTCApp_fisConfig_allowStoreLocator
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideProductEligibility'), NULL) as OTCApp_fisConfig_hideProductEligibility
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideStoreSearch'), NULL) as OTCApp_fisConfig_hideStoreSearch
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest'), NULL) as OTCApp_fisconfig_reimbursementRequest
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.allowReimbursementRequest'), NULL) as OTCApp_fisconfig_reimbursementRequest_allowReimbursementRequest
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.card'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_card
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.check'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_check
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.reimbursementRequest.paymentModes.isSelectionDisabled'), NULL) as OTCApp_fisConfig_reimbursementRequest_paymentModes_isSelectionDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.flexCardImagePathSuffix'), NULL) as OTCApp_flexCardImagePathSuffix
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Funded'), NULL) as OTCApp_Funded
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.hcqDetails'), NULL) as OTCApp_hcqDetails
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.healthQuestionnaire'), NULL) as OTCApp_healthQuestionnaire
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.hideBenefitTracker'), NULL) as OTCApp_hideBenefitTracker
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.hideOTCShopingExperience'), NULL) as OTCApp_hideOTCShopingExperience
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideProductEligibility'), NULL) as OTCApp_hideProductEligibility
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.fisConfig.hideStoreSearch'), NULL) as OTCApp_hideStoreSearch
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.is2FAEnabled'), NULL) as OTCApp_is2FAEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isActivateCardDisabledPostLogin'), NULL) as OTCApp_isActivateCardDisabledPostLogin
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isActivateCardDisabledPreLogin'), NULL) as OTCApp_isActivateCardDisabledPreLogin
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isDefaultDiscountApplied'), NULL) as OTCApp_isDefaultDiscountApplied
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isDisplayMyBenefitsDisabled'), NULL) as OTCApp_isDisplayMyBenefitsDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isExpressOrderDisabledForMEA'), NULL) as OTCApp_isExpressOrderDisabledForMEA
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isExternalUtilizationEnabled'), NULL) as OTCApp_isExternalUtilizationEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isHealthProfileDisabled'), NULL) as OTCApp_isHealthProfileDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isLanguageSelectionEnabled'), NULL) as OTCApp_isLanguageSelectionEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isMemberIdRequiredForCardActivation'), NULL) as OTCApp_isMemberIdRequiredForCardActivation
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isRefundsDisabled'), NULL) as OTCApp_isRefundsDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isRequestCatalogEnabled'), NULL) as OTCApp_isRequestCatalogEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isRetailOnlyBenefit'), NULL) as OTCApp_isRetailOnlyBenefit
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isSelectionDisabled'), NULL) as OTCApp_isSelectionDisabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isSelfAttestationAllowed'), NULL) as OTCApp_isSelfAttestationAllowed
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isSurveyEnabled'), NULL) as OTCApp_isSurveyEnabled
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.isTemplateEnable'), NULL) as OTCApp_isTemplateEnable
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.notifyCustomModelPostLogin'), NULL) as OTCApp_notifyCustomModelPostLogin
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.offers'), NULL) as OTCApp_offers
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.offers.templateName'), NULL) as OTCApp_offers_templateName
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.offers.title'), NULL) as OTCApp_offers_title
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.offers.isTemplateEnable'), NULL) as OTCApp_offers_isTemplateEnable
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[0]'), NULL) as OTCApp_benefitTypes_0
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.benefitTypes[1]'), NULL) as OTCApp_benefitTypes_1
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.paymentModes'), NULL) as OTCApp_paymentModes
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.planCode'), NULL) as OTCApp_planCode
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Preferences'), NULL) as OTCApp_Preferences
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Preferences.OrderUpdates.sendEmail'), NULL) as OTCApp_Preferences_OrderUpdates_sendEmail
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.Preferences.OrderUpdates.sendSMS'), NULL) as OTCApp_Preferences_OrderUpdates_sendSMS
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.programType'), NULL) as OTCApp_programType
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.showBenefitExpiration'), NULL) as OTCApp_showBenefitExpiration
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.showfeeSummary'), NULL) as OTCApp_showfeeSummary
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.twoFAConfig'), NULL) as OTCApp_twoFAConfig
,IIF(ConfigType = 'OTCAPP', json_value(InsuranceConfig.ConfigData, '$.twoFAConfig.is2FAEnabled'), NULL) as OTCApp_twoFAConfig_is2FAEnabled


--OTCBenefit
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.multiplePlans'), NULL) as OTCBenefit_multiplePlans
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.multiplePlans.considerSingleBenefit'), NULL) as OTCBenefit_multiplePlans_considerSingleBenefit
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.multiplePlans.walletToCheckFor'), NULL) as OTCBenefit_multiplePlans_walletToCheckFor
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.getAllWexPlans'), NULL) as OTCBenefit_getAllWexPlans
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.CombineBalances[0].SG0222[0]'), NULL) as OTCBenefit_CombineBalances_SG0222
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.CombineBalances[0].SM0122[0]'), NULL) as OTCBenefit_CombineBalances_SM0122_0
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.CombineBalances[0].SM0122[1]'), NULL) as OTCBenefit_CombineBalances_SM0122_1
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.CombineBalances[0].ML01WEX22[0]'), NULL) as OTCBenefit_CombineBalances_ML01WEX22
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[0].benefitType'), NULL) as OTCBenefit_benefitsTypesForProductElig_0_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[0].benefitName'), NULL) as OTCBenefit_benefitsTypesForProductElig_0_benefitName
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[1].benefitType'), NULL) as OTCBenefit_benefitsTypesForProductElig_1_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForProductElig[1].benefitName'), NULL) as OTCBenefit_benefitsTypesForProductElig_1_benefitName
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[0].benefitType'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_0_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[0].benefitName'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_0_benefitName
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[1].benefitType'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_1_benefitType
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.benefitsTypesForStoreLocator[1].benefitName'), NULL) as OTCBenefit_benefitsTypesForStoreLocator_1_benefitName
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[0]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_1
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[1]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_2
,IIF(ConfigType = 'OTCBENEFIT', json_value(InsuranceConfig.ConfigData, '$.restrictedCardStatusForBenefitUtilization[2]'), NULL) as OTCBenefit_restrictedCardStatusForBenefitUtilization_3


--OTCContent
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.accessSupplementalBenefitsOn'), NULL) as OTCContent_accessSupplementalBenefitsOn
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.additionalBenefitTitle'), NULL) as OTCContent_additionalBenefitTitle
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.agentTemplateTitle'), NULL) as OTCContent_agentTemplateTitle
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.allowDeliveryDays'), NULL) as OTCContent_allowDeliveryDays
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.appleTrademark'), NULL) as OTCContent_appleTrademark
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cardNumberLoginFieldLabel'), NULL) as OTCContent_cardNumberLoginFieldLabel
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cardNumberLoginInfo'), NULL) as OTCContent_cardNumberLoginInfo
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartCoveredKey'), NULL) as OTCContent_cartCoveredKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.cartNotCoveredKey'), NULL) as OTCContent_cartNotCoveredKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.civilRightsDisclaimer'), NULL) as OTCContent_civilRightsDisclaimer
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping'), NULL) as OTCContent_contentMapping
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.coveredByKey'), NULL) as OTCContent_coveredByKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.customHeroBannerHeading'), NULL) as OTCContent_customHeroBannerHeading
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.dhePhone'), NULL) as OTCContent_dhePhone
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.disclaimers.onPageCustomDisclaimer'), NULL) as OTCContent_disclaimers_onPageCustomDisclaimer
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.exceedBenefitConfirmationKey'), NULL) as OTCContent_exceedBenefitConfirmationKey
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.footerDisclaimer'), NULL) as OTCContent_footerDisclaimer
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.GASupport'), NULL) as OTCContent_GASupport
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.hoursOfOperation'), NULL) as OTCContent_hoursOfOperation
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMessage'), NULL) as OTCContent_loginMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMsgOnTemplate'), NULL) as OTCContent_loginMsgOnTemplate
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginWithMemberId'), NULL) as OTCContent_loginWithMemberId
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping[0].memberID'), NULL) as OTCContent_memberID
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping[0].memberIDApiError'), NULL) as OTCContent_memberIDApiError
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.contentMapping[0].memberIDInfo'), NULL) as OTCContent_memberIDInfo
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.memberIdLoginInfo'), NULL) as OTCContent_memberIdLoginInfo
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.orderDisclaimer'), NULL) as OTCContent_orderDisclaimer
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.phone'), NULL) as OTCContent_phone
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.PortalHeaderDescMessage'), NULL) as OTCContent_PortalHeaderDescMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginMessage'), NULL) as OTCContent_postLoginMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel'), NULL) as OTCContent_postLoginModel
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.Modeltitle'), NULL) as OTCContent_postLoginModel_Modeltitle
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.img'), NULL) as OTCContent_postLoginModel_img
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.ModelBodyContent'), NULL) as OTCContent_postLoginModel_ModelBodyContent
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.postLoginModel.btntxt'), NULL) as OTCContent_postLoginModel_btntxt
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.preLoginHoursOfOperation'), NULL) as OTCContent_preLoginHoursOfOperation
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.preloginPortalHeaderDescMessage'), NULL) as OTCContent_preloginPortalHeaderDescMessage
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.showOTCGuidelines'), NULL) as OTCContent_showOTCGuidelines
,IIF(ConfigType = 'OTCCONTENT', json_value(InsuranceConfig.ConfigData, '$.loginMsgOnTemplateNote'), NULL) as OTCContent_loginMsgOnTemplateNote



--OTCLogin -- check again
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.allowAgentAccess'), NULL)  as  OTCLogin_allowAgentAccess
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.isLoginRestricted'), NULL)  as  OTCLogin_isLoginRestricted
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.isRegisterable'), NULL)  as  OTCLogin_isRegisterable
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.loginTemplate'), NULL)  as  OTCLogin_loginTemplate
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets'), NULL)  as  OTCLogin_MapWallets
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.splashTemplate'), NULL)  as  OTCLogin_splashTemplate
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
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.MapWallets."CY23 OTC Transportation $185"'), NULL)  as  OTCLogin_MapWallets_CY23OTCTransportation$185
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
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.removeBBB'), NULL)  as  OTCLogin_removeBBB
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.agentLoginType'), NULL)  as  OTCLogin_agentLoginType
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.hideClientLogo'), NULL)  as  OTCLogin_hideClientLogo
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.allowDirectDebit'), NULL)  as  OTCLogin_allowDirectDebit
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.ProgramManager'), NULL)  as  OTCLogin_ProgramManager
,IIF(ConfigType = 'OTCLOGIN', json_value(InsuranceConfig.ConfigData, '$.displayClientCustomBranding'), NULL)  as  OTCLogin_displayClientCustomBranding
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

--OTCRewards
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.isRewardAllowed'), NULL)  as  OTCRewards_isRewardAllowed
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].rewardCode'), NULL)  as  OTCRewards_rewardData_0_RewardCode
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[0]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_0
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[1]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_1
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[2]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_2
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].walletMapping[3]'), NULL)  as  OTCRewards_rewardData_0_WalletMapping_3
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].source'), NULL)  as  OTCRewards_rewardData_0_Source
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[0].displayName'), NULL)  as  OTCRewards_rewardData_0_DisplayName
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].rewardCode'), NULL)  as  OTCRewards_rewardData_1_RewardCode
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[0]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_0
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[1]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_1
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[2]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_2
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].walletMapping[3]'), NULL)  as  OTCRewards_rewardData_1_WalletMapping_3
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].source'), NULL)  as  OTCRewards_rewardData_1_Source
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.rewardData[1].displayName'), NULL)  as  OTCRewards_rewardData_1_DisplayName
,IIF(ConfigType = 'OTCREWARDS', json_value(InsuranceConfig.ConfigData, '$.isRewardRestrictedForApple'), NULL)  as  OTCRewards_isRewardRestrictedForApple

 
--CardType
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].cardType'), NULL)  as  CardType_CardType
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].Template'), NULL)  as  CardType_Template
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets'), NULL)  as  CardType_CatalogAccessWallets
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets.WalletCode'), NULL)  as  CardType_CatalogAccessWallets_WalletCode
,IIF(ConfigType = 'CARDTYPE', json_value(InsuranceConfig.ConfigData, '$[0].CatalogAccessWallets.HAUPCCode'), NULL)  as  CardType_CatalogAccessWallets_HAUPCCode

--Claim
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

--DHELOGIN
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig'),NULL) as DHELOGIN_splashConfig
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTemplate'),NULL) as DHELOGIN_splashConfig_splashTemplate
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashTitle'),NULL) as DHELOGIN_splashConfig_splashTitle
,IIF(ConfigType = 'DHELOGIN', json_value(InsuranceConfig.ConfigData, '$.splashConfig.splashContent'),NULL) as DHELOGIN_splashConfig_splashContent

--FISCONFIGURATION
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.CarrierPlanlogourl'),NULL) as FISCONFIGURATION_CarrierPlanlogourl
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.ClientID'),NULL) as FISCONFIGURATION_ClientID
,IIF(ConfigType = 'FISCONFIGURATION', json_value(InsuranceConfig.ConfigData, '$.SubProgID'),NULL) as FISCONFIGURATION_SubProgID
from insurance.InsuranceConfig 
-- where (isnull(InsuranceCarrierID,1) in (select isnull(InsuranceCarrierID,1) from  #InsuranceCarrierID ) and isnull(InsuranceHealthPlanId,1) in (select isnull(InsuranceHealthPlanId,1) from  #InsuranceHealthPlanId ))

) a

/*
SELECT  QUOTENAME([name]) + ',' as ColumnName,
        TYPE_NAME(user_type_id) as DataTypeName, * 
FROM tempdb.sys.columns 
WHERE OBJECT_ID = OBJECT_ID('tempdb..#InsuranceConfig');
*/

/*
select
'select * from (' +
'select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, ' +
+''''+ name +  +''''+ ' as COLUMN_NAME,' +
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ name+']' + ' as nvarchar(max)))),' + '''"'''+') as VALUE from ' 
+ ' #InsuranceConfig ' + ') a union'
from tempdb.sys.columns
where OBJECT_ID = OBJECT_ID('tempdb..#InsuranceConfig');
*/


drop table if exists #InsuranceConfigValues
select * into #InsuranceConfigValues from (
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'IsActive' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([IsActive] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'InsuranceCarrierID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceCarrierID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'InsuranceHealthPlanID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([InsuranceHealthPlanID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'ConfigType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'ConfigData' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([ConfigData] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_IsCopayVerbiageInHeader' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_IsCopayVerbiageInHeader] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_AllowAddMember' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_AllowAddMember] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_allowAddMemberUserGroups' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_allowAddMemberUserGroups] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_3] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_4' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_4] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_5' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_5] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_BenefitTypes_6' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes_6] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CarrierConfig_ProgramType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_ProgramType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_TFN' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_TFN] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_CarrierId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_CarrierId] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_PlanId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_PlanId] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_CarrierName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_CarrierName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_CarrierCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_CarrierCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_Amount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_Amount] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_BenefitStartDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_BenefitStartDate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_BenefitEndDate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_BenefitEndDate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_BenefitOfferType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_BenefitOfferType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_benefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_benefitType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_BenefitSource' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_BenefitSource] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_Name] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_Address1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_Address2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_Address2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_State] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_Phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_Phone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_0_Zip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_0_Zip] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_Name' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_Name] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_Address1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_Address1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_Address2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_Address2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_State' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_State] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_Phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_Phone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISBenefits_LocalStores_1_Zip' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISBenefits_LocalStores_1_Zip] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MailTrackingInfo_TrackingFromEmail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailTrackingInfo_TrackingFromEmail] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MailTrackingInfo_TrackingMailKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MailTrackingInfo_TrackingMailKey] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_hoursOfOperation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_hoursOfOperation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_civilRightsDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_civilRightsDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_phone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_mealBundleTypes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_mealBundleTypes] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_mealBundleTypes_bundleName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_mealBundleTypes_bundleName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_mealBundleTypes_bundleValue' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_mealBundleTypes_bundleValue] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_maxMealCount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_maxMealCount] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_mealsPerDay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_mealsPerDay] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_maxLimitPerYear' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_maxLimitPerYear] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MealsContent_enableFISFeatures' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MealsContent_enableFISFeatures] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_hoursOfOperation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_hoursOfOperation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_phone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_showOTCGuidelines' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_showOTCGuidelines] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_showManageCardMenu' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_showManageCardMenu] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_blockCardRequestInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_blockCardRequestInDays] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_civilRightsDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_civilRightsDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_splashConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_splashConfig] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_splashConfig_splashTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_splashConfig_splashTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_splashConfig_splashTitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_splashConfig_splashTitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_splashConfig_splashContent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_splashConfig_splashContent] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_expiryMsgTimePeriodInMonths' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_expiryMsgTimePeriodInMonths] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_displayBenefitNotice' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_displayBenefitNotice] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_displayReceiptAlert' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_displayReceiptAlert] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_isRewardTermsRequired' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_isRewardTermsRequired] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_rewardCDNLink' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_rewardCDNLink] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_copyChanges' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_copyChanges] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_copyChanges_memberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_copyChanges_memberId] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_copyChanges_memberIdRequired' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_copyChanges_memberIdRequired] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'MemberPortalContent_copyChanges_enterMemberInfoMsg' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([MemberPortalContent_copyChanges_enterMemberInfoMsg] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_alwaysViewCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_alwaysViewCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowAgentCardActivation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowAgentCardActivation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowCheckEligProducts' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowCheckEligProducts] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowCourtesyOrders' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowCourtesyOrders] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowDownloadCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowDownloadCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowEMailCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowEMailCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowMailCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowMailCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowMyTransactions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowMyTransactions] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowReimbursementRequest' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowReimbursementRequest] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowRequestCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowRequestCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowSiteTranslation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowSiteTranslation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_allowStoreLocator' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_allowStoreLocator] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_benefitExpiration' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_benefitExpiration] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_benefitExpiration_expireInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_benefitExpiration_expireInDays] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_benefitExpiration_showBenefitExpiration' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_benefitExpiration_showBenefitExpiration] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_canIgnoreHealthQuestionnaire' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_canIgnoreHealthQuestionnaire] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_canSubscribe' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_canSubscribe] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_card' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_card] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_check' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_check] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_dheConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_dheConfig] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_disablePromotions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_disablePromotions] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_displayFAQ' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_displayFAQ] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_enableDHEFeatures' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_enableDHEFeatures] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_enableFISFeatures' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_enableFISFeatures] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_expireInDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_expireInDays] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_expressOrderEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_expressOrderEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_expressOrdersDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_expressOrdersDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisconfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisconfig] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_allowCheckEligProducts' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_allowCheckEligProducts] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_allowMyTransactions' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_allowMyTransactions] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisconfig_allowRequestCatalog' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisconfig_allowRequestCatalog] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_allowStoreLocator' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_allowStoreLocator] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_hideProductEligibility' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_hideProductEligibility] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_hideStoreSearch' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_hideStoreSearch] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisconfig_reimbursementRequest' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisconfig_reimbursementRequest] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisconfig_reimbursementRequest_allowReimbursementRequest' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisconfig_reimbursementRequest_allowReimbursementRequest] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_reimbursementRequest_paymentModes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_reimbursementRequest_paymentModes] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_reimbursementRequest_paymentModes_card' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_reimbursementRequest_paymentModes_card] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_reimbursementRequest_paymentModes_check' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_reimbursementRequest_paymentModes_check] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_fisConfig_reimbursementRequest_paymentModes_isSelectionDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_fisConfig_reimbursementRequest_paymentModes_isSelectionDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_flexCardImagePathSuffix' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_flexCardImagePathSuffix] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_Funded' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_Funded] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_hcqDetails' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_hcqDetails] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_healthQuestionnaire' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_healthQuestionnaire] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_hideBenefitTracker' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_hideBenefitTracker] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_hideOTCShopingExperience' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_hideOTCShopingExperience] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_hideProductEligibility' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_hideProductEligibility] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_hideStoreSearch' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_hideStoreSearch] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_is2FAEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_is2FAEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isActivateCardDisabledPostLogin' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isActivateCardDisabledPostLogin] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isActivateCardDisabledPreLogin' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isActivateCardDisabledPreLogin] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isDefaultDiscountApplied' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isDefaultDiscountApplied] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isDisplayMyBenefitsDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isDisplayMyBenefitsDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isExpressOrderDisabledForMEA' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isExpressOrderDisabledForMEA] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isExternalUtilizationEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isExternalUtilizationEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isHealthProfileDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isHealthProfileDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isLanguageSelectionEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isLanguageSelectionEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isMemberIdRequiredForCardActivation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isMemberIdRequiredForCardActivation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isRefundsDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isRefundsDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isRequestCatalogEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isRequestCatalogEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isRetailOnlyBenefit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isRetailOnlyBenefit] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isSelectionDisabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isSelectionDisabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isSelfAttestationAllowed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isSelfAttestationAllowed] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isSurveyEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isSurveyEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_isTemplateEnable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_isTemplateEnable] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_notifyCustomModelPostLogin' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_notifyCustomModelPostLogin] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_offers' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_offers] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_offers_templateName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_offers_templateName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_offers_title' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_offers_title] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_offers_isTemplateEnable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_offers_isTemplateEnable] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_benefitTypes_0' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_benefitTypes_0] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_benefitTypes_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_benefitTypes_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_paymentModes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_paymentModes] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_planCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_planCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_Preferences' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_Preferences] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_Preferences_OrderUpdates_sendEmail' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_Preferences_OrderUpdates_sendEmail] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_Preferences_OrderUpdates_sendSMS' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_Preferences_OrderUpdates_sendSMS] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_programType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_programType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_showBenefitExpiration' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_showBenefitExpiration] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_showfeeSummary' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_showfeeSummary] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_twoFAConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_twoFAConfig] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCApp_twoFAConfig_is2FAEnabled' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCApp_twoFAConfig_is2FAEnabled] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_multiplePlans' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_multiplePlans] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_multiplePlans_considerSingleBenefit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_multiplePlans_considerSingleBenefit] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_multiplePlans_walletToCheckFor' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_multiplePlans_walletToCheckFor] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_getAllWexPlans' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_getAllWexPlans] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_CombineBalances_SG0222' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_CombineBalances_SG0222] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_CombineBalances_SM0122_0' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_CombineBalances_SM0122_0] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_CombineBalances_SM0122_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_CombineBalances_SM0122_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_CombineBalances_ML01WEX22' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_CombineBalances_ML01WEX22] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForProductElig_0_benefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForProductElig_0_benefitType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForProductElig_0_benefitName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForProductElig_0_benefitName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForProductElig_1_benefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForProductElig_1_benefitType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForProductElig_1_benefitName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForProductElig_1_benefitName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForStoreLocator_0_benefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForStoreLocator_0_benefitType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForStoreLocator_0_benefitName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForStoreLocator_0_benefitName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForStoreLocator_1_benefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForStoreLocator_1_benefitType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_benefitsTypesForStoreLocator_1_benefitName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_benefitsTypesForStoreLocator_1_benefitName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_restrictedCardStatusForBenefitUtilization_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_restrictedCardStatusForBenefitUtilization_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_restrictedCardStatusForBenefitUtilization_2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_restrictedCardStatusForBenefitUtilization_2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCBenefit_restrictedCardStatusForBenefitUtilization_3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCBenefit_restrictedCardStatusForBenefitUtilization_3] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_accessSupplementalBenefitsOn' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_accessSupplementalBenefitsOn] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_additionalBenefitTitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_additionalBenefitTitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_agentTemplateTitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_agentTemplateTitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_allowDeliveryDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_allowDeliveryDays] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_appleTrademark' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_appleTrademark] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_cardNumberLoginFieldLabel' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_cardNumberLoginFieldLabel] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_cardNumberLoginInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_cardNumberLoginInfo] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_cartCoveredKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_cartCoveredKey] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_cartNotCoveredKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_cartNotCoveredKey] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_civilRightsDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_civilRightsDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_contentMapping' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_contentMapping] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_coveredByKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_coveredByKey] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_customHeroBannerHeading' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_customHeroBannerHeading] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_dhePhone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_dhePhone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_disclaimers_onPageCustomDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_disclaimers_onPageCustomDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_exceedBenefitConfirmationKey' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_exceedBenefitConfirmationKey] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_footerDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_footerDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_GASupport' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_GASupport] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_hoursOfOperation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_hoursOfOperation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_loginMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_loginMessage] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_loginMsgOnTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_loginMsgOnTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_loginWithMemberId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_loginWithMemberId] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_memberID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_memberID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_memberIDApiError' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_memberIDApiError] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_memberIDInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_memberIDInfo] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_memberIdLoginInfo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_memberIdLoginInfo] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_orderDisclaimer' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_orderDisclaimer] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_phone' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_phone] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_PortalHeaderDescMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_PortalHeaderDescMessage] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginMessage] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginModel' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginModel] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginModel_Modeltitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginModel_Modeltitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginModel_img' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginModel_img] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginModel_ModelBodyContent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginModel_ModelBodyContent] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_postLoginModel_btntxt' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_postLoginModel_btntxt] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_preLoginHoursOfOperation' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_preLoginHoursOfOperation] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_preloginPortalHeaderDescMessage' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_preloginPortalHeaderDescMessage] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_showOTCGuidelines' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_showOTCGuidelines] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCContent_loginMsgOnTemplateNote' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCContent_loginMsgOnTemplateNote] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_allowAgentAccess' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_allowAgentAccess] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_isLoginRestricted' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_isLoginRestricted] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_isRegisterable' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_isRegisterable] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_loginTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_loginTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashConfigBackup' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashConfigBackup] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashConfigBackup_splashTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashConfigBackup_splashTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashConfigBackup_splashTitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashConfigBackup_splashTitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashConfigBackup_splashContent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashConfigBackup_splashContent] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$150' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$150] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$160' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$160] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$350' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$350] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$210' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$210] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$400' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$400] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$110' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$110] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$230' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$230] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$240' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$240] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$310' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$310] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$185' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$185] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$500' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$500] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$250' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$250] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$260' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$260] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$170' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$170] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$100' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$100] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$370' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$370] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$365' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$365] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$200' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$200] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$115' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$115] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$335' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$335] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$470' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$470] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$125' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$125] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$535' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$535] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$475' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$475] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$120' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$120] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$410' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$410] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$125' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$125] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$300' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$300] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$610' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$610] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$110' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$110] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$450' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$450] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$410' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$410] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$375' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$375] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$30' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$30] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$55' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$55] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$82' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$82] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$80' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$80] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$65' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$65] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$40' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$40] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$110' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$110] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$35' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$35] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$32' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$32] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$45' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$45] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$150' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$150] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$50' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$50] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$60' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$60] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$28' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$28] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23FoodandProduce$85' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23FoodandProduce$85] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$90' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$90] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTCTransportation$90' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTCTransportation$90] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$60' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$60] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_CY23OTC$75' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_CY23OTC$75] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Flex60' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Flex60] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Flex100' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Flex100] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Flex300' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Flex300] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Flex185' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Flex185] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Incentives' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Incentives] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Flex320' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Flex320] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_Grocery25' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_Grocery25] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_tags' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_tags] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_loginTemplate2022' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_loginTemplate2022] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_isManaged' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_isManaged] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_removeBBB' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_removeBBB] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_agentLoginType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_agentLoginType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_hideClientLogo' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_hideClientLogo] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_allowDirectDebit' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_allowDirectDebit] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_ProgramManager' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_ProgramManager] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_displayClientCustomBranding' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_displayClientCustomBranding] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_01' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_01] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_02' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_02] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_03' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_03] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_04' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_04] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_05' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_05] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_06' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_06] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_07' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_07] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_08' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_08] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_09' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_09] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_10' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_10] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_11' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_11] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_12' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_12] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_13' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_13] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_14' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_14] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_15' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_15] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_16' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_16] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_17' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_17] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_18' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_18] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_19' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_19] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_20' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_20] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_21' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_21] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_22' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_22] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_23' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_23] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_24' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_24] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_25' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_25] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_26' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_26] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_27' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_27] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_28' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_28] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_29' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_29] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_30' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_30] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_31' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_31] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_32' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_32] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_33' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_33] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_34' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_34] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_35' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_35] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_36' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_36] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_37' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_37] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_38' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_38] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_39' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_39] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_40' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_40] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_41' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_41] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_42' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_42] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_43' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_43] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_44' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_44] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_45' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_45] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_46' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_46] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_47' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_47] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_48' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_48] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_49' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_49] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_50' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_50] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_51' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_51] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_52' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_52] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_53' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_53] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_54' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_54] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_55' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_55] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_56' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_56] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_57' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_57] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_58' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_58] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_59' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_59] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_60' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_60] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_61' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_61] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_62' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_62] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_63' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_63] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_64' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_64] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_65' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_65] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_66' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_66] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_67' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_67] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_68' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_68] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_69' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_69] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_70' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_70] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_71' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_71] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_72' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_72] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_73' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_73] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_74' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_74] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_75' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_75] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_76' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_76] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_77' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_77] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_78' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_78] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_79' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_79] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_80' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_80] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_81' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_81] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_82' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_82] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_83' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_83] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_84' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_84] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_85' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_85] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_86' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_86] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_87' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_87] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_88' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_88] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_89' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_89] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_90' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_90] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_91' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_91] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_92' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_92] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_93' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_93] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_94' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_94] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_95' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_95] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_96' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_96] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_97' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_97] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_98' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_98] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_99' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_99] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_MapWallets_100' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_MapWallets_100] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_isRewardAllowed' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_isRewardAllowed] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_RewardCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_RewardCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_WalletMapping_0' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_WalletMapping_0] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_WalletMapping_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_WalletMapping_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_WalletMapping_2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_WalletMapping_2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_WalletMapping_3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_WalletMapping_3] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_Source' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_Source] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_0_DisplayName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_0_DisplayName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_RewardCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_RewardCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_WalletMapping_0' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_WalletMapping_0] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_WalletMapping_1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_WalletMapping_1] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_WalletMapping_2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_WalletMapping_2] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_WalletMapping_3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_WalletMapping_3] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_Source' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_Source] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_rewardData_1_DisplayName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_rewardData_1_DisplayName] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCRewards_isRewardRestrictedForApple' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCRewards_isRewardRestrictedForApple] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CardType_CardType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType_CardType] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CardType_Template' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType_Template] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CardType_CatalogAccessWallets' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType_CatalogAccessWallets] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CardType_CatalogAccessWallets_WalletCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType_CatalogAccessWallets_WalletCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'CardType_CatalogAccessWallets_HAUPCCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CardType_CatalogAccessWallets_HAUPCCode] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_IsClaimRequired' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_IsClaimRequired] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_NobleInsuranceID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_NobleInsuranceID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_GroupAllServicesBy' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_GroupAllServicesBy] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_IncludeBeneftsAppliedInClaim' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_IncludeBeneftsAppliedInClaim] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_DefaultClaimAmount' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_DefaultClaimAmount] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_UseNationsAsBillingProvider' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_UseNationsAsBillingProvider] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_UseNationsAsRenderingProvider' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_UseNationsAsRenderingProvider] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_IsZeroClaim' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_IsZeroClaim] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_IsEncounter' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_IsEncounter] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_SubmissionThroughClearingHouse' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_SubmissionThroughClearingHouse] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_NeedPGPEncryption' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_NeedPGPEncryption] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_ClaimDueDays' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_ClaimDueDays] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_PlaceofService' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_PlaceofService] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_ApplyCoPay' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_ApplyCoPay] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_CopyPrimaryAsSecondaryInsu' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_CopyPrimaryAsSecondaryInsu] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'Claim_IsClaimToNoble' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([Claim_IsClaimToNoble] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'DHELOGIN_splashConfig' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHELOGIN_splashConfig] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'DHELOGIN_splashConfig_splashTemplate' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHELOGIN_splashConfig_splashTemplate] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'DHELOGIN_splashConfig_splashTitle' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHELOGIN_splashConfig_splashTitle] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'DHELOGIN_splashConfig_splashContent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([DHELOGIN_splashConfig_splashContent] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISCONFIGURATION_CarrierPlanlogourl' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISCONFIGURATION_CarrierPlanlogourl] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISCONFIGURATION_ClientID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISCONFIGURATION_ClientID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a union
select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'FISCONFIGURATION_SubProgID' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([FISCONFIGURATION_SubProgID] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a ) a


/*
-- InsuranceHealthPLanID  = 999 is actually a NULL value
select distinct ConfigType from #InsuranceConfigValues

select * from  #InsuranceConfigValues 
where 1=1 and
insuranceCarrierID = 413 and
column_name not in ('InsuranceCarrierID', 'InsuranceHealthPlanID', 'ConfigData', 'ConfigType', 'IsActive') and
Value is not null
order by column_name


select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, column_name as Keys,[Value], Count(*) as RecordCount from #InsuranceConfigValues 
where value is not null and
column_name not in ('InsuranceCarrierID', 'InsuranceHealthPlanID', 'ConfigData', 'ConfigType', 'IsActive')
and InsuranceCarrierID = 34 and InsuranceHealthPlanID = 999
group by column_name, InsuranceCarrierID, InsuranceHealthPlanID,ConfigData,ConfigType,  [Value]
order by 5 desc

select distinct insuranceCarrierID, InsuranceHealthPlanID, ConfigType 
--RANK() OVER (PARTITION BY insuranceCarrierID, InsuranceHealthPlanID, ConfigType ORDER BY insuranceCarrierID, InsuranceHealthPlanID ) Rank,
--ROW_NUMBER()  OVER (PARTITION BY insuranceCarrierID, InsuranceHealthPlanID ORDER BY ConfigType ) ROWNUM
from  #InsuranceConfigValues 
--where InsuranceHealthPlanID <> 99 order by insuranceCarrierID, InsuranceHealthPlanID, 5


select insuranceCarrierID, InsuranceHealthPlanID, count(*) as RC from (
select distinct insuranceCarrierID, InsuranceHealthPlanID, ConfigType 
from  #InsuranceConfigValues
) a
group by insuranceCarrierID, InsuranceHealthPlanID
order by RC desc

select * from (select InsuranceCarrierID, InsuranceHealthPlanID, ConfigType, ConfigData, 'OTCLogin_splashConfigBackup_splashContent' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([OTCLogin_splashConfigBackup_splashContent] as nvarchar(max)))),'"') as VALUE from  #InsuranceConfig ) a
where value is not null



select  * from #InsuranceConfigValues where ConfigType = 'OTCAPP' and Value is not null and
column_name not in ('InsuranceCarrierID', 'InsuranceHealthPlanID', 'ConfigData', 'ConfigType', 'IsActive')
order by ConfigData
--and ConfigData like '%reward%'

select distinct ConfigType, ConfigData, Column_name,Value from #InsuranceConfigValues where ConfigType = 'FISBENEFITS' and Value is not null and
column_name not in ('InsuranceCarrierID', 'InsuranceHealthPlanID', 'ConfigData', 'ConfigType', 'IsActive') 
order by configdata,column_name


drop table if exists #ConfigParse
select * into #ConfigParse from 
(
select ConfigType, ConfigData from insurance.InsuranceConfig where ConfigType = 'CLAIM'
) a

select * from #ConfigParse

update #configParse set ConfigData = (replace(replace(replace(ConfigData,'"',''), '{',''), '}',''))
update #configParse set ConfigData = (replace(ConfigData, '[', ''))
update #configParse set ConfigData = (replace(ConfigData, ']', ''))


drop table if exists #ConfigParseFull
select * into #ConfigParseFull from (
select ConfigType, ltrim(rtrim(value)) as keyValue, ltrim(rtrim(substring(value,0, charindex(':',value)) )) as keys, ltrim(rtrim(substring(value,charindex(':',value)+1, len(value)) )) as value  from (
SELECT distinct ConfigType, ltrim(rtrim(value )) as value
FROM #configParse
    CROSS APPLY STRING_SPLIT(rtrim(ltrim(ConfigData)), ',')
	where RTRIM(ltrim(value)) <> ''
) a
) a

select * from #ConfigParseFull

select distinct keys from #ConfigParseFull union
select distinct value as keys from #ConfigParseFull 

*/