Class extends DataClass

Function load($search : Text) : cs:C1710.ContactsSelection
	If ($search="")
		return ds:C1482.Contacts.all().copy().orderBy("Name")
	Else 
		return ds:C1482.Contacts.query("Name = :1 or Company = :1"; "@"+$search+"@").orderBy("Name")
	End if 