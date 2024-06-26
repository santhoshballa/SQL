/****** Object:  UserDefinedFunction [dbo].[GetIdBasedOnInput]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
SELECT [dbo].[GetIdBasedOnInput]('1000','PRODUCTTYPE')    
*/    
    
CREATE   FUNCTION [dbo].[GetIdBasedOnInput]      
(      
   @Input VARCHAR(100),    
   @Type VARCHAR(25)      
)      
RETURNS INT     
AS      
BEGIN      
    DECLARE @response INT = -1    
    
  IF(@Type = 'BRAND')    
  BEGIN   
  IF(ISNULL(@Input,'NULL') = 'NULL' OR ISNULL(@Input,'') = '')  
  BEGIN  
   SELECT @response = BrandId FROM PM.Brands WHERE [Name] = 'Other'  
  END  
  ELSE  
  BEGIN  
   SELECT @response = BrandId FROM PM.Brands WHERE [Name] = @Input   
  END   
     
  END    
    
  IF(@Type = 'CATEGORY')    
  BEGIN  
  IF(ISNULL(@Input,'NULL') = 'NULL' OR ISNULL(@Input,'') = '')  
  BEGIN  
   SELECT @response = CategoryId FROM PM.Category WHERE [Name] = 'Other'  
  END  
  ELSE  
  BEGIN  
   SELECT @response = CategoryId FROM PM.Category WHERE [Name] = @Input    
  END    
  END    
    
  IF(@Type = 'SUBCATEGORY')    
  BEGIN    
  IF(ISNULL(@Input,'NULL') = 'NULL' OR ISNULL(@Input,'') = '')  
  BEGIN  
   SELECT @response = SubCategoryId FROM PM.SubCategory WHERE [Name] = 'Other'  
  END  
  ELSE  
  BEGIN  
   SELECT @response = SubCategoryId FROM PM.SubCategory WHERE [Name] = @Input    
  END  
  END    
    
  IF(@Type = 'ITEMTYPE')    
  BEGIN   
  IF(ISNULL(@Input,'NULL') = 'NULL' OR ISNULL(@Input,'') = '')  
  BEGIN  
   SELECT @response = ItemTypeId FROM PM.ItemTypes WHERE [Name] = 'Other'  
  END  
  ELSE  
  BEGIN  
   SELECT @response = ItemTypeId FROM PM.ItemTypes WHERE [Name] = (CASE WHEN @Input = 'HA' THEN 'Hearing Aid' ELSE @Input END)   
  END     
  END    
    
  IF(@Type = 'PRODUCTTYPE')    
  BEGIN    
  IF(ISNULL(@Input,'NULL') = 'NULL' OR ISNULL(@Input,'') = '')  
  BEGIN  
   SELECT @response = ProductTypeId FROM PM.ProductTypes WHERE [Name] = 'Other'  
  END  
  ELSE  
  BEGIN  
   SELECT @response = ProductTypeId FROM PM.ProductTypes WHERE [Name] = @Input  
  END   
  END    
      
  RETURN ISNULL(@response, -1)     
END 
GO
/****** Object:  UserDefinedFunction [dbo].[UDF_Get_Effective_Date]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   FUNCTION [dbo].[UDF_Get_Effective_Date]  
(  
   @effectiveDate AS DATE = NULL  
)  
RETURNS DATE  
AS  
BEGIN  
    DECLARE @returnEffectiveDate AS DATE  
    DECLARE @ESTDATE DATE = CONVERT(DATE, GETDATE() AT TIME ZONE (SELECT CURRENT_TIMEZONE_ID()) AT TIME ZONE 'Eastern Standard Time')

    IF @effectiveDate IS NOT NULL  
    BEGIN  
        SET @returnEffectiveDate = CASE WHEN YEAR(@effectiveDate) = YEAR(GETDATE())
                                        THEN @effectiveDate
                                        ELSE @ESTDATE
                                   END
    END  
    ELSE
    BEGIN
        SET @returnEffectiveDate = @ESTDATE
    END
  
    RETURN @returnEffectiveDate  
END
GO
/****** Object:  UserDefinedFunction [Item].[GetActiveConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*      
===================================================================================================                                          
Created by    : Naresh S                                                 
Description   : Used to get unique item configurations                                                    
Create on     : May-08-2024                                                                                              
===================================================================================================         
Modify By     :                                               
Description   :                                                   
modify Date   :                                
===================================================================================================       
Execution:      
select Item.GetActiveConfigurations()      
===================================================================================================        
*/      
CREATE   FUNCTION [Item].[GetActiveConfigurations](  
 @BenefitTypeId INT = 1  
)      
RETURNS varchar(max)      
AS      
BEGIN      
    DECLARE @config_Ids VARCHAR(MAX) = ''      
 DECLARE @Item_Ids VARCHAR(MAX) = ''      
      
 --Current Active Configurations       
 SELECT @config_Ids = STRING_AGG(ConfigurationId,','), @Item_Ids = STRING_AGG(ItemId,',')       
 FROM (      
  SELECT MAX(ConfigurationId) ConfigurationId, I.ItemId       
  FROM Item.[Configurations] C  
  JOIN Item.Items I ON I.ItemId = C.ItemId  
  WHERE I.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL      
  AND C.IsActive = 1  
  --AND I.IsActive = 1  
  AND GETDATE() BETWEEN EffectiveFrom AND EffectiveTo      
  GROUP BY I.ITEMID      
 ) T    
     
 SET @config_Ids = ISNULL(@config_Ids,0)    
 SET @Item_Ids = ISNULL(@Item_Ids,0)    
      
 IF EXISTS(SELECT I.ItemId       
   FROM Item.[Configurations] C  
   JOIN Item.Items I ON I.ItemId = C.ItemId  
   WHERE I.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL      
   AND C.IsActive = 1  
   --AND I.IsActive = 1     
   AND I.ItemId NOT IN (SELECT [value] FROM STRING_SPLIT(@Item_Ids, ','))      
   AND GETDATE() < EffectiveFrom      
   AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(@config_Ids, ',')))  
  BEGIN  
 --Future configuration      
  SELECT @config_Ids = @config_Ids + ',' + STRING_AGG(ConfigurationId,','), @Item_Ids = @Item_Ids+',' + STRING_AGG(ItemId,',')       
  FROM (      
   SELECT MIN(ConfigurationId) ConfigurationId, I.ItemId       
   FROM Item.[Configurations] C  
   JOIN Item.Items I ON I.ItemId = C.ItemId  
   WHERE I.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL      
   AND C.IsActive = 1  
   --AND I.IsActive = 1     
   AND I.ItemId NOT IN (SELECT [value] FROM STRING_SPLIT(@Item_Ids, ','))      
   AND GETDATE() < EffectiveFrom      
   AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(@config_Ids, ','))      
   GROUP BY I.ITEMID      
  ) T   
 END  
      
 SET @config_Ids = ISNULL(@config_Ids,0)    
 SET @Item_Ids = ISNULL(@Item_Ids,0)    
  
  
 --Past configuration   
 IF EXISTS(SELECT I.ItemId       
   FROM Item.[Configurations] C  
   JOIN Item.Items I ON I.ItemId = C.ItemId  
   WHERE I.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL      
   AND C.IsActive = 1  
   --AND I.IsActive = 1      
   AND I.ItemId NOT IN (SELECT [value] FROM STRING_SPLIT(@Item_Ids, ','))      
   AND GETDATE() > EffectiveFrom      
   AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(@config_Ids, ',')))  
  BEGIN  
   SELECT @config_Ids = @config_Ids + ',' + STRING_AGG(ConfigurationId,','), @Item_Ids = @Item_Ids+',' + STRING_AGG(ItemId,',')      
   FROM (      
    SELECT MAX(ConfigurationId) ConfigurationId, I.ItemId       
    FROM Item.[Configurations] C  
    JOIN Item.Items I ON I.ItemId = C.ItemId  
    WHERE I.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL      
    AND C.IsActive = 1  
    --AND I.IsActive = 1      
    AND I.ItemId NOT IN (SELECT [value] FROM STRING_SPLIT(@Item_Ids, ','))      
    AND GETDATE() > EffectiveFrom      
    AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(@config_Ids, ','))      
    GROUP BY I.ITEMID      
   ) T    
 END  
 RETURN  @config_Ids      
      
END
GO
/****** Object:  UserDefinedFunction [PM].[GetDistinctValues]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
SELECT [PM].[GetDistinctValues]('1,2,3,4,1,2,3,5,6,7')
*/

CREATE   FUNCTION [PM].[GetDistinctValues]  
(  
   @request VARCHAR(MAX) = NULL  
)  
RETURNS VARCHAR(MAX)  
AS  
BEGIN  
    DECLARE @response VARCHAR(MAX)

    SELECT @response= '[' + STRING_AGG('"'+VALUE+'"',',') + ']' FROM (SELECT DISTINCT VALUE FROM STRING_SPLIT(@request, ',')) AS T
  
    RETURN @response  
END
GO
/****** Object:  UserDefinedFunction [Template].[GetActiveConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*    
===================================================================================================                                        
Created by    : Naresh S                                               
Description   : Used to get unique Template configurations                                                  
Create on     : May-08-2024                                                                                            
===================================================================================================       
Modify By     :                                             
Description   :                                                 
modify Date   :                              
===================================================================================================     
Execution:    
select Template.GetActiveConfigurations(1)    
===================================================================================================      
*/    
CREATE   FUNCTION [Template].[GetActiveConfigurations](@BenefitTypeId INT)    
RETURNS varchar(max)    
AS    
BEGIN    
    DECLARE @config_Ids VARCHAR(MAX) = ''    
	DECLARE @template_Ids VARCHAR(MAX) = ''    
    
	--Current Active Configurations     
	SELECT @config_Ids = STRING_AGG(ConfigurationId,','), @template_Ids = STRING_AGG(T.TemplateId,',')     
	FROM (    
	 SELECT MAX(ConfigurationId) ConfigurationId, T.TemplateId     
	 FROM Template.[Configurations] C
	 JOIN Template.Templates T ON T.TemplateId = C.TemplateId
	 WHERE T.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL    
	 --AND C.IsActive = 1  
	 AND T.IsActive = 1
	 AND GETDATE() BETWEEN EffectiveFrom AND EffectiveTo    
	 GROUP BY T.TemplateId    
	) T    
    
	--Future configuration   
	IF EXISTS(SELECT T.TemplateId     
	  FROM Template.[Configurations] C
	  JOIN Template.Templates T ON T.TemplateId = C.TemplateId  
	  WHERE T.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL    
	  --AND C.IsActive = 1 
	  AND T.IsActive = 1
	  AND T.TemplateId NOT IN (SELECT [value] FROM STRING_SPLIT(ISNULL(@template_Ids,0), ','))    
	  AND GETDATE() < EffectiveFrom    
	  AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(ISNULL(@config_Ids,0), ',')))
	BEGIN
	 SELECT @config_Ids = ISNULL(@config_Ids,0) + ',' + ISNULL(STRING_AGG(ConfigurationId,','),''), 
	 @template_Ids = ISNULL(@template_Ids,0) + STRING_AGG(T.TemplateId,',')     
	 FROM (    
	  SELECT MAX(ConfigurationId) ConfigurationId, T.TemplateId     
	  FROM Template.[Configurations] C
	  JOIN Template.Templates T ON T.TemplateId = C.TemplateId  
	  WHERE T.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL    
	  --AND C.IsActive = 1 
	  AND T.IsActive = 1
	  AND T.TemplateId NOT IN (SELECT [value] FROM STRING_SPLIT(ISNULL(@template_Ids,0), ','))    
	  AND GETDATE() < EffectiveFrom    
	  AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(ISNULL(@config_Ids,0), ','))    
	  GROUP BY T.TemplateId    
	 ) T    
 
	END
    
	--Past configuration 
	IF EXISTS(SELECT T.TemplateId     
	  FROM Template.[Configurations] C
	  JOIN Template.Templates T ON T.TemplateId = C.TemplateId   
	  WHERE T.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL    
	  AND T.IsActive = 1    
	  --AND C.IsActive = 1
	  AND T.TemplateId NOT IN (SELECT [value] FROM STRING_SPLIT(ISNULL(@template_Ids,0), ','))    
	  AND GETDATE() > EffectiveFrom    
	  AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(ISNULL(@config_Ids,0), ',')))
	BEGIN
	 SELECT @config_Ids = ISNULL(@config_Ids,0) + ',' + ISNULL(STRING_AGG(ConfigurationId,','),''), @template_Ids = ISNULL(@template_Ids,0) + STRING_AGG(T.TemplateId,',')     
	 FROM (    
	  SELECT MAX(ConfigurationId) ConfigurationId, T.TemplateId     
	  FROM Template.[Configurations] C
	  JOIN Template.Templates T ON T.TemplateId = C.TemplateId   
	  WHERE T.BenefitTypeId = @BenefitTypeId AND EffectiveFrom IS NOT NULL    
	  AND T.IsActive = 1    
	  --AND C.IsActive = 1
	  AND T.TemplateId NOT IN (SELECT [value] FROM STRING_SPLIT(ISNULL(@template_Ids,0), ','))    
	  AND GETDATE() > EffectiveFrom    
	  AND ConfigurationId NOT IN (SELECT [VALUE] FROM STRING_SPLIT(ISNULL(@config_Ids,0), ','))    
	  GROUP BY T.TemplateId    
	 ) T  
	END
    
    RETURN  @config_Ids    
    
