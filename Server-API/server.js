const express = require("express");
const bodyParser = require("body-parser");
const mysql = require("mysql2");
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

// GET API to fetch hotels by region
server.get('/hotel', (req, res) => {
  const regionId = parseInt(req.query.region_id, 10);
  console.log('Fetching hotels for region:', regionId);

  let qry = `
    SELECT hotel.*,
           COUNT(room.id) as available_rooms,
           SUM(CASE WHEN room.type = 'single' THEN 1 ELSE 0 END) as single_rooms,
           SUM(CASE WHEN room.type = 'double' THEN 1 ELSE 0 END) as double_rooms
    FROM hotel
    LEFT JOIN room ON room.hotel_id = hotel.id
    WHERE hotel.region_id = ?
    GROUP BY hotel.id;
  `;

  connection.query(qry, [regionId], (error, result) => {
    if (error) {
      console.error('Database query error:', error);
      res.status(500).send({ status: false, message: 'Unable to fetch hotels.' });
    } else {
      console.log('Query Result:', result);
      res.send({ status: true, data: result });
    }
  });
});


// PUT API to update a hotel by ID
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

//post api to create a region
server.post("/region/create", (req,res)=>{
  let details = { name: req.body.name};

  let qry = "insert into region set ?";
  connection.query(qry,details,(error) =>{
    if (error) {
      res.send({ status: false, message: "Region failed to be added"});
    }
    res.send({ status: true, message: "Region added successful"});
  });

});


//************************************************************************************************* */
                // Server Modification search region by name
               // modificatio search through region name

  server.get('/region', (req, res) => {
  const regionName = req.query.name;

  if (!regionName) {
    return res.status(400).send({ status: false, message: 'Region name is required' });
  }

  // Query to fetch hotels based on region name by joining two tables: region and hotel
  const query = `
    SELECT h.id, h.name, h.address, h.contact_info, r.name AS regionName
    FROM hotel h
    JOIN region r ON h.region_id = r.id
    WHERE r.name LIKE CONCAT('%', ?, '%')
  `;
  const searchTerm = `%${regionName}%`; // Use % as wildcard for partial matching

  connection.query(query, [searchTerm], (error, results) => {
    if (error) {
      console.error('Database query error:', error);
      return res.status(500).send({ status: false, message: 'An error occurred while searching for hotels' });
    }

    if (results.length > 0) {
      res.send({ status: true, data: results });
    } else {
      res.send({ status: false, message: 'No hotels found for the specified region' });
    }
  });
  });

//************************************************************************************************* */


//post api for create location
server.post("/location/create", (req,res)=>{
  let details = {
    name: req.body.name,
    region_id: req.body.region_id
  };

  let qry = "insert into location set ?";
  connection.query(qry,details,(error) =>{
    if (error) {
      res.send({ status: false, message: "Location failed to be added"});
    }
    res.send({ status: true, message: "Location added successful"});
  });

});

//api to view location
server.get("/location", (req,res) => {
  var qry = "select * from location";

    connection.query(qry, (error, result) => {
    if (error) {
      res.send({ status: false, message: "Region cannot be viewed" });
    } else {
      res.send({ status: true, data: result });
    }
  });

});


/*
 * Before pushing the booking into the database, we first fetch the region by name
 * in order to get the id of that region that will then going to be recorded into the
 * booking relation through this API endpoint
*/

// API endpoint to get region ID by region name
server.get('/region/id', (req, res) => {
  const regionName = req.query.name;

  if (!regionName) {
    return res.status(400).send({ status: false, message: 'Region name is required' });
  }

  // Use wildcards for partial matching
  const query = 'SELECT * FROM region WHERE name LIKE ?';
  const wildcardRegionName = `%${regionName}%`;  // Adding wildcards

  connection.query(query, [wildcardRegionName], (error, results) => {
    if (error) {
      console.error('Database query error:', error);
      return res.status(500).send({ status: false, message: 'An error occurred while fetching region ID' });
    }

    if (results.length > 0) {
      res.send({ status: true, data: results[0].id, name: results[0].name });
    } else {
      res.send({ status: false, message: 'Region not found' });
    }
  });
});

