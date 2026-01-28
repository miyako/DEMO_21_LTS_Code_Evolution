//%attributes = {"invisible":true}
// Initialize the database with demo data

var $contact : Object

// Check if data already exists
If (ds:C1482.Contacts.all().length=0)
	
	// Create demo contacts
	
	// Contact 1: Person
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="Sophie Martin"
	$contact.Email:="sophie.martin@example.com"
	$contact.Phone:="+33 6 12 34 56 78"
	$contact.Type:="Person"
	$contact.Company:="Tech Innovations"
	$contact.Position:="Senior Developer"
	$contact.Address:="15 rue de la République\n75001 Paris"
	$contact.Notes:="Main contact for XYZ project"
	$contact.save()
	
	// Contact 2: Company
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="Digital Solutions SARL"
	$contact.Email:="contact@digitalsolutions.com"
	$contact.Phone:="+33 1 23 45 67 89"
	$contact.Type:="Company"
	$contact.Company:="Digital Solutions SARL"
	$contact.Position:=""
	$contact.Address:="42 avenue des Champs-Élysées\n75008 Paris"
	$contact.Notes:="Customer since 2022 - Active maintenance contract"
	$contact.save()
	
	// Contact 3: Person
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="Jean Dupont"
	$contact.Email:="jean.dupont@company.com"
	$contact.Phone:="+33 6 98 76 54 32"
	$contact.Type:="Person"
	$contact.Company:="Consulting Pro"
	$contact.Position:="Project Manager"
	$contact.Address:="8 boulevard Haussmann\n75009 Paris"
	$contact.Notes:="Available Monday-Wednesday"
	$contact.save()
	
	// Contact 4: Company
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="WebDesign Studio"
	$contact.Email:="info@webdesignstudio.com"
	$contact.Phone:="+33 1 45 67 89 01"
	$contact.Type:="Company"
	$contact.Company:="WebDesign Studio"
	$contact.Position:=""
	$contact.Address:="25 rue du Faubourg Saint-Antoine\n75011 Paris"
	$contact.Notes:="Design partner - Portfolio available upon request"
	$contact.save()
	
	// Contact 5: Person
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="Marie Leclerc"
	$contact.Email:="marie.leclerc@startup.io"
	$contact.Phone:="+33 7 11 22 33 44"
	$contact.Type:="Person"
	$contact.Company:="StartupLab"
	$contact.Position:="CEO & Founder"
	$contact.Address:="Station F\n75013 Paris"
	$contact.Notes:="Interested in our AI solutions"
	$contact.save()
	
End if 