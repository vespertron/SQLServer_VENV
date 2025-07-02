-- ========================
-- CREATE TABLES
---------------------------
-- Server: [My local SQL server]
-- Database: BMTC
-- Author: Vesper Annstas
-- Date: 06/26/2025
-- Description: This script creates the BMTC database. The Filegroups are set up to separate primary and secondary data files, with a dedicated log file location.
-- Last Modified: 06/27/2025
-- Modified By: Vesper Annstas
-- Modification Notes: Delimited primary vs secondary data files, added filegroup for secondary data, and set up log file location.
-- ========================


-- Create the parent company database with Primary and Secondary Filegroups
CREATE DATABASE BMTC 
ON
    PRIMARY (
        NAME = 'BMTC',
        FILENAME = 'C:\Databases\BMTC.mdf',
        SIZE = 500MB,
        MAXSIZE = 2GB,
        FILEGROWTH = 100MB
    ),
    FILEGROUP Sub_SouthMississippiCo (
        NAME = 'Sub_SouthMississippiCo',
        FILENAME = 'C:\Databases\Sub_SouthMississippiCo.ndf',
        SIZE = 200MB,
        MAXSIZE = 1GB,
        FILEGROWTH = 50MB
    ),
    FILEGROUP Sub_AffiliatedPDX (
        NAME = 'Sub_AffiliatedPDX',
        FILENAME = 'C:\Databases\Sub_AffiliatedPDX.ndf',
        SIZE = 200MB,
        MAXSIZE = 1GB,
        FILEGROWTH = 50MB
    ),
    FILEGROUP BackupData (
        NAME = 'BackupData',
        FILENAME = 'C:\Databases\BackupData.ndf',
        SIZE = 100MB,
        MAXSIZE = 500MB,
        FILEGROWTH = 50MB
    )
LOG ON (
    NAME = 'BMTC_Log',
    FILENAME = 'C:\Databases\BMTC_Log.ldf',
    SIZE = 200MB,
    MAXSIZE = 1GB,
    FILEGROWTH = 50MB
)
COLLATE SQL_Latin1_General_CP1_CI_AS
WITH 
    TRUSTWORTHY = ON,
    NESTED_TRIGGERS = ON,
    DB_CHAINING = ON;