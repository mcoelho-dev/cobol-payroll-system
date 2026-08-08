# cobol-payroll-system

A mainframe-style payroll processing system built in COBOL, designed to simulate real-world batch processing workflows used in enterprise environments.

This project is structured in progressive phases, each introducing new mainframe concepts — from sequential file I/O to VSAM, DB2, and CICS — following the architecture patterns found in production HR and payroll systems.

---

## Project Architecture

```
Employees File (SEQ)
        │
        ▼
  EMPVAL.CBL ──► Rejected Records
        │
        ▼
 PAYROLL.CBL ──► Payroll Report (SEQ)
        │
        ▼
RPRTGEN.CBL ──► Pay Stubs / CSV / GDG Backup
```

---

## Phases

| Phase | Description | Status |
|-------|-------------|--------|
| 1 | Batch processing with sequential files — IRRF, INSS, overtime, bonus | 🔄 In progress |
| 2 | Input validation, FILE STATUS, error handling (`EMPVAL.CBL`) | ⬜ Planned |
| 3 | Formatted reports, pay stubs, totals, GDG backup (`RPRTGEN.CBL`) | ⬜ Planned |
| 4 | VSAM KSDS — indexed employee records, keyed access | ⬜ Planned |
| 5 | DB2 embedded SQL — payroll history with `EXEC SQL` | ⬜ Planned |
| 6 | CICS screens, USS Shell scripts, PDS/PDSE organization | ⬜ Planned |

---

## Phase 1 — Sequential Batch Processing

### What it does

Reads a fixed-length sequential employee file, calculates gross salary (base + overtime + bonus), applies Brazilian statutory deductions (INSS and IRRF by tax bracket), and writes a formatted payroll report.

### Files

| File | Description |
|------|-------------|
| `employees.dat` | Input — fixed-length employee records |
| `payroll_report.txt` | Output — formatted payroll report |
| `PAYROLL.CBL` | Main COBOL program |

### Calculations

- **Gross salary**: base salary + (extra hours × hourly rate × 1.5) + bonus
- **INSS**: fixed-rate deduction applied to gross salary
- **IRRF**: calculated by Brazilian tax bracket table (rate × gross − deduction)
- **Health plan**: fixed discount per employee record
- **Net salary**: gross − INSS − IRRF − health plan

### IRRF Tax Brackets (2024)

| Range (BRL) | Rate | Deduction |
|-------------|------|-----------|
| Up to 2,824.00 | Exempt | — |
| 2,824.01 – 3,751.05 | 7.5% | 211.78 |
| 3,751.06 – 4,664.68 | 15% | 494.92 |
| 4,664.69 – 5,768.43 | 22.5% | 692.84 |
| Above 5,768.43 | 27.5% | 884.96 |

---

## Environment

- **Compiler**: GnuCOBOL (local development) / IBM Enterprise COBOL (mainframe target)
- **Mainframe access**: IBM Z Xplore environment
- **Tools**: Zowe CLI, Zowe Explorer, VS Code

---

## About

Built as part of a mainframe development portfolio. Concepts applied: sequential file I/O, fixed-length records, working-storage tables with `OCCURS`, `SEARCH` for tax bracket lookup, formatted output with `PICTURE` editing clauses.
