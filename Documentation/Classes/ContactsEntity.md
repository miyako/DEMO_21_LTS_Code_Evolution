# ContactsEntity クラス

## 説明

`Contacts` テーブル用のエンティティクラス。このクラスは `Entity` を継承し、個々の連絡先の検証および永続化に関するビジネスロジックをカプセル化します。

**主な役割:**
- 保存前に連絡先データを検証する
- 連絡先をデータベースに保存する
- 連絡先をデータベースから削除する

**使用パターン:** ORDA エンティティ拡張 (Entity Extension)


## 関数

### 関数 saveContact()

連絡先を検証し、データベースに保存します。

```4d
Function saveContact : Object
```

| 名前 | 型 | 入出力 | 説明 |
|------|------|:------------:|-------------|
| 戻り値 | Object | 出力 | エラーの場合に `success` (Boolean) と `statusText` (Text) を含む Object |


### 関数 removeContact()

データベースから連絡先を削除します。

```4d
Function removeContact : Object
```

| 名前 | 型 | 入出力 | 説明 |
|------|------|:------------:|-------------|
| 戻り値 | Object | 出力 | エラーの場合に `success` (Boolean) と `statusText` (Text) を含む Object |
