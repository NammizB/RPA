# Smart File Organizer and Backup

## Overview

Organizes sample files entirely inside this project folder. It recognizes PDF, DOCX, XLSX, PNG, JPG, and TXT, moves supported files into category folders, safely renames collisions, logs each decision, creates a ZIP backup, and verifies the archive count.

## Technologies and activities

- UiPath Studio Windows project and `UiPath.System.Activities`.
- UiPath `Invoke Code` orchestrates the local runner.
- PowerShell file APIs and `System.IO.Compression` provide portable local file operations.

## Inputs and outputs

- Inputs: `input/source-*/*` sample files.
- Outputs: `outputs/organized/<category>/*`, `outputs/file-movement-log.csv`, `outputs/organized-backup.zip`, and `outputs/summary.json`.

Run `Initialize.ps1` to restore the sample source folders after a test run.

## Safety boundary

The runner resolves and validates every source/destination path under this project directory. It never writes outside the project root. Unsupported extensions are logged and left in place.

## Verified test results

Direct runner and UiPath Robot PASS using package version 1.0.1. Six supported files were moved, one unsupported Markdown file was skipped, one duplicate was renamed safely, six organized files were archived, and the ZIP entry count matched the organized file count. The root-boundary check passed.
