*&---------------------------------------------------------------------*
*& Report  Z_EJERCICIO_VERO_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09ej_st.

*&---------------------------------------------------------------------*
*& Declaracion de variables
*&---------------------------------------------------------------------*


*&---------------------------------------------------------------------*
*& Declaracion de tipos
*&---------------------------------------------------------------------*

"CREACION DE TABLA LOCAL"
TYPES: BEGIN OF ty_alumno_local,
          nombre   TYPE c LENGTH 20,
          apellido  TYPE c LENGTH 30,
          postal TYPE c LENGTH 8,
  END OF ty_alumno_local.


SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
PARAMETERS: p_lv_1 TYPE i,
            p_lv_2 TYPE i.

SELECTION-SCREEN END OF BLOCK b1.

*&---------------------------------------------------------------------*
*& Declaracion de datos
*&---------------------------------------------------------------------*

DATA wa_alumnos TYPE zst_alumno_vero_2.



*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.


*Punto a del ejercicio 2
  PERFORM f_ejercicio_2_a.

  PERFORM f_ejercicio_2_b_y_c.

  perform f_ej_3.

*&---------------------------------------------------------------------*
*&      Form  F_EJERCICIO_2_A
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_ejercicio_2_a .
*Parta a del ejercicio 2
 wa_alumnos-padron     = '1234'.
  wa_alumnos-nombre     = 'Vero'.
  wa_alumnos-apellido   = 'lapolla'.
  wa_alumnos-nacimiento = '19761124'.
  wa_alumnos-postal     = '1172'.


  WRITE wa_alumnos.

*  otra opcion
  WRITE: / 'Padron: ', wa_alumnos-padron.
  WRITE: / 'Nombre: ', wa_alumnos-nombre.

  SKIP.


*   y asi todos los campos
ENDFORM.                    " F_EJERCICIO_2_A
*&---------------------------------------------------------------------*
*&      Form  F_EJERCICIO_2_B
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*



FORM f_ejercicio_2_b_y_c.
  DATA: lv_3 TYPE i.

  lv_3 = p_lv_1 + p_lv_2.


  WRITE: / 'El 1er numero es:', p_lv_1.
  WRITE: / 'El 2do numero es:', p_lv_2.
  WRITE: / 'El resultado es: ', lv_3.


ENDFORM.                    "f_ejercicio_2_b_y_c
*&---------------------------------------------------------------------*
*&      Form  F_EJERCICIO_3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_EJ_3
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_EJ_3 .
  "DECLARACION Y CARGA DE DATOS DENTRO DE LA TABLA LOCAL"
  DATA  wa_alumno_local TYPE ty_alumno_local.
  wa_alumnos-nombre     = 'Vero'.
  wa_alumnos-apellido   = 'lapolla'.
  wa_alumnos-postal     = '1172'.

"COPIA DE LOS DATOS DE WA_ALUMNOS_LOCAL A WA_ALUMNOS"
  MOVE-CORRESPONDING wa_alumnos to wa_alumno_local.
  WRITE: / wa_alumno_local.
endform.                    " F_EJ_3
