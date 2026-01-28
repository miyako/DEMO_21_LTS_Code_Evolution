# Architecture du Projet DEMO_21_LTS_Code_Evolution

## Vue d'ensemble

Ce projet est une application de gestion de contacts développée en **4D v21**, showcasing modern UI patterns avec des fenêtres sémantiques, des formulaires dynamiques et une architecture orientée objet.

## Stack Technologique

- **Plateforme**: 4D v21
- **Extensions de fichiers**: 
  - `.4dm` - Méthodes 4D
  - `.4DForm` - Définitions de formulaires (format JSON)
  - `.4DCatalog` - Catalogue de la base de données
- **Accès aux données**: ORDA (Object Relational Data Access)
- **Architecture**: Formulaires orientés objet avec classes dédiées

## Structure des Répertoires

```
Project/Sources/
├── Classes/                        # Classes pour les formulaires
│   ├── ContactDetailForm.4dm       # Logique formulaire détail contact
│   ├── ContactListForm.4dm         # Logique liste des contacts
│   ├── Contacts.4dm                # Dataclass ORDA pour Contacts
│   └── ContactsEntity.4dm          # Entity ORDA pour Contact unique
│
├── DatabaseMethods/
│   └── onStartup.4dm               # Initialisation au démarrage
│
├── Forms/                          # Formulaires avec définitions JSON
│   ├── ContactDetail/              # Fenêtre palette (édition)
│   │   ├── form.4DForm             # Définition JSON du formulaire
│   │   ├── method.4dm              # Logique d'événement du formulaire
│   │   └── ObjectMethods/          # Gestionnaires d'événements
│   │       ├── BtnSave.4dm
│   │       └── InputType.4dm
│   │
│   └── ContactList/                # Fenêtre document (liste)
│       ├── form.4DForm             # Définition JSON du formulaire
│       ├── method.4dm              # Logique d'événement du formulaire
│       └── ObjectMethods/          # Gestionnaires d'événements
│           ├── BtnEdit.4dm
│           └── ...
│
└── Methods/                        # Méthodes projet réutilisables
    ├── __Start.4dm                 # Point d'entrée principal
    ├── _InitializeData.4dm         # Initialisation des données
    └── OpenContactList.4dm         # Ouverture de la liste

Data/                              # Fichiers de données
├── data.4DD                        # Données
├── data.4DIndx                     # Index
├── data.journal                    # Journal transactionnel
└── Logs/                           # Fichiers journaux
```

## Modèle de Données

### Dataclass: Contacts

**Attributs principaux**:
- `ID` (Number) - Clé primaire
- `Name` (Text) - Nom complet
- `Type` (Text) - "Person" ou "Company"
- `Email` (Text)
- `Phone` (Text)
- `Position` (Text) - Fonction (visible pour les personnes)
- `Website` (Text) - Site web (visible pour les sociétés)

### Architecture ORDA

```4d
ds.Contacts                          // Accès à la dataclass
ds.Contacts.all()                    // Tous les contacts (EntitySelection)
ds.Contacts.new()                    // Nouveau contact (Entity)
```

## Architecture des Formulaires

### Pattern: Formulaires Orientés Objet

Les formulaires sont liés à des instances de classes via l'objet `Form` :

```4d
// Ouverture du formulaire avec classe
$formData:=cs.ContactListForm.new()
DIALOG("ContactList"; $formData)

// Dans le formulaire, accès via: Form.contacts, Form.onRowClick()
```

### ContactListForm (Classe)

**Responsabilités**:
- Charge la liste complète des contacts via ORDA
- Gère la sélection de ligne
- Expose la méthode `onRowClick()` pour édition

**Propriétés exposées**:
- `contacts` (EntitySelection) - Tous les contacts
- `selectedIndex` (Number) - Indice de la ligne sélectionnée

### ContactDetailForm (Classe)

**Responsabilités**:
- Édition d'un contact existant ou création
- Gère l'alternance Person/Company
- Valide et persiste les modifications

**Propriétés exposées**:
- `entity` (Entity) - Contact courant
- `isCompany` (Boolean) - Type = "Company"
- `isPerson` (Boolean) - Type = "Person"
- `updateType()` - Change le type et recalcule les propriétés

