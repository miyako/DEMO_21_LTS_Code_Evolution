// ContactListのフォームメソッド

var $event:=FORM Event:C1606
Case of 
	: ($event.code=On Load:K2:1)
		
		var $icon : Picture
		
		// ドキュメントウィンドウ (リスト) のアイコン
		BLOB TO PICTURE:C682(File:C1566("/RESOURCES/contact_list.png").getContent(); $icon)
		SET WINDOW DOCUMENT ICON:C1840(Current form window:C827; $icon)
		
		LISTBOX SELECT ROWS:C1715(*; "ListBox"; Form:C1466.contacts.slice(0; 1); lk replace selection:K53:1)
		
		SearchPicker SET HELP TEXT("SearchPicker"; "名前")
		
		
	: ($event.code=On Double Clicked:K2:5)
		
		// リストボックスをダブルクリック
		If ($event.objectName="ListBox")
			// 連絡先詳細フォームのonEditContactメソッドを呼び出します
			Form:C1466.onEditContact()
		End if 
		
		// タイマー終了 - ユーザーの入力がdelaySearchミリ秒間停止しました
	: ($event.code=On Timer:K2:25)
		// タイマーを停止し、現在の検索テキストで検索を実行します
		SET TIMER:C645(0)
		Form:C1466.loadContacts()
		
End case 
