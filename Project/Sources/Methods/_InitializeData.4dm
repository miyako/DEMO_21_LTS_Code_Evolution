//%attributes = {"invisible":true}
//%attributes = {"invisible":true}
// サンプルデータで初期化

var $contact : Object

// データがすでに存在するかどうかを確認
If (ds:C1482.Contacts.all().length=0)
	
	// デモ用の連絡先を作成
	
	// 連絡先 1: 個人
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="ソフィー・マルタン"
	$contact.Email:="sophie.martin@example.com"
	$contact.Phone:="+33 6 12 34 56 78"
	$contact.Type:="Person"
	$contact.Company:="テック・イノベーションズ"
	$contact.Position:="シニアデベロッパー"
	$contact.Address:="レピュブリック通り15番地\n75001 パリ"
	$contact.Notes:="XYZプロジェクトの主な連絡先"
	$contact.save()
	
	// 連絡先 2: 会社
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="デジタル・ソリューションズ SARL"
	$contact.Email:="contact@digitalsolutions.com"
	$contact.Phone:="+33 1 23 45 67 89"
	$contact.Type:="Company"
	$contact.Company:="デジタル・ソリューションズ SARL"
	$contact.Position:=""
	$contact.Address:="シャンゼリゼ通り42番地\n75008 パリ"
	$contact.Notes:="2022年来の顧客 - 有効な保守契約あり"
	$contact.save()
	
	// 連絡先 3: 個人
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="ジャン・デュポン"
	$contact.Email:="jean.dupont@company.com"
	$contact.Phone:="+33 6 98 76 54 32"
	$contact.Type:="Person"
	$contact.Company:="コンサルティング・プロ"
	$contact.Position:="プロジェクトマネージャー"
	$contact.Address:="オスマン通り8番地\n75009 パリ"
	$contact.Notes:="月曜～水曜に対応可能"
	$contact.save()
	
	// 連絡先 4: 会社
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="ウェブデザイン・スタジオ"
	$contact.Email:="info@webdesignstudio.com"
	$contact.Phone:="+33 1 45 67 89 01"
	$contact.Type:="Company"
	$contact.Company:="ウェブデザイン・スタジオ"
	$contact.Position:=""
	$contact.Address:="フォーブール・サンタントワーヌ通り25番地\n75011 パリ"
	$contact.Notes:="デザインパートナー - ご要望に応じてポートフォリオを提供可能"
	$contact.save()
	
	// 連絡先 5: 個人
	$contact:=ds:C1482.Contacts.new()
	$contact.Name:="マリー・ルクレール"
	$contact.Email:="marie.leclerc@startup.io"
	$contact.Phone:="+33 7 11 22 33 44"
	$contact.Type:="Person"
	$contact.Company:="スタートアップラボ"
	$contact.Position:="CEO 兼 創業者"
	$contact.Address:="Station F\n75013 パリ"
	$contact.Notes:="当社のAIソリューションに関心あり"
	$contact.save()
	
End if 