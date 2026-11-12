# RPA Office and Utility Automations

Five independent UiPath Studio projects for portable, local-only office and file automation. Each project has its own `project.json`, `Main.xaml`, inputs, outputs, initialization fixture, runner script, and README.

## Projects

| Project | Purpose | Runtime status |
|---|---|---|
| [01 Excel Attendance Analyzer](RPA/01-Excel-Attendance-Analyzer/README.md) | Read XLSX attendance, calculate percentages, sort, report, and CSV export | Robot PASS |
| [02 Word Certificate Generator](RPA/02-Word-Certificate-Generator/README.md) | Fill DOCX template from CSV and verify generated certificates | Robot PASS |
| [03 PowerPoint Report Generator](RPA/03-PowerPoint-Report-Generator/README.md) | Fill PPTX template, update slides, and add a report table | Robot PASS |
| [04 Email Classification](RPA/04-Email-Classification/README.md) | Classify local `.eml` fixtures, copy safe attachments, and draft replies | Robot PASS |
| [05 File Organizer Backup](RPA/05-File-Organizer-Backup/README.md) | Categorize files, handle duplicates, log movements, and create ZIP backup | Robot PASS |

## Design

- No real email account, external service, or network endpoint is used.
- No Office Interop is required. XLSX, DOCX, and PPTX fixtures are Open XML ZIP packages generated and processed locally.
- `Main.xaml` is the UiPath entry point. It invokes the project-local `Run.ps1` through a UiPath `Invoke Code` activity and propagates non-zero failures.
- All inputs and outputs are relative to the project folder. File Organizer operations are confined to its own project directory.

## Running

1. Open a numbered folder in UiPath Studio 2026.0.180 STS.
2. Run `Initialize.ps1` once if you need to regenerate the sample fixtures.
3. Run `Main.xaml` in Studio or execute it with the local UiPath Robot.
4. Review the project README and its `outputs` folder.

The automation projects use local-only fixtures and processing. This portfolio is published in the `NammizB/RPA` GitHub repository.

## Verification snapshot

Robot execution was completed locally on 2026-11-11 using UiPath Robot 26.0.180.0. Packages were published locally and this portfolio was pushed to `NammizB/RPA`. See each project README for verified output details.

## Final verification

| Project | Main.xaml | Package | Robot | Verified outputs | Dynamic processing | Remaining issues |
|---|---|---|---|---|---|---|
| Excel Attendance Analyzer | Yes | 1.0.1 | PASS | 2 XLSX reports, 2 low-attendance CSVs, summary | 15-row and 8-row XLSX datasets | None |
| Word Certificate Generator | Yes | 1.0.0 | PASS | 4 personalized DOCX files, verification JSON | CSV-driven placeholder replacement | PDF export unavailable without converter |
| PowerPoint Report Generator | Yes | 1.0.0 | PASS | 2-slide PPTX with native table, verification JSON | CSV-driven slide/table generation | PDF export unavailable without converter |
| Email Classification | Yes | 1.0.0 | PASS | CSV report, 4 drafts, copied attachment, summary | 4 local `.eml` fixtures and keyword rules | No live mailbox by design |
| File Organizer Backup | Yes | 1.0.1 | PASS | 6 organized files, movement log, verified ZIP, summary | Extension categorization and duplicate handling | Unsupported Markdown fixture is intentionally skipped |
