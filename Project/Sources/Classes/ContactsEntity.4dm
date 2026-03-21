Class extends Entity

Function saveContact : Object
	
	// 検証
	If (This:C1470.Type="Person") & (This:C1470.Name="")
		return {success: False:C215; statusText: "名前は必須です。"}
	End if 
	
	If (This:C1470.Type="Company") & (This:C1470.Company="")
		return {success: False:C215; statusText: "会社名は必須です。"}
	End if 
	
	
	If (This:C1470.Email#"") && (Position:C15("@"; This:C1470.Email)=0)
		return {success: False:C215; statusText: "メールアドレスが正しくありません。"}
	End if 
	
	// 保存
	return This:C1470.save()
	
Function removeContact : Object
	
	return This:C1470.drop(dk force drop if stamp changed:K85:17)
	
	
	