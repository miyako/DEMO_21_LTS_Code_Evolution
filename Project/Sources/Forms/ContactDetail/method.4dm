// Form method for ContactDetail

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		var $icon : Picture
		
		// The form receives the entity via DIALOG or FORM LOAD
		// Form is already initialized by the calling method
		
		If (Form:C1466.contact=Null:C1517)
			// Creation mode
			BLOB TO PICTURE:C682(File:C1566("/RESOURCES/contact_new.png").getContent(); $icon)
			SET WINDOW TITLE:C213("New Contact")
		Else 
			// Edit mode
			BLOB TO PICTURE:C682(File:C1566("/RESOURCES/contact_detail.png").getContent(); $icon)
			SET WINDOW TITLE:C213("Contact Details")
		End if 
		
		SET WINDOW DOCUMENT ICON:C1840(Current form window:C827; $icon)
		
		// Call the createDynamicFields method to create fields dynamically based on new type
		Form:C1466.createDynamicFields()
		
End case 

