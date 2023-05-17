CLASS zcl_enno_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_enno_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write_text( |Hello World| ).
  ENDMETHOD.
ENDCLASS.
