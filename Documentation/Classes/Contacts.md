# Contacts クラス

## 説明

`Contacts` テーブル用の DataClass。このクラスは `DataClass` を継承し、データベース内の連絡先の読み込みと検索のためのビジネスメソッドを提供します。

**主な役割:**
- すべての連絡先を読み込む
- 名前または会社名で連絡先をフィルタリングする (テキスト検索)

**使用パターン:** ORDA DataClass 拡張 (DataClass Extension)

---

## 関数

### 関数 load()

データベースから連絡先を読み込みます。テキスト検索によるフィルタリングのオプションがあります。

```4d
Function load($search : Text) : cs.ContactsSelection
```

| 名前 | 型 | 入出力 | 説明 |
|------|------|:------------:|-------------|
| `$search` | Text | 入力 | 検索テキスト。空 (`""`) の場合: すべての連絡先を返します。それ以外の場合: `Name` または `Company` に検索テキストが含まれる連絡先をフィルタリングします |
| 戻り値 | cs.ContactsSelection | 出力 | 名前でソートされたエンティティセレクション (Entity selection) |
