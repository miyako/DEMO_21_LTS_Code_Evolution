// 連絡先 Form のプロパティ
property name : Text  // 連絡先のフルネームまたは会社名
property email : Text  // 連絡先のメールアドレス
property phone : Text  // 電話番号
property type : Text  // 連絡先の種類: "Person" または "Company"
property company : Text  // 会社名 (個人の場合) または会社の名称
property position : Text  // 役職 (会社内の個人の場合)
property address : Text  // 完全な住所 (市区町村、番地、郵便番号など)
property notes : Text  // 連絡先に関する追加のメモまたは備考

// データベースと状態のプロパティ
property contact : cs:C1710.ContactsEntity  // データベースのエンティティへの参照
property isNew : Boolean  // 新しい連絡先を作成中の場合は True、既存のものを編集中の場合は False
// 動的 Form のプロパティ
property isCompany : Boolean  // 種類が "Company" の場合は True
property isPerson : Boolean  // 種類が "Person" の場合は True
property attributes : Collection  // 種類に基づいて表示するフィールド名のリスト
property nbInputs : Integer  // 動的に作成された入力フィールドの数

Class constructor($obj : cs:C1710.ContactsEntity)
	
	If ($obj=Null:C1517)
		// 新しい連絡先を作成する
		This:C1470.isNew:=True:C214
		This:C1470.name:=""
		This:C1470.email:=""
		This:C1470.phone:=""
		This:C1470.type:="Person"  // デフォルト値
		This:C1470.company:=""
		This:C1470.position:=""
		This:C1470.address:=""
		This:C1470.notes:=""
	Else 
		// 既存の連絡先を編集する
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
		// 作成
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
	
	// 種類が変更されたときに呼び出される (Person/Company)
	// どのフィールドを表示するかを決定するブールフラグを更新する
	This:C1470.isCompany:=(This:C1470.type="Company")
	This:C1470.isPerson:=(This:C1470.type="Person")
	
	// 種類に基づいて表示する属性を定義する
	// これらのフラグは CreateDynamicFields での動的フィールド生成をトリガーする
	// ここでは OBJECT SET DATA SOURCE FORMULA を使用して入力フィールドを作成、配置、およびバインドする
	// Person: 名前、メールアドレス、電話番号、住所、メモを表示する
	// Company: 会社名、名前、役職、メールアドレス、電話番号、住所、メモを表示する
	If (This:C1470.isCompany)
		// 会社の場合: 会社名 (Company)、名前 (Name)、役職 (Position)、メールアドレス (Email)、電話番号 (Phone)、住所 (Address)、メモ (Notes)
		This:C1470.attributes:=New collection:C1472("company"; "name"; "position"; "email"; "phone"; "address"; "notes")
	Else 
		// 個人の場合: 名前 (Name)、メールアドレス (Email)、電話番号 (Phone)、住所 (Address)、メモ (Notes)
		This:C1470.attributes:=New collection:C1472("name"; "email"; "phone"; "address"; "notes")
	End if 
	
	
Function createDynamicFields
	// 種類 (Person/Company) に基づいて Form フィールドを動的に作成する
	
	var $l_x1; $l_y1; $l_x2; $l_y2; $i_x1; $i_y1; $i_x2; $i_y2 : Integer
	var $item; $label : Text
	var $formula : 4D:C1709.Function
	var $index : Integer
	
	// テンプレートの初期座標を取得する
	OBJECT GET COORDINATES:C663(*; "Label"; $l_x1; $l_y1; $l_x2; $l_y2)
	OBJECT GET COORDINATES:C663(*; "Input"; $i_x1; $i_y1; $i_x2; $i_y2)
	
	// フィールドを動的に作成する
	$index:=0
	For each ($item; Form:C1466.attributes)
		$index+=1
		
		// ラベルを作成する
		OBJECT DUPLICATE:C1111(*; "Label"; "Label_"+String:C10($index))
		OBJECT SET VISIBLE:C603(*; "Label_"+String:C10($index); True:C214)
		OBJECT SET COORDINATES:C1248(*; "Label_"+String:C10($index); $l_x1; $l_y1; $l_x2; $l_y2)
		
		// ラベルのタイトルを設定する
		$label:=$item
		// ラベルの最初の文字を大文字にする
		$label[[1]]:=Uppercase:C13($label[[1]])
		OBJECT SET TITLE:C194(*; "Label_"+String:C10($index); $label+" :")
		
		// 入力フィールドを作成する
		OBJECT DUPLICATE:C1111(*; "Input"; "Input_"+String:C10($index))
		OBJECT SET VISIBLE:C603(*; "Input_"+String:C10($index); True:C214)
		OBJECT SET COORDINATES:C1248(*; "Input_"+String:C10($index); $i_x1; $i_y1; $i_x2; $i_y2)
		
		// データソースの数式を設定する
		$formula:=Formula from string:C1601("Form."+$item)
		OBJECT SET DATA SOURCE FORMULA:C1851(*; "Input_"+String:C10($index); $formula)
		
		// 新しい座標を計算する (フィールドごとに 30px のオフセット)
		$l_y1+=30
		$l_y2+=30
		$i_y1+=30
		$i_y2+=30
	End for each 
	
	
	// 動的フィールドのオブジェクトプールを管理する
	// 4D は動的に作成されたオブジェクトを削除できないため、プーリングパターンを使用する:
	// - オブジェクトは一度作成されると、種類の変更をまたいで再利用される
	// - 以前に作成した数より少ないフィールドが必要な場合、余分なオブジェクトは非表示になり、そのデータソースはクリアされる
	// - nbInputs はこれまでに作成されたフィールドの最大数を追跡し、次回の呼び出し時にいくつ非表示/表示にするかを把握する
	// 例: Company (7フィールド) から Person (5フィールド) に切り替えると、Label_6、Label_7、Input_6、Input_7 が非表示になる
	var $i : Integer
	If ($index<Form:C1466.nbInputs)
		// 不要になったフィールドを非表示にする
		For ($i; $index+1; Form:C1466.nbInputs)
			OBJECT SET VISIBLE:C603(*; "Label_"+String:C10($i); False:C215)
			OBJECT SET VISIBLE:C603(*; "Input_"+String:C10($i); False:C215)
			// 意図しないデータ更新を防ぐためにデータバインディングをクリアする
			OBJECT SET DATA SOURCE FORMULA:C1851(*; "Input_"+String:C10($i); Null:C1517)
		End for 
	Else 
		// 新しいフィールドが作成されたときに最大プールサイズを更新する
		Form:C1466.nbInputs:=$index
	End if 
	
	