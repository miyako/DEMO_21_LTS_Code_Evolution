Class extends Entity

Function saveContact : Object
	
	// Validation
	If (This:C1470.Type="Person") & (This:C1470.Name="")
		return {success: False:C215; statusText: "The name is mandatory."}
	End if 
	
	If (This:C1470.Type="Company") & (This:C1470.Company="")
		return {success: False:C215; statusText: "The company is mandatory."}
	End if 
	
	
	If (This:C1470.Email#"") && (Position:C15("@"; This:C1470.Email)=0)
		return {success: False:C215; statusText: "The email is incorrect."}
	End if 
	
	// Save
	return This:C1470.save()
	
Function removeContact : Object
	
	return This:C1470.drop(dk force drop if stamp changed:K85:17)
	
	
	