# Windows Services

## 1. Purpose

Windows services are background components that provide operating system or application functionality.

Services may run without a user directly interacting with them. They can support networking, printing, updates, time synchronisation, and other system functions.



## 2. Core Concepts

### Service

A service is a Windows component managed through the Windows Service Control Manager (SCM).

A service has properties such as its service name, display name, state, startup type, and dependencies.

### Process

A process is a running instance of a program.

A service may run within its own process or share a process with other services. Therefore, a service and a process are related but are not the same thing.

### PID

A Process ID (PID) identifies a running process.

PIDs can help correlate a service with a process when investigating system activity. A PID may change when a process restarts.

### Dependencies

Some services depend on other services or system components.

If a service fails to start, its dependencies may be relevant to the investigation. However, a dependency should be checked rather than assumed to be the cause.

## 3. Service Startup Types

|Startup Type|Meaning|
|-|-|
|Automatic|Windows is configured to start the service automatically during system startup.|
|Automatic (Delayed Start)|The service is configured to start automatically after other automatic-start services have had time to start.|
|Manual|The service is not configured for ordinary automatic startup; it may be started manually or by another component when needed.|
|Disabled|The service cannot be started normally until its startup configuration is changed.|
|Trigger Start|A service is configured to start in response to a specific trigger, depending on its configuration.|

\*Startup type and current service state are different properties.

For example, a service can have a Manual startup type and currently be Running.

A stopped service is not necessarily faulty. Some services only run when required.

## 4. How to Inspect Services

### Method A — Services Console

1. Press `Win + R`.
2. Enter `services.msc`.
3. Locate the service.
4. Review its service name, status, and startup type.
5. Open Properties to inspect additional configuration and dependencies.

Do not change service settings simply because a service is stopped or set to Manual.

### Method B — PowerShell

These commands inspect system information. They do not change service configuration.

List services and their current states: Get-Service

Inspect a specific service: Get-Service -Name Spooler

Inspect a process by PID: Get-Process -Id <PID>

This command retrieves service information, including state, configured start mode, and associated process ID where available.

Inspecting Service Configuration: Get-CimInstance Win32\_Service | Select-Object Name, State, StartMode, ProcessId

## 5. Service vs Process

A service and a process describe different things.

|Concept|Question It Answers|
|-|-|
|Service|Which managed Windows service are we examining?|
|Process|Which running program instance is executing?|
|PID|Which specific process instance is this?|
|Startup Type|How is the service configured to start?|
|State|Is the service currently running or stopped?|
|Dependency|Does the service rely on another service or component?|
|Required|Do any other services or components depend on this service?|

Multiple services may share one process. 

## 6. Practical Observations

During Windows troubleshooting practice, service information was inspected using the Services console and PowerShell.

Examples of services examined included:

* Print Spooler (`Spooler`)
* Background Intelligent Transfer Service (`BITS`)
* Windows Time (`W32Time`)
* Remote Procedure Call (`RPCSS`)

Relevant observations included service state, startup type, process ID where applicable, and service-related events.

A service state or event should be interpreted in context. It does not independently establish the root cause of a problem.

## 7. Key Takeaways

* A service is not the same as a process.
* A PID identifies a process instance, not a permanent service identity.
* Startup type is different from current state.
* Manual or Trigger Start does not automatically indicate a problem.
* Service dependencies can provide useful investigation leads.
* Event Viewer can provide additional evidence when a service fails.
* Collect evidence before changing service configuration.
* Verify the original symptom after any troubleshooting change.

