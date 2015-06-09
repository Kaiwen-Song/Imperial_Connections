#!/usr/bin/php

<?php

    $connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    $query = "SELECT sender_id, message_content, send_time, message_id FROM messages WHERE chatroom_id = '". $_GET['chatroom_id'] . "' ORDER BY send_time";
    
    $link = pg_connect($connection);
    
    if(!$link) {
        echo "error!";
    } else {
        $result = pg_query($link, $query);
        if (pg_num_rows($result) == 0) {
            echo "";
        } else {
            $json = json_encode(array_values(pg_fetch_all($result)));
            echo $json;
        }
    }

?>