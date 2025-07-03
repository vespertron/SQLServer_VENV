-- ========================
-- CREATE TABLES
---------------------------
-- Server: [My local SQL server]
-- Database: CentralServicesDB
-- Author: Vesper Annstas
-- Date: 07/02/2025
-- Description: This script creates the CentralServicesDB database.
-- Last Modified: 07/02/2025
-- Modified By: Vesper Annstas
-- Modification Notes: initial creation of the CentralServicesDB database.
-- ========================


-- Create the parent company database with Primary and Secondary Filegroups
-- Create central database for shared services
CREATE DATABASE CentralServicesDB
ON PRIMARY (
    NAME = CentralServicesDB_data,
    FILENAME = 'C:\SQLData\CentralServicesDB.mdf',
    SIZE = 100MB,
    MAXSIZE = UNLIMITED,
    FILEGROWTH = 10MB
)
LOG ON (
    NAME = CentralServicesDB_log,
    FILENAME = 'C:\SQLLogs\CentralServicesDB.ldf',
    SIZE = 50MB,
    MAXSIZE = 2048GB,
    FILEGROWTH = 10MB
);
GO
