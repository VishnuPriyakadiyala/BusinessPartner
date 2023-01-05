CLASS zcm_businesspartner DEFINITION
   PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_abap_behv_message .
    INTERFACES if_t100_message .
    INTERFACES if_t100_dyn_msg .


    METHODS constructor
      IMPORTING
        severity TYPE if_abap_behv_message=>t_severity DEFAULT if_abap_behv_message=>severity-error
        textid   LIKE if_t100_message=>t100key OPTIONAL
        previous TYPE REF TO cx_root OPTIONAL
        currency TYPE waers_curc OPTIONAL
        net      TYPE string OPTIONAL.

    CONSTANTS: BEGIN OF invalid_create,
                 msgid TYPE symsgid VALUE 'ZREP_MSGCLASS',
                 msgno TYPE symsgno VALUE '004',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_create.
    CONSTANTS: BEGIN OF invalid_update,
                 msgid TYPE symsgid VALUE 'ZREP_MSGCLASS',
                 msgno TYPE symsgno VALUE '005',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_update.
    CONSTANTS: BEGIN OF invalid_delete,
                 msgid TYPE symsgid VALUE 'ZREP_MSGCLASS',
                 msgno TYPE symsgno VALUE '006',
                 attr1 TYPE scx_attrname VALUE '',
                 attr2 TYPE scx_attrname VALUE '',
                 attr3 TYPE scx_attrname VALUE '',
                 attr4 TYPE scx_attrname VALUE '',
               END OF invalid_delete.
    DATA:currency TYPE waers_curc READ-ONLY.
    DATA:net TYPE string READ-ONLY.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_businesspartner IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
    me->if_abap_behv_message~m_severity = severity.
    me->currency = currency.
    me->net = net.
  ENDMETHOD.



ENDCLASS.
