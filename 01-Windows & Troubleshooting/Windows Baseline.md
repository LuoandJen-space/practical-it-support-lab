# Windows Baseline

## 1\. Purpose

A Windows baseline is a record of a computer's observed system state at a particular time.
It provides a reference point for investigating performance problems, unexpected behaviour, and changes in system condition.
A baseline does not necessarily represent a perfectly healthy system. It records what was observed under the conditions at the time of collection.

## 2\. System Performance

### Task Manager

Task Manager provides an overview of system resource utilisation and running processes.

|Component|What to Observe|Why It Matters|
|-|-|-|
|CPU|Overall utilisation and processes using CPU|Helps identify periods of high processor activity|
|Memory|Memory usage and processes consuming memory|Helps assess memory pressure|
|Disk|Disk activity and processes generating disk activity|Helps investigate possible storage bottlenecks|
|Processes|Running applications and background processes|Helps identify processes associated with a symptom|

Resource utilisation should be interpreted in context. A high value is not automatically a fault, and a low value does not rule out every performance problem.

## 3\. Windows System State

### Services

Use the Services console to inspect service state and startup type.
Relevant observations include:

* Service name
* Current state
* Startup type
* Whether the service is relevant to the reported symptom

A stopped service is not automatically faulty. Some services are designed to start only when required.

### Device Manager

Use Device Manager to inspect installed hardware and device status.
Relevant observations include:

* Device name
* Device status
* Warning indicators
* Driver information when investigating a device-related issue

A warning indicator is evidence that requires further investigation, not a complete diagnosis.

### Event Viewer

Use Event Viewer to inspect recorded Windows system and application events.
Record relevant information such as:

* Timestamp
* Event source
* Event ID
* Event level
* Event message

Events should be correlated with the reported symptom and incident timeline. \*An error event does not automatically identify the root cause.

### Reliability Monitor

Use Reliability Monitor to review recorded application failures, Windows failures, and other reliability-related events.
Compare the displayed timeline with the time the problem was reported.

## 4\. Baseline Observations (On my PC)

The following values were observed during earlier Windows performance checks.

|Observation|Recorded Value|
|-|-|
|CPU utilisation|Approximately 2–4%|
|Memory usage|9.7 GB out of 16 GB, approximately 61%|
|Disk activity|0% at the recorded observation|
|Firefox with five tabs|Approximately 0.1–0.4% CPU|
|Memory with five Firefox tabs|Approximately 11.1 GB out of 16 GB|

These are observations from particular sessions on my PC, not universal Windows performance targets.

The values should not be compared directly unless the operating conditions are reasonably similar. Running applications, background tasks, and the time of measurement can affect the results.

## 5\. Interpretation and Limitations

A baseline helps establish a comparison point, but it does not independently establish whether a computer is healthy or faulty.

When investigating a reported problem:

1. Confirm the symptom and when it occurs.
2. Compare current observations with relevant baseline data.
3. Identify unusual behaviour or changes.
4. Collect additional evidence before forming a conclusion.
5. Verify findings against the original symptom.

### Key Principles

* A symptom is not a root cause.
* High resource utilisation is not automatically a fault.
* An event recorded in Event Viewer is not automatically the cause of an incident.
* A single measurement may not represent the system's normal behaviour.
* Record observations separately from hypotheses and conclusions.
