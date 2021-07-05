        IDENTIFICATION DIVISION.
            PROGRAM-ID. str.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 one         PIC X(10) VALUE "hello".
                01 two         PIC X(15) VALUE "world, guys".
                01 three       PIC X(15) VALUE " people.".
                01 result      PIC X(40) VALUE SPACES.
                01 points      PIC 99    VALUE ZEROS.
                01 counter     PIC 9     VALUE ZEROS.

        PROCEDURE DIVISION.
            MOVE 3 TO points.
            STRING  one DELIMITED BY SIZE
                    two DELIMITED BY ','
                    three
                INTO result
                WITH POINTER points
                ON OVERFLOW DISPLAY "it's too big!"
                NOT ON OVERFLOW DISPLAY "All good"
            END-STRING.
            DISPLAY result.
            
            INSPECT result TALLYING counter FOR ALL 'l'.
            DISPLAY "there are " counter " l's on the string"
            
            INSPECT result REPLACING ALL 'hello' BY 'bye  '.
            DISPLAY result
            
            UNSTRING result DELIMITED BY SPACES INTO one two three
            END-UNSTRING.
            DISPLAY one.
            DISPLAY two.
            DISPLAY three.
            STOP RUN.
        
                
        END PROGRAM str.
