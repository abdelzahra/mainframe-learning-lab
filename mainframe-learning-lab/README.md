# Mainframe Learning Lab

A small personal learning project for practicing IBM mainframe concepts relevant to
batch processing and systems operations.

## What this project demonstrates

- COBOL sequential file processing
- Batch-oriented program flow
- JCL structure for compile/link/run
- Fixed-width input records
- Basic validation and summary reporting
- Documentation of z/OS, JCL, TSO/ISPF, VSAM, and workload-scheduling concepts

> Status: Learning project / work in progress. This is an independent project and
> is not presented as production mainframe experience.

## Project structure

- `src/mortgage_payment_report.cbl` — COBOL batch program
- `jcl/run_report.jcl` — example JCL compile/link/run job
- `data/payments.txt` — sample fixed-width payment records
- `docs/learning-notes.md` — notes for interview review

## Input layout

Each record is fixed-width:

| Field | Length | Example |
|---|---:|---|
| Loan ID | 10 | `LN00000001` |
| Space | 1 | |
| Amount | 9 | `000012345` = 123.45 |
| Space | 1 | |
| Status | 1 | `P` |

Statuses:
- `P` = processed
- `R` = rejected
- `H` = hold

## Running on IBM Z

The JCL file uses the common `IGYWCLG` COBOL compile/link/go procedure. Mainframe
installations vary, so dataset names, compiler procedures, and accounting fields
may need to be changed for the specific environment.

## Resume wording

A truthful way to describe this repository while it is in progress:

**IBM Z / Mainframe Learning Lab — In Progress**
- Building hands-on familiarity with COBOL batch processing, JCL job structure,
  fixed-width datasets, and z/OS concepts through IBM Z Xplore and an independent
  mainframe learning repository.