//post api for booking for create
server.post("/booking/create", (req, res) => {
  let details = {
    room: req.body.room,
    duration: req.body.duration,
    hotel_id: req.body.hotel_id,
    region_id: req.body.region_id,
    book_no: req.body.book_no,
    start_date: req.body.start_date,
    end_date: req.body.end_date
  };

  let qry = "insert into booking set ?";
  connection.query(qry, details, (error) => {
    if (error) {
      console.log(error);
      res.send({ status: false, message: "Booking failed." });
    } else {
      res.send({ status: true, message: "Booking successful." });
    }
  });
});


server.get("/booking", (req,res) => {
  var qry = "select * from booking";

    connection.query(qry, (error, result) => {
    if (error) {
      res.send({ status: false, message: "Booking cannot be viewed" });
    } else {
      res.send({ status: true, data: result });
    }
  });

});

 /*
  * Check room availability by considering their booking status, room id, and duration
  * in the booking relation
  */

  //API endpoint for the room availability in each hotel

  // API endpoint to get total bookings and available rooms for each hotel and room type
  server.get("/available", (req, res) => {
    const startDate = req.query.start_date;
    const endDate = req.query.end_date;

    if (!startDate || !endDate) {
      return res.status(400).send({ status: false, message: 'Start date and end date are required.' });
    }
    /*
    * This endpoint here return the available rooms for each hotel, their price for each type of rooms
    *
    */
    const qry = `
      SELECT
        h.id AS hotel_id,
        h.name AS hotel_name,
        r.id as room_id,
        r.type AS room_type,
        r.price AS room_price,
        COUNT(b.id) AS total_bookings,
        (r.total_rooms - COUNT(b.id)) AS available_rooms
      FROM
        room r
      JOIN
        hotel h ON r.hotel_id = h.id
      LEFT JOIN
        booking b ON r.id = b.room
      AND (b.start_date < Now() AND b.end_date > Now())
      WHERE
        r.is_available = 1
      GROUP BY
        h.id, r.type, r.price
      HAVING
        available_rooms > 0;

    `;

    connection.query(qry, (error, result) => {
      if (error) {
        console.error('Database query error:', error);
        return res.status(500).send({ status: false, message: 'Unable to fetch room availability.' });
      }

      res.send({ status: true, data: result });
    });
  });




// Handle and store complaint
// server.post('/complaint/create', (req, res) => {
//   const { user_id, booking_id, hotel_id, complaint_text } = req.body;

//   if (!user_id || !booking_id || !hotel_id || !complaint_text) {
//     return res.status(400).send({
//       status: false,
//       message: 'Missing required fields.',
//     });
//   }

//   // Ensure complaint_text is a string
//   if (typeof complaint_text !== 'string') {
//     return res.status(400).send({
//       status: false,
//       message: 'Invalid complaint text.',
//     });
//   }

//   let solution = '';

//   // Dynamic response based on complaint content
//   if (complaint_text.toLowerCase().includes('wifi')) {
//     solution = 'Please check the router and ensure it\'s connected.';
//   } else if (complaint_text.toLowerCase().includes('room')) {
//     solution = 'Our staff will address the room issue shortly.';
//   } else {
//     solution = 'Thank you for your feedback. We will look into it.';
//   }

//   // Insert the complaint into the database
//   const qry = `INSERT INTO Complaints (user_id, booking_id, hotel_id, complaint_text, status, response_text)
//                VALUES (?, ?, ?, ?, 'Pending', ?)`;

//   connection.query(qry, [user_id, booking_id, hotel_id, complaint_text, solution], (error, results) => {
//     if (error) {
//       console.error('Database query error:', error);
//       return res.status(500).send({
//         status: false,
//         message: 'Complaint could not be submitted.',
//       });
//     } else {
//       return res.send({
//         status: true,
//         message: solution,
//         complaintId: results.insertId,
//       });
//     }
//   });
// });

server.get('/rooms', (req, res) => {
  const hotelId = req.query.hotel_id;

  if (!hotelId) {
    return res.status(400).send({ status: false, message: 'Hotel ID is required.' });
  }

  const qry = `SELECT * FROM room WHERE hotel_id = ?`;

  connection.query(qry, [hotelId], (error, result) => {
    if (error) {
      console.error('Database query error:', error);
      return res.status(500).send({ status: false, message: 'Unable to fetch rooms.' });
    }

    res.send({ status: true, data: result });
  });
});

// Specify the port
server.listen(3000, function check(error) {
  if (error) {
    console.log("Error.....!!!");
  } else {
    console.log("Started...!!!");
  }
});
