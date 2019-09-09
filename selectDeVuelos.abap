*&---------------------------------------------------------------------*
*& Report  ZUSER09_VUELO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09_vuelo.

*&---------------------------------------------------------------------*
*& Declaracion de workarea
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_scarr,
       carrid type scarr-carrid,
       carrname type scarr-carrname,
       currcode type scarr-currcode,
       url type scarr-url,
    END OF ty_scarr.

DATA: wa_vuelo TYPE ty_scarr,
      it_tipo_vuelo TYPE STANDARD TABLE OF spfli,
      wa_tipo_vuelo TYPE spfli.

*&---------------------------------------------------------------------*
*& START OF SELECTION
*&---------------------------------------------------------------------*
START-OF-SELECTION.


  "PUNTO 1: TRAERME TODOS LOS DATOS DEL PRIMER REGISTRO DONDE SU CODIGO DE AEROLINEA SE 'AA'"


  SELECT SINGLE carrid carrname currcode url
    FROM scarr
    INTO wa_vuelo
    WHERE carrid = 'AA'.

  IF sy-subrc = 0.
    WRITE: 'DATOS DE AMERICAN AIRLINES: ' , / wa_vuelo.
    ULINE.
    ELSE.
      WRITE: 'SCARR NO TIENE DATOS'.
    ENDIF.

  CLEAR wa_vuelo.

  "AL USAR LA MISMA WORKAREA, TENGO QUE TRAER TODOS LOS DATOS PARA MANTENER LA ESTRUCTURA"

  SELECT SINGLE carrid carrname currcode url
    INTO wa_vuelo
    FROM scarr
    WHERE carrid = 'LH'.

    IF sy-subrc = 0.
    WRITE: 'DATOS DE AEROLINEA LH: ' , /,  wa_vuelo-carrname, wa_vuelo-url.
    ULINE.
    ELSE.
      WRITE: 'SCARR NO TIENE DATOS'.
    ENDIF.

  CLEAR wa_tipo_vuelo.

  "TRAER TODOS LOS TIPOS DE VUELOS QUE TIENE LA AEROLINEA LH"
  SELECT *
    INTO TABLE it_tipo_vuelo
    FROM spfli
    WHERE carrid = 'LH'.

    IF sy-subrc = 0.
      ENDIF.

     SORT: it_tipo_vuelo BY carrid connid.

  SKIP.
  WRITE 'LISTADO DE VUELOS'.
  SKIP.
  LOOP AT it_tipo_vuelo INTO wa_tipo_vuelo.

    WRITE: / wa_tipo_vuelo-mandt, wa_tipo_vuelo-carrid, wa_tipo_vuelo-connid, wa_tipo_vuelo-countryfr, wa_tipo_vuelo-cityfrom, wa_tipo_vuelo-airpfrom, wa_tipo_vuelo-countryto,
wa_tipo_vuelo-cityto, wa_tipo_vuelo-airpto, wa_tipo_vuelo-fltime, wa_tipo_vuelo-deptime, wa_tipo_vuelo-arrtime, wa_tipo_vuelo-distance, wa_tipo_vuelo-distid, wa_tipo_vuelo-fltype
, wa_tipo_vuelo-period.

  CLEAR wa_tipo_vuelo.

  ENDLOOP.
