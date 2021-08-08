        *> **********************************************************************
        *> Connect and get data from Postgres using COBOL
        *>
        *>    To run this, you need libpq, a Postgres server and GnuCobol.
        *>    This is for educational purposes and takes little effort to DRY.
        *>      its a sligtly more advanced example as this check connection 
        *>      status and tries to simplify data retrieval.
        *>    If you want a simpler example, please look at "postgres1.cob"
        *>    Also compiles in "non-free format".
        *>
        *>    Usage:   
        *>   createdb cobol
        *>   psql --dbname=cobol
        *>   SQL> CREATE TABLE test (user_id integer NOT NULL,
        *>                           username character varying(50) NOT NULL);
        *>   SQL> insert into test (user_id, username) values (1, 'bob');
        *>   SQL> insert into test (user_id, username) values (2, 'ellen');
        *>  
        *> *********************************************************************
        IDENTIFICATION DIVISION.
            PROGRAM-ID. pgcobol.
            AUTHOR. Gustavo S. Teixeira - gsteixei@gmail.com
            DATE-WRITTEN. 2021-07-10
            INSTALLATION. cobc -xj -lpq postgres2.cob
        DATA DIVISION.
            WORKING-STORAGE SECTION.
                01 conn_string      PIC x(125) VALUE 
                                        "dbname=cobol " &
                                        "hostaddr=localhost " &
                                        "user=dbuser " &
                                        "password=xxxx " &
                                        "port=5432 " & x"00".
                01 connection       USAGE POINTER.
                01 db_cursor        USAGE POINTER.
                01 counter          USAGE BINARY-LONG.
                01 result_pointer   USAGE POINTER.
                01 result_string    PIC X(4096) BASED.
                01 result_data      PIC X(4096).
                01 data_control.
                    03 db_row       PIC 9(6) VALUE ZEROS.
                    03 db_column    PIC 9(6) VALUE ZEROS.
                01 table_row.
                    02 user_id      PIC 9(4) VALUE ZEROS.
                    02 username     PIC X(50) VALUE SPACES.
        *> *********************************************************************
        PROCEDURE DIVISION.
            *> connect, then check status.
            CALL "PQconnectdb" USING conn_string RETURNING connection.
            CALL "PQstatus" USING BY VALUE connection RETURNING counter.
            IF counter <> 0 THEN
                DISPLAY "Connection error! " counter
                STOP RUN
            END-IF.
            *> query DB, will return a cursor
            CALL "PQexec" USING BY VALUE connection BY REFERENCE 
                "SELECT user_id, username FROM test;" & x"00"
                RETURNING db_cursor END-CALL.
            *> get how many entries there are in the table
            CALL "PQntuples" USING BY VALUE db_cursor RETURNING counter.
            DISPLAY "number of rows: " counter.
            *> iterate over rows
            PERFORM VARYING db_row FROM 0 BY 1 UNTIL db_row >= counter
                *> get value of column 0 (user_id)
                MOVE 0 TO db_column
                PERFORM get_value
                MOVE result_data TO user_id
                *> get value of column 1 (username)
                MOVE 1 TO db_column
                PERFORM get_value
                MOVE FUNCTION trim(result_data) TO username
                *> show result
                DISPLAY user_id " - " username
            END-PERFORM
            *> close connection
            CALL "PQfinish" USING BY VALUE connection RETURNING OMITTED.
            GOBACK.
            *> ****************************************************************
            get_value.
                CALL "PQgetvalue" USING BY VALUE db_cursor 
                        BY VALUE db_row by value db_column
                        RETURNING result_pointer END-CALL
                SET ADDRESS OF result_string TO result_pointer
                STRING result_string DELIMITED BY x"00" 
                        INTO result_data END-STRING
                EXIT.
            *> ****************************************************************
        END PROGRAM pgcobol.
