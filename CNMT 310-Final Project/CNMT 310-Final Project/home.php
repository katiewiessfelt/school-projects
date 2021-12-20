<?php
//external pages
require_once("includes.php");
require_once("classes/SiteTemplate.php");

//setting header and footer
$page = new SiteTemplate("Home");
$page->addHeadElement("<link rel='stylesheet' href=styles/layout.css>");
$page->addHeadElement("<style>#home {text-decoration: underline;}</style>");
$page->finalizeTopSection();
$page->finalizeBottomSection();

//header
print $page->getTopSection();

require_once("layout.php");

$message = "";
//check that user is logged in
if (!isset($_SESSION["isLoggedIn"])) {
  $_SESSION["errors"][] = "<h3 id='message'>You are not currently logged in.</h3>";
  die(header("Location: " . LOGIN_PAGE));
}
$message = "<h3 id='message'>Welcome " . $_SESSION["name"] . "</h3>";
print $message;
$message = "<p>Role: " . $_SESSION["role"] . "</p>";
print $message;
$message = "<p>Email: <a href=mailto:" . $_SESSION["email"] . ">" . $_SESSION["email"] . "</a></p>";
print $message;
print $page->getBottomSection();
