/*
Missing Fitting Fee Payment
dbo.QuickBook_FittingFee_Upload_Sent	| Contains the amount that was sent to the Service Provider (Carrier, PONumber, OrderID, Account)
orders.orders							| contains the OrderID, carrier, vendor information for hearing aids.

Important Note One						| If you find a record, the payment has been made.
Important Note Two						| If a record is not found, inform Srikanth or Sujay.

select top 1 * from dbo.QuickBook_FittingFee_Upload_Sent
select top 1 * from orders.Orders
select count(*) from dbo.QuickBook_FittingFee_Upload_Sent

--37335
First Name: John
Middle Name: E
Last Name: Fortier Jr
Order Number: 200225939
PO Number:20200012375
Provider Legal Business Name: Hear For You Hearing & Balance Center, LLC
Provider DBA: Hear For You Hearing & Balance Center, LLC

--37212
First Name: CLARENCE
Middle Name: H
Last Name: YAX II
PO Number:20200007377
Order Number: 200126213
Provider Legal Business Name: Hear Michigan, Inc
Provider DBA: Hear Michigan
https://catalog.nationshearing.com/manageorder?orderId=200126213

--37211
First Name: PHIL
Last Name: DICKMAN
Provider Legal Business Name: Hear Michigan, Inc
Provider DBA: Hear Michigan
PO Number:20200008847
Order Number: 200147672
https://catalog.nationshearing.com/manageorder?orderId=200147672

--37200
Please add payment for the member below, not in the master spreadsheet:
First Name: ROBERT
Last Name: BOWNS
Provider Legal Business Name: Hear Michigan, Inc
Provider DBA: Hear Michigan
Order Number: 190011543
PO Number:20190004610
https://catalog.nationshearing.com/manageorder?orderId=190011543


Please add the payment for the member below, It is not on the masterlist.
First Name: Margaret
Middle Name: M
Last Name: Cote
Provider Legal Business Name: Hear For You Hearing & Balance Center, LLC
Provider DBA: Hear For You Hearing & Balance Center, LLC
Order Number: 200121244
PO Number:20200007370
https://catalog.nationshearing.com/manageorder?orderId=200121244

Please add the missing payment for below:
First Name: KEVIN
Middle Name: R
Last Name: SMITH
Order Number: 190011034
PO Number:20190004517
Provider Legal Business Name: Bieri Hearing Instruments, Inc
Provider DBA: Bieri Hearing Specialists
https://catalog.nationshearing.com/manageorder?orderId=190011034

Good Afternoon!
First Name: Carlo
Last Name: Castiglione
Provider Legal Business Name: Ear, Nose and Throat Consultants, PC
Provider DBA: Ear, Nose And Throat Consultants Novi
Order Number: 200241630
PO Number : 20200013300
https://catalog.nationshearing.com/manageorder?orderId=200241630

*/


/*
# 37934
Missing Fitting Fee Payment for NH202002544657
200157204	Healthfirst (New York)	P-BSE Hearing, Inc	20200009439	2020-12-02	400	Net 60	002303 · Accrued Provider Fees	2020-12-29	2020-12-21	200157204	NEW	ACTIVE	0	NH202002544657	DOC
The payment has been initiated or sent to the service provider. Thank you

*/


/*
Missing Fitting Fee Payment for NH202002754823
Please see the missing payment below:
First Name: FRANCISCO
Middle Name: A
Last Name: PONCE
Provider Legal Business Name: GN Hearing Care Corporation
Provider DBA: Beltone Hearing Care Center / Retail Loma Linda
PO Number:20200010774
Order Number: 200182253
https://catalog.nationshearing.com/manageorder?orderId=200182253
*/



-- select * from dbo.QuickBook_FittingFee_Upload_Sent order by OrderID desc, SentDate desc, DeliveryDate desc

