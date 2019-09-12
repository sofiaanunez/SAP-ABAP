*&---------------------------------------------------------------------*
*&  Include           Z_ACC_TEST_11_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_OBTENCION_DATOS
*&---------------------------------------------------------------------*
FORM f_obtencion_datos.

  SELECT kunnr razon
    FROM zclientes
    INTO TABLE it_clientes_acc
    WHERE kunnr IN so_kunnr.

  IF sy-subrc EQ 0.

    SORT: it_clientes_acc BY kunnr.

    SELECT kunnr pedido direccion entrega
      FROM zpedidos
      INTO TABLE it_pedidos_acc
      FOR ALL ENTRIES IN it_clientes_acc
      WHERE kunnr     EQ it_clientes_acc-kunnr
        AND entrega EQ v_entregado.

    IF sy-subrc EQ 0.
      SORT: it_pedidos_acc BY kunnr pedido.
    ENDIF.

  ENDIF.

ENDFORM.                    " F_OBTENCION_DATOS
*&---------------------------------------------------------------------*
*&      Form  F_DATOS_SALIDA
*&---------------------------------------------------------------------*
FORM f_datos_salida.

  LOOP AT it_pedidos_acc INTO wa_pedidos_acc.

    READ TABLE it_clientes_acc INTO wa_clientes_acc
      WITH KEY kunnr = wa_pedidos_acc-kunnr
               BINARY SEARCH.

    IF sy-subrc EQ 0.
      wa_alv-kunnr = wa_clientes_acc-kunnr.
      wa_alv-razon = wa_clientes_acc-razon.
    ENDIF.

    wa_alv-pedido    = wa_pedidos_acc-pedido.
    wa_alv-direccion = wa_pedidos_acc-direccion.
    wa_alv-entregado = wa_pedidos_acc-entregado.

    APPEND wa_alv TO it_alv.
  ENDLOOP.

  IF it_alv[] IS NOT INITIAL.
    SORT: it_alv BY kunnr pedido.
  ENDIF.

ENDFORM.                    " F_DATOS_SALIDA
*&---------------------------------------------------------------------*
*&      Form  F_ALV_SALIDA
*&---------------------------------------------------------------------*
FORM f_alv_salida.

  PERFORM f_completar_layout.

  PERFORM f_completar_fieldcat.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = wa_layout
      it_fieldcat        = it_fieldcat
    TABLES
      t_outtab           = it_alv
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.

  IF sy-subrc NE 0.
    MESSAGE s000(zescuelita) WITH text-002 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.                    " F_ALV_SALIDA
*&---------------------------------------------------------------------*
*&      Form  F_COMPLETAR_LAYOUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_completar_layout .

  wa_layout-zebra             = dc_x.
  wa_layout-colwidth_optimize = dc_x.
  wa_layout-window_titlebar   = 'Ejercicio 11!'.

ENDFORM.                    " F_COMPLETAR_LAYOUT
*&---------------------------------------------------------------------*
*&      Form  F_COMPLETAR_FIELDCAT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_completar_fieldcat .

  DATA: wa_fieldcat TYPE slis_fieldcat_alv.

  wa_fieldcat-fieldname       = 'KUNNR'.
  wa_fieldcat-tabname         = 'IT_ALV'.
  wa_fieldcat-ref_fieldname   = 'KUNNR'.
  wa_fieldcat-ref_tabname     = 'ZCLIENTES'.
  wa_fieldcat-seltext_m       = 'Customer'.
  wa_fieldcat-seltext_s       = 'Customer'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.


  wa_fieldcat-fieldname       = 'RAZON' .
  wa_fieldcat-tabname         = 'IT_ALV'.
  wa_fieldcat-ref_fieldname   = 'RAZON'.
  wa_fieldcat-ref_tabname     = 'ZCLIENTES'.
  wa_fieldcat-seltext_m       = 'Raz�n social' .
  wa_fieldcat-seltext_s       = 'Raz�n social'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname       = 'PEDIDO'.
  wa_fieldcat-tabname         = 'IT_ALV'.
  wa_fieldcat-ref_fieldname   = 'PEDIDO'.
  wa_fieldcat-ref_tabname     = 'ZPEDIDOS'.
  wa_fieldcat-seltext_m       = 'Pedido'.
  wa_fieldcat-seltext_s       = 'Pedido'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.


  wa_fieldcat-fieldname       = 'DIRECCION'.
  wa_fieldcat-tabname         = 'IT_ALV'.
  wa_fieldcat-ref_fieldname   = 'DIRECCION'.
  wa_fieldcat-ref_tabname     = 'ZPEDIDOS'.
  wa_fieldcat-seltext_m       = 'Direcci�n'.
  wa_fieldcat-seltext_s       = 'Direcci�n'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

  wa_fieldcat-fieldname       = 'ENTREGADO'.
  wa_fieldcat-tabname         = 'IT_ALV'.
  wa_fieldcat-ref_fieldname   = 'ENTREGADO'.
  wa_fieldcat-ref_tabname     = 'ZPEDIDOS'.
  wa_fieldcat-seltext_m       = 'Entregado'.
  wa_fieldcat-seltext_s       = 'Entregado'.

  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR wa_fieldcat.

ENDFORM.                    " F_COMPLETAR_FIELDCAT
