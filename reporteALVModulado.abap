*&---------------------------------------------------------------------*
*& Report  ZUSER09_CLIENTES
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT  ZUSER09_CLIENTES.

INCLUDE ZUSER09_CLIENTES_TOP.
INCLUDE ZUSER09_CLIENTES_FORMS.

INITIALIZATION.
START-OF-SELECTION.

PERFORM f_buscar_datos.

*1)	Se requiere imprimir en pantalla los campos KUNNR, RAZON, ZOBSERVCLI de la tabla clientes.

PERFORM f_completar_fieldcat.
PERFORM F_mostrar_alv.

END-OF-SELECTION.
