*&---------------------------------------------------------------------*
*& Report  ZUSER09_EJ9VUELO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09_ej9vuelo.

*&---------------------------------------------------------------------*
*& TABLA
*&---------------------------------------------------------------------*
TABLES: sflight,spfli,scarr.

*&---------------------------------------------------------------------*
*& DECLARACION DE TIPOS
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty2_sflight,
  carrid   TYPE sflight-carrid,
  connid   TYPE sflight-connid,
  fldate   TYPE sflight-fldate,
  price    TYPE sflight-price,
  currency TYPE sflight-currency,
  END OF ty2_sflight,

     BEGIN OF ty2_spfli,
   carrid  TYPE spfli-carrid,
   connid  TYPE spfli-connid,
  cityfrom TYPE spfli-cityfrom,
    cityto TYPE spfli-cityto,
   END OF ty2_spfli,

     BEGIN OF ty2_scarr,
   carrid  TYPE scarr-carrid,
  carrname TYPE scarr-carrname,
    END OF ty2_scarr,

    BEGIN OF ty2_salida,
    carrid TYPE sflight-carrid,
    connid TYPE sflight-connid,
    fldate TYPE sflight-fldate,
    price  TYPE sflight-price,
  currency TYPE sflight-currency,
  cityfrom TYPE spfli-cityfrom,
    cityto TYPE spfli-cityto,
  carrname TYPE scarr-carrname,
      END OF ty2_salida.

*&---------------------------------------------------------------------*
*& DECLARACION DE TABLAS INTERNAS
*&---------------------------------------------------------------------*
DATA: it2_sflight TYPE TABLE OF ty2_sflight,
      it2_spfli   TYPE TABLE OF ty2_spfli,
      it2_scarr   TYPE TABLE OF ty2_scarr,
      it2_salida  TYPE TABLE OF ty2_salida.
*&---------------------------------------------------------------------*
*& DECLARACION DE ESTRUCTURAS
*&---------------------------------------------------------------------*
DATA: wa2_sflight TYPE ty2_sflight,
      wa2_spfli   TYPE ty2_spfli,
      wa2_scarr   TYPE ty2_scarr,
      wa2_salida  TYPE ty2_salida.
*&---------------------------------------------------------------------*
*& SELECT-OPTIONS
*&---------------------------------------------------------------------*
* Acceder a la tabla SFLIGHT con FLDATE = rango pantalla de selección, PRICE = rango pantalla de selección.
SELECT-OPTIONS: s_fldate FOR sflight-fldate,
                s_price FOR sflight-price.
*Luego con los resultados obtenidos en la selección anterior acceder a la tabla SPFLI con y recuperar carrid connid fldate price currency:
SELECT carrid connid fldate price currency
  FROM sflight
  INTO TABLE it2_sflight
  WHERE: fldate IN s_fldate,
         price IN s_price.

IF sy-subrc EQ 0.
  SORT: it2_sflight BY fldate.
ELSE.
  WRITE: 'No se encontraron fechas de vuelos y a ese precio'.
ENDIF.

*Luego con los resultados obtenidos en la selección anterior acceder a la tabla SPFLI con: CARRID = SFLIGHT- CARRID y CONNID = SFLIGHT- CONNID
SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO TABLE it2_spfli
  FOR ALL ENTRIES IN it2_sflight
  WHERE carrid = it2_sflight-carrid AND
         connid = it2_sflight-connid.

IF sy-subrc EQ 0.
  SORT: it2_spfli BY carrid.
ELSE.
  WRITE: 'No se encontraron registros'.
ENDIF.

*Luego con los resultados obtenidos en la primera selección acceder a la tabla SCARR con: CARRID = SFLIGHT- CARRID
SELECT carrid carrname
  FROM scarr
  INTO TABLE it2_scarr
  FOR ALL ENTRIES IN it2_sflight
  WHERE carrid = it2_sflight-carrid.

"Luego completar la tabla principal recorriendo la primera y leyendo las otras en cada iteración."

LOOP AT it2_sflight INTO wa2_sflight.
  READ TABLE it2_spfli INTO wa2_spfli
  WITH KEY carrid = wa2_sflight-carrid
  BINARY SEARCH.

  READ TABLE it2_scarr INTO wa2_scarr
  WITH KEY carrid = wa2_sflight-carrid
  BINARY SEARCH.

  wa2_salida-carrid = wa2_sflight-carrid.
  wa2_salida-connid = wa2_sflight-connid.
  wa2_salida-fldate = wa2_sflight-fldate.
  wa2_salida-price  = wa2_sflight-price.
  wa2_salida-currency = wa2_sflight-currency.
  wa2_salida-cityfrom = wa2_spfli-cityfrom.
  wa2_salida-cityto = wa2_spfli-cityto.
  wa2_salida-carrname = wa2_scarr-carrname.

  APPEND wa2_salida TO it2_salida.
ENDLOOP.

LOOP AT it2_salida INTO wa2_salida.
  WRITE: / wa2_salida-carrid, wa2_salida-connid, wa2_salida-fldate, wa2_salida-price, wa2_salida-currency, wa2_salida-cityfrom, wa2_salida-cityto, wa2_salida-carrname.
ENDLOOP.
