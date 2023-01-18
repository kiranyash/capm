          
using {anuv.db.CDSView1} from '../db/CDSView';
using {
    anuv.db.master,
    anuv.db.transaction
} from '../db/mydatamodel';

service CDSServices @(path : '/CDSService') {
    
    entity  PoWorklist as projection on CDSView1.POworklist;
    entity  productOrders as projection on CDSView1.productViewSub;

}


