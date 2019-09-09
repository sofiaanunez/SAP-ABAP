*&---------------------------------------------------------------------*
*& Report  ZSUMA_USER09
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zsuma_user09.

"PERMITE ALMACENAR LA SUMA"

*&---------------------------------------------------------------------*
*& DECLARACION DE VARIABLE
*&---------------------------------------------------------------------*
DATA: lp_c TYPE i.

"MUESTRA LA PANTALLA"

*&---------------------------------------------------------------------*
*& DECLARACION DE PANTALLA
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.

"DEFINO LOS PARAMETROS DE ENTRADA PERO DENTRO DEL PROGRAMA, SON DE SALIDA"
PARAMETERS: lp_a TYPE i, lp_b TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*

START-OF-SELECTION.

  "LLAMANDO A LA FUNCION DONDE TENGO GUARDADOS LOS PARAMETROS"
  CALL FUNCTION 'ZUSER09_FUNCIONES'
    EXPORTING
      p_a = lp_a
      p_b = lp_b
    IMPORTING
      p_c = lp_c.

  WRITE lp_c.
