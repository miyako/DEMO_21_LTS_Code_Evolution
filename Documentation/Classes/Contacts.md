# Contacts Class

## Description

DataClass for the `Contacts` table. This class extends `DataClass` and provides business methods for loading and searching contacts in the database.

**Main responsibilities:**
- Load all contacts
- Filter contacts by name or company (text search)

**Pattern used:** ORDA DataClass Extension

---

## Functions

### Function load()

Loads contacts from the database, with the option to filter by text search.

```4d
Function load($search : Text) : cs.ContactsSelection
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| `$search` | Text | Input | Search text. If empty (`""`) : returns all contacts. Otherwise : filters contacts whose `Name` or `Company` contains the searched text |
| Result | cs.ContactsSelection | Output | Entity selection sorted by name |
