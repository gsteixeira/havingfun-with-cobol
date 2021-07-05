        IDENTIFICATION DIVISION.
            PROGRAM-ID. cmdline.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01  first-arg          PIC X(10)         VALUE SPACES.

        PROCEDURE DIVISION.
            MAINLINE.
                ACCEPT first-arg FROM COMMAND-LINE.
                DISPLAY "You said " first-arg.
            STOP RUN.
        END PROGRAM cmdline.
