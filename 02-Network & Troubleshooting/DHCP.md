# DHCP (Dynamic Host Configuration Protocol)

## 1. Purpose

This document records the core concepts and practical inspection methods related to Dynamic Host Configuration Protocol (DHCP) in Windows networking.
DHCP allows a client device to obtain network configuration automatically, reducing the need to configure each device manually.

- The purpose of DHCP
- The DHCP address allocation process
- DHCP leases and client configuration
- DHCP-related Windows commands
- APIPA and common symptoms of DHCP configuration problems
- Troubleshooting considerations and limitations


## 2. What Is DHCP?

DHCP is a network protocol that enables a client to obtain configuration information from a DHCP server.

Depending on the network, the configuration may include:

- IPv4 address
- Subnet mask
- Default gateway
- DNS server addresses
- Lease duration and related configuration options

A DHCP server may run on a home router, a dedicated server, or network infrastructure managed by an organisation.
Obtaining an IP address through DHCP does not guarantee that the client has working internet access. The gateway, DNS, routing, firewall rules, and upstream connectivity may still require investigation.

## 3. How DHCP Works

### 3.1 The DORA Process

A common DHCPv4 address allocation process is described using four steps: Discover, Offer, Request, and Acknowledgment (DORA).

1. Discover: The client broadcasts a DHCP discovery message to locate available DHCP servers.
2. Offer: A DHCP server offers an available IP address and configuration.
3. Request: The client requests the offered address.
4. Acknowledgment: The server acknowledges the request and confirms the lease.

The client can then configure its network interface using the assigned settings.
This sequence describes a common initial address allocation process. DHCP renewals, address reservations, multiple servers, relays, and other situations can involve different message sequences or additional details.

### 3.2 DHCP and Network Segments

DHCP discovery messages are normally broadcast within the local network segment.
If the DHCP server is on a different IP subnet, a DHCP relay agent may forward relevant DHCP messages between the client network and the server.
Consequently, a client failing to obtain an address does not automatically mean that the DHCP server is offline. The problem may occur anywhere along the path between the client and the service.

## 4. DHCP Leases

### 4.1 What Is a Lease?

A DHCP lease grants a client permission to use an assigned IP address for a specified period, subject to the DHCP configuration and protocol rules. The client generally attempts to renew its lease before it expires. When a lease is renewed successfully, the client can continue using the address. If renewal fails, the outcome depends on the lease state and subsequent DHCP communication.

### 4.2 DHCP Reservation vs Static Configuration

A DHCP reservation associates a particular client identity with a designated address in the DHCP server's configuration.
A statically configured address is entered directly into the client's network settings rather than obtained through ordinary DHCP address allocation.

| Configuration | Description |
|---|---|
| DHCP dynamic allocation | The server allocates an address from its configured address pool |
| DHCP reservation | The server is configured to allocate a designated address to a matching client |
| Static IP configuration | The address is manually configured on the client |

These approaches serve different purposes. A manually configured address must be chosen carefully to avoid conflicts with other devices and to match the intended network configuration.

## 5. DHCP on Windows

### 5.1 Check Whether DHCP Is Enabled

Run the following command: ipconfig /all
Locate the relevant network adapter and review:

- `DHCP Enabled`
- `IPv4 Address`
- `Subnet Mask`
- `Default Gateway`
- `DHCP Server`, if shown
- `Lease Obtained`, if shown
- `Lease Expires`, if shown
- `DNS Servers`

Interpret the values together.
For example, `DHCP Enabled: Yes` indicates that the adapter is configured to obtain its address through DHCP. It does not prove that a DHCP server successfully supplied the current configuration.

### 5.2 Inspect IP Configuration with PowerShell
This provides a summary of IP configuration for network interfaces: Get-NetIPConfiguration
For more detailed information about IPv4 addresses and their associated configuration, use: Get-NetIPAddress -AddressFamily IPv4

Review the interface involved in the investigation rather than assuming every address belongs to the active network connection.

### 5.3 Release and Renew a DHCP Lease

The following commands can be used to request a DHCP lease release and renewal for eligible DHCP-configured adapters: ipconfig /release; ipconfig /renew
* These commands change the active network configuration use carefully. 

On a computer with multiple adapters, VPNs, or a remote session, releasing an address can disrupt access. First inspect the current configuration and confirm that the action is appropriate. Releasing and renewing a lease may help when the client has an address or lease problem, but it does not repair an unavailable DHCP server, a broken network link, or an incorrect network configuration elsewhere.

## 6. Understanding APIPA

### 6.1 What Is APIPA?

