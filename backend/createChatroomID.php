#!/usr/bin/php

<?php

$connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';

$query1 = "SELECT chatroom_id FROM chatrooms WHERE event_id = '". $_GET['event_id'] . "'";
$query2 = "INSERT INTO chatrooms (chatroom_id, event_id, event_owner_id, sender_id) VALUES (DEFAULT, NULL, NULL, NULL) RETURNING chatroom_id";

    
    // UPDATE chatrooms SET event_id = '". $_GET['event_id'] . "', sender_id = '". $_GET['sender_id'] . "', event_owner_id = '". $_GET['event_owner_id'] . "'
$link = pg_connect($connection);

if(!$link) {
    echo "error!";
} else {
    $result = pg_query($link, $query1);
    if (pg_num_rows($result) == 0) {
        $result = pg_query($link, $query2);
    }
    while ($row = pg_fetch_row($result)) {
            $chatID = (string)$row[0];
        }
    echo $chatID;
}

?>