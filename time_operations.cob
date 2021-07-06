            IDENTIFICATION DIVISION.
                PROGRAM-ID. timeops.
                DATE-WRITTEN. 2021-07-05
            DATA DIVISION.
                WORKING-STORAGE SECTION.
                    01 time_stamp.
                        02 tstamp   PIC 9(15) VALUE 0.
                        02 tzdata   PIC 9(4) VALUE 0.
                    01 some_date.
                        02 date_data.
                            03 year     PIC 9999 VALUE 0.
                            03 month    PIC 99 VALUE 0.
                            03 dday     PIC 99 VALUE 0.
                        02 time_data.
                            03 hour     PIC 99 VALUE 0.
                            03 minute   PIC 99 VALUE 0.
                            03 second   PIC 99 VALUE 0.
                            03 milis    PIC 999 VALUE 0.
                    01 integer_date     PIC 9(15) VALUE 0.
                    01 ini_date         PIC 9(8) VALUE 0.
                    01 end_date         PIC 9(8) VALUE 0.
            PROCEDURE DIVISION.
                MOVE FUNCTION CURRENT-DATE TO time_stamp.
                DISPLAY "timestamp: " time_stamp. 
                DISPLAY "tzdata: " tzdata " tstamp " tstamp.
                MOVE FUNCTION CURRENT-DATE TO some_date.
                DISPLAY "formated: " year"-"month"-"dday" "hour":"minute.
                *> Gregorian to Integer
                STRING year month dday INTO ini_date.
                COMPUTE integer_date = FUNCTION INTEGER-OF-DATE (ini_date)
                DISPLAY "date as integer: " integer_date
                *> add 10 days to date
                ADD 10 TO integer_date.
                *> Integer to Gregorian
                COMPUTE end_date = FUNCTION DATE-OF-INTEGER (integer_date)
                DISPLAY "date after conversion: " end_date.
            STOP RUN.
