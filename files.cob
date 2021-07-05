        IDENTIFICATION DIVISION.
            PROGRAM-ID. files.
            
        ENVIRONMENT DIVISION.
            INPUT-OUTPUT SECTION.
                FILE-CONTROL.
                    SELECT the_file ASSIGN TO "outfile.txt"
                        ORGANIZATION IS LINE SEQUENTIAL
                        ACCESS MODE IS SEQUENTIAL.
        
        DATA DIVISION.
            FILE SECTION.
                FD  the_file.
                    01 line_record.
                        02 line_id  PIC 99 VALUE ZERO.
                        02 line_tx  PIC X(12) VALUE SPACES.
            WORKING-STORAGE SECTION.
                01 end_of_file      PIC 9 VALUE ZERO.
   
        PROCEDURE DIVISION.
        
            MOVE 2 TO line_id.
            MOVE "Hello World!" TO line_tx.
            *> write a line to file
            OPEN OUTPUT the_file.
            WRITE line_record.
            CLOSE the_file.
            *> Read a line
            OPEN INPUT the_file.
            READ the_file
                AT END DISPLAY "this is the end"
            END-READ.
            DISPLAY line_id SPACE line_tx.
            CLOSE the_file.
            *> read all lines
            OPEN INPUT the_file.
            MOVE 0 TO end_of_file.
            PERFORM UNTIL end_of_file = 1
                READ the_file
                    AT END MOVE 1 TO end_of_file
                END-READ
                DISPLAY line_id SPACE line_tx
            END-PERFORM
            CLOSE the_file.
          
        STOP RUN.

        END PROGRAM files.
