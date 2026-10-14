# DevTeam Task Manager — tests API complémentaires

## Avant de lancer

- Utiliser uniquement une base de données de développement/test.
- Démarrer l'API et vérifier Swagger : `http://localhost:5074/swagger`.
- Le script crée une tâche temporaire et une entrée de temps temporaire, puis tente de supprimer la tâche créée. Le contrôleur de suppression supprime également ses entrées de temps liées.
- Le script ne modifie pas les sprints existants ; le test de dates de sprint invalides ne devrait pas créer de sprint.
- Ne pas lancer contre une base de production ou une base dont les données ne sont pas sauvegardées.

## Exécution sous Windows PowerShell

Enregistrer les deux fichiers dans le même dossier, puis exécuter :

```powershell
Set-ExecutionPolicy -Scope Process Bypass
.\Test-DevTeamTaskManager.ps1
```

Si l'API utilise une autre adresse :

```powershell
.\Test-DevTeamTaskManager.ps1 -BaseUrl "http://localhost:5074"
```

Le script affiche PASS/FAIL et génère `DevTeamTaskManager-TestReport.json` dans le même dossier.

## Ce que couvre le script

- Swagger et GET principaux ; réponses 404 pour les identifiants inexistants.
- Filtres de tâches par client et développeur ; rejet de certains filtres d'énumération invalides.
- Création, lecture, modification PUT et suppression d'une tâche temporaire.
- Validation du payload de création et estimation minimale en ligne.
- Rejet d'un statut de tâche invalide, avec restauration immédiate du statut si l'API l'accepte.
- Création et lecture d'une entrée de temps ; rejet d'une durée de 25 heures.
- Rejet d'un sprint dont la date de fin précède la date de début.
- Lecture des sprints actifs et du rapport de capacité d'un sprint existant.

## Limites restantes

Ce script est un test de régression API, pas une validation complète de production. Il ne remplace pas :

- les tests du frontend dans un navigateur (formulaires, Kanban, filtres UI, affichage des erreurs et responsive) ;
- un test de persistance après redémarrage de l'API ;
- des tests de concurrence sur les écritures ;
- des tests d'autorisation/authentification si ces exigences sont ajoutées ;
- un test d'intégration dans une base isolée et jetable ;
- les tests automatisés unitaires/integration à intégrer au projet .NET.

Certaines vérifications sont volontairement conçues pour révéler des défauts déjà suspectés : par exemple, `estimatedHours=0`, un statut `999`, ou un DTO de tâche vide. Un FAIL sur ces cas indique que le comportement actuel ne respecte pas l'attente du test ; il ne faut pas simplement changer l'attente pour faire passer le test.
