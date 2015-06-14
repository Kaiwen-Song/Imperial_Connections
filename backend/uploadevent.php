#!/usr/bin/php

<?php
$connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';

$id = $_GET['event_id'];
$query = "UPDATE events SET owner = '" . $_GET['owner'] . "', title = '" . $_GET['title'] . "', categories = '" . $_GET['category'] . "', content = '" . $_GET['description'] . "', event_date = '" . $_GET['event_date'] . "' WHERE event_id = '" . $id. "';";
echo $query;

$link = pg_connect($connection);

if(!$link) {
	echo "error!";
} else {
	$result = pg_query($link, $query);
	echo "Done!1111";
}

?>