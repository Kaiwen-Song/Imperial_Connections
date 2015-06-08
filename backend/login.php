#!/usr/bin/php
<?php

    $connectString = 'host=db.doc.ic.ac.uk dbname=g1427123_u user=g1427123_u password=1by9jrkgJO';
    $sql = "SELECT password FROM users WHERE username=Jeffrey";
    echo $sql
    //'" . $_GET['username'] . "'
    //$password_check = $_GET['password']
    
    //echo $password_check
    
    $link = pg_connect($connectString);
    
    $result = pg_query($link, $sql);

    echo $result

    /*if (!$link) {
        echo "Connection error";
    } else {
        
        $result = pg_query($link, $sql);
        if ($result = 11111) {
            echo "Success"
        } else {
            echo "Fail"
        }
    }*/
    
?>