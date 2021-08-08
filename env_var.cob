        IDENTIFICATION DIVISION.
            PROGRAM-ID. env_var.
            *> how to get a value from an environment variable in cobol
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 env_var     pic x(100) VALUE SPACES.
        PROCEDURE DIVISION.
            DISPLAY "PATH" UPON ENVIRONMENT-NAME.
            ACCEPT env_var FROM ENVIRONMENT-VALUE.
        STOP RUN.


