# System Hardening Guidelines

## 1. Operating System Hardening

- Disable unnecessary services (e.g., Telnet, FTP)
- Apply latest security patches and OS updates
- Enforce minimum password complexity and lockout policies
- Enable Windows Defender or appropriate endpoint protection
- Disable guest account and rename admin account

## 2. SQL Server Hardening

- Use Windows Authentication wherever possible
- Disable SA account or rename and limit access
- Set up role-based access control (RBAC)
- Enable Transparent Data Encryption (TDE)
- Regularly audit login and access logs

## 3. Virtual Machine Hardening

- Disable clipboard sharing, drag-and-drop, and USB passthrough
- Encrypt VM disk images
- Isolate dev, staging, and prod environments
- Install VM guest tools from trusted sources only

## 4. Network Hardening

- Disable unused ports at the firewall and switch level
- Enable IDS/IPS monitoring
- Use VPN or IPsec for remote connections
- Segregate networks (e.g., DMZ for public access services)

## 5. Logging and Auditing

- Centralize logs with a SIEM (Security Information and Event Management platform that collects and analyzes security data from across the infrastructure)
-	Use Microsoft Sentinel for cloud-based log management
- Enable verbose logging for authentication, authorization, and privilege changes
- Rotate logs regularly and secure log directories
