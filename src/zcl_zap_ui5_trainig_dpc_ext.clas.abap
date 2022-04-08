CLASS zcl_zap_ui5_trainig_dpc_ext DEFINITION
  PUBLIC
  INHERITING FROM zcl_zap_ui5_trainig_dpc
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset
        REDEFINITION .
  PROTECTED SECTION.

    METHODS productsset_get_entityset
        REDEFINITION .
    METHODS productsset_create_entity
        REDEFINITION .
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zap_ui5_trainig_dpc_ext IMPLEMENTATION.


  METHOD /iwbep/if_mgw_appl_srv_runtime~get_expanded_entityset.

    DATA results TYPE zap_odata_categories.
    DATA included_categories TYPE RANGE OF int2.
    DATA products TYPE zap_odata_products.

    DATA(filter) = io_tech_request_context->get_filter( ).
    DATA(filter_select_options) = filter->get_filter_select_options( ).
    DATA(filter_string) = filter->get_filter_string( ).

    " FIXME: use cl_shdb_seltab=>combine_seltabs with filter_select_options instead
    SELECT * FROM zap_categories INTO CORRESPONDING FIELDS OF TABLE @results
      WHERE (filter_string).

    included_categories = VALUE #( FOR r IN results
      ( sign = 'I' option = 'EQ' low = r-category_id )
    ).

    IF lines( included_categories ) > 0.
      SELECT * FROM zap_products INTO CORRESPONDING FIELDS OF TABLE @products
        WHERE category_id IN @included_categories.

      LOOP AT results REFERENCE INTO DATA(result).
        result->products = CORRESPONDING #( VALUE zap_odata_products(
          FOR p IN products WHERE ( category_id = result->category_id ) ( p )
        ) ).
      ENDLOOP.
    ENDIF.

    APPEND 'PRODUCTS' TO et_expanded_tech_clauses.

    copy_data_to_ref( EXPORTING is_data = results
                      CHANGING cr_data = er_entityset ).

  ENDMETHOD.


  METHOD productsset_create_entity.

    DATA product TYPE zcl_zap_ui5_trainig_mpc_ext=>ts_products.

    io_data_provider->read_entry_data( IMPORTING es_data = product ).

    DATA(message_container) = mo_context->get_message_container( ).

    DATA(product_to_add) = CORRESPONDING zap_products( product ).

    SELECT SINGLE MAX( product_id ) FROM zap_products INTO @DATA(max_id).

    product_to_add-mandt = sy-mandt.
    product_to_add-product_id = max_id + 1.
    product_to_add-date_added = sy-datum.

    MODIFY zap_products FROM product_to_add.

    IF sy-subrc = 0.
      message_container->add_message_text_only( iv_msg_type = 'S'
                                                iv_msg_text = 'Product successfully created'
                                                iv_add_to_response_header = abap_true ).
    ELSE.
      message_container->add_message_text_only( iv_msg_type = 'E'
                                                iv_msg_text = 'Error occurred while creating a product'
                                                iv_add_to_response_header = abap_true ).
    ENDIF.

    er_entity = CORRESPONDING #( product_to_add ).

  ENDMETHOD.


  METHOD productsset_get_entityset.

    CONSTANTS product_id_property TYPE string VALUE 'PRODUCT_ID'.
    CONSTANTS category_id_property TYPE string VALUE 'CATEGORY_ID'.
    CONSTANTS unit_price_property TYPE string VALUE 'UNIT_PRICE'.
    CONSTANTS date_added_property TYPE string VALUE 'DATE_ADDED'.
    CONSTANTS sorting_descending TYPE string VALUE 'desc'.

    DATA(filter) = io_tech_request_context->get_filter( ).
    DATA(filter_select_options) = filter->get_filter_select_options( ).
    DATA(filter_string) = filter->get_filter_string( ).

    DATA(combined_filter) = ||.

    DATA(product_id_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = product_id_property ]-select_options
    OPTIONAL ).

    DATA(category_id_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = category_id_property ]-select_options
    OPTIONAL ).

    DATA(unit_price_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = unit_price_property ]-select_options
    OPTIONAL ).

    DATA(date_added_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = date_added_property ]-select_options
    OPTIONAL ).

    TRY.
        combined_filter = cl_shdb_seltab=>combine_seltabs(
           it_named_seltabs = VALUE #(
            ( name = product_id_property dref = REF #( product_id_filters ) )
            ( name = category_id_property dref = REF #( category_id_filters ) )
            ( name = unit_price_property dref = REF #( unit_price_filters ) )
            ( name = date_added_property dref = REF #( date_added_filters ) )
           )
        ).
      CATCH cx_shdb_exception INTO DATA(ex).
    ENDTRY.

    REPLACE ALL OCCURRENCES OF '(' IN combined_filter WITH ' ( '.
    REPLACE ALL OCCURRENCES OF ')' IN combined_filter WITH ' ) '.

    SELECT * FROM zap_products INTO CORRESPONDING FIELDS OF TABLE @et_entityset
      WHERE (combined_filter).

    DATA(orderby) = io_tech_request_context->get_orderby( ).
    DATA(orders) = VALUE abap_sortorder_tab( FOR o IN orderby (
      name = o-property
      descending = xsdbool( o-order = sorting_descending )
    ) ).

    SORT et_entityset BY (orders).

  ENDMETHOD.
ENDCLASS.
