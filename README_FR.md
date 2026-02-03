🇬🇧 English version available [here](README.md)
* * *
# Présentation du projet `update_my_newbie_commit_author`
## Description

Ce script vous aide à **mettre à jour l’auteur et le committer des anciens commits Git**.

Lorsque vous avez commencé à utiliser Git, il est possible que vous ayez fait des commits avec un mauvais nom ou une mauvaise adresse email, à cause de `.gitconfig` mal configuré car vous êtes un gros noob.
Ce script vous permet de corriger ces anciens commits sans perdre l’historique, tout en gardant un dépôt propre et cohérent.

Il utilise `git filter-repo` pour remplacer de manière sécurisée les anciens noms et emails par les bons.

**De ça :**  
![from this](docs/from_this.png) 

**A ça :**  
![to this](docs/to_this.png) 

### Arguments

Le script prend 3 arguments :
1. `Fichier de configuration Python` : contient les listes `BAD_EMAILS` et `BAD_NAMES` à remplacer, ainsi que `RIGHT_NAME` et `RIGHT_EMAIL` qui serviront de remplacement. Le fichier `my_newbie_commit_author.py` déjà fourni : il suffit de le compléter avec vos propres informations.
2. `URL du dépôt Git` : le dépôt distant sur lequel vous souhaitez pousser les modifications (SSH ou HTTPS).
3. `Chemin vers le dépôt local` : le chemin vers le dépôt Git que vous voulez mettre à jour.

*⚠️ Important : assurez-vous que le chemin du dépôt local et l’URL du dépôt distant correspondent bien au même dépôt, sinon l’ajout du remote échouera.*

### Avertissements

- Ce script **réécrit l’historique Git**. Toute personne ayant déjà cloné le dépôt devra le re-cloner après l’exécution du script.
- **Sauvegardez toujours votre dépôt** avant d’exécuter le script.
- Assurez-vous d’avoir les **droits d’écriture** sur le dépôt Git.
- `git filter-repo` doit être installé sur votre machine.
- Il est fortement recommandé de tester d’abord sur un clone ou d’utiliser un **dry-run** afin d’éviter toute perte de données accidentelle.

* * *
## Langages & Technologies

**Langage**
- Python
- Bash

**Technologies**
- git

* * *
# Utilisation de `update_my_newbie_commit_author`

## **Comment utiliser `update_my_newbie_commit_author`**

1. Clonez `update_my_newbie_commit_author` dans un dossier : `git clone https://github.com/bibickette/update_my_newbie_commit_author.git`
2. Déplacez-vous dans le dépôt : `cd update_my_newbie_commit_author`
3. Préparez votre fichier de configuration Python (`my_newbie_commit_author.py`), ouvrez le fichier pour plus de détails
4. Vous pouvez maintenant exécuter `./update_my_newbie_commit_author.sh my_newbie_commit_author.py git@github.com:username/repo.git /chemin/vers/repo/local` pour changer vos anciens commits réalisés avec un nom ou une adresse email incorrects.


### Améliorations / Travaux futurs

Ce projet est toujours en cours de développement. Les améliorations futures pourraient inclure :
- Sauvegarde automatique du dépôt avant la réécriture de l’historique
- Mode dry-run pour prévisualiser les changements
- Validation plus poussée du fichier de configuration Python
- Gestion plus sécurisée des remotes afin d’éviter les pushes accidentels