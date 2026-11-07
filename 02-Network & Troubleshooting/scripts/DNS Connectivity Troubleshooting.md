# INCIDENT CASE REPORT: NET-02

## 1. Case Metadata & Overview

| Header | Details | 
| ----- | ----- | 
| **Case ID** | NET-02 | 
| **Ticket Status** | Open (Investigating / Pending Further Telemetry) | 
| **Severity Level** | Medium (Host-Level DNS Resolution Failure) | 
| **Category** | Network & Connectivity / DNS Resolution | 
| **Affected Endpoint** | Windows Client (`192.168.1.25`) | 
| **Reported Issue** | Inability to access target external website using hostname (`www.example.com`) | 
| **Technician / Handler** | IT Support Specialist | 
| **Date / Time Logged** | 20 October 2026 | 

## 2. Investigation & Action Log

### 2.1 Client Network & IP Configuration Inspection

* **Action Taken:** Executed `ipconfig /all` to verify local IPv4 settings and identify assigned DNS name servers.

* **Observed Output:**

  ```
  IPv4 Address. . . . . . . . . . . : 192.168.1.25
  Subnet Mask . . . . . . . . . . . : 255.255.255.0
  Default Gateway . . . . . . . . . : 192.168.1.1
  DNS Servers . . . . . . . . . . . : 192.168.1.1
  
  ```

* **Analysis:**
  The client possesses a valid local IPv4 configuration and subnet mask. Unlike an APIPA state (`169.254.x.x`), the dynamic address assignment was successful, and a local DNS server (`192.168.1.1`) is populated. However, static configuration parameters do not guarantee operational status or reachability of the designated services.

### 2.2 Local Gateway Reachability Verification

* **Action Taken:** Issued ICMP echo request (`ping 192.168.1.1`) to check Layer 3 connectivity to the local default gateway.

* **Observed Output:**

  ```
  Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
  Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
  Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
  Reply from 192.168.1.1: bytes=32 time<1ms TTL=64
  
  ```

* **Analysis:**
  Successful ICMP replies confirm local Layer 2 and Layer 3 communication with the gateway is healthy. A total local network hardware or link isolation is ruled out at this stage.

### 2.3 DNS Name Resolution Query Test

* **Action Taken:** Queried external hostname resolution using `nslookup www.example.com`.

* **Observed Output:**

  ```
  Server:  Unknown
  Address: 192.168.1.1

  DNS request timed out.
      timeout was 2 seconds.
  DNS request timed out.
      timeout was 2 seconds.
  *** Request to Unknown timed-out
  
  ```

* **Analysis:**
  The name resolution query failed due to a repeated timeout. While the `Server: Unknown` header indicates a reverse-lookup naming mismatch on the server itself, the critical finding is the query timeout, confirming that the client is unable to obtain translation records from the designated DNS resolver.

### 2.4 External Raw IP & TCP Connectivity Verification

* **Action Taken:** Tested direct IP reachability using `ping 93.184.216.34` and application layer connection via `Test-NetConnection www.example.com -Port 443`.

* **Observed Output:**

  * *Raw IP Ping:* Request timed out (4/4 packets lost).

  * *TCP Connection Test:* `WARNING: Name resolution of www.example.com failed` with `TcpTestSucceeded : False`.

* **Analysis:**
  The direct external IP ping timed out, though this is inconclusive as many intermediate nodes or target endpoints drop ICMP echo requests. The `Test-NetConnection` utility failed immediately during the initial name-resolution phase, preventing TCP socket handshaking on Port 443.

## 3. Diagnostic Summary & Evidence Matrix

| Diagnostic Step | Command / Artifact | Observed Result | Case Assessment | 
| ----- | ----- | ----- | ----- | 
| **IP Configuration** | `ipconfig /all` | Valid IPv4 assigned; Gateway & DNS set to `192.168.1.1` | Local client parameters are correctly populated. | 
| **Gateway Ping** | `ping 192.168.1.1` | Success (`<1ms` latency, TTL=64) | Local network connectivity and gateway routing are operational. | 
| **DNS Lookup** | `nslookup www.example.com` | Request timed out (2s interval) | DNS queries sent to resolver are dropped or unanswered. | 
| **Raw IP Ping** | `ping 93.184.216.34` | Request timed out (Inconclusive) | ICMP blocked or external routing issue; non-definitive. | 
| **TCP Port Check** | `Test-NetConnection` | Name resolution failed; TCP test aborted | Application connectivity blocked by prior name resolution failure. | 

## 4. Findings & Current Case Status

### 4.1 Technical Finding

The client is experiencing a targeted **DNS resolution failure**. While local connectivity to the default gateway is healthy, recursive DNS queries sent to the local resolver (`192.168.1.1`) consistently time out, preventing hostname translation and subsequent application-layer connections.

### 4.2 Root Cause Analysis (RCA)

**Status: Unconfirmed / Under Investigation**

The underlying cause of the DNS timeout remains unverified. Supported hypotheses include:

1. **Resolver Service Failure:** The local DNS forwarder/server on the gateway or upstream resolver is offline or unresponsive.

2. **Network Filtering / Firewall Rules:** UDP/TCP Port 53 traffic is being dropped or filtered along the path between the host and the DNS server.

3. **Misconfiguration:** The assigned DNS server address is invalid or lacks proper upstream forwarding routes.

### 4.3 Recommended Next Steps & Remediation Plan

* \[ \] Test DNS resolution using a known public resolver (e.g., `nslookup www.example.com 8.8.8.8`) to isolate local gateway DNS forwarding issues from general internet filtering.

* \[ \] Clear and inspect local DNS resolver cache using `ipconfig /flushdns`.

* \[ \] Verify local firewall rules or security software logs to ensure Port 53 outbound traffic is permitted.

* \[ \] Escalate to network infrastructure team if upstream recursive resolvers on `192.168.1.1` are confirmed down.

### 5. Sign-off & Record

* **Incident Reported By:** User / Simulated Scenario

* **Documented By:** Helpdesk Tier 1 / IT Support Specialist

* **Ticket Resolution State:** **Unresolved / Pending Verification (DNS Timeout Isolated)**
