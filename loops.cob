        IDENTIFICATION DIVISION.
            PROGRAM-ID. loops.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
            01  vars_area.
                02  i                  PIC 9(3)          VALUE 0.
                
        PROCEDURE DIVISION.
            MAINLINE.
                MOVE 0 to i.
                DISPLAY "A loop using GOTO :)"
                PERFORM go-loop.
                
                DISPLAY "now.. this looks like a FOR"
                PERFORM VARYING i from 0 BY 1 UNTIL i >= 10
                DISPLAY i
                END-PERFORM
                
                DISPLAY "another kind of loop"
                MOVE 0 TO i.
                PERFORM until i > 10
                    DISPLAY i
                    ADD 1 to i 
                END-PERFORM.
                
                DISPLAY "loop until with function"
                MOVE 0 to i.
                PERFORM increment-counter UNTIL i >= 10.
                DISPLAY "a after" i.
                STOP RUN.

            go-loop.
                *> a loop with GOTO :)
                DISPLAY "looping " i.
                ADD 1 TO i.
                IF i < 10 THEN GO TO go-loop END-IF.
            
            increment-counter.
                DISPLAY "looping " i.
                ADD 1 TO i.

        END PROGRAM loops.