/*
Missing Payment for Fitting Fees NH202005293973
Please see add the missing payment for the member below:
First Name: STELLA
Middle Name: V
Last Name: SIVERLING
Order Number: 200247762
PO Number:20200014060
Provider Legal Business Name: Auditory Services, LLC
Provider DBA: Auditory Services, LLC

https://catalog.nationshearing.com/manageorder?orderId=200247762
*/

 
/*
39244
Fitting Fee NH202002016626
Member is not on the spreadsheet for reimbursement and fit date was on 01/13/2021. Please see below:
First Name: EMMA
Last Name: ANDALUZ
PO Number:20200011010
Order Number: 200181659
Provider Legal Business Name: 55 Sandalwood Enterprises Inc

https://catalog.nationshearing.com/manageorder?orderId=200181659

 */


 /*
 --39205
 Fitting Fee NH202002693965
 Good afternoon,
 Member is not on the spreadsheet for reimbursement and fit date was on 01/14/2021. Please see below:
 First Name: Brian
 Last Name: Cumberland
 PO Number:20200009814
 Order Number: 200161749
 Provider Legal Business Name: Robert Wayne Jester
 https://catalog.nationshearing.com/manageorder?orderId=200161749

 The payment has been initiated or sent to the service provider. Thank you
 */


 /*
 --39217
 Fitting Fee NH202002139544
 Member is not on the spreadsheet for reimbursement and fit date was on 08/14/2020. Please see below:
 First Name: VENECIA
Last Name: SALOMON
PO Number:20200000752
Order Number: 200006098
Provider Legal Business Name: 55 Sandalwood Enterprises Inc
https://catalog.nationshearing.com/manageorder?orderId=200006098
The payment has been initiated or sent to the service provider. Thank you

 */

 /*
 Fitting Fee NH202002078868
 Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 09/29/2020. Please see below:
First Name: MARIA
Last Name: ARRIAGA
PO Number:20200006635
Order Number: 200112161
Provider Legal Business Name: 55 Sandalwood Enterprises Inc
https://catalog.nationshearing.com/manageorder?orderId=200112161
The payment has been initiated or sent to the service provider. Thank you
 */

 /*
 Fitting Fee NH202002088310
 Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 11/19/2020. Please see below:
First Name: MARTHA
Last Name: DOMINGUEZ CHAVEZ
PO Number:20200008482
Order Number: 200139004
Provider Legal Business Name: 55 Sandalwood Enterprises Inc

https://catalog.nationshearing.com/manageorder?orderId=200139004
The payment has been initiated or sent to the service provider. Thank you
 */

 /*
 Fitting Fee NH202002021167
 Good afternoon,
 Member is not on the spreadsheet for reimbursement and fit date was on 10/13/2020. Please see below:
 First Name: F
 Last Name: POLANCO DE BREGOLI
 PO Number:20200005942
 Order Number: 200098330
 Provider Legal Business Name: 55 Sandalwood Enterprises Inc
 https://catalog.nationshearing.com/manageorder?orderId=200098330

 */

 /*
 # 37179 | Missing Fitting Fee Payment - NH202002214946
 Please add the payment for the member below, It is not on the masterlist.
 First Name: Margaret
 Middle Name: M
 Last Name: Cote
 Provider Legal Business Name: Hear For You Hearing & Balance Center, LLC
 Provider DBA: Hear For You Hearing & Balance Center, LLC
 Order Number: 200121244
 PO Number:20200007370

https://catalog.nationshearing.com/manageorder?orderId=200121244
Sincerely,
 */



 /*
 Fitting Fee NH202004940915
 --39574
Member is not on the spreadsheet for reimbursement and fit date was on 01/22/2021. Please see below:
First Name: Kenneth
Last Name: Schlehuber
PO Number:20200011651
Order Number: 200212203
Provider Legal Business Name: Professional Hearing Aid Associates
https://catalog.nationshearing.com/manageorder?orderId=200212203

*/

/*
--39572 | Fitting Fee NH202004856398
Member is not on the spreadsheet for reimbursement and fit date was on 01/19/2021. Please see below:
First Name: FULTON
Last Name: HAWKINS
PO Number:20200011794
Order Number: 200214176
Provider Legal Business Name: Professional Hearing Aid Associates
https://catalog.nationshearing.com/manageorder?orderId=200214176

*/

/*
Fitting Fee NH202004937298
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 02/12/2021. Please see below:
First Name: JAMES
Last Name: BOSTON
PO Number:20200013280
Order Number: 200238835
Provider Legal Business Name: Royer Hearing Aid Center

https://catalog.nationshearing.com/manageorder?orderId=200238835
*/

/*
Fitting Fee NH202005076989 | 39673
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 02/10/2021. Please see below:
First Name: NATHANIEL
Last Name: DAVIS
PO Number:20200013728
Order Number: 200244644
Provider Legal Business Name: ReNewed Hearing Aid Center
https://catalog.nationshearing.com/manageorder?orderId=200244644
*/

