# Copilot Instructions for Form_21 4D Project

## Project Overview
This is a **4D v21** contact management demo application showcasing modern UI patterns including semantic windows, dynamic forms, and object-oriented form design. The project demonstrates three window types (Document, Palette, Tool) with icon customization and conditional field visibility.

## Technology Stack
- **Platform**: 4D v21 (4D language)
- **File Extensions**: `.4dm` (4D methods), `.4DForm` (JSON form definitions)
- **Data Access**: ORDA (Object Relational Data Access) via `ds.Contacts`
- **Architecture**: Object-oriented forms with dedicated form classes

## Project Structure

```
Project/Sources/
├── Classes/              # Form classes for data binding and logic
│   ├── ContactForm.4dm          # Handles single contact (detail/create)
│   └── ContactListForm.4dm      # Handles contact list view
├── DatabaseMethods/
│   └── onStartup.4dm            # Auto-runs on app launch
├── Forms/                # JSON form definitions + methods
│   ├── ContactDetail/           # Palette window (edit contact)
│   ├── ContactList/             # Document window (main list)
│   └── ObjectMethods/           # Event handlers for form objects
└── Methods/              # Reusable project methods
    ├── OpenContactForm.4dm      # Opens contact detail window
    └── OpenContactList.4dm      # Opens main list window
```

## Key Architectural Patterns

### 1. Form Classes (Object-Oriented Forms)
Forms bind to class instances via `Form` object. Classes handle state and business logic:

```4d
// In OpenContactList.4dm
$formData:=cs.ContactListForm.new()
DIALOG("ContactList"; $formData)

// In form, access via: Form.contacts, Form.onRowClick()
```

- **ContactListForm**: Manages ORDA EntitySelection (`ds.Contacts.all()`)
- **ContactForm**: Wraps single entity with calculated properties (`isCompany`, `isPerson`)
- Classes use `property` declarations for type hints and IDE autocompletion

### 2. Dynamic Forms with Conditional Visibility
Fields show/hide based on data state using JSON `visibility` expressions:

```json
{
  "InputCompany": {
    "visibility": "Form.isCompany"  // Visible only for companies
  },
  "InputPosition": {
    "visibility": "Form.isPerson"   // Visible only for persons
  }
}
```

When type changes, `Form.updateType()` recalculates boolean flags, triggering automatic UI updates.

### 3. Semantic Windows
Each window type has distinct behavior and icons:

```4d
// Document window (main, can minimize)
Open form window("ContactList"; Plain form window; ...)

// Palette window (floating, stays on top)
Open form window("ContactDetail"; Palette form window; ...)

// Tool window (compact, toolbar button on macOS)
Open form window("QuickAdd"; Movable form window+Has toolbar button window; ...)
```

Icons set via `SET WINDOW DOCUMENT ICON($winRef; $iconPath)` using PNG resources.

## Critical Development Patterns

### ORDA Entity Access
Always use `ds.TableName` to access dataclasses:
```4d
$contacts:=ds.Contacts.all()           // EntitySelection
$contact:=ds.Contacts.new()            // New entity
$contact.Name:="John"
$contact.save()                        // Persist
```

### Form Data Binding
- Form objects bind via `dataSource` property: `"dataSource": "Form:C1466.name"`
- Methods access form via `Form` object (implicit parameter)
- Event handlers in `ObjectMethods/` folder trigger on UI interactions

### Method Naming Conventions
- **DatabaseMethods**: Special lifecycle methods (`onStartup.4dm`)
- **Object Methods**: Named after form objects (e.g., `BtnSave.4dm`, `InputType.4dm`)
- **Project Methods**: PascalCase (e.g., `OpenContactForm`, `OpenContactList`)

### Event Handling
Object methods check form events:
```4d
// In ContactList/method.4dm
Case of 
  : (Form event code=On Double Clicked)
    Form.onRowClick()
End case
```

Common events: `On Load`, `On Clicked`, `On Data Change`, `On Double Clicked`

## Running the Application

1. **Launch**: Open `Form_21.4DProject` in 4D v21, press Cmd+R (Mac) or Ctrl+R (Windows)
2. **Auto-initialization**: `onStartup.4dm` creates 5 demo contacts if database empty
3. **Main window**: ContactList opens automatically on startup
4. **Workflow**: Double-click contact → opens ContactDetail palette window

## Important Constraints

- **No SQL**: Use ORDA exclusively (`ds.TableName` not `SELECT * FROM`)
- **JSON Forms**: Form structure defined in `.4DForm` JSON files, not code
- **Language Codes**: 4D uses numeric codes (e.g., `:C1466` for `Form`, `:C1470` for `This`)


## Common Tasks

**Add a new field to Contact table**:
1. Modify catalog in Structure editor
2. Add property to `ContactForm` class
3. Add UI control to `ContactDetail/form.4DForm`
4. Bind via `dataSource`: `"Form:C1466.newField"`

**Create a new form**:
1. Add class in `Classes/` (extend form logic)
2. Create folder in `Forms/` with `form.4DForm`
3. Create opener method in `Methods/` using `Open form window` + `DIALOG`

**Debug**: Use `TRACE` command to set breakpoints. 4D opens debugger at runtime.

## References
- 4D Documentation: https://doc.4d.com/4Dv21
