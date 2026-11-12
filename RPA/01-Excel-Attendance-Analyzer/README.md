# Excel Attendance Analyzer

## Overview

UiPath project that reads sample XLSX workbooks, calculates each student's attendance percentage, sorts the results, creates an XLSX report with `All Students` and `Low Attendance` sheets, exports low-attendance rows to CSV, and writes a summary.

## Aim and objectives

- Process workbook data dynamically rather than embedding final results.
- Flag students below the 75% threshold.
- Verify the report using two different datasets.

## Technologies and activities

- UiPath Studio Windows project and `UiPath.System.Activities`.
- `UiPath.Excel.Activities` dependency is included for Studio compatibility.
- UiPath `Invoke Code` orchestrates a portable PowerShell/Open XML implementation so Excel Interop is not required.

## Inputs and outputs

- Inputs: `input/attendance_dataset_1.xlsx`, `input/attendance_dataset_2.xlsx` (generated from the CSV fixtures by `Initialize.ps1`).
- Outputs: `outputs/reports/*.xlsx`, `outputs/low-attendance/*.csv`, and `outputs/summary.json`.

## Workflow

`Main.xaml` launches `Run.ps1`; the runner reads each workbook's `xl/worksheets/sheet1.xml`, calculates percentages, sorts by percentage ascending, writes two report sheets, exports low-attendance CSV, and verifies counts and ZIP entries.

## Setup

Run `powershell -ExecutionPolicy Bypass -File .\Initialize.ps1` once, then run `Main.xaml` from the project folder in UiPath Studio or Robot.

## Verified test results

Direct runner and UiPath Robot PASS. Dataset 1 processed 15 students with 6 below 75%; dataset 2 processed 8 students with 4 below 75%. Both report workbooks and both low-attendance CSV files were generated and verified. No screenshots were captured; the generated artifacts, summaries, and Robot completion logs are the evidence.

## Known limitations

No Office Interop or live Excel application is used. PDF output is not part of this Excel project.
