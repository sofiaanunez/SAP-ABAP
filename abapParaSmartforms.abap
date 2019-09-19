*&---------------------------------------------------------------------*
*&  Include           ZSF_USER09_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SELECCION_VUELOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_seleccion_vuelos .

  SELECT carrid connid fldate price currency
    FROM sflight
    INTO TABLE it_sflight
    WHERE carrid IN s_carrid.

  IF sy-subrc = 0.
    SORT: it_sflight BY carrid.
  ELSE.
    WRITE: 'No existen registros'.
  ENDIF.

  SELECT carrid connid cityfrom cityto
    FROM spfli
    INTO TABLE it_spfli
    FOR ALL ENTRIES IN it_sflight
    WHERE carrid = it_sflight-carrid
    AND   connid = it_sflight-connid.

   IF sy-subrc = 0.
    SORT: it_spfli BY carrid connid.
  ELSE.
    WRITE: 'No existen registros'.
  ENDIF.

  SORT it_sflight BY carrid connid.

  LOOP AT it_spfli INTO wa_spfli.
    READ TABLE it_sflight INTO wa_sflight
    WITH KEY carrid = wa_spfli-carrid
             connid = wa_spfli-connid
             BINARY SEARCH.

    IF sy-subrc EQ 0.
    wa_final-carrid   = wa_sflight-carrid.
    wa_final-connid   = wa_sflight-connid.
    wa_final-fldate   = wa_sflight-fldate.
    wa_final-price    = wa_sflight-price.
    wa_final-currency = wa_sflight-currency.
    wa_final-cityfrom = wa_spfli-cityfrom.
    wa_final-cityto = wa_spfli-cityto.
    ENDIF.

      APPEND wa_final TO it_final.
  ENDLOOP.

ENDFORM.                    " F_SELECCION_VUELOS
*&---------------------------------------------------------------------*
*&      Form  F_IMPRIMIR_FORMULARIO
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_IMPRIMIR_FORMULARIO .
CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZUSER09_SM2'
*   VARIANT                  = ' '
*   DIRECT_CALL              = ' '
 IMPORTING
   FM_NAME                  = l_funcion
 EXCEPTIONS
   NO_FORM                  = 1
   NO_FUNCTION_MODULE       = 2
   OTHERS                   = 3
          .
IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ELSE.
    CALL FUNCTION l_funcion
      EXPORTING
*       ARCHIVE_INDEX              =
*       ARCHIVE_INDEX_TAB          =
*       ARCHIVE_PARAMETERS         =
*       CONTROL_PARAMETERS         =
*       MAIL_APPL_OBJ              =
*       MAIL_RECIPIENT             =
*       MAIL_SENDER                =
*       OUTPUT_OPTIONS             =
*       USER_SETTINGS              = 'X'
        it_tabla_final             = it_final
        carrid                     = 'LH'
*     IMPORTING
*       DOCUMENT_OUTPUT_INFO       =
*       JOB_OUTPUT_INFO            =
*       JOB_OUTPUT_OPTIONS         =
*     EXCEPTIONS
*       FORMATTING_ERROR           = 1
*       INTERNAL_ERROR             = 2
*       SEND_ERROR                 = 3
*       USER_CANCELED              = 4
*       OTHERS                     = 5
              .
    IF sy-subrc <> 0.
 MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

ENDIF.

endform.                    " F_IMPRIMIR_FORMULARIO