Automatic Private IP Addressing (APIPA) allows Windows to assign a link-local IPv4 address when a DHCP client cannot obtain an IPv4 address through DHCP.
APIPA addresses fall within: 169.254.0.0/16
An APIPA address is intended for communication on the local link. It does not provide ordinary routed connectivity to the internet through a default gateway.

### 6.2 What Does an APIPA Address Indicate?

An APIPA address is evidence that the client does not have the expected DHCP-assigned IPv4 configuration at that observation point.
Possible areas to investigate include:

- The Ethernet cable, Wi-Fi association, or network adapter
- The local switch or wireless access point
- VLAN configuration or network segmentation
- DHCP server availability and address-pool capacity
- DHCP relay configuration, where applicable
- Firewall or network filtering affecting DHCP traffic
- Client-side configuration or software problems

The address alone cannot identify which component is responsible.

### 6.3 APIPA Does Not Automatically Mean the DHCP Server Is Faulty

For example, if a Windows client has an address beginning with `169.254`, the correct initial observation is:
"The client has an APIPA address and does not appear to have obtained the expected DHCP IPv4 configuration."
A stronger conclusion, such as "the DHCP server is down", requires additional evidence.
The next investigation should establish whether the adapter is connected, whether the client is on the expected network, and whether DHCP communication can reach an appropriate server.

## 7. Common DHCP Symptoms

| Observation | Possible interpretation | Further evidence needed |
|---|---|---|
| DHCP is enabled and a normal IPv4 address is assigned | The adapter has an IPv4 configuration | Check gateway, DNS, routing, and the required destination |
| IPv4 address begins with `169.254` | APIPA configuration is present | Check the link, network segment, DHCP path, and client state |
| No expected default gateway appears | The client may have incomplete or unusual configuration | Review the intended network design and DHCP options |
| Address renewal fails | The client could not complete the requested renewal operation | Record the exact error and inspect the client and network path |
| Two devices appear to use the same IPv4 address | An address conflict may exist | Verify the addresses, interface identities, and network configuration |
| DHCP works on one network but not another | The problem may depend on the network or its configuration | Compare adapter settings, VLANs, relay paths, and DHCP scopes |

These are investigation clues rather than definitive diagnoses. A single observation rarely identifies the root cause.

## 8. Practical Investigation Principles

When investigating a possible DHCP problem:

1. Record the current adapter status and IP configuration.
2. Identify whether the adapter uses DHCP or a static address.
3. Check whether the assigned address and subnet match the expected network.
4. Record the presence or absence of a default gateway and DNS configuration.
5. Note the exact error returned by any release or renewal command.
6. Compare the result with a known working configuration where appropriate.
7. Escalate to network infrastructure checks when the evidence points beyond the client.

A client-side investigation may not provide access to the DHCP server's lease database, address-pool utilisation, server logs, or relay configuration. Document these limitations instead of claiming to have verified infrastructure that was not accessible.

## 9. Key Takeaways

- DHCP automatically provides IP configuration to clients.
- DORA describes a common DHCPv4 initial address allocation process.
- A DHCP lease allows a client to use an assigned address for a defined period.
- DHCP reservations and manually configured static addresses are different approaches.
- An APIPA address indicates that the expected DHCP IPv4 configuration was not obtained; it does not identify the root cause.
- `ipconfig /all` is a useful starting point for examining DHCP-related client configuration.
- DHCP success does not guarantee DNS resolution, gateway reachability, or internet access.
- Reliable troubleshooting separates observed configuration from hypotheses and verified conclusions.

# DNS and DHCP Troubleshooting Runbook

## Purpose

To distinguish DHCP address-assignment problems from DNS resolution problems.

## Procedure

### Step 1 — Check IP configuration

Use:

ipconfig /all

Record:

* IPv4 address
* Subnet mask
* Default gateway
* DHCP server
* DNS servers

### Step 2 — Check for APIPA

If the address is: 169.254.x.x

Investigate why the client did not obtain a DHCP lease.

Possible fault domains include:

* NIC
* Wi-Fi
* Cable
* Switch/AP
* VLAN
* DHCP path
* DHCP server

Do not assume the DHCP server is the root cause.

### Step 3 — Test gateway connectivity

If the gateway cannot be reached:

Investigate local network connectivity before investigating DNS.

### Step 4 — Test DNS resolution

Use:

nslookup

Compare:

* DNS resolution failure
* IP connectivity failure

### Step 5 — Test direct IP connectivity

If appropriate, test the destination by IP address.

This helps determine whether the problem is:

* DNS
* Network connectivity
* Remote service

### Step 6 — Verify

Confirm:

* Valid IP address
* Working gateway
* Successful DNS resolution
* Successful destination connectivity
