*> Tell if a word is palindrome
IDENTIFICATION DIVISION.
    PROGRAM-ID. palindrome.
    AUTHOR. Gustavo Teixeira - gsteixei@gmail.com
    DATE-WRITTEN. 2021-07-10
DATA DIVISION.
    WORKING-STORAGE SECTION.
        01 the_word    PIC X(120) VALUE SPACES.
PROCEDURE DIVISION.
    DISPLAY "Please, tell me a word".
    ACCEPT the_word.
    IF FUNCTION reverse(FUNCTION trim(the_word)) = FUNCTION trim(the_word) THEN
        DISPLAY FUNCTION trim(the_word) " is a palindrome!"
    ELSE
        DISPLAY FUNCTION trim(the_word) " NOT a palindrome. Try again"
    END-IF
    STOP RUN.
END PROGRAM palindrome.
