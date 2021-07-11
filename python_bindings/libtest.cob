        *> This programs are made to test python bindings
        *> cobc --debug -b --free -o libtest.so libtest.cob
        IDENTIFICATION DIVISION.
            *> this one takes two arguments and multiply. Note that by current
            *> limitations of gnucobol it can only return integers.
            PROGRAM-ID. numeric_arguments.
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
