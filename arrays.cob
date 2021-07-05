
        IDENTIFICATION DIVISION.
            PROGRAM-ID. arrays.
            DATE-WRITTEN. 2021-07-03
            AUTHOR. Gustavo Teixeira - gsteixei@gmail.com
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 max            PIC 99 VALUE 0.
                01 i              PIC 99 VALUE 0.
                01 aux            PIC 99 VALUE 0.
                01 the_array      PIC 99 OCCURS 10 TIMES.
                01 time_stamp.
                    02 tstamp   PIC 9(16) VALUE 0.
                    02 tzdata  PIC 9(4) VALUE 0.
        PROCEDURE DIVISION.
            MOVE 20 TO max.
            DISPLAY "I will load the array with random strings".
            PERFORM VARYING i FROM 1 BY 1 UNTIL i > max
                MOVE FUNCTION CURRENT-DATE TO time_stamp
                COMPUTE aux = FUNCTION RANDOM (tstamp+i) * 99 + 1
                MOVE aux TO the_array(i)
            END-PERFORM
            
            DISPLAY "Here is the array from my memory".
            PERFORM VARYING i FROM 1 BY 1 UNTIL i > max
                DISPLAY the_array(i)
            END-PERFORM
        STOP RUN.
        END PROGRAM arrays.
