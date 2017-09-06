const express = require('express');
const db = require('./db');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.json());

app.get('/', function(request, response) {
  response.send('chain /machines with the id, or snacks and/or  /purchaseHistory to get the specific info. Use the machines/ the id + /snackTime to buy a snack.');
});

app.get('/', (req, res) => {
  res.redirect('/api/machine')
})

app.get('/api/machine', (req, res) =>{
  db.query('SELECT * FROM machine', (err, dbresponse)=>{
    if (err){
      return (err)
    }
    res.json({machine:dbresponse.rows})
  })
})

app.get('/api/machine/:machine_id', (req,res)=>{
  db.query('SELECT * FROM machine where machine_id =$1', [req.params.machine_id],(err,dbresponse)=>{
    if(err){
      return (err)
    }
    res.json({thisMachine: dbresponse.rows })
  })
})

app.get('/api/machine/:machine_id/transactions',(req,res) =>{
  console.log(req.params.machine_id);
  db.query('SELECT * FROM purchase WHERE machine_id =$1', [req.params.machine_id], (err,dbresponse)=>{
    if(err){
      return next(err)
    }
    res.json({transactionHistory:dbresponse.rows})
  })
})

app.post('/api/machine/:machine_id/purchase', (req,res)=>{
    var date = new Date();
    var payment = req.body.amount_taken
    var machine_id = req.params.machine_id
    var item_id = req.body.item_id

  db.query('SELECT cost FROM item WHERE item_id =$1',[req.body.item_id], (err, dbresponse)=>{
    console.log("the error is:", err);
    var price = dbresponse.rows[0].cost;
    var change = payment - price;
    if(payment < price){
      res.json({status:'Failed', money_given:payment, cost:price})
    }else{
      db.query('INSERT INTO purchase(purchase_time, amount_taken,change_given, machine_id, item_id) VALUES($1, $2, $3, $4, $5)',[date, payment, change, machine_id, item_id ], (err, dbresponse)=>{
        console.log(err);
        res.json({status:'Enjoy your purchase'})
      })
    }
  })
})

app.listen(3000, function() {
  console.log('Vending server');
});
