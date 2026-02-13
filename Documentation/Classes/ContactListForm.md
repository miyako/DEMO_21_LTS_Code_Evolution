# ContactListForm Class

## Description

Form controller for managing the contact list. This class encapsulates the business logic for displaying, filtering, creating, and deleting contacts. It also handles synchronization between the user selection and the database.

**Main responsibilities:**
- Load all contacts from the database
- Manage contact selection in the ListBox
- Create a new contact
- Edit an existing contact
- Delete a contact
- Refresh the list after modifications

**Pattern used:** Form Controller Pattern (MVC)

---

## Properties

| Property | Type | Description |
|----------|------|-------------|
| `contacts` | cs.ContactsSelection | All loaded contacts, sorted by name |
| `selection` | cs.ContactsSelection | Contacts filtered by search or criteria |
| `selectedContact` | cs.ContactsEntity | Currently selected contact for editing |
| `delaySearch` | Integer | Delay in ms before executing the search (debounce) |
| `search` | Text | Current search text |


## Functions

### Constructor

Initializes the form controller and loads all contacts.

```4d
Class constructor()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters |


### Function loadContacts()

Loads all contacts from the database and displays them in the ListBox.

```4d
Function loadContacts()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |


### Function onEditContact()

Opens the detail form in edit mode for the selected contact.

```4d
Function onEditContact()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |



### Function onNewContact()

Creates a new contact by opening the detail form in creation mode.

```4d
Function onNewContact()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |


### Function onRemoveContact()

Deletes the selected contact after confirmation.

```4d
Function onRemoveContact()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |