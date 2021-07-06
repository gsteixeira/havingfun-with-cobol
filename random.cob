
        IDENTIFICATION DIVISION.
            PROGRAM-ID. randoms.
            DATE-WRITTEN. 2021-07-04
            AUTHOR. Gustavo Teixeira - gsteixei@gmail.com
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 num            PIC 99 VALUE 0.
                01 seed           PIC 9(16) VALUE 0.
        PROCEDURE DIVISION.
            *> get the timestamp to seed the random
            MOVE FUNCTION CURRENT-DATE TO seed.
            COMPUTE num = FUNCTION RANDOM (seed) * 99 + 1
            DISPLAY "My random number is... " num
        STOP RUN.
        END PROGRAM randoms.
