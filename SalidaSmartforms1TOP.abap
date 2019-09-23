*&---------------------------------------------------------------------*
*&  Include           ZUSER09_PRACTICASF_TOP
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*&  TABLES:
*&---------------------------------------------------------------------*
TABLES: vbrk,kna1,vbrp.
*&---------------------------------------------------------------------*
*&  DECLARACION DE TIPOS
*&---------------------------------------------------------------------*
TYPES: BEGIN OF ty_vbrk,
vbeln TYPE vbrk-vbeln,
fkdat TYPE vbrk-fkdat,
kunag TYPE vbrk-kunag,
waerk TYPE vbrk-waerk,
  END OF ty_vbrk,

      BEGIN OF ty_kna1,
kunnr TYPE kna1-kunnr,
name1 TYPE kna1-name1,
stras TYPE kna1-stras,
ort01 TYPE kna1-ort01,
        END OF ty_kna1,

        BEGIN OF ty_vbrp,
vbeln TYPE vbrp-vbeln,
meins TYPE vbrp-meins,
fklmg TYPE vbrp-fklmg,
netwr TYPE vbrp-netwr,
matnr TYPE vbrp-matnr,
arktx TYPE vbrp-arktx,
mwsbp TYPE vbrp-mwsbp,
         END OF ty_vbrp.

*&---------------------------------------------------------------------*
*&  DECLARACION DE TABLAS INTERNAS
*&---------------------------------------------------------------------*
DATA: it_vbrk    TYPE TABLE OF ty_vbrk,
      it_kna1    TYPE TABLE OF ty_kna1,
      it_vbrp    TYPE TABLE OF ty_vbrp,
      it_final1  TYPE TABLE OF zst_final1,
      it_final2  TYPE TABLE OF zst_final2,
      it_tablaf2 TYPE TABLE OF ztt_final2. "TABLA MAIN"
*&---------------------------------------------------------------------*
*&  DECLARACION DE VARIABLES GLOBALES
*&---------------------------------------------------------------------*
DATA: wa_vbrk      TYPE ty_vbrk,
      wa_kna1      TYPE ty_kna1,
      wa_vbrp      TYPE ty_vbrp,
      wa_final1    TYPE zst_final1,
      wa_final2    TYPE zst_final2,
      wa2_tablaf2  TYPE ztt_final2, "TABLA MAIN"
     wa_ztt_final2 TYPE zst_final2,
     l_funcion  TYPE rs38l_fnam.
