# DNS (Domain Name System)

## 1. Purpose

This document records the core concepts and practical inspection methods related to the Domain Name System (DNS) in Windows networking.
DNS translates domain names into information used to locate network services. For example, a computer may need to resolve 'example.com' to an IP address before establishing a connection to the destination.

This document covers:

- The purpose of DNS and how name resolution works
- Common DNS record types
- DNS configuration on Windows
- Using `nslookup` to investigate name resolution
- Common DNS symptoms and possible explanations
- The relationship between DNS resolution and network connectivity

## 2. What Is DNS?

The Domain Name System is a distributed naming system that provides information associated with domain names.
People commonly use domain names because they are easier to remember than IP addresses. Applications and operating systems use DNS responses to obtain records needed for tasks such as locating a service.

For example:

- Domain name: 'example.com'
- Possible DNS response: an IPv4 address associated with that name

The actual response depends on the domain, record type, DNS configuration, and current DNS data. DNS does not establish the network connection itself. It provides name-related information that applications can use when attempting to connect to a destination.

## 3. How DNS Resolution Works

### 3.1 Basic Resolution Process

A simplified DNS resolution process is:

1. An application requests information associated with a domain name.
2. Windows and the application may use locally available information, such as cached DNS results.
3. If a suitable result is not available locally, the DNS client sends a query to a configured DNS resolver.
4. The resolver returns an applicable DNS response or an error.
5. The application uses the returned information as appropriate.

A recursive resolver may obtain information from other DNS servers when necessary. The exact path depends on caching, DNS configuration, the requested record, and the resolver's behaviour. A successful DNS lookup does not guarantee that the destination is reachable or that its application is working.

### 3.2 DNS Cache

Display cached DNS client records: ipconfig /displaydns
The output can help identify cached information, but it is not a complete view of every DNS cache on the computer or throughout the network. A cached result may differ from a fresh query to a DNS server, depending on the record's remaining time to live (TTL) and other factors. DNS results may be cached to reduce repeated queries and improve response time.

### 3.3 DNS Server vs Domain Name

These are two different concepts:
Domain name: The name being resolved, such as `example.com`.
DNS server: The resolver that receives and processes a DNS query.

When investigating a DNS problem, record both the requested domain and the DNS server used. Otherwise, it may be difficult to determine whether a failure is associated with a particular resolver or name.

## 4. Common DNS Record Types

| Record type | Purpose |
|---|---|
| A | Maps a name to an IPv4 address |
| AAAA | Maps a name to an IPv6 address |
| CNAME | Provides an alias from one DNS name to another name |
| MX | Identifies mail servers for a domain |
| NS | Identifies authoritative name servers for a DNS zone |
| PTR | Supports reverse lookup from an IP address to a name |
| TXT | Stores text data used for various purposes, including domain verification |

Different applications and services depend on different record types. For example, a website connection may use an A or AAAA record, while mail delivery also depends on MX records and other mail-related configuration. A successful A-record lookup does not prove that every other DNS record for the domain is correct.

## 5. DNS Configuration on Windows

### 5.1 Inspect Configured DNS Servers
Locate the network adapter being used and inspect its 'DNS Servers' field: ipconfig /all

Record:
- Adapter name
- Configured DNS server addresses
- Whether the adapter uses DHCP
- Whether the computer is connected to a VPN or another network interface that may affect DNS resolution

The displayed DNS server addresses indicate the configured resolver addresses for the relevant adapter. They do not prove that those servers are reachable or returning correct answers.

### 5.2 Inspect DNS Client Configuration
This displays DNS server configuration associated with network interfaces: Get-DnsClientServerAddress

Compare the output with 'ipconfig /all' when necessary. Pay attention to the interface in use, as disconnected adapters, virtual interfaces, and VPNs may have separate DNS settings.

### 5.3 Check the DNS Client Service

The Windows DNS Client service supports DNS-related client functionality, including caching: Get-Service -Name Dnscache

The service state is one piece of information, not a complete diagnosis. A running DNS Client service does not guarantee that the configured DNS resolver is reachable or that a particular name can be resolved.

## 6. Testing DNS Resolution

### 6.1 Query a Domain Using nslookup
nslookup example.com

