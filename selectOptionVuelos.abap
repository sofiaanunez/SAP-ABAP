*&---------------------------------------------------------------------*
*& Report  ZUSER09_SELECTOPTIONVUELO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09_selectoptionvuelo.

*&---------------------------------------------------------------------*
*& DECLARACION DE VARIABLES
*&---------------------------------------------------------------------*

TABLES: scarr.

TYPES: BEGIN OF ty_scarr,
  carrid TYPE scarr-carrid,
  carrname TYPE scarr-carrname,
  END OF ty_scarr,

  BEGIN OF ty_sflight,
    carrid TYPE sflight-carrid,
    connid TYPE sflight-connid,
    fldate TYPE sflight-fldate,
    price TYPE sflight-price,
    currency TYPE sflight-currency,
    END OF ty_sflight.

DATA: it_scarr TYPE TABLE OF ty_scarr,
      wa_scarr TYPE ty_scarr,
      it_sflight TYPE TABLE OF ty_sflight,
      wa_sflight TYPE ty_sflight.

*&---------------------------------------------------------------------*
*& SELECT-OPTIONS
*&---------------------------------------------------------------------*
SELECT-OPTIONS: s_carrid FOR scarr-carrid OBLIGATORY.

SELECT carrid carrname
  FROM scarr
  INTO TABLE it_scarr
  WHERE carrid IN s_carrid.

IF sy-subrc = 0.
  SORT: it_scarr BY carrid.
ENDIF.

SELECT carrid connid fldate price currency
  FROM sflight
  INTO TABLE it_sflight
  FOR ALL ENTRIES IN it_scarr
  WHERE carrid = it_scarr-carrid.

"CON EL FOR ALL ENTRIES IN TRAIGO LOS DATOS QUE OBTUVE EN LA BUSQUEDA ANTERIOR Y EN LAS DOS ULTIMAS LINEAS AGARRO LOS DATOS EN LOS QUE COINCIDEN LOS CARRID"

IF sy-subrc = 0.
  SORT it_sflight BY carrid connid.
  ENDIF.

  SORT it_scarr by carrid.

  LOOP AT it_sflight into wa_sflight.

    WRITE: /, wa_sflight-carrid.

"LEO DE UNA FORMA SIMILAR LO QUE BUSQUE EN FOR ALL ENTRIES"
"PRIMERO GUARDO LA INFO DE SFLIGHT EN SU WA Y DESPUES HAGO EL READ TABLE PARA SCARR Y LO GUARDO EN SU WA"
    CLEAR: wa_scarr.
    READ TABLE it_scarr into wa_scarr
    WITH KEY carrid = wa_sflight-carrid
    BINARY SEARCH.

    if sy-subrc = 0.
      WRITE: wa_scarr-carrname.
      ENDIF.
      ENDLOOP.
