

select
'select top 100 * from
(' +
'select distinct  ' 
+''''+TABLE_SCHEMA+''''+' as TABLE_SCHEMA,' 
+''''+ TABLE_NAME+'''' + ' as TABLE_NAME,' 
+''''+ COLUMN_NAME +''''+ ' as COLUMN_NAME,' 
+ 'QUOTENAME(ltrim(rtrim(cast(' +'['+ COLUMN_NAME+']' + ' as nvarchar))),' + '''"'''+') as VALUE from ' 
+ TABLE_SCHEMA +'.'+ '['+TABLE_NAME+']' +
') a union '
from  information_Schema.COLUMNS
where 1=1 and column_name like '%BenefitType%'
--TABLE_SCHEMA in ('nb') 
and COLUMN_NAME not in ('CreateUser', 'ModifyUser', 'CreateDate', 'ModifyDate')
-- and DATA_TYPE IN ('float','bigint','bit','datetime','nvarchar','varchar')



select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_FD' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_FD]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_Meta_HAP' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_Meta_HAP]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F1_HAP' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F1_HAP]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'ClientBenefitRulesData' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[ClientBenefitRulesData]) a union 
select top 100 * from  (select distinct  'Orders' as TABLE_SCHEMA,'MemberBenefitExternalUsage_History' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from Orders.[MemberBenefitExternalUsage_History]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021_Cache' as TABLE_NAME,'W1_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W1_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021_Cache]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021_Cache' as TABLE_NAME,'W2_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W2_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021_Cache]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021_Cache' as TABLE_NAME,'W3_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W3_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021_Cache]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_CI_bkp_20220811' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_CI_bkp_20220811]) a union 
select top 100 * from  (select distinct  'provider' as TABLE_SCHEMA,'MemberInsuranceBenefitDetails_bkp_refactor' as TABLE_NAME,'BenefitTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypeCode] as nvarchar))),'"') as VALUE from provider.[MemberInsuranceBenefitDetails_bkp_refactor]) a union 
select top 100 * from  (select distinct  'Master' as TABLE_SCHEMA,'MemberInsuranceBenefitDetails_bkp_refactor' as TABLE_NAME,'BenefitTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypeCode] as nvarchar))),'"') as VALUE from Master.[MemberInsuranceBenefitDetails_bkp_refactor]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_FD_BANCORP_temp' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_FD_BANCORP_temp]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_Error' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_Error]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'MemberAddressChange' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[MemberAddressChange]) a union 
select top 100 * from  (select distinct  'temp' as TABLE_SCHEMA,'OTC_Issue_0108_A_OrderInfo' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from temp.[OTC_Issue_0108_A_OrderInfo]) a union 
select top 100 * from  (select distinct  'Orders' as TABLE_SCHEMA,'MemberOrdersExternalUsage' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from Orders.[MemberOrdersExternalUsage]) a union 
select top 100 * from  (select distinct  'temp' as TABLE_SCHEMA,'connecticare_Plans_with_OTC_Benefit' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from temp.[connecticare_Plans_with_OTC_Benefit]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'MasterCarrierConfigTemp' as TABLE_NAME,'CarrierConfig_BenefitTypes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([CarrierConfig_BenefitTypes] as nvarchar))),'"') as VALUE from dbo.[MasterCarrierConfigTemp]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_Meta' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_Meta]) a union 
select top 100 * from  (select distinct  'execreports' as TABLE_SCHEMA,'OrderSummaryDetails_2021' as TABLE_NAME,'BenefitType1' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType1] as nvarchar))),'"') as VALUE from execreports.[OrderSummaryDetails_2021]) a union 
select top 100 * from  (select distinct  'execreports' as TABLE_SCHEMA,'OrderSummaryDetails_2021' as TABLE_NAME,'BenefitType2' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType2] as nvarchar))),'"') as VALUE from execreports.[OrderSummaryDetails_2021]) a union 
select top 100 * from  (select distinct  'execreports' as TABLE_SCHEMA,'OrderSummaryDetails_2021' as TABLE_NAME,'BenefitType3' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType3] as nvarchar))),'"') as VALUE from execreports.[OrderSummaryDetails_2021]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_HealthFirst' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_HealthFirst]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F1' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F1]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'BenefitTypes' as TABLE_NAME,'BenefitTypeCode' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypeCode] as nvarchar))),'"') as VALUE from Insurance.[BenefitTypes]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'BenefitTypes' as TABLE_NAME,'BenefitTypeId' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypeId] as nvarchar))),'"') as VALUE from Insurance.[BenefitTypes]) a union 
select top 100 * from  (select distinct  'Insurance' as TABLE_SCHEMA,'BenefitTypes' as TABLE_NAME,'BenefitTypeName' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypeName] as nvarchar))),'"') as VALUE from Insurance.[BenefitTypes]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F2' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F2]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'BCBSKC_TermMembers_20220830' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from dbo.[BCBSKC_TermMembers_20220830]) a union 
select top 100 * from  (select distinct  'temp' as TABLE_SCHEMA,'OTC_Issue_0108_B_OrderInfo' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from temp.[OTC_Issue_0108_B_OrderInfo]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_CI_BANCORP_temp' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_CI_BANCORP_temp]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'Alignment_BrokerCard_600_Reward10_20221102' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from dbo.[Alignment_BrokerCard_600_Reward10_20221102]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021' as TABLE_NAME,'W1_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W1_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021' as TABLE_NAME,'W2_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W2_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'BI_OTC_OrderDetail_Data_2021' as TABLE_NAME,'W3_BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([W3_BenefitType] as nvarchar))),'"') as VALUE from bireports.[BI_OTC_OrderDetail_Data_2021]) a union 
select top 100 * from  (select distinct  'flex' as TABLE_SCHEMA,'temp_CardBenefitLoad' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from flex.[temp_CardBenefitLoad]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'GetActiveInsuranceByMemberID' as TABLE_NAME,'BenefitTypes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypes] as nvarchar))),'"') as VALUE from dbo.[GetActiveInsuranceByMemberID]) a union 
select top 100 * from  (select distinct  'bireports' as TABLE_SCHEMA,'MitelQueue_CRMCarrier_Mapping_2020' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from bireports.[MitelQueue_CRMCarrier_Mapping_2020]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_CI' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_CI]) a union 
select top 100 * from  (select distinct  'nb' as TABLE_SCHEMA,'PurseBenefit' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from nb.[PurseBenefit]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'AetnaTestCardPopulation_20220819_ssn' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from dbo.[AetnaTestCardPopulation_20220819_ssn]) a union 
select top 100 * from  (select distinct  'Orders' as TABLE_SCHEMA,'MemberBenefitExternalUsage' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from Orders.[MemberBenefitExternalUsage]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_CI_bkp_20220623_Aetna_COVID' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_CI_bkp_20220623_Aetna_COVID]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F2_Optima' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F2_Optima]) a union 
select top 100 * from  (select distinct  'dbo' as TABLE_SCHEMA,'GetMemberInsurancesByMemberID' as TABLE_NAME,'BenefitTypes' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitTypes] as nvarchar))),'"') as VALUE from dbo.[GetMemberInsurancesByMemberID]) a union 
select top 100 * from  (select distinct  'catalog' as TABLE_SCHEMA,'FISCategory' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from catalog.[FISCategory]) a union 
select top 100 * from  (select distinct  'otcfunds' as TABLE_SCHEMA,'CardBenefitLoad_bkp_20220227_before_FDRefactor' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from otcfunds.[CardBenefitLoad_bkp_20220227_before_FDRefactor]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F9' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F9]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F9_UHP_HA' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F9_UHP_HA]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_F9_UHP_OTC' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_F9_UHP_OTC]) a union 
select top 100 * from  (select distinct  'InAppBI' as TABLE_SCHEMA,'ClientUtilizationCallStatistics_HAP_Main' as TABLE_NAME,'BenefitType' as COLUMN_NAME,QUOTENAME(ltrim(rtrim(cast([BenefitType] as nvarchar))),'"') as VALUE from InAppBI.[ClientUtilizationCallStatistics_HAP_Main]) a 