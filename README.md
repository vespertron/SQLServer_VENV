# On-Prem Virtualization & Database Administration
This repository contains scripts, configurations, and documentation for standing up a secure, high-performance on-premise infrastructure with virtualized environments and robust SQL Server database administration. It includes CI/CD automation, backup strategies, ETL pipelines, and performance monitoring practices.

---

## Repo Structure
```
├── virtualization/
│ ├── hypervisor_config/
│ ├── vm_templates/
│ ├── network_topology/
│ ├── firewall_rules/
│ └── patching_strategy.md
├── database/
│ ├── schema/
│ │ ├── create_databases.sql
│ │ ├── create_tables.sql
│ │ ├── create_indexes.sql
│ │ └── stored_procedures/
│ ├── encryption/
│ ├── backups/
│ │ ├── backup_strategy.md
│ │ └── restore_tests/
│ └── access_control/
│ └── access_control_matrix.xlsx
├── etl/
│ ├── pipelines/
│ ├── logging/
│ └── validation_rules/
├── cicd/
│ ├── github/
│ │ └── main.yml
│ ├── azure-pipelines.yml
│ └── secrets_template.md
├── docs/
│ ├── workflow_flowchart.png
│ ├── hardening_guidelines.md
│ └── architecture_overview.md
└── README.md
```
---

## Features
- **Virtualization Setup**: Templates and configuration for provisioning VMs with Hyper-V, VMware, or Proxmox
- **Secure Networking**: VLAN and firewall configuration for isolated, compliant environments
- **Database Deployment**: SQL Server setup with filegroups, collation, containment, RBAC, and encryption
- **ETL Design**: Pipeline structure with validation and error logging
- **CI/CD Integration**: Ready-to-use YAML files for GitHub Actions and Azure Pipelines
- **Backups & DR**: Strategy for full/differential/log backups and restore testing
- **Documentation**: Flowcharts, configs, and access control matrices for audit and scale

---

## Documentation
- This README.md file provides an overview of the project, its structure, and how to set up the environments.
- The `docs` directory contains documentation on the project including templates, diagrams, and guidelines.
- The [WIKI](https://github.com/vespertron/SQLServer_VENV/wiki) is used for detailed, **step-by-step guides**, best practices, troubleshooting tips and knowledge sharing.
- System and Database Administration tasks are logged on [this Trello board](https://trello.com/b/RnV4u78D/sql-server-system-database-administration).

---

## Getting Started

### Tools & Account Prerequisites

This document outlines all the tools and accounts required to use this repository for on-prem virtualization, SQL Server database administration, CI/CD automation, and infrastructure documentation.

---

### Tools You'll Need

#### Virtualization & Infrastructure
- **Hypervisor** (choose one):
  - Hyper-V (Windows Server)
  - VMware ESXi
  - Proxmox VE
- **VM Management Tools**:
  - Hyper-V Manager / vSphere Client / Proxmox Web UI
  - PowerShell (with Hyper-V or VMware modules)
  - SSH client for Linux VMs

#### Database Tools
- **SQL Server**:
  - SQL Server 2019+ installed on your VMs
  - SQL Server Management Studio (SSMS)
- **Scripting & Testing**:
  - Azure Data Studio (optional, cross-platform)
  - `sqlcmd` CLI utility

#### ETL & Automation
- SQL Server Integration Services (SSIS) or Azure Data Factory
- Python or PowerShell for scripting ETL validation and automation

#### CI/CD & Version Control
- Git
- GitHub CLI (optional)
- YAML-aware IDE or editor (e.g., VSCode)
- GitHub Actions or Azure DevOps Pipelines

---

### Security & Secrets Management
- GitHub Secrets configured for:
  - SQL Server connection strings
  - Admin credentials
  - API tokens or secret keys
- (Optional) Azure Key Vault or HashiCorp Vault for advanced secret handling

---

### Account Requirements

| Tool / Platform            | Account Requirement                                       |
|---------------------------|------------------------------------------------------------|
| **GitHub**                | Free or Pro account to host the repo & run Actions         |
| **Azure DevOps**          | Microsoft account + DevOps organization                    |
| **SQL Server**            | Local or licensed installation + admin access              |
| **VMware/Proxmox**        | Admin access to hypervisor or test lab environment         |
| **Windows Admin Center**  | Admin rights to manage Hyper-V or Windows Server Core      |
| **Cloud Storage (optional)** | Azure Blob or AWS S3 bucket for backup replication     |

---

### Optional Downloads

| Tool                     | Download Link                                             |
|--------------------------|-----------------------------------------------------------|
| **SSMS**                | https://aka.ms/ssms                                       |
| **Azure Data Studio**   | https://learn.microsoft.com/en-us/sql/azure-data-studio  |
| **Proxmox VE ISO**      | https://www.proxmox.com/en/downloads                     |
| **Hyper-V (Windows)**   | https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/ |
| **Git**                 | https://git-scm.com/downloads                            |

---

> 💡 Tip: Ensure all tools are installed on the machine(s) where you plan to provision VMs, run pipelines, or manage your databases.

---

### Cloning the Repository

Clone this repository to your local machine using:

```bash
git clone https://github.com/your-username/SQLServer-VENV.git
```

---

### Using the Repository

1. **Provision Hypervisor**
   - Start in `/virtualization/` to configure your hypervisor, network, and base VM templates.

2. **Set Up Virtual Networks**
   - Use VLAN design files and firewall rules to isolate environments.

3. **Deploy Databases**
   - Run SQL scripts in `/database/schema/` from your preferred management tool or pipeline.

4. **Configure Access & Backups**
   - Modify the RBAC stored procedures and encryption settings to fit your org’s policy.

5. **Run ETL Jobs**
   - Develop and test pipelines in `/etl/`. Logs and validations are built in.

6. **Deploy CI/CD**
   - Choose a pipeline (GitHub Actions or Azure DevOps) and connect secrets for auto-deployment.

---

## Security Notes

- Do **not** check in real secrets. Use `/cicd/secrets_template.md` as a guide.
- All production machines should follow `/docs/hardening_guidelines.md`.

---

## License

MIT License

---

## Maintained By

**Vesper Annstas**  
Data Analytics Manager & Infrastructure Engineer  
Contact: [LinkedIn](https://www.linkedin.com/in/vesperannstas/)


