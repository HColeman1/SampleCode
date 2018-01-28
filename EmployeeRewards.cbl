>* This program reads in a file of every employee and divides them up
>* into two different files; one for employees who have been here over 
>* ten years, and one for newer employees. The original file is kept unchanged.

IDENTIFICATION DIVISION.
PROGRAM-ID. EMPLOYEEREWARDS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT INFILE ASSIGN TO "allemployees"
ORGANIZATION IS LINE SEQUENTIAL
FILE STATUS IS FILE_CHECK.
select OUTFILE1 assign to "longtermemployees"
ORGANIZATION IS LINE SEQUENTIAL.
SELECT OUTFILE2 ASSIGN TO "shorttermemployees"
ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD INFILE.
01 ALL_EMPLOYEES.
05 EMP_FIRST PIC X(10).
05 EMP_LAST PIC X(10).
05 EMP_ID PIC 9(5).IDENTIFICATION DIVISION.
PROGRAM-ID. EMPLOYEEREWARDS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT INFILE ASSIGN TO "allemployees"
ORGANIZATION IS LINE SEQUENTIAL
FILE STATUS IS FILE_CHECK.
select OUTFILE1 assign to "longtermemployees"
ORGANIZATION IS LINE SEQUENTIAL.
SELECT OUTFILE2 ASSIGN TO "shorttermemployees"
ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD INFILE.
01 ALL_EMPLOYEES.
05 EMP_FIRST PIC X(10).
05 EMP_LAST PIC X(10).
05 EMP_ID PIC 9(5).
05 HIRE_DATE.
10 HIRE_MONTH PIC 99.
10 HIRE_DAY PIC 99.

05 HIRE_DATE.
10 HIRE_MONTH PIC 99.
10 HIRE_DAY PIC 99.
10 HIRE_YEAR PIC 9999.

FD OUTFILE1.
01 LONG_PRINT_LINES.
05 FILLER PIC X(25).
01 LONG_EMPLOYEES.
05 LONG_EMP_FIRST PIC X(10).
05 LONG_EMP_LAST PIC X(10).
05 LONG_EMP_ID PIC 9(5).IDENTIFICATION DIVISION.
PROGRAM-ID. EMPLOYEEREWARDS.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
SELECT INFILE ASSIGN TO "allemployees"
ORGANIZATION IS LINE SEQUENTIAL
FILE STATUS IS FILE_CHECK.
select OUTFILE1 assign to "longtermemployees"
ORGANIZATION IS LINE SEQUENTIAL.
SELECT OUTFILE2 ASSIGN TO "shorttermemployees"
ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD INFILE.
01 ALL_EMPLOYEES.
05 EMP_FIRST PIC X(10).
05 EMP_LAST PIC X(10).
05 EMP_ID PIC 9(5).
05 HIRE_DATE.
10 HIRE_MONTH PIC 99.
10 HIRE_DAY PIC 99.

05 LONG_HIRE_DATE.
10 LONG_HIRE_MONTH PIC 99.
10 LONG_HIRE_DAY PIC 99.
10 LONG_HIRE_YEAR PIC 9999.

FD OUTFILE2.
01 SHORT_PRINT_LINES.
05 FILLER PIC X(25).
01 SHORT_EMPLOYEES.
05 SHORT_EMP_FIRST PIC X(10).
05 SHORT_EMP_LAST PIC X(10).
05 SHORT_EMP_ID PIC 9(5).
WORKING-STORAGE SECTION.
01 END_OF_FILE PIC X VALUE "N".
01 FILE_CHECK PIC 99.

01 TOTAL_YEARS_EMPLOYED PIC 9999.
01 DISPLAY_TOTAL_YEARS_EMPLOYED PIC ZZZ9.
01 EMPLOYED_YEAR PIC 9999.

01 THE_CURRENT_DATE.
05 THE_CURRENT_YEAR PIC 9999.
05 THE_CURRENT_MONTH PIC 99.
05 THE_CURRENT_DAY PIC 99.

01 EMPLOYEE_HEADER.
05 FIRST_NAME_HEADER PIC X(11) VALUE "F_NAME ".
05 LAST_NAME_HEADER PIC X(11) VALUE "L_NAME ".
05 ID_HEADER PIC X(2) VALUE "ID".

PROCEDURE DIVISION.
MOVE FUNCTION CURRENT-DATE TO THE_CURRENT_DATE.
DISPLAY "THIS YEAR IS: "THE_CURRENT_YEAR.
DISPLAY "THE CURRENT DAY OF THE MONTH IS: "THE_CURRENT_DAY.

OPEN INPUT INFILE.
OPEN OUTPUT OUTFILE1.
OPEN OUTPUT OUTFILE2.

IF FILE_CHECK NOT = "00" THEN
           DISPLAY "COULD NOT OPEN FILE EXIT STATUS IS: "FILE_CHECK
GO TO 500_END_PROGRAM
END-IF.
WRITE LONG_PRINT_LINES FROM EMPLOYEE_HEADER 
BEFORE ADVANCING 2 LINES
WRITE SHORT_PRINT_LINES FROM EMPLOYEE_HEADER
BEFORE ADVANCING 2 LINES
PERFORM UNTIL END_OF_FILE = "Y"
READ INFILE
AT END MOVE "Y" TO END_OF_FILE
NOT AT END
COMPUTE TOTAL_YEARS_EMPLOYED = THE_CURRENT_YEAR - HIRE_YEAR

IF TOTAL_YEARS_EMPLOYED IS GREATER THAN 10 THEN
MOVE EMP_FIRST TO LONG_EMP_FIRST
MOVE EMP_LAST TO LONG_EMP_LAST
MOVE EMP_ID TO LONG_EMP_ID
WRITE LONG_EMPLOYEES
END-WRITE
END-IF
IF TOTAL_YEARS_EMPLOYED IS EQUAL TO 10 AND (HIRE_MONTH IS LESS THAN 
           THE_CURRENT_MONTH OR (HIRE_MONTH IS EQUAL TO THE_CURRENT_MONTH AND
           HIRE_DAY IS LESS THAN THE_CURRENT_DAY)) THEN
MOVE EMP_FIRST TO LONG_EMP_FIRST
MOVE EMP_LAST TO LONG_EMP_LAST
MOVE EMP_ID TO LONG_EMP_ID
WRITE LONG_EMPLOYEES
END-WRITE
END-IF
IF TOTAL_YEARS_EMPLOYED IS LESS THAN 10 OR (HIRE_YEAR IS EQUAL
TO THE_CURRENT_YEAR AND (HIRE_MONTH IS GREATER THAN THE_CURRENT_MONTH
OR HIRE_MONTH IS EQUAL TO THE_CURRENT_MONTH AND HIRE_DAY IS GREATER
THAN THE_CURRENT_DAY)) THEN
MOVE EMP_FIRST TO SHORT_EMP_FIRST
MOVE EMP_LAST TO SHORT_EMP_LAST
MOVE EMP_ID TO SHORT_EMP_ID
WRITE SHORT_EMPLOYEES
END-WRITE
END-READ
END-PERFORM.
400_CLOSE_FILES.
CLOSE INFILE.
CLOSE OUTFILE1.
CLOSE OUTFILE2.

500_END_PROGRAM.
STOP RUN.