*&---------------------------------------------------------------------*
*& Report  ZUSER09_PRACTICASF
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZUSER09_PRACTICASF.

INCLUDE ZUSER09_PRACTICASF_TOP.
INCLUDE ZUSER09_PRACTICASF_SCR.
INCLUDE ZUSER09_PRACTICASF_F01.

START-OF-SELECTION.
PERFORM f_seleccion_datos.
PERFORM f_imprimir_datos.
