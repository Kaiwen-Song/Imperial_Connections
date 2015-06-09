#!/usr/bin/php

<?php

$connection = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';

$query = "INSERT INTO messages (chatroom_id, message_id, sender_id, message_content, send_time) VALUES ('" . $_GET[
'chatroom_id'] . "' , '". $_GET['message_id']. "', '". $_GET['sender_id']. "', '". $_GET['message_content'] . "', DEFAULT) RETURNING event_ID;";

$link = pg_connect($connection);

if(!$link) {
	echo "error!";
} else {
	$result = pg_query($link, $query);
	while ($row = pg_fetch_row($result)) {
            $ID = (string)$row[0];
        }
	echo $ID;
}

?>