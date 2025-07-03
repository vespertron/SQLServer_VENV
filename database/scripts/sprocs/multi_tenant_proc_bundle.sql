-- =============================================
-- Multi-Tenant & System-Level Procedure Bundle
-- =============================================
-- Assumes a Centralized schema "CEN" for multi-tenant operations
-- Each table must include SubsidiaryID (a.k.a. TenantID)

-- ==========================
-- 1. Grant Subsidiary Access to Module
-- ==========================
CREATE PROCEDURE CEN.usp_GrantSubsidiaryAccess
    @SubsidiaryID INT,
    @ModuleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    IF NOT EXISTS (
        SELECT 1 FROM CEN.Subsidiary WHERE SubsidiaryID = @SubsidiaryID
    )
    THROW 50001, 'Subsidiary does not exist.', 1;

    INSERT INTO CEN.AccessControl (SubsidiaryID, ModuleName, GrantedDate)
    VALUES (@SubsidiaryID, @ModuleName, GETDATE());
END;
GO

-- ==========================
-- 2. Revoke Subsidiary Access
-- ==========================
CREATE PROCEDURE CEN.usp_RevokeSubsidiaryAccess
    @SubsidiaryID INT,
    @ModuleName NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DELETE FROM CEN.AccessControl
    WHERE SubsidiaryID = @SubsidiaryID AND ModuleName = @ModuleName;
END;
GO

-- ==========================
-- 3. Archive Old Employee Records (All Tenants)
-- ==========================
CREATE PROCEDURE CEN.usp_ArchiveOldRecords
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO CEN.EmployeeArchive
    SELECT * FROM CEN.Employee
    WHERE HireDate < DATEADD(YEAR, -1, GETDATE());

    DELETE FROM CEN.Employee
    WHERE HireDate < DATEADD(YEAR, -1, GETDATE());
END;
GO

-- ==========================
-- 4. Generate Monthly Usage Billing Report
-- ==========================
CREATE PROCEDURE CEN.usp_GenerateMonthlyServiceUsageBill
    @Year INT,
    @Month INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT s.SubsidiaryID,
           s.SubsidiaryName,
           u.ModuleName,
           COUNT(*) AS UsageCount,
           SUM(u.BillableUnits * m.UnitRate) AS BilledAmount
    FROM CEN.ServiceUsage u
    JOIN CEN.Subsidiary s ON u.SubsidiaryID = s.SubsidiaryID
    JOIN CEN.ModuleRateCard m ON u.ModuleName = m.ModuleName
    WHERE YEAR(u.UsageDate) = @Year AND MONTH(u.UsageDate) = @Month
    GROUP BY s.SubsidiaryID, s.SubsidiaryName, u.ModuleName;
END;
GO

-- ==========================
-- 5. Provision New Subsidiary (Tenant)
-- ==========================
CREATE PROCEDURE CEN.usp_ProvisionTenant
    @SubsidiaryName NVARCHAR(100),
    @AdminEmail NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @NewSubsidiaryID INT;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO CEN.Subsidiary (SubsidiaryName, CreatedDate)
        VALUES (@SubsidiaryName, GETDATE());

        SET @NewSubsidiaryID = SCOPE_IDENTITY();

        INSERT INTO CEN.SubsidiaryAdmin (SubsidiaryID, Email)
        VALUES (@NewSubsidiaryID, @AdminEmail);

        -- Optional: Assign default modules
        INSERT INTO CEN.AccessControl (SubsidiaryID, ModuleName, GrantedDate)
        SELECT @NewSubsidiaryID, ModuleName, GETDATE()
        FROM CEN.DefaultModuleAccess;

        COMMIT;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK;
        THROW;
    END CATCH
END;
GO
