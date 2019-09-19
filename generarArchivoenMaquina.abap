*&---------------------------------------------------------------------*
*&  Include           ZUSER09_EJARC_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SELECCION
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_seleccion .
  SELECT carrid connid cityfrom cityto
    FROM spfli
    INTO TABLE it1_spfli
    WHERE connid IN s_connid.

  IF sy-subrc = 0.
    SORT: it1_spfli BY carrid.
  ELSE.
    WRITE: 'No hay asignados numeros de vuelos'.
  ENDIF.

  SELECT carrid carrname
    FROM scarr
    INTO TABLE it1_scarr
    FOR ALL ENTRIES IN it1_spfli "LO QUE OBTUVE ANTERIORMENTE"
    WHERE carrid = it1_spfli-carrid. "COINCIDAN"

  IF sy-subrc = 0.
    SORT: it1_spfli BY carrid.
  ELSE.
    WRITE: 'No hay compañias registradas'.
  ENDIF.

  SORT: it_mix BY carrid.
  LOOP AT it1_spfli INTO wa1_spfli.
    " WRITE: / , wa1_spfli-carrid."
    CLEAR: wa1_scarr.
    READ TABLE it1_scarr INTO wa1_scarr
    WITH KEY carrid = wa1_spfli-carrid
    BINARY SEARCH.

    "VALIDO LO QUE BUSQUE CON EL READ TABLE"
    IF sy-subrc = 0.
      wa_mix-carrname = wa1_scarr-carrname.
    ENDIF.

    wa_mix-carrid = wa1_spfli-carrid.
    wa_mix-connid = wa1_spfli-connid.
    wa_mix-cityfrom = wa1_spfli-cityfrom.
    wa_mix-cityto = wa1_spfli-cityto.
    wa_mix-carrname = wa1_scarr-carrname.

    APPEND wa_mix TO it_mix.
    CLEAR: wa_mix.
  ENDLOOP.

  LOOP AT it_mix INTO wa_mix.
    WRITE: / wa_mix.
  ENDLOOP.

ENDFORM.                    " F_SELECCION
*&---------------------------------------------------------------------*
*&      Form  F_DIRECTORY_BROWSE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SELECCION_CARPETA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_seleccion_carpeta .
  CALL METHOD cl_gui_frontend_services=>directory_browse
    EXPORTING
      window_title         = 'Seleccione la carpeta'
      initial_folder       = 'C:'
    CHANGING
      selected_folder      = p_folder
    EXCEPTIONS
      cntl_error           = 1
      error_no_gui         = 2
      not_supported_by_gui = 3
      OTHERS               = 4.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
               WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.
ENDFORM.                    " F_SELECCION_CARPETA
*&---------------------------------------------------------------------*
*&      Form  F_CREAR_ARCHIVO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_crear_archivo .

  DATA: l_ruta TYPE string,
        it_car TYPE TABLE OF ty_mix,
        wa_car TYPE string.

  LOOP AT it_mix INTO wa_mix.
    CONCATENATE
    wa_mix-carrid ';'
    wa_mix-connid ';'
    wa_mix-cityfrom ';'
    wa_mix-cityto ';'
    wa_mix-carrname
    INTO wa_car.

    APPEND wa_car TO it_car.
    ENDLOOP.

  CONCATENATE p_folder
               '\'
               'lista_fecha_hora'
               sy-datum
               sy-timlo
               '.txt'
          INTO l_ruta.


    CALL METHOD cl_gui_frontend_services=>gui_download
      EXPORTING
        filename                = l_ruta
      CHANGING
        data_tab                = it_car
      EXCEPTIONS
        file_write_error        = 1
        no_batch                = 2
        gui_refuse_filetransfer = 3
        invalid_type            = 4
        no_authority            = 5
        unknown_error           = 6
        header_not_allowed      = 7
        separator_not_allowed   = 8
        filesize_not_allowed    = 9
        header_too_long         = 10
        dp_error_create         = 11
        dp_error_send           = 12
        dp_error_write          = 13
        unknown_dp_error        = 14
        access_denied           = 15
        dp_out_of_memory        = 16
        disk_full               = 17
        dp_timeout              = 18
        file_not_found          = 19
        dataprovider_exception  = 20
        control_flush_error     = 21
        not_supported_by_gui    = 22
        error_no_gui            = 23
        OTHERS                  = 24.
    IF sy-subrc <> 0.
      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                 WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.


  ENDFORM.                    " F_CREAR_ARCHIVO
