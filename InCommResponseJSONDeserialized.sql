create table #CardNumberTemp 
(
CardNumber nvarchar(1000)
,JsonResponse nvarchar(4000)

)

insert into #CardNumberTemp (CardNumber, JsonResponse) values
('6102812771008790711', '{
  "data": {
    "store_number": "00001",
    "register_number": "001",
    "transaction_sequence_number": "0000",
    "response_code": "AA",
    "approval_code": "546500",
    "capture_date": "072121",
    "display_message": "The card provided does not have any active catalogs. Please contact your health plan for assistance.",
    "flex_info": {
      "INCOMM-ID": "000121093799",
      "IRC": "0000",
      "IRC-ALPHA": "TransactionApproval",
      "INTERNAL-DESCRIPTION": "Transaction was approved",
      "RRC": "00",
      "AUTHORIZER-UNIQUE-ID": "00000000000081546500",
      "APPROVED-AMOUNT": "000000000000",
      "PRODUCT-DESCRIPTION": "IHA OTC Medicaid77 27710",
      "SERIAL-NUMBER": "230646579",
      "MBA": [
        {
          "dataSet": "DV",
          "dataSetFields": {
            "Version": "01.01"
          }
        }
      ]
    },
    "unique_id_scheme": "S",
    "sender_unique_id": "LcdrBRStekSIbK0inImpmQ==",
    "isValid": true,
    "isAccountActive": true,
    "canShowMessage": true
  },
  "errors": null
}'
),
('6102812771008790711', '{
  "data": {
    "store_number": "00001",
    "register_number": "001",
    "transaction_sequence_number": "0000",
    "response_code": "AA",
    "approval_code": "546500",
    "capture_date": "072121",
    "display_message": "The card provided does not have any active catalogs. Please contact your health plan for assistance.",
    "flex_info": {
      "INCOMM-ID": "000121093799",
      "IRC": "0000",
      "IRC-ALPHA": "TransactionApproval",
      "INTERNAL-DESCRIPTION": "Transaction was approved",
      "RRC": "00",
      "AUTHORIZER-UNIQUE-ID": "00000000000081546500",
      "APPROVED-AMOUNT": "000000000000",
      "PRODUCT-DESCRIPTION": "IHA OTC Medicaid77 27710",
      "SERIAL-NUMBER": "230646579",
      "MBA": [
        {
          "dataSet": "DV",
          "dataSetFields": {
            "Version": "01.01"
          }
        }
      ]
    },
    "unique_id_scheme": "S",
    "sender_unique_id": "LcdrBRStekSIbK0inImpmQ==",
    "isValid": true,
    "isAccountActive": true,
    "canShowMessage": true
  },
  "errors": null
}'
)



select * from #CardNumberTemp

select distinct
 CardNumber
,JSON_VALUE(JsonResponse, '$.data.store_number') as Store_Number
,JSON_VALUE(JsonResponse, '$.data.register_number') as register_number
,JSON_VALUE(JsonResponse, '$.data.transaction_sequence_number') as transaction_sequence_number
,JSON_VALUE(JsonResponse, '$.data.response_code') as response_code
,JSON_VALUE(JsonResponse, '$.data.approval_code') as approval_code
,JSON_VALUE(JsonResponse, '$.data.capture_date') as capture_date
,JSON_VALUE(JsonResponse, '$.data.display_message') as display_message

,JSON_VALUE(JsonResponse, '$.data.flex_info."INCOMM-ID"') as [Flex_info_INCOMM-ID]

,JSON_VALUE(JsonResponse, '$.data.flex_info."IRC"') as [Flex_info_IRC]
,JSON_VALUE(JsonResponse, '$.data.flex_info."IRC-ALPHA"') as [Flex_info_IRC-ALPHA]
,JSON_VALUE(JsonResponse, '$.data.flex_info."INTERNAL-DESCRIPTION"') as [Flex_info_INTERNAL-DESCRIPTION]
,JSON_VALUE(JsonResponse, '$.data.flex_info."RRC"') as [Flex_info_RRC]
,JSON_VALUE(JsonResponse, '$.data.flex_info."AUTHORIZER-UNIQUE-ID"') as [Flex_info_AUTHORIZER-UNIQUE-ID]
,JSON_VALUE(JsonResponse, '$.data.flex_info."APPROVED-AMOUNT"') as [Flex_info_APPROVED-AMOUNT]
,JSON_VALUE(JsonResponse, '$.data.flex_info."PRODUCT-DESCRIPTION"') as [Flex_info_PRODUCT-DESCRIPTION]
,JSON_VALUE(JsonResponse, '$.data.flex_info."SERIAL-NUMBER"') as [Flex_info_SERIAL-NUMBER]

,JSON_VALUE(JsonResponse, '$.data.flex_info.MBA[0].dataSet') as [Flex_info_MBA_dataSet]
,JSON_VALUE(JsonResponse, '$.data.flex_info.MBA[0].dataSetFields.Version') as [Flex_info_MBA_dataSetFields_Version]

,JSON_VALUE(JsonResponse, '$.data.unique_id_scheme') as unique_id_scheme
,JSON_VALUE(JsonResponse, '$.data.sender_unique_id') as sender_unique_id
,JSON_VALUE(JsonResponse, '$.data.isValid') as isValid
,JSON_VALUE(JsonResponse, '$.data.isAccountActive') as isAccountActive
,JSON_VALUE(JsonResponse, '$.data.canShowMessage') as canShowMessage

from #CardNumberTemp


