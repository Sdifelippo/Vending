const express = require('express');
const db = require('./db');
const bodyParser = require('body-parser');

const app = express();

app.use(bodyParser.json());



app.get('/', (request, response) => {
  response.redirect('/api/machine')
})

app.get('/machine', (request, response) =>{
  db.query('SELECT * FROM machine', (err, dbresponse)=>{
    if (err){
      return (err)
    }
    response.json({machines:dbresponse.rows})
  })
})

app.get('/api/machine/:machine_id', (request,response)=>{
  db.query('SELECT * FROM machine where machine_id =$1', [request.params.machine_id],(err,dbresponse)=>{
    if(err){
      return (err)
    }
    response.json({thisMachine: dbresponse.rows })
  })
})

app.get('/api/machine/:machine_id/sale',(request,response) =>{
  console.log(request.params.machine_id);
  db.query('SELECT * FROM purchase WHERE machine_id =$1', [request.params.machine_id], (err,dbresponse)=>{
    if(err){
      return (err)
    }
    response.json({saleHistory:dbresponse.rows})
  })
})

app.post('/api/machine/:machine_id/purchase', (request,response)=>{
    var date = new Date();
    var payment = request.body.amount_taken
    var machine_id = request.params.machine_id
    var item_id = request.body.item_id

  db.query('SELECT cost FROM item WHERE item_id =$1',[request.body.item_id], (err, dbresponse)=>{
    console.log("error is:", err);
    var price = dbresponse.rows[0].cost;
    var change = payment - price;
    if(payment < price){
      response.json({status:'Failed', money_given:payment, cost:price})
    }else{
      db.query('INSERT INTO purchase(purchase_time, amount_taken,change_given, machine_id, item_id) VALUES($1, $2, $3, $4, $5)',[date, payment, change, machine_id, item_id ], (err, dbresponse)=>{
        console.log(err);
        response.json({status:'Enjoy your tasty snacks'})
      })
    }
  })
})

app.listen(3000, function() {
  console.log('Vending machine here to take your money');
});
