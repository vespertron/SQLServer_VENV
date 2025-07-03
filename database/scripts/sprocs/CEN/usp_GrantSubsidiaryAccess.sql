CREATE PROCEDURE central.usp_GrantSubsidiaryAccess
    @SubsidiaryID INT,
    @ModuleName NVARCHAR(50)
AS
BEGIN
    INSERT INTO central.AccessControl (SubsidiaryID, ModuleName, GrantedDate)
    VALUES (@SubsidiaryID, @ModuleName, GETDATE());
END;
