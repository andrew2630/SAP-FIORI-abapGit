*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 11.02.2022 at 19:08:51
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAPV_SUPPLIERS..................................*
TABLES: ZAPV_SUPPLIERS, *ZAPV_SUPPLIERS. "view work areas
CONTROLS: TCTRL_ZAPV_SUPPLIERS
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZAPV_SUPPLIERS. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAPV_SUPPLIERS.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAPV_SUPPLIERS_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAPV_SUPPLIERS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_SUPPLIERS_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAPV_SUPPLIERS_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAPV_SUPPLIERS.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_SUPPLIERS_TOTAL.

*.........table declarations:.................................*
TABLES: ZAP_SUPPLIERS                  .
