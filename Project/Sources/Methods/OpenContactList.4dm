//%attributes = {}
// メイン画面を表示

// ContactListFormクラスのインスタンスでFormデータを管理
var $formData:=cs:C1710.ContactListForm.new()

// Formデータを渡してContactListフォームを表示
var $winRef:=Open form window:C675("ContactList"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4; *)
DIALOG:C40("ContactList"; $formData)
CLOSE WINDOW:C154($winRef)