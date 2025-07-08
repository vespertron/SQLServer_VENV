
-- ================================================
-- Script Name   : example_financeops_ddl.sql
-- Description   : DDL script to create database
--                 with filegroup configuration and core financial tables.
-- 
-- Author        : Vesper Annstas
-- Created On    : 2025-07-07
-- Version       : 1.0
-- 
-- Purpose       : 
--   - Initialize database for centralized finance and operations
--   - Define core entities: chart of accounts, departments, entities, etc.
--   - Include bookings and finance ledger for transactions and forecasting
-- 
-- Prerequisites :
--   - Sufficient disk space on D:\, E:\, and F:\ for data and log files
--   - SQL Server instance with appropriate permissions to create databases
-- 
-- Notes         :
--   - Filegroup 'UserData' used for isolating business tables from system metadata
--   - Booking table references CoA for revenue forecasting linkage
--   - All monetary fields use DECIMAL(18,2)
-- 
-- Change Log    :
--   - [2025-07-07] V.A. - Initial version
-- ================================================

-- Create the database with filegroup planning
CREATE DATABASE FinanceOps
ON PRIMARY (
    NAME = 'FinanceOps_Primary',
    FILENAME = 'D:\Data\FinanceOps_Primary.mdf',
    SIZE = 500MB,
    MAXSIZE = 5GB,
    FILEGROWTH = 256MB
),
FILEGROUP UserData (
    NAME = 'FinanceOps_UserData',
    FILENAME = 'E:\Data\FinanceOps_UserData.ndf',
    SIZE = 1GB,
    MAXSIZE = 10GB,
    FILEGROWTH = 512MB
)
LOG ON (
    NAME = 'FinanceOps_log',
    FILENAME = 'F:\Logs\FinanceOps_log.ldf',
    SIZE = 256MB,
    MAXSIZE = 2GB,
    FILEGROWTH = 128MB
);
GO

-- Use the new database
USE FinanceOps;
GO

-- Schemas
CREATE SCHEMA fin;
GO

-- Chart of Accounts
CREATE TABLE fin.chart_of_accounts (
    account_id INT PRIMARY KEY,
    account_code NVARCHAR(20) NOT NULL UNIQUE,
    account_name NVARCHAR(100) NOT NULL,
    account_type NVARCHAR(50),
    parent_account_id INT NULL,
    is_active BIT DEFAULT 1
) ON UserData;
GO

-- Entities (Subsidiaries or Services)
CREATE TABLE fin.entities (
    entity_id INT PRIMARY KEY,
    entity_name NVARCHAR(100) NOT NULL,
    entity_type NVARCHAR(50),
    country_code CHAR(2),
    is_active BIT DEFAULT 1
) ON UserData;
GO

-- Departments
CREATE TABLE fin.departments (
    department_id INT PRIMARY KEY,
    department_name NVARCHAR(100),
    cost_center_code NVARCHAR(20),
    is_active BIT DEFAULT 1
) ON UserData;
GO

-- Finance Ledger
CREATE TABLE fin.finance_ledger (
    ledger_id INT IDENTITY PRIMARY KEY,
    transaction_date DATE NOT NULL,
    entity_id INT NOT NULL,
    department_id INT,
    account_id INT NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    currency_code CHAR(3),
    entry_type NVARCHAR(50),
    reference_doc NVARCHAR(100),
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id),
    FOREIGN KEY (department_id) REFERENCES fin.departments(department_id),
    FOREIGN KEY (account_id) REFERENCES fin.chart_of_accounts(account_id)
) ON UserData;
GO

-- Bookings Table
CREATE TABLE fin.bookings (
    booking_id INT PRIMARY KEY,
    entity_id INT NOT NULL,
    buyer_id INT,
    department_id INT,
    booking_date DATE NOT NULL,
    delivery_date DATE,
    status NVARCHAR(50) DEFAULT 'Booked',
    amount DECIMAL(18, 2),
    tax_amount DECIMAL(18, 2),
    discount_amount DECIMAL(18, 2),
    currency_code CHAR(3),
    reference_number NVARCHAR(100),
    description NVARCHAR(255),
    account_id INT,
    payment_terms NVARCHAR(50),
    invoiced BIT DEFAULT 0,
    source_system NVARCHAR(100),
    created_at DATETIME DEFAULT GETDATE(),
    created_by NVARCHAR(100),
    last_modified_at DATETIME,
    modified_by NVARCHAR(100),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id),
    FOREIGN KEY (department_id) REFERENCES fin.departments(department_id),
    FOREIGN KEY (account_id) REFERENCES fin.chart_of_accounts(account_id)
) ON UserData;
GO
