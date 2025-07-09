## Snapshot: Base Clean - Static IP + Internet Access
**Date:** 2025-07-08  
**VM:** Base  
**State:** Powered Off  
**Description:**  
- Windows Server 2022 installed (Desktop Experience)  
- Static IP configured: `192.168.44.10` (NAT network)  
- Gateway: `192.168.44.2`, DNS: `8.8.8.8` + `1.1.1.1`  
- Internet access and Windows Update working  

**Why this matters:**  
This is a safe restore point with baseline networking verified. Ideal for cloning and configuring new VMs like domain controller, SQL server, or web app tiers.
