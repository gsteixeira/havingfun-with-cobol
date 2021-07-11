        *> **********************************************************************
        *> This program is:
        *>    a simple connection and data retrieval from Postres using COBOL
        *>
        *>    to run this, you need LibPq, a Postgre server and GnuCobol.
        *>    This is for educational purposes and does not take any effort 
        *>      to optimization or DRY. 
        *>      It's sequential and monolithic on purpose.
        *>      If you are looking for a less bulky version, take a look at 
        *>          postgre2.cob file.
        *>    Should compile also in "non-free format".
        *>      build: cobc -xj -lpq postgres2.cob
        *>    Usage:
        *>   
        *>   createdb cobol
        *>   psql --dbname=cobol
        *>   SQL> CREATE TABLE test (user_id integer NOT NULL,
        *>                           username character varying(50) NOT NULL);
        *>   SQL> insert into test (user_id, username) values (1, 'bob');
        *>   SQL> insert into test (user_id, username) values (2, 'ellen');
        *>   SQL> insert into test (user_id, username) values (3, 'john');
        *>  
        *> *********************************************************************
        IDENTIFICATION DIVISION.
            PROGRAM-ID. pgcobol.
            AUTHOR. Gustavo S. Teixeira - gsteixei@gmail.com
            DATE-WRITTEN. 2021-07-10
            INSTALLATION. cobc -xj -lpq postgres1.cob
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 conn_string      PIC x(124) VALUE 
                                        'dbname=cobol ' &
                                        'hostaddr=localhost ' &
                                        'user=dbuser ' &
                                        'password=xxxx ' &
                                        'hostaddr=127.0.0.1 ' &
                                        'port=5432 ' & x"00".
                01 connection       USAGE POINTER.
                01 db_cursor        USAGE POINTER.
                01 counter          USAGE BINARY-LONG.
                    01 result_pointer   USAGE POINTER.
                    01 result_string    PIC X(4096) BASED.
                    01 data_value       PIC X(4096).
                01 data_control.
                    03 db_row       PIC 9(6) VALUE ZEROS.
                    03 db_column    PIC 9(6) VALUE ZEROS.
                01 table_row.
                    02 user_id      PIC 9(4) VALUE ZEROS.
                    02 username     PIC X(50) VALUE SPACES.
        *> *********************************************************************
        PROCEDURE DIVISION.
            *> connect
            CALL "PQconnectdb" USING conn_string RETURNING connection.
            *> query DB, it will return a cursor
            CALL "PQexec" USING BY VALUE connection BY REFERENCE 
                "SELECT user_id, username FROM test;" & x"00"
                RETURNING db_cursor END-CALL.
            *> get how many entries there are in the table
            CALL "PQntuples" USING BY VALUE db_cursor RETURNING counter.
            DISPLAY "number of rows: " counter.
            *> iterate over rows
            PERFORM VARYING db_row FROM 0 BY 1 UNTIL db_row >= counter
                *> get value of column 1 (user_id)
                CALL "PQgetvalue" USING BY VALUE db_cursor 
                        BY VALUE db_row BY VALUE 0 
                        RETURNING result_pointer END-CALL
                    SET ADDRESS OF result_string TO result_pointer
                    STRING result_string DELIMITED BY x"00" 
                        INTO data_value END-STRING
                    MOVE data_value TO user_id
                *> get value of column 2 (username)
                CALL "PQgetvalue" USING BY VALUE db_cursor 
                        BY VALUE db_row by value 1
                        RETURNING result_pointer END-CALL
                    SET ADDRESS OF result_string TO result_pointer
                    STRING result_string DELIMITED BY x"00" 
                        INTO data_value END-STRING
                MOVE FUNCTION trim(data_value) TO username
                DISPLAY user_id " - " username
            END-PERFORM
            *> close connection
            CALL "PQfinish" USING BY VALUE connection RETURNING OMITTED.
            GOBACK.
        END PROGRAM pgcobol.
