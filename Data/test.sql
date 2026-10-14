USE DevTeamDb;


GO
IF DB_ID(N'DevTeamDb_Test') IS NULL
    BEGIN
        CREATE DATABASE [DevTeamDb_Test];
        PRINT 'DevTeamDb_Test created successfully.';
    END
ELSE
    BEGIN
        PRINT 'DevTeamDb_Test already exists; no changes made.';
    END


GO
SELECT name,
       state_desc
FROM   sys.databases
WHERE  name IN (N'DevTeamDb', N'DevTeamDb_Test');