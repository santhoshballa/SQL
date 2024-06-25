/*
In SQL Server, you can extract XML data into a table format using the OPENXML function or the nodes() method of the XML data type. I'll provide examples for both methods:
Using OPENXML function:
The OPENXML function allows you to shred XML data into relational format. It creates a rowset from the XML data that you can insert into a table. However, please note that the OPENXML function is deprecated starting from SQL Server 2005, and it is recommended to use the nodes() method instead. Nevertheless, I'll provide an example for completeness:
sql
Copy code
*/

truncate table FISXML

--DECLARE @xmlData XML =
'<Persons>
    <Person>
        <Name>John</Name>
        <Age>30</Age>
    </Person>
    <Person>
        <Name>Jane</Name>
        <Age>28</Age>
    </Person>
</Persons>';

--DECLARE @idoc INT;

-- Create the internal representation of the XML document
EXEC sp_xml_preparedocument @idoc OUTPUT, @xmlData;

-- Extract XML data into a table
SELECT *
INTO TempTable
FROM OPENXML(@idoc, '/Persons/Person', 2)
WITH (
    Name NVARCHAR(50) 'Name',
    Age INT 'Age'
);

-- Remove the internal representation of the XML document
EXEC sp_xml_removedocument @idoc;

-- Select the data from the TempTable
SELECT * FROM TempTable;



'<Purses>
		<Purse>
			<PerformAction>3</PerformAction>
			<Sub_ProgramName>5739</Sub_ProgramName>
			<PurseName>EFX2300</PurseName>
			<NewPurseName>ZEF2300</NewPurseName>
			<PurseDescription>ZEF2300</PurseDescription>
		</Purse>
</Purses>'


select * from FISXML where FileName  = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done'

DECLARE @xmlData XML
select @xmlData = F1XML from FISXML where FileName  = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done'

DECLARE @idoc INT;

-- Create the internal representation of the XML document
EXEC sp_xml_preparedocument @idoc OUTPUT, @xmlData;

drop table if exists temptable
-- Extract XML data into a table
SELECT *
INTO TempTable
FROM OPENXML(@idoc, '/Batch/Purses/Purse', 10)
WITH (
    PerformAction NVARCHAR(50) 'PerformAction' ,
    Sub_ProgramName NVARCHAR(50) 'Sub_ProgramName' ,
	PurseName NVARCHAR(50) 'PurseName' ,
	IIASGroup nvarchar(50) 'IIASGroup'
);

-- Remove the internal representation of the XML document
EXEC sp_xml_removedocument @idoc;

-- Select the data from the TempTable
SELECT * FROM TempTable;

/*

DECLARE @xmlData XML = '<Books>
    <Book>
        <Title lang = "English">Book 1</Title>
        <Author>Author 1</Author>
    </Book>
    <Book>
        <Title lang = "Hindi">Book 2</Title>
        <Author>Author 2</Author>
    </Book>
    <Book>
        <Title lang = "abracadabra" >Book 3</Title>
        <Author>Author 3</Author>
    </Book>
</Books>'

SELECT
    Book.value('(Title)[1]', 'NVARCHAR(100)') AS Title,
    Book.value('(Author)[1]', 'NVARCHAR(100)') AS Author
FROM @xmlData.nodes('/Books/Book') AS T(Book);



SELECT
    Book.value('(Title)[1]', 'NVARCHAR(100)') AS Title,
    Book.value('(Author)[1]', 'NVARCHAR(100)') AS Author,
    Book.value('(Title)[1]/@lang', 'NVARCHAR(50)') AS Language
FROM @xmlData.nodes('/Books/Book') AS T(Book);

*/


