<?php
//external pages
require_once("includes.php");
require_once("classes/SiteTemplate.php");
require_once("layout.php");
require_once("classes/WebServiceClient.php");

//setting header and footer
$page = new SiteTemplate("Questions");
$page->addHeadElement("<link rel='stylesheet' href=styles/layout.css>");
$page->addHeadElement("<style>#questions {text-decoration: underline;}</style>");
$page->finalizeTopSection();
$page->finalizeBottomSection();
$count;
//header
print $page->getTopSection();

$message = "";
//check that user is logged in
if (!isset($_SESSION["isLoggedIn"])) {
    $_SESSION["errors"][] = "<h3 id='message'>You are not currently logged in.</h3>\n";
    die(header("Location: " . LOGIN_PAGE));
}

if($_SESSION["correct"]) {
    print "<br>Correct!<br>";
    $_SESSION["count"]++;
}
else {
    print "<br>Sorry, that is not the correct answer.<br>";
}

print "<br>You have gotten " . $_SESSION["count"] . " questions correct this session.<br><br>";
print "Click <a href='questions.php'>here</a> for another question!<br><br>";
print "Click <a href='home.php'>here</a> to go home.<br>";
print $page->getBottomSection();
