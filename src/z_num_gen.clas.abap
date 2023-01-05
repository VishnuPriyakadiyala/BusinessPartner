CLASS z_num_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

PUBLIC SECTION.
 INTERFACES if_oo_adt_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.



CLASS z_num_gen IMPLEMENTATION.


METHOD if_oo_adt_classrun~main.
     DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
      DATA: LV_JO TYPE CHAR10 .
      DATA: LV_JO_OPT TYPE CHAR10.
TRY.
      CALL METHOD cl_numberrange_runtime=>number_get
        EXPORTING
*         ignore_buffer     =
          nr_range_nr = '01'
          object      = 'ZBPPART'
*          quantity    = 00000000000000000001
*         subobject   =
*         toyear      =
        IMPORTING
          number      = nr_number.
*     returncode        =
*     returned_quantity =

    CATCH cx_nr_object_not_found.
    CATCH cx_number_ranges.
  ENDTRY.
    LV_JO =  |{ nr_number ALPHA = out }|.
   LV_JO_OPT = |{ LV_JO ALPHA = in }|.
   out->write( LV_JO_OPT ).

 ENDMETHOD.
ENDCLASS.
