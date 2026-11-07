# Windows Drivers and Hardware

## 1. Purpose

This document records technical knowledge and practical observations related to Windows device management, hardware identification, and driver troubleshooting.
The purpose is to understand how Windows recognises hardware, how drivers enable communication between the operating system and devices, and how to collect evidence when a device behaves unexpectedly.
This document focuses on technical concepts and inspection methods. It does not assume that a warning, error, or unexpected restart automatically indicates a faulty driver or hardware component.

## 2. Core Concepts

### 2.1 Hardware Devices

Hardware devices are physical components connected to or installed in a computer. Examples include:

- Graphics cards
- Network adapters
- Storage controllers and drives
- Audio devices
- USB devices
- Memory and motherboard components
Windows detects supported devices and uses device drivers to communicate with them.

### 2.2 Device Drivers

A device driver is software that allows Windows and applications to interact with a particular hardware device or device class.
Drivers may be provided by Microsoft, the hardware manufacturer, or another software vendor.
A device may experience problems when its driver is missing, incompatible, corrupted, outdated, or incorrectly configured. However, similar symptoms can also result from hardware faults, power problems, firmware issues, or other software problems.

*A driver-related symptom is a lead to investigate, not proof of root cause.

### 2.3 Device Manager

Device Manager is a Windows utility for inspecting detected hardware devices and their reported status.

It can be used to:

- Identify devices recognised by Windows.
- Check whether a device reports an error.
- View driver provider, version, and date.
- Inspect hardware IDs.
- Review device properties and status messages.
- Check whether Windows has identified a problem with a device.

A device appearing in Device Manager does not necessarily mean that it is functioning correctly. Likewise, a device without a warning icon is not guaranteed to be free of hardware or performance problems.

## 3. Inspecting Device Status and Driver Information

### 3.1 Using Device Manager

Open Device Manager:
1. Right-click Start.
2. Select 'Device Manager'.
3. Expand the relevant device category.
4. Open the device's Properties.
5. Review the **General**, **Driver**, and **Details** tabs.

Record the following information when investigating a device:

| Field | Purpose |
|---|---|
| Device name | Identifies the device as displayed by Windows |
| Device status | Shows whether Windows reports a problem |
| Driver provider | Identifies the reported driver provider |
| Driver version | Helps identify the installed driver release |
| Driver date | Provides additional version context |
| Hardware IDs | Helps identify the device's hardware identity |

Driver dates and versions should be interpreted in context. A relatively old driver date does not, by itself, prove that the driver is defective or incompatible.

### 3.2 Checking Hardware Information with PowerShell
List detected Plug and Play devices:
Get-PnpDevice |
    Select-Object Status, Class, FriendlyName

Inspect devices reported as having a problem:
Get-PnpDevice |
    Where-Object { $_.Status -ne 'OK' } |
    Select-Object Status, Class, FriendlyName, InstanceId
This second command is a starting point rather than a complete fault detector. A device can have a functional problem without appearing in this list, and some non-OK states require further context.

Inspect display adapters:
Get-CimInstance Win32_VideoController |
    Select-Object Name, DriverVersion, DriverDate, Status
The available fields and the meaning of the reported status may vary by device and driver.

## 4. Understanding Hardware IDs

Hardware IDs help Windows and administrators identify a device and match it with a suitable driver.
A hardware ID is an identification clue, not a complete diagnosis. It does not establish whether the device is physically healthy, whether its driver is functioning correctly, or whether the device is responsible for a system crash.
When recording a hardware ID, preserve the full identifier where practical. The full value may contain additional information useful for distinguishing devices and matching drivers.

## 5. Driver and Hardware Troubleshooting Principles

### 5.1 Separate Symptoms from Causes

| Symptom | Possible investigation areas |
|---|---|
| Device Manager reports a device problem | Device status, driver compatibility, connection, hardware |
| Graphics-related application crash | Application logs, graphics driver, GPU load, temperatures, hardware stability |
| Unexpected restart | Bugcheck events, system logs, power delivery, thermal conditions, hardware and software |
| Device is missing | Physical connection, firmware settings, device detection, driver availability |
| Display output stops working | Monitor and cable, graphics output, GPU, driver, power and system state |

These are investigation directions, not one-to-one mappings between symptoms and causes.

### 5.2 Use Multiple Sources of Evidence

A more reliable investigation combines relevant information from several sources:

1. **Device Manager:** device status, driver details, hardware IDs.
2. **Event Viewer:** errors and warnings around the incident time.
3. **Reliability Monitor:** a timeline of application failures, Windows failures, and other reported events.
4. **System behaviour:** what happened, when it happened, and whether it can be reproduced.
5. **Recent changes:** driver updates, Windows updates, new hardware, configuration changes, or physical movement.

The objective is to establish whether the evidence supports a particular hypothesis and to identify what remains uncertain.

### 5.3 Avoid Premature Driver Changes

Before changing a driver, record the current version and the observed symptom.
Driver updates, rollbacks, and reinstalls can be useful when supported by evidence, but changing multiple components at once makes it harder to determine which change affected the result.
For managed or production computers, follow the organisation's change-control process and confirm that the proposed driver is appropriate for the device and Windows version.

## 6. Practical Observations of my PC

### 6.1 Graphics Driver Inspection 
During a Windows troubleshooting exercise, the following information was recorded for a graphics device:

| Field | Observation |
|---|---|
| Graphics device | NVIDIA GeForce GTX 1070 |
| Driver version | `32.0.15.6094` |
| Driver date | 14 August 2024 |
| Hardware ID fields observed | `PCI\VEN_10DE` and `DEV_1B81` |

These values describe the information observed on that computer at that time. They do not establish that the graphics driver was faulty.

### 6.2 BugCheck Observation

A Windows event investigation included BugCheck Event ID `1001`, with bugcheck code `0x116`. This code is associated with `VIDEO_TDR_FAILURE`, a failure involving Windows' timeout detection and recovery mechanism for graphics processing. The code provides a direction for further investigation, but it does not independently prove that the graphics card itself is defective. Potential areas to investigate include the graphics driver, GPU stability, temperature, power delivery, and other system conditions.
A separate event containing `Kernel-Power` Event ID `41` indicated that Windows detected an unclean shutdown. That event alone does not establish why the shutdown occurred.
These observations should be correlated with incident timing, other logs, and reproducible symptoms before reaching a conclusion.

## 7. Evidence and Documentation

When investigating a driver or hardware issue, record:

- Date and time of the observation
- Computer and device involved
- Exact symptom or error message
- Device name and status
- Driver provider, version, and date
- Relevant hardware IDs
- Related Event Viewer entries
- Recent changes and troubleshooting actions
- Test results and verification evidence
- Remaining uncertainties

Distinguish clearly between:

Observation: information directly collected.
Hypothesis: a possible explanation.
Test: an action intended to evaluate a hypothesis.
Result: what the test actually showed.
Conclusion: what the available evidence supports.
Do not report a repair as successful until the relevant behaviour has been checked after the change.

## 8. Key Takeaways

- Device Manager provides useful information about detected devices and their reported status.
- Driver version and date are evidence to record, not automatic indicators of a fault.
- Hardware IDs help identify devices but do not establish physical condition.
- A graphics-related bugcheck does not automatically prove a failed GPU.
- Event Viewer, Reliability Monitor, device information, and observed behaviour should be considered together.
- A good troubleshooting record distinguishes facts from hypotheses and documents verification before claiming resolution.
