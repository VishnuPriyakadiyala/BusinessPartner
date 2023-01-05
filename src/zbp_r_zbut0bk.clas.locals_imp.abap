CLASS lhc_zbut0bk DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE ZBUT0BK.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE ZBUT0BK.

    METHODS read FOR READ
      IMPORTING keys FOR READ ZBUT0BK RESULT result.

    METHODS rba_Zbut000 FOR READ
      IMPORTING keys_rba FOR READ ZBUT0BK\_Zbut000 FULL result_requested RESULT result LINK association_links.

ENDCLASS.

CLASS lhc_zbut0bk IMPLEMENTATION.

  METHOD update.
    DATA:ls_but0bk TYPE zbut0bk.
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entities>).
      ls_but0bk = CORRESPONDING #(  <ls_entities> MAPPING FROM ENTITY USING CONTROL ).
      modify zbut0bk FROM @ls_but0bk.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid ) TO mapped-zbut0bk.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid  ) TO failed-zbut0bk.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_update
                                     )
       ) TO reported-zbut0bk.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD delete.
    DATA:ls_but0bk TYPE zbut0bk.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>).
      ls_but0bk-partner = <ls_keys>-Partner.
      ls_but0bk-bkvid = <ls_keys>-bkvid.
      DELETE zbut0bk FROM @ls_but0bk.
      IF sy-subrc IS INITIAL.
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid    ) TO mapped-zbut0bk.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid ) TO failed-zbut0bk.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( partner = ls_but0bk-partner
                        bkvid   = ls_but0bk-bkvid
                        %msg = NEW zcm_businesspartner(
                                    severity = if_abap_behv_message=>severity-error
                                    textid   = zcm_businesspartner=>invalid_delete
                                     )
       ) TO reported-zbut0bk.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD read.
    DATA:lt_but0bk TYPE STANDARD TABLE OF zbut0bk.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<ls_keys>)
    GROUP BY <ls_keys>-partner.

      SELECT  *
      FROM zbut0bk
      WHERE partner = @<ls_keys>-Partner
      INTO TABLE @lT_but0bk.
      IF sy-subrc IS INITIAL.
        LOOP AT GROUP <ls_keys> ASSIGNING FIELD-SYMBOL(<key>)
                                         GROUP BY <ls_keys>-%key.
          DATA(ls_but0bk) = VALUE #( lT_but0bk[  partner = <ls_keys>-%key-Partner
                                                 bkvid    = <ls_keys>-%key-bkvid ] OPTIONAL ).
          IF ls_but0bk IS NOT INITIAL.
            INSERT CORRESPONDING #( ls_but0bk MAPPING TO ENTITY ) INTO TABLE result.
          ELSE.
            "fill failed return structure for the framework
            APPEND VALUE #( partner = ls_but0bk-partner
                            bkvid   = ls_but0bk-bkvid
                            %fail-cause = if_abap_behv=>cause-not_found ) TO failed-zbut0bk.

          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDLOOP.


  ENDMETHOD.

  METHOD rba_Zbut000.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
