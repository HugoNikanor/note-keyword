<!doctype html>
<html>
<head>
	<meta charset="utf-8"/>
	<link rel="stylesheet" href="style.css"/>
	<title>Lecture Notes</title>
</head>
<body>
<?php
echo exec("mysql -Hu root note_keywords < get_full_keyword_table.sql");
?>
</body>
</html>
