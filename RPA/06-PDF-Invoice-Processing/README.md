# PDF Invoice Processing

Processes safe local invoice fixtures, determines Paid/Pending/Overdue status, and generates a summary CSV, exception list, and JSON execution summary. No real vendors, payments, bank accounts, or external services are used.

## Run

Open `project.json` in UiPath Studio, restore the declared packages, and run `Main.xaml`. The workflow invokes the included `Run.ps1` against `input/invoices.csv` and writes results under `outputs/`.

## Files

- `Main.xaml` and `project.json` — UiPath Windows project.
- `Run.ps1` — local deterministic processing logic.
- `input/invoices.csv` and `input/*.pdf` — safe sample invoice references.
- `outputs/InvoiceSummary.csv`, `InvoiceExceptions.txt`, and `Summary.json` — generated reports.

## Runtime status

UiPath Robot package `1.0.1` completed successfully on 2026-11-12 with exit code 0. It processed 4 invoices, classified 1 as Paid, 2 as Pending, and 1 as Overdue, with total amount `$4,655.75`. The generated `InvoiceSummary.csv`, `InvoiceExceptions.txt`, and `Summary.json` were inspected.
