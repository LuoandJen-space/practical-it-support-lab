# Windows Troubleshooting Model

```text
               User report
                    |
                 Symptom
                    |
                  Scope
                    |
                Reproduce
                    |
           Establish Baseline 1.CPU
                    |         2.Disk
                    |         3.Memory
         Collect Resource evidence
--------------------------------------------------
     |                  |                   |
  Service            Process              Event
     |                  |                   |
   status              PID              Event ID
startup type                          Error details
dependencies                            Timeline
     |                  |                   |
--------------------------------------------------
                        ||
                    Hypothesis
                        |
                       Test
                        |
                      Verify
                        |
                     Document
```
