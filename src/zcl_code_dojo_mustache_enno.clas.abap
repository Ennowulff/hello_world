CLASS zcl_code_dojo_mustache_enno DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .


  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.

    TYPES:
      BEGIN OF _task,
        name TYPE string,
        time TYPE i,
      END OF _task,
      _tasks TYPE STANDARD TABLE OF _task WITH EMPTY KEY,
      BEGIN OF _attendee,
        name   TYPE string,
        points TYPE i,
        tasks  TYPE _tasks,
      END OF _attendee,
      _attendees_tt TYPE STANDARD TABLE OF _attendee WITH DEFAULT KEY,


      BEGIN OF _course,
        course_name TYPE string,
        attendees   TYPE _attendees_tt,
      END OF _course.

    DATA course TYPE _course.

    METHODS get_course_template
      RETURNING
        VALUE(r_result) TYPE string.
    METHODS get_course
      RETURNING
        VALUE(r_result) TYPE _course.
    METHODS bind_template
      IMPORTING
        i_html_template TYPE string
        i_data          TYPE zcl_code_dojo_mustache_enno=>_course
      RETURNING
        VALUE(r_result) TYPE string.

ENDCLASS.



CLASS zcl_code_dojo_mustache_enno IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(html_template) = get_course_template( ).
    DATA(attendees) = get_course( ).
    DATA(output)     = bind_template(
     i_html_template = html_template
     i_data          = attendees ).

    " run with F9
    out->write( output ).
  ENDMETHOD.


  METHOD get_course_template.
    DATA(c_nl) = cl_abap_char_utilities=>newline.

    r_result  = 'Welcome to {{course_name}}!'    && c_nl &&
                '{{#attendees}}'                 && c_nl &&
                '* {{name}} - {{points}} points' && c_nl &&
                '{{#tasks}}' && c_nl &&
                '** {{name}} - {{time}} minutes' && c_nl &&
                '{{/tasks}}' && c_nl &&
                '{{/attendees}}'.
  ENDMETHOD.


  METHOD get_course.
    r_result = VALUE #( course_name = `Code Dojo`
                        attendees       = VALUE #(
                            ( name      = `Ernie`
                              points    = 12
                              tasks     = VALUE #(
                                 ( name = 'install abapGit ADT plugin' time = 10 )
                                 ( name = 'pull Mustache repo' time = 5 ) ) )
                            ( name      = `Enno` points = 17
                              tasks     = VALUE #(
                                 ( name = 'Create class' time = 1 )
                                 ( name = 'copy example' time = 10 ) ) )
                            ( name      = `Erwin` points = 3
                              tasks     = VALUE #(
                                 ( name = 'Create course structrue type' time = 11 )
                                 ( name = 'Adapt template' time = 10 )
                                 ( name = 'Push repo' time = 8 ) ) )
                             ) ).
  ENDMETHOD.


  METHOD bind_template.
    TRY.
        DATA(mustache) = zcl_mustache=>create( i_html_template ).
        r_result = mustache->render( i_data ).
      CATCH zcx_mustache_error INTO DATA(error).
        r_result = error->get_text( ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