/*
Good Evening!


Please see the Missing Fitting Fee:
First Name: JOSE
Middle Name: V
Last Name: RODRIGUEZ PENA
Order Number: 200118113
Purchase Order -20200006849
PO Number:20200006849
Provider Legal Business Name: Tri-State Hearing LLC
Provider DBA: Beltone Hearing Aid Center

https://catalog.nationshearing.com/manageorder?orderId=200118113

*/

/*
Good Evening!
Please assist with the missing fitting fee payment:
First Name: KIMBERLY
Middle Name: A
Last Name: MICHAELS
Order Number: 200154896
PO Number:20200009327
Provider Legal Business Name: Oakland Hearing Aid Company, LLC
Provider DBA: Oakland Hearing Aid Company, LLC

https://catalog.nationshearing.com/manageorder?orderId=200154896
*/

/*
NH202002712465
Member is not on the spreadsheet for reimbursement and fit date was on 08/12/2020 and the documents were just uploaded on 05/13/2021. Please see below:
First Name: Cristina
Last Name: Martinez Rios
PO Number:20200005924
Order Number: 200104141
Provider Legal Business Name: Tricounty Premier Hearing Services

https://catalog.nationshearing.com/manageorder?orderId=200104141
*/

/*
NH202002361492
Member is not on the spreadsheet for reimbursement and fit date was on 02/02/021. Please see below:
First Name: MARLENE
Last Name: KOERBER
PO Number:20200014213
Order Number: 200255589

Provider Legal Business Name: Florida Hearing Matters LLC
https://catalog.nationshearing.com/manageorder?orderId=200255589
*/

/*
NH202002197073
Good morning,
Member is not on the spreadsheet for reimbursement and fit date was on 12/21/2020. Please see below:
First Name: Evelina
Last Name: Silva
PO Number:20200010096
Order Number: 200169302
Provider Legal Business Name: Physicians Hearing Solutions LLC

https://catalog.nationshearing.com/manageorder?orderId=200169302

*/


/*
-- NH202005748755
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 03/09/2021. Please see below:
First Name: BARBARA
Last Name: OUELLETTE
PO Number:20200016644
Order Number: 200285252
Provider Legal Business Name: University of Maine
https://catalog.nationshearing.com/manageorder?orderId=200285252


*/


/*
Fitting Fee NH201800578418
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 02/11/2021. Please see below:
First Name: CARLOS
Last Name: DE LEON CANAS
PO Number:20200014093
Order Number: 200249230
Provider Legal Business Name: ValleyWide Hearing Aid Center, Inc

https://catalog.nationshearing.com/manageorder?orderId=200249230

*/

/*
Fitting Fee NH201901364170
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 10/13/2020. Please see below:
First Name: DANIEL
Last Name: ELIZONDO
PO Number:20200007428
Order Number: 200126438
Provider Legal Business Name: Schell Services, LLC

https://catalog.nationshearing.com/manageorder?orderId=200126438
*/

/*
Fitting Fee NH201901965547
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 02/04/2021. Please see below:
First Name: Dennis
Last Name: Carroll
PO Number:20200000829
Order Number: 200007774
Provider Legal Business Name: Schell Services, LLC

https://catalog.nationshearing.com/manageorder?orderId=200007774

*/

/*
NH202004753814
Good Morning,
Member is not on the spreadsheet for reimbursement,  fit date was on 03/17/2021, documents received 03/23/2021. Please see below:
First Name: Drena
Last Name: TURNER
PO Number: 20200018190
Order Number:  20030068
Provider Legal Business Name: Kaw Valley Hearing, LLC
https://catalog.nationshearing.com/manageorder?orderId=200300068
*/

/*
Fitting Fee NH202004953683
Member is not on the spreadsheet for reimbursement and fit date was on 01/03/2021. Please see below:
First Name: Loretta
Last Name: Pulkowski
PO Number:20200016055
Order Number: 200278030
Provider Legal Business Name: GN Hearing Care Corporation
https://catalog.nationshearing.com/manageorder?orderId=200278030
*/

/*
Fitting Fee NH201901357123
Member is not on the spreadsheet for reimbursement and fit date was on 02/01/2021. Please see below:
First Name: HERMAN
Last Name: CARPENTER
PO Number:20200012083
Order Number: 200220792
Provider Legal Business Name: Macomb Hearing Aid Center L.L.C.
https://catalog.nationshearing.com/manageorder?orderId=200220792
*/

