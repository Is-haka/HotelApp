  const app = require('express')();
  const bodyParser = require('body-parser');
  const cors = require('cors');
  const mysql = require('mysql');
  const port = 3005;

  app.use(cors());
  app.use(bodyParser.json());

  const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'hotel_api'
  });

  db.connect(error => {
    if(error) {
      console.log("database connection failed", error);
    }
    console.log("Database connected");
  });

  app.post('/location/create', (req, res) => {
    let locationDetails = {
      name: req.body.name,
      region_id: req.body.region_id,
      created_at: req.body.created_at,
      updated_at: req.body.updated_at,
      deleted_at: req.body.deleted_at,
    };
    const qry = "INSERT INTO location SET ?";
    db.query(qry, locationDetails, (error) => {
      if (error) {
        console.error('Database error:', error); // Log the error for debugging
        // Ensure that the response is only sent once
        if (!res.headersSent) {
          return res.status(500).send({ status: false, message: 'Query failed' });
        }
      } else {
        // Ensure that the response is only sent once
        if (!res.headersSent) {
          return res.send({ status: true, message: 'Location created successfully' });
        }
      }
    });
  });

  app.get('/location/view', (req, res) => {
    const qry = "SELECT * FROM location";
    db.query(qry, (error, results) => {
      if(error) {
        console.error("Database error: ", error);
        if(!res.headersSent) {
          return res.status(500).send({status: false, message: "Query failed"});
        }
      } else {
        if(!res.headersSent) {
          return res.send({status: true, message: "Locations are as follows", data: results});
        }
      }
      res.json(results[0]);
    });
  });

  app.listen(
    port, console.log(`Server run on http://127.0.0.1:${port}`)
  );
