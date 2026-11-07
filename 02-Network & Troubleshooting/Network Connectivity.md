# Network Connectivity

## 1. Purpose

Network connectivity testing helps determine whether a computer can communicate with a local device, a gateway, a remote IP address, or a specific network service.

This document covers:

- Basic network communication
- ICMP and 'ping'
- Routing tables and 'tracert'
- TCP connectivity testing
- Interpreting combined test results
- Common limitations of network diagnostic tools

The objective is to understand what each test demonstrates, what it does not demonstrate, and what additional evidence may be required.

## 2. Connectivity Fundamentals

Network connectivity involves several components working together.
A Windows computer may need to:

1. Establish a network connection through Ethernet or Wi-Fi.
2. Obtain an appropriate IP configuration.
3. Communicate with devices on the local network.
4. Reach a gateway when communicating outside the local subnet.
5. Follow an appropriate route towards the destination.
6. Establish a connection to the required service.

DNS resolution may also be required when the destination is specified by hostname rather than IP address. These components are related, but they are not interchangeable. For example, a computer can have a valid IP address while being unable to reach a remote service. A useful investigation separates the different stages instead of treating network connectivity as a single pass-or-fail condition.

## 3. ICMP and Ping

### 3.1 What Is ICMP?

Internet Control Message Protocol (ICMP) supports network diagnostic and error-reporting functions. The 'ping' command commonly sends ICMP Echo Request messages and checks whether corresponding Echo Reply messages are received. Ping is useful for testing basic IP-level reachability between the source and destination.

### 3.2 Test the Local TCP/IP Stack
ping 127.0.0.1
The address '127.0.0.1' is an IPv4 loopback address.
A successful response provides evidence that the local IPv4 loopback path is functioning. It does not test the physical network adapter, local network, gateway, or internet connection.

### 3.3 Test the Default Gateway
First identify the configured gateway: ipconfig
Then use the actual gateway address: ping <default-gateway-ip>
A successful response indicates that the gateway responded to ICMP Echo Requests from the computer. A failed response does not necessarily mean that the gateway is unavailable. The device may filter ICMP, or the request or response may be blocked or lost elsewhere along the path.
Interpret the result alongside the adapter status, IP configuration, and other connectivity evidence.

### 3.4 Test a Remote IP Address: 
This tests whether the destination responds to ICMP Echo Requests: ping <destination-ip>

A successful response demonstrates ICMP reachability at the time of testing. It does not guarantee that a particular application or TCP port is available.
A failed response may result from:

- The destination being unavailable
- ICMP filtering
- Firewall rules
- Routing problems
- Packet loss
- Network congestion

Ping results must therefore be interpreted in context.

## 4. Routing and Network Paths

### 4.1 Inspect the Routing Table
This displays the IPv4 routing table: route print -4
The routing table contains information Windows uses to select a route for IPv4 traffic.
When reviewing the output, pay attention to:

- Destination network
- Network mask or prefix
- Gateway
- Interface
- Route metric

The default route commonly uses destination `0.0.0.0` and network mask `0.0.0.0`. A default route is used when no more specific applicable route takes precedence. Windows considers route specificity and metrics when selecting a route. The presence of a default route does not prove that the gateway is reachable or that traffic can reach the intended destination.

### 4.2 Trace a Network Path
`tracert` attempts to identify successive network hops towards a destination by using IP packets with increasing TTL values: tracert <destination-ip>
The output may show intermediate routers that return the relevant ICMP responses. Some hops may display timeouts or asterisks because devices do not respond to the probes, filter the traffic, or otherwise prevent the expected response. A missing response at one hop does not automatically mean that traffic cannot pass through that device. If later hops respond, traffic is clearly progressing beyond the non-responding hop for those probes. Similarly, the final destination not responding to `tracert` does not necessarily prove that the destination is unreachable.

## 5. TCP Connectivity Testing

### 5.1 Why Test TCP?

Some network services use TCP connections rather than ICMP Echo Requests. A device may ignore ping requests while still accepting connections to a required TCP port. Testing the actual service port can therefore provide more relevant evidence than relying on ping alone.

### 5.2 Use Test-NetConnection

For example, test TCP port 443 on a hostname: Test-NetConnection example.com -Port 443

Review the relevant output fields:

| Field | Meaning |
|---|---|
| `ComputerName` | The specified destination name |
| `RemoteAddress` | The destination IP address selected for the test |
| `RemotePort` | The TCP port being tested |
| `SourceAddress` | The local source address used |
| `TcpTestSucceeded` | Whether the TCP connection test succeeded |

The exact output may vary by Windows version and test conditions.

### 5.3 Interpret the Result

If `TcpTestSucceeded` is `True`, the test established a TCP connection to the selected destination address and port at that time. This does not prove that the application will function correctly after the connection is established. Additional requirements may include TLS negotiation, authentication, application protocols, and server-side processing.
If the result is `False`, possible explanations include:

- The service is not listening on the selected port.
- A firewall or network policy blocks the connection.
- The destination is unavailable.
- The route to the destination is incorrect or unavailable.
- The connection attempt timed out.

Individual tests provide limited information. Combining results helps narrow the investigation.

### Scenario A: The Gateway Responds, but a Remote Destination Does Not

