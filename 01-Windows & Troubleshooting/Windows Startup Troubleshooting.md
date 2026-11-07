# Windows Startup Troubleshooting

## 1. Purpose

Windows startup troubleshooting involves investigating problems that occur while Windows starts, when a user signs in, or shortly after the desktop becomes available.
The investigation may include startup applications, Windows services, system events, and recent configuration changes.
The objective is to identify relevant evidence and determine whether a startup-related component contributes to the reported problem.

## 2. Startup Concepts

### Windows Startup

Windows startup includes the processes and components required to initialise the operating system and make it available for use.

### Sign-in and Startup Applications

Some applications are configured to launch when a user signs in.
Examples may include cloud synchronisation tools, messaging applications, and software update utilities.
These applications may affect the time it takes for the desktop to become responsive, depending on their activity and the system's resources.

### Windows Services

Services are background components managed by Windows.
Some services start automatically, while others may start when required or in response to a trigger.
A service's startup type is different from an application's startup setting in Task Manager.

### Startup Impact

Task Manager may display a Startup Impact classification for supported startup applications.
This classification helps prioritise investigation. It does not prove that an application is faulty or that it is the cause of a slow startup.

## 3. Inspect Startup Applications

### Using Task Manager

1. Ctrl + Shift + Esc.
2. Open 'Startup apps'.
3. Review the listed applications.
4. Record the application name, status, and displayed startup impact.
5. Identify entries that may be relevant to the reported symptom.

When investigating a problem, consider whether the application is necessary for the user's work or for another installed application.
Do not disable startup applications solely because their impact is labelled High.

## 4. Investigation Tools

### Task Manager

Use Task Manager to review startup applications and their displayed startup impact.
The Processes and Performance views can also help determine whether CPU, memory, or disk activity remains unusually high after sign-in.

### Services Console

Use 'services.msc' to inspect service state and startup configuration when evidence suggests a service may be involved.
Do not change a service's startup type without understanding its purpose and the potential impact.

### Event Viewer

Use Event Viewer to inspect relevant system or application events around the reported startup problem.
Record the timestamp, source, event ID, level, and message.
An event occurring near startup is not necessarily the cause of a startup problem.

### Reliability Monitor

Use Reliability Monitor to review recorded application failures, Windows failures, and other reliability-related events.
Compare the timeline with the reported onset of the problem.

## 5. Practical Observations

During previous Windows troubleshooting practice, the following startup entries were observed:

| Entry | Recorded Observation |
|---|---|
| Java Update Scheduler | Displayed as enabled, with Low startup impact |
| Microsoft Edge | Displayed as enabled, with High startup impact |
| OneDrive | Displayed as enabled, with High startup impact |

These observations describe the startup configuration at the time of inspection.
They do not establish that any of these applications caused a startup delay or system problem.
The displayed impact classification should be considered alongside actual system behaviour and the user's reported symptoms.

## 6. Investigation Considerations

When investigating a startup-related problem, consider:

- Does the problem occur before sign-in or after sign-in?
- Is Windows itself slow to start, or is the desktop slow to become responsive?
- Does the issue occur on every startup or only occasionally?
- Are CPU, memory, or disk resources heavily used after sign-in?
- Are relevant services failing to start?
- Are there related events or reliability records?
- Did the issue begin after a software installation, update, or configuration change?

Record observations before making changes.
If a change is necessary, document the original setting, the reason for the change, and the result.

## 7. Key Takeaways

- Startup applications and Windows services are different concepts.
- Startup Impact is an indicator, not a diagnosis.
- A High startup impact classification does not automatically mean an application should be disabled.
- A startup-related event does not automatically identify the root cause.
- Distinguish slow Windows startup from slow application or desktop readiness after sign-in.
- Investigate recent changes and relevant evidence before modifying configuration.
- Verify the original symptom after any troubleshooting change.