END
GO
/****** Object:  UserDefinedFunction [TestActivity].[diff_Product]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Function [TestActivity].[diff_Product] (@id int, @date datetime2(0))
returns table
as
return (
	select v1.[key] as [Column], v1.value as v1, v2.value as v2
	from OPENJSON(
			(select * from TestActivity.Product where ProductID = @id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) v1
		join OPENJSON(
			(select * from TestActivity.Product for system_time as of @date where ProductID = @id FOR JSON PATH, WITHOUT_ARRAY_WRAPPER)) v2
		on v1.[key] = v2.[key]
	where v1.value <> v2.value
)
GO
/****** Object:  StoredProcedure [Auth].[GetUserRoles]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                 
===================================================================================================                              
Created by    : Praveen Acha                                        
Description   : used to Get the User Roles      
Create on     : 24-May-2024                                        
Used in       : Pricing Manager Serivce                                         
===================================================================================================                              
History:                 
===========================================================================================               
Modified by         :               
Modified on         :               
Description         :               
===================================================================================================                              
--exec [Auth].[GetUserRoles] 'skasimsetty@nationsbenefits.com'
===================================================================================================     
*/

CREATE PROC [Auth].[GetUserRoles]  
(  
	@Email varchar(250)  
)  
As  
Begin  
  
  
SELECT 
    ROW_NUMBER() OVER (ORDER BY U.UserId) AS RowNumber, 
    U.FullName, 
    U.Email, 
    U.UserId, 
    U.Username, 
    R.RoleId, 
    R.[Name] AS RoleName, 
    M.MenuName, 
    SM.SubMenuName, 
    P.PageName, 
    RC.IsCreate, 
    RC.IsRead, 
    RC.IsUpdate, 
    RC.IsDelete   
FROM 
    Auth.Users U  
INNER JOIN 
    Auth.UserRoles UR ON UR.UserId = U.UserId AND U.IsActive = 1 
INNER JOIN 
    Auth.Roles R ON UR.RoleId = R.RoleId AND R.IsActive = 1
INNER JOIN 
    Auth.RoleConfigurations RC ON RC.RoleId = R.RoleId AND RC.IsActive = 1
INNER JOIN 
    Auth.Pages P ON P.PageId = RC.PageId AND P.IsActive = 1 
INNER JOIN 
    Auth.SubMenus SM ON SM.SubMenuId = P.SubMenuId AND SM.IsActive = 1
INNER JOIN 
    Auth.Menus M ON M.MenuId = SM.MenuId AND M.IsActive = 1
WHERE 
    U.Email = @Email AND U.IsActive = 1

  
END  


