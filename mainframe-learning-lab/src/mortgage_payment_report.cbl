       IDENTIFICATION DIVISION.
       PROGRAM-ID. PAYRPT.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT PAYMENT-FILE ASSIGN TO INFILE
               ORGANIZATION IS SEQUENTIAL
               FILE STATUS IS WS-IN-STATUS.

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
       01  WS-IN-STATUS              PIC XX VALUE SPACES.
       01  WS-EOF                    PIC X VALUE 'N'.
           88 END-OF-FILE            VALUE 'Y'.

       01  WS-COUNTERS.
           05 WS-TOTAL-RECORDS       PIC 9(5) VALUE ZERO.
           05 WS-PROCESSED           PIC 9(5) VALUE ZERO.
           05 WS-REJECTED            PIC 9(5) VALUE ZERO.
           05 WS-HOLD                PIC 9(5) VALUE ZERO.

       01  WS-TOTAL-AMOUNT           PIC 9(9)V99 VALUE ZERO.
       01  WS-DISPLAY-AMOUNT         PIC ZZZ,ZZZ,ZZ9.99.

       PROCEDURE DIVISION.
       MAIN-PROCESS.
           OPEN INPUT PAYMENT-FILE

           IF WS-IN-STATUS NOT = '00'
               DISPLAY 'ERROR OPENING INPUT FILE. STATUS=' WS-IN-STATUS
               STOP RUN
           END-IF

           PERFORM UNTIL END-OF-FILE
               READ PAYMENT-FILE
                   AT END
                       SET END-OF-FILE TO TRUE
                   NOT AT END
                       PERFORM PROCESS-RECORD
               END-READ
           END-PERFORM

           CLOSE PAYMENT-FILE

           MOVE WS-TOTAL-AMOUNT TO WS-DISPLAY-AMOUNT

           DISPLAY '-----------------------------------------'
           DISPLAY 'MORTGAGE PAYMENT BATCH SUMMARY'
           DISPLAY '-----------------------------------------'
           DISPLAY 'TOTAL RECORDS : ' WS-TOTAL-RECORDS
           DISPLAY 'PROCESSED     : ' WS-PROCESSED
           DISPLAY 'REJECTED      : ' WS-REJECTED
           DISPLAY 'ON HOLD       : ' WS-HOLD
           DISPLAY 'TOTAL AMOUNT  : ' WS-DISPLAY-AMOUNT
           DISPLAY '-----------------------------------------'

           STOP RUN.

       PROCESS-RECORD.
           ADD 1 TO WS-TOTAL-RECORDS

           EVALUATE PR-STATUS
               WHEN 'P'
                   ADD 1 TO WS-PROCESSED
                   ADD PR-AMOUNT TO WS-TOTAL-AMOUNT
               WHEN 'R'
                   ADD 1 TO WS-REJECTED
               WHEN 'H'
                   ADD 1 TO WS-HOLD
               WHEN OTHER
                   DISPLAY 'UNKNOWN STATUS FOR LOAN: ' PR-LOAN-ID
           END-EVALUATE.
