CREATE PROCEDURE central.usp_ArchiveOldRecords
AS
BEGIN
    INSERT INTO central.EmployeeArchive
    SELECT * FROM central.Employee
    WHERE HireDate < DATEADD(YEAR, -1, GETDATE());

    DELETE FROM central.Employee
    WHERE HireDate < DATEADD(YEAR, -1, GETDATE());
END;
