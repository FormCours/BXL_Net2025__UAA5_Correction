# Épreuve UAA5

## Votre mission
Utiliser React pour réaliser un site Web qui permet :
- De consulter les parcours de formation.
- De s'inscrire aux séances d'information d'une formation.

Modifier la Web API pour :
- Implémenter la route `(GET) /api/Training/{id}/participant`.

## Description du frontend
L'application React doit comporter 4 pages :
- **Accueil**  
  Contenu : _Un titre, un slogan, une image (en background)_
- **Listing des formations**  
  Contenu : _La liste des prochaines formations disponibles_
- **Détail d'une formation**  
  Contenu : _Les informations d'une formation et un formulaire d'inscription_
- **À propos**  
  Contenu : _Page libre. Amusez-vous ^^_

### Contraintes
- Chaque page du site doit contenir un menu de navigation.
- Les données doivent être récupérées en consommant la Web API.
- Le site doit avoir une UX claire et être accessible.
- Le code doit être propre et commenté quand nécessaire.

## Description de la WebAPI
La Web API fournie possède les routes suivantes :
- `(GET) /api/Training/`  
  _Permet d'obtenir la liste des formations_
- `(GET) /api/Training/{id}`  
  _Permet d'obtenir les informations d'une formation_
- `(POST) /api/Training/{id}/participant`  
  _Permet de s'inscrire à la séance d'information d'une formation_
- `(GET) /api/Training/{id}/participant`  
  _Permet d'obtenir les inscrits d'une séance d'information d'une formation_

### Mise en place de la base de données
Le fichier `init-db.sql` permet d'initialiser la base de données `[uaa5_db]`.  
Renseigner la connection string dans le fichier `program.cs`.

### Modification à apporter
Implémenter la route `(GET) /api/Training/{id}/participant`.  
Cette route permet d'obtenir la liste des inscrits à une formation.

La liste des inscrits doit contenir les informations suivantes : Id, Email, RegistrationDate.  
Si une formation ne possède pas d'inscrits, la route envoie une liste vide.

Si la formation ciblée n'existe pas, la route doit envoyer une erreur 404.