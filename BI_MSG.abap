*&---------------------------------------------------------------------*
*& Report  ZBI_USER09
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZBI_USER09.

*&---------------------------------------------------------------------*
*& TABLA CREADA ZCLIENTES
*&---------------------------------------------------------------------*
TABLES: ZUSER09CLIENTESF, bdcdata, bdcmsgcoll.

*&---------------------------------------------------------------------*
*& DECLARACION DE TIPOS
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_file,
  KUNNR       TYPE zclientes-kunnr,
  RAZON       TYPE zclientes-razon,
  OBSERV      TYPE zclientes-observ,
  END OF ty_file,

  BEGIN OF ty_file_msg,
  KUNNR       TYPE zclientes-kunnr,
  RAZON       TYPE zclientes-razon,
  OBSERV      TYPE zclientes-observ,
  MSG         TYPE string,
    END OF ty_file_msg.
*&---------------------------------------------------------------------*
*& DECLARACION DE TABLAS INTERNAS
*&---------------------------------------------------------------------*
DATA: it_file         TYPE TABLE OF ty_file,
      it_file_txt     TYPE TABLE OF string,
      it_bdc_tab      TYPE TABLE OF bdcdata,
      it_bdc_msg      TYPE TABLE OF bdcmsgcoll,
      it_file_msg     TYPE TABLE OF ty_file_msg.
*&---------------------------------------------------------------------*
*& DECLARACION DE ESTRUCTURAS
*&---------------------------------------------------------------------*
DATA: wa_file         TYPE ty_file,
      wa_file_txt     TYPE string,
      wa_bdc_tab      TYPE bdcdata,
      wa_bdc_msg      TYPE bdcmsgcoll,
      wa_file_msg     TYPE ty_file_msg,
      v_message       TYPE string.
*&---------------------------------------------------------------------*
*& DECLARACION SELECCION DE PANTALLA
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-001.
  PARAMETERS: p_file TYPE STRING DEFAULT 'C:\Users\T11641.Training16\Documents\prov.txt'.
 SELECTION-SCREEN END OF BLOCK b1.
 
 START-OF-SELECTION.

 PERFORM f_leer_file.

 LOOP AT it_file INTO wa_file.
   REFRESH it_bdc_tab.
 PERFORM f_fill_bdc_file USING:
   'X' 'SAPMSVMA' '0100',
   ' ' 'BDC_CURSOR' 'VIEWNAME',
   ' ' 'BDC_OKCODE' '=UPD',
   ' ' 'VIEWNAME' 'ZUSER09CLIENTESF',
   ' ' 'VIMDYNFLDS-LTD_DTA_NO' 'X',

   'X' 'SAPLZUSER09CLIENTESF' '0001',
   ' ' 'BDC_CURSOR' 'ZUSER09CLIENTESF-KUNNR(01)',
   ' ' 'BDC_OKCODE' '=NEWL',

   'X' 'SAPLZUSER09CLIENTESF' '0001',
   ' ' 'BDC_CURSOR' 'ZUSER09CLIENTESF-OBSERV(01)',
   ' ' 'BDC_OKCODE' '=SAVE',
   ' ' 'ZUSER09CLIENTESF-KUNNR(01)' wa_file-kunnr,
   ' ' 'ZUSER09CLIENTESF-RAZON(01)' wa_file-razon,
   ' ' 'ZUSER09CLIENTESF-OBSERV(01)' wa_file-observ,

   'X' 'SAPLZUSER09CLIENTESF' '0001',
   ' ' 'BDC_CURSOR' 'ZUSER09CLIENTESF-KUNNR(02)',
   ' ' 'BDC_OKCODE' '=BACK',

   'X' 'SAPLZUSER09CLIENTESF' '0001',
   ' ' 'BDC_CURSOR' 'ZUSER09CLIENTESF-KUNNR(02)',
   ' ' 'BDC_OKCODE' '=BACK',

   'X' 'SAPMSVMA' '0100',
   ' ' 'BDC_CURSOR' 'VIEWNAME',
   ' ' 'BDC_OKCODE' '=UPD',
   ' ' 'VIEWNAME' 'ZUSER09CLIENTESF',
   ' ' 'VIMDYNFLDS-LTD_DTA_NO' 'X' ,

   'X' 'SAPLZUSER09CLIENTESF' '0001',
   ' ' 'BDC_CURSOR' 'ZUSER09CLIENTESF-KUNNR(01)',
   ' ' 'BDC_OKCODE' '=BACK',

   'X' 'SAPMSVMA' '0100',
   ' ' 'BDC_OKCODE' '/EBACK',
   ' ' 'BDC_CURSOR' 'VIEWNAME'.

 CALL TRANSACTION 'SM30' USING it_bdc_tab mode 'N' MESSAGES INTO it_bdc_msg.

 LOOP AT it_bdc_msg INTO wa_bdc_msg.

   wa_file_msg-kunnr = wa_file-kunnr.
   wa_file_msg-razon = wa_file-razon.
   wa_file_msg-observ = wa_file-observ.

  MESSAGE ID wa_bdc_msg-msgid
     TYPE wa_bdc_msg-msgtyp
     NUMBER wa_bdc_msg-msgnr
     WITH wa_bdc_msg-msgv1
          wa_bdc_msg-msgv2
          wa_bdc_msg-msgv3
          wa_bdc_msg-msgv4
     INTO wa_file_msg-msg.


