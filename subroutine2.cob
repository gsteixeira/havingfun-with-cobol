*> In COBOL, functions are called subroutines, or another PROGRAM.
*> This is the second part where we study subroutines AKA functions.
*> here we gonna demonstrate how to pass and receive variables.

IDENTIFICATION DIVISION.
    PROGRAM-ID. demo.
DATA DIVISION.
    WORKING-STORAGE SECTION.
        01 a             PIC 999 VALUE ZEROS.
        01 result        PIC 9999 VALUE ZEROS.
PROCEDURE DIVISION.
    DISPLAY "Still bored, lets call a subroutine, with return value".
    MOVE 15 to a.
    CALL 'plus-two' USING a, result.
    DISPLAY "the result of " a " plus two is " result.
    STOP RUN.
END PROGRAM demo.

*> Now lets declare my function
*>    The key difference is that I declare de PROCEDURE DIVISION with USING
IDENTIFICATION DIVISION.
    PROGRAM-ID. plus-two.
DATA DIVISION.
    WORKING-STORAGE SECTION.
        01 b        PIC 999 VALUE ZEROS.
    LINKAGE SECTION.
        01 arg        PIC 999 VALUE ZEROS.
        01 answer     PIC 9999 VALUE ZEROS.
PROCEDURE DIVISION USING arg, answer.
    MOVE 2 TO b.
    COMPUTE answer = arg + b
END PROGRAM plus-two.

*> TODO Theres two ways of returning data. The above shows passing it to 
*>      the procedure. The other is using this statement. See how to do it.
*> PROCEDURE DIVISION RETURNING DATA 


