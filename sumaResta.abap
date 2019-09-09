*&---------------------------------------------------------------------*
*& Report  Z_EEJEMPLO_VERO_FUNCION
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09_sumaresta.

*&---------------------------------------------------------------------*
*&  Variables
*&---------------------------------------------------------------------*

DATA v_resultado TYPE i.

*&---------------------------------------------------------------------*
*&  Screen
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_suma1 TYPE i,
            p_suma2 TYPE i.
SELECTION-SCREEN SKIP.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-002.
PARAMETERS: p_suma  RADIOBUTTON GROUP gr1,
            p_resta RADIOBUTTON GROUP gr1.
SELECTION-SCREEN END OF BLOCK b2.

SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*&  START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.

  IF p_suma = 'X'.

    CALL FUNCTION 'Z_PRUEBA_FUNCION_2'
      EXPORTING
        a                             = p_suma1
        b                             = p_suma2
        suma                          = 'X'
      IMPORTING
        c                             = v_resultado
      EXCEPTIONS
        el_valor_a_debe_ser_mayor_a_b = 1
        OTHERS                        = 2.
    IF sy-subrc <> 0.
      MESSAGE e000(z_vero) WITH text-003.
    ENDIF.
  ELSE.     "RESTA

    IF p_suma1 GE p_suma2.

      CALL FUNCTION 'Z_PRUEBA_FUNCION_2'
        EXPORTING
          a                             = p_suma1
          b                             = p_suma2
          suma                          = ' '
        IMPORTING
          c                             = v_resultado
        EXCEPTIONS
          el_valor_a_debe_ser_mayor_a_b = 1
          OTHERS                        = 2.
      IF sy-subrc NE 0.
        MESSAGE e000(z_vero) WITH text-003.
      ENDIF.
    ELSE.   "false, if p_suma1 ge p_suma2.
      MESSAGE e004(z_vero).

    ENDIF.
  ENDIF.

  IF sy-subrc = 0.
    WRITE: / 'Su resultado es: ', v_resultado.
  ENDIF.
