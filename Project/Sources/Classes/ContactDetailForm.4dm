// Contact form properties
property name : Text  // Contact's full name or company name
property email : Text  // Email address for contact
property phone : Text  // Phone number
property type : Text  // Type of contact: "Person" or "Company"
property company : Text  // Company name (for persons) or company designation
property position : Text  // Job position (for persons in companies)
property address : Text  // Full address (street, city, postal code)
property notes : Text  // Additional notes or remarks about the contact

// Database and state properties
property contact : cs:C1710.ContactsEntity  // Reference to the database entity
property isNew : Boolean  // True if creating new contact, False if editing existing

// Dynamic form properties
property isCompany : Boolean  // True if type is "Company"
property isPerson : Boolean  // True if type is "Person"
property attributes : Collection  // List of field names to display based on type
property nbInputs : Integer  // Number of dynamically created input fields

Class constructor($obj : cs:C1710.ContactsEntity)
	
	If ($obj=Null:C1517)
		// Creating a new contact
		This:C1470.isNew:=True:C214
		This:C1470.name:=""
		This:C1470.email:=""
		This:C1470.phone:=""
		This:C1470.type:="Person"  // Default value
		This:C1470.company:=""
		This:C1470.position:=""
		This:C1470.address:=""
		This:C1470.notes:=""
	Else 
		// Editing an existing contact
		This:C1470.isNew:=False:C215
		This:C1470.contact:=$obj
		This:C1470.name:=This:C1470.contact.Name
		This:C1470.email:=This:C1470.contact.Email
		This:C1470.phone:=This:C1470.contact.Phone
		This:C1470.type:=This:C1470.contact.Type
		This:C1470.company:=This:C1470.contact.Company
		This:C1470.position:=This:C1470.contact.Position
		This:C1470.address:=This:C1470.contact.Address
		This:C1470.notes:=This:C1470.contact.Notes
	End if 
	
	This:C1470.nbInputs:=0
	
	This:C1470.updateType()
	
Function save
	
	If (This:C1470.contact=Null:C1517)
		// Creation
		This:C1470.contact:=ds:C1482.Contacts.new()
	End if 
	
	This:C1470.contact.Name:=This:C1470.name
	This:C1470.contact.Email:=This:C1470.email
	This:C1470.contact.Phone:=This:C1470.phone
	This:C1470.contact.Type:=This:C1470.type
	This:C1470.contact.Company:=This:C1470.company
	This:C1470.contact.Position:=This:C1470.position
	This:C1470.contact.Address:=This:C1470.address
	This:C1470.contact.Notes:=This:C1470.notes
	
	var $status:=This:C1470.contact.saveContact()
	
	If ($status.success=False:C215)
		ALERT:C41($status.statusText)
	Else 
		CANCEL:C270
	End if 
	
	
Function updateType
	
	// Called when type changes (Person/Company)
	// Updates boolean flags that determine which fields to display
	This:C1470.isCompany:=(This:C1470.type="Company")
	This:C1470.isPerson:=(This:C1470.type="Person")
	
	// Define attributes to display based on type
	// These flags trigger the dynamic field generation in CreateDynamicFields
	// which creates, positions, and binds input fields using OBJECT SET DATA SOURCE FORMULA
	// Person: shows name, email, phone, address, notes
	// Company: shows company, name, position, email, phone, address, notes
	If (This:C1470.isCompany)
		// For a company: Company, Name, Position, Email, Phone, Address, Notes
		This:C1470.attributes:=New collection:C1472("company"; "name"; "position"; "email"; "phone"; "address"; "notes")
	Else 
		// For a person: Name, Email, Phone, Address, Notes
		This:C1470.attributes:=New collection:C1472("name"; "email"; "phone"; "address"; "notes")
	End if 
	
	
Function createDynamicFields
	// Dynamically create form fields based on type (Person/Company)
	
	var $l_x1; $l_y1; $l_x2; $l_y2; $i_x1; $i_y1; $i_x2; $i_y2 : Integer
	var $item; $label : Text
	var $formula : 4D:C1709.Function
	var $index : Integer
	
	// Get initial coordinates of templates
	OBJECT GET COORDINATES:C663(*; "Label"; $l_x1; $l_y1; $l_x2; $l_y2)
	OBJECT GET COORDINATES:C663(*; "Input"; $i_x1; $i_y1; $i_x2; $i_y2)
	
	// Create fields dynamically
	$index:=0
	For each ($item; Form:C1466.attributes)
		$index+=1
		
		// Create label
		OBJECT DUPLICATE:C1111(*; "Label"; "Label_"+String:C10($index))
		OBJECT SET VISIBLE:C603(*; "Label_"+String:C10($index); True:C214)
		OBJECT SET COORDINATES:C1248(*; "Label_"+String:C10($index); $l_x1; $l_y1; $l_x2; $l_y2)
		
		// Set label title
		$label:=$item
		// Capitalize first letter for label
		$label[[1]]:=Uppercase:C13($label[[1]])
		OBJECT SET TITLE:C194(*; "Label_"+String:C10($index); $label+" :")
		
		// Create input
		OBJECT DUPLICATE:C1111(*; "Input"; "Input_"+String:C10($index))
		OBJECT SET VISIBLE:C603(*; "Input_"+String:C10($index); True:C214)
		OBJECT SET COORDINATES:C1248(*; "Input_"+String:C10($index); $i_x1; $i_y1; $i_x2; $i_y2)
		
		// Set data source formula
		$formula:=Formula from string:C1601("Form."+$item)
		OBJECT SET DATA SOURCE FORMULA:C1851(*; "Input_"+String:C10($index); $formula)
		
		// Calculate new coordinates (30px offset per field)
		$l_y1+=30
		$l_y2+=30
		$i_y1+=30
		$i_y2+=30
	End for each 
	
	
	// Manage object pool for dynamic fields
	// 4D cannot delete dynamically created objects, so we use a pooling pattern:
	// - Objects are created once and reused across type changes
	// - If fewer fields are needed than previously created, excess objects are hidden and their data sources are cleared
	// - nbInputs tracks the maximum number of fields ever created to know how many to hide/show on next call
	// Example: switching from Company (7 fields) to Person (5 fields) hides Label_6, Label_7, Input_6, Input_7
	var $i : Integer
	If ($index<Form:C1466.nbInputs)
		// Hide fields we no longer need
		For ($i; $index+1; Form:C1466.nbInputs)
			OBJECT SET VISIBLE:C603(*; "Label_"+String:C10($i); False:C215)
			OBJECT SET VISIBLE:C603(*; "Input_"+String:C10($i); False:C215)
			// Clear data binding to prevent unintended data updates
			OBJECT SET DATA SOURCE FORMULA:C1851(*; "Input_"+String:C10($i); Null:C1517)
		End for 
	Else 
		// Update max pool size when new fields are created
		Form:C1466.nbInputs:=$index
	End if 
	
	