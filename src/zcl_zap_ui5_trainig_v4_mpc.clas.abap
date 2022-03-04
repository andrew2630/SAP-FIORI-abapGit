class ZCL_ZAP_UI5_TRAINIG_V4_MPC definition
  public
  inheriting from /IWBEP/CL_V4_ABS_MODEL_PROV
  create public .

public section.

  types:
         TS_SUPPLIER type ZAP_ODATA_SUPPLIER .
  types:
    TT_SUPPLIER type standard table of TS_SUPPLIER .

  methods /IWBEP/IF_V4_MP_BASIC~DEFINE
    redefinition .
protected section.
private section.

  methods DEFINE_SUPPLIER
    importing
      !IO_MODEL type ref to /IWBEP/IF_V4_MED_MODEL
    raising
      /IWBEP/CX_GATEWAY .
ENDCLASS.



CLASS ZCL_ZAP_UI5_TRAINIG_V4_MPC IMPLEMENTATION.


  method /IWBEP/IF_V4_MP_BASIC~DEFINE.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 04.03.2022 16:35:10 in client 010
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZAP_UI5_TRAINIG_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*
  define_supplier( io_model ).
  endmethod.


  method DEFINE_SUPPLIER.
*&----------------------------------------------------------------------------------------------*
*&* This class has been generated on 04.03.2022 16:35:10 in client 010
*&*
*&*       WARNING--> NEVER MODIFY THIS CLASS <--WARNING
*&*   If you want to change the MPC implementation, use the
*&*   generated methods inside MPC subclass - ZCL_ZAP_UI5_TRAINIG_V4_MPC_EXT
*&-----------------------------------------------------------------------------------------------*

 DATA:
   lo_entity_type TYPE REF TO /iwbep/if_v4_med_entity_type,
   lo_property    TYPE REF TO /iwbep/if_v4_med_prim_prop,
   lo_entity_set  TYPE REF TO /iwbep/if_v4_med_entity_set,
   lv_supplier    TYPE zap_odata_supplier.
***********************************************************************************************************************************
*   ENTITY - Supplier
***********************************************************************************************************************************

 lo_entity_type = io_model->create_entity_type_by_struct( iv_entity_type_name = 'SUPPLIER' is_structure = lv_supplier
                                                          iv_add_conv_to_prim_props = abap_true ). "#EC NOTEXT
 lo_entity_type->set_edm_name( 'Supplier' ).                "#EC NOTEXT

***********************************************************************************************************************************
*   Properties
***********************************************************************************************************************************
 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'SUPPLIER_ID' ). "#EC NOTEXT
 lo_property->set_edm_name( 'SupplierID' ).                 "#EC NOTEXT
 lo_property->set_is_key( ).
 lo_property->set_edm_type( iv_edm_type = 'Int16' ).        "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'COMPANY_NAME' ). "#EC NOTEXT
 lo_property->set_edm_name( 'CompanyName' ).                "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '100' ).      "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'ADDRESS' ). "#EC NOTEXT
 lo_property->set_edm_name( 'Address' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '100' ).      "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'CITY' ). "#EC NOTEXT
 lo_property->set_edm_name( 'City' ).                       "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '40' ).       "#EC NOTEXT

 lo_property = lo_entity_type->create_prim_property( iv_property_name = 'COUNTRY' ). "#EC NOTEXT
 lo_property->set_edm_name( 'Country' ).                    "#EC NOTEXT
 lo_property->set_edm_type( iv_edm_type = 'String' ).       "#EC NOTEXT
 lo_property->set_max_length( iv_max_length = '20' ).       "#EC NOTEXT


***********************************************************************************************************************************
*   ENTITY SETS
***********************************************************************************************************************************
 lo_entity_set = lo_entity_type->create_entity_set( 'SUPPLIERSET' ). "#EC NOTEXT
 lo_entity_set->set_edm_name( 'SupplierSet' ).              "#EC NOTEXT
  endmethod.
ENDCLASS.
