-- CRUD for Aircrafts table --

/*
  @name: AircraftsCreate
  @role: Inserts a new row into Aircrafts table
  @parameters:
    aircraft_id CHAR(6)
    aircraft_type VARCHAR(35)
    max_number_of_passengers SMALLINT(6)
    entered_service DATE
    aircraft_name VARCHAR(55)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: See @role
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS AircraftsCreate $$
CREATE PROCEDURE AircraftsCreate(aircraft_id              CHAR(6), aircraft_type VARCHAR(35),
                                 max_number_of_passengers SMALLINT(6), entered_service DATE, aircraft_name VARCHAR(55))
  BEGIN
    INSERT INTO aircrafts (aircraftID, aircraftType, maxNumberOfPassangers, enteredService, aircraftName)
    VALUES (aircraft_id, aircraft_type, max_number_of_passengers, entered_service, aircraft_name);
  END $$
DELIMITER ;

/*
  @name: AircraftsRead
  @role: Selects a row from the Aircrafts table
  @parameters:
    aircraft_id CHAR(6)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Selects a row from Aircrafts that corresponds to the given id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS AircraftsRead $$
CREATE PROCEDURE AircraftsRead(aircraft_id CHAR(6))
  BEGIN
    SELECT *
    FROM aircrafts
    WHERE aircraft_id = aircraftID;
  END $$
DELIMITER ;

/*
  @name: AircraftsUpdate
  @role: Updates a row from the Aircrafts table
  @parameters:
    aircraft_id CHAR(6)
    aircraft_type VARCHAR(35)
    max_number_of_passengers SMALLINT(6)
    entered_service DATE
    aircraft_name VARCHAR(55)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Updates a row in the Aircrafts table that corresponds to the given id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS AircraftsUpdate $$
CREATE PROCEDURE AircraftsUpdate(aircraft_id              CHAR(6), aircraft_type VARCHAR(35),
                                 max_number_of_passengers SMALLINT(6), entered_service DATE, aircraft_name VARCHAR(55))
  BEGIN
    UPDATE aircrafts
    SET aircraftType = aircraft_type, maxNumberOfPassangers = max_number_of_passengers,
      enteredService = entered_service, aircraftName = aircraft_name
    WHERE aircraftID = aircraft_id;
  END $$
DELIMITER ;

/*
  @name: AircraftsDelete
  @role: Deletes a row from the Aircrafts table
  @parameters:
    aircraft_id CHAR(6)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Deletes a row from the Aircrafts table that corresponds to the given id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS AircraftsDelete $$
CREATE PROCEDURE AircraftsDelete(aircraft_id CHAR(6))
  BEGIN
    DELETE FROM aircrafts
    WHERE aircraftID = aircraft_id;
  END $$
DELIMITER ;


-- CRUD for PriceCategories table --

/*
  @name: PriceCategoriesCreate
  @role: Inserts a new row into the PriceCategories table
  @parameters:
    class_id INT(11)
    category_name VARCHAR(35)
    valid_from DATE
    valid_to DATE
    minimum_price INT(11)
    refundable TINYINT(1)
    seat_number_restrictions INT(11)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Inserts a new row, using the parameters
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS PriceCategoriesCreate $$
CREATE PROCEDURE PriceCategoriesCreate(class_id      INT(11), category_name VARCHAR(35), valid_from DATE, valid_to DATE,
                                       minimum_price INT(11), refundable TINYINT(1), seat_number_restrictions INT(11))
  BEGIN
    INSERT INTO pricecategories (classID, categoryName, validFrom, validTo, minimumPrice, refundable, seatNumberRestrictions)
    VALUES (class_id, category_name, valid_from, valid_to, minimum_price, refundable, seat_number_restrictions);
  END $$
DELIMITER ;

/*
  @name: PriceCategoriesRead
  @role: Select a row from the PriceCategories table
  @parameters:
    category_id INT(11)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Selects a single row from table that corresponds to the given id
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS PriceCategoriesRead $$
CREATE PROCEDURE PriceCategoriesRead(category_id INT(11))
  BEGIN
    SELECT *
    FROM pricecategories
    WHERE categoryID = category_id;
  END $$
DELIMITER ;


/*
  @name: PriceCategoriesUpdate
  @role: Update a row from the PriceCategories table
  @parameters:
    category_id INT(11)
    class_id INT(11)
    category_name VARCHAR(35)
    valid_from DATE
    valid_to DATE
    minimum_price INT(11)
    refundable TINYINT(1)
    seat_number_restrictions INT(11)
  @created: 11-03-2016
  @author: Valdimar Gunnarsson
  @description: Updates a single row from the table that corresponds to the given id.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS PriceCategoriesUpdate $$
CREATE PROCEDURE PriceCategoriesUpdate(category_id   INT(11), class_id INT(11), category_name VARCHAR(35),
                                       valid_from    DATE, valid_to DATE,
                                       minimum_price INT(11), refundable TINYINT(1), seat_number_restrictions INT(11))
  BEGIN
    UPDATE pricecategories
    SET classID    = class_id, categoryName = category_name, validFrom = valid_from, validTo = valid_to,
      minimumPrice = minimum_price, refundable = refundable, seatNumberRestrictions = seat_number_restrictions
    WHERE categoryID = category_id;
  END $$
DELIMITER ;

DELIMITER $$
DROP PROCEDURE IF EXISTS PriceCategoriesDelete $$
CREATE PROCEDURE PriceCategoriesDelete(category_id INT(11))
  BEGIN
    DELETE
    FROM pricecategories
    WHERE categoryID = category_id;
  END $$
DELIMITER ;


-- Other procedures/functions --

/*
  @name: FlightNumberOfPassengers
  @role: Display the number of passengers in any one flight
  @parameters:
    flightCode INT(11)
  @created: 25-03-2016
  @author: Valdimar Gunnarsson
  @description: Displays the number of passengers from the flight corresponding with the given parameter.
*/
DELIMITER $$
DROP PROCEDURE IF EXISTS FlightNumberOfPassengers $$
CREATE PROCEDURE FlightNumberOfPassengers(flight_code INT(11))
  BEGIN
    SELECT count(personID) AS 'Passenger count'
    FROM passengers
      JOIN bookings ON passengers.bookingNumber = bookings.bookingNumber
    WHERE bookings.flightCode = flight_code;
  END $$
