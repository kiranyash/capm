namespace anuv.db;

using {
    anuv.db.master,
    anuv.db.transaction
} from './mydatamodel';

context CDSView1 {
    define view![POworklist] as
        select from transaction.purchaseorder {
            key PO_ID                         as![PurchaseOrder],
                PARTNER_GUID.bp_id            as![PartnerGuid],
                PARTNER_GUID.company_name     as![CompanyName],
                GROSS_AMOUNT                  as![GrossAmount],
                CURRENCY_CODE                 as![CurrencyCode],
            key items.PO_ITEM_POS             as![itemPostiton],
                items.PRODUCT_GUID            as![ProductGuid],
                PARTNER_GUID.add_guid.city    as![city],
                PARTNER_GUID.add_guid.country as![Country]
        };



define view productValueHelp as
    select from master.product {
        @EndUserText.label: [{
            Language: 'EN',
            text    : 'Product ID'
        }]
        PRODUCT_ID  as![productId],
        @EndUserText.label: [{
            Language: 'EN',
            text    : 'Product description'
        }]
        description as![description],
    };

define view![ItemView] as
    select from transaction.po_item {
        PARENT_KEY.PARTNER_GUID.node_key as![Partner],
        PRODUCT_GUID.NODE_KEY            as![ProductKey],
        CURRENCY_CODE                    as![Currecy],
        GROSS_AMOUNT                     as![Grossamount]
    };

define view productViewSub as
    select from master.product as prod {
        PRODUCT_ID    as ![productId],
        prod.NODE_KEY as ![NodeKey],
        (
            select from transaction.po_item as a {
                SUM(
                    a.GROSS_AMOUNT
                ) as sum:Decimal(10,2)
            }
            where
                a.PRODUCT_GUID.NODE_KEY = prod.NODE_KEY
        )             as po_sum:Decimal(10,2)

    };

define view productView as
    select from master.product
    mixin {
        po_order : Association[ * ] to ItemView
                       on po_order.ProductKey = $projection.ProductId;
    }
    into {
        NODE_KEY                   as![ProductId],
        description,
        CATEGORY                   as![category],
        PRICE                      as![Price],
        TYPE_CODE                  as![Typecode],
        SUPPLIER_GUID.bp_id        as![BP],
        SUPPLIER_GUID.add_guid.city,
        SUPPLIER_GUID.company_name as![company name],
        po_order,
    };
   define view CProductvalue as
        select from productView {
            ProductId,
            city,
            po_order.Currecy as![CurrencyCode],
            sum(po_order.Grossamount) as ![Grossamount]: Decimal(10,2)
        }
        group by
            ProductId,
            city,
            po_order.Currecy

}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               