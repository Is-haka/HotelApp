const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
const cors = require('cors')
const app = express();
const port = 3001;

app.use(bodyParser.json());
app.use(cors());


// test if server is runing....
app.get('/',(req,res)=>{
        res.send("SERVER IS UNDER MAINTANANCE....")
})

// connect to dataBase
const db = mysql.createConnection({
  server: 'localhost',
  user:'root',
  password:'',
  database:'hotel_api'
});

// test if connect
if(db){
  console.log('Connection is successfull...');
}

//  insert data in the Server

// api = {http://localhost:3001/api/insert}
app.post('/api/insert', (req, res) => {
  const { book_no, bk_status, room, region_id, hotel_id, status} = req.body;

  const sql = `
    INSERT INTO booking (book_no, bk_status, room, region_id, hotel_id, status) VALUES (?, ?, ?, ?, ?, ?)`;

  db.query(sql, [book_no, bk_status, room, region_id, hotel_id, status], (err, result) => {
    if (err) {
      console.error('Error inserting data:', err);
      return res.status(500).send({ error: 'An error occurred while inserting data' });
    }
    console.log('Insert result:', result);
    res.status(201).send({ message: 'New row affected' });
  });
});


   // ApI to Select all Data

// api = {http://localhost:3001/api/all

app.get('/api/all',(req,res)=>{
  const sql ='SELECT * FROM `booking` WHERE 1';
  db.query(sql,(err, result)=>{
      // check if error
      if(err){
        console.log({err: err});
      } else {
        if(result.length > 0){
          console.log(result);
          res.send({result: result});
        }
      }
  })
})

   // ApI to Select all Data
   // api = {http://localhost:3001/api/single/:id <=
   app.get('/api/single/:id',(req,res)=>{


       let {id} = req. params;
    const sql ='SELECT * FROM `booking` WHERE id = ?';
    db.query(sql,[id],(err, result)=>{
        // check if error
        if(err){
          console.log({err: err});
        } else {
          //test if it return with its value
          if(result.length > 0){
            console.log(result);
            res.send({result: result});
          }

        }
    })
  })


app.listen(port, () => {
  console.log(`Server running on port: ${port}`);
});



// INSERT INTO `hotel` (`id`, `name`, `region_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (NULL, 'Bogota Hotel', '13', current_timestamp(), current_timestamp(), current_timestamp())


// INSERT INTO `booking` (`id`, `book_no`, `bk_status`, `room`, `region_id`, `hotel_id`, `start_date`, `end_date`, `status`, `created_at`, `updated_at`, `deleted_at`) VALUES (NULL, 'DKG-101', '1', 'Ordnary', '2', '4', current_timestamp(), current_timestamp(), '1', current_timestamp(), current_timestamp(), current_timestamp())
// INSERT INTO `hotel` (`id`, `name`, `region_id`, `created_at`, `updated_at`, `deleted_at`) VALUES (NULL, 'Bogota Hotel', '13', current_timestamp(), current_timestamp(), current_timestamp())


