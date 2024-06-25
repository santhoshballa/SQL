routine_definition
CREATE PROCEDURE [Document].[GetDocumentsListByOrderMemberChartDataId]
(
  @OrderMemberchartDataId bigint,
  @DocType varchar(15)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON
BEGIN
    select top 1 
	DT.DocProcessID as DocumentProcessId,
	DT.DocumentName as DocumentName,
	DT.DocumentTypeCode as DocumentType,
	DO.DocumentObject as DocumentData,
	DT.DocumentExtension as Extension
	from provider.MemberChartData Mc join [Document].[DocumentTransaction]  DT on DT.MemberChartId=MC.MemberChartId 
    join [Document].[DocumentObject] DO on Do.DocumentObjectID=DT.DocumentObjectID 
    where Mc.MemberChartDataId=@OrderMemberchartDataId and DT.DocumentTypeCode = @DocType  and DT.IsActive=1 
	and Do.IsActive=1 and  Mc.IsActive=1 order by DT.CreateDate desc
END
END
-- =============================================
-- Author:      <Author, pulikamsuneetha, Name>
-- Create Date: <Create Date, 10-04-2020, >
-- Description: <Description,to get document object data based on the ordermemberchartdataid , >
-- =============================================
CREATE PROCEDURE [Document].[GetDocumentsListbyOrdermhtId]
(
    -- Add the parameters for the stored procedure here
  @OrderMemberchartDataId bigint,
  @DocType varchar(15)
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON

  	IF (@DocType ='AGM')  
BEGIN
    select top 1 DO.DocumentObjectID,DocumentObject,DO.IsActive,'' as DocumentMasterModels,'' as DocumentTransactionModels 
	,Do.CreateUser ,DO.CreateDate,DO.ModifyUser,DO.ModifyDate ,cast(1 as bit ) as isFileholdSync
	from provider.MemberChartData Mc
    left join [Document].[DocumentTransaction]  DT on DT.MemberChartDataId=MC.MemberChartDataId

(2 rows affected)


Completion time: 2021-08-16T17:16:11.5539718-04:00
