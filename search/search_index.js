var __index = {"config":{"lang":["en"],"separator":"[\\s\\-]+","pipeline":["stopWordFilter"],"fields":{"title":{"boost":1000.0},"text":{"boost":1.0},"tags":{"boost":1000000.0}}},"docs":[{"location":"index.html","title":"Poweroff scheduler","text":"<p> Download the latest version</p>"},{"location":"index.html#what-is-this-for","title":"What is this for ?","text":"<p>The idea behind this script is to create the ultimate screentime limiter. </p> <p>For a given user, this script allows you to set limits, shutting down the computer if it is too early or too late. </p> <p>Admin privileges are needed to install this script.</p>"},{"location":"index.html#features","title":"Features","text":"<ul> <li> Define custom morning and evening limits for every day of the week.<ul> <li> Windows will shut down if the time is before the morning or after the afternoon limit. </li> <li> User sensitive: customize the schedule for multiple users.</li> </ul> </li> <li> Easely disable or delete the script for a user.</li> </ul> <p>Hop on the next page to get started!</p>"},{"location":"useage.html","title":"Installation and useage","text":"<p>Admin privileges</p> <p>Admin privileges are required for both the installation and execution of this script.</p>"},{"location":"useage.html#installation","title":"Installation","text":"<ol> <li> <p>First, open PowerShell with admin privileges and past this command: <pre><code>Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine\n</code></pre> Then press the letter corresponding to \"Yes\". You have to press Enter after each command you write.</p> </li> <li> <p>Download the latest version of the script and unpack it. The destination folder can be anywhere but you should not make it accessible by the target users. </p> </li> </ol>"},{"location":"useage.html#useage","title":"Useage","text":"<ol> <li>Take note of the exact name of the target user, as it can be seen in C:\\Users. This will be referred to as the username. </li> <li>Open the unpacked folder and launch the launcher. A blue window should appear with the main menu of the script. </li> <li>Depending of your use case, follow one of these three procedures.</li> </ol> Create or update a schedule for a userDisable the poweroffs for a userDelete the script from a user's profile <p>Enter <code>1</code>.</p> <p>Enter <code>2</code>.</p> <p>Enter <code>3</code>.</p> <p>When the script prompts you for a username, enter the one from step 1.  If the script was already used, it will give ask you if you want to proceed with the last used username. <code>Yes</code> is the default answer, you can decline by entering <code>n</code>.</p> <p>Locking yourself out</p> <p>If you run the script with your own account or the admin account as a target, you will effectively lock yourself out if you are outside of the working hours you specified as the computer will shut down uppon login.</p> Create or update a schedule for a userDisable the poweroffs for a userDelete the script from a user's profile <p>For each day of the week, you will be prompted for a morning limit and an afternoon limit. Keep in mind that the computer will shut down before the morning limit and after the afternoon limit.  For example, if you set the morning limit at 6 AM and the afternoon limit at 10 PM, the computer will be useable between 6 AM and 10 PM. </p> <p>To enter the time, please use the <code>hhmm</code> format. For example, 6 AM is <code>0600</code> and 10PM is <code>2200</code>. 0:1 AM is <code>0001</code> and 11:59 PM is <code>2359</code>. </p> <p>The script will still be present in the user's profile, but it will have no effect on the computer (the working hours will be set from 0 AM to 12 PM). </p> <p>Previously unmonitored user</p> <p>Please note that if this action is carried out for a user that was previously unaffected by the script, the script will be written to their profile.</p> <p>All files related to the script will be removed from the target profile.</p> <p>If you weren't asked to reboot or declined to do so, the script returns to the main menu so you can do another action, or exit by entering any letter. </p> <p>If any error messages appeared (in red), it probably means that the username was wrong or the script didn't have admin privileges.</p>"},{"location":"useage.html#limits","title":"Limits","text":"<ul> <li>The script should function until it is disabled via the forementionned actions. Nevertheless, it is located in the user's folder (C:\\). If the user finds the location of the script, they can delete it.  <li>The script uses the system time. If the system time differs from the actual time, the script will function with false data. However, changing the system time breaks a lot of time-based processes like online games, so it is unlikely that the user will resort to this action. </li>"},{"location":"fr/index.html","title":"Poweroff scheduler","text":"<p> T\u00e9l\u00e9chargez la derni\u00e8re version</p>"},{"location":"fr/index.html#a-quoi-ca-sert","title":"A quoi \u00e7a sert ?","text":"<p>L'id\u00e9e derri\u00e8re ce script est de cr\u00e9er le limiteur de temps d'\u00e9cran ultime.</p> <p>Pour un utilisateur donn\u00e9, ce script permet de d\u00e9finir des limites temporelles en dehors desquelles l'ordinateur s'\u00e9teindra.</p> <p>Les privil\u00e8ges d'administrateur sont n\u00e9cessaires pour installer ce script.</p>"},{"location":"fr/index.html#fonctionnalites","title":"Fonctionnalit\u00e9s","text":"<ul> <li> D\u00e9finissez des limites du matin et de l'apr\u00e8s-midi personnalis\u00e9es pour chaque jour de la semaine.<ul> <li> Windows s'\u00e9teindra avant la limite du matin et apr\u00e8s la limite de l'apr\u00e8s-midi.</li> <li> Sensible \u00e0 l'utilisateur: d\u00e9finissez des horaires personnalis\u00e9s pour chaque utilisateur.</li> </ul> </li> <li> Arr\u00eatez ou supprimez le script facilement pour un utilisateur donn\u00e9.</li> </ul> <p>Allez \u00e0 la page suivante pour commencer!</p>"},{"location":"fr/useage.html","title":"Installation et utilisation","text":"<p>Privil\u00e8ges administrateur</p> <p>Les privil\u00e8ges d'administrateur sont n\u00e9cessaires pour l'installation et l'ex\u00e9cution du script.</p>"},{"location":"fr/useage.html#installation","title":"Installation","text":"<ol> <li> <p>Commencez par ouvrir PowerShell en tant qu'administrateur et entrez la commande qui suit: <pre><code>Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine\n</code></pre> Entrez ensuite la lettre correspondant \u00e0 \"Oui\". Vous devez appuyer sur Enter apr\u00e8s chaque commande que vous \u00e9crivez.</p> </li> <li> <p>T\u00e9l\u00e9chargez la derni\u00e8re version du script et d\u00e9sarchivez-l\u00e0. Le dossier de destination n'a pas d'importance mais le script ne devrait pas \u00eatre accessible par les utilisateurs cibles.</p> </li> </ol>"},{"location":"fr/useage.html#utilisation","title":"Utilisation","text":"<ol> <li>Notez le nom exact de l'utilisateur cible, tel qu'il apparait dans C:\\Users. Nous y ferons r\u00e9f\u00e9rence en temps que username.</li> <li>Ouvrez le dossier extrait et rendez vous dans le sous-dossier \"french\". Lancez le lanceur. Une fen\u00eatre bleue devrait apparaitre avec le menu du script.</li> <li>En fonction de votre cas d'utilisation, suivez une de ces trois proc\u00e9dures.</li> </ol> Cr\u00e9er ou mettre \u00e0 jour l'horaire d'un utilisateurD\u00e9sactiver l'extinction pour un utilisateurSupprimer le script du profil d'un utilisateur <p>Entrez <code>1</code>.</p> <p>Entrez <code>2</code>.</p> <p>Entrez <code>3</code>.</p> <p>Si le script vous demande un nom d'utilisateur, entre le username retenu de l'\u00e9tape 1.  Si le script a d\u00e9j\u00e0 \u00e9t\u00e9 lanc\u00e9, il vous demandera si vous voulez continuer avec le dernier username utilis\u00e9. <code>Oui</code> est la r\u00e9ponse par d\u00e9faut, vous pouvez refuser en entrant <code>n</code>.</p> <p>S'enfermer hors de votre ordinateur</p> <p>Si vous lancez le script avec votre propre compte ou le compte utilisateur comme cible, vous risquez de couper votre propre acc\u00e8s \u00e0 l'ordinateur si vous \u00eates en dehors des heures d'activit\u00e9 que vous avez d\u00e9finies puisque l'ordinateur s'\u00e9teindra au moment de l'ouverture de votre session.</p> Cr\u00e9er ou mettre \u00e0 jour l'horaire d'un utilisateurD\u00e9sactiver l'extinction pour un utilisateurSupprimer le script du profil d'un utilisateur <p>Pour chaque jour de la semaine, vous serez invit\u00e9 \u00e0 entrer une limite pour le matin et l'apr\u00e8s-midi. L'ordinateur s'\u00e9teindra avant la limite du matin et apr\u00e8s la limite de l'apr\u00e8s-midi. Par  exemple, si vous d\u00e9finissez la limite du matin pour 6h et la limite du soir pour 22h, l'ordinateur ne sera utilisable que entre 6h et 22h.</p> <p>Pour entrer l'heure, merci d'utiliser le format <code>hhmm</code>. Par exemple, 6h s'\u00e9crit <code>0600</code> et 22h <code>2200</code>. 0h1 est <code>0001</code> et 23h59 est <code>2359</code>.</p> <p>Le script sera toujours pr\u00e9sent sur le profil de l'utilisateur cible, mais n'aura aucun effet (Les heures d'activit\u00e9 de l'ordinateur seront de minuit \u00e0 minuit).</p> <p>Profil pr\u00e9c\u00e9demment non affect\u00e9</p> <p>Veuillez noter que si le profil cible n'\u00e9tait jusqu'\u00e0 pr\u00e9sent pas affect\u00e9 par le script, alors le script sera \u00e9crit \u00e0 ce profil.</p> <p>Tous les fichiers li\u00e9s au script seront supprim\u00e9s du profil de l'utilisateur cible.</p> <p>Si le script ne vous a pas demand\u00e9 de red\u00e9marrer l'ordinateur ou que vous avez refus\u00e9 de le faire, le menu principal est affich\u00e9 \u00e0 nouveau afin de vous permettre de faire une autre action ou de sortir en appuyant sur n'importe quelle lettre.</p> <p>Si des messages d'erreur sont apparus (en rouge), c'est probablement d\u00fb \u00e0 un mauvais username ou au fait que le script n'ait pas obtenu les privil\u00e8ges d'administrateur.</p>"},{"location":"fr/useage.html#limites","title":"Limites","text":"<ul> <li>Le script devrait fonctionner tant qu'il n'a pas \u00e9t\u00e9 arr\u00eat\u00e9 par une des actions cit\u00e9es plus haut. Cel\u00e0-dit, le script est contenu dans les dossiers du profil de l'utilisateur cible. S'il est d\u00e9couvert, il peut doc \u00eatre supprim\u00e9.</li> <li>Le script utilise le temps syst\u00e8me. Si le temps syst\u00e8me diff\u00e8re du temps r\u00e9el, le script fonctionnera avec la fausse information. Cela dit, changer le temps du syst\u00e8me entra\u00eene beaucoup de dysfonctionnements, notamment pour les jeux en ligne. Il est donc peu probable que l'utilisateur utilise cette m\u00e9thode de contournement.  </li> </ul>"}]}