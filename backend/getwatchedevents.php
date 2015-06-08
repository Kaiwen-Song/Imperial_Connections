#!/usr/bin/php
<?php
    $query = "SELECT events.event_id, owner, title, categories, content FROM events, watched_events WHERE u_id = '" . $_GET['u_id'] . "' AND watched_events.event_id = events.event_id";
    
    $connectString = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    $link = pg_connect($connectString);
    
    if (!$link) {
        echo "error";
    } else {
        $result = pg_query($link, $query);
        $json = json_encode(array_values(pg_fetch_all($result)));
        echo $json;
}
?>