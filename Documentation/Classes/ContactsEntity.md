# ContactsEntity Class

## Description

Entity class for the `Contacts` table. This class extends `Entity` and encapsulates the business logic for validating and persisting an individual contact.

**Main responsibilities:**
- Validate contact data before saving
- Save a contact to the database
- Delete a contact from the database

**Pattern used:** ORDA Entity Extension


## Functions

### Function saveContact()

Validates and saves the contact to the database.

```4d
Function saveContact : Object
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| Result | Object | Output | Object containing `success` (Boolean) and `statusText` (Text) in case of error |


### Function removeContact()

Deletes the contact from the database.

```4d
Function removeContact : Object
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| Result | Object | Output | Object containing `success` (Boolean) and `statusText` (Text) in case of error |