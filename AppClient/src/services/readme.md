# Gestion des erreurs des services

Deux solutions peuvent être envisagé : 
 - Laisser l'exception se propager et la gérer lors de l'utilisation du service
 - Mettre en place un pattern "Result" qui traiter l'erreur dans le service

Idéalement, vous devez gerer toutes les exceptions de la même facon.


## Propagation d'exception
Le service peut générer une exception qui doit être traiter par le front

### Avantage
- Code du service plus simple
- Gestion au cas par cas de l'erreur
- Possibilité de customiser l'exception

### Inconvénient
- Necessité de mettre en place une gestion d'erreur lors de chaque utilisation
- Risque que l'app plante en cas d'oublie
- Code potentiel dupliqué (Meme gestion dans plusieurs zone)


## Pattern Result
Le service DOIT gérer l'exception et renvoyer une resultat avec une valeur "success"

### Avantage
- Toutes les exceptions sont traiter de maniere centraliser
- Gestion unique des erreurs
- Lors de l'utilisation, il suffit de tester un boolean

### Inconvénient
- Chaque service DOIT traiter TOUTES les erreurs possibles
- Les services sont plus complexe (Renvoyer un objet : {success, data, error })
