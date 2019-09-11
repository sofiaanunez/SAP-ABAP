*&---------------------------------------------------------------------*
*& Report  ZUSER09_CLIENTES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZUSER09_CLIENTES.

TYPE-POOLS: slis.
*&---------------------------------------------------------------------*
*& DECLARACION DE TABLA
*&---------------------------------------------------------------------*
TABLES: zclientes_acc.

*&---------------------------------------------------------------------*
*& DECLARACION DE TIPOS
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_clientes,
      KUNNR   type zclientes_acc-KUNNR,
      RAZON   type zclientes_acc-RAZON,
ZOBSERVCLI    type zclientes_acc-ZOBSERVCLI,
       END OF ty_clientes.

*&---------------------------------------------------------------------*
*& DECLARACION DE TABLAS INTERNAS Y ESTRUCTURA
*&---------------------------------------------------------------------*
DATA: it_clientes TYPE TABLE OF ty_clientes,
      wa_clientes TYPE ty_clientes,
      wa_layout   TYPE  slis_layout_alv,
      it_fieldcat TYPE  slis_t_fieldcat_alv,
      wa_fieldcat TYPE slis_fieldcat_alv.

*1)	Se requiere imprimir en pantalla los campos KUNNR, RAZON, ZOBSERVCLI de la tabla clientes.

SELECT-OPTIONS s_kunnr for zclientes_acc-KUNNR.

SELECT kunnr razon zobservcli
  INTO TABLE it_clientes
  FROM zclientes_acc
  WHERE kunnr IN s_kunnr.

IF sy-subrc = 0.
*  WRITE: wa_scarr,
*         /.
*  ULINE.
  wa_layout-zebra = 'X'.


  wa_fieldcat-fieldname = 'KUNNR'.
  wa_fieldcat-tabname = 'IT_CLIENTES'.
  wa_fieldcat-seltext_s = 'KUNNR'.
  wa_fieldcat-seltext_m = 'KUNNR'.
  wa_fieldcat-seltext_l = 'KUNNR'.

  APPEND wa_fieldcat TO IT_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname = 'RAZON'.
  wa_fieldcat-tabname = 'IT_CLIENTES'.
  wa_fieldcat-seltext_s = 'RAZON'.
  wa_fieldcat-seltext_m = 'RAZON'.
  wa_fieldcat-seltext_l = 'RAZON'.
  wa_fieldcat-outputlen = 50.
  wa_fieldcat-just = 'C'.

  APPEND wa_fieldcat TO IT_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname = 'ZOBSERVCLI'.
  wa_fieldcat-tabname = 'IT_CLIENTES'.
  wa_fieldcat-seltext_s = 'ZOBSERVCLI'.
  wa_fieldcat-seltext_m = 'ZOBSERVCLI'.
  wa_fieldcat-seltext_l = 'ZOBSERVCLI'.

  APPEND wa_fieldcat TO IT_fieldcat.
  CLEAR wa_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = wa_layout
      it_fieldcat        = it_fieldcat
    TABLES
      t_outtab           = it_clientes
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
            WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.


ELSE.
  WRITE: 'LA TABLA CLIETNES NO TIENE DATOS'.
ENDIF.
