*> In COBOL, functions are called subroutines, or another PROGRAM.
*> the usefulness is that they have their own vars.
*> Lets Check it out

IDENTIFICATION DIVISION.
    PROGRAM-ID. demo.
DATA DIVISION.
PROCEDURE DIVISION.
    DISPLAY "I'm bored, lets call a subroutine"
    CALL 'do-something' USING 'arrrgs'.
    STOP RUN.
END PROGRAM demo.

*> Now lets declare my function
*>    The key difference is that I declare de PROCEDURE DIVISION with USING
IDENTIFICATION DIVISION.
    PROGRAM-ID. do-something.
DATA DIVISION.
    LINKAGE SECTION.
        01 arg        PIC Z(10) VALUE SPACES.
PROCEDURE DIVISION USING arg.
    DISPLAY "Hello world from a subroutine, you said ", arg
    STOP RUN.
END PROGRAM do-something.


