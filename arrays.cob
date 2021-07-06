
        IDENTIFICATION DIVISION.
            PROGRAM-ID. arrays.
            DATE-WRITTEN. 2021-07-03
            AUTHOR. Gustavo Teixeira - gsteixei@gmail.com
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 i              PIC 99 VALUE 0.
                01 item_value     PIC 99 VALUE 0.
                01 array_size     PIC 99 VALUE 10.
                01 the_array      PIC 9 OCCURS 10 TIMES.
                01 seed           PIC 9(16) VALUE 0.

        PROCEDURE DIVISION.
            MOVE 20 TO array_size.
            DISPLAY "I will load the array with random numbers".
            PERFORM VARYING i FROM 1 BY 1 UNTIL i > array_size
                PERFORM get_a_random
                MOVE item_value TO the_array(i)
            END-PERFORM
            
            DISPLAY "Here is the array from my memory".
            PERFORM VARYING i FROM 1 BY 1 UNTIL i > array_size
                DISPLAY the_array(i)
            END-PERFORM
        STOP RUN.

        get_a_random.
            MOVE FUNCTION CURRENT-DATE TO seed.
            COMPUTE item_value = FUNCTION RANDOM (seed + i) * 9 + 1.
        
        END PROGRAM arrays.
