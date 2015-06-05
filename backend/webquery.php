#!/usr/bin/php

<?php
$connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';

//$string = "[{"id":"1","dept":"DOC ","emp_id":"101"},{"id":"3","dept":"JMC ","emp_id":"103"},{"id":"2","dept":"RSM ","emp_id":"102"},{"id":"4","dept":"MATH ","emp_id":"106"},{"id":"5","dept":"AERO ","emp_id":"110"},{"id":"10","dept":"B-School ","emp_id":"120"},{"id":"6","dept":"MEDIC ","emp_id":"107"}]"
//$sql = "INSERT INTO"
//$url = 'http://www.doc.ic.ac.uk/project/2014/271/g1427123/web/webservice.php'
//$content = file_get_contents($url);
//$json = json_decode($content, true);

$query = "INSERT INTO events VALUES ('" . $_GET['event_id'] . "', '" . $_GET['owner'] . "', '" . $_GET['title'] . "', '" . $_GET['category'] . "', '" . $_GET['description'] . "' );";
echo $query;

$link = pg_connect($connection);

if(!$link) {
	echo "error!";
} else {
	$result = pg_query($link, $query);
	echo "Done!1111";
}

?>