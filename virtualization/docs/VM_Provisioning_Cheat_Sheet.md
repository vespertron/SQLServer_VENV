# VM Provisioning Cheat Sheet – VMware Workstation Lab

___

## 1. VM Creation
 
- Use VMware Workstation Pro (“Create New Virtual Machine”) 
- Set OS: Windows Server 2022/2025 (x64 implied) 
- Configure: 
    – CPUs: 1–4 (based on workload) 
    – RAM: 4–12 GB per VM 
    – Disk: 40–150 GB (dynamic preferred) 
    – Network: Set to Host-Only or VMnet2 (same network for all VMs) 
- Mount ISO from a logical folder (e.g., C:\ISOs\) 

## 2. VM Build Order (Recommended)
 
1. AD-DomainController 
2. FileShare 
3. SQL-Dev ? WebApp-Dev 
4. SQL-Staging ? WebApp-Staging 
5. SQL-Prod ? WebApp-Prod 

## 3. Network Setup
 
- Use Virtual Network Editor: 
    – VMnet1: Host-only 
    – VMnet2+: Custom (no DHCP) 
- Ensure all VMs use the same VMnet for internal communication 
- Assign static IPs (e.g., 192.168.56.x) 

## 4. Shared Storage Options
 
- Option 1: FreeNAS VM (NFS or iSCSI) 
- Option 2: StarWind SAN Free (Windows, iSCSI) 
- Use for Cluster Shared Volume (CSV) 

## 5. Side Channel Mitigations
 
- Disable for lab performance (safe in isolated setups) 
- In VM settings or .vmx file: 
    – specCtrl.enable = “FALSE” 
    – ucodeReqMask = 0 

## 6. Post-Install PowerShell (Optional)
 
- Rename computer 
- Set static IP and DNS 
- Join Active Directory domain 
- Install Windows Features (e.g., Failover Clustering, Hyper-V) 

## 7. What NOT to Store in Git
 
- .vmdk, .vmx, .iso files (too large/sensitive) 
- Credentials, IPs, passwords 
- Instead: Track config scripts, setup guides, checklists 