/*
drop table FISXMLExtract
Create table FISXMLExtract
(
FileName nvarchar(max),
NodeName nvarchar(max), 
AttributeName nvarchar(max), 
AttributeValue nvarchar(max), 
NodeValue nvarchar(max)

)




CREATE PROCEDURE dbo.ExtractXmlDataIntoTable
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @XmlData XML;
	DECLARE @FileName NVARCHAR(500);
    DECLARE @TempTable TABLE (
        -- Define columns for extracted data
		FileName NVARCHAR(500),
        NodeName NVARCHAR(100),
        AttributeName NVARCHAR(100),
        AttributeValue NVARCHAR(100),
        NodeValue NVARCHAR(MAX)
    );

    -- Replace 'YourTableName' and 'YourXmlColumn' with actual table and XML column names
    DECLARE XmlCursor CURSOR LOCAL FOR
    SELECT F1XML, FileName
    FROM FISXML where FileName in ('C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart1_060523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazmaxload_053023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndchp_042123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_cardexp6904_040723.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_expdaterewkc_042123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part2_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part20_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part5_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lekmaxload_061223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120614.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurseelevance_062723.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionblocking_part4_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart2_060823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursefix_part1_062823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\EH_XRX_PROD_20230602.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120merchantn051221.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_42423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazcommercialmaxload_053123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_ecommerce_041123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmtid_041823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part25_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part27_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part30_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_041923.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_042023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant0531.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_A2A_070623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ubertesting_071923.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part2_062823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursecreation_071023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefixpart2_071223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionalblocking_part3_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursepart2_061423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otcfodmcc_042123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart2_060523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_051723.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenewal_041823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcexpdaterew22_050123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskciias_051623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_051123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurseotc_040323.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_connecticareemblemexpdate_050123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancenewpackage_060923.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part8_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_mtid_sprout7120.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_otcfodmcc_042023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_presidente_sedanos_052223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elvefx_071023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname_071123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamefilling_v2_nostopshop_072423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemercha_061523 (1).xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmaxload_050823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_sonderrewards_052423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_uber2iterationtest_040323.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept1_041823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\plan_1119.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\file_xml_zpursepart1_061423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_042423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenew_042023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpursept2_040623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_edvelevance_052423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevance_051023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancezpurse_052223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalmcc6362050923.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part11_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part15_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part16_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part17_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part26_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationaltransaction_part1_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvantagemerchantname_040523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamecreation_072123.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_mmo_071023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ouyangtesing_072423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_select_merchantname_070523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part1_062823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_pt2_051723.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid_060523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid35777_060523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantname_060623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_srilaskhmi_052323.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_targetmerchant.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_testing_052323.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart1_060823.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\plan_1121.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_3031zpart2_060623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_a2aprod_040523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcrenamezcsh_040323.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_040723.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internatinationalblocking_part29_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part28_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part32_061623.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part7_061523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadv_test_052423.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvremnetname_040523.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120_prod_051023.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantgroupfixcentralmmo_040323.xml.done')
	and FileName not in 
	(
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done', 
	'C:\NHEligJobs\FIS_XML\DAT\IN\file_xml_zpursepart1_061423.xml.done', 
	'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1119.xml.done',
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept1_041823.xml.done',
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_uber2iterationtest_040323.xml.done',
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_sonderrewards_052423.xml.done',
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmaxload_050823.xml.done',
	'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemercha_061523 (1).xml.done'
	)
	
	OPEN XmlCursor;
    FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
		select @FileName
        INSERT INTO @TempTable ( NodeName, AttributeName, AttributeValue, NodeValue, FileName)
        SELECT
            Node.value('local-name(.)', 'NVARCHAR(100)') AS NodeName,
            Attribute.value('local-name(.)', 'NVARCHAR(100)') AS AttributeName,
            Attribute.value('.', 'NVARCHAR(100)') AS AttributeValue,
            Node.value('.', 'NVARCHAR(MAX)') AS NodeValue,
			@FileName as FileName
        FROM @XmlData.nodes('//*') AS T(Node) -- Get all nodes in the XML document
        OUTER APPLY Node.nodes('@*') AS T2(Attribute); -- Get attributes of each node
		select @FileName
        FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
    END

    CLOSE XmlCursor;
    DEALLOCATE XmlCursor;

    -- Insert the extracted data into a new table
    INSERT INTO FISXMLExtract (FileName, NodeName, AttributeName, AttributeValue, NodeValue)
    SELECT FileName,NodeName, AttributeName, AttributeValue, NodeValue
    FROM @TempTable;
END

select * from FISXMLExtract

select distinct filename from FISXMLExtract

*/
drop table FISXML

select * into FISXML from (
SELECT Filename, STRING_AGG(F1, '')  WITHIN GROUP (ORDER BY ID ASC) as F1XML FROM [dbo].[FISXMLStg] group by FileName
) a


select FileName, len(F1XML) as LengthXML, * from FISXML where F1XML like '%</Batch>%' order by LengthXML desc

