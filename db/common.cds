namespace  anuv.db;
type phone_no:String(30) @assert.format : '';
type email:String(255)@assert.format : '';

type AmountT : Decimal(15,2)@(
    semantic.Amount.CURRENCY_CODE:'CURRENCY_CODE' ,
    Sap.unit:'CURRENCY_CODE' 
);
