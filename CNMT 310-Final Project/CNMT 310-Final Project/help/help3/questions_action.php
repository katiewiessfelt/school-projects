<?php //form action upon submission of answer from question.php
//external pages
require_once("includes.php");
require_once("classes/SiteTemplate.php");
require_once("layout.php");

//setting header and footer
$page = new SiteTemplate("Questions");
$page->addHeadElement('<link rel="stylesheet" href=styles/layout.css>');
$page->addHeadElement('<style>#questions {text-decoration: underline;}</style>');
$page->finalizeTopSection();
$page->finalizeBottomSection();

//header
print $page->getTopSection();


$message = "";
//check that the user is logged in
if (!isset($_SESSION['name'])) {
  $message = "<h3 id='message'>You are not currently logged in.</h3><br><p>Click <a href='login.php'>here</a> to login.</p>";
  print $message;
} else { //send the data to server
  /****************************form action*********************************/
  //answer input is required
  $required = array("answer");
  $_SESSION['errors'] = array();
  foreach ($required as $index => $value) {
    if (!isset($_POST[$value]) || empty($_POST[$value])) {
      $_SESSION['errors'][] = "Please enter your answer";
      die(header("Location: " . QUESTIONS_PAGE));
    }
  }
}
print $page->getBottomSection();
