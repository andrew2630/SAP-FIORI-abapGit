FUNCTION z_ap_get_categories.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CATEGORY_ID) TYPE  INT2
*"  EXPORTING
*"     VALUE(RESULTS) TYPE  ZAP_ODATA_CATEGORIES
*"----------------------------------------------------------------------


  DATA(clause) = | category_id { COND #( WHEN category_id > 0
                                 THEN |= @category_id|
                                 ELSE |> 0| ) }|.

  SELECT * FROM zap_categories INTO CORRESPONDING FIELDS OF TABLE @results
  WHERE (clause).

ENDFUNCTION.
