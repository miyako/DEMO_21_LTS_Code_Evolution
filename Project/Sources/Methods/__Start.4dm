//%attributes = {}
// On Startup
Case of 
	: (Count parameters:C259=0)
		var $ps:=New process:C317(Current method name:C684; 0; Current method name:C684; 0)
		
	Else 
		// Initialize the database with demo data
		_InitializeData
		
		// Automatically open main window
		OpenContactList
End case 