      *This program allows you to add new vendors to an index file.
      *For demonstration purposes, only ID number, name, and zip has been included.
      *Adding additional fields as needed is assumed trivial.	  
       IDENTIFICATION DIVISION.
       PROGRAM-ID. VNDNEW02.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT VENDOR-FILE
                   ASSIGN TO "vendor"
                   ORGANIZATION IS INDEXED
                   RECORD KEY IS VENDOR-NUMBER
                   ACCESS MODE IS DYNAMIC.
       DATA DIVISION.
       FILE SECTION.
       FD VENDOR-FILE
           LABEL RECORDS ARE STANDARD.
       01 VENDOR-RECORD.
           05 VENDOR-NUMBER PIC   9(5).
           05 VENDOR-NAME   PIC   X(30).
           05 VENDOR-ZIP    PIC   9(5).

       WORKING-STORAGE SECTION.
       01 VENDOR-NUMBER-FIELD PIC Z(5).
       PROCEDURE DIVISION.
       PROGRAM-BEGIN.
           OPEN I-O VENDOR-FILE.
           PERFORM GET-NEW-VENDOR-NUMBER.
           PERFORM ADD-RECORDS
           UNTIL VENDOR-NUMBER = ZEROES.
           CLOSE VENDOR-FILE.
       PROGRAM-DONE.
           STOP RUN.
       GET-NEW-VENDOR-NUMBER.
           PERFORM INIT-VENDOR-RECORD.
           PERFORM SELECT-VENDOR-NUMBER.
       INIT-VENDOR-RECORD.
           MOVE SPACE TO VENDOR-RECORD.
           MOVE ZEROES TO VENDOR-NUMBER.
       SELECT-VENDOR-NUMBER.
           DISPLAY "ENTER VENDOR NUMBER (1 - 99999)".
           DISPLAY "ENTER 0 TO STOP ENTRY".
           ACCEPT VENDOR-NUMBER-FIELD.
           MOVE VENDOR-NUMBER-FIELD TO VENDOR-NUMBER.
       ADD-RECORDS.
           PERFORM ENTER-REMAINING-FIELDS.
           PERFORM WRITE-VENDOR-RECORD.
           PERFORM GET-NEW-VENDOR-NUMBER.
       WRITE-VENDOR-RECORD.
           WRITE VENDOR-RECORD
           INVALID KEY
           DISPLAY "RECORD ALREADY ON FILE".
       ENTER-REMAINING-FIELDS.
           PERFORM ENTER-VENDOR-NAME.
           PERFORM ENTER-VENDOR-ZIP.
       ENTER-VENDOR-NAME.
           DISPLAY "ENTER VENDOR NAME".
           ACCEPT VENDOR-NAME.
       ENTER-VENDOR-ZIP.
           DISPLAY "ENTER VENDOR ZIP".
           ACCEPT VENDOR-ZIP.
