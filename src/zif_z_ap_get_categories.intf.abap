interface ZIF_Z_AP_GET_CATEGORIES
  public .


  types:
    TEXT40 type C length 000040 .
  types:
    TEXT100 type C length 000100 .
  types:
    WERT8 type P length 8  decimals 000002 .
  types:
    TEXT20 type C length 000020 .
  types:
    begin of ZAP_ODATA_SUPPLIER,
      SUPPLIER_ID type INT2,
      COMPANY_NAME type TEXT100,
      ADDRESS type TEXT100,
      CITY type TEXT40,
      COUNTRY type TEXT20,
    end of ZAP_ODATA_SUPPLIER .
  types:
    ZAP_ODATA_SUPPLIERS            type standard table of ZAP_ODATA_SUPPLIER             with non-unique default key .
  types:
    begin of ZAP_ODATA_PRODUCT,
      PRODUCT_ID type INT2,
      PRODUCT_NAME type TEXT40,
      SUPPLIER_ID type INT2,
      CATEGORY_ID type INT2,
      UNIT_PRICE type WERT8,
      SUPPLIERS type ZAP_ODATA_SUPPLIERS,
    end of ZAP_ODATA_PRODUCT .
  types:
    ZAP_ODATA_PRODUCTS             type standard table of ZAP_ODATA_PRODUCT              with non-unique default key .
  types:
    begin of ZAP_ODATA_CATEGORY,
      CATEGORY_ID type INT2,
      CATEGORY_NAME type TEXT40,
      DESCRIPTION type TEXT100,
      PRODUCTS type ZAP_ODATA_PRODUCTS,
    end of ZAP_ODATA_CATEGORY .
  types:
    ZAP_ODATA_CATEGORIES           type standard table of ZAP_ODATA_CATEGORY             with non-unique default key .
endinterface.
