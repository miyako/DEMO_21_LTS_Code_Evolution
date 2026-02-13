# ContactDetailForm Class

## Description

Form controller for managing contact details. This class encapsulates the business logic for creating, editing, and displaying a single contact. It also handles dynamic field display based on the contact type (Person or Company).

**Main responsibilities:**
- Initialize and load contact data
- Handle type changes (Person/Company)
- Dynamically create form fields
- Save changes to the database

**Pattern used:** Form Controller Pattern (MVC)


## Properties

### Business properties (form)

| Property | Type | Description |
|----------|------|-------------|
| `name` | Text | Contact name or manager name (for a company) |
| `email` | Text | Contact email address |
| `phone` | Text | Phone number |
| `type` | Text | Contact type: `"Person"` or `"Company"` |
| `company` | Text | Company name |
| `position` | Text | Job title or role (for a person in a company) |
| `address` | Text | Full address |
| `notes` | Text | Additional notes or remarks |

### Persistence and state properties

| Property | Type | Description |
|----------|------|-------------|
| `contact` | cs.ContactsEntity | Reference to the `Contacts` entity in the database |
| `isNew` | Boolean | `True` if the contact is being created, `False` otherwise |

### Dynamic UI properties

| Property | Type | Description |
|----------|------|-------------|
| `isCompany` | Boolean | `True` if the type is `Company` |
| `isPerson` | Boolean | `True` if the type is `Person` |
| `attributes` | Collection | Ordered list of fields to display dynamically |
| `nbInputs` | Integer | Maximum number of dynamic fields already created (pool) |


## Functions

### Constructor

Initializes the form controller with an existing contact or creates a new contact.

```4d
Class constructor($obj : cs.ContactsEntity)
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| `$obj` | cs.ContactsEntity \| Null | Input | Contact entity to edit. If `Null`: creates a new empty contact |


### Function save()

Saves the contact to the database. Creates a new entity when in creation mode, updates the existing one when editing.

```4d
Function save()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |


### Function updateType()

Updates the contact type and prepares the list of fields to display.
This collection is then used by `createDynamicFields()` to generate the interface.

**Signature:**
```4d
Function updateType()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |


### Function createDynamicFields()

Dynamically creates and updates form fields based on the contact type.

```4d
Function createDynamicFields()
```

| Name | Type | Input/Output | Description |
|------|------|:------------:|-------------|
| — | — | — | No parameters, no return value |
