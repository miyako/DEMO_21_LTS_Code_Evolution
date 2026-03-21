//%attributes = {}
Case of 
	: (Count parameters:C259=0)
		var $ps:=New process:C317(Current method name:C684; 0; Current method name:C684; 0)
		
	Else 
		// サンプルデータで初期化
		_InitializeData
		
		// メイン画面を表示
		OpenContactList
End case 