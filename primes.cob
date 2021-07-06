*> List Prime Numbers up to 99 in COBOL
*>     generates prime numbers
IDENTIFICATION DIVISION.
    PROGRAM-ID. primes.
    AUTHOR. gsteixei@gmail.com
    DATE-WRITTEN. 2021-07-03
DATA DIVISION.
    WORKING-STORAGE SECTION.
        01 num       PIC 9(2) VALUE ZEROS.
        01 res_float PIC 9(3)V9(4) VALUE ZEROS.
        01 res_int   PIC 9(3) VALUE ZEROS.
        01 divisor   PIC 9(2) VALUE ZEROS.
        01 isprime   PIC 9 VALUE ZEROS.
PROCEDURE DIVISION.
    DISPLAY "The prime numbers sequence".
    PERFORM VARYING num FROM 1 BY 1 UNTIL num = 99
        MOVE 1 TO isprime
        PERFORM VARYING divisor FROM 2 BY 1 UNTIL divisor >= num
            COMPUTE res_float = num / divisor
            MOVE res_float TO res_int
            IF res_int = res_float THEN
                MOVE 0 TO isprime
                EXIT PERFORM
            END-IF
        END-PERFORM
        IF isprime = 1 THEN DISPLAY num END-IF
    END-PERFORM
STOP RUN.
