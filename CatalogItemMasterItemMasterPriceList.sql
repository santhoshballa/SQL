select * from catalog.ItemMasterList
select * from catalog.ItemMasterPriceList
select * from catalog.ItemMasterAttributeValues
select * from catalog.ItemAttributes


select top 10 * from catalog.ItemMasterList where itemid = '5447'
select top 10 * from catalog.ItemMasterPriceList
select top 10 * from catalog.ItemMasterAttributeValues where ModelAttributeValueDescription like '%washcloths%'
select top 10 * from catalog.ItemAttributes

select * from otccatalog.ItemMaster where ItemName like '%washcloths%'

