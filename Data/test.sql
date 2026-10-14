USE DevTeamDb;

-- Nettoyage au cas où
DELETE TimeEntries;

DELETE Tasks;

DELETE Sprints;

DELETE Developers;

-- 1. Insertion des développeurs (Équipe technique)
SET IDENTITY_INSERT Developers ON;

INSERT  INTO Developers (
    Id,
    Name,
    Email
)
VALUES                  (1, 'Wassim Yaich', 'wassim@devteam.local'),
                        (2, 'Sarah Ben Ali', 'sarah@devteam.local'),
                        (3, 'Mehdi Trabelsi', 'mehdi@devteam.local');

SET IDENTITY_INSERT Developers OFF;

-- 2. Insertion des Sprints (Passé, Actuel, Futur)
SET IDENTITY_INSERT Sprints ON;

INSERT  INTO Sprints (
    Id,
    Name,
    StartDate,
    EndDate,
    Status
)
VALUES               (1, 'Sprint 1 - MVP Foundation', '2026-10-01 00:00:00', '2026-10-15 23:59:59', 2); -- Closed

SET IDENTITY_INSERT Sprints OFF;

-- 3. Insertion des Tâches (Kanban réaliste)
SET IDENTITY_INSERT Tasks ON;

INSERT  INTO Tasks (
    Id,
    Client,
    Description,
    AssigneeId,
    EstimatedHours,
    DueDate,
    Priority,
    Status,
    SprintId,
    CreatedAt
)
VALUES             (1, 'Acme Corp', 'Implémenter le système d authentification JWT', 1, 8.0, '2026-10-16 17:00:00', 2, 0, 1, GETUTCDATE()),
                   (2, 'Fintech Global', 'Optimiser les requêtes SQL des rapports', 3, 5.0, '2026-10-17 17:00:00', 1, 0, 1, GETUTCDATE()),
                   (3, 'E-Shop Pro', 'Corriger le bug de calcul de TVA', 2, 4.0, '2026-10-15 17:00:00', 2, 1, 1, GETUTCDATE()),
                   (4, 'LogiTrans', 'Mettre en place le Drag & Drop jQuery UI', 1, 6.0, '2026-10-15 12:00:00', 2, 1, 1, GETUTCDATE());

SET IDENTITY_INSERT Tasks OFF;

-- 4. Insertion des imputations de temps (Time Entries) avec les bons noms de colonnes
SET IDENTITY_INSERT TimeEntries ON;

INSERT  INTO TimeEntries (
    Id,
    TaskId,
    DeveloperId,
    DurationHours,
    WorkDate,
    Note,
    CreatedAt
)
VALUES                   (1, 4, 1, 3.5, '2026-10-14 00:00:00', 'Mise en place de l interface et liaison des événements', GETUTCDATE()),
                         (2, 3, 2, 2.0, '2026-10-14 00:00:00', 'Identification de la source du bug d arrondi de TVA', GETUTCDATE());

SET IDENTITY_INSERT TimeEntries OFF;