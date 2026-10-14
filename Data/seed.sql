USE DevTeamDb;


GO
-- 1. Clear existing test data
DELETE TimeEntries;

DELETE Tasks;

DELETE Sprints;

DELETE Developers;

DBCC CHECKIDENT ('Developers', RESEED, 0);

DBCC CHECKIDENT ('Sprints', RESEED, 0);

DBCC CHECKIDENT ('Tasks', RESEED, 0);

DBCC CHECKIDENT ('TimeEntries', RESEED, 0);

-- 2. Insert Developers
INSERT  INTO Developers (
    Name,
    Email
)
VALUES                  ('ahmed', 'ahmed@CliniSys.tn'),
                        ('Aymen Ben Salah', 'aymen.bensalah@CliniSys.tn'),
                        ('Mariem Trabelsi', 'mariem.trabelsi@CliniSys.tn'),
                        ('Ghazi Karray', 'ghazi.karray@CliniSys.tn');

-- 3. Insert Sprints
INSERT  INTO Sprints (
    Name,
    StartDate,
    EndDate,
    Status
)
VALUES               ('Sprint 1 - MVP Release', '2026-10-01', '2026-10-14', 2),
                     ('Sprint 2 - AI Integration', '2026-10-15', '2026-10-28', 1),
                     ('Sprint 3 - Performance Tuning', '2026-10-29', '2026-11-11', 1);

-- 4. Insert Tasks (Statuses: 1=À faire, 2=En cours, 3=Terminé | Priorities: 1=Basse, 2=Moyenne, 3=Haute, 4=Critique)
INSERT  INTO Tasks (
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
VALUES             -- Sprint 1 Tasks
                   ('Acme Corp', 'Implement authentication and JWT tokens', 1, 8.0, '2026-10-05', 3, 3, 1, GETDATE()),
                   ('Acme Corp', 'Fix payment gateway timeout issue', 2, 6.5, '2026-10-06', 4, 2, 1, GETDATE()),
                   ('Tunisie Telecom', 'Optimize SQL Server query performance indices', 1, 12.0, '2026-10-10', 3, 2, 1, GETDATE()),
                   ('Beta Solutions', 'Design customer onboarding wireframes', 3, 5.0, '2026-10-08', 2, 3, 1, GETDATE()),
                   ('Beta Solutions', 'Setup CI/CD pipeline with GitHub Actions', 4, 10.0, '2026-10-12', 4, 1, 1, GETDATE()),
                   -- Sprint 2 Tasks
                   ('Global Logistics', 'Container tracking API integration', 2, 16.0, '2026-10-20', 3, 1, 2, GETDATE()),
                   ('Global Logistics', 'Generate PDF monthly billing reports', 3, 8.0, '2026-10-22', 2, 1, 2, GETDATE()),
                   ('Sfax Retail', 'E-commerce shopping cart persistence bug', 1, 4.0, '2026-10-18', 4, 1, 2, GETDATE()),
                   -- Sprint 3 Tasks
                   ('Medina Craft', 'Setup multilingual Arabic-French UI toggle', 3, 7.5, '2026-11-02', 1, 1, 3, GETDATE()),
                   ('Medina Craft', 'Configure Redis output caching layer', 4, 14.0, '2026-11-05', 3, 1, 3, GETDATE());

-- 5. Insert Time Entries (Simulating time spent and budget overruns for testing reports)
INSERT  INTO TimeEntries (
    TaskId,
    DeveloperId,
    WorkDate,
    DurationHours,
    Note,
    CreatedAt
)
VALUES                   (1, 1, '2026-10-02', 4.0, 'Initial token generation setup', GETDATE()),
                         (1, 1, '2026-10-03', 4.5, 'Refined claims and expiration handling', GETDATE()),
                         (2, 2, '2026-10-04', 5.0, 'Investigated gateway logs', GETDATE()),
                         (3, 1, '2026-10-05', 14.0, 'Heavy query tuning on execution plans', GETDATE()),
                         (4, 3, '2026-10-02', 4.0, 'Figma wireframes complete', GETDATE());