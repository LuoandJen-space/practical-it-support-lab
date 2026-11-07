# Network Baseline

## 1. Purpose

This document records the basic network configuration and connectivity observations collected from a Windows computer at a particular point in time.
A network baseline provides a reference for understanding the computer's current network state and comparing it with later observations.
The baseline may include:

- Network adapter status
- IPv4 address and subnet mask
- Default gateway
- DNS server configuration
- DHCP configuration
- Basic connectivity test results

A baseline describes the observed state. It does not, by itself, prove that the entire network is functioning correctly.

## 2. Network Configuration Overview

### 2.1 Network Adapter

A network adapter enables a computer to communicate over a network. Examples include Ethernet adapters and Wi-Fi adapters.
When collecting a baseline, record:

- Adapter name
- Connection type
- Adapter status
- IPv4 configuration
- DNS server configuration

A connected adapter does not necessarily mean that the computer can reach the internet. Connectivity also depends on factors such as IP configuration, routing, DNS, network equipment, and the destination service.

### 2.2 IPv4 Address

An IPv4 address identifies a network interface within an IP network.
When inspecting an IPv4 address, consider:

- Whether an address is assigned
- Whether it belongs to the expected network
- Whether it is consistent with the subnet mask
- Whether the configuration is automatic or static

An address alone is not enough to determine whether a connection is working.

### 2.3 Subnet Mask

A subnet mask identifies which part of an IPv4 address represents the network prefix and which part represents the host portion.
For example: `255.255.255.0` corresponds to the prefix `/24`.
The subnet mask helps determine whether another IPv4 address belongs to the same local subnet or whether traffic normally needs to be sent through a router.

### 2.4 Default Gateway

The default gateway is the next-hop router used when traffic must be sent outside the computer's directly connected network and no more specific route takes precedence.
When collecting a baseline, record the configured gateway and test whether it is reachable where appropriate.
A missing or unreachable default gateway may affect external connectivity. However, the result must be interpreted alongside the network configuration and the intended network design.

### 2.5 DNS Servers

DNS servers resolve domain names, such as 'google.com', into IP addresses and may provide other DNS records.
Record the DNS servers configured for the relevant adapter.
A computer may have working IP connectivity but still experience problems accessing services by domain name if name resolution fails.
DNS configuration alone does not prove that name resolution is working; an actual query provides additional evidence.

### 2.6 DHCP

Dynamic Host Configuration Protocol (DHCP) allows a client to obtain network configuration automatically, including an IP address and other settings.
When DHCP is enabled, record whether the adapter is configured to obtain its IP address automatically and whether a valid configuration appears to have been assigned.
A Windows DHCP client cannot obtain an IPv4 address through DHCP.
An APIPA address is a useful troubleshooting clue, but it does not prove that the DHCP server itself is faulty. The cause may involve the client, adapter, cable, wireless connection, switch, access point, VLAN, DHCP relay, or DHCP service.

## 3. Collecting Network Information

### 3.1 Inspect the Current IP Configuration

Run the following read-only command in Command Prompt or PowerShell: ipconfig /all
Review the relevant adapter and record:

- Description
- Physical Address
- DHCP Enabled
- IPv4 Address
- Subnet Mask
- Default Gateway
- DHCP Server, when shown
- DNS Servers
- Lease Obtained and Lease Expires, when shown

Focus on the adapter actually being used. Virtual adapters, VPNs, disconnected adapters, and other interfaces may also appear in the output.

### 3.2 Check Adapter Status

In PowerShell, run: Get-NetAdapter |
    Select-Object Name, InterfaceDescription, Status, LinkSpeed
This command provides a basic view of adapter status and reported link speed.
A disconnected Ethernet adapter may indicate a physical link issue, while a disconnected Wi-Fi adapter may simply not be associated with a wireless network. Interpret the status in context.

### 3.3 Inspect the Routing Table
route print -4

This displays the IPv4 routing table.
The routing table helps identify available routes and the route Windows may use to reach a destination. The default route is commonly represented by a destination and network mask of `0.0.0.0`, with a gateway and interface associated with it.
The presence of a default route does not guarantee that the gateway or an external destination is reachable.

## 4. Basic Connectivity Observations

A baseline can include simple connectivity tests to establish what worked at the time of testing.

### 4.1 Test the Local TCP/IP Stack
ping 127.0.0.1
This tests the local IPv4 loopback path.
A successful result does not establish that the network adapter, local network, gateway, or internet connection is working.

### 4.2 Test the Default Gateway
Replace the example address with the gateway recorded from the actual network configuration:
ping <default-gateway-ip>
Record whether replies were received or the request timed out.
Some gateways or network devices do not respond to ICMP echo requests. Therefore, a failed ping alone does not prove that the gateway is unavailable.

### 4.3 Test Name Resolution
nslookup example.com
Record the DNS server used and whether the query returned a result.
This checks DNS resolution for the selected name. It does not prove that every domain resolves correctly or that the destination service is available.

### 4.4 Test a Specific TCP Service
When appropriate, test a known destination and port:
Test-NetConnection example.com -Port 443
Record the value of `TcpTestSucceeded` and any relevant output.
A successful TCP connection indicates that the tested TCP connection could be established at that time. It does not prove that all network services are reachable or that an application is functioning correctly.

## 6. Interpreting the Baseline

Interpret the collected information as a whole rather than relying on a single command or result.
Examples of useful observations include:

- An adapter is connected and has an IPv4 address consistent with the expected network.
- The adapter is configured for DHCP and has received an address, gateway, and DNS configuration.
- The computer can reach the default gateway, but a selected DNS query fails.
- The computer has an IPv4 address in the APIPA range and no expected DHCP configuration.
- DNS resolution succeeds, but a connection to a particular TCP service fails.

These observations help narrow the next investigation step, but they do not automatically establish a root cause.
For example, successful DNS resolution does not prove that the destination application is available. Likewise, failure to receive a ping response does not necessarily mean that the destination is offline.

## 7. Limitations

A network baseline represents the state observed during a particular session. Network configuration and connectivity may change because of:

- DHCP lease renewal or address changes
- Switching between Ethernet and Wi-Fi
- VPN connections
- Adapter or driver changes
- Router, switch, or access point changes
- Firewall rules
- DNS configuration changes
- Remote service availability

A baseline is a reference point, not a guarantee of future availability or complete network health.

## 8. Key Takeaways

- Record the actual network configuration before drawing conclusions.
- Check the adapter in use rather than assuming every listed interface is relevant.
- Understand the relationship between IP address, subnet mask, gateway, DNS, and routing.
- Use connectivity tests to gather evidence, not to make unsupported assumptions.
- Distinguish observed facts from possible explanations.