## Patterns Architecturaux

### 1. Fenêtres Sémantiques

Trois types de fenêtres avec comportements distincts:

```4d
// Fenêtre Document (principale, peut être réduite)
Open form window("ContactList"; Plain form window; ...)

// Fenêtre Palette (flottante, reste en avant)
Open form window("ContactDetail"; Palette form window; ...)

// Fenêtre Outil (compacte, bouton de barre d'outils sur macOS)
Open form window("QuickAdd"; Movable form window+Has toolbar button window; ...)
```

### 2. Visibilité Dynamique des Champs

Les champs s'affichent/se masquent selon l'état des données via expressions JSON:

```json
{
  "InputCompany": {
    "visibility": "Form.isCompany"
  },
  "InputPosition": {
    "visibility": "Form.isPerson"
  }
}
```

Quand le type change, `Form.updateType()` recalcule les flags booléens, déclenchant les mises à jour UI automatiques.

### 3. Liaison de Données (Data Binding)

Les objets formulaire se lient via la propriété `dataSource`:

```json
{
  "nameInput": {
    "dataSource": "Form:C1466.entity.Name"
  }
}
```

### 4. Gestion d'Événements

Les méthodes d'objet réagissent aux événements utilisateur:

```4d
// Dans ObjectMethods/BtnSave.4dm
Case of 
  : (Form event code=On Clicked)
    Form.saveContact()
End case
```

**Événements courants**:
- `On Load` - Chargement du formulaire
- `On Clicked` - Clic sur un bouton
- `On Data Change` - Modification de donnée
- `On Double Clicked` - Double-clic sur ligne

## Flux d'Utilisation Principal

1. **Démarrage** (`__Start.4dm`)
   - Lance `onStartup` qui initialise 5 contacts de démonstration
   - Ouvre `ContactList`

2. **Liste des Contacts** (`ContactList`)
   - Affiche tous les contacts
   - Double-clic sur une ligne déclenche `BtnEdit.onRowClick()`

3. **Détail du Contact** (`ContactDetail` - Palette)
   - Édition du contact sélectionné
   - Visibilité dynamique selon Type
   - Clic "Enregistrer" persiste via ORDA

## Conventions de Nommage

| Type | Convention | Exemple |
|------|-----------|---------|
| Classes | PascalCase | `ContactDetailForm` |
| Méthodes projet | PascalCase | `OpenContactList` |
| Méthodes privées | Préfixe `_` | `_InitializeData` |
| Méthodes d'objet | D'après l'objet | `BtnSave.4dm` |
| Propriétés booléennes | Préfixe `is` | `isCompany`, `isPerson` |

## Points Critiques

- **Pas de SQL**: Utiliser exclusivement ORDA (`ds.TableName`)
- **Formulaires JSON**: Structure définie dans `.4DForm`, pas en code
- **Codes de langage**: 4D utilise des codes numériques (ex: `:C1466` pour `Form`)
- **Pas de SQL imbriqué**: Données uniquement via entités ORDA

## Initialisation des Données

Quand la base est vide, `onStartup.4dm` crée 5 contacts de démonstration:

```4d
CREATE WITH DEFAULT VALUES
  Name = "Alice Johnson" / Type = "Person"
  Name = "Bob Smith" / Type = "Person"
  Name = "Acme Corp" / Type = "Company"
  ...
```

## Points d'Extension

### Ajouter un Nouveau Champ au Contact

1. Modifier le catalogue dans l'éditeur de structure
2. Ajouter la propriété à `ContactsEntity` 
3. Ajouter le contrôle UI à `ContactDetail/form.4DForm`
4. Lier via `dataSource`: `"Form:C1466.entity.newField"`

### Créer un Nouveau Formulaire

1. Ajouter une classe dans `Classes/`
2. Créer un dossier dans `Forms/` avec `form.4DForm`
3. Créer une méthode d'ouverture dans `Methods/`

## Ressources

- [Documentation 4D v21](https://doc.4d.com/4Dv21)
- [Guide ORDA](https://doc.4d.com/4Dv21/4D/21/ORDA.201-7228401.en.html)