*   IF wa_bdc_msg = 'E'.
*     wa_file_msg-msg = 'NO'.
*     ELSE.
*       wa_file_msg-msg = 'OK'.
*       ENDIF.
       ENDLOOP.

     APPEND wa_file_msg TO it_file_msg.

 ENDLOOP.

       LOOP at it_file_msg INTO wa_file_msg.
       write: /, wa_file_msg-kunnr, wa_file_msg-razon, wa_file_msg-observ, wa_file_msg-msg.
       ENDLOOP.


*&---------------------------------------------------------------------*
*&      Form  F_LEER_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_LEER_FILE .
 CALL METHOD cl_gui_frontend_services=>gui_upload
  EXPORTING
    filename                = p_file
   filetype                = 'ASC'
*    has_field_separator     = SPACE
*    header_length           = 0
*    read_by_line            = 'X'
*    dat_mode                = SPACE
*    codepage                = SPACE
*    ignore_cerr             = ABAP_TRUE
*    replacement             = '#'
*    virus_scan_profile      =
*  IMPORTING
*    filelength              =
*    header                  =
  CHANGING
    data_tab                = it_file_txt
  EXCEPTIONS
    file_open_error         = 1
    file_read_error         = 2
    no_batch                = 3
    gui_refuse_filetransfer = 4
    invalid_type            = 5
    no_authority            = 6
    unknown_error           = 7
    bad_data_format         = 8
    header_not_allowed      = 9
    separator_not_allowed   = 10
    header_too_long         = 11
    unknown_dp_error        = 12
    access_denied           = 13
    dp_out_of_memory        = 14
    disk_full               = 15
    dp_timeout              = 16
    not_supported_by_gui    = 17
    error_no_gui            = 18
    others                  = 19
        .
IF sy-subrc <> 0.
 MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
           WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
ENDIF.

  LOOP AT it_file_txt into wa_file_txt.
  SPLIT wa_file_txt at '|'
  INTO wa_file-kunnr
       wa_file-razon
       wa_file-observ.
  APPEND wa_file to it_file.
  ENDLOOP.
  REFRESH it_file_txt.
endform.                    " F_LEER_FILE

*&---------------------------------------------------------------------*
*&      Form  F_FILL_BDC_FILE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_FILL_BDC_FILE USING dynbegin name value.
  IF dynbegin = 'X'.
    CLEAR wa_bdc_tab.
    MOVE: name  to wa_bdc_tab-program,
          value to wa_bdc_tab-dynpro,
          'X'   to wa_bdc_tab-dynbegin.
    APPEND wa_bdc_tab to it_bdc_tab.
    ELSE.
      CLEAR wa_bdc_tab.
    MOVE: name  to wa_bdc_tab-fnam,
          value to wa_bdc_tab-fval.
    APPEND wa_bdc_tab to it_bdc_tab.
    ENDIF.
endform.                    " F_FILL_BDC_FILE
