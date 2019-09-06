*&---------------------------------------------------------------------*
*& Report  Z_EJERCICIO_VERO_2
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  z_ejercicio_vero_2.
*&---------------------------------------------------------------------*
*& Declaracion de typos
*&---------------------------------------------------------------------*

TYPES: BEGIN OF ty_alumno,
        nombre     TYPE  c LENGTH 20,
        apellido   TYPE char30,
        postal     TYPE c LENGTH 8,
END OF ty_alumno.


"Creacion tabla interna i_alumnos"
*&---------------------------------------------------------------------*
*& Declaracion de variables
*&---------------------------------------------------------------------*

DATA: wa_alumnos      TYPE zst_alumno_vero_2.

"EJERCICIO 4"
TYPES: i_alumnos TYPE zst_alumno_vero_2.
DATA: i_alumnos TYPE STANDARD TABLE OF zst_alumno_vero_2.
DATA: wa_i_alumnos TYPE zst_alumno_vero_2.

*&---------------------------------------------------------------------*
*& START-OF-SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.

*Punto a del ejercicio 2
  PERFORM f_ejercicio_2_a.

  PERFORM f_ejercicio_2_b_y_c.

  PERFORM f_ejercicio_3_a.

  PERFORM f_ejercicio_3_b.


*&---------------------------------------------------------------------*
*& Subrutinas
*&---------------------------------------------------------------------*

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
  DATA:  lv_1 TYPE i,
         lv_2 TYPE i,
         lv_3 TYPE i.


  lv_1 = 2.
  lv_2 = 5.

  lv_3 = lv_1 + lv_2.


  WRITE: /, / 'Parte B y C del ejercicio'.
  IF lv_3 GT 10.

    WRITE: 'el resultado es mayora 10 e igual a: ', lv_3.
  ELSE.
    WRITE: 'el resultado no es mayora 10, es igual a: ', lv_3.

  ENDIF.


ENDFORM.                    " F_EJERCICIO_2_B
*&---------------------------------------------------------------------*
*&      Form  F_EJERCICIO_3_A
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_ejercicio_3_a .
  DATA:  wa_alumno_local TYPE ty_alumno.

  CLEAR wa_alumnos.

  wa_alumnos-padron     = '1234'.
  wa_alumnos-nombre     = 'Vero'.
  wa_alumnos-apellido   = 'lapolla'.
  wa_alumnos-nacimiento = '19761124'.
  wa_alumnos-postal     = '1172'.

* solo mueve los campos que se llamen igual y tengan el mismo tipo.
  MOVE-CORRESPONDING wa_alumnos TO wa_alumno_local.

  WRITE: / wa_alumno_local.

* observamos como no respeta nuestra division logica de campos
  wa_alumno_local = wa_alumnos.

ENDFORM.                    " F_EJERCICIO_3_A
*&---------------------------------------------------------------------*
*&      Form  F_EJERCICIO_3_B
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_ejercicio_3_b .

  wa_i_alumnos-padron    = '3456'.
  wa_i_alumnos-nombre     = 'Sofia'.
  wa_i_alumnos-apellido   = 'Nunez'.
  wa_i_alumnos-nacimiento = '19761424'.
  wa_i_alumnos-postal     = '1706'.

  "INSERTO DATOS"
  APPEND wa_i_alumnos TO i_alumnos.
  CLEAR wa_i_alumnos.
  "ORDENO POR SU PADRON"

  wa_i_alumnos-padron    = '0567'.
  wa_i_alumnos-nombre     = 'Wendy'.
  wa_i_alumnos-apellido   = 'Santillan'.
  wa_i_alumnos-nacimiento = '20150812'.
  wa_i_alumnos-postal     = '1706'.

  APPEND wa_i_alumnos TO i_alumnos.
  CLEAR wa_i_alumnos.

  wa_i_alumnos-padron    = '12345'.
  wa_i_alumnos-nombre     = 'Coni'.
  wa_i_alumnos-apellido   = 'Santillan'.
  wa_i_alumnos-nacimiento = '20140224'.
  wa_i_alumnos-postal     = '1706'.

  APPEND wa_i_alumnos TO i_alumnos.
  CLEAR wa_i_alumnos.

  "ORDENAR POR PADRON"
  SORT i_alumnos BY padron ASCENDING.

  LOOP AT i_alumnos INTO wa_i_alumnos.
    WRITE: / 'Apellido: ',wa_i_alumnos-padron, / 'Nombre', wa_i_alumnos-nombre, / 'Apellido ', wa_i_alumnos-apellido, / 'Fecha de nacimiento: ', wa_i_alumnos-nacimiento, / 'Código postal: ', wa_i_alumnos-postal, / '--------------------------'.
  ENDLOOP.

  "LEYENDO EL SEGUNDO REGISTRO"
  READ TABLE i_alumnos INTO wa_i_alumnos INDEX 2.
  IF sy-subrc = 0.
    WRITE: / 'Padron: ',wa_i_alumnos-padron, / 'Nombre', wa_i_alumnos-nombre, / 'Apellido ', wa_i_alumnos-apellido, / 'Fecha de nacimiento: ', wa_i_alumnos-nacimiento, / 'Código postal: ', wa_i_alumnos-postal.
  ELSE.
    WRITE / 'No existe usuario registrado en esa posicion'.
  ENDIF.

  "LEYENDO EL REGISTRO CON PADRON 12345"
  READ TABLE i_alumnos INTO wa_i_alumnos WITH KEY padron = '12345'.
  IF sy-subrc = 0.
    WRITE: / 'Padron: ', wa_alumnos-padron.
  ELSE.
    WRITE / 'No existe un padron con ese registro'.
  ENDIF.

  "CAMBIAR EL CODIGO POSTAL DE TODOS LOS REGISTRO POR TABLA C666AHH"
  LOOP AT i_alumnos INTO wa_i_alumnos.
    WRITE: / 'Apellido: ',wa_i_alumnos-padron, / 'Nombre', wa_i_alumnos-nombre, / 'Apellido ', wa_i_alumnos-apellido, / 'Fecha de nacimiento: ', wa_i_alumnos-nacimiento, / 'Código postal: ', wa_i_alumnos-postal, / '--------------------------'.
    wa_i_alumnos-postal = 'C666AHH'.
    MODIFY i_alumnos FROM wa_i_alumnos.
  ENDLOOP.

  "BORRAR EL ALUMNO CUYO PADRON SEA 12345"

  DELETE i_alumnos WHERE padron = '12345'.




ENDFORM.                    " F_EJERCICIO_3_B
