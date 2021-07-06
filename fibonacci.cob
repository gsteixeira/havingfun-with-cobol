*> The Fibonacci sequence in COBOL
IDENTIFICATION DIVISION.
    PROGRAM-ID. fibonacci.
    AUTHOR. Gustavo Teixeira - gsteixei@gmail.com
    DATE-WRITTEN. 2021-07-03
DATA DIVISION.
    WORKING-STORAGE SECTION.
        01 a         PIC 999 VALUE ZEROS.
        01 b         PIC 999 VALUE ZEROS.
        01 i         PIC 999 VALUE ZEROS.
        01 nth       PIC 999 VALUE ZEROS.

PROCEDURE DIVISION.
    DISPLAY "The fibonacci sequence".
    MOVE 0 TO a.
    MOVE 1 TO b.
    PERFORM VARYING i FROM 1 BY 1 UNTIL a >= 99
        DISPLAY a
        COMPUTE nth = a + b
        MOVE b TO a
        MOVE nth TO b
    END-PERFORM
STOP RUN.
