<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="style.css"/>
	<title>Lecture Notes</title>
</head>
<body>
<?php

	ini_set('display_startup_errors', 1);
	ini_set('display_errors', 1);
	error_reporting(E_ALL);
	error_reporting(~E_STRICT);


$ini_file = parse_ini_file("database.ini");

// TODO update this to take data from a better place
$servername = "localhost";
$user = $ini_file["user"];
$password = $ini_file["password"];
$database = $ini_file["database"];

$conn = new mysqli($servername, $user, $password, $database);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$order = $conn->real_escape_string(isset($_GET["order"]) ? $_GET["order"] : "course_name");

$sql =
	"SELECT
		keywords.name AS keyword,
		notes.date AS date,
		notes.name AS note_name,
		UPPER(courses.name) AS course_name
	FROM keyword_bindings
		JOIN keywords
			ON keyword_bindings.keyword_id = keywords.id
		JOIN notes
			ON keyword_bindings.note_id = notes.id
		JOIN courses
			on notes.course_id = courses.id
	ORDER BY " . $order;

$result = $conn->query($sql);

if ($result->num_rows > 0) {
	echo "<table>";
	$hasHeader = false;
	while($row = $result->fetch_assoc()) {
		if(!$hasHeader) {
			echo "<thead>";
			foreach( array_keys($row) as $key ) {
				echo "<th>" . $key . "</th>";
			}
			echo "</thead>";
			$hasHeader = true;
		}
		echo "<tr>";
		foreach( $row as $key => $item ) {
			if($key === "date" or $key === "note_name") {
				echo "<td><a href='" . $row["date"] . ".pdf'>" . $item . "</a></td>";
			} else {
				echo "<td>" . $item . "</td>";
			}
		}
		echo "</tr>";
	}
	echo "</table>";
} else {
	echo "0 results";
}
$conn->close();
?>
</body>
</html>
