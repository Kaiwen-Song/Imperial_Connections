#!/usr/bin/php

<?php
    $connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    
    $query = "REMOVE FROM events WHERE event_id = '". $_GET['event_id'] ."' ;";
    echo $query;
    
    $link = pg_connect($connection);
    
    if(!$link) {
        echo "error!";
    } else {
        $result = pg_query($link, $query);
        echo "Done!1111";
    }
    
    ?>