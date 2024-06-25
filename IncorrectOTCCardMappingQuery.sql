--Incorrect OTC card mapping

select NHmemberid, cardnumber, IsActive from otc.Cards where cardnumber in ('6102812731008017747') or NHMemberID in ('NH202106880562', 'NH202106655345') -- This card belongs to NH202106880562

update otc set NHMemberID = 'NH202106880562' from otc.cards otc where cardnumber = '6102812731008017747'