Review:
- The DNS server identified in the output
- The queried name
- The returned address or records
- Any error or timeout message

Record the actual output rather than assuming that every query will return a particular IP address. Public domains may return different addresses depending on location, DNS configuration, load balancing, and other factors.

### 6.2 Query a Specific Record Type

To query an IPv4 A record: nslookup -type=A example.com
To query an IPv6 AAAA record: nslookup -type=AAAA example.com
To query MX records: nslookup -type=MX example.com

These commands help narrow the investigation to a particular record type.

A domain may have an A record without having an AAAA record, or vice versa. The absence of one record type does not automatically indicate a DNS fault.

### 6.3 Query a Specific DNS Server

To compare the responses from different resolvers, query a specific server: nslookup example.com <dns-server-ip>
This can help determine whether the result differs between resolvers. However, different responses are not automatically evidence of a fault: DNS records may vary legitimately by resolver, location, or configuration.

### 6.4 Understand Common DNS Responses

| Response | General meaning | Important limitation |
|---|---|---|
| A or AAAA record returned | The query returned an address record | Does not prove the destination is reachable |
| `NXDOMAIN` | The response indicates that the queried name does not exist | Check the exact name and DNS context |
| `SERVFAIL` | The resolver could not successfully complete the query | The cause may require resolver-side investigation |
| `Request timed out` | No response was received within the expected time | Does not identify whether the issue is the client, network path, filtering, or resolver |
| No record of the requested type | No applicable record was returned for that query | The name may still have other valid record types |

## 7. DNS and Network Connectivity

DNS resolution and network connectivity are related but separate stages.
Consider these examples:

### Scenario A: DNS Fails

A domain name cannot be resolved, but the cause has not yet been identified.
Possible investigation areas include:

- Incorrect DNS server configuration
- An unreachable resolver
- A DNS service or forwarding problem
- Incorrect or unavailable DNS records
- Client-side configuration or caching

The next step is to gather more evidence before selecting a cause.

### Scenario B: DNS Succeeds but the Website Does Not Open

A DNS query returns an IP address, but the website remains unavailable.
Possible investigation areas include:

- Routing or general connectivity
- TCP port accessibility
- Firewall or proxy configuration
- TLS or certificate problems
- Web server or application availability

A successful DNS query only confirms that the query returned a result. It does not prove that the website is available.

### Scenario C: A Domain Works on One Network but Not Another

Possible explanations include:

- Different DNS resolvers
- Different VPN or split-DNS configuration
- Network filtering
- Different routes or firewall policies
- Differences in cached or resolver-provided DNS data

Compare the actual configuration and test results before concluding that DNS is the cause.

## 8. Practical Investigation Principles

When investigating a possible DNS problem:

1. Record the affected domain name and the observed symptom.
2. Inspect the DNS server configuration of the relevant network adapter.
3. Query the domain using 'nslookup'.
4. Record the resolver used and the exact response.
5. Where appropriate, compare results using an authorised alternative resolver.
6. If resolution succeeds, investigate the next stage of connectivity rather than repeatedly assuming DNS is faulty.
7. Record the evidence, possible explanations, tests performed, and remaining uncertainties.

A client-side investigation may not reveal the full configuration or logs of an organisation's DNS infrastructure. Document what was accessible and what still requires further investigation.

## 9. Evidence and Documentation

For a DNS investigation, record:

- Date and time of the test
- Computer or lab identifier
- Network adapter in use
- Queried domain and record type
- Configured DNS server
- Command executed
- Actual result or error message
- Relevant connectivity test results
- Possible explanations
- Follow-up tests and conclusions

Distinguish between a successful lookup, a successful network connection, and successful application behaviour. These are different observations.

## 10. Key Takeaways

- DNS provides name-related information that applications use to locate services.
- Windows may use cached information before querying a resolver.
- Different DNS record types serve different purposes.
- `ipconfig /all` and 'Get-DnsClientServerAddress' help inspect resolver configuration.
- 'nslookup' helps investigate DNS responses and compare resolvers.
- A DNS failure does not automatically identify the root cause.
- Successful DNS resolution does not guarantee that the destination service is reachable.
- Reliable troubleshooting depends on recorded evidence, carefully tested hypotheses, and clear conclusions.

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
