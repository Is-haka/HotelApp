const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');
const app = express();
const port = 3001;

app.use(cors());
app.use(bodyParser.json());

// MySQL connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '', // replace with your MySQL password
  database: 'hotel_api',
});

connection.connect((err) => {
  if (err) throw err;
  console.log('Connected to MySQL database.');
});



// test if its work.....
app.get('/',(req, res)=>{
    res.send("SERVER IS UNDER MAINTANANCE..")
})

// API Endpoints

// Get all regions

// app.get('/api/regions', async (req , res)=>{
//   const sql =  await 'SELECT * FROM region';
//   connection.query(sql, (err, result)=>{
//        if(err){
//         console.log(err);
//        }else{
//         res.send(result);
//        }
//   })
// })

// Get all regions

app.get('/api/regions', (req, res) => {
  connection.query('SELECT * FROM region', (err, results) => {
    if (err) throw err;
    res.json(results);
  });
});



// Insert a new region
// app.post('/api/regions', (req, res) => {
//   const { name } = req.body;
//   connection.query('INSERT INTO region (name) VALUES (?)', [name], (err, results) => {
//     if (err) throw err;
//     res.status(201).json({ id: results.insertId, name });
//   });
// });

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
