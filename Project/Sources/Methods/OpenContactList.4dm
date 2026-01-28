//%attributes = {}
// OpenContactList
// Opens the main window with the contact list (Document type)

// Create a new instance of the ContactListForm class to hold the form data
var $formData:=cs:C1710.ContactListForm.new()

// Open the ContactList form, passing the form data instance
var $winRef:=Open form window:C675("ContactList"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
DIALOG:C40("ContactList"; $formData)
CLOSE WINDOW:C154($winRef)