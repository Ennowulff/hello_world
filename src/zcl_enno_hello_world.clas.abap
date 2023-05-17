CLASS zcl_enno_hello_world DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
    INTERFACES z2ui5_if_app.
    data input_username type string.
    data input_date type d.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_enno_hello_world IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    out->write_text( |Hello World| ).
  ENDMETHOD.
  METHOD z2ui5_if_app~main.

    "event handling
    CASE client->get( )-event.
      WHEN 'BUTTON_POST'.
        client->popup_message_toast( |App executed on { input_Date DATE = USER } by { input_username }| ).
    ENDCASE.

    "view rendering
    client->set_next( VALUE #( xml_main = z2ui5_cl_xml_view=>factory(
        )->page( title = 'abap2UI5 - SAP Developer Code Challenge - Open Source ABAP'
            )->simple_form( title = 'Form Title' editable = abap_true
                )->content( 'form'
                    )->title( 'Input'
                    )->label( 'User'
                    )->input( client->_bind( input_username )
                    )->label( 'Date'
                    )->input( client->_bind( input_Date )
                    )->button( text  = 'post' press = client->_event( 'BUTTON_POST' )
         )->get_root( )->xml_get( ) ) ).
  ENDMETHOD.



ENDCLASS.
