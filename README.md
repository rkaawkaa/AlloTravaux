# AlloTravaux

## Présentation du projet

Cette application permet de créer des projets de travaux de rénovation et de réparation et de prendre contact avec des artisans pour les réaliser.
L'application est en cours de développement.

## Logo

![Image text](https://cdn.discordapp.com/attachments/1039893817995837440/1061999430632484964/magnifique_logo_du_meilleur_groupe_de_projet_flutter_allo_pas_resto_mais_travaux.png)

## Technologies

* [Flutter](https://flutter.dev/) : Version 3.3.8
* [Shared Preferences](https://pub.dev/packages/shared_preferences) : Version 2.0.15
* [Flutter Chat UI](https://pub.dev/packages/flutter_chat_ui) : Version 1.6.6

## Règles de nommage des branches

Les branches sont nommées avec le format {NUMERO_DE_SPRINT}-{NOM_DE_LA_PAGE}-{FONCTIONNALITE}. 
Par exemple, la branche 01-Projets-RechercheArtisan se réfère au premier sprint, à la recherche des artisans sur la page de projets.

## Règles de nommage des commits :

Nos commits doivent décrire ce qui a été modifié et pourquoi en indiquant le contexte.  
Pour pouvoir écrire convenablement un commit, celui-ci doit porter sur un objectif simple. Si l'on développe plusieurs choses, il faut donc faire plusieurs commits. De la sorte, le nommage du commit sera simplifié et pourra respecter la règle de ne pas excéder environ 60 caractères. (ceci est arbitraire.)
Les messages de commits sont rédigés en français.

Nos règles de nommages de commits suit cette logique : il y'a d'abord un préfixe qui fait référence à la métadonnée du numéro d'itération du sprint. 
 Puis il indique un verbe d'action au présent indiquant ce qui est fait : "Correctif" pour le réglage d'un bug, "Style" pour le changement de styles d'élements sans modification fonctionnel, "Ajout" pour un ajout d'une fonctionnalité, "MAJ" pour une mise à jour etc. 

Ainsi, voilà quelques bons exemples de commit :  
01- Style : Changement du style du bouton Valider pour la page "Création d'un projet"

02- Correctif : Charger les données sur la page "Mes Projets"

## Règles de nommage des variables, fonctions et classes: 

Le nom des classes commencent par une majuscule et chaque nouveau mot de la classe commençent par une majuscule également. Il n'y a ni tirets ni underscore. 
Exemple : ArtisanCardComponent.
Les classes correspondant à des composants sont suffixés par "Component", comme par exemple :
ButtonComponent, NavigationBarComponent.  

Le nom des fichiers doit être le même que celui de la classe qu'il réprésente sauf écrit dans un autre format: les mots sont écrits tous en miniscules et entre deux mots, on mets un underscore _.  

Les noms des méthodes commencent par une miniscule et suit sinon la même convention que pour les classes, comme par exemple :
createRoute, onItemTapped.

Le nom des variables suit la même convention que celles des méthodes comme par exemple:
indexSelected.
Pour les variables privés, on préfixe le nom d'un underscore comme : _title. 


De manière générale, les noms de variables, fonctions et classes doivent être auto-descriptifs et décrire leur utilité et ce qu'elles réprésentent et non pas une version de ce qu'elles pourraient répresenter (il faut mieux appeler une instance de Color PrimaryColor que PinkColor). Elles doivent indiquées clairement à celui qui les lit de quoi il s'agit.
Cependant, si certaines portions de codes sont difficiles à comprendre malgré de bons nommages, il faut l'agrémenter de bons commentaires explicatifs.

## Comment travaillons nous ?

Nous sommes un groupe de 5 et travaillons chacun sur une fonctionnalité différente ou par groupe de 2 sur une même fonctionnalité. Cependant, chacun ayant des facilités et compétences sur des domaines différents de Flutter, dans un souci de productivité générale, nous privilégions de beaucoup communiquer et nous nous entraidons beaucoup.

Le chef de projet est Maxime RUFFRAY et le scrum master Robin KAWKA.

Chaque matin, nous avons une réunion courte où chacun expose ses difficultés et nous mettons en place les objectifs de la journée. 

Pour chaque fonctionnalité à développer, on crée une branche respectant les bonnes règles de nommage. On effectue de bons commits et une fois la fonctionnalité terminé, on récupère éventuellement les nouvelles modifications de la branche main en local, on règle les éventuels conflits en local puis on push notre branche sans conflits en local sur la branche de même nom sur GitLab. En dernière étape,on fait une merge request sur GitLab pour intégrer nos changements à la branche principale. L'un de nos collègues va vérifier nos modifications et accepter ou non le merge sur le branche principale.



## Commant lancer notre application

Si vous êtes dans la liste des développeurs
- Acceptez l'invitation : [ ] [Lien de l'APK sur le PlayStore](https://play.google.com/apps/internaltest/4701328031854448885) **déprécié**
- Télécharger et installez
- Enjoy the fun

Si vous souhaitez récuperer et développer le projet
- Installer flutter et un IDE adéquate (Visual Studio Code)
- git clone https://github.com/rkaawkaa/AlloTravaux
- Ouvrir le dossier / projet
- flutter get pub
- flutter run

Vous pouvez ensuite lancer l'application sur un émulateur ou bien sur votre téléphone directement en l'installant via un cable.
