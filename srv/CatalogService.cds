using {
    anuv.db.master,
    anuv.db.transaction
} from '../db/mydatamodel';

service CatalogService @(path: '/catalogservice') {
    entity businesspartner                   as projection on master.businesspartner;
    entity address                           as projection on master.address;
    entity product                           as projection on master.product;
    entity employee                          as projection on master.employee;

    entity POs @( title: '{ i18n>poheader }' ) as projection on transaction.purchaseorder {
        *,
        items : redirected to POitems
    }

    entity POitems @( title: '{i18n>poitem}') as projection on transaction.po_item {
        *,
        PARENT_KEY : redirected to POs,
        PRODUCT_GUID: redirected to product

    }
    

}
