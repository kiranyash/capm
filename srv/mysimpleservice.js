const myservice = function ( srv ){
    srv.on('myfunction',(req,res )=> {

        return "Anubhav" + req.data.msg;

    });
}
module.exports = myservice;