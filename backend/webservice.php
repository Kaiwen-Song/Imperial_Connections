#!/usr/bin/php
<?php
$sql = "SELECT * FROM events";


$connectString = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
$link = pg_connect($connectString);

if (!$link) {
    echo "error";
} else {

$result = pg_query($link, $sql);

$json = json_encode(array_values(pg_fetch_all($result)));
echo $json;
}
?>