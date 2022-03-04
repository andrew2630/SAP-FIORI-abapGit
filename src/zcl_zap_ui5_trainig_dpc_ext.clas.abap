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
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zap_ui5_trainig_dpc_ext IMPLEMENTATION.


  METHOD productsset_get_entityset.

    CONSTANTS product_id_property TYPE string VALUE 'PRODUCT_ID'.
    CONSTANTS date_added_property TYPE string VALUE 'DATE_ADDED'.

    DATA(filter) = io_tech_request_context->get_filter( ).
    DATA(filter_select_options) = filter->get_filter_select_options( ).
    DATA(filter_string) = filter->get_filter_string( ).

    DATA(combined_filter) = ||.

    DATA(product_id_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = product_id_property ]-select_options
    OPTIONAL ).

    DATA(date_added_filters) = VALUE /iwbep/t_cod_select_options(
      filter_select_options[ property = date_added_property ]-select_options
    OPTIONAL ).

    TRY.
        combined_filter = cl_shdb_seltab=>combine_seltabs(
           it_named_seltabs = VALUE #(
            ( name = product_id_property dref = REF #( product_id_filters ) )
            ( name = date_added_property dref = REF #( date_added_filters ) )
           )
        ).
      CATCH cx_shdb_exception INTO DATA(ex).
    ENDTRY.

    IF strlen( combined_filter ) > 0.
      combined_filter = |{
        substring( val = combined_filter
                   len = strlen( combined_filter ) - 1 )
      } )|.
    ENDIF.

    SELECT * FROM zap_products INTO CORRESPONDING FIELDS OF TABLE @et_entityset
      WHERE (combined_filter).

  ENDMETHOD.


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
ENDCLASS.
