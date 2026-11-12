# PowerPoint Report Generator

## Overview

Creates a genuine Open XML PowerPoint presentation from CSV performance data. The template contains dynamic placeholders; the output updates slide title/details and adds a native Open XML table on slide 2.

## Technologies and activities

- UiPath Studio Windows project and `UiPath.System.Activities`.
- `UiPath.Presentations.Activities` dependency is included for Studio compatibility.
- Portable Open XML package generation avoids Office Interop.

## Inputs and outputs

- Input: `input/PerformanceTemplate.pptx` and `input/student_performance.csv`.
- Output: `outputs/Student_Performance_Report.pptx` and `outputs/verification.json`.

## Workflow

The runner reads performance rows, replaces slide 1 placeholders, constructs a native `a:tbl` table in slide 2, writes the completed package, and verifies the slide XML, table element, and student names.

## PDF limitation

PDF export is not attempted because no PowerPoint/PDF conversion engine is assumed. The README and verification output explicitly report that limitation.

## Verified test results

Direct runner and UiPath Robot PASS. The generated presentation contains two slides, a native `a:tbl` table, and all five student rows. PDF export remains explicitly unavailable in this portable runtime; no PDF success is claimed.