DELIMITER ;

/*
  @name: BookFlight
  @role: Book one or more passengers into a flight
  @parameters:
    flightCode INT(11)
    flightDate DATE
    cardIssuedBy VARCHAR(35)
    cardHoldersName VARCHAR(55)
    passengersArray TEXT
  @created: 25-03-2016
  @author: Valdimar Gunnarsson
  @description: Books one or more passengers into a flight using the given parameters
*/

DELIMITER $$
DROP PROCEDURE IF EXISTS BookFlight $$
CREATE PROCEDURE BookFlight(flight_code       INT(11), flight_date DATETIME, card_issued_by VARCHAR(35),
                            card_holders_name VARCHAR(55), passengers_array TEXT)
  BEGIN
    DECLARE outerPosition INT;
    DECLARE innerPosition INT;
    DECLARE workingArray TEXT;
    DECLARE currentPassanger VARCHAR(255);

    DECLARE booking_number INT(11);
    DECLARE price_id INT(11);
    DECLARE seat_id INT(11);
    DECLARE person_id VARCHAR(35);
    DECLARE person_name VARCHAR(75);

    SET workingArray = passengers_array;
    SET outerPosition = 1;
    SET innerPosition = 1;

    INSERT INTO bookings (flightCode, timeOfBooking, cardIssuedBy, cardholdersName)
    VALUES (flight_code, flight_date, card_issued_by, card_holders_name);

    SELECT bookingNumber
    FROM bookings
    WHERE flightCode = flight_code AND timeOfBooking = flight_date AND cardIssuedBy = card_issued_by AND
          cardholdersName = card_holders_name
    INTO booking_number;

    WHILE char_length(workingarray) > 0 AND outerposition > 0 DO
      SET outerposition = instr(workingarray, '|');
      IF outerposition = 0
      THEN
        SET currentpassanger = workingarray;
      ELSE
        SET currentpassanger = left(workingarray, outerposition - 1);
      END IF;

      IF trim(workingarray) != ''
      THEN
        SET innerposition = instr(currentpassanger, ',');
        SET person_name = left(currentpassanger, innerposition - 1);
        SET currentpassanger = substring(currentpassanger, innerposition + 1);

        SET innerposition = instr(currentpassanger, ',');
        SET person_id = left(currentpassanger, innerposition - 1);
        SET currentpassanger = substring(currentpassanger, innerposition + 1);

        SET innerposition = instr(currentpassanger, ',');
        SET seat_id = left(currentpassanger, innerposition - 1);
        SET currentpassanger = substring(currentpassanger, innerposition + 1);

        SET price_id = currentpassanger;

        INSERT INTO passengers (personname, personid, seatid, priceid, bookingnumber)
        VALUES (person_name, person_id, seat_id, price_id, booking_number);
      END IF;


      SET workingarray = substring(workingarray, outerposition + 1);
    END WHILE;
  END $$
