---
name: daily-journal
description: Update today's daily journal — run the linking script and append session notes
user-invocable: false
disable-model-invocation: false
---

## Daily Journal
Use this skill to create or update today's daily journal.

## Goal
Update today's journal with a clear summary of the current development session.

## Required method
Use the Obsidian CLI.

Check CLI syntax when needed:
```bash
obsidian help
obsidian help append
obsidian help file
obsidian help search
```

## Journal path
Today's journal path is:
Journal/YYYY/MM/DD.md

Example: Journal/2026/08/26.md

## Workflow
1. Run the linking script to create/update the journal structure and template:
bash Agents/Scripts/daily-journal.sh
2. Determine today's date and time.

## Append
```bash
obsidian append path="Journal/YYYY/MM/DD.md" content="<new bullet points>"
```

### Append Rules
- Add new entries as bullet points.
- Preserve existing bullets.
- Skip sections where there is no new information.
- Do not invent missing details.
- If context is missing, ask the user what they want to log.

## Log format
Every log entry is a separate timestamped line — ONE action per line:
`HH:MM:SS: text`

Example:
```md
## Log
14:32:15: Reorganized Claude structure inside Obsidian.
14:35:20: Created index notes for Commands and Skills.
14:40:05: Symlinked project instructions into the vault.
```

## Rules
- Use HH:MM:SS: at the start of each log line.
- Keep entries short and specific (concise).
- Append new entries in chronological order.
- Do not use bullets under ## Log.
- Use bullets only for sections like Files Modified, Commands Executed, Next Steps.
- Do not infer, summarize, or invent commands — if no exact commands are provided, leave the section unchanged.

## Output
After updating, only say:
Today's journal has been updated.
Then list the sections changed.

## Connected to
- [[Templates/Daily|Daily]] - Template this skill uses
- [[Journal]]

