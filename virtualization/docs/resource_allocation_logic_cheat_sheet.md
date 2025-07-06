# Memory Allocation Logic Cheat Sheet for Virtual Machines

Use this guide to plan and allocate memory (RAM) for each VM role based on its workload type, role criticality, and expected performance requirements.

---

## General Principles

| Principle | Description |
|----------|-------------|
| **Reserve for Host** | Always reserve 4–8 GB for the host OS. |
| **Avoid Overcommitment** | Don't allocate more RAM than physically available unless using dynamic memory carefully. |
| **Use Multiples of 2** | Allocate RAM in powers of 2 (2GB, 4GB, 8GB...) for alignment and efficiency. |
| **Use ECC RAM** | Prefer Error-Correcting Code memory in production environments for reliability. |
| **Plan for Growth** | Leave headroom for scaling or temporary spikes in usage. |

---

## vCPU (Virtual CPUs)
- **Start conservatively:** Begin with a small number of vCPUs (e.g., 1 or 2) and monitor performance.
- **Consider overcommitment:** You can often overcommit vCPUs (allocate more vCPUs than physical cores), but excessive overcommitment can impact performance. A 2:1 or 3:1 ratio (vCPUs to physical cores) is generally considered safe.
- **Monitor resource usage:** Track CPU utilization and identify if more or fewer vCPUs are needed.
- **Application requirements:** The specific application(s) running on the VM will dictate vCPU requirements. Some applications benefit from multiple cores, while others are less sensitive.

---

## RAM (Memory)
- **Basic VMs:** 1-2 GB is a good starting point for simple tasks. 
- **Standard VMs:** 4-8 GB is often sufficient for many workloads. 
- **Resource-intensive VMs:** 8 GB or more, potentially much more, depending on the application and its memory demands. 
- **Overhead:** Account for hypervisor overhead (memory used by the hypervisor itself) and potential memory ballooning (where the hypervisor reclaims unused memory from the VM). 
- **Application-specific needs:** Some applications, like databases or CAD software, can require very large amounts of RAM. 
- **Oversubscription:** Like vCPUs, you can oversubscribe RAM, but it's important to monitor usage and ensure you have sufficient physical RAM to handle the combined demands of all VMs. 

# Baseline RAM Guidelines by VM Role

| **VM Role**              | **Minimum RAM** | **Recommended** | **Why** |
|--------------------------|------------------|------------------|--------|
| **Web Server / App**     | 2–4 GB           | 4 GB             | Lightweight but should handle bursts of traffic |
| **Database Server (SQL)**| 8–12 GB          | 12–16 GB+        | RAM-intensive for caching, indexing, joins, etc. |
| **Domain Controller**    | 2–4 GB           | 4 GB             | Low usage, but critical for authentication & DNS |
| **File Server**          | 1–2 GB           | 2 GB             | Light memory footprint, heavy on storage I/O |
| **Dev/Test VMs**         | 2–4 GB           | 4–8 GB           | Based on role (SQL, WebApp, etc.) |
| **Management / Utility** | 1–2 GB           | 2–4 GB           | Depends on installed tools and services |

---

## Storage (Disk Space)

#### Operating System:
Allocate enough space for the OS installation, updates, and basic applications (e.g., 40-60 GB for Windows). 

#### Data and Application Storage:
Consider the size of the data and applications the VM will handle. 

#### Performance Considerations:
For performance-critical VMs, consider using faster storage technologies like SSDs. 

#### Dynamic Sizing:
VMware supports dynamic disk expansion, so you can start with a smaller disk size and increase it later if needed, says a Reddit thread. 

---

## General Tips

#### Start small and scale:
It's generally better to start with smaller resource allocations and increase them as needed based on monitoring.

#### Monitor resource utilization:
Use vCenter or other monitoring tools to track CPU, memory, and disk usage.

#### Consider the workload:
The specific applications and their demands will heavily influence resource allocation.
- **Active Directory**
- **FileShare**
- **WebApp**
- **SQL Server**

#### Vendor recommendations:
Always refer to the documentation for the operating system and applications running on the VM for recommended resource allocations.

#### Test and refine:
Monitor performance after initial setup and adjust resources as needed to optimize performance and efficiency.


### Allocation Ratio Reference (Relative Importance)

Use these approximate **ratio-based allocations** when distributing a fixed pool of memory across different workloads:
- SQL VM : 6 parts
- WebApp VM : 2 parts
- AD VM : 2 parts
- FileShare VM : 1 part

> Example: For 27 GB available RAM (after host reservation)
>
> - SQL: 6/11 × 27 = ~14.7 GB
> - WebApp: 2/11 × 27 = ~4.9 GB
> - AD: 2/11 × 27 = ~4.9 GB
> - FileShare: 1/11 × 27 = ~2.5 GB

---

## Example VM Allocation Table

| **VM Name**         | **Purpose**                | **Environment** | **vCPUs** | **RAM (GB)** | **Storage (GB)** | **Org** |
|---------------------|-----------------------------|-----------------|-----------|--------------|------------------|---------|
| AD-DomainController | Centralized Identity Service| Shared          | 2         | 4            | 40               | All     |
| FileShare           | Network file storage        | Shared          | 1         | 2            | 100              | All     |
| SQL-Dev             | SQL Server (Dev)            | Dev             | 4         | 12           | 150              | All     |
| WebApp-Dev          | Web/API services (Dev)      | Dev             | 2         | 4            | 40               | All     |
| SQL-Staging         | SQL Server (Staging)        | Staging         | 4         | 12           | 150              | All     |
| WebApp-Staging      | Web/API services (Staging)  | Staging         | 2         | 4            | 40               | All     |
| SQL-Prod            | SQL Server (Prod)           | Prod            | 4         | 12           | 150              | All     |
| WebApp-Prod         | Web/API services (Prod)     | Prod            | 2         | 4            | 40               | All     |
| **Total**           |                             |                 | **21**    | **54**       | **710**          |         |

---

## Tips & Warnings

- ✅ **SQL Server** benefits significantly from more RAM due to in-memory caching.
- ✅ **Enable Dynamic Memory** only if you’ve profiled VM usage and know peak vs idle trends.
- ✅ **Staging VMs** should mimic production specs for accurate testing.
- ❌ **Don't rely on swap/pagefile** to compensate for inadequate RAM—it severely impacts performance.
- ❌ **Don’t include ISO mounting or installer folders inside VM RAM calculations.**

---

## Tools

- PowerShell: `Get-CimInstance Win32_OperatingSystem | Select-Object TotalVisibleMemorySize, FreePhysicalMemory`
- Task Manager > Performance > Memory
- Use audit templates like:  
  [`resource_allocation_template.xlsx`](https://github.com/vespertron/SQLServer_VENV/blob/main/virtualization/docs/resource_allocation_audit_TEMPLATE.xlsx)

---

> *Rule of thumb:* If you're not sure, **allocate more to SQL and less to web/file services**. They’ll be the first to bottleneck under load.