Observation: The default gateway responds to ping, but a remote IP address does not.
Possible explanations:
- The destination does not respond to ICMP.
- The remote network or destination is unavailable.
- A routing or filtering issue affects traffic beyond the local gateway.
Interpretation: Local communication with the gateway is demonstrated, but end-to-end connectivity is not established by these results alone.

### Scenario B: Ping Fails, but TCP Connectivity Succeeds

Observation: The destination does not respond to ping, but 'Test-NetConnection' succeeds for the required TCP port.
Interpretation: The destination is reachable for the tested TCP connection, even though ICMP Echo Requests did not receive a response.
This is an example of why a failed ping should not automatically be classified as a complete network failure.

### Scenario C: DNS Resolution Succeeds, but TCP Connectivity Fails

Observation: A hostname resolves to an IP address, but the TCP connection test fails.
Possible explanations:
- The service is unavailable.
- The tested port is incorrect or closed.
- A firewall or network policy blocks the connection.
- A routing or destination issue prevents the connection.
Interpretation: DNS resolution succeeded for the query, but the required TCP connection was not established. Further testing is needed to identify the cause.

### Scenario D: The Computer Has an APIPA Address

Observation: The computer has an IPv4 address in the `169.254.0.0/16` range.
Interpretation: Windows has assigned an Automatic Private IP Addressing (APIPA) address, commonly because the DHCP client could not obtain an IPv4 address through DHCP.
This is a clue to investigate the client configuration and network path. It does not, by itself, prove that the DHCP server is faulty.

### Scenario E: A Website Does Not Open, but DNS and TCP Tests Succeed

Observation: DNS resolution returns an address, and a TCP connection to the tested port succeeds, but the website still does not work as expected.
Possible explanations:
- TLS or certificate errors
- Proxy configuration
- Authentication problems
- Application-level errors
- An incorrect URL or service endpoint
- Server-side application problems
Interpretation: Successful DNS resolution and TCP connectivity do not guarantee successful application behaviour. The investigation must continue at the relevant application layer.

## 7. Practical Testing Principles

When collecting connectivity evidence:

1. Identify the source computer and destination being tested.
2. Record the time and network interface in use.
3. Inspect the current IP configuration.
4. Select tests that match the question being investigated.
5. Record the actual output and any error messages.
6. Compare results across tests instead of relying on a single command.
7. Distinguish confirmed observations from possible explanations.
8. Document additional tests needed to establish a root cause.

Choose tests carefully. For production systems, use approved diagnostic methods and follow the organisation's security and change-control requirements.

## 8. Limitations

Network diagnostic tools provide evidence about specific communication attempts, not a complete guarantee of network health.

Important limitations include:

- ICMP traffic may be filtered even when application traffic is permitted.
- 'tracert' may not receive responses from every intermediate router.
- TCP connectivity tests assess a particular destination and port, not every service.
- DNS resolution can succeed while routing, TCP, TLS, or application communication fails.
- Results can change over time because of network conditions, firewall rules, routing, and service availability.
- A successful test does not prove that all clients or destinations have the same connectivity.

A reliable conclusion should be limited to what the tests actually demonstrate.

## 9. Key Takeaways

- Connectivity should be assessed in stages rather than treated as one pass-or-fail condition.
- 'ping' tests ICMP responsiveness, not general application availability.
- 'route print -4' helps inspect the routes Windows can use.
- 'tracert' can provide clues about a network path, but missing hop responses do not automatically prove a failure.
- 'Test-NetConnection' can test whether a TCP connection to a specified destination and port can be established.
- DNS success, ICMP responsiveness, TCP connectivity, and application functionality are different observations.
- Combining test results produces stronger evidence than relying on one command.
- Good troubleshooting records what was observed, what remains uncertain, and what should be tested next.

# Network Connectivity Troubleshooting Runbook

## Purpose

To systematically isolate network connectivity problems.

## When to Use

Use this runbook when:

* Internet access fails
* A network resource cannot be reached
* A user reports intermittent connectivity
* An application cannot connect to a remote service

## Procedure

### Step 1 — Determine scope

Ask:

* Is only one device affected?
* Are multiple devices affected?
* Is one application affected?
* Is the issue local or remote?

### Step 2 — Check IP configuration

Use:

ipconfig /all

Check:

* IPv4 address
* Subnet mask
* Default gateway
* DNS servers
* DHCP status

### Step 3 — Check for APIPA

If the device has:

169.254.x.x

consider DHCP lease failure.

Do not immediately conclude that the DHCP server is broken.

### Step 4 — Test local network connectivity

Test the default gateway.

### Step 5 — Test external IP connectivity

Use ping where appropriate.

### Step 6 — Test DNS

Use: nslookup Determine whether hostname resolution is working.

### Step 7 — Check routing

Use:

tracert or route print

### Step 8 — Test service connectivity

Use: Test-NetConnection where a specific TCP service or port needs to be tested.

### Step 9 — Identify the fault domain

Classify the issue as potentially:

* Device
* NIC
* LAN/Wi-Fi
* Gateway
* DHCP
* DNS
* Routing
* Remote service
* Application

### Step 10 — Verify

Confirm connectivity after the suspected issue has been addressed.
