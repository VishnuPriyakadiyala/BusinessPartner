CLASS lhc_zbut000 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR zbut000
        RESULT result,
      create FOR MODIFY
        IMPORTING
          entities FOR CREATE  zbut000,
      update FOR MODIFY
        IMPORTING
          entities FOR UPDATE  zbut000,
      delete FOR MODIFY
        IMPORTING
          keys FOR DELETE  zbut000,
      lock FOR LOCK
        IMPORTING
          keys FOR LOCK  zbut000,
      read FOR READ
        IMPORTING
                  keys   FOR READ  zbut000
        RESULT    result,
      cba_zbut0bk FOR MODIFY
        IMPORTING
          entities_cba FOR CREATE  zbut000\_zbut0bk,
      rba_zbut0bk FOR READ
        IMPORTING
                  keys_rba FOR READ  zbut000\_zbut0bk
                    FULL result_requested
        RESULT    result
                    LINK association_links,
      cba_zbut0id FOR MODIFY
        IMPORTING
          entities_cba FOR CREATE  zbut000\_zbut0id,
      rba_zbut0id FOR READ
        IMPORTING
                  keys_rba FOR READ  zbut000\_zbut0id
                    FULL result_requested
        RESULT    result
                    LINK association_links.
ENDCLASS.

CLASS lhc_zbut000 IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD create.
    DATA:ls_but000 TYPE zbut000.
    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>).
      ls_but000 = CORRESPONDING #(  <ls_entities> MAPPING FROM ENTITY USING CONTROL ).

      TRY.
          CALL METHOD cl_numberrange_runtime=>number_get
            EXPORTING
              nr_range_nr = '01'
              object      = 'ZBPPART'
            IMPORTING
              number      = nr_number.
          IF nr_number IS NOT INITIAL.
            ls_but000-partner = nr_number+11(9).
          ENDIF.
        CATCH cx_nr_object_not_found.
        CATCH cx_number_ranges.
      ENDTRY.

      INSERT zbut000 FROM @ls_but000.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( %cid =  <ls_entities>-%cid
                        partner = ls_but000-partner ) TO mapped-zbut000.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but000-partner ) TO failed-zbut000.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but000-partner
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_create
                                     )
       ) TO reported-zbut000.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD update.
    DATA:ls_but000 TYPE zbut000.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>).
      ls_but000 = CORRESPONDING #(  <ls_entities> MAPPING FROM ENTITY USING CONTROL ).
      MODIFY zbut000 FROM @ls_but000.
      IF sy-subrc IS INITIAL.
