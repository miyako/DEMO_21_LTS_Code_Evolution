// 連絡先リストのプロパティ
property contacts : cs:C1710.ContactsSelection  // データベースからのすべての連絡先 (名前順)
property selection : cs:C1710.ContactsSelection  // 検索または条件に基づいてフィルタリングされた連絡先
property selectedContact : cs:C1710.ContactsEntity  // 編集のために現在選択されている連絡先

property delaySearch : Integer
property search : Text

Class constructor
	
	This:C1470.contacts:=Null:C1517
	This:C1470.selection:=Null:C1517
	This:C1470.selectedContact:=Null:C1517
	
	This:C1470.delaySearch:=500
	This:C1470.search:=""
	
	// すべての連絡先を読み込む
	This:C1470.loadContacts()
	
	
Function loadContacts()
	This:C1470.contacts:=ds:C1482.Contacts.load(This:C1470.search)
	This:C1470.selection:=This:C1470.contacts
	This:C1470.selectedContact:=This:C1470.selection.first()
	
	
Function onEditContact
	
	If (This:C1470.selectedContact#Null:C1517)
		
		// 詳細フォームを初期化する
		var $formData:=cs:C1710.ContactDetailForm.new(This:C1470.selectedContact)
		
		// 詳細フォームウィンドウを開く (編集モード)
		var $winRef:=Open form window:C675("ContactDetail"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
		DIALOG:C40("ContactDetail"; $formData)
		CLOSE WINDOW:C154($winRef)
	End if 
	
	
Function onNewContact
	
	// 詳細フォームを初期化する
	var $formData:=cs:C1710.ContactDetailForm.new(Null:C1517)
	
	// 詳細フォームウィンドウを開く (作成モード)
	var $winRef:=Open form window:C675("ContactDetail"; Movable form dialog box:K39:8; Horizontally centered:K39:1; Vertically centered:K39:4; *)
	DIALOG:C40("ContactDetail"; $formData)
	CLOSE WINDOW:C154($winRef)
	
	// リストフォームを更新する
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
	