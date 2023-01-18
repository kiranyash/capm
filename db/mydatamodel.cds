namespace anuv.db;
using { cuid } from '@sap/cds/common';


type guid : String(32);

context master {
    entity businesspartner {

        key node_key     : String(32);
            BP_role      : String(2);
            email_Add    : String(64);
            phone_no     : String(14);
            fax_no       : String(14);
            web_Add      : String(64);
            add_guid     : Association to address;
            bp_id        : String(16);
            company_name : String(80);
    }

    annotate master.businesspartner with {
        node_key @title : '{i18n/bp_key}';
        BP_role  @title : '{i18n/bp_role}'; 

    };

    entity address {

        key node_key        : String(32);
            city            : String(64);
            postal_code     : String(14);
            street          : String(64);
            building        : String(64);
            country         : String(2);
            val_Start_date  : Date;
            val_End_date    : Date;
            latitude        : Decimal;
            longitude       : Decimal;
            businesspartner : Association to one businesspartner
                                  on businesspartner.add_guid = $self;

    }

    entity product {

        key NODE_KEY        : guid;
            PRODUCT_ID      : String(28);
            TYPE_CODE       : String(2);
            CATEGORY        : String(32);
            DESC_GUID       : guid;
            description     : localized String(255);
            SUPPLIER_GUID   : Association to businesspartner;
            TAX_TARIF_CODE  : Integer;
            MEASURE_UNIT    : String(2);
            WEIGHT_MEASURE  : Decimal;
            WEIGHT_UNIT     : String(2);
            CURRENCY_CODE   : String(4);
            PRICE           : Decimal;
            PRODUCT_PIC_URL : String(255);
            WIDTH           : Decimal;
            DEPTH           : Decimal;
            HEIGHT          : Decimal;
            DIM_UNIT        : String(3);


    }
    entity employee:cuid {

        FullName      : String(40);	
        JobTitle      : String(40);
        Department    : String(40);	
        BusinessUnit  : String(40);
        Gender        : String(4);	
        Age           : Integer;	
        AnnualSalary  : Decimal;		
        Country       : String(40);	
        City          : String(40);
    }
}


context transaction {
    entity purchaseorder {
        key NODE_KEY         : guid;
            PO_ID            : String(24);
            PARTNER_GUID     : Association to master.businesspartner;
            CURRENCY_CODE    : String(4);
            GROSS_AMOUNT     : Decimal;
            NET_AMOUNT       : Decimal;
            TAX_AMOUNT       : Decimal;
            LIFECYCLE_STATUS : String(1);
            APPROVAL_STATUS  : String(1);
            CONFIRM_STATUS   : String(1);
            ORDERING_STATUS  : String(1);
            INVOICING_STATUS : String(1);
            OVERALL_STATUS   : String(1);
            items:Association to many po_item on items.PARENT_KEY = $self

    }

    entity po_item {
        key NODE_KEY      : guid;
            PARENT_KEY    : Association to purchaseorder;
            PO_ITEM_POS   : Integer;
            PRODUCT_GUID  : Association to  master.product;
            CURRENCY_CODE : String(4);
            GROSS_AMOUNT  : Decimal(15,2);
            NET_AMOUNT    : Decimal;
            TAX_AMOUNT    : Decimal;

    }
}
