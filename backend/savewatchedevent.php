#!/usr/bin/php

<?php
    $connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    

    $query = "INSERT INTO watched_events VALUES ('" . $_GET['u_id'] . "', " . $_GET['event_id'] . ");";
    
    $link = pg_connect($connection);
    
    if(!$link) {
        echo "error!";
    } else {
        $result = pg_query($link, $query);
        echo "Done!1111";
    }
    
    ?>