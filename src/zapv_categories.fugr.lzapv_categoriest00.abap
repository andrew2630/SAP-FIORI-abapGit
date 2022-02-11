*---------------------------------------------------------------------*
*    view related data declarations
*   generation date: 11.02.2022 at 19:06:44
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
*...processing: ZAPV_CATEGORIES.................................*
TABLES: ZAPV_CATEGORIES, *ZAPV_CATEGORIES. "view work areas
CONTROLS: TCTRL_ZAPV_CATEGORIES
TYPE TABLEVIEW USING SCREEN '0001'.
DATA: BEGIN OF STATUS_ZAPV_CATEGORIES. "state vector
          INCLUDE STRUCTURE VIMSTATUS.
DATA: END OF STATUS_ZAPV_CATEGORIES.
* Table for entries selected to show on screen
DATA: BEGIN OF ZAPV_CATEGORIES_EXTRACT OCCURS 0010.
INCLUDE STRUCTURE ZAPV_CATEGORIES.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_CATEGORIES_EXTRACT.
* Table for all entries loaded from database
DATA: BEGIN OF ZAPV_CATEGORIES_TOTAL OCCURS 0010.
INCLUDE STRUCTURE ZAPV_CATEGORIES.
          INCLUDE STRUCTURE VIMFLAGTAB.
DATA: END OF ZAPV_CATEGORIES_TOTAL.

*.........table declarations:.................................*
TABLES: ZAP_CATEGORIES                 .
