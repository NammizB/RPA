# Email Classification Automation

## Overview

Safe local-only email processing. The project reads `.eml` fixtures, extracts sender/subject/body, detects `urgent`, `invoice`, `complaint`, and `request`, copies declared sample attachments, writes reply drafts, and generates a report and summary. It never connects to a mailbox, sends a message, or deletes a message.

## Technologies and activities

- UiPath Studio Windows project and `UiPath.System.Activities`.
- `UiPath.Mail.Activities` dependency is included for Studio compatibility.
- Local `.eml` parsing and deterministic file outputs.

## Inputs and outputs

- Inputs: `input/emails/*.eml` and `input/attachment-fixtures/*`.
- Outputs: `outputs/classification_report.csv`, `outputs/reply_drafts/*.txt`, `outputs/attachments/*`, and `outputs/summary.json`.

## Workflow

Each message is parsed, classified by keyword priority, assigned a draft response, and checked for declared attachments. The processing summary records total messages, category counts, copied attachments, and the explicit `MessagesSent: 0` safety invariant.

## Verified test results

Direct runner and UiPath Robot PASS. Four local messages were classified across Urgent, Invoice, Complaint, and Request; one safe fixture attachment was copied; four reply drafts were created; `MessagesSent`, `MessagesDeleted`, and `ExternalConnections` all remained zero.
