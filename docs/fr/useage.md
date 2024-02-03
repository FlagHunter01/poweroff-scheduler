---
title: Installation et utilisation
description: Guide à propos de l'installation et de l'utilisation du script. 
---

!!! warning "Privilèges administrateur"
    Les privilèges d'administrateur sont nécessaires pour l'installation et l'exécution du script.

## Installation

1. Commencez par ouvrir PowerShell en tant qu'administrateur et entrez la commande qui suit:
```ps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine
```
Entrez ensuite la lettre correspondant a "Oui". Vous devez appuiller sur ++enter++ après chaque commande que vous écrivez.

2. Téléchargez la dernière version du script et désarchivez-là. Le dossier de destination n'a pas d'importance mais le script ne devrait pas être accessible par les utilisateurs cibles.

## Utilisation

1. Notez le nom exact de l'utilisateur cible, tel qu'il apparait dans C:\Users\. Nous y ferons référence en temps que **username**. 
2. Ouvrez le dossier extrait et rendez vous dans le sous-dossier "french". Lancez le lanceur. Une fenêtre bleue devrait apparaitre avec le menu du script. 
3. En fonction de votre cas d'utilisation, suivez une de ses trois procédures.

=== "Créer ou mettre à jour l'horaire d'un utilisateur"
    
    Entrez `1`.

=== "Désactiver l'extinction pour un utilisateur"

    Entrez `2`.

=== "Supprimer le script du profil d'un utilisateur"

    Entrez `3`.

Si le script vous demande un nom d'utilisateur, entre le username retenu de l'étape 1. <br>
Si le script a déjà été lancé, il vous demandera si vous voulez continuer avec le dernier username utilisé. `Oui` est la réponse par défaut, vous pouvez refuser en entrant `n`.

!!! danger "S'enfermer hors de votre ordinateur"
    Si vous lancez le script vec votre propre compte ou le compte utilisateur comme cible, vous risquez de couper votre propre accès à l'ordinateur si vous êtes en dehors des heures d'activité que vous avez définies puisque l'ordinateur s'éteindra au moment de l'ouverture de votre session.

=== "Créer ou mettre à jour l'horaire d'un utilisateur"

    Pour chaque jour de la semaine, vous serez invité à entrer une limite pour le matin et l'après-midi. 
    L'ordinateur s'éteindra *avant* la limite du matin et *après* la limite de l'après-midi. 
    Par  exemple, si vous définissez la limite du matin pour 6h et la limite du soir pour 22h, l'ordinateur ne sera utilisable que *entre* 6h et 22h. 

    Pour entrer l'heure, merci d'utiliser le format `hhmm`. Par exmemple, 6h s'écrit `0600` et 22h `2200`. 0h1 est `0001` et 23h59 est `2359`. 

=== "Désactiver l'extinction pour un utilisateur"

    Le script sera toujours présent sur le profil de l'utilisateur cible, mais n'aura aucun effet (Les heures d'activité de l'ordinateur seront de minuit a minuit). 

    !!! note "Profil précédemment non affecé"
        Veuillez noter que si le profil cible n'était jusqu'à présent pas affecté par le script, alors le script sera écrit à ce profil.

=== "Supprimer le script du profil d'un utilisateur"

    Tous les fichiers liés au script seront supprimés du profil de l'utilisateur cible.

Si le script ne vous a pas demandé de redémarrer l'ordinateur ou que vous avez refusé de le faire, le menu principal est affiché à nouveau afin de vous permettre de faire une autre action ou de sortir en appuillant sur n'importe quelle lettre.

Si des messages d'erreur sont apparus (en rouge), c'est probablement dû à un mauvais username ou au fait que le script n'ait pas obtenu les privilèges d'administrateur.

## Limites

- Le script devrait fonctionner tant qu'il n'a pas été arrêté par une des actions citées plus haut.
Celà-dit, le script est contenu dans les dossiers du profil de l'utilisarteur cible. S'il est découvert, il peut doc être supprimé. 
- Le script utilise le temps système. Si le temps système diffère du temps réel, le script fonctionnera avec la fausse information. Celà-dit, changer le temps de système entraine beaucoup de dysfonctionnements, nottemment pôur les jeux en ligne. Il est donc peu probable qu l'utiisateur utilisera cette méthode de contournement.  
