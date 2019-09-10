*&---------------------------------------------------------------------*
*& Report  ZUSER09_CLIENTES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZUSER09_CLIENTES.

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
*& DECLARACION DE TABLAS INTERNAS
*&---------------------------------------------------------------------*
DATA: it_clientes type TABLE OF ty_clientes.

*&---------------------------------------------------------------------*
*& DECLARACION DE ESTRUCTURA
*&---------------------------------------------------------------------*
DATA: wa_clientes type ty_clientes.

*&---------------------------------------------------------------------*
*& SELECT-OPTIONS
*&---------------------------------------------------------------------*
SELECT-OPTIONS s_kunnr for zclientes_acc-KUNNR.

SELECT kunnr razon zobservcli
  INTO TABLE it_clientes
  FROM zclientes_acc
  WHERE kunnr IN s_kunnr.

  IF sy-subrc = 0.
  SORT it_clientes BY kunnr.
  ELSE.
    MESSAGE e000(z_errorkunnr) WITH text-003.
  ENDIF.

  LOOP AT it_clientes INTO wa_clientes.
    WRITE: /, wa_clientes-kunnr, wa_clientes-razon, wa_clientes-zobservcli.
    ENDLOOP.