/*
Fitting Fee NH201700010385
Member is not on the spreadsheet for reimbursement and fit date was on 01/27/2021. Please see below:
First Name: Arthur
Last Name: Thompson
PO Number:20200011731
Order Number: 200213086
Provider Legal Business Name: Tricounty Premier Hearing Services

https://catalog.nationshearing.com/manageorder?orderId=200213086
*/

/*
Fitting Fee NH202005412264
Good afternoon,
Member is not on the spreadsheet for reimbursement and fit date was on 03/09/2021. Please see below:
First Name: RACHEL
Last Name: ROBBINS
PO Number:20200018748
Order Number: 200311328
Provider Legal Business Name: Texas State Hearing Aid Device Center

https://catalog.nationshearing.com/manageorder?orderId=200311328
*/

/*
Fitting Fee NH202005345872
Member is not on the spreadsheet for reimbursement and fit date was on 02/18/2021. Please see below:
First Name: Frances
Last Name: Pletcher
PO Number:20200013311
Order Number: 200239142
Provider Legal Business Name: GN Hearing Care Corporation
https://catalog.nationshearing.com/manageorder?orderId=200239142


*/

/*
Fitting Fee NH202004663019
Member is not on the spreadsheet for reimbursement and fit date was on 02/15/2021. Please see below:
First Name: Carolann
Last Name: Stephens
PO Number:20200013263
Order Number: 200238653
Provider Legal Business Name: GN Hearing Care Corporation

https://catalog.nationshearing.com/manageorder?orderId=200238653
*/

/*
Fitting Fee NH202004933446
Member is not on the spreadsheet for reimbursement and fit date was on 02/10/2021. Please see below:
First Name: John
Last Name: Campsey
PO Number:20200011723
Order Number: 200206911
Provider Legal Business Name: GN Hearing Care Corporation

https://catalog.nationshearing.com/manageorder?orderId=200206911

*/

/*

Fitting Fee NH202004953683
Member is not on the spreadsheet for reimbursement and fit date was on 01/03/2021. Please see below:
First Name: Loretta
Last Name: Pulkowski
PO Number:20200016055
Order Number: 200278030
Provider Legal Business Name: GN Hearing Care Corporation

https://catalog.nationshearing.com/manageorder?orderId=200278030
*/

/*
Member is not on the spreadsheet for reimbursement and fit date was on 02/19/2021. Please see below:
First Name: INEZ
Last Name: MERRITTS
PO Number:20200015386
Order Number: 200271120
Provider Legal Business Name: Reliable Hearing Solutions, LLC
https://catalog.nationshearing.com/manageorder?orderId=200271120
*/

/*
NH202002693965
Member is not on the spreadsheet for reimbursement and fit date was on 01/14/2021. Please see below:
First Name: Brian
Last Name: Cumberland
PO Number:20200009814
Order Number: 200161749
Provider Legal Business Name: Robert Wayne Jester
https://catalog.nationshearing.com/manageorder?orderId=200161749

*/
/*
Fitting Fee NH202002062936
Member is not on the spreadsheet for reimbursement and fit date was on 02/26/2021. Please see below:
First Name: KLEVEERT
Last Name: ANDUJAR
PO Number:20200013087
Order Number: 200234034
Provider Legal Business Name: 55 Sandalwood Enterprises Inc
https://catalog.nationshearing.com/manageorder?orderId=200234034

*/

/*
Fitting Fee NH202002336975
Provider was paid for one Hearing Aid and never received payment for the second Hearing Aid because they submitted 2 orders. Fit date was on 02/22/2021. Please see below:
First Name: LINDA
Last Name: MEISTER
PO Number:20200013387
Order Number: 200243398
Provider Legal Business Name: Hearing Tools LLC
https://catalog.nationshearing.com/manageorder?orderId=200243398

*/

/*
Fitting Fee NH202002807398
Provider was paid for one Hearing Aid and never received payment for the second Hearing Aid because they submitted 2 orders. Fit date was on 02/24/2021. Please see below:
First Name: JAMES
Last Name: GAMBLE
PO Number:20200016996
Order Number: 200289722
Provider Legal Business Name: Hearing Tools LLC
https://catalog.nationshearing.com/manageorder?orderId=200289722

*/

/*
Fitting Fee NH202004643515
 Member is not on the spreadsheet for reimbursement and fit date was on 03/05/2021. Please see below:
 First Name: BONNIE
Last Name: MAYALL
PO Number:20200016150
Order Number: 200277603
Provider Legal Business Name: ClearSound Hearing, LLC

https://catalog.nationshearing.com/manageorder?orderId=200277603

*/

