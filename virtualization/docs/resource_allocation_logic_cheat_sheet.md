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

