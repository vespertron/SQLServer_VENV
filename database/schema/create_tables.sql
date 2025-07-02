-- ========================
-- CREATE TABLES
---------------------------
-- Server: [My local SQL server]
-- Database: BMTC
-- Author: Vesper Annstas
-- Date: 06/26/2025
-- Description: This script creates the necessary tables for the BMTC database. Is dependent on the database being created first.
-- Last Modified: 06/27/2025
-- Modified By: Vesper Annstas
-- Modification Notes: Added indexes for performance optimization,
-- ========================

USE BMTC;
GO

-- ========================
-- CREATE SCHEMAS IF NOT EXISTS
-- ========================
-- CREATE SCHEMA ODS; -- Operational Data Store
-- CREATE SCHEMA WHS; -- Warehouse
-- CREATE SCHEMA MKT; -- Marketing 

-- Create Subsidiary table
CREATE TABLE Subsidiaries (
    SubsidiaryID INT PRIMARY KEY,
    SubsidiaryName VARCHAR(255) NOT NULL,
    SubsidiaryType VARCHAR(100),
    SubsidiaryLocation VARCHAR(255),
    ParentCompanyID INT, -- This could refer to the Parent Company if there are multiple entities.
    LegalEntityStatus VARCHAR(50)
);

-- Create table for Shared HR Data
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(255),
    Department VARCHAR(100),
    JobTitle VARCHAR(100),
    HireDate DATE,
    Salary DECIMAL(10,2),
    EmploymentStatus VARCHAR(50),
    SubsidiaryID INT -- Links to Subsidiary in this table
);


CREATE TABLE ODS.SalesOrder (
    SalesOrderID INT PRIMARY KEY CLUSTERED,
    CustomerID INT,
    OrderDate DATE,
    OrderStatus VARCHAR(20)
);

CREATE TABLE ODS.SalesOrderLine (
    SalesOrderLineID INT PRIMARY KEY CLUSTERED,
    SalesOrderID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

CREATE TABLE ODS.Customer (
    CustomerID INT PRIMARY KEY CLUSTERED,
    FirstName NVARCHAR(100),
    LastName NVARCHAR(100),
    Email NVARCHAR(255)
);

CREATE TABLE ODS.Product (
    ProductID INT PRIMARY KEY CLUSTERED,
    SKU NVARCHAR(50),
    Name NVARCHAR(100),
    Category NVARCHAR(100),
    Price DECIMAL(10, 2)
);

CREATE TABLE WHS.Inventory (
    InventoryID INT PRIMARY KEY NONCLUSTERED,
    WarehouseID INT,
    ProductID INT,
    StockLevel INT
);
-- Composite clustered index to be added separately:
-- CREATE CLUSTERED INDEX IX_Inventory_WHProduct ON Inventory(WarehouseID, ProductID);

CREATE TABLE ODS.CommunicationLog (
    LogID INT PRIMARY KEY CLUSTERED,
    RelatedEntityType VARCHAR(50),
    RelatedEntityID INT,
    Timestamp DATETIME,
    Channel VARCHAR(50),
    Subject NVARCHAR(255),
    Body NVARCHAR(MAX),
    FilePath NVARCHAR(500)
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