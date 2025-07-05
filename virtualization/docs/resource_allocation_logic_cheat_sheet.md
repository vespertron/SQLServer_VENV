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

## Baseline RAM Guidelines by VM Role

| **VM Role**              | **Minimum RAM** | **Recommended** | **Why** |
|--------------------------|------------------|------------------|--------|
| **Web Server / App**     | 2–4 GB           | 4 GB             | Lightweight but should handle bursts of traffic |
| **Database Server (SQL)**| 8–12 GB          | 12–16 GB+        | RAM-intensive for caching, indexing, joins, etc. |
| **Domain Controller**    | 2–4 GB           | 4 GB             | Low usage, but critical for authentication & DNS |
| **File Server**          | 1–2 GB           | 2 GB             | Light memory footprint, heavy on storage I/O |
| **Dev/Test VMs**         | 2–4 GB           | 4–8 GB           | Based on role (SQL, WebApp, etc.) |
| **Management / Utility** | 1–2 GB           | 2–4 GB           | Depends on installed tools and services |

---

## Allocation Ratio Reference (Relative Importance)

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

