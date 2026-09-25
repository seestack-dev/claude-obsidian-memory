---
name: daily-journal-structure
description: How the daily journal is structured and linked - day → month → year hierarchy
metadata:
type: reference
---
# Daily Journal Structure
The journal lives at `Journal/YYYY/MM/DD.md`, linked into a hierarchy:
- **Day** (`Journal/YYYY/MM/DD.md`) links to its **month** (`Journal/YYYY/MM.md`)
-  **Month** (`Journal/YYYY/MM.md`) links to its **year** (`Journal/YYYY.md`)
-  **Year** (`Journal/YYYY.md`) links to each month

The template is `Templates/Daily.md`.
The script `Agents/Scripts/daily-journal.sh` creates and maintains this hierarchy automatically.


## Connected to
[[Agents/Commands/Daily-Journal|Daily-Journal]]
