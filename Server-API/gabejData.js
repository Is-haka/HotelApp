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
// *************************************************************
// Middleware to verify the token
function authenticateToken(req, res, next) {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) return res.status(401).send({ status: false, message: 'Token missing' });

  jwt.verify(token, secretKey, (err, user) => {
    if (err) return res.status(403).send({ status: false, message: 'Token is not valid' });

    req.user = user;
    next();
  });
}
           //post api to create a hotel
// Protected routes with authenticateToken middleware
server.post("/hotel/create", authenticateToken, (req, res) => {
  let details = {
    name: req.body.name,
    region_id: req.body.region_id
  };

  let qry = "insert into hotel set ?";
  connection.query(qry, details, (error) => {
    if (error) {
      res.send({ status: false, message: "Hotel failed to be added" });
    }
    res.send({ status: true, message: "Hotel added successfully" });
  });
});
//************************************************************ */

// GET API to fetch hotels by region
server.get('/hotel', authenticateToken, (req, res) => {
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
// **************************************************************

server.put("/hotel/update/:id", authenticateToken, (req, res) => {
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

// ***************************************************


server.post("/region/create", authenticateToken, (req, res) => {
  let details = { name: req.body.name };

  let qry = "insert into region set ?";
  connection.query(qry, details, (error) => {
    if (error) {
      res.send({ status: false, message: "Region failed to be added" });
    }
    res.send({ status: true, message: "Region added successfully" });
  });
});

//************************************************************************************************* */

  //  get region with name
              server.get('/region', authenticateToken, (req, res) => {
                const regionName = req.query.name;

                if (!regionName) {
                  return res.status(400).send({ status: false, message: 'Region name is required' });
                }

                // Query to fetch regions based on partial region name, case-insensitive
                const query = `
                  SELECT id, name
                  FROM region
                  WHERE LOWER(name) LIKE LOWER(?)
                `;

                // Using `%${regionName}%` to match any part of the region name
                connection.query(query, [`%${regionName}%`], (error, results) => {
                  if (error) {
                    console.error('Database query error:', error);
                    return res.status(500).send({ status: false, message: 'An error occurred while searching for regions' });
                  }

                  if (results.length > 0) {
                    res.send({ status: true, data: results });
                  } else {
                    res.send({ status: false, message: 'No regions found for the specified name' });
                  }
                });
              });


//*************************************************** */
//post api for create location

server.post("/location/create", authenticateToken, (req, res) => {
  let details = {
    name: req.body.name,
    region_id: req.body.region_id
  };

  let qry = "insert into location set ?";
  connection.query(qry, details, (error) => {
    if (error) {
      res.send({ status: false, message: "Location failed to be added" });
    }
    res.send({ status: true, message: "Location added successfully" });
  });
});

server.get("/location", authenticateToken, (req, res) => {
  var qry = "select * from location";

  connection.query(qry, (error, result) => {
    if (error) {
      res.send({ status: false, message: "Location cannot be viewed" });
    } else {
      res.send({ status: true, data: result });
    }
  });
});


// ************************************************
/*
 * Before pushing the booking into the database, we first fetch the region by name
 * in order to get the id of that region that will then going to be recorded into the
 * booking relation through this API endpoint
*/

// API endpoint to get region ID by region name

server.get('/region/id', authenticateToken, (req, res) => {
  const regionName = req.query.name;

  if (!regionName) {
    return res.status(400).send({ status: false, message: 'Region name is required' });
  }

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

// ******************************************************
//post api for booking for create
server.post("/booking/create", authenticateToken, (req, res) => {
  let details = {
    firstname: req.body.firstname,
    lastname: req.body.lastname,
    email: req.body.email,
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
// **********************************************************
 // api to getting booking.........
server.get("/booking", authenticateToken, (req, res) => {
  var qry = "select * from booking";

  connection.query(qry, (error, result) => {
    if (error) {
      res.send({ status: false, message: "Booking cannot be viewed" });
    } else {
      res.send({ status: true, data: result });
    }
  });
});


// ***********************************************************
 /*
  * Check room availability by considering their booking status, room id, and duration
  * in the booking relation
  */

  //API endpoint for the room availability in each hotel

  // API endpoint to get total bookings and available rooms for each hotel and room type
  server.get("/available", authenticateToken, (req, res) => {
    const region_id = req.query.region_id;

    const qry = `
      SELECT
        h.id AS hotel_id,
        h.name AS hotel_name,
        r.id AS room_id,
        r.type AS room_type,
        r.price AS room_price,
        (r.total_rooms - COALESCE(COUNT(b.id), 0)) AS available_rooms
      FROM
        room r
      JOIN
        hotel h ON r.hotel_id = h.id
      LEFT JOIN
        booking b ON r.id = b.room
        AND (b.start_date < now() AND b.end_date > now())
      WHERE
        r.is_available = 1
        AND h.region_id = ?
      GROUP BY
        h.id, r.id, r.type, r.price
      HAVING
        available_rooms > 0;
    `;

    connection.query(qry, [region_id], (error, result) => {
      if (error) {
        console.error('Database query error:', error);
        return res.status(500).send({ status: false, message: 'Unable to fetch room availability.' });
      }

      res.send({ status: true, data: result });
    });
  });

  // ******************************************************
                // Handle and store complaint
//API endpoint for submitting inquiry to the complaints table
server.post('/inquiry', authenticateToken, (req, res) => {
  const { customDesc, fullname, phone } = req.body;

  if (customDesc && fullname && phone) {
    const qry = "INSERT INTO complain(fullname, phone, customDesc) VALUES(?, ?, ?)";
    connection.query(qry, [fullname, phone, customDesc], (error) => {
      if (error) {
        console.log(error);
        res.send({ status: false, message: 'Failed to submit inquiry' });
      } else {
        res.send({ status: true, message: 'Inquiry submitted successfully' });
      }
    });
  } else {
    return res.status(400).send({ status: false, message: 'Please enter your inquiry' });
  }
});

server.get('/rooms', authenticateToken, (req, res) => {
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



//
*addition clientInformation={


  // **************************************************
  // Middleware to check if a user can book
function checkBookingLimit(req, res, next) {
  const userToken = req.body.token;

  // Check if token exists and has been used in the past five minutes
  const currentTime = Date.now();
  if (bookingTokens.has(userToken)) {
    const tokenInfo = bookingTokens.get(userToken);

    // Filter out old booking timestamps
    tokenInfo.bookings = tokenInfo.bookings.filter(timestamp => currentTime - timestamp < 5 * 60 * 1000);

    if (tokenInfo.bookings.length >= 5) {
      return res.status(429).send({ status: false, message: "Booking limit reached. Please try again later." });
    }

    tokenInfo.bookings.push(currentTime);
    bookingTokens.set(userToken, tokenInfo);
  } else {
    bookingTokens.set(userToken, { bookings: [currentTime] });
  }

  next();
}

// Endpoint to generate and return a token to the user
server.get('/generate-token', (req, res) => {
  const newToken = generateToken();
  bookingTokens.set(newToken, { bookings: [] });
  res.send({ status: true, token: newToken });
});

// Booking endpoint with limiting logic
server.post("/booking/create", checkBookingLimit, (req, res) => {
  let details = {
    firstname: req.body.firstname,
    lastname: req.body.lastname,
    email: req.body.email,
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

// Specify the port
server.listen(3000, function check(error) {
  if (error) {
    console.log("Error.....!!!");
  } else {
    console.log("Started...!!!");
  }
});

  // ***************************************************

  const express = require("express");
  const bodyParser = require("body-parser");
  const mysql = require("mysql2");
  const cors = require("cors");
  const session = require('express-session');
  const MySQLStore = require('connect-mysql2')(session);
  const crypto = require('crypto');

  // const server = express();
  server.use(cors());
  server.use(bodyParser.json());

  // Database connection configuration
  const connectionOptions = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'hotel_api',
  };

  // Use mysql2 connection pool
  const connection = mysql.createPool(connectionOptions);

  // Session store configuration
  const sessionStore = new MySQLStore({
    expiration: 10800000,
    createDatabaseTable: true,
    schema: {
      tableName: 'sessions',
      columnNames: {
        session_id: 'session_id',
        expires: 'expires',
        data: 'data',
      },
    },
  }, connection);

  server.use(
    session({
      secret: 'hotel_app_ipt', // Replace with a strong secret
      resave: false,
      saveUninitialized: false,
      store: sessionStore,
      cookie: { maxAge: 60 * 60 * 1000 }, // Session expires in 1 hour
    })
  );

  // Token storage to track booking attempts
  const bookingTokens = new Map();

  // Generate a token for each booking
  function generateToken() {
    return crypto.randomBytes(16).toString('hex');
  }