*        APPEND VALUE #( partner = ls_but000-partner ) TO mapped-zbut000.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but000-partner ) TO failed-zbut000.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but000-partner
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_update
                                     )
       ) TO reported-zbut000.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD delete.
    DATA:ls_but000 TYPE zbut000.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>).

      ls_but000 = CORRESPONDING #(  <ls_keys> MAPPING FROM ENTITY  ).
      DELETE zbut000 FROM @ls_but000.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( partner = ls_but000-partner ) TO mapped-zbut000.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but000-partner ) TO failed-zbut000.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but000-partner
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_delete
                                     )
       ) TO reported-zbut000.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD lock.
  ENDMETHOD.
  METHOD read.

    DATA:lt_but000 TYPE STANDARD TABLE OF zbut000.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>).

      SELECT SINGLE *
      FROM zbut000
      WHERE partner = @<ls_keys>-Partner
      INTO @DATA(ls_but000).
      IF sy-subrc IS INITIAL.
        INSERT CORRESPONDING #( ls_but000 MAPPING TO ENTITY ) INTO TABLE result.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but000-partner ) TO failed-zbut000.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but000-partner
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_delete
                                     )
       ) TO reported-zbut000.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
  METHOD cba_zbut0bk.
    DATA:ls_zbut0bk TYPE zbut0bk.
    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<ls_entities_cba>).
      DATA(lv_partner) = <ls_entities_cba>-Partner.
      SELECT *
      FROM zbut0bk
      WHERE partner = @lv_partner
      INTO TABLE @DATA(lt_but0bk).
      IF sy-subrc IS INITIAL.
        DATA(lv_bkvid) = lt_but0bk[ lines( lt_but0bk ) ]-bkvid.
      ENDIF.

      LOOP AT <ls_entities_cba>-%target ASSIGNING FIELD-SYMBOL(<entity>).
        ls_zbut0bk = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
        lv_bkvid += 1.
        ls_zbut0bk-bkvid = lv_bkvid.
        MODIFY zbut0bk FROM @ls_zbut0bk.
        IF sy-subrc IS INITIAL.
          APPEND VALUE #( %cid =  <entity>-%cid
                          partner = lv_partner
                          bkvid   = lv_bkvid ) TO mapped-zbut0bk.
        ELSE.
          "fill failed return structure for the framework
          APPEND VALUE #( partner = lv_partner ) TO failed-zbut0bk.
          "fill reported structure to be displayed on the UI
          APPEND VALUE #( partner = lv_partner
                          %msg = NEW zcm_businesspartner(
                                      severity = if_abap_behv_message=>severity-error
                                      textid   = zcm_businesspartner=>invalid_create
                                       )
         ) TO reported-zbut0bk.
        ENDIF.
      ENDLOOP.

    ENDLOOP.


  ENDMETHOD.
  METHOD rba_zbut0bk.
    DATA: ls_result LIKE LINE OF result.
    LOOP AT keys_rba ASSIGNING FIELD-SYMBOL(<ls_key_rba>).
      SELECT *
      FROM zbut0bk
      WHERE partner = @<ls_key_rba>-Partner
      INTO TABLE @DATA(lt_but0bk).
      IF sy-subrc IS INITIAL.
        LOOP AT lt_but0bk ASSIGNING FIELD-SYMBOL(<ls_but0bk>).
          INSERT VALUE #( source-%key = <ls_key_rba>-%key
                          target-%key = VALUE #( Partner = <ls_but0bk>-partner
                                                 bkvid   = <ls_but0bk>-bkvid ) ) INTO TABLE association_links.

          IF result_requested = abap_true.
            ls_result = CORRESPONDING #( <ls_but0bk> MAPPING TO ENTITY ).
            INSERT ls_result INTO TABLE result.
          ENDIF.
        ENDLOOP.
      ELSE.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD cba_zbut0id.
    DATA: ls_zbut0id TYPE zbut0id.
    LOOP AT entities_cba ASSIGNING FIELD-SYMBOL(<ls_entities_cba>).
      DATA(lv_partner) = <ls_entities_cba>-Partner.
      SELECT MAX( type )
      FROM zbut0id
      WHERE partner = @lv_partner
      INTO @DATA(lv_type).
      LOOP AT <ls_entities_cba>-%target ASSIGNING FIELD-SYMBOL(<entity>).
        ls_zbut0id = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
        ls_zbut0id-type = lv_type + 1.
        MODIFY zbut0id FROM @ls_zbut0id.
        IF sy-subrc IS INITIAL.
          APPEND VALUE #( %cid =  <entity>-%cid
                          partner = ls_zbut0id-partner
                          type    = ls_zbut0id-type ) TO mapped-zbut0ID.
        ELSE.
          "fill failed return structure for the framework
          APPEND VALUE #( partner = lv_partner ) TO failed-zbut0bk.
          "fill reported structure to be displayed on the UI
          APPEND VALUE #( partner = lv_partner
                          %msg = NEW zcm_businesspartner(
                                      severity = if_abap_behv_message=>severity-error
                                      textid   = zcm_businesspartner=>invalid_create
                                       )
         ) TO reported-zbut0bk.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.
  METHOD rba_zbut0id.
    DATA: ls_result LIKE LINE OF result.
    LOOP AT keys_rba ASSIGNING FIELD-SYMBOL(<ls_key_rba>).
      SELECT *
      FROM zbut0id
      WHERE partner = @<ls_key_rba>-Partner
      INTO TABLE @DATA(lt_but0id).
      IF sy-subrc IS INITIAL.
        LOOP AT lt_but0id ASSIGNING FIELD-SYMBOL(<ls_but0id>).
          INSERT VALUE #( source-%key = <ls_key_rba>-%key
                          target-%key = VALUE #( Partner = <ls_but0id>-partner
                                                 Type    = <ls_but0id>-type ) ) INTO TABLE association_links.

          IF result_requested = abap_true.
            ls_result = CORRESPONDING #( <ls_but0id> MAPPING TO ENTITY ).
            INSERT ls_result INTO TABLE result.
          ENDIF.
        ENDLOOP.
      ELSE.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_zr_zbut000tp DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
    METHODS:
      finalize REDEFINITION,
      check_before_save REDEFINITION,
      save REDEFINITION,
      cleanup REDEFINITION,
      cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lcl_zr_zbut000tp IMPLEMENTATION.
  METHOD finalize.
  ENDMETHOD.
  METHOD check_before_save.
  ENDMETHOD.
  METHOD save.
* /* This is a commit save
    IF sy-subrc IS INITIAL.
    ENDIF.
  ENDMETHOD.
  METHOD cleanup.
  ENDMETHOD.
  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
