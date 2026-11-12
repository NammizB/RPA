# Data Validation and Reporting

Validates employee records from a CSV file using required ID, email format, and age rules. It separates valid and invalid records and creates a plain-text summary.

## Run

Open `project.json` in UiPath Studio, restore dependencies, and run `Main.xaml`. The workflow invokes the included `Run.ps1` against `input/records.csv` and writes results under `outputs/`.

## Files

- `Main.xaml` and `project.json` — UiPath Windows project.
- `Run.ps1` — local validation logic.
- `input/records.csv` — sample data containing three valid and two invalid records.
- `outputs/ValidRecords.csv`, `InvalidRecords.csv`, and `Summary.txt` — generated reports.

## Runtime status

UiPath Robot package `1.0.1` completed successfully on 2026-11-12 with exit code 0. It processed 5 records, producing 3 valid and 2 invalid rows. The generated `ValidRecords.csv`, `InvalidRecords.csv`, and `Summary.txt` were inspected.
