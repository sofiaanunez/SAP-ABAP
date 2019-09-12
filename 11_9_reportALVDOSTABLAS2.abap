*&---------------------------------------------------------------------*
*&  Include           Z_ACC_TEST_11_TOP
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&  Include           Z_ACC_TEST_11_TOP
*&---------------------------------------------------------------------*
************************************************************************
* Definici�n de tablas del sistema                                     *
************************************************************************
TABLES: kna1.

************************************************************************
* Declaracion de ALV                                                   *
************************************************************************
TYPE-POOLS: slis.

************************************************************************
* Definici�n de tipos de datos                                         *
************************************************************************
TYPES: BEGIN OF t_clientes_acc,
         kunnr TYPE kunnr,
         razon TYPE char35,
       END OF t_clientes_acc,

       BEGIN OF t_pedidos_acc,
         kunnr     TYPE kunnr,
         pedido    TYPE char50,
         direccion TYPE char50,
         entregado TYPE char1,
       END OF t_pedidos_acc,

       BEGIN OF t_alv,
         kunnr     TYPE kunnr,
         razon     TYPE char35,
         pedido    TYPE char50,
         direccion TYPE char50,
         entregado TYPE ZENTREGADO_ACC,
       END OF t_alv.

************************************************************************
* Definici�n de constantes                                             *
************************************************************************
CONSTANTS: dc_x TYPE ZENTREGADO_ACC VALUE 'X'.

************************************************************************
* Definici�n de variables                                              *
************************************************************************
DATA: v_entregado TYPE char1.

************************************************************************
* Definici�n de estructuras                                            *
************************************************************************
DATA: wa_clientes_acc TYPE t_clientes_acc,
      wa_pedidos_acc  TYPE t_pedidos_acc,
      wa_alv          TYPE t_alv,
      wa_layout       TYPE slis_layout_alv.

************************************************************************
* Definici�n de tablas internas                                        *
************************************************************************
DATA: it_clientes_acc TYPE TABLE OF t_clientes_acc,
      it_pedidos_acc  TYPE TABLE OF t_pedidos_acc,
      it_alv          TYPE TABLE OF t_alv,
      it_fieldcat     TYPE slis_t_fieldcat_alv.

************************************************************************
* Definici�n de pantalla de selecci�n                                  *
************************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE text-001.
SELECT-OPTIONS: so_kunnr FOR kna1-kunnr. "OBLIGATORY.
PARAMETERS: rb_listo RADIOBUTTON GROUP g1,
            rb_pend  RADIOBUTTON GROUP g1.
SELECTION-SCREEN END OF BLOCK b2.
