const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql");
const cors = require("cors"); // Import cors middleware

const server = express();

// Enable CORS for all origins
server.use(cors());

server.use(bodyParser.json());

// Establish a database connection
const connection = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "hotel_api",
});

// Check for connection
connection.connect(function (error) {
  if (error) {
    console.log("Error connecting to database");
  } else {
    console.log("Successfully connected to database");
  }
});

// Specify the port
server.listen(3000, function check(error) {
  if (error) {
    console.log("Error.....!!!");
  } else {
    console.log("Started...!!!");
  }
});


//post api to create a hotel
server.post("/hotel/create", (req,res)=>{
  let details = {
    name: req.body.name,
    region_id: req.body.region_id
  };

  let qry = "insert into hotel set ?";
  connection.query(qry,details,(error) =>{
    if (error) {
      res.send({ status: false, message: "Hotel failed to be added"});
    }
    res.send({ status: true, message: "Hotel added successful"});
  });

});

server.get("/hotel", (req,res) => {
  var qry = "select * from hotel";

    connection.query(qry, (error, result) => {
    if (error) {
      res.send({ status: false, message: "Hotel cannot be viewed" });
    } else {
      res.send({ status: true, data: result });
    }
  });

});

// PUT API to update a todo by ID
server.put("/hotel/update/:id", (req, res) => {
  var hotelId = req.params.id;
  var newName = req.body.name;

  var qry = "update hotel set name = ? where id = ?";
  connection.query(qry, [newName, hotelId], (error) => {
    if (error) {
      res.send({
        status: false,
        message: "Hotel update failed",
      });
    } else {
      res.send({ status: true, message: "Hotel updated successfully" });
    }
  });
});

// // GET API to view all todos
// server.get("/todo", (req, res) => {
//   var qry = "select * from todos";
// });

// // GET API to view a single todo by ID
// server.get("/todo/:id", (req, res) => {
//   const todoId = req.params.id;
//   const qry = "SELECT * FROM todos WHERE id = ?";
//   connection.query(qry, [todoId], (error, result) => {
//     if (error) {
//       res.status(500).send({
//         status: false,
//         message: "Todo with ID " + todoId + " cannot be viewed",
//       });
//     } else if (result.length > 0) {
//       res.send({ status: true, data: result[0] });
//     } else {
//       res.status(404).send({ status: false, message: "Todo not found" });
//     }
//   });
// });




// // DELETE API to delete a todo by ID
// server.delete("/todo/:id", (req, res) => {
//   var todoId = req.params.id;
//   var qry = "delete from todos where id = ?";
//   connection.query(qry, [todoId], (error, result) => {
//     if (error) {
//       res.send({
//         status: false,
//         message: "Failed to delete todo",
//       });
//     } else {
//       res.send({ status: true, message: "Todo deleted successfully" });
//     }
//   });
// });
