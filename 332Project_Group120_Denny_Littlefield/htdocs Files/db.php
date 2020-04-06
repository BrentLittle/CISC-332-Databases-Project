<?php
    $user = 'root';
    $pass = '';
    $name = 'spcadb';
    $host = 'localhost';

    try
    {
        $Link = new PDO("mysql:host=" . $host . ";dbname=" . $name, $user, $pass);
        echo "Connected!";
    }
    catch(PDOException $e)
    {
        $msg = $e->getMessage();
        echo $msg;
    }
?>