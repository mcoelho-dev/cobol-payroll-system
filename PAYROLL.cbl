       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYROLL.
       AUTHOR. MIGUEL COELHO.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
       SELECT EMPLOYEES-FILE ASSIGN TO "employees.dat".
       SELECT EMPLOYEES-SUMMARY ASSIGN TO "payroll_report.txt".

       DATA DIVISION.
       FILE SECTION.
       FD  EMPLOYEES-FILE.
       01  EMP-DATA.
           05 EMP-ID            PIC 9(4).
           05 EMP-NAME          PIC X(30).
           05 EMP-BASE-SALARY   PIC 9(7)V99.
           05  EMP-EXTRA-HOURS  PIC 9(3).
           05  EMP-HOURLY-RATE  PIC 9(5)V99.
           05  EMP-BONUS        PIC 9(7)V99.
           05  EMP-HEALTH-PLAN  PIC 9(5)V99.

       FD  EMPLOYEES-SUMMARY.
       01  SUMMARY              PIC X(80).

       WORKING-STORAGE SECTION.

       01  EOF                  PIC X VALUE "N".
       01  BRUTE-SALARY         PIC 9(7)V99.
       01  INSS-DISCOUNT        PIC 9(5)V99.
       01  IRRF-DISCOUNT        PIC 9(5)V99.
       01  TOTAL-DISCOUNT       PIC 9(7)V99.
       01  LIQUID-SALARY        PIC 9(7)V99.
       01  FINAL-OUTPUT         PIC X(80).

       01  IRRF-TABLE.
           05  IRRF-BRACKET OCCURS 5 TIMES.
              10  BRACKET-LIMIT    PIC 9(5)V99.
              10  BRACKET-RATE     PIC 9(2)V99.
              10  BRACKET-DEDUCT   PIC 9(5)V99.