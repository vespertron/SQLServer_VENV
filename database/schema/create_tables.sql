-- ========================
-- CREATE TABLES
---------------------------
-- Server: [My local SQL server]
-- Database: CentralServicesDB
-- Author: Vesper Annstas
-- Date: 07/02/2025
-- Description: This script creates the necessary tables for the CentralServicesDB database. Is dependent on the database being created first.
-- Last Modified: 07/02/2025
-- Modified By: Vesper Annstas
-- Modification Notes: initial creation of tables for the CentralServicesDB database.
-- ========================

USE CentralServicesDB;
GO

-- ========================
-- CREATE SCHEMAS IF NOT EXISTS
-- ========================
-- CREATE SCHEMA CEN    -- Central Services
-- CREATE SCHEMA HR     __ Human Resources
-- CREATE SCHEMA IT     -- Information Technology
-- CREATE SCHEMA ACC    -- Accounting
-- CREATE SCHEMA FIN    -- Finance
-- CREATE SCHEMA LEGAL  -- Legal
-- CREATE SCHEMA ODS	-- Operational Data Store
-- CREATE SCHEMA MKT    -- Marketing


USE CentralServicesDB;
GO

-- HR Schema
CREATE TABLE HR.HR_Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    SubsidiaryID INT,
    Role NVARCHAR(100),
    Department NVARCHAR(100),
    HireDate DATE
);

-- IT Schema
CREATE TABLE IT.IT_Assets (
    AssetID INT PRIMARY KEY,
    AssetType NVARCHAR(50),
    AssignedToEmployeeID INT,
    PurchaseDate DATE,
    WarrantyExpiry DATE,
    SubsidiaryID INT
);

-- Accounting / Finance Schema
CREATE TABLE FIN.Finance_Ledger (
    EntryID INT PRIMARY KEY,
    SubsidiaryID INT,
    AccountCode NVARCHAR(20),
    Amount DECIMAL(18, 2),
    EntryDate DATE,
    Description NVARCHAR(255)
);

-- Legal Schema
CREATE TABLE LEG.Legal_Contracts (
    ContractID INT PRIMARY KEY,
    SubsidiaryID INT,
    ContractName NVARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    LegalContact NVARCHAR(100),
    Status NVARCHAR(50)
);

-- Credit / Financing
CREATE TABLE FIN.Credit_Scores (
    SubsidiaryID INT PRIMARY KEY,
    Score INT,
    LastEvaluated DATE,
    CreditLimit DECIMAL(18, 2),
    RiskLevel NVARCHAR(50)
);

-- Protecting Subsidiaries' Data
CREATE TABLE CEN.Subsidiary_Info (
    SubsidiaryID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Region NVARCHAR(50),
    DataIsolationLevel NVARCHAR(50)  -- e.g. "Strict", "Shared-Metadata-Only"
);

CREATE TABLE ODS.DocumentLibrary (
    DocumentID INT PRIMARY KEY CLUSTERED,
    DocumentType VARCHAR(100),
    RelatedEntityType VARCHAR(50),
    RelatedEntityID INT,
    FileName NVARCHAR(255),
    FilePath NVARCHAR(500),
    UploadDate DATETIME,
    UploadedBy INT
);

CREATE TABLE MKT.MarketingAsset (
    AssetID INT PRIMARY KEY CLUSTERED,
    RelatedProductID INT,
    Platform VARCHAR(100),
    ContentType VARCHAR(50),
    AssetPath NVARCHAR(500),
    CampaignName VARCHAR(100),
    PostedDate DATETIME
);