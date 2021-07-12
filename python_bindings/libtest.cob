        *> This programs are made to test python bindings
        *> cobc --debug -b --free -o libtest.so libtest.cob
        IDENTIFICATION DIVISION.
            PROGRAM-ID. numeric_arguments.
            *> this one takes two arguments and multiply. Note that by current
            *> limitations of gnucobol it can only return integers.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 int_one       PIC 9999 VALUE ZEROS.
                01 int_two       PIC 999V9 VALUE ZEROS.
                01 answer        PIC 9999V9 VALUE ZEROS.
            LINKAGE SECTION.
                01 arg_one       PIC Z(4).
                01 arg_two       PIC Z(4).
        PROCEDURE DIVISION USING BY REFERENCE arg_one, arg_two.
            MOVE arg_two TO int_two.
            MOVE arg_one TO int_one.
            COMPUTE answer = int_one * int_two.
            DISPLAY " numeric arguments"
            DISPLAY "    called with " int_one " * " int_two " = " answer.
            GOBACK RETURNING answer.
        END PROGRAM numeric_arguments.

        *> ********************************
        IDENTIFICATION DIVISION.
            PROGRAM-ID. change_string.
            *> receives a string by the pointer, then change it.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 input_argument   PIC Z(22) VALUE SPACES.
                01 str_from_python  PIC Z(22) BASED.
            LINKAGE SECTION.
                01 pointer_argument USAGE POINTER.
        PROCEDURE DIVISION USING BY VALUE pointer_argument.
            SET ADDRESS OF str_from_python TO pointer_argument.
            STRING str_from_python DELIMITED BY x"00"
                    INTO input_argument END-STRING
            DISPLAY "Python said: " input_argument
            *> This changes the value of the string.
            STRING "Hello from COBOL!!!" & x"00"
                    INTO str_from_python end-string.
            GOBACK.
        END PROGRAM change_string.

        *> ********************************
        *> Return an integer
        IDENTIFICATION DIVISION.
            PROGRAM-ID. ret_integer.
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 val PIC 9999.
        PROCEDURE DIVISION.
            MOVE 21 TO val.
            GOBACK RETURNING val.
        END PROGRAM ret_integer.
        
        *> ********************************
        *> takes a string argument
        IDENTIFICATION DIVISION.
            PROGRAM-ID. string_arguments.
        DATA DIVISION.
            LINKAGE SECTION.
                01 arg_one PIC Z(15).
        PROCEDURE DIVISION USING BY REFERENCE arg_one.
            DISPLAY "Hello, " arg_one.
            GOBACK RETURNING arg_one.
        END PROGRAM string_arguments.
