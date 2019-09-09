FUNCTION zuser09_suma20.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(P_ISUMA20) TYPE  I
*"  EXPORTING
*"     REFERENCE(P_ESUMA20) TYPE  I
*"----------------------------------------------------------------------


CALL FUNCTION 'ZUSER09_FUNCIONES'
  EXPORTING
    p_a           = 20
    p_b           = p_isuma20
 IMPORTING
   P_C           = p_esuma20
          .
CALL FUNCTION 'POPUP_TO_INFORM'
  EXPORTING
    titel         = 'sumatoria'
    txt1          = 'el resultado es: '
    txt2          = p_esuma20
*   TXT3          = ' '
*   TXT4          = ' '
          .



ENDFUNCTION.