GO
/****** Object:  StoredProcedure [dbo].[GetProducts]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[GetProducts] as
begin

	select * from TestActivity.Product
		left join TestActivity.Product FOR SYSTEM_TIME ALL as ProductHistory
			on Product.ProductID = ProductHistory.ProductID
			and Product.ValidFrom <> ProductHistory.ValidFrom
	order by Product.ProductID asc, ProductHistory.ValidFrom desc
	FOR JSON AUTO, ROOT('data')

end
GO
/****** Object:  StoredProcedure [dbo].[GetTechnologyLevels]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTechnologyLevels]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT Id, Name, IsActive, CreatedBy, CreatedDate, ModifiedBy, ModifiedDate
    FROM PM.TechnologyLevels;
END;
GO
/****** Object:  StoredProcedure [Item].[BulkUpdateItemConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                             
===================================================================================================                          
Created by    : Abirami Vellore                                  
Description   : Bulk updates the item Prices and Effective from of items
Create on     : 06-03-2024                                    
Used in       : Pricing Manager Serivce                                     
===================================================================================================                          
History:             
===========================================================================================           
Modified by         :           
Modified on         :           
Description         :           
===================================================================================================                          
How to Exec   : exec [Item].[BulkUpdateItemConfigurations] '[
    {"ItemId": 280, "CogsPrice": 200.99, "EffectiveFrom": "2024-01-03T00:00:00"},
    {"ItemId": 289, "CogsPrice": 155.49, "EffectiveFrom": "2024-01-03T00:00:00"}
]','abi'      
===================================================================================================          
*/
CREATE
	

 PROCEDURE [Item].[BulkUpdateItemConfigurations] (
	@PriceUpdates NVARCHAR(MAX)
	,@UserName NVARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @SuccessfullyUpdated VARCHAR(200) = 'Items updated successfully.';
	DECLARE @SuccessfullyUpdatedCode INT = 200;

	BEGIN TRY
		BEGIN TRANSACTION;

		-- Temporary table to hold parsed JSON data
		DECLARE @UpdateData TABLE (
			ItemId INT
			,CogsPrice DECIMAL(18, 2)
			,EffectiveFrom DATETIME
			);

		-- Insert parsed JSON data into temporary table
		INSERT INTO @UpdateData (
			ItemID
			,CogsPrice
			,EffectiveFrom
			)
		SELECT ItemId
			,CogsPrice
			,EffectiveFrom
		FROM OPENJSON(@PriceUpdates) WITH (
				ItemId INT
				,CogsPrice DECIMAL(18, 2)
				,EffectiveFrom DATETIME
				);

		INSERT INTO [Item].[Configurations] (
			ItemId
			,DisplayName
			,Reason
			,CogsPrice
			,Attachment
			,EffectiveFrom
			,EffectiveTo
			,IsActive
			,CreatedBy
			,CreatedDate
			,ModifiedBy
			,ModifiedDate
			)
		SELECT UD.ItemId
			,IT.Name
			,NULL
			,UD.CogsPrice
			,NULL
			,UD.EffectiveFrom
			,'2099-12-31'
			,1
			,@UserName
			,GETDATE()
			,@UserName
			,GETDATE()
		FROM @UpdateData UD
		JOIN Item.Items IT ON IT.ItemId = UD.ItemID

		-- Return success message and code
		SELECT @SuccessfullyUpdated AS Message
			,@SuccessfullyUpdatedCode AS Code;

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;

		THROW;
	END CATCH;
END;
GO
/****** Object:  StoredProcedure [Item].[DeleteImageById]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                  
Description   : used to get the Images for item configuration     
Create on     : 09-May-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : 

exec Item.DeleteImageById 22,68,'PACHA'      
===================================================================================================        
*/  
CREATE PROC [Item].[DeleteImageById]
(
@ItemId bigint,
@ImageId int,
@UserName varchar(250)
)
As
Begin

	BEGIN TRY
		
		DECLARE @UpdateMessage VARCHAR(MAX) = 'Image deleted succesfully'
		DECLARE @StatusCode INT = 200

		
		UPDATE Item.Images SET IsActive = 0, ModifiedBy = @UserName,ModifiedDate = GETDATE()
		WHERE ItemId = @ItemId AND ImageId = @ImageId

		SELECT @UpdateMessage AS [Message], @StatusCode AS [Code]
	END TRY
	BEGIN CATCH
		THROW 
	END CATCH

End
GO
/****** Object:  StoredProcedure [Item].[DeleteItemConfiguration]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                                   
===================================================================================================                                
Created by    : Abirami.V                                          
Description   : used to delete the item Configurations               
Create on     : 10-May-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===========================================================================================                 
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
 exec [Item].[DeleteItemConfiguration] 294,59,'valid test','Abi'   
===================================================================================================                                
*/  
Create    PROCEDURE [Item].[DeleteItemConfiguration](  
    @ConfigurationId INT,  
	@ItemId bigint,
	@Reason VARCHAR(250),
	@UserName VARCHAR(50)
)  
AS  
BEGIN  

	BEGIN TRY
     SET NOCOUNT ON;  

		DECLARE @PreviousEffectiveTo DATETIME;
        -- Step 1: Get the EffectiveTo date of the current record
        SELECT TOP 1 @PreviousEffectiveTo = EffectiveTo
        FROM [Item].[Configurations]
        WHERE ConfigurationId = @ConfigurationId
          AND ItemId = @ItemId
          AND IsActive = 1;

        -- Step 2: Update the EffectiveTo date of the previous record
        IF @PreviousEffectiveTo IS NOT NULL
        BEGIN
            UPDATE [Item].[Configurations]
            SET EffectiveTo = @PreviousEffectiveTo
            WHERE ConfigurationId = (
                SELECT TOP 1 ConfigurationId
                FROM [Item].[Configurations]
                WHERE ItemId = @ItemId
                  AND ConfigurationId < @ConfigurationId
                  AND IsActive = 1
                ORDER BY ConfigurationId DESC
            );
        END

        -- Step 3: Mark the specified record as inactive
        UPDATE [Item].[Configurations]
        SET IsActive = 0,
            Reason = @Reason,
            ModifiedBy = @UserName,
            ModifiedDate = GETDATE()
        WHERE ConfigurationId = @ConfigurationId
          AND ItemId = @ItemId;

        -- Return success message
        DECLARE @ConfigurationDeletedSuccessMessage VARCHAR(500) = 'Upcoming Configuration deleted successfully.';
        DECLARE @ConfigurationDeletedCode INT = 200;
        SELECT @ConfigurationDeletedSuccessMessage AS Message, @ConfigurationDeletedCode AS Code, @ConfigurationId AS Id;  

	END TRY

	BEGIN CATCH
		THROW
	END CATCH;
          
END  
GO
/****** Object:  StoredProcedure [Item].[GetAccessoryMappingItemsByItemId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                                   
===================================================================================================                                
Created by    : Rafi Ahmmed Shaik                                        
Description   : used to get the accessorymapping items By ItemId        
Create on     : 06-Jun-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===================================================================================================              
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
How to Exec   : exec [Item].[GetAccessoryMappingItemsByItemId]  300  
===================================================================================================                
*/
CREATE
	

 PROCEDURE [Item].[GetAccessoryMappingItemsByItemId] (@ItemId BIGINT)
AS
BEGIN
	SET NOCOUNT ON

	SELECT AMI.Id AS AccessoryId
	    ,IT.ItemId AS ItemId
		,IT.[Name] AS ItemName
		,CAT.Name AS Model
		,BR.Name AS Brand
		,SCAT.[Name] AS SubCategory
		,PT.[Name] AS ProductType
		,AMI.ModifiedBy
		,AMI.ModifiedDate
	FROM [Item].[Items] IT
	JOIN [PM].[Brands] BR ON BR.BrandId = IT.BrandId
		AND BR.IsActive = 1
	JOIN [Item].[AccessoryMapping] AMI ON AMI.ItemId = IT.ItemId
		AND AMI.IsActive = 1
	JOIN [Item].[Mapping] ITM ON ITM.ItemId = IT.ItemId
		AND ITM.IsActive = 1
	JOIN [PM].[Category] CAT ON ITM.CategoryId = CAT.CategoryId
		AND CAT.IsActive = 1
	JOIN PM.SubCategory SCAT ON SCAT.SubCategoryId = ITM.SubCategoryId
		AND SCAT.IsActive = 1
	JOIN PM.ProductTypes PT ON PT.ProductTypeId = ITM.ProductTypeId
		AND PT.IsActive = 1
	JOIN PM.ItemTypes ITT ON ITT.ItemTypeId = IT.ItemTypeId
		AND ITT.IsActive = 1
	WHERE AMI.AccessoryItemId = @ItemId
END

GO
/****** Object:  StoredProcedure [Item].[GetAllBrandsWithItemCount]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                   
===================================================================================================                                
Created by    : Sravani G                                        
Description   : used to get the Brands with ItemsCount         
Create on     : 04-Jun-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===================================================================================================              
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
How to Exec   : exec [Item].[GetAllBrandsWithItemCount]        
===================================================================================================                
*/
CREATE
	

 PROCEDURE [Item].[GetAllBrandsWithItemCount]
AS
BEGIN
	SELECT br.BrandId AS BrandId
		,br.[Name] AS BrandName
		,count(it.itemId) AS ItemsCount
	FROM [Item].[Items] it
	JOIN [PM].[Brands] br ON Br.BrandId = it.BrandId
	JOIN [Item].[Configurations] itcon ON it.ItemId = itcon.ItemId
	WHERE it.ItemTypeId=1
	     AND(GETDATE() BETWEEN EffectiveFrom
				AND EffectiveTo
			)
		AND br.IsActive = 1
		AND it.IsActive = 1
		AND itcon.IsActive = 1
	GROUP BY br.BrandId
		,br.[Name]
END
GO
/****** Object:  StoredProcedure [Item].[GetAllItems]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE       PROCEDURE [Item].[GetAllItems](  
@BenefitTypeId INT = 1  
)     
AS    
BEGIN    
    
 SET NOCOUNT ON     
    
 DECLARE @UniqueConfigurationIds VARCHAR(MAX);    
 SELECT @UniqueConfigurationIds = Item.GetActiveConfigurations(@BenefitTypeId)    
    
 SELECT     
  IT.ImagePath,    
  IT.BenefitTypeId,    
  IT.ItemId,     
  IT.Name as ItemName,     
  CAT.Name as  Category,     
  SCAT.Name as  SubCategory,    
  PT.Name as ProductType,    
  BR.Name as Brand,    
  Case When ITT.Name ='CROS' 
  THEN 'Accessory'
  ELSE ITT.Name
  End as ItemType,    
  C.CogsPrice,    
  C.EffectiveFrom,    
  IT.IsActive    
      
 FROM Item.Items IT    
 JOIN PM.Brands BR ON IT.BrandId = BR.BrandId AND BR.IsActive = 1 AND IT.BenefitTypeId = @BenefitTypeId  
  
 JOIN Item.Mapping HAI on HAI.ItemId = IT.ItemId  and BenefitTypeId = 1   
 JOIN PM.Category CAT on CAT.CategoryId = HAI.CategoryId AND HAI.IsActive = 1    
 JOIN PM.SubCategory SCAT on SCAT.SubCategoryId = HAI.SubCategoryId  AND SCAT.IsActive = 1    
 JOIN PM.ProductTypes PT on PT.ProductTypeId = HAI.ProductTypeId AND PT.IsActive = 1    
 JOIN PM.ItemTypes ITT ON IT.ItemTypeId = ITT.ItemTypeId AND ITT.IsActive = 1    
 LEFT JOIN item.Configurations C ON C.ItemId = IT.ItemId AND C.IsActive = 1    
 WHERE (C.ConfigurationId in (SELECT [Value] FROM string_split(@UniqueConfigurationIds,','))    
 OR C.EffectiveFrom IS NULL)    
    
 END     
  




GO
/****** Object:  StoredProcedure [Item].[GetBrandWiseItemCount]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                   
===================================================================================================                                
Created by    : Sravani G                                        
Description   : used to get the Brands with ItemsCount         
Create on     : 04-Jun-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===================================================================================================              
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
How to Exec   : exec [Item].[GetBrandWiseItemCount]        
===================================================================================================                
*/
CREATE
	

 PROCEDURE [Item].[GetBrandWiseItemCount]
AS
BEGIN
	SELECT br.BrandId AS BrandId
		,br.[Name] AS BrandName
		,count(it.itemId) AS ItemsCount
	FROM [Item].[Items] it
	JOIN [PM].[Brands] br ON Br.BrandId = it.BrandId
	JOIN Item.Mapping HAI on HAI.ItemId = IT.ItemId  and BenefitTypeId = 1 
	JOIN [Item].[Configurations] itcon ON it.ItemId = itcon.ItemId
	WHERE it.ItemTypeId=1
	     AND(GETDATE() BETWEEN EffectiveFrom
				AND EffectiveTo
			)
		AND br.IsActive = 1
		AND it.IsActive = 1
		AND itcon.IsActive = 1
	GROUP BY br.BrandId
		,br.[Name]
END
GO
/****** Object:  StoredProcedure [Item].[GetCategoriesByBrandId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                   
===================================================================================================                                
Created by    : Sravani G                                        
Description   : used to get the Categories with ItemsCount By BrandId        
Create on     : 04-Jun-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===================================================================================================              
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
How to Exec   : exec [Item].[GetCategoriesByBrandId]  '1, 2'  
===================================================================================================                
*/
CREATE
	

 PROCEDURE [Item].[GetCategoriesByBrandId] (@brandId VARCHAR(Max))
AS
BEGIN
	SELECT br.BrandId AS BrandId
		,cat.CategoryId AS CategoryId
		,cat.[Name] AS CategoryName
		,count(itm.itemId) AS ItemsCount
	FROM [Item].[Items] it
	JOIN [Item].[Mapping] itm ON it.ItemId = itm.ItemId
	JOIN [PM].[Brands] br ON br.BrandId = it.BrandId
	JOIN PM.Category cat ON cat.CategoryId = itm.CategoryId
	JOIN [Item].[Configurations] itcon ON it.ItemId = itcon.ItemId
	WHERE (
			GETDATE() BETWEEN EffectiveFrom
				AND EffectiveTo
			)
		AND itm.IsActive = 1
		AND cat.IsActive = 1
		AND it.Isactive = 1
		AND itcon.Isactive = 1
		AND br.brandId IN (
			SELECT VALUE
			FROM STRING_SPLIT(replace(@brandId, '''', ''), ',')
			)
	GROUP BY br.BrandId
		,cat.CategoryId
		,cat.[Name]
END
GO
/****** Object:  StoredProcedure [Item].[GetImagesByItemId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                  
Description   : used to get the Images for item configuration     
Create on     : 09-May-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : 
exec Item.GetImagesByItemId 22      
===================================================================================================        
*/   
  
CREATE PROC [Item].[GetImagesByItemId]  
(  
@ItemId INT   
)  
As  
Begin  

SET NOCOUNT ON

SELECT 
ImageId,
ImagePath,
ItemId,
Direction,
ISNULL(Size,'') AS Size,
'' AS Base64String
FROM Item.Images  
WHERE ItemId = @ItemId AND IsActive = 1

END
GO
/****** Object:  StoredProcedure [Item].[GetItemConfigurationsByItemId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*                               
===================================================================================================                            
Created by    : Rafi Ahmmed Shaik                                      
Description   : used to get the item configurations         
Create on     : 03-May-2024                                      
Used in       : Pricing Manager Serivce                                       
===================================================================================================                            
History:               
===========================================================================================             
Modified by         :             
Modified on         :             
Description         :             
===================================================================================================                            
How to Exec   : exec [Item].[GetItemConfigurationsByItemId]  2         
===================================================================================================            
*/      
    
CREATE PROC [Item].[GetItemConfigurationsByItemId]      
(      
@ItemId INT       
)      
As      
Begin      
    
SET NOCOUNT ON    
    
SELECT ROW_NUMBER() OVER (ORDER BY CG.ItemId) AS RowNumber,    
    CG.ConfigurationId,    
 CG.ItemId,    
 CG.DisplayName,    
 CG.EffectiveFrom,    
 CG.CogsPrice,    
 CG.ModifiedBy,    
 CG.ModifiedDate,    
 CASE       
        WHEN CG.EffectiveTo < CONVERT(date, GETDATE()) THEN 'Expired'      
        WHEN CG.EffectivefROM > CONVERT(date, GETDATE()) THEN 'Upcoming'      
        ELSE 'Current'      
    END AS [Status],    
 CG.Attachment    
 FROM       
    Item.Configurations AS CG      
    INNER JOIN       
    Item.Items AS IT ON CG.ItemId = IT.ItemId --AND IT.IsActive = 1    
 WHERE       
    IT.ItemId = @ItemId    
    AND CG.IsActive = 1    
 ORDER BY       
    CG.EffectiveFrom DESC      
    
End    
GO
/****** Object:  StoredProcedure [Item].[GetItemsByCategoryId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                     
===================================================================================================                                  
Created by    : Sravani G                                          
Description   : used to get the HearingItems By CategoryId          
Create on     : 04-Jun-2024                                            
Used in       : Pricing Manager Serivce                                             
===================================================================================================                                  
History:                     
===================================================================================================                
Modified by         :                   
Modified on         :                   
Description         :                   
===================================================================================================                                  
How to Exec   : exec [Item].[GetItemsByCategoryId]  '4','49'   
===================================================================================================                  
*/  
CREATE     PROCEDURE [Item].[GetItemsByCategoryId] (@brandId VARCHAR(Max),@categoryId VARCHAR(Max))  
AS  
BEGIN  
 SELECT IT.ItemId as ItemId, IT.[Name] as ItemName,scat.[Name] as  SubCategory,PT.[Name] as ProductType,it.[BrandId] as BrandId,cat.[CategoryId] as CategoryId  
FROM [Item].[Items] it  
JOIN [Item].[Mapping] itm ON itm.ItemId=it.ItemId  AND it.IsActive = 1 AND it.BenefitTypeId = 1
JOIN [PM].[Category] cat ON itm.CategoryId=cat.CategoryId  
JOIN PM.SubCategory scat on scat.SubCategoryId = itm.SubCategoryId         
JOIN PM.ProductTypes PT on PT.ProductTypeId = itm.ProductTypeId   
WHERE cat.CategoryId IN (SELECT VALUE FROM STRING_SPLIT(replace(@categoryId, '''', ''), ','))  
     AND it.ItemTypeId = 1  
  AND itm.IsActive = 1  
  AND cat.IsActive = 1  
        AND scat.IsActive = 1   
     AND PT.IsActive = 1    
  --AND cat.CategoryId IN (  
  -- SELECT VALUE  
  -- FROM STRING_SPLIT(replace(@categoryId, '''', ''), ',')  
  -- )
    AND  it.BrandId IN (   
   SELECT VALUE  
   FROM STRING_SPLIT(replace(@brandId, '''', ''), ',')  
   ) 
END
GO
/****** Object:  StoredProcedure [Item].[GetItemsCountByCategoryId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                   
===================================================================================================                                
Created by    : Sravani G                                        
Description   : used to get the Categories with ItemsCount         
Create on     : 04-Jun-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===================================================================================================              
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
How to Exec   : exec [Item].[GetItemsCountByCategoryId]  '1,4,7'      
===================================================================================================                
*/ 
CREATE    PROCEDURE [Item].[GetItemsCountByCategoryId]
(
@categoryId varchar(Max)
) 
       
AS      
BEGIN 

--declare @ids varchar(max)=replace(@categoryId,'''','')
select c.CategoryId as CategoryId,c.[Name] as CategoryName,Count(itemId) as ItemsCount
from [Item].[Mapping] itm
Join [PM].[Category] c on itm.CategoryId=c.CategoryId
where itm.IsActive=1
and c.IsActive=1
and c.CategoryId in (SELECT value FROM STRING_SPLIT(replace(@categoryId,'''',''), ','))
group by c.CategoryId,c.[Name]

END
GO
/****** Object:  StoredProcedure [Item].[GetMealsItemsByCategoryId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                               
===================================================================================================                            
Created by    : NareshS          
Description   : used to get the Meals Items by Diet Restiction (Category)          
Create on     : 21-May-2024                                      
Used in       : Pricing Manager Serivce                                       
===================================================================================================                            
History:               
===========================================================================================             
Modified by         : Arun Kulkarni            
Modified on         : 06/05/2024            
Description         : To exclude allergens and exclusions             
===================================================================================================                            
How to Exec   : Exec [Item].[GetMealsItemsByCategoryId] 'General Wellness','Tree Nuts','Turkey','0'        
===================================================================================================             
Additional notes: Items with the selected allergens, exclusions, spicelevel will be excluded.       
For eg: If from UI/API - Milk is passed as allergen, this procedure will return items that dont have milk as allergen.( will exclude items with milk as allergen)      
*/         
      
CREATE    PROC [Item].[GetMealsItemsByCategoryId](        
@Category VARCHAR(100),        
@Allergens VARCHAR(100) = NULL,        
@Exclusions VARCHAR(100) = NULL,        
@SpiceLevel VARCHAR(100) = NULL        
)        
AS        
BEGIN        
             
IF  (@SpiceLevel='')      
BEGIN      
SET @SpiceLevel=Null      
END      
SELECT ROW_NUMBER() OVER(order by ItemCode) RowId, *        
FROM (        
  SELECT DISTINCT I.ItemId ItemCode, I.Name AS ItemName, I.SKUCode AS UPC, I.ImagePath,        
  C.CategoryId, C.Name AS Category,        
  C.Description AS [Description],        
  P_Rank.Value AS [Rank],        
  P_Record.Value AS [RecordId],        
  P_Kitchen.Value AS [KitchenCode],        
  P_Spice.Value AS SpiceLevel,        
  PT.Name AS MealPeriod,        
  [PM].[GetDistinctValues] (STRING_AGG(P_Allergens.Value,',')) AS Allergens,        
  [PM].[GetDistinctValues] (STRING_AGG(P_Exclusions.Value,',')) AS Exclusions,         
  [PM].[GetDistinctValues] (STRING_AGG(P_QBCode.Value,',')) AS [QBCode]        
        
  FROM item.Items I        
  JOIN Item.Mapping M ON I.itemid = M.ItemId         
   AND I.BenefitTypeId = 2 AND I.IsActive=1 AND M.IsActive=1        
  JOIN PM.Category C ON C.CategoryId = M.CategoryId         
   AND C.IsActive=1        
  JOIN PM.ProductTypes PT ON PT.ProductTypeId = M.ProductTypeId        
  LEFT JOIN Item.Properties P_Allergens ON P_Allergens.ItemId = I.ItemId        
   AND P_Allergens.PropertyTypeId = 2 --'Allergens'        
  LEFT JOIN Item.Properties P_Exclusions ON P_Exclusions.ItemId = I.ItemId        
   AND P_Exclusions.PropertyTypeId = 3 --'Exclusions'        
  LEFT JOIN Item.Properties P_Spice ON P_Spice.ItemId = I.ItemId        
   AND P_Spice.PropertyTypeId = 4 --'Spice Level'        
  LEFT JOIN Item.Properties P_Rank ON P_Rank.ItemId = I.ItemId        
   AND P_Rank.PropertyTypeId = 1 --'Rank'        
  LEFT JOIN Item.Properties P_Record ON P_Record.ItemId = I.ItemId        
   AND P_Record.PropertyTypeId = 19 --'Record'        
  LEFT JOIN Item.Properties P_Kitchen ON P_Kitchen.ItemId = I.ItemId        
   AND P_Kitchen.PropertyTypeId = 18 --'Kitchen Code'        
  LEFT JOIN Item.Properties P_QBCode ON P_QBCode.ItemId = I.ItemId        
   AND P_QBCode.PropertyTypeId = 20 --'Quick Base Code'        
  WHERE 1=1         
  AND ((C.[Name] = @Category) OR (C.Name = 'Shakes' and I.Name = @Category))        
  AND P_Spice.[Value] = ISNULL(@SpiceLevel, P_Spice.Value)        
  Group BY I.ItemId, I.Name, I.SKUCode, I.ImagePath, C.CategoryId, C.Name, C.Description, P_Rank.Value, P_Record.Value, P_Kitchen.Value, P_Spice.Value, PT.Name        
  ) AS T        
ORDER by ItemCode        
END 
GO
/****** Object:  StoredProcedure [Item].[GetMealsItemsByCategoryId_opt]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [Item].[GetMealsItemsByCategoryId_opt](
    @Category VARCHAR(100),
    @SpiceLevel VARCHAR(100) = NULL
)
AS
BEGIN
    DECLARE @SpiceFilter VARCHAR(100)

    -- Set Spice Filter
    IF @SpiceLevel = ''
        SET @SpiceFilter = NULL
    ELSE
        SET @SpiceFilter = @SpiceLevel

    ;WITH ItemProperties AS (
        SELECT 
            I.ItemId AS ItemCode, 
            STRING_AGG(CASE WHEN P.PropertyTypeId = 2 THEN P.Value END, ',') AS Allergens,
            STRING_AGG(CASE WHEN P.PropertyTypeId = 3 THEN P.Value END, ',') AS Exclusions,
            MAX(CASE WHEN P.PropertyTypeId = 4 THEN P.Value END) AS SpiceLevel
        FROM 
            item.Items AS I
        JOIN 
            Item.Mapping AS M ON I.itemid = M.ItemId
        JOIN 
            PM.Category AS C ON C.CategoryId = M.CategoryId
        LEFT JOIN 
            Item.Properties AS P ON P.ItemId = I.ItemId
        WHERE 
            (C.[Name] = @Category OR (C.Name = 'Shakes' AND I.Name = @Category))
            AND I.BenefitTypeId = 2 
            AND I.IsActive = 1 
            AND M.IsActive = 1 
            AND C.IsActive = 1
        GROUP BY 
            I.ItemId
    )
    
    SELECT 
        ROW_NUMBER() OVER(ORDER BY IP.ItemCode) AS RowId,
        IP.ItemCode,
        I.Name AS ItemName,
        I.SKUCode AS UPC,
        I.ImagePath,
        C.CategoryId,
        C.Name AS Category,
        C.Description AS [Description],
        P_Rank.Value AS [Rank],
        P_Record.Value AS [RecordId],
        P_Kitchen.Value AS [KitchenCode],
        IP.SpiceLevel,
        PT.Name AS MealPeriod,
        IP.Allergens,
        IP.Exclusions
    FROM 
        ItemProperties AS IP
    JOIN 
        item.Items AS I ON IP.ItemCode = I.ItemId
    JOIN 
        Item.Mapping AS M ON I.itemid = M.ItemId
    JOIN 
        PM.Category AS C ON C.CategoryId = M.CategoryId
    JOIN 
        PM.ProductTypes AS PT ON PT.ProductTypeId = M.ProductTypeId
    LEFT JOIN 
        Item.Properties AS P_Rank ON P_Rank.ItemId = I.ItemId AND P_Rank.PropertyTypeId = 1 --'Rank'
    LEFT JOIN 
        Item.Properties AS P_Record ON P_Record.ItemId = I.ItemId AND P_Record.PropertyTypeId = 19 --'Record'
    LEFT JOIN 
        Item.Properties AS P_Kitchen ON P_Kitchen.ItemId = I.ItemId AND P_Kitchen.PropertyTypeId = 18 --'Kitchen Code'
    WHERE 
        IP.SpiceLevel = ISNULL(@SpiceFilter, IP.SpiceLevel)
    ORDER BY 
        IP.ItemCode;
END
GO
/****** Object:  StoredProcedure [Item].[GetPropertiesByItemId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                  
Description   : used to get the item properties   
Create on     : 07-May-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : 

exec Item.GetPropertiesByItemId 49     
===================================================================================================        
*/   
  
CREATE PROC [Item].[GetPropertiesByItemId]  
(  
@ItemId INT   
)  
As  
Begin  

SELECT 
    PR.Id AS PropertyId,
    PR.ItemId,
    PT.Name AS PropertyTypeName,
    PT.DisplayName,
    PT.Description,
    PR.Value
FROM 
    Item.Properties PR
JOIN 
    PM.PropertyTypes PT 
    ON PR.PropertyTypeId = PT.PropertyTypeId AND PT.IsActive = 1
WHERE 
    PR.ItemId = @ItemId AND PR.IsActive = 1
ORDER BY 
PT.PropertyTypeId


END 
GO
/****** Object:  StoredProcedure [Item].[GetTemplateLevelItemsAndCOGSPrices]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                         
===================================================================================================                                      
Created by    : Naresh S                                               
Description   : used to get the Get Item Levels And COGSPrices                 
Create on     : 22-May-2024                                                
Used in       : Pricing Manager Serivce                                                 
===================================================================================================                                      
History:                         
===================================================================================================                    
Modified by         :                       
Modified on         :                       
Description         :                       
===================================================================================================                                      
How to Exec   :   
exec ITEM.GetTemplateLevelItemsAndCOGSPrices 80,102,87
===================================================================================================                      
*/            
CREATE     PROCEDURE [Item].[GetTemplateLevelItemsAndCOGSPrices] (            
 @TemplateId INT,            
 @ConfigurationId INT,            
 @LevelConfigurationId BIGINT            
 )            
AS            
BEGIN
    DECLARE @PrevLevelConfigurationId BIGINT = 0
    DECLARE @RowId INT = 0
    DECLARE @Date DATETIME = GETDATE()
    DECLARE @StartPrice DECIMAL(10,2) = 0.00
    DECLARE @EndPrice DECIMAL(10,2) = 0.00

    IF EXISTS (SELECT TOP 1 1 
               FROM Template.Configurations 
               WHERE ConfigurationId = @ConfigurationId 
                 AND GETDATE() > EffectiveTo)
    BEGIN
        SELECT TOP 1 @Date = EffectiveTo 
        FROM Template.Configurations 
        WHERE ConfigurationId = @ConfigurationId
    END
    ELSE IF EXISTS (SELECT TOP 1 1 
                    FROM Template.Configurations 
                    WHERE ConfigurationId = @ConfigurationId 
                      AND GETDATE() < EffectiveFrom)
    BEGIN
        SELECT TOP 1 @Date = EffectiveFrom 
        FROM Template.Configurations 
        WHERE ConfigurationId = @ConfigurationId
    END

    SELECT @EndPrice = ThresholdPrice 
    FROM [Template].[LevelConfigurations] 
    WHERE LevelConfigurationId = @LevelConfigurationId 
      AND IsActive = 1;

    WITH CTE1 AS (
        SELECT ROW_NUMBER() OVER (ORDER BY LevelConfigurationId) AS RowId, 
               LevelConfigurationId, 
               ThresholdPrice 
        FROM [Template].[LevelConfigurations] 
        WHERE ConfigurationId = @ConfigurationId 
          AND IsActive = 1
    )
    SELECT TOP 1 @RowId = RowId, 
                 @PrevLevelConfigurationId = LevelConfigurationId, 
                 @StartPrice = ThresholdPrice + 0.1 
    FROM CTE1
    WHERE LevelConfigurationId < @LevelConfigurationId
    ORDER BY RowId DESC;

    SELECT I.ItemId,
           I.Name AS ItemName,
           @ConfigurationId AS ConfigurationId,
           IT.Name AS ItemType,
           C.CogsPrice AS CogsPrice,
           @LevelConfigurationId AS LevelConfigurationId,
           CAT.Name AS Category,
           SC.Name AS SubCategoryName,
           PT.Name AS ProductType,
           @TemplateId AS TemplateId,
           0 AS levelItemCount,
           ISNULL(TL.[Name], '') AS [level],
           CAST(0 AS BIT) AS IsOverride,
           '' AS FromLevel,
           '' AS OverRideBy,
           GETDATE() AS OverrideDate,
           ISNULL(LC_FFEE.ThresholdPrice, 0) AS FittingFee,
           C.DisplayName AS DisplayName,
           STRING_AGG(I2.Name, ', ') AS Accessories
    FROM Item.Items I
    JOIN Item.Configurations C ON I.ItemId = C.ItemId AND C.IsActive = 1
    JOIN PM.ItemTypes IT ON IT.ItemTypeId = I.ItemTypeId AND IT.IsActive = 1
    JOIN Item.Mapping M ON M.ItemId = I.ItemId AND M.IsActive = 1
    JOIN PM.Category CAT ON CAT.CategoryId = M.CategoryId AND CAT.IsActive = 1
    JOIN PM.ProductTypes PT ON PT.ProductTypeId = M.ProductTypeId AND PT.IsActive = 1
    JOIN PM.SubCategory SC ON SC.SubCategoryId = M.SubCategoryId AND SC.IsActive = 1
    JOIN [Template].[LevelConfigurations] LC ON LC.LevelConfigurationId = @LevelConfigurationId AND LC.IsActive = 1 AND LC.ConfigurationId = @ConfigurationId AND LC.ThresholdTypeId = 1
    JOIN [PM].[TechnologyLevels] TL ON TL.Id = LC.TechnologyId AND TL.IsActive = 1
    LEFT JOIN [Template].[LevelConfigurations] LC_FFEE ON LC_FFEE.LinkLevelConfigurationId = @LevelConfigurationId AND LC_FFEE.IsActive = 1 AND LC_FFEE.ConfigurationId = @ConfigurationId AND LC_FFEE.ThresholdTypeId = 2
    LEFT JOIN [Item].[AccessoryMapping] AM ON AM.ItemId = I.ItemId AND AM.IsActive = 1
    LEFT JOIN Item.Items I2 ON AM.AccessoryItemId = I2.ItemId
    WHERE I.IsActive = 1
      AND C.CogsPrice BETWEEN @StartPrice AND @EndPrice
      AND @Date BETWEEN C.EffectiveFrom AND C.EffectiveTo
      AND I.ItemId NOT IN (SELECT ItemId 
                           FROM Template.TemplateLevelItemOverrides 
                           WHERE ConfigurationId = @ConfigurationId 
                             AND (FromLevelConfigurationId = @LevelConfigurationId OR TOLevelConfigurationId = @LevelConfigurationId))
    GROUP BY I.ItemId, I.Name, IT.Name, C.CogsPrice, CAT.Name, SC.Name, PT.Name, C.DisplayName, TL.Name, LC_FFEE.ThresholdPrice

    UNION ALL

    SELECT I.ItemId,
           I.Name AS ItemName,
           @ConfigurationId AS ConfigurationId,
           IT.Name AS ItemType,
           C.CogsPrice AS CogsPrice,
           @LevelConfigurationId AS LevelConfigurationId,
           CAT.Name AS Category,
           SC.Name AS SubCategoryName,
           PT.Name AS ProductType,
           @TemplateId AS TemplateId,
           0 AS levelItemCount,
           ISNULL(TL_To.[Name], '') AS [level],
           CAST(1 AS BIT) AS IsOverride,
           ISNULL(TL_From.[Name], '') AS FromLevel,
           O.ModifiedBy AS OverRideBy,
           O.ModifiedDate AS OverrideDate,
           ISNULL(LC_FFEE.ThresholdPrice, 0) AS FittingFee,
           C.DisplayName AS DisplayName,
           STRING_AGG(I2.Name, ', ') AS Accessories
    FROM Item.Items I
    JOIN Item.Configurations C ON I.ItemId = C.ItemId AND C.IsActive = 1
    JOIN PM.ItemTypes IT ON IT.ItemTypeId = I.ItemTypeId AND IT.IsActive = 1
    JOIN Item.Mapping M ON M.ItemId = I.ItemId AND M.IsActive = 1
    JOIN PM.Category CAT ON CAT.CategoryId = M.CategoryId AND CAT.IsActive = 1
    JOIN PM.ProductTypes PT ON PT.ProductTypeId = M.ProductTypeId AND PT.IsActive = 1
    JOIN PM.SubCategory SC ON SC.SubCategoryId = M.SubCategoryId AND SC.IsActive = 1
    JOIN Template.TemplateLevelItemOverrides O ON O.ItemId = I.ItemId AND O.ToLevelConfigurationId = @LevelConfigurationId AND O.ConfigurationId = @ConfigurationId
    JOIN [Template].[LevelConfigurations] LC_To ON LC_To.LevelConfigurationId = O.ToLevelConfigurationId AND LC_To.IsActive = 1 AND LC_TO.ConfigurationId = @ConfigurationId AND LC_To.ThresholdTypeId = 1
    JOIN [Template].[LevelConfigurations] LC_From ON LC_From.LevelConfigurationId = O.FromLevelConfigurationId AND LC_From.IsActive = 1 AND LC_FROM.ConfigurationId = @ConfigurationId AND LC_From.ThresholdTypeId = 1
    JOIN [PM].[TechnologyLevels] TL_To ON TL_To.Id = LC_To.TechnologyId AND TL_To.IsActive = 1
    JOIN [PM].[TechnologyLevels] TL_From ON TL_From.Id = LC_From.TechnologyId AND TL_From.IsActive = 1
    LEFT JOIN [Template].[LevelConfigurations] LC_FFEE ON LC_FFEE.LinkLevelConfigurationId = @LevelConfigurationId AND LC_FFEE.IsActive = 1 AND LC_FFEE.ConfigurationId = @ConfigurationId AND LC_FFEE.ThresholdTypeId = 2
    LEFT JOIN [Item].[AccessoryMapping] AM ON AM.ItemId = I.ItemId AND AM.IsActive = 1
    LEFT JOIN Item.Items I2 ON AM.AccessoryItemId = I2.ItemId
    WHERE I.IsActive = 1 AND O.IsActive = 1
      AND @Date BETWEEN C.EffectiveFrom AND C.EffectiveTo
    GROUP BY I.ItemId, I.Name, IT.Name, C.CogsPrice, CAT.Name, SC.Name, PT.Name, C.DisplayName, TL_To.Name, TL_From.Name, LC_FFEE.ThresholdPrice, O.ModifiedBy, O.ModifiedDate
    ORDER BY CogsPrice, ItemName
END;
  
  
  
GO
/****** Object:  StoredProcedure [Item].[SaveItemConfigration]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                               
===================================================================================================                            
Created by    : Sravani G                                     
Description   : used to save item configration information          
Create on     : 01-May-2024                                      
Used in       : Pricing Manager Serivce                                       
===================================================================================================                            
History:               
===========================================================================================             
Modified by         :             
Modified on         :             
Description         :             
===================================================================================================                            
How to Exec   : Exec [Item].[SaveItemConfigration] 8,'Starkey Evolv AI 1000 NW CICs','Test Record',1580.00,'','2024-05-01','Jack Smith'           
===================================================================================================                            
*/      
CREATE         
       
      
 PROCEDURE [Item].[SaveItemConfigration] (      
 @ItemId BIGINT      
 ,@DisplayName VARCHAR(50)      
 ,@Reason VARCHAR(100)      
 ,@CogsPrice DECIMAL(10, 2)      
 ,@Attachment VARCHAR(50)      
 ,@EffectiveFrom DATETIME      
 ,@UserName VARCHAR(20)      
 )      
AS      
BEGIN      
 SET NOCOUNT ON      
      
 BEGIN TRY      
  BEGIN TRANSACTION;      
    
 DECLARE @SuccessfullyCreated VARCHAR(500) = 'Item Configration details Saved Successfully'      
 DECLARE @SuccessfullyCreatedCode INT = 200        
          
  BEGIN      
   DECLARE @LatestConfigId BIGINT = 0      
      
   SELECT TOP 1 @LatestConfigId = ConfigurationId      
   FROM Item.Configurations      
   WHERE ItemId = @ItemId      
    AND IsActive = 1      
   ORDER BY ConfigurationId DESC      
      
   IF (ISNULL(@LatestConfigId, 0) > 0)      
   BEGIN      
    UPDATE Item.Configurations      
    SET EffectiveTo = (@EffectiveFrom - 1)      
     ,ModifiedBy = @UserName      
     ,ModifiedDate = GETDATE()      
    WHERE ConfigurationId = @LatestConfigId      
   END      
    BEGIN TRY  
   -- Insert into Item.Configurations           
   INSERT INTO [Item].[Configurations] (      
    ItemId      
    ,DisplayName      
    ,EffectiveFrom      
    ,Reason      
    ,CogsPrice      
    ,Attachment      
    ,CreatedBy      
    ,EffectiveTo      
    ,IsActive      
    ,CreatedDate      
    ,ModifiedBy      
    ,ModifiedDate      
    )      
   SELECT       
    @ItemId      
    ,@DisplayName      
    ,@EffectiveFrom      
    ,@Reason      
    ,@CogsPrice      
    ,NULL      
    ,@UserName      
    ,'2099-12-31'      
    ,1      
    ,GETDATE()      
    ,@UserName      
    ,GETDATE()      
      
   SELECT @SuccessfullyCreated Message      
    ,@SuccessfullyCreatedCode Code     
 END TRY  
 BEGIN CATCH  
 SELECT ERROR_NUMBER() AS ErrorNumber    
        ,ERROR_MESSAGE() AS ErrorMessage;  
 END CATCH  
  END      
      
  COMMIT TRANSACTION;      
 END TRY      
      
 BEGIN CATCH      
  ROLLBACK TRANSACTION;      
      
  throw      
 END CATCH;      
END;
GO
/****** Object:  StoredProcedure [Item].[SaveItemImages]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                               
===================================================================================================                            
Created by    : Sravani G                                     
Description   : used to save item Images        
Create on     : 01-May-2024                                      
Used in       : Pricing Manager Serivce                                       
===================================================================================================                            
History:               
===========================================================================================             
Modified by         :             
Modified on         :             
Description         :             
===================================================================================================                            
How to Exec   :

Exec [Item].[SaveItemImages] 
49
,'[{"ImagePath":"Left.png", "Direction":"Left","Size":"100MB","IsUploaded":false},{"ImagePath":"Right.png", "Direction":"Right","Size":"200MB","IsUploaded":false}]'
,'Sgogulamudi'          
===================================================================================================                            
*/
CREATE PROCEDURE [Item].[SaveItemImages] (
	@ItemId BIGINT
	,@ImageDetails VARCHAR(MAX)
	,@UserName VARCHAR(50)
	)
AS
BEGIN

	BEGIN TRY

		BEGIN TRANSACTION;

		DECLARE @SuccessfullyCreated VARCHAR(500) = 'Item images uploaded successfully'
		DECLARE @SuccessfullyCreatedCode INT = 200

			INSERT INTO [Item].[Images] (
				ItemId
				,ImagePath
				,Direction
				,IsActive
				,CreatedBy
				,CreatedDate
				,ModifiedBy
				,ModifiedDate
				,Size
				,IsUploadedToBlob
				)
			SELECT @ItemId
				,imageDetails.ImagePath
				,imageDetails.Direction
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
				,imageDetails.Size
				,imageDetails.IsUploaded
			FROM OPENJSON(@ImageDetails) WITH (
					ImagePath VARCHAR(100)
					,Direction VARCHAR(20)
					,Size NVARCHAR(100)
					,IsUploaded BIT
					) imageDetails;

			COMMIT TRANSACTION;

			SELECT @SuccessfullyCreated Message
				,@SuccessfullyCreatedCode Code

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;

		THROW
	END CATCH;
END;
GO
/****** Object:  StoredProcedure [Item].[SaveorUpdateAccessoryMappingItems]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                                 
===================================================================================================                              
Created by    : Rafi Ahmmed Shaik                                       
Description   : used to Save or update accessory mapping items information in the following tables            
Create on     : 05-june-2024                                        
Used in       : Pricing Manager Serivce                                         
===================================================================================================                              
History:                 
===========================================================================================               
Modified by         :               
Modified on         :               
Description         :               
===================================================================================================                              
       
Exec [Item].[SaveorUpdateAccessoryMappingItems] 
2, 
'[{"ItemId":1},{"ItemId":2}, {"ItemId":3}]', 
'rafi',
1
===================================================================================================                              
*/
CREATE PROCEDURE [Item].[SaveorUpdateAccessoryMappingItems] (
	@AccessoryItemId BIGINT
	,@ItemIds VARCHAR(MAX)
	,@UserName VARCHAR(50)
	,@IsNewItem BIT
	)
AS
BEGIN
	DECLARE @SuccessfullyCreated VARCHAR(500) = 'Accessories has been mapped successfully'
	DECLARE @SuccessfullyCreatedCode INT = 200
	DECLARE @SuccessfullyUpdated VARCHAR(500) = 'Accessories has been updated successfully'
	DECLARE @Flag BIT;
	-- Temporary table to hold parsed JSON data
	DECLARE @accessoryData TABLE (ItemId BIGINT);

	BEGIN TRY
		BEGIN TRANSACTION;

		-- Set @Flag based on @IsNewItem
		IF @IsNewItem = 1
			SET @Flag = 1;-- Insert
		ELSE
			SET @Flag = 0;-- Update

		-- Insert parsed JSON data into temporary table
		INSERT INTO @accessoryData (ItemId)
		SELECT ItemId
		FROM OPENJSON(@ItemIds) WITH (ItemId BIGINT);

		-- Perform insert or update based on @Flag
		IF @Flag = 1
		BEGIN
			INSERT INTO [Item].[AccessoryMapping] (
				[AccessoryItemId]
				,[ItemId]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				,[ModifiedBy]
				,[ModifiedDate]
				)
			SELECT @AccessoryItemId
				,AD.ItemId
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
			FROM @accessoryData AD
			JOIN Item.Items IT ON IT.ItemId = @AccessoryItemId
			WHERE NOT EXISTS (
					SELECT 1
					FROM Item.AccessoryMapping AM
					WHERE AM.ItemId = AD.ItemId
						AND AM.AccessoryItemId = @AccessoryItemId
						AND AM.IsActive = 1
					);

			COMMIT TRANSACTION;

			SELECT @SuccessfullyCreated Message
				,@SuccessfullyCreatedCode Code
		END
		ELSE
		BEGIN
			UPDATE AM
			SET IsActive = 0
			FROM Item.AccessoryMapping AM
			JOIN @accessoryData AD ON AM.ItemId = AD.ItemId
			WHERE AM.AccessoryItemId = @AccessoryItemId
				AND AM.IsActive = 1

			SELECT @SuccessfullyUpdated [Message]
				,@SuccessfullyCreatedCode Code

			COMMIT TRANSACTION;
		END
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;

		THROW
	END CATCH;
END;
GO
/****** Object:  StoredProcedure [Item].[UpdateItemActiveOrInActive]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                           
===================================================================================================                        
Created by    : Praveen Acha                                  
Description   : update to item in-active     
Create on     : 05-17-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : exec [Item].[UpdateItemActiveOrInActive]  1,true,'pacha'      
===================================================================================================        
*/   
  
CREATE    PROC [Item].[UpdateItemActiveOrInActive]
(
@ItemId INT,
@ItemStatus BIT,
@UserName VARCHAR(160),
@Reason VARCHAR(250)
)
AS
BEGIN

	DECLARE @SuccessfullyCreated VARCHAR(500) = 'Item Status Updated Successfully'
	DECLARE @SuccessfullyCreatedCode INT = 200
	DECLARE @ConfigurationDoesNotExits VARCHAR(500) = 'Item id does not exists in the table.'
    DECLARE @ConfigurationDoesNotExitsCode INT = 204

	BEGIN TRY

	IF EXISTS (SELECT TOP 1 * FROM Item.Items WHERE ItemId = @ItemId)

	BEGIN
		UPDATE Item.Items SET IsActive = @ItemStatus,ModifiedBy = @UserName,ModifiedDate = GETDATE(),Reason = @Reason WHERE ItemId = @ItemId

		SELECT @SuccessfullyCreated Message,@SuccessfullyCreatedCode Code
    END

	ELSE

	  SELECT @ConfigurationDoesNotExits Message, @ConfigurationDoesNotExitsCode Code

	END TRY

	BEGIN CATCH
		THROW
	END CATCH;

END
GO
/****** Object:  StoredProcedure [Item].[UpdateItemConfiguration]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                
Description   : update to item configuration    
Create on     : 05-17-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : exec [Item].[UpdateItemConfiguration] 1, 2, 'Hearing', 'Test', 12.22, 'string', '2024-05-20 00:00:00.000', 'script'    
===================================================================================================        
*/   
  
CREATE PROC [Item].[UpdateItemConfiguration]
(
 @ConfigurationId INT
,@ItemId INT
,@DisplayName VARCHAR(50)
,@Reason VARCHAR(250)
,@COGSPrice DECIMAL(10, 2)
,@Attachment VARCHAR(250)    
,@EffectiveFrom DATETIME    
,@UserName VARCHAR(50)
)
AS
BEGIN

  SET NOCOUNT ON 

	DECLARE @ConfigurationUpdatedSuccessMessage VARCHAR(500) = 'Upcoming Configuration edited successfully.'  
	DECLARE @ConfigurationUpdatedCode INT = 200 
	DECLARE @ConfigurationDoesNotExits VARCHAR(500) = 'Only Upcoming configurations will be editable.'
    DECLARE @ConfigurationDoesNotExitsCode INT = 204 

	BEGIN TRY

   DECLARE @LatestConfigId BIGINT = 0      
      
   SELECT TOP 1 @LatestConfigId = ConfigurationId      
   FROM Item.Configurations      
   WHERE ItemId = @ItemId AND EffectiveFrom <= CONVERT(date, GETDATE())     
    AND IsActive = 1      
   ORDER BY ConfigurationId DESC      
      
   IF (ISNULL(@LatestConfigId, 0) > 0)      
   BEGIN      
    UPDATE Item.Configurations      
    SET EffectiveTo = (@EffectiveFrom - 1)      
     ,ModifiedBy = @UserName      
     ,ModifiedDate = GETDATE()      
    WHERE ConfigurationId = @LatestConfigId      
   END      

    IF EXISTS (SELECT TOP 1 * FROM [Item].[Configurations] WHERE ConfigurationId = @ConfigurationId 
	                                                       AND @EffectiveFrom >= CONVERT(date, EffectiveFrom) AND IsActive = 1)
    BEGIN
	

		UPDATE [Item].[Configurations] 
		SET
		DisplayName = @DisplayName,
		Reason = @Reason,
		CogsPrice = @COGSPrice,
		Attachment = @Attachment,
		EffectiveFrom = @EffectiveFrom,
		EffectiveTo =  '2099-12-31',
		ModifiedBy = @UserName,
		ModifiedDate = GETDATE() 
		WHERE ConfigurationId = @ConfigurationId AND IsActive = 1

 		SELECT @ConfigurationUpdatedSuccessMessage Message,@ConfigurationUpdatedCode Code	
    END 

     ELSE
          SELECT @ConfigurationDoesNotExits Message, @ConfigurationDoesNotExitsCode Code

     END TRY

   BEGIN CATCH
      THROW
    END CATCH;

END 
GO
/****** Object:  StoredProcedure [Item].[UpdateItemProperties]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*                           
===================================================================================================                        
Created by    : Praveen Acha                                  
Description   : update item properties     
Create on     : 05-17-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : exec [Item].[UpdateItemProperties]  63,'pacha',1,'test'      
===================================================================================================        
*/   
  
CREATE PROC [Item].[UpdateItemProperties]
(
@ItemId INT,
@UserName VARCHAR(160),
@PropertyId INT,
@Value nvarchar(max)
)
AS
BEGIN

	DECLARE @SuccessfullyCreated VARCHAR(500) = 'Item Property Updated Successfully'
	DECLARE @SuccessfullyCreatedCode INT = 200
	DECLARE @ConfigurationDoesNotExits VARCHAR(500) = 'Item id does not exists in the table.'
    DECLARE @ConfigurationDoesNotExitsCode INT = 204

	BEGIN TRY

	IF EXISTS (SELECT TOP 1 * FROM Item.Properties WHERE ItemId = @ItemId)

	BEGIN

		UPDATE Item.Properties SET [Value] = @Value,ModifiedBy = @UserName,ModifiedDate = GETDATE() WHERE ItemId = @ItemId AND Id = @PropertyId

		SELECT @SuccessfullyCreated Message,@SuccessfullyCreatedCode Code
	END 

	ELSE

	SELECT @ConfigurationDoesNotExits Message, @ConfigurationDoesNotExitsCode Code

	END TRY

	BEGIN CATCH
		THROW
	END CATCH;

END


GO
/****** Object:  StoredProcedure [PM].[GetBenefitTypes]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                       
===================================================================================================                    
Created by    : Abirami.v                              
Description   : used to get Benefit Types information  
Create on     : 22-Apr-2024                              
Used in       : Pricing Manager Serivce                               
===================================================================================================                    
History:       
===========================================================================================     
Modified by         :     
Modified on         :     
Description         :     
===================================================================================================                    
How to Exec   : Exec [PM].[GetBenefitTypes] 0    
===================================================================================================                    
*/    
CREATE PROCEDURE [PM].[GetBenefitTypes] 
(
    @UserId bigint 
)
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON
      
   Select * from  PM.BenefitTypes where IsActive=1 and BenefitTypeId=1
END
GO
/****** Object:  StoredProcedure [PM].[GetLookUpsForMeals]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                     
===================================================================================================                  
Created by    : NareshS
Description   : used to get look up information for Meals
Create on     : 18-May-2024                            
Used in       : Pricing Manager Serivce                             
===================================================================================================                  
History:     
===========================================================================================   
Modified by         :   
Modified on         :   
Description         :   
===================================================================================================                  
How to Exec   : Exec [PM].[GetLookUpsForMeals] 'All1'
===================================================================================================                  
*/  

CREATE PROCEDURE [PM].[GetLookUpsForMeals] (@Type varchar(25))
AS
BEGIN

	SET NOCOUNT ON 

	IF(@Type = 'All')
	BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY [Type]) AS RowId, * FROM(
			SELECT CAST(LookUpId AS INT) AS Id, [Name] AS [Value], MasterType [Type], '' AS [Description] 
			FROM PM.LookUps 
			WHERE MasterType IN ('Allergens','Spice Level') AND IsActive=1

			UNION ALL

			SELECT CAST(CategoryId AS INT) AS Id, [Name] AS [Value], [Type] AS [Type], [Description] 
			FROM PM.Category 
			WHERE [Type] in ('Diet', 'Shakes') AND IsActive=1
		) AS T
	END
	ELSE
	IF(@Type = 'Diet' OR @Type = 'Shakes')
	BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY [Type]) AS RowId, CAST(CategoryId AS INT) AS Id, [Name] AS [Value], [Type] AS [Type], [Description] 
		FROM PM.Category 
		WHERE [Type] = @Type AND IsActive=1
	END
	ELSE
	IF(@Type = 'Allergens' OR @Type = 'Spice Level')
	BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY MasterType) AS RowId, CAST(LookUpId AS INT) AS Id, [Name] AS [Value], MasterType [Type], '' AS [Description] 
		FROM PM.LookUps 
		WHERE MasterType = @Type AND IsActive=1
	END
	ELSE
	BEGIN
		SELECT ROW_NUMBER() OVER (ORDER BY MasterType) AS RowId, CAST(LookUpId AS INT) AS Id, [Name] AS [Value], MasterType [Type], '' AS [Description] 
		FROM PM.LookUps 
		WHERE MasterType = @Type AND IsActive=1
	END

 END 
GO
/****** Object:  StoredProcedure [Template].[DeleteTemplateConfiguration]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                                   
===================================================================================================                                
Created by    : Rafi Ahmmed Shaik                                          
Description   : used to delete the template Configurations               
Create on     : 28-May-2024                                          
Used in       : Pricing Manager Serivce                                           
===================================================================================================                                
History:                   
===========================================================================================                 
Modified by         :                 
Modified on         :                 
Description         :                 
===================================================================================================                                
 exec [Template].[DeleteTemplateConfiguration] 5,4,'valid test','Abi'   
===================================================================================================                                
*/  
CREATE PROCEDURE [Template].[DeleteTemplateConfiguration](  
    @ConfigurationId INT,  
	@TemplateId bigint,
	@Reason VARCHAR(250),
	@UserName VARCHAR(50)
)  
AS  
BEGIN  

	BEGIN TRY
     SET NOCOUNT ON;  

		DECLARE @PreviousEffectiveTo DATETIME;
        -- Step 1: Get the EffectiveTo date of the current record
        SELECT TOP 1 @PreviousEffectiveTo = EffectiveTo
        FROM [Template].[Configurations]
        WHERE ConfigurationId = @ConfigurationId
          AND TemplateId = @TemplateId
          AND IsActive = 1;

        -- Step 2: Update the EffectiveTo date of the previous record
        IF @PreviousEffectiveTo IS NOT NULL
        BEGIN
            UPDATE [Template].[Configurations]
            SET EffectiveTo = @PreviousEffectiveTo
            WHERE ConfigurationId = (
                SELECT TOP 1 ConfigurationId
                FROM [Template].[Configurations]
                WHERE TemplateId = @TemplateId
                  AND ConfigurationId < @ConfigurationId
                  AND IsActive = 1
                ORDER BY ConfigurationId DESC
            );
        END

		-- Step 3: Mark the specified record as inactive
        UPDATE [Template].[Configurations]
        SET IsActive = 0,
            Reason = @Reason,
            ModifiedBy = @UserName,
            ModifiedDate = GETDATE()
        WHERE ConfigurationId = @ConfigurationId
          AND TemplateId = @TemplateId;

        -- Return success message
        DECLARE @ConfigurationDeletedSuccessMessage VARCHAR(500) = 'Upcoming Configuration deleted successfully.';
        DECLARE @ConfigurationDeletedCode INT = 200;
        SELECT @ConfigurationDeletedSuccessMessage AS Message, @ConfigurationDeletedCode AS Code, @ConfigurationId AS Id;  

	END TRY

	BEGIN CATCH
		THROW
	END CATCH;
          
END  

GO
/****** Object:  StoredProcedure [Template].[GetTechnologyLevels]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                 
===================================================================================================                              
Created by    : Abirami.V                                        
Description   : used to get the Technology Levels            
Create on     : 04-June-2024                                        
Used in       : Pricing Manager Serivce                                         
===================================================================================================                              
History:                 
===========================================================================================               
Modified by         :               
Modified on         :               
Description         :               
===================================================================================================                              
       
Exec [Template].[GetTechnologyLevels] 
===================================================================================================                              
*/


CREATE PROCEDURE [Template].[GetTechnologyLevels]
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT *
    FROM PM.TechnologyLevels;
END;


GO
/****** Object:  StoredProcedure [Template].[GetTemplateConfigurationsByTemplateId]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
/*                               
===================================================================================================                            
Created by    : Praveen Acha                                      
Description   : used to get the template configurations         
Create on     : 01-May-2024                                      
Used in       : Pricing Manager Serivce                                       
===================================================================================================                            
History:               
===========================================================================================             
Modified by         :             
Modified on         :             
Description         :             
===================================================================================================                            
How to Exec   : 
exec [Template].[GetTemplateConfigurationsByTemplateId]  28          
===================================================================================================            
*/       
      
CREATE     PROC [Template].[GetTemplateConfigurationsByTemplateId]      
(      
@TemplateId INT       
)      
AS      
BEGIN 

DECLARE @ModifiedBy VARCHAR(100) = ''

IF EXISTS (SELECT TOP 1 1 FROM [Template].[Configurations] WHERE TemplateId = @TemplateId AND IsActive = 1)
BEGIN

	SELECT TOP 1 @ModifiedBy = LC.ModifiedBy FROM Template.Configurations C 
			JOIN Template.Templates T ON T.TemplateId = C.TemplateId AND T.IsActive=1
			JOIN Template.LevelConfigurations AS LC ON C.ConfigurationId = LC.ConfigurationId AND LC.IsActive=1 AND C.IsActive=1
	WHERE T.TemplateId = @TemplateId
	ORDER BY LC.ModifiedDate DESC;
      
	WITH LevelData AS (      
		SELECT       
			LC.ConfigurationId, 
			T.TemplateId,      
			T.Name,      
			C.EffectiveFrom,          
			CASE WHEN C.EffectiveTo < CONVERT(date, GETDATE()) THEN 'Expired'      
				WHEN C.EffectivefROM > CONVERT(date, GETDATE()) THEN 'Upcoming'      
				ELSE 'Current'      
			END AS [Status],
			'[' + STRING_AGG(
			
			CONCAT(      
					'{"LevelName": "', LC.LevelName,'", "ThresholdTypeId": "', LC.ThresholdTypeId,'", "ThreshHoldPrice": "', LC.ThresholdPrice,'", "TechnologyId": "', LC.TechnologyId,'","TechnologyName": "', TL.[Name], '","LevelConfigurationId": "', LC.LevelConfigurationId, '","LinkLevelConfigurationId": "', LC.LinkLevelConfigurationId, '"}'      
				),       
				', '      
			) + ']' AS LevelsJson, 
			@ModifiedBy AS ModifiedBy
		FROM       
			Template.Configurations C 
			JOIN Template.Templates T ON T.TemplateId = C.TemplateId AND T.IsActive=1
			JOIN Template.LevelConfigurations AS LC ON C.ConfigurationId = LC.ConfigurationId AND LC.IsActive=1 AND C.IsActive=1
			JOIN PM.TechnologyLevels AS TL ON TL.Id = LC.TechnologyId AND TL.IsActive = 1
		WHERE T.TemplateId = @TemplateId
		GROUP BY       
			T.TemplateId, T.Name ,LC.ConfigurationId, C.EffectiveFrom, C.EffectiveTo
	)  
	SELECT  ROW_NUMBER() OVER (ORDER BY TemplateId) AS RowNumber, * FROM(
	SELECT DISTINCT           
		TemplateId,
		LD.ConfigurationId,
		Name,      
		EffectiveFrom,      
		LevelsJson,
		[Status],      
		ModifiedBy,
		CAST(1 AS BIT) IsActive
	FROM           
		LevelData AS LD 
	) AS T
	ORDER BY       
		EffectiveFrom DESC
END 
ELSE 
BEGIN
	SELECT TOP 1 @ModifiedBy = LC.ModifiedBy FROM Template.Configurations C 
			JOIN Template.Templates T ON T.TemplateId = C.TemplateId AND T.IsActive=1
			JOIN Template.LevelConfigurations AS LC ON C.ConfigurationId = LC.ConfigurationId AND LC.IsActive=1 --AND C.IsActive=1
	WHERE T.TemplateId = @TemplateId
	ORDER BY LC.ModifiedDate DESC;
      
	WITH LevelData AS (      
		SELECT TOP 1      
			LC.ConfigurationId, 
			T.TemplateId,      
			T.Name,      
			C.EffectiveFrom,          
			CASE WHEN C.EffectiveTo < CONVERT(date, GETDATE()) THEN 'Expired'      
				WHEN C.EffectivefROM > CONVERT(date, GETDATE()) THEN 'Upcoming'      
				ELSE 'Current'      
			END AS [Status],
			'[' + STRING_AGG(      
				CONCAT(      
					'{"LevelName": "', LC.LevelName,'", "ThresholdTypeId": "', LC.ThresholdTypeId,'", "ThreshHoldPrice": "', LC.ThresholdPrice,'", "TechnologyId": "', LC.TechnologyId,'","TechnologyName": "', TL.[Name], '","LevelConfigurationId": "', LC.LevelConfigurationId, '","LinkLevelConfigurationId": "', LC.LinkLevelConfigurationId, '"}'      
				),       
				', '      
			) + ']' AS LevelsJson, 
			@ModifiedBy AS ModifiedBy
		FROM       
			Template.Configurations C 
			JOIN Template.Templates T ON T.TemplateId = C.TemplateId AND T.IsActive=1
			JOIN Template.LevelConfigurations AS LC ON C.ConfigurationId = LC.ConfigurationId AND LC.IsActive=1
			JOIN PM.TechnologyLevels AS TL ON TL.Id = LC.TechnologyId AND TL.IsActive = 1
		WHERE T.TemplateId = @TemplateId
		GROUP BY       
			T.TemplateId, T.Name ,LC.ConfigurationId, C.EffectiveFrom, C.EffectiveTo
	)  
	SELECT  ROW_NUMBER() OVER (ORDER BY TemplateId) AS RowNumber, * FROM(
	SELECT DISTINCT           
		TemplateId,
		LD.ConfigurationId,
		Name,      
		EffectiveFrom,      
		LevelsJson,
		[Status],      
		ModifiedBy,
		CAST(0 AS BIT) IsActive
	FROM           
		LevelData AS LD 
	) AS T
	ORDER BY       
		EffectiveFrom DESC 
END
     
END
GO
/****** Object:  StoredProcedure [Template].[GetTemplates]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
/*                             
===================================================================================================                          
Created by    : Naresh S                                    
Description   : used to get Templates information        
Create on     : 19-Apr-2024                                    
Used in       : Pricing Manager Serivce                                     
===================================================================================================                          
History:             
===========================================================================================           
Modified by         :           
Modified on         :           
Description         :           
===================================================================================================                          
How to Exec   : Exec [Template].[GetTemplates] 1, NULL         
===================================================================================================                          
*/            
CREATE     PROCEDURE [Template].[GetTemplates] (            
 @BenefitTypeId INT            
 ,@EffectiveDate DATETIME = NULL            
 )            
AS            
BEGIN            
 SET NOCOUNT ON            
            
 SET @effectiveDate = [dbo].[UDF_Get_Effective_Date](@effectiveDate)        
      
 DECLARE @UniqueConfigurationIds VARCHAR(MAX);      
 SELECT @UniqueConfigurationIds = Template.GetActiveConfigurations(@BenefitTypeId)      
         
 SELECT     
    T.TemplateId,     
    T.[Name],     
    TC.EffectiveFrom,     
    TC.EffectiveTo,    
    CASE WHEN   
   (select COUNT(*) from Template.Configurations where EffectiveFrom > Getdate() and TemplateId = T.TemplateId AND IsActive = 1) > 0   
  THEN CAST(1 AS BIT) ELSE CAST(0 AS BIT) END AS [HasFutureConfig]    
FROM     
    Template.Templates T    
    LEFT JOIN Template.Configurations TC ON T.TemplateId = TC.TemplateId  
WHERE     
    T.BenefitTypeId = @BenefitTypeId        
    AND T.IsActive = 1        
    --AND TC.IsActive = 1      
    AND (TC.ConfigurationId IN (SELECT [Value] FROM STRING_SPLIT(@UniqueConfigurationIds, ',')) OR TC.EffectiveFrom IS NULL)    
ORDER BY     
    T.CreatedDate DESC;     
        
        
END   
  
  
GO
/****** Object:  StoredProcedure [Template].[SaveFittingFeeAndConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                 
===================================================================================================                              
Created by    : Rafi Ahmmed Shaik                                       
Description   : used to save template fitting fee information in the following tables            
Create on     : 27-May-2024                                        
Used in       : Pricing Manager Serivce                                         
===================================================================================================                              
History:                 
===========================================================================================               
Modified by         :               
Modified on         :               
Description         :               
===================================================================================================                              
       
Exec [Template].[SaveFittingFeeAndConfigurations] 1,'test reason',
'{"levels":[{"LevelConfigurationId":"1","LevelName":"Level 1", "ThresholdPrice":"80.21"},{"LevelConfigurationId":"2", "LevelName":"Level 2", "ThresholdPrice":"100.22"} ]}','Script','2'    
===================================================================================================                              
*/
CREATE    PROCEDURE [Template].[SaveFittingFeeAndConfigurations] (
	 @ConfigurationId INT = 0
	,@Reason NVARCHAR(250) = ''
	,@Levels NVARCHAR(MAX)
	,@UserName NVARCHAR(50)
	,@ThresholdType VARCHAR(20)
	)
AS
BEGIN

    DECLARE @SuccessfullyCreated VARCHAR(500) = 'Fitting Fee has been created successfully'
	DECLARE @SuccessfullyCreatedCode INT = 200

	BEGIN TRY
	      BEGIN TRANSACTION;
    

		INSERT INTO [Template].[LevelConfigurations] (
				[ConfigurationId]
				,[LevelName]
				,[ThresholdTypeId]
				,[ThresholdPrice]
				,[Reason]
				,[LinkLevelConfigurationId]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				,[ModifiedBy]
				,[ModifiedDate]
				)
			SELECT @ConfigurationId
				,levels.LevelName
				,@ThresholdType
				,levels.ThresholdPrice
				,@Reason
				,levels.LevelConfigurationId
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
			FROM OPENJSON(@Levels, '$.levels') WITH (
			        LevelConfigurationId INT,
					LevelName VARCHAR(100),
					ThresholdPrice DECIMAL(18, 2)
					) levels;

		SELECT @SuccessfullyCreated Message,@SuccessfullyCreatedCode Code
		COMMIT TRANSACTION;

	END TRY

	BEGIN CATCH
			ROLLBACK TRANSACTION;
		THROW
	END CATCH;

END
GO
/****** Object:  StoredProcedure [Template].[SaveOverrideItemLevelConfiguration]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                     
===================================================================================================                                  
Created by    : Sravani G                                            
Description   : Used to save overrride item level configuration in the following tables                
Create on     : 01-May-2024                                            
Used in       : Pricing Manager Serivce                                             
===================================================================================================                                  
History:                     
==================================================================================================              
Modified by         :                   
Modified on         :                   
Description         :                   
===================================================================================================                                  
           
Exec [Template].[SaveOverrideItemLevelConfiguration] '7,8,2,6000',2,6,2,'Test Override','sgogulamudi'      
===================================================================================================                                  
*/    
CREATE PROCEDURE [Template].[SaveOverrideItemLevelConfiguration] (    
  @ItemId NVARCHAR(MAX)  
 ,@ConfigurationId BIGINT   
 ,@FromLevelConfigurationId INT    
 ,@ToLevelConfigurationId INT    
 ,@Reason NVARCHAR(MAX)    
 ,@UserName NVARCHAR(50)     
 )    
AS    
BEGIN    
  
DECLARE @SuccessfullyCreatedCode INT = 200    
DECLARE @FailedStatusCode INT = 204   
  
SELECT ROW_NUMBER() OVER (  
  ORDER BY Cast(Value AS INT)  
  ) AS 'RowNumber'  
 ,CAST(Value AS INT) AS 'ItemId'  
INTO #OverrideItemsTempTable  
FROM STRING_SPLIT(@ItemId, ',')  
  
DECLARE @ExistingIds VARCHAR(100);  
DECLARE @NotExistingIds VARCHAR(100);  
DECLARE @ItemIdExists TABLE (ExistId INT);  
DECLARE @ItemIdNotExists TABLE (NotExistsId INT);  
DECLARE @flag INT  
  
SET @flag = 1  
  
DECLARE @Id BIGINT = 0  
DECLARE @maxrowNum INT = (  
  SELECT max(RowNumber)  
  FROM #OverrideItemsTempTable  
  )  
  
WHILE (@flag <= @maxrowNum)  
BEGIN  
 SET @Id = (  
   SELECT ItemId  
   FROM #OverrideItemsTempTable  
   WHERE RowNumber = @flag  
   )  
  
 IF (  
   (  
    SELECT ItemId  
    FROM Item.Items  
    WHERE ItemId = @Id  
    ) > 0  
   )  
 BEGIN  
  
 if((select top 1 ItemId from [Template].[TemplateLevelItemOverrides] where ItemId=@Id and ConfigurationId=@ConfigurationId)>0)  
 BEGIN  
 Update [Template].[TemplateLevelItemOverrides]   
 set ToLevelConfigurationId=@ToLevelConfigurationId  
  ,FromLevelConfigurationId=@FromLevelConfigurationId  
  ,Reason=@Reason
  ,ModifiedBy=@UserName  
  ,ModifiedDate=GetDate()  
  WHERE ItemId=@Id  
  and ConfigurationId=@ConfigurationId

  INSERT INTO @ItemIdExists (ExistId)  
  VALUES (@Id);  
 END  
 ELSE  
 BEGIN  
 INSERT INTO [Template].[TemplateLevelItemOverrides] (    
     [ConfigurationId]  
 ,[ItemId]  
 ,[ToLevelConfigurationId]  
 ,[FromLevelConfigurationId]  
 ,[Reason]  
 ,[IsActive]  
 ,[CreatedBy]  
 ,[CreatedDate]  
 ,[ModifiedBy]  
 ,[ModifiedDate]    
    )    
SELECT   
    @ConfigurationId,  
    @Id,  
    @ToLevelConfigurationId,  
    @FromLevelConfigurationId,  
    @Reason,  
    1,  
    @UserName,  
    GETDATE(),  
    @UserName,  
    GETDATE()  
  
  INSERT INTO @ItemIdExists (ExistId)  
  VALUES (@Id);  
 END  
 END  
 ELSE  
 BEGIN  
  INSERT INTO @ItemIdNotExists (NotExistsId)  
  VALUES (@Id);  
 END  
  
 SET @flag += 1;  
END  
  
--The COALESCE() function returns the first non-null value in a list                
SELECT @ExistingIds = COALESCE(@ExistingIds + ',', '') + Cast(ExistId AS VARCHAR(50))  
FROM @ItemIdExists;  
  
SELECT @NotExistingIds = COALESCE(@NotExistingIds + ',', '') + Cast(NotExistsId AS VARCHAR(50))  
FROM @ItemIdNotExists;  
  
IF (  
  @ExistingIds IS NOT NULL  
  AND @NotExistingIds IS NOT NULL  
  )  
BEGIN  
 SELECT 'Item properties overrided successfully for the ItemIds are:' + @ExistingIds + ' and ' + 'Not existing ItemIds are:' + @NotExistingIds AS [Message],  
 @FailedStatusCode as Code  
END  
ELSE IF (  
  @ExistingIds IS NOT NULL  
  AND @NotExistingIds IS NULL  
  )  
BEGIN  
 SELECT 'Item properties overrided successfully for the ItemIds are:' + @ExistingIds AS [Message],  
 @SuccessfullyCreatedCode as Code  
END  
ELSE IF (  
  @NotExistingIds IS NOT NULL  
  AND @ExistingIds IS NULL  
  )  
BEGIN  
 SELECT 'Not existing ItemIds are:' + @NotExistingIds AS [Message],  
 @FailedStatusCode as Code  
END  
  
DROP TABLE #OverrideItemsTempTable  
END
GO
/****** Object:  StoredProcedure [Template].[SaveTemplateAndConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*                                 
===================================================================================================                              
Created by    : Abirami.V                                        
Description   : used to Save Templates information in the following tables            
Create on     : 01-May-2024                                        
Used in       : Pricing Manager Serivce                                         
===================================================================================================                              
History:                 
===========================================================================================               
Modified by         :               
Modified on         :               
Description         :               
===================================================================================================                              
       
Exec [Template].[SaveTemplateAndConfigurations] 
0,
'test reason',
'Template Catelog1',
1,
'2024-06-06',
'{"cogslevels":[{"LevelName":"Level Test 1", "ThresholdPrice":"11.21", "ThresholdTypeId": "1","TechnologyId":"1"} ]}',
'{"fittinglevels":[{"LevelName":"Level Test 1", "ThresholdPrice":"21.21", "ThresholdTypeId": "2","TechnologyId":"1"} ]}', 
'Script',
1,
1  
===================================================================================================                              
*/

CREATE PROCEDURE [Template].[SaveTemplateAndConfigurations] (
	@TemplateId INT = 0
	,@Reason VARCHAR(250) = ''
	,@TemplateName VARCHAR(50)
	,@BenefitTypeId INT
	,@EffectiveFrom DATETIME
	,@CogsLevels VARCHAR(MAX)
	,@FittingLevels VARCHAR(MAX)
	,@UserName VARCHAR(50)
	,@IsDuplicate BIT = 0
	,@SourceTemplateId INT = NULL
	)
AS
BEGIN


	DECLARE @SuccessfullyCreated VARCHAR(500) = 'Template has been created successfully'
	DECLARE @SuccessfullyCreatedCode INT = 200
	DECLARE @AlreadyExixts VARCHAR(500) = 'Template name already exists'
	DECLARE @AlreadyExixtsCode INT = 204
	DECLARE @ConfigurationAlreadyExixts VARCHAR(500) = 'A configuration already exists with these dates'

	BEGIN TRY
		BEGIN TRANSACTION;

		IF EXISTS (
				SELECT TOP 1 1
				FROM Template.Configurations
				WHERE EffectiveFrom = @EffectiveFrom
					AND TemplateId = @TemplateId
					AND IsActive = 1
				)
		BEGIN
			SELECT @ConfigurationAlreadyExixts [Message]
				,@AlreadyExixtsCode Code

			COMMIT TRANSACTION;

			RETURN
		END

		IF (@TemplateId = 0)
		BEGIN
   
			IF EXISTS (
					SELECT TOP 1 1
					FROM Template.Templates
					WHERE Name = @TemplateName
					)
			BEGIN
				SELECT @AlreadyExixts [Message]
					,@AlreadyExixtsCode Code

				COMMIT TRANSACTION;

				RETURN
			END

				INSERT INTO Template.Templates
				(
				[Name],
				BenefitTypeId,
				IsActive,
				CreatedBy,
				CreatedDate,
				ModifiedBy,
				ModifiedDate,
				IsDuplicate,
				SourceTemplateId
				)
				VALUES (
					@TemplateName
					,@BenefitTypeId
					,1
					,@UserName
					,GETDATE()
					,@UserName
					,GETDATE()
					,@IsDuplicate
					,@SourceTemplateId
					);

				SET @TemplateId = SCOPE_IDENTITY();
			
		END

		DECLARE @LatestConfigId BIGINT = 0

		SELECT TOP 1 @LatestConfigId = ConfigurationId
		FROM Template.Configurations
		WHERE TemplateId = @TemplateId
			AND IsActive = 1
		ORDER BY ConfigurationId DESC

		IF (ISNULL(@LatestConfigId, 0) > 0)
		BEGIN
			UPDATE Template.Configurations
			SET EffectiveTo = (@EffectiveFrom - 1)
				,ModifiedBy = @UserName
				,ModifiedDate = GETDATE()
			WHERE ConfigurationId = @LatestConfigId
		END
  
			INSERT INTO [Template].[Configurations] (
				TemplateId
				,Reason
				,EffectiveFrom
				,EffectiveTo
				,IsActive
				,CreatedBy
				,CreatedDate
				,ModifiedBy
				,ModifiedDate
				)
			VALUES (
				@TemplateId
				,@Reason
				,@EffectiveFrom
				,'2099-12-31'
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
				);


		DECLARE @ConfigurationId INT = 0

		SET @ConfigurationId = SCOPE_IDENTITY();

		DECLARE @TempFittingLevels TABLE (
					LevelName VARCHAR(100),
					ThresholdTypeId INT,
					ThresholdPrice DECIMAL(18, 2),
					TechnologyId INT
					);
		
		-- This table refers basically to get the last inserted records for LevelConfigurationId like (1,2,3) table format
		DECLARE @InsertedRecordsForCOGSPrices TABLE (
					LevelConfigurationId INT,
					TechnologyId INT
					);


		INSERT INTO [Template].[LevelConfigurations] (
				[ConfigurationId]
				,[LevelName]
				,[ThresholdTypeId]
				,[ThresholdPrice]
				,[TechnologyId]
				,[Reason]
				,[LinkLevelConfigurationId]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				,[ModifiedBy]
				,[ModifiedDate]
				)
				OUTPUT 
				INSERTED.LevelConfigurationId,
				INSERTED.TechnologyId
			INTO @InsertedRecordsForCOGSPrices
			SELECT @ConfigurationId
				,levels.LevelName
				,levels.ThresholdTypeId
				,levels.ThresholdPrice
				,levels.TechnologyId
				,@Reason
				,NULL
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
			FROM OPENJSON(@CogsLevels, '$.cogslevels') WITH (
			         LevelConfigurationId INT
					,LevelName VARCHAR(100)
					,ThresholdPrice DECIMAL(18, 2)
					,ThresholdTypeId INT
					,TechnologyId INT
					)levels;
					

				INSERT INTO @TempFittingLevels (
							  LevelName
							, ThresholdTypeId
							, ThresholdPrice
							, TechnologyId
							)
							SELECT 
							 levels.LevelName
							,levels.ThresholdTypeId
							,levels.ThresholdPrice
							,levels.TechnologyId

							FROM OPENJSON(@FittingLevels, '$.fittinglevels') WITH (
											 LevelName VARCHAR(100)
											,ThresholdPrice DECIMAL(18, 2)
											,ThresholdTypeId INT
											,TechnologyId INT
											) levels;

		INSERT INTO [Template].[LevelConfigurations] (
				[ConfigurationId]
				,[LevelName]
				,[ThresholdTypeId]
				,[ThresholdPrice]
				,[TechnologyId]
				,[Reason]
				,[LinkLevelConfigurationId]
				,[IsActive]
				,[CreatedBy]
				,[CreatedDate]
				,[ModifiedBy]
				,[ModifiedDate]
				)
			SELECT @ConfigurationId
				,TF.LevelName
				,TF.ThresholdTypeId
				,TF.ThresholdPrice
				,TF.TechnologyId
				,@Reason 
				,CP.LevelConfigurationId
				,1
				,@UserName
				,GETDATE()
				,@UserName
				,GETDATE()
			
				FROM @TempFittingLevels TF
				JOIN @InsertedRecordsForCOGSPrices CP
				ON TF.TechnologyId = CP.TechnologyId;

		COMMIT TRANSACTION;

		SELECT @SuccessfullyCreated Message,@SuccessfullyCreatedCode Code

	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION;

		THROW
	END CATCH;
END;
GO
/****** Object:  StoredProcedure [Template].[UpdateTemplateConfigurations]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                
Description   : update to template configuration    
Create on     : 05-22-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : 

exec [Template].[UpdateTemplateConfigurations] 
28, 
38, 
'praveen reason',  
'2024-09-09',
'{"cogslevels":[{"LevelName":"Level Test 1", "ThresholdPrice":"123.21", "ThresholdTypeId": "1","LevelConfigurationId":"89","TechnologyId":"1"} ]}',
'{"fittinglevels":[{"LevelName":"Level Test 1", "ThresholdPrice":"321.00", "ThresholdTypeId": "2","LevelConfigurationId":"90","TechnologyId":"1"} ]}',
'Script'     
===================================================================================================        
*/
CREATE
	

 PROC [Template].[UpdateTemplateConfigurations] (
	@TemplateId INT
	,@ConfigurationId INT
	,@Reason NVARCHAR(250) = ''
	,@EffectiveFrom DATETIME
	,@CogsLevels VARCHAR(MAX)
	,@FittingLevels VARCHAR(MAX)
	,@UserName NVARCHAR(50)
	)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @ConfigurationUpdatedSuccessMessage VARCHAR(500) = 'Upcoming Configuration updated successfully.'
	DECLARE @ConfigurationUpdatedCode INT = 200

	BEGIN TRY
		DECLARE @LatestConfigId BIGINT = 0

		SELECT TOP 1 @LatestConfigId = ConfigurationId
		FROM Template.Configurations
		WHERE TemplateId = @TemplateId
			AND EffectiveFrom <= CONVERT(DATE, GETDATE())
			AND IsActive = 1
		ORDER BY ConfigurationId DESC

		IF (ISNULL(@LatestConfigId, 0) > 0)
		BEGIN
			UPDATE Template.Configurations
			SET EffectiveTo = (@EffectiveFrom - 1)
				,ModifiedBy = @UserName
				,ModifiedDate = GETDATE()
			WHERE ConfigurationId = @LatestConfigId
		END

		
			UPDATE [Template].[Configurations]
			SET Reason = @Reason
				,EffectiveFrom = @EffectiveFrom
				,EffectiveTo = '2099-12-31'
				,ModifiedBy = @UserName
				,ModifiedDate = GETDATE()
			WHERE ConfigurationId = @ConfigurationId
				AND IsActive = 1

			-- this section to update the cogs prices
			DECLARE @CogsLevelsTable TABLE (
				LevelConfigurationId INT
				,LevelName NVARCHAR(50)
				,ThresholdPrice DECIMAL(18, 2)
				,TechnologyId INT
				);

			INSERT INTO @CogsLevelsTable (
				LevelConfigurationId
				,LevelName
				,ThresholdPrice
				,TechnologyId
				)
			SELECT LevelConfigurationId
				,LevelName
				,ThresholdPrice
				,TechnologyId
			FROM OPENJSON(@CogsLevels, '$.cogslevels') WITH (
					LevelConfigurationId BIGINT
					,LevelName VARCHAR(100)
					,ThresholdPrice DECIMAL(18, 2)
					,TechnologyId INT
					);

			UPDATE LC
			SET LC.ThresholdPrice = CLT.ThresholdPrice
				,LC.Reason = @Reason
				,LC.ModifiedBy = @UserName
				,LC.ModifiedDate = GETDATE()
			FROM [Template].[LevelConfigurations] LC
			JOIN @CogsLevelsTable CLT ON LC.TechnologyId = CLT.TechnologyId
				AND LC.LevelConfigurationId = CLT.LevelConfigurationId
			WHERE LC.ConfigurationId = @ConfigurationId
				AND LC.IsActive = 1
				AND LC.ThresholdTypeId = 1

			-- end
			-- this section to update the fitting fee prices
			DECLARE @FittingFeeLevelsTable TABLE (
				LevelConfigurationId INT
				,LevelName NVARCHAR(50)
				,ThresholdPrice DECIMAL(18, 2)
				,TechnologyId INT
				);

			INSERT INTO @FittingFeeLevelsTable (
				LevelConfigurationId
				,LevelName
				,ThresholdPrice
				,TechnologyId
				)
			SELECT LevelConfigurationId
				,LevelName
				,ThresholdPrice
				,TechnologyId
			FROM OPENJSON(@FittingLevels, '$.fittinglevels') WITH (
					LevelConfigurationId BIGINT
					,LevelName VARCHAR(100)
					,ThresholdPrice DECIMAL(18, 2)
					,TechnologyId INT
					);

			UPDATE LC
			SET LC.ThresholdPrice = FLT.ThresholdPrice
				,LC.Reason = @Reason
				,LC.ModifiedBy = @UserName
				,LC.ModifiedDate = GETDATE()
			FROM [Template].[LevelConfigurations] LC
			JOIN @FittingFeeLevelsTable FLT ON LC.TechnologyId = FLT.TechnologyId
				AND LC.LevelConfigurationId = FLT.LevelConfigurationId
			WHERE LC.ConfigurationId = @ConfigurationId
				AND LC.IsActive = 1
				AND LC.ThresholdTypeId = 2

			-- end
			SELECT @ConfigurationUpdatedSuccessMessage Message
				,@ConfigurationUpdatedCode Code
		
	END TRY

	BEGIN CATCH
		THROW
	END CATCH;
END
GO
/****** Object:  StoredProcedure [Template].[UpdateTemplateName]    Script Date: 6/26/2024 1:18:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*                           
===================================================================================================                        
Created by    : Rafi Ahmmed Shaik                                
Description   : update to template name 
Create on     : 05-17-2024                                  
Used in       : Pricing Manager Serivce                                   
===================================================================================================                        
History:           
===========================================================================================         
Modified by         :         
Modified on         :         
Description         :         
===================================================================================================                        
How to Exec   : exec [Template].[UpdateTemplateName] 1, '4-LevelTemplate', 'script'    
===================================================================================================        
*/   
  
CREATE PROC [Template].[UpdateTemplateName]
(
 @TemplateId INT
,@TemplateName VARCHAR(150)  
,@UserName VARCHAR(50)
)
AS
BEGIN

  SET NOCOUNT ON 

  DECLARE @ConfigurationUpdatedSuccessMessage VARCHAR(500) = 'Template name updated successfully'  
  DECLARE @ConfigurationUpdatedCode INT = 200 
  DECLARE @AlreadyExixts VARCHAR(500) = 'Template name already exists'
  DECLARE @AlreadyExixtsCode INT = 204 
  DECLARE @ConfigurationDoesNotExits VARCHAR(500) = 'Template id does not exists in the table.'
  DECLARE @ConfigurationDoesNotExitsCode INT = 404 

    BEGIN TRY

			-- Checking Template name exists or not     
			IF EXISTS (
					SELECT TOP 1 1
					FROM Template.Templates
					WHERE Name = @TemplateName
					)
			BEGIN
				SELECT @AlreadyExixts [Message]
					,@AlreadyExixtsCode Code

				RETURN
			END

    IF EXISTS (SELECT TOP 1 * FROM [Template].[Templates] WHERE TemplateId = @TemplateId)

	BEGIN

		UPDATE [Template].[Templates] 
		SET
		Name = @TemplateName,
		ModifiedBy = @UserName,
		ModifiedDate = GETDATE()
		WHERE TemplateId = @TemplateId

		SELECT @ConfigurationUpdatedSuccessMessage Message,@ConfigurationUpdatedCode Code
    END

	ELSE
          SELECT @ConfigurationDoesNotExits Message, @ConfigurationDoesNotExitsCode Code

     END TRY

	BEGIN CATCH
		THROW
	END CATCH;
END

GO