select string_agg(FileName, ',') from (

select  (''''+fileName+''''+',') as fileName from FISXML order by FileName
) a

select * from FISXML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done'

update FISXML set F1XML = '<?xml version="1.0" encoding="utf-8"?>
<Batch BusinessPartner="NationsBenefits LLC">
	<MerchantNameLists>
		<MerchantNameList>
			<PerformAction>1</PerformAction>
			<MerchantGroupDescription>NBD IIAS Exception</MerchantGroupDescription>
			<MerchantName>SPROUT%</MerchantName>
			<Category>NH</Category>
		</MerchantNameList>
	</MerchantNameLists>
</Batch>'

where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done'


DECLARE @xmlData XML =
'<Persons>
    <Person>
        <Name>John</Name>
        <Age>30</Age>
    </Person>
    <Person>
        <Name>Jane</Name>
        <Age>28</Age>
    </Person>
</Persons>';

-- Extract XML data into a table
SELECT
    Person.value('Name[1]', 'NVARCHAR(50)') AS Name,
    Person.value('Age[1]', 'INT') AS Age
INTO TempTable
FROM @xmlData.nodes('/Persons/Person') AS T(Person);

-- Select the data from the TempTable
SELECT * FROM TempTable;
Both of these methods will extract the XML data into a temporary table called TempTable in this example. You can replace TempTable with the desired table name to insert the data permanently into a table of your choice. Remember to adjust the column data types accordingly based on your XML structure.




SET NOCOUNT ON;

    DECLARE @XmlData XML;
	DECLARE @FileName NVARCHAR(500);
    DECLARE @TempTable TABLE (
        -- Define columns for extracted data
		FileName NVARCHAR(500),
        NodeName NVARCHAR(100),
        AttributeName NVARCHAR(100),
        AttributeValue NVARCHAR(100),
        NodeValue NVARCHAR(MAX)
    );

    -- Replace 'YourTableName' and 'YourXmlColumn' with actual table and XML column names
    DECLARE XmlCursor CURSOR LOCAL FOR
    SELECT F1XML, FileName
    FROM FISXML where FileName in (
----'C:\NHEligJobs\FIS_XML\DAT\IN\EH_XRX_PROD_20230602.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\file_xml_zpursepart1_061423.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis.xml.fraudmid_053023.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_prod_xml_merchantnameattach_v2_072423.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_3031zpart1_060623.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_3031zpart2_060623.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120merchantn051221.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done'

----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc_061423.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otcfodmcc_042123.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_a2a_051223.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_a2aprod_040523.xml.done'

--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnagoogle_040623.xml.done'
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart1_060523.xml.done',
----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart2_060523.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_042423.xml.done'   -- check this file
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_051723.xml.done'

'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_42423.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenew_042023.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenew7212_050123.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenewal_041823.xml.done'

'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenewal7148.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazcommercialmaxload_053123.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazmaxload_053023.xml.done',
'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbscsh_033123_20230403.xml.done'

	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskc_maxload_maxvalue_051623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskccsh2300_050923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcexpdaterew22_050123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskciias_051623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcrenamezcsh_040323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_ecommerce_041123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentralfod_050123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndchp_042123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndmccreconfig_061223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzotcfod_040623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_040723.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndZpurse_050523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_051123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_051223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurseotc_040323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurseotc_040423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpursept2_040623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_cardexp6904_040723.xml.done',

	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_cchpexpdate_042023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_centralfio_051823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_centralrew22expdate_050123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_connecticareemblemexpdate_050123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_edvelevance_052423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevance_051023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancefix_060823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancenewpackage_060923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancezpurse_052223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancezpurse_052323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_expdaterewkc_042123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fio_050523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fio_051923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fiomerchantgroup_050823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmid_051023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmidblocking_041123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmtid_041823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmtid_050923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalcfo_051023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalmcc_041423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalmcc6362050923.xml.done',

	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_iiasmiss7120_051123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internatinationalblocking_part29_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part10_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part11_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part12_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part13_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part15_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part16_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part17_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part18_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part19_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part2_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part20_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part21_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part22_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part23_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part24_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part25_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part26_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part27_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part28_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part30_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part31_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part32_061623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part5_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part6_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part7_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part8_061523.xml.done',

	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part9_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationaltransaction_part1_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_041923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_042023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lekmaxload_061223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massad_052423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadv_test_052423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvantagemerchantname_040523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvremnetname_040523.xml.done',
	----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant0531.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120_prod_051023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120614.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantgroupfix2centralmmo_040323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantgroupfixcentralmmo_040323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantname_052623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantname_060223.xml.done',
	----'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_mtid_purse7130.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_mtid_sprout7120.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_nationsotc_053023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_nbdibndchpfod_050123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_otcfodmcc_042023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_ouyangtest_051923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_presidente_sedanos_052223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_A2A_070623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_bcom_070623.xml.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_bndcentral_062323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_central_merchantname_062223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elevanceefxv2_071023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_elevancemaxload_062223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elv5984_070223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elvefx_071023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_iiasmissingdata_070723.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname_071123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname_071723.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname7120_072423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamecreation_072123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamefilling_v2_nostopshop_072423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_mmo_071023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_optimarewards_062123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ouyangtesing_072423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_select_merchantname_070523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_selectmerchantname_062123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_selectrew_071823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ubertesting_071223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ubertesting_071923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part1_062823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part2_062823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse071123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursecreation_071023.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursecreationefx_071123.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurseelevance_062723.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefix_part2_062823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefixpart1_071223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefixpart2_071223.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_pt2_051723.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_publixmerchant7120_061323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemercha_061523 (1).xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid_060523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid_061623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid35777_060523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectfix_060623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmaxload_050823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantgroup_050823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantname.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantname_060623.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_sonderrewards_052423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_srilaskhmi_052323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_targetmerchant.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_testing_052323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_tradermerchant.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionalblocking_part3_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionblocking_part4_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UAT_7120_061523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UAT_7127_052523.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UATToshibaTesting_060823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_uber2iterationtest_040323.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zinglassorew2300_050923.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart1_060823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart2_060823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursefix_part1_062823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursepart2_061423.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept1_041823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept2_041823.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1119.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1120.xml.done',
	--'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1121.xml.done'
	)
	--('C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done','C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart2_060523.xml.done')
	OPEN XmlCursor;
    FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
	select @XmlData, @FileName

    WHILE @@FETCH_STATUS = 0
    BEGIN
		select @FileName
        INSERT INTO @TempTable ( NodeName, AttributeName, AttributeValue, NodeValue, FileName)
        SELECT
            Node.value('local-name(.)', 'NVARCHAR(100)') AS NodeName,
            Attribute.value('local-name(.)', 'NVARCHAR(100)') AS AttributeName,
            Attribute.value('.', 'NVARCHAR(100)') AS AttributeValue,
            Node.value('.', 'NVARCHAR(MAX)') AS NodeValue,
			@FileName as FileName
        FROM @XmlData.nodes('//*') AS T(Node) -- Get all nodes in the XML document
        OUTER APPLY Node.nodes('@*') AS T2(Attribute); -- Get attributes of each node
		select @FileName
        FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
    END

    CLOSE XmlCursor;
    DEALLOCATE XmlCursor;

    -- Insert the extracted data into a new table
    INSERT INTO FISXMLExtract (FileName, NodeName, AttributeName, AttributeValue, NodeValue)
    SELECT FileName,NodeName, AttributeName, AttributeValue, NodeValue
    FROM @TempTable;

	--delete from FISXMLExtract
	--select count(*) from FISXMLExtract
	--select * from FISXMLExtract
	--select distinct FileName from FISXMLExtract

	select * from FISXML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_042423.xml.done'



update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_select_merchantname_070523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_targetmerchant.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmid_051023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part13_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenewal7148.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskc_maxload_maxvalue_051623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentralfod_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndmccreconfig_061223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalmcc_041423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part12_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part18_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_testing_052323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart1_060823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1121.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_mtid_purse7130.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elevanceefxv2_071023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmtid_050923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part10_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part24_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part6_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part9_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part31_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcrenamezcsh_040323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_040723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internatinationalblocking_part29_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part28_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part32_061623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part7_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadv_test_052423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120_prod_051023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UAT_7127_052523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_3031zpart1_060623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbscsh_033123_20230403.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fio_051923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvremnetname_040523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantgroupfixcentralmmo_040323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_elevancemaxload_062223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UAT_7120_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_UATToshibaTesting_060823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept2_041823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_a2a_051223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_051223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_centralrew22expdate_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancefix_060823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantname_052623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_publixmerchant7120_061323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantgroup_050823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_bndcentral_062323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_iiasmissingdata_070723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname_071723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname7120_072423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_optimarewards_062123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid_061623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1120.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis.xml.fraudmid_053023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzotcfod_040623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_iiasmiss7120_051123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse071123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_tradermerchant.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fio_050523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalcfo_051023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_nbdibndchpfod_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_ouyangtest_051923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_bcom_070623.xml.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_central_merchantname_062223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elv5984_070223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_selectrew_071823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ubertesting_071223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefix_part2_062823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc_061423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnagoogle_040623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenew7212_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefixpart1_071223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zinglassorew2300_050923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_prod_xml_merchantnameattach_v2_072423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_centralfio_051823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fiomerchantgroup_050823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantname_060223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantname.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskccsh2300_050923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurseotc_040423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndZpurse_050523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_cchpexpdate_042023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancezpurse_052323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchantgroupfix2centralmmo_040323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_nationsotc_053023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_PROD_selectmerchantname_062123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectfix_060623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otc2322_051223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart1_060523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndchp_042123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_cardexp6904_040723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part2_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part20_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part5_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120614.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionblocking_part4_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpart2_060823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursefix_part1_062823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120merchantn051221.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_42423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_ecommerce_041123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmtid_041823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part25_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part27_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part30_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursecreation_071023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_transactionalblocking_part3_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnapart2_060523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazmaxload_053023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenewal_041823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part17_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part26_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationaltransaction_part1_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamecreation_072123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part23_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_expdaterewkc_042123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part19_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part21_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part22_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massad_052423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursecreationefx_071123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lekmaxload_061223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant0531.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_A2A_070623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ubertesting_071923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurseelevance_062723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbsazcommercialmaxload_053123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part2_062823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpursefixpart2_071223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursepart2_061423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\EH_XRX_PROD_20230602.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_041923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_lacaremcc_042023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120otcfodmcc_042123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_051723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_connecticareemblemexpdate_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskcexpdaterew22_050123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurse_051123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpurseotc_040323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part8_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\plan_1119.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_042423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndzpursept2_040623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevance_051023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancezpurse_052223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part11_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part15_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_internationalblocking_part16_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bcbskciias_051623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_fraudmidblocking_041123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_elevancenewpackage_060923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_mtid_sprout7120.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_otcfodmcc_042023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_presidente_sedanos_052223.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_elvefx_071023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantname_071123.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_merchantnamefilling_v2_nostopshop_072423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemercha_061523 (1).xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmaxload_050823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_sonderrewards_052423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_uber2iterationtest_040323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_zpursept1_041823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\file_xml_zpursepart1_061423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_7120nhsprout05.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_edvelevance_052423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_srilaskhmi_052323.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_autorenew_042023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_bndcentral_061523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_globalmcc6362050923.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_massadvantagemerchantname_040523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_mmo_071023.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_ouyangtesing_072423.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_prod_zpurse_part1_062823.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_pt2_051723.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid_060523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_removemid35777_060523.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_selectmerchantname_060623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_3031zpart2_060623.xml.done'
update FISXML set XMLType = F1XML where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_a2aprod_040523.xml.done'




update FISXML set F1XML = '<?xml version="1.0" encoding="utf-8"?>
<Batch BusinessPartner="NationsBenefits LLC">
	<Purses>
		<Purse>
			<PerformAction>5</PerformAction>
			<Sub_ProgramName>NB_7120</Sub_ProgramName>
			<PurseName>FOD2305</PurseName>
			<NetworkName>FS Empty Network</NetworkName>
		</Purse>
		<PurseMerchantGroupNameLinks>
			<PurseMerchantGroupNameLink>
				<PerformAction>1</PerformAction>
				<Sub_ProgramName>NB_7120</Sub_ProgramName>
				<PurseName>FOD2305</PurseName>
				<MerchantGroupDescription>NBD IIAS Exception</MerchantGroupDescription>
			</PurseMerchantGroupNameLink>
		</PurseMerchantGroupNameLinks>
		<Purse>
			<PerformAction>5</PerformAction>
			<Sub_ProgramName>NB_7120</Sub_ProgramName>
			<PurseName>OTC2322</PurseName>
			<NetworkName>FS Empty Network</NetworkName>
		</Purse>
		<PurseMerchantGroupNameLinks>
			<PurseMerchantGroupNameLink>
				<PerformAction>1</PerformAction>
				<Sub_ProgramName>NB_7120</Sub_ProgramName>
				<PurseName>OTC2322</PurseName>
				<MerchantGroupDescription>NBD IIAS Exception</MerchantGroupDescription>
			</PurseMerchantGroupNameLink>
		</PurseMerchantGroupNameLinks>
		<Purse>
			<PerformAction>5</PerformAction>
			<Sub_ProgramName>NB_7120</Sub_ProgramName>
			<PurseName>OTC2305</PurseName>
			<NetworkName>FS Empty Network</NetworkName>
		</Purse>
		<PurseMerchantGroupNameLinks>
			<PurseMerchantGroupNameLink>
				<PerformAction>1</PerformAction>
				<Sub_ProgramName>NB_7120</Sub_ProgramName>
				<PurseName>OTC2305</PurseName>
				<MerchantGroupDescription>NBD IIAS Exception</MerchantGroupDescription>
			</PurseMerchantGroupNameLink>
		</PurseMerchantGroupNameLinks>
		</Purses>
	</Batch>'

	where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_merchant7120_prod_051023.xml.done'


	update FISXML set F1XML = replace(F1XML, 'LLC"<Purses>', 'LLC"><Purses>') where FileName = 'C:\NHEligJobs\FIS_XML\DAT\IN\fis_xml_aetnazpurse_042423.xml.done'


	select 'update FISXML set XMLType = F1XML where FileName = '+''''+FileName+'''' from FISXML


	
Create table FISXMLExtract
(
FileName NVARCHAR(max),
NodeName NVARCHAR(max),
AttributeName NVARCHAR(max),
AttributeValue NVARCHAR(max),
NodeValue NVARCHAR(MAX)
)

truncate table FISXMLExtract
select * from FISXMLExtract

drop table
exec [dbo].[ExtractXmlDataIntoTable]

create PROCEDURE [dbo].[ExtractXmlDataIntoTable]
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @XmlData XML;
	DECLARE @FileName NVARCHAR(500);
    DECLARE @TempTable TABLE (
        -- Define columns for extracted data
		FileName NVARCHAR(500),
        NodeName NVARCHAR(100),
        AttributeName NVARCHAR(100),
        AttributeValue NVARCHAR(100),
        NodeValue NVARCHAR(MAX)
    );

    -- Replace 'YourTableName' and 'YourXmlColumn' with actual table and XML column names
    DECLARE XmlCursor CURSOR LOCAL FOR
    SELECT F1XML, FileName
    FROM FISXML
	
	OPEN XmlCursor;
    FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
		select @FileName
        INSERT INTO @TempTable ( NodeName, AttributeName, AttributeValue, NodeValue, FileName)
        SELECT
            Node.value('local-name(.)', 'NVARCHAR(100)') AS NodeName,
            Attribute.value('local-name(.)', 'NVARCHAR(100)') AS AttributeName,
            Attribute.value('.', 'NVARCHAR(100)') AS AttributeValue,
            Node.value('.', 'NVARCHAR(MAX)') AS NodeValue,
			@FileName as FileName
        FROM @XmlData.nodes('//*') AS T(Node) -- Get all nodes in the XML document
        OUTER APPLY Node.nodes('@*') AS T2(Attribute); -- Get attributes of each node
		select @FileName
        FETCH NEXT FROM XmlCursor INTO @XmlData, @FileName;
    END

    CLOSE XmlCursor;
    DEALLOCATE XmlCursor;

    -- Insert the extracted data into a new table
    INSERT INTO FISXMLExtract (FileName, NodeName, AttributeName, AttributeValue, NodeValue)
    SELECT FileName,NodeName, AttributeName, AttributeValue, NodeValue
    FROM @TempTable;
END
GO

select * from FISXMLExtract 
select * from FISXMLExtract where NodeName = 'Sub_ProgramName'

select distinct * from FISXMLExtract where NodeName = 'PerformAction'
select distinct * from FISXMLExtract where NodeName = '%Max%'

select distinct * from FISXMLExtract where filename like '%internatinationalblocking%'

