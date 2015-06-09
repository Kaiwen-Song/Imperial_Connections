#!/usr/bin/php

<?php

$connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';

$query = "UPDATE chatrooms SET event_id = '". $_GET['event_id'] . "', sender_id = '". $_GET['sender_id'] . "', event_owner_id = '". $_GET['event_owner_id'] . "' WHERE chatroom_id = '". $_GET['chatroom_id'] . "'";


$link = pg_connect($connection);

if(!$link) {
    echo "error!";
} else {
    $result = pg_query($link, $query);
}

?>