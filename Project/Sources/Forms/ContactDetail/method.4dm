// ContactDetailフォームメソッド

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		var $icon : Picture
		
		// FormはDIALOGまたはFORM LOADを介してエンティティを受け取ります
		// Formは呼び出し元のメソッドによってすでに初期化されています
		
		If (Form:C1466.contact=Null:C1517)
			// 作成モード
			BLOB TO PICTURE:C682(File:C1566("/RESOURCES/contact_new.png").getContent(); $icon)
			SET WINDOW TITLE:C213("New Contact")
		Else 
			// 編集モード
			BLOB TO PICTURE:C682(File:C1566("/RESOURCES/contact_detail.png").getContent(); $icon)
			SET WINDOW TITLE:C213("Contact Details")
		End if 
		
		SET WINDOW DOCUMENT ICON:C1840(Current form window:C827; $icon)
		
		// 新しい種類に基づいてフィールドを動的に作成するために createDynamicFields メソッドを呼び出します
		Form:C1466.createDynamicFields()
		
End case 

