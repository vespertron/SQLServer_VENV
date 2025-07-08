
-- Centralized Chart of Accounts
CREATE TABLE chart_of_accounts (
    account_id INT PRIMARY KEY,
    account_code NVARCHAR(20) NOT NULL,
    account_name NVARCHAR(100) NOT NULL,
    account_type NVARCHAR(50), -- Asset, Liability, Revenue, Expense
    parent_account_id INT NULL,
    is_active BIT DEFAULT 1
);


-- Departments (IT, HR, Legal, etc.)
CREATE TABLE fin.departments (
    department_id INT PRIMARY KEY,
    department_name NVARCHAR(100),
    cost_center_code NVARCHAR(20),
    is_active BIT DEFAULT 1
);

-- Finance Ledger (Central Journal)
CREATE TABLE fin.finance_ledger (
    ledger_id INT IDENTITY PRIMARY KEY,
    transaction_date DATE NOT NULL,
    entity_id INT NOT NULL,
    department_id INT,
    account_id INT NOT NULL,
    amount DECIMAL(18, 2) NOT NULL,
    currency_code CHAR(3),
    entry_type NVARCHAR(50), -- AP, AR, Payroll, Journal, Accrual, etc.
    reference_doc NVARCHAR(100),
    description NVARCHAR(255),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id),
    FOREIGN KEY (department_id) REFERENCES fin.departments(department_id),
    FOREIGN KEY (account_id) REFERENCES fin.chart_of_accounts(account_id)
);

-- Operational Tables
CREATE TABLE fin.buyers (
    buyer_id INT PRIMARY KEY,
    buyer_name NVARCHAR(100),
    contact_email NVARCHAR(100)
);

CREATE TABLE fin.suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name NVARCHAR(100),
    contact_email NVARCHAR(100)
);

CREATE TABLE fin.bookings (
    booking_id INT PRIMARY KEY,
    entity_id INT,
    buyer_id INT,
    booking_date DATE,
    amount DECIMAL(18, 2),
    description NVARCHAR(255),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id),
    FOREIGN KEY (buyer_id) REFERENCES fin.buyers(buyer_id)
);

CREATE TABLE fin.purchases (
    purchase_id INT PRIMARY KEY,
    entity_id INT,
    supplier_id INT,
    purchase_date DATE,
    amount DECIMAL(18, 2),
    description NVARCHAR(255),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id),
    FOREIGN KEY (supplier_id) REFERENCES fin.suppliers(supplier_id)
);

-- HR Table (Minimal Placeholder)
CREATE TABLE fin.employees (
    employee_id INT PRIMARY KEY,
    full_name NVARCHAR(100),
    hire_date DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES fin.departments(department_id)
);

-- Legal Docs Table
CREATE TABLE fin.documents (
    document_id INT PRIMARY KEY,
    entity_id INT,
    document_type NVARCHAR(50),
    document_name NVARCHAR(100),
    uploaded_at DATETIME DEFAULT GETDATE(),
    file_path NVARCHAR(255),
    FOREIGN KEY (entity_id) REFERENCES fin.entities(entity_id)
);
