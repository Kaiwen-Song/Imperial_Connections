#!/usr/bin/php
<?php
    $query = "SELECT * FROM events WHERE event_id = '".$_GET['event_id']."'";
    
    $connectString = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    $link = pg_connect($connectString);
    
    if (!$link) {
        echo "error";
    } else {
        $result = pg_query($link, $query);
        $json = pg_fetch_all($result);
        if ($json == null){
            echo "[]";
        } else {
            echo json_encode(array_values($json));
        }
    }
?>