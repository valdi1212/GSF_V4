<?php

require_once 'DBcon.php';

function AircraftsCreate($aircraftID, $aircraftType, $maxNumberOfPassengers, $enteredService, $aircraftName)
{
	global $db;
	$stmt = $db->prepare('CALL AircraftsCreate(:id, :type, :maxNum, :enteredService, :name)');
	$stmt->bindParam(':id', $aircraftID);
	$stmt->bindParam(':type', $aircraftType);
	$stmt->bindParam(':maxNum', $maxNumberOfPassengers);
	$stmt->bindParam(':enteredService', $enteredService);
	$stmt->bindParam(':name', $aircraftName);

	$stmt->execute();
}

function AircraftsRead($aircraftID)
{
	global $db;
	$stmt = $db->prepare('CALL AircraftsRead(:aircraftID)');
	$stmt->bindParam(':aircraftID', $aircraftID);

	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetch();

	echo 'ID: ' . $result["aircraftID"] . ' - Type: ' . $result["aircraftType"] . ' - Max number of passengers ' . $result["maxNumberOfPassangers"] . ' - Entered service: ' . $result["enteredService"] . ' - Name: ' . (($result["aircraftName"] == null) ? "Unnamed" : $result["aircraftName"]) . "\n";
}

function AircraftsUpdate($aircraftID, $aircraftType, $maxNumberOfPassengers, $enteredService, $aircraftName)
{
	global $db;
	$stmt = $db->prepare('CALL AircraftsUpdate(:id, :type, :maxNum, :enteredService, :name)');
	$stmt->bindParam(':id', $aircraftID);
	$stmt->bindParam(':type', $aircraftType);
	$stmt->bindParam(':maxNum', $maxNumberOfPassengers);
	$stmt->bindParam(':enteredService', $enteredService);
	$stmt->bindParam(':name', $aircraftName);

	$stmt->execute();
}

function AircraftsDelete($aircraftID)
{
	global $db;
	$stmt = $db->prepare('CALL AircraftsDelete(:aircraftID)');
	$stmt->bindParam(':aircraftID', $aircraftID);

	$stmt->execute();
}

function PriceCategoriesCreate($classID, $categoryName, $validFrom, $validTo, $minimumPrice, $refundable, $seatNumberRestrictions)
{
	global $db;
	$stmt = $db->prepare('CALL PriceCategoriesCreate(:id, :name, :from, :to, :minimumPrice, :refundable, :restrictions)');
	$stmt->bindParam(':id', $classID);
	$stmt->bindParam(':name', $categoryName);
	$stmt->bindParam(':from', $validFrom);
	$stmt->bindParam(':to', $validTo);
	$stmt->bindParam(':minimumPrice', $minimumPrice);
	$stmt->bindParam(':refundable', $refundable);
	$stmt->bindParam(':restrictions', $seatNumberRestrictions);

	$stmt->execute();
}

function PriceCategoriesRead($categoryID)
{
	global $db;
	$stmt = $db->prepare('CALL PriceCategoriesRead(:id)');
	$stmt->bindParam(':id', $categoryID);

	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetch();

	echo 'Class ID: ' . $result["classID"] . ' - Name: ' . $result["categoryName"] . ' Valid from: ' . $result["validFrom"] . ' - Valid to: ' . $result["validTo"] . ' - Minimum price: ' . $result["minimumPrice"] . ' - Refundable: ' . (($result["refundable"] == 1) ? "Yes" : "No") . ' - Seat number restrictions: ' . (($result["seatNumberRestrictions"] == 0) ? "No" : $result["seatNumberRestrictions"]) . "\n";
}

