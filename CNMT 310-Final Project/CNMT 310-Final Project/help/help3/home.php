<?php

require_once("includes.php");
require_once("classes/SiteTemplate.php");

$page = new SiteTemplate("Home");
$page->addHeadElement('<link rel="stylesheet" href=styles/layout.css>');
$page->addHeadElement('<style>#home {text-decoration: underline;}</style>');
$page->finalizeTopSection();
$page->finalizeBottomSection();

print $page->getTopSection();

require_once("layout.php");

$message = "";
if (!isset($_SESSION['name'])) {
  $message="<h3 id='message'>You are not currently logged in.</h3><br><p>Click <a href='login.php'>here</a> to login.</p>";
}
else {
    $user = $_SESSION['name'];
    $message = "<h3 id='message'>Welcome " . $user . "</h3>";
}
print $message;
print $page->getBottomSection();