//PAYRPT   JOB (ACCT),'MAINFRAME LAB',CLASS=A,MSGCLASS=H,
//             NOTIFY=&SYSUID
//*
//* Example compile/link/run JCL.
//* Your IBM Z environment may use a different COBOL procedure.
//*
//COBRUN   EXEC IGYWCLG
//COBOL.SYSIN DD *
       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYRPT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PAYMENT-FILE ASSIGN TO INFILE
               ORGANIZATION IS SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  PAYMENT-FILE
           RECORD CONTAINS 22 CHARACTERS.
       01  PAYMENT-RECORD.
           05 PR-LOAN-ID             PIC X(10).
           05 FILLER                 PIC X.
           05 PR-AMOUNT              PIC 9(7)V99.
           05 FILLER                 PIC X.
           05 PR-STATUS              PIC X.

       WORKING-STORAGE SECTION.
       01  WS-EOF                    PIC X VALUE 'N'.
           88 END-OF-FILE            VALUE 'Y'.
       01  WS-TOTAL-RECORDS          PIC 9(5) VALUE ZERO.
       01  WS-PROCESSED              PIC 9(5) VALUE ZERO.
       01  WS-REJECTED               PIC 9(5) VALUE ZERO.
       01  WS-HOLD                   PIC 9(5) VALUE ZERO.
       01  WS-TOTAL-AMOUNT           PIC 9(9)V99 VALUE ZERO.
       01  WS-DISPLAY-AMOUNT         PIC ZZZ,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
           OPEN INPUT PAYMENT-FILE
           PERFORM UNTIL END-OF-FILE
               READ PAYMENT-FILE
                   AT END SET END-OF-FILE TO TRUE
                   NOT AT END
                       ADD 1 TO WS-TOTAL-RECORDS
                       EVALUATE PR-STATUS
                           WHEN 'P'
                               ADD 1 TO WS-PROCESSED
                               ADD PR-AMOUNT TO WS-TOTAL-AMOUNT
                           WHEN 'R'
                               ADD 1 TO WS-REJECTED
                           WHEN 'H'
                               ADD 1 TO WS-HOLD
                       END-EVALUATE
               END-READ
           END-PERFORM
           CLOSE PAYMENT-FILE
           MOVE WS-TOTAL-AMOUNT TO WS-DISPLAY-AMOUNT
           DISPLAY 'TOTAL RECORDS: ' WS-TOTAL-RECORDS
           DISPLAY 'PROCESSED:     ' WS-PROCESSED
           DISPLAY 'REJECTED:      ' WS-REJECTED
           DISPLAY 'ON HOLD:       ' WS-HOLD
           DISPLAY 'TOTAL AMOUNT:  ' WS-DISPLAY-AMOUNT
           STOP RUN.
/*
//GO.INFILE DD *
LN00000001 000012345 P
LN00000002 000005000 P
LN00000003 000000000 R
LN00000004 000007550 H
LN00000005 000010000 P
/*
//