function PriceCategoriesUpdate($classID, $categoryName, $validFrom, $validTo, $minimumPrice, $refundable, $seatNumberRestrictions)
{
	global $db;
	$stmt = $db->prepare('CALL PriceCategoriesUpdate(:id, :name, :from, :to, :minimumPrice, :refundable, :restrictions)');
	$stmt->bindParam(':id', $classID);
	$stmt->bindParam(':name', $categoryName);
	$stmt->bindParam(':from', $validFrom);
	$stmt->bindParam(':to', $validTo);
	$stmt->bindParam(':minimumPrice', $minimumPrice);
	$stmt->bindParam(':refundable', $refundable);
	$stmt->bindParam(':restrictions', $seatNumberRestrictions);

	$stmt->execute();
}

function PriceCategoriesDelete($categoryID)
{
	global $db;
	$stmt = $db->prepare('CALL PriceCategoriesDelete(:id)');
	$stmt->bindParam(':id', $categoryID);

	$stmt->execute();
}

function FlightNumberOfPassengers($flightCode)
{
	global $db;
	$stmt = $db->prepare('CALL FlightNumberOfPassengers(:flightCode)');
	$stmt->bindParam(':flightCode', $flightCode);

	$stmt->execute();
}

function BookFlight($flightCode, $flightDate, $cardIssuedBy, $cardHoldersName, $passengersArray)
{
	global $db;
	$stmt = $db->prepare('CALL BookFlight(:flightCode, :flightDate, :cardIssuedBy, :cardHoldersName, :passengersArray)');
	$stmt->bindParam(':flightCode', $flightCode);
	$stmt->bindParam(':flightDate', $flightDate);
	$stmt->bindParam(':cardIssuedBy', $cardIssuedBy);
	$stmt->bindParam(':cardHoldersName', $cardHoldersName);
	$stmt->bindParam(':passengersArray', $passengersArray);

	$stmt->execute();
}

function AircraftList()
{
	global $db;
	$stmt = $db->prepare('SELECT * FROM AircraftList');

	$stmt->execute();
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetchAll();

	foreach ($result as $row)
	{
		echo 'ID: ' . $row["ID"] . ' - Type: ' . $row["Type"] . ' - Max number of passengers: ' . $row["Max number of passengers"] . ' - Date entered service ' . $row['Date entered service'] . "\n";
	}
}

function DestinationList()
{
	global $db;
	$stmt = $db->prepare('SELECT * FROM DestinationList');

	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetchAll();

	foreach ($result as $row)
	{
		echo 'Destination: ' . $row["Destination"] . ' - Airport: ' . $row["Airport"] . ' - City: ' . $row["City"] . ' - Country: ' . $row["Country"] . "\n";
	}
}

function PriceCategoryList()
{
	global $db;
	$stmt = $db->prepare('SELECT * FROM PriceCategoryList');

	$stmt->execute();
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetchAll();

	foreach ($result as $row)
	{
		echo 'Name: ' . $row["Name"] . ' - Valid from ' . $row['Valid from'] . ' - Valid to: ' . $row['Valid to'] . ' - Minimum price ' . $row["Minimum price"] . ' - Refundable: ' . (($row["Refundable"] == 1) ? "Yes" : "No") . ' - Seat number restrictions: ' . (($row["Seat number restrictions"] == 0) ? "No" : $row["Seat number restrictions"]) . ' - Class: ' . $row["Class"] . "\n";
	}
}

function AirportList()
{
	global $db;
	$stmt = $db->prepare('SELECT * FROM AirportList');

	$stmt->execute();
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetchAll();

	foreach ($result as $row)
	{
		echo 'Airport name: ' . $row["Airport name"] . ' - City name: ' . $row["City name"] . ' - Country name: ' . $row["Country name"] . "\n";
	}
}

function FlightScheduleList()
{
	global $db;
	$stmt = $db->prepare('SELECT * FROM FlightScheduleList');

	$stmt->execute();
	$stmt->execute();
	$stmt->setFetchMode(PDO::FETCH_ASSOC);
	$result = $stmt->fetchAll();

	foreach ($result as $row)
	{
		echo 'Flight number: ' . $row["Flight number"] . ' - Originating airport: ' . $row['Originating airport'] . ' - Destination airport: ' . $row["Destination airport"] . ' - Distance: ' . $row["Distance"] . "\n";
	}
}