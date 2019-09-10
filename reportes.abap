*&---------------------------------------------------------------------*
*& Report  ZUSER09_EJ8VUELO
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  zuser09_ej8vuelo.

*&---------------------------------------------------------------------*
*& TRAIGO TABLA SPFLI
*&---------------------------------------------------------------------*
TABLES: spfli, scarr.

*&---------------------------------------------------------------------*
*& DECLARACION DE TIPOS
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty1_spfli,
      carrid TYPE spfli-carrid,
      connid TYPE spfli-connid,
    cityfrom TYPE spfli-cityfrom,
      cityto TYPE spfli-cityto,
  END OF ty1_spfli,

      BEGIN OF ty1_scarr,
      carrid TYPE scarr-carrid,
    carrname TYPE scarr-carrname,
  END OF ty1_scarr,

      BEGIN OF ty_mix,
      carrid TYPE spfli-carrid,
      connid TYPE spfli-connid,
    cityfrom TYPE spfli-cityfrom,
      cityto TYPE spfli-cityto,
    carrname TYPE scarr-carrname,
        END OF ty_mix.

*&---------------------------------------------------------------------*
*& DECLARACION DE TABLAS INTERNAS
*&---------------------------------------------------------------------*
DATA: it1_spfli TYPE TABLE OF ty1_spfli,
      it1_scarr TYPE TABLE OF ty1_scarr,
      it_mix TYPE TABLE OF ty_mix.

*&---------------------------------------------------------------------*
*& DECLARACION DE ESTRUCTURA
*&---------------------------------------------------------------------*
DATA: wa1_spfli TYPE ty1_spfli,
      wa1_scarr TYPE ty1_scarr,
      wa_mix TYPE ty_mix.

*&---------------------------------------------------------------------*
*& SELECT-OPTIONS
*&---------------------------------------------------------------------*
SELECT-OPTIONS s_connid FOR spfli-connid.

SELECT carrid connid cityfrom cityto
  FROM spfli
  INTO TABLE it1_spfli
  WHERE connid IN s_connid.

IF sy-subrc = 0.
  SORT: it1_spfli BY connid.
ELSE.
  WRITE: 'No hay asignados numeros de vuelos'.
ENDIF.

SELECT carrid carrname
  FROM scarr
  INTO TABLE it1_scarr
  FOR ALL ENTRIES IN it1_spfli
  WHERE carrid = it1_spfli-carrid.

 IF sy-subrc = 0.
   SORT: it1_spfli by carrid.
   ELSE.
     WRITE: 'No hay compañias registradas'.
   ENDIF.

  SORT: it_mix by carrid.
   LOOP AT it1_spfli into wa1_spfli.
    " WRITE: / , wa1_spfli-carrid."
     CLEAR: wa1_scarr.
     READ TABLE it1_scarr into wa1_scarr
     WITH KEY carrid = wa1_spfli-carrid
     BINARY SEARCH.

     wa_mix-carrid = wa1_spfli-carrid.
     wa_mix-connid = wa1_spfli-connid.
     wa_mix-cityfrom = wa1_spfli-cityfrom.
     wa_mix-cityto = wa1_spfli-cityto.
     wa_mix-carrname = wa1_scarr-carrname.

     APPEND wa_mix to it_mix.
     WRITE: / wa_mix-carrid, wa_mix-connid, wa_mix-cityfrom, wa_mix-cityto, wa_mix-carrname.
     ENDLOOP.
