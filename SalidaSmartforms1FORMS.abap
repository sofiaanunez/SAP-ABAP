*&---------------------------------------------------------------------*
*&  Include           ZUSER09_PRACTICASF_F01
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SELECCION_DATOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_SELECCION_DATOS .
* •	Acceder a la tabla vbrk con vbrk-vbeln = p_vbeln.
*Obtener un único registro con los campos: fkdat , kunag, waerk

SELECT SINGLE vbeln fkdat kunag waerk
FROM vbrk
INTO wa_vbrk
WHERE vbeln = p_vbeln.

  IF sy-subrc IS INITIAL.
    ENDIF.

*	Acceder a la tabla Kna1 con kna1-kunnr = vbrk-kunag.
*Obtener un único registro con los campos: name1, stras,ort01.

SELECT SINGLE kunnr name1 stras ort01
FROM kna1
INTO wa_kna1
WHERE kunnr = wa_vbrk-kunag.

  IF sy-subrc IS INITIAL.
      wa_final1-vbeln = wa_vbrk-vbeln. "documento"
      wa_final1-fkdat = wa_vbrk-fkdat. "fecha"
      wa_final1-kunag = wa_vbrk-kunag. "cod cliente"
      wa_final1-name1 = wa_kna1-name1. "nombre"
      wa_final1-stras = wa_kna1-stras.
      wa_final1-ort01 = wa_kna1-ort01.

      CONCATENATE wa_kna1-stras
                  wa_kna1-ort01
                  INTO wa_final1-p_dir
                  SEPARATED BY ','.

      APPEND wa_final1 TO it_final1.
    ENDIF.

*•  Acceder a la tabla vbrp con vbrp-vbeln = p_vbeln.
*Obtener N registros y los campos: meins, fklmg, netwr, matnr, artx, mwsbp.

SELECT vbeln meins fklmg netwr matnr arktx mwsbp
FROM vbrp
INTO TABLE it_vbrp
WHERE vbeln = p_vbeln.

  LOOP AT it_vbrp INTO wa_vbrp.
    wa_final2-matnr = wa_vbrp-matnr.
    wa_final2-meins = wa_vbrp-meins.
    wa_final2-arktx = wa_vbrp-arktx.
    wa_final2-fklmg = wa_vbrp-fklmg. "cantidad"
    wa_final2-p_unit = wa_vbrp-netwr + wa_vbrp-mwsbp / wa_vbrp-fklmg. "unitario"
    wa_final2-mwsbp = wa_vbrp-netwr + wa_vbrp-mwsbp. "total"

    APPEND wa_final2 TO it_final2.
    ENDLOOP.

endform.                    " F_SELECCION_DATOS
*&---------------------------------------------------------------------*
*&      Form  F_IMPRIMIR_DATOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
form F_IMPRIMIR_DATOS .
CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
  EXPORTING
    formname                 = 'ZUSER09_PRACTICA'
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
        it_tabla_f2                = it_final2
        wa_header                  = wa_final1
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
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*         WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
    ENDIF.

ENDIF.

endform.                    " F_IMPRIMIR_DATOS
