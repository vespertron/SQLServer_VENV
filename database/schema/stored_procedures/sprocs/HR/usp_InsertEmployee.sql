CREATE PROCEDURE [HR].[usp_InsertEmployee]
	@FirstName NVARCHAR(50),
	@LastName NVARCHAR(50),
	@SubsidiaryId INT,
	@JobTitle NVARCHAR(50),
	@Email NVARCHAR(100),
	@PhoneNumber NVARCHAR(15),
	@Salary DECIMAL(18, 2),
	@HireDate DATETIME
AS
BEGIN
  SET NOCOUNT ON;

  BEGIN TRY
    BEGIN TRANSACTION;

	----------------------------
    -- Validate input parameters
	----------------------------

	-- Check if the subsidiary exists
    IF NOT EXISTS (
      SELECT 1 
      FROM CEN.Subsidiary_Info
	  WHERE SubsidiaryID = @SubsidiaryID
      )
      THROW 50001, 'Subsidiary does not exist.', 1;


      -- Check if the email is already in use
      IF EXISTS (
	    SELECT 1 
		FROM [HR].[Employees] 
		WHERE Email = @Email
		)
		THROW 50002, 'Email is already in use.', 1;

      -- Duplicate Employee Check
	     -- !! Look into safely incorporating DOB or other unique identifiers in the rare case of name collisions. !!
	  IF EXISTS (
		SELECT 1
		FROM [HR].[Employees]
		WHERE FirstName = @FirstName
		AND LastName = @LastName
        )
        THROW 50003, 'An employee with the same name already exists.', 1;


		--------------------------------------------------------
		-- Insert a new employee record into the Employees table
		--------------------------------------------------------

		-- Insert the new employee into the Employees table
        INSERT INTO [HR].[Employees] (FirstName, LastName, SubsidiaryId, JobTitle, Email, PhoneNumber, Salary, HireDate)
        VALUES (@FirstName, @LastName, @SubsidiaryId, @JobTitle, @Email, @PhoneNumber, @Salary, @HireDate);
	
        -- Optionally return the ID of the newly inserted employee
	    SELECT SCOPE_IDENTITY() AS NewEmployeeId;
	COMMIT TRANSACTION;
  END TRY
  BEGIN CATCH
	IF @@TRANCOUNT > 0
	  ROLLBACK TRANSACTION;
	-- Return error information
	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;
	SELECT 
	  @ErrorMessage = ERROR_MESSAGE(),
	  @ErrorSeverity = ERROR_SEVERITY(),
	  @ErrorState = ERROR_STATE();
	RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
  END CATCH
END;
GO