/*
Fitting Fee NH202106453879
Member is not on the spreadsheet for reimbursement and fit date was on 03/15/2021. Please see below:
First Name: THELA
Last Name: LEACH
PO Number:20200018324
Order Number: 200308129
Provider Legal Business Name: Doc Side Audiology, LLC

https://catalog.nationshearing.com/manageorder?orderId=200308129

*/


/*
Fitting Fee NH202002615804
Member is not on the spreadsheet for reimbursement and fit date was on 03/18/2021. Please see below:
First Name: MIGUEL
Last Name: ORANTES
PO Number:20200020395
Order Number: 200330575
Provider Legal Business Name: A&E Hearing Aid Center LLC
https://catalog.nationshearing.com/manageorder?orderId=200330575
*/

/*
Fitting Fee NH202002116861
Member is not on the spreadsheet for reimbursement and fit date was on 08/17/2020. Please see below:
First Name: RAWAYIAH
Last Name: YAFAI
PO Number:20200005005
Order Number: 200095718
Provider Legal Business Name: 55 Sandalwood Enterprises Inc

https://catalog.nationshearing.com/manageorder?orderId=200095718

*/


/*
Fitting Fee NH202002484963
Member is not on the spreadsheet for reimbursement and fit date was on 10/16/2020. Please see below:
First Name: Jacques
Last Name: Carter
PO Number:20200007412
Order Number: 200126223
Provider Legal Business Name: Personal Hearing Solutions

https://catalog.nationshearing.com/manageorder?orderId=200126223

*/
/*
Fitting Fee NH201901406364
Member is not on the spreadsheet for reimbursement,  fit date was on 01/02/2021, documents received 06/10/2021. Please see below:
First Name: Susan
Last Name: Elliott
PO Number: 20200018190
Order Number : 200238908
Provider Legal Business Name: Oakland Hearing
https://catalog.nationshearing.com/manageorder?orderId=200238908

/*

/*
Fitting Fee NH202005346771
Member is not on the spreadsheet for reimbursement,  fit date was on 03/02/2021, documents received 06/02/2021. Please see below:
First Name: Frank
Last Name: Male
PO Number : 20200015886
Order Number : 200274786
Provider Legal Business Name: Kaw Valley Hearing, LLC

https://catalog.nationshearing.com/manageorder?orderId=200274786
*/

/*
Fitting Fee NH202004972097
Member is not on the spreadsheet for reimbursement,  fit date was on 01/21/2021, documents received 06/02/2021. Please see below:
First Name: Margo H
Last Name: Bell
PO Number : 20200011791
Order Number : 200213768
Provider Legal Business Name: Kaw Valley Hearing, LLC
https://catalog.nationshearing.com/manageorder?orderId=200213768

*/

/*
Fitting Fee NH202106625020
Member is not on the spreadsheet for reimbursement,  fit date was on 03/29/2021, documents received 03/29/2021. Please see below:
First Name: JOSEPH W
Last Name: PAPROCKY
PO Number : 20200019552
Order Number : 200323846
Provider Legal Business Name: North Shore Hearing PC

https://catalog.nationshearing.com/manageorder?orderId=200323846


*/

/*
Fitting Fee NH202002225389
Member is not on the spreadsheet for the current reimbursement and fit date was on 03/30/2021. Please see below:
First Name: Richard
Last Name: Silvia
PO Number:20200016601
Order Number: 200285481
Provider Legal Business Name: Hearing Specialists of New England, LLC

https://catalog.nationshearing.com/manageorder?orderId=200285481


*/

/*
Fitting Fee NH202004800181
Provider placed two different orders and was only reimbursed for the Left Ear. Fit date was on 03/17/2021. Please see below details for Right Ear:
First Name: Fred
Last Name: Elias
PO Number:20200018130
Order Number: 200301856
Provider Legal Business Name: GN Hearing Care Corporation

https://catalog.nationshearing.com/manageorder?orderId=200301856
*/


 /*
 Fitting Fee NH202004827108
 Member is not on the spreadsheet for the current reimbursement and fit date was on 02/09/2021. Please see below:
 First Name: James
 Last Name: Shreve
 PO Number:20200014006
 Order Number: 200249297
 Provider Legal Business Name: ZAMS, LLC
 https://catalog.nationshearing.com/manageorder?orderId=200249297

*/

