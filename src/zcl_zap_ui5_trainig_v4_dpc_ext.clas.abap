CLASS zcl_zap_ui5_trainig_v4_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zap_ui5_trainig_v4_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.

    METHODS supplierset_read_list
        REDEFINITION .
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zap_ui5_trainig_v4_dpc_ext IMPLEMENTATION.


  METHOD supplierset_read_list.

    DATA to_do TYPE /iwbep/if_v4_requ_basic_list=>ty_s_todo_list.
    DATA keys TYPE zcl_zap_ui5_trainig_v4_mpc=>tt_supplier.
    DATA included_ids TYPE RANGE OF int2.
    DATA results TYPE zcl_zap_ui5_trainig_v4_mpc=>tt_supplier.

    io_request->get_todos( IMPORTING es_todo_list = to_do ).
    io_request->get_key_data( IMPORTING et_key_data = keys ).

    included_ids = VALUE #( FOR k IN keys
      ( sign = 'I' option = 'EQ' low = k-supplier_id )
    ).

    DATA(done_list) = VALUE /iwbep/if_v4_requ_basic_list=>ty_s_todo_process_list(
      key_data = abap_true
    ).

    DATA(where_clause) = ||.
    IF to_do-process-filter = abap_true.
      io_request->get_filter_osql_where_clause(
        IMPORTING ev_osql_where_clause = where_clause
      ).

      done_list-filter = abap_true.
    ENDIF.

    IF lines( included_ids ) > 0.
      SELECT * FROM zap_suppliers INTO CORRESPONDING FIELDS OF TABLE @results
        WHERE supplier_id IN @included_ids.
    ELSEIF where_clause IS NOT INITIAL.
      SELECT * FROM zap_suppliers INTO CORRESPONDING FIELDS OF TABLE @results
        WHERE (where_clause).
    ELSE.
      SELECT * FROM zap_suppliers INTO CORRESPONDING FIELDS OF TABLE @results.
    ENDIF.

    io_response->set_busi_data( it_busi_data = results ).
    io_response->set_is_done( done_list ).

  ENDMETHOD.


ENDCLASS.