DELIMITER ;

-- Views --

/*
  @name: AircraftList
  @role: Displays a list of all aircrafts in the database
  @parameters: N/A
  @created: 29-03-2016
  @author: Valdimar Gunnarsson
  @description: see role.
*/

DELIMITER $$
DROP VIEW IF EXISTS AircraftList $$
CREATE VIEW AircraftList AS
  SELECT
    aircraftID            AS 'ID',
    aircraftType          AS 'Type',
    maxNumberOfPassangers AS 'Max number of passengers',
    enteredService        AS 'Date entered service',
    aircraftName          AS 'Name'
  FROM aircrafts;
DELIMITER ;

/*
  @name: DestinationList
  @role: Displays a list of all destinations in the database
  @parameters: N/A
  @created: 29-03-2016
  @author: Valdimar Gunnarsson
  @description: see role
*/

DELIMITER $$
DROP VIEW IF EXISTS DestinationList $$
CREATE VIEW DestinationList AS
  SELECT
    destinationAirport AS 'Destination',
    airportName        AS 'Airport',
    cityName           AS 'City',
    countryName        AS 'Country'
  FROM flightschedules
    JOIN airports ON flightschedules.destinationAirport = airports.IATAcode
    JOIN cities ON airports.cityID = cities.cityID
    JOIN countries ON cities.countryCode = countries.alpha336612;
DELIMITER ;

/*
  @name: PriceCategoryList
  @role: Displays all pricecategories in database
  @parameters: N/A
  @created: 29-03-2016
  @author: Valdimar Gunnarsson
  @description: see role.
*/

DELIMITER $$
DROP VIEW IF EXISTS PriceCategoryList $$
CREATE VIEW PriceCategoryList AS
  SELECT
    categoryName           AS 'Name',
    validFrom              AS 'Valid from',
    validTo                AS 'Valid to',
    minimumPrice           AS 'Minimum price',
    refundable             AS 'Refundable',
    seatNumberRestrictions AS 'Seat number restrictions',
    classID                AS 'Class'
  FROM pricecategories;
DELIMITER ;

/*
  @name: AirportList
  @role: Displays all airports in database
  @paramaters: N/A
  @created: 29-03-2016
  @author: Valdimar Gunnarsson
  @description: see role.
*/

DELIMITER $$
DROP VIEW IF EXISTS AirportList $$
CREATE VIEW AirportList AS
  SELECT
    airportName AS 'Airport name',
    cityName    AS 'City name',
    countryName AS 'Country name'
  FROM airports
    JOIN cities ON airports.cityID = cities.cityID
    JOIN countries ON cities.countryCode = countries.alpha336612;
DELIMITER ;

/*
  @name: FlightScheduleList
  @role: Displays all flight schedules in database
  @paramaters: N/A
  @created: 29-03-2016
  @author: Valdimar Gunnarsson
  @description: see role.
*/

DELIMITER $$
DROP VIEW IF EXISTS FlightScheduleList $$
CREATE VIEW FlightScheduleList AS
  SELECT
    flightNumber       AS 'Flight number',
    originatingAirport AS 'Originating airport',
    destinationAirport AS 'Destination airport',
    distance           AS 'Distance'
  FROM flightschedules;
DELIMITER ;