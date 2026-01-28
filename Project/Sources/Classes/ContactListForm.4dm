// Contacts list properties
property contacts : cs:C1710.ContactsSelection  // All contacts from database, ordered by name
property selection : cs:C1710.ContactsSelection  // Filtered contacts based on search or criteria
property selectedContact : cs:C1710.ContactsEntity  // Currently selected contact for editing

property delaySearch : Integer
property search : Text

Class constructor
	
	This:C1470.contacts:=Null:C1517
	This:C1470.selection:=Null:C1517
	This:C1470.selectedContact:=Null:C1517
	
	This:C1470.delaySearch:=500
	This:C1470.search:=""
	
	// Load all contacts
	This:C1470.loadContacts()
	
	
Function loadContacts()
	This:C1470.contacts:=ds:C1482.Contacts.load(This:C1470.search)
	This:C1470.selection:=This:C1470.contacts
	This:C1470.selectedContact:=This:C1470.selection.first()
	
	
Function onEditContact
	
	If (This:C1470.selectedContact#Null:C1517)
		
		// Initialize Detail Form
		var $formData:=cs:C1710.ContactDetailForm.new(This:C1470.selectedContact)
		
		// Open Detail Form window (edit mode)
		var $winRef:=Open form window:C675("ContactDetail"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		DIALOG:C40("ContactDetail"; $formData)
		CLOSE WINDOW:C154($winRef)
	End if 
	
	
Function onNewContact
	
	// Initialize Detail Form
	var $formData:=cs:C1710.ContactDetailForm.new(Null:C1517)
	
	// Open Detail Form window (create mode)
	var $winRef:=Open form window:C675("ContactDetail"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40("ContactDetail"; $formData)
	CLOSE WINDOW:C154($winRef)
	
	// Refresh List Form
	This:C1470.contacts.add($formData.contact)
	This:C1470.contacts.refresh()
	
Function onRemoveContact
	
	If (This:C1470.selectedContact#Null:C1517)
		var $status : Object
		$status:=This:C1470.selectedContact.removeContact()
		
		If ($status.success=False:C215)
			ALERT:C41($status.statusText)
		End if 
		
		This:C1470.contacts:=This:C1470.contacts.clean()
		
	End if 
	