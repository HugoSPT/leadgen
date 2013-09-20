<?php
require_once("../classes/class.firebase.php");

$firebase = new firebaseData();

if(isset($_POST['data'])){
    $data = json_decode($_POST['data']);
    $firebase->SaveLead($data);
}else {
    echo "Error...";
}

echo($data);