<?php

require_once("includes.php");
if (isset($_SESSION["isLoggedIn"])) {
  $_SESSION["isLoggedIn"] = false;
}
$required = array("username", "pass");
$_SESSION["errors"] = array();
foreach ($required as $index => $value) {
  if (!isset($_POST[$value]) || empty($_POST[$value])) {
    $_SESSION["errors"][] = "Username and password are required";
    die(header("Location: " . LOGIN_PAGE));
  }
}

require_once("classes/WebServiceClient.php");

$client = new WebServiceClient("http://cnmt310.braingia.org/authws/auth.php");
$data = array(
  "apikey" => APIKEY,
  "apiuser" => APIUSER,
  "password" => $_POST["pass"],
  "username" => $_POST["username"]
);
$client->setPostFields($data);
$verifyRequest = $client->send();
$verifyObject = json_decode($verifyRequest);

if (!is_object($verifyObject)) {
  $_SESSION["errors"][] = "Error: Authentication Issues";
} else { //if returned data is an object
  if ($verifyObject->result == "Success") {
    $_SESSION["isLoggedIn"] = true;
    $_SESSION["role"] = $verifyObject->role;
    $_SESSION["email"] = $verifyObject->email;
    $_SESSION["name"] = $verifyObject->name;
    $_SESSION["count"] = 0;
    die(header("Location: " . AUTHENTICATED_HOME)); //if successful login go to homepage
  } else {
    $_SESSION["errors"][] = $verifyObject->message;
  }
}
die(header("Location: " . LOGIN_PAGE)); //if errors, stay on login page
