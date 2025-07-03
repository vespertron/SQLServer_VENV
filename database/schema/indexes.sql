USE CentralServicesDB;
GO

-- HR_Employees: Likely query: WHERE SubsidiaryID = ? AND Department = ?
CREATE NONCLUSTERED INDEX IX_HR_Employees_Subsidiary_Department
ON HR_Employees (SubsidiaryID, Department);

-- IT_Assets: WHERE AssignedToEmployeeID = ? AND SubsidiaryID = ?
CREATE NONCLUSTERED INDEX IX_IT_Assets_Employee_Subsidiary
ON IT_Assets (AssignedToEmployeeID, SubsidiaryID);

-- Reporting_Metadata: WHERE SubsidiaryID = ? AND Schedule = ?
CREATE NONCLUSTERED INDEX IX_Reporting_Metadata_Subsidiary_Schedule
ON Reporting_Metadata (SubsidiaryID, Schedule);

-- Finance_Ledger: WHERE SubsidiaryID = ? AND EntryDate BETWEEN ? AND ?
CREATE NONCLUSTERED INDEX IX_Finance_Ledger_Subsidiary_EntryDate
ON Finance_Ledger (SubsidiaryID, EntryDate);

-- Legal_Contracts: WHERE SubsidiaryID = ? AND Status = ?
CREATE NONCLUSTERED INDEX IX_Legal_Contracts_Subsidiary_Status
ON Legal_Contracts (SubsidiaryID, Status);

-- Credit_Scores: WHERE RiskLevel = ? AND CreditLimit > ?
CREATE NONCLUSTERED INDEX IX_Credit_Scores_Risk_CreditLimit
ON Credit_Scores (RiskLevel, CreditLimit);

-- Governance_AccessLogs: WHERE SubsidiaryID = ? AND Timestamp BETWEEN ? AND ?
CREATE NONCLUSTERED INDEX IX_Governance_Logs_Subsidiary_Timestamp
ON Governance_AccessLogs (SubsidiaryID, Timestamp);

-- Subsidiary_Info: WHERE Region = ? AND DataIsolationLevel = ?
CREATE NONCLUSTERED INDEX IX_Subsidiary_Info_Region_Isolation
ON Subsidiary_Info (Region, DataIsolationLevel);
