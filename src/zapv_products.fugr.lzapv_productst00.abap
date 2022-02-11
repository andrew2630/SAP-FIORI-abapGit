*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 11.02.2022 at 19:07:35
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAPV_PRODUCTS...................................*
TABLES: ZAPV_PRODUCTS, *ZAPV_PRODUCTS. "view work areas
CONTROLS: TCTRL_ZAPV_PRODUCTS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZAPV_PRODUCTS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAPV_PRODUCTS.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAPV_PRODUCTS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAPV_PRODUCTS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_PRODUCTS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAPV_PRODUCTS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAPV_PRODUCTS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_PRODUCTS_TOTAL.

*.........table declarations:.................................*
TABLES: ZAP_PRODUCTS                   .