/*
 Fitting Fee NH202004962933
Member is not on the spreadsheet for the current reimbursement and fit date was on 04/12/2021. Please see below:
First Name: LAVERNE
Last Name: FAYMONVILLE
PO Number:20200023406
Order Number: 200366299
Provider Legal Business Name: L & G hearing Aid Centers Inc

https://catalog.nationshearing.com/manageorder?orderId=200366299

*/

/*
Fitting Fee NH202005163723
 Member is not on the spreadsheet for the current reimbursement and fit date was on 04/06/2021. Please see below:
 First Name: Ronald
 Last Name: Reinders
 PO Number:20200025282
 Order Number: 200394849
 Provider Legal Business Name: Merit Hearing LLC

 

https://catalog.nationshearing.com/manageorder?orderId=200394849
*/

/*
Fitting Fee NH202005812648
Member is not on the spreadsheet for the current reimbursement and fit date was on 03/08/2021. Please see below:
First Name: DAVID
Last Name: KOLENDA
PO Number:20200018593
Order Number: 200307658
Provider Legal Business Name: LifeStyle Hearing Aid Center LLC

https://catalog.nationshearing.com/manageorder?orderId=200307658

*/

/*
Fitting Fee NH202006048042
Member is not on the spreadsheet for the current reimbursement and fit date was on 04/27/2021. Please see below:
First Name: MAX
Last Name: GESSNER SR
PO Number:20200026061
Order Number: 200409651
Provider Legal Business Name: Tricounty Premier Hearing Services
https://catalog.nationshearing.com/manageorder?orderId=200409651

*/

/*
Fitting Fee NH202005187445 | 41452 | Not Found
Member is not on the spreadsheet for the current reimbursement and fit date was on 03/23/2021. Please see below:
First Name: Sharon
Last Name: Schumacher
PO Number:20200019829
Order Number: 200324367
Provider Legal Business Name: ZAMS, LLC

https://catalog.nationshearing.com/manageorder?orderId=200324367

*/

/*
Fitting Fee NH202004795885 | 41455 | Not Found
Member is not on the spreadsheet for the current reimbursement and fit date was on 04/13/2021. Please see below:
First Name: Elizabeth
Last Name: Schaaf
PO Number:20200023138
Order Number: 200364153
Provider Legal Business Name: Lake Effect Hearing, LLC

https://catalog.nationshearing.com/manageorder?orderId=200364153


*/

/*
Fitting Fee NH202005689055 | Not Found
Member is not on the spreadsheet for the current reimbursement and fit date was on 04/13/2021. Please see below:
First Name: Elizabeth
Last Name: Bowes
PO Number:20200021333
Order Number: 200342101
Provider Legal Business Name: Brooklands Audiology Inc

https://catalog.nationshearing.com/manageorder?orderId=200342101

*/


select 
a.orderid, a.carrier, a.vendor, a.PONumber, a.FittingDate, a.TotalFittingFee, a.Term, a.Account, a.sentDate,a.DeliveryDate,
b.orderid, b.ordertype, b.status, b.Amount, b.NHMemberID, b.OrderStatusCode
from 
dbo.QuickBook_FittingFee_Upload_Sent a join orders.orders b on a.orderID = b.OrderID
where 
1=1
and b.NHMemberID = 'NH202005689055'
--and a.OrderID = 200241630





select * from orders.orders where orderid = 200483331 
select * from orders.orderitems where orderid = 200483331
select * from orders.OrderPOs where orderid = 200483331 or PONumber= 20200010096
select * from orders.OrderTransactionDetails where orderid = 200483331 order by OrderTransactionID desc





/*
-- Work in Progress, Missing Fitting Fee Payment, will let the right tech member know. Thank you
-- The payment has been initiated or sent to the service provider. Thank you
-- Unable to find the payment to the service provider, assigned to the right Tech member to process this request. Thank you
*/


select 
a.orderid, a.carrier, a.vendor, a.PONumber, a.FittingDate, a.TotalFittingFee, a.Term, a.Account, a.sentDate,a.DeliveryDate,
b.orderid, b.ordertype, b.status, b.Amount, b.NHMemberID, b.OrderStatusCode
from 
dbo.QuickBook_FittingFee_Upload_Sent a join orders.orders b on a.orderID = b.OrderID
where 
1=1
and b.NHMemberID in (
'NH202005187445'  


)


