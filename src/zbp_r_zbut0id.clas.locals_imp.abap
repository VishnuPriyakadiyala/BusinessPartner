CLASS lhc_zbut0id DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      update FOR MODIFY
        IMPORTING
          entities FOR UPDATE  zbut0id,
      delete FOR MODIFY
        IMPORTING
          keys FOR DELETE  zbut0id,
      read FOR READ
        IMPORTING
                  keys   FOR READ  zbut0id
        RESULT    result,
      rba_zbut000 FOR READ
        IMPORTING
                  keys_rba FOR READ  zbut0id\_zbut000
                    FULL result_requested
        RESULT    result
                    LINK association_links.
ENDCLASS.

CLASS lhc_zbut0id IMPLEMENTATION.
  METHOD update.
    DATA:ls_but0ID TYPE zbut0ID.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>).
      ls_but0ID = CORRESPONDING #(  <ls_entities> MAPPING FROM ENTITY USING CONTROL ).
      modify zbut0ID FROM @ls_but0ID.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( partner = ls_but0ID-partner
                        type    = ls_but0id-type  ) TO mapped-zbut0ID.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but0ID-partner
                        type    = ls_but0id-type  ) TO failed-zbut0ID.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but0ID-partner
                        type    = ls_but0id-type
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_update
                                     )
       ) TO reported-zbut0ID.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD delete.
    DATA:ls_but0id TYPE zbut0id.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>).
      ls_but0id-partner = <ls_keys>-Partner.
      ls_but0id-type = <ls_keys>-Type.
      DELETE zbut0id FROM @ls_but0id.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( partner = ls_but0id-partner
                        type    = ls_but0id-type    ) TO mapped-zbut0ID.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but0id-partner
                        type    = ls_but0id-type ) TO failed-zbut0ID.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but0id-partner
                        type    = ls_but0id-type
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_delete
                                     )
       ) TO reported-zbut0ID.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD read.
    DATA:lt_but0ID TYPE STANDARD TABLE OF zbut0ID.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>)
    GROUP BY <ls_keys>-partner.

      SELECT  *
      FROM zbut0ID
      WHERE partner = @<ls_keys>-Partner
      INTO TABLE @lT_but0ID.
      IF sy-subrc IS INITIAL.
        LOOP AT GROUP <ls_keys> ASSIGNING FIELD-SYMBOL(<key>)
                                         GROUP BY <ls_keys>-%key.
          DATA(ls_but0id) = VALUE #( lT_but0ID[  partner = <ls_keys>-%key-Partner
                                                 type    = <ls_keys>-%key-Type ] OPTIONAL ).
          IF ls_but0id IS NOT INITIAL.
            INSERT CORRESPONDING #( ls_but0ID MAPPING TO ENTITY ) INTO TABLE result.
          ELSE.
            "fill failed return structure for the framework
            APPEND VALUE #( partner = ls_but0ID-partner
                            type    = ls_but0id-type
                            %fail-cause = if_abap_behv=>cause-not_found ) TO failed-zbut0ID.

          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.
  METHOD rba_zbut000.
  ENDMETHOD.
ENDCLASS.
