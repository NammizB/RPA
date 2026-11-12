# RPA Office and Utility Automations

Seven independent UiPath Studio projects for portable, local-only office and file automation. Each project has its own `project.json`, `Main.xaml`, inputs, outputs, initialization fixture where needed, runner script, and README.

## Projects

| Project | Purpose | Runtime status |
|---|---|---|
| [01 Excel Attendance Analyzer](RPA/01-Excel-Attendance-Analyzer/README.md) | Read XLSX attendance, calculate percentages, sort, report, and CSV export | Robot PASS |
| [02 Word Certificate Generator](RPA/02-Word-Certificate-Generator/README.md) | Fill DOCX template from CSV and verify generated certificates | Robot PASS |
| [03 PowerPoint Report Generator](RPA/03-PowerPoint-Report-Generator/README.md) | Fill PPTX template, update slides, and add a report table | Robot PASS |
| [04 Email Classification](RPA/04-Email-Classification/README.md) | Classify local `.eml` fixtures, copy safe attachments, and draft replies | Robot PASS |
| [05 File Organizer Backup](RPA/05-File-Organizer-Backup/README.md) | Categorize files, handle duplicates, log movements, and create ZIP backup | Robot PASS |
| [06 PDF Invoice Processing](RPA/06-PDF-Invoice-Processing/README.md) | Process local invoice fixtures and report payment exceptions | Robot PASS — 1.0.2 |
| [07 Data Validation and Reporting](RPA/07-Data-Validation-Reporting/README.md) | Validate CSV employee records and separate valid/invalid rows | Robot PASS — 1.0.2 |

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

The automation projects use local-only fixtures and processing.

The refreshed `Main.xaml` files now include a visible UiPath `Read Text File` input step before invoking each project’s local processing routine. The processing logic remains portable and is kept in the project-local runner scripts so the projects can be tested without Office or external services.

## Verification snapshot

Robot execution was completed locally using UiPath Robot 26.0.180.0. Packages were published locally and each project was verified against its generated outputs. See each project README for verified output details.

## Final verification

| Project | Main.xaml | Package | Robot | Verified outputs | Dynamic processing | Remaining issues |
|---|---|---|---|---|---|---|
| Excel Attendance Analyzer | Yes | 1.0.5 | PASS | 2 XLSX reports, 2 low-attendance CSVs, summary | 15-row and 8-row XLSX datasets | None |
| Word Certificate Generator | Yes | 1.0.2 | PASS | 4 personalized DOCX files, verification JSON | CSV-driven placeholder replacement | PDF export unavailable without converter |
| PowerPoint Report Generator | Yes | 1.0.1 | PASS | 2-slide PPTX with native table, verification JSON | CSV-driven slide/table generation | PDF export unavailable without converter |
| Email Classification | Yes | 1.0.1 | PASS | CSV report, 4 drafts, copied attachment, summary | 4 local `.eml` fixtures and keyword rules | No live mailbox by design |
| File Organizer Backup | Yes | 1.0.3 | PASS | 6 organized files, movement log, verified ZIP, summary | Extension categorization and duplicate-safe copying | Unsupported Markdown fixture is intentionally skipped |
| PDF Invoice Processing | Yes | 1.0.2 | PASS | Invoice summary, overdue exception list, JSON summary | Four local invoice fixtures | No payment service is connected |
| Data Validation and Reporting | Yes | 1.0.2 | PASS | Valid CSV, invalid CSV, text summary | Five CSV records and three validation rules | No external data source is connected |
