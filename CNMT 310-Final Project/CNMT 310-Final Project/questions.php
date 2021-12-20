<?php
//external pages
require_once("includes.php");
require_once("classes/SiteTemplate.php");

//setting header and footer
$page = new SiteTemplate("Questions");
$page->addHeadElement("<link rel='stylesheet' href=styles/layout.css>");
$page->addHeadElement("<style>#questions {text-decoration: underline;}</style>");
$page->finalizeTopSection();
$page->finalizeBottomSection();

//header
print $page->getTopSection();

require_once("layout.php");

$message = "";
//check that user is logged in
if (!isset($_SESSION["isLoggedIn"])) {
    $_SESSION["errors"][] = "<h3 id='message'>You are not currently logged in.</h3>\n";
    die(header("Location: " . LOGIN_PAGE));
}
/****************************form*********************************/
print "<form class='question-form' action='questions_action.php' method='POST'>\n";
if (isset($_SESSION["errors"]) && count($_SESSION["errors"]) > 0) { //if there are any errors print them
    foreach ($_SESSION["errors"] as $errorIndex => $errorMessage) {
        print $errorMessage . "<br><br>\n";
    }
    unset($_SESSION["errors"]); //reset errors
}
/*----------------------------------------------------------------------------------------*/
require_once("classes/WebServiceClient.php");

$client = new WebServiceClient("https://cnmt310.braingia.org/qws/q.php");
$data = array(
    "apikey" => APIKEY,
    "apiuser" => APIUSER
);
$client->setPostFields($data);
$client->ignoreSSL();
$verifyRequest = $client->send();
$verifedObj = json_decode ($verifyRequest, true);

if ($verifedObj["result"] == "Success") {
    console_log("successful retrieval of question");
    $quizQuestion = $verifedObj["question"];
    $_SESSION["answer"] = $verifedObj["answer"];
    console_log($_SESSION["answer"]);
} else {
    $_SESSION["errors"][] = $verifedObj->message;
}

//form content
print "<p>" . $quizQuestion . "</p>\n";
print "<label for='answer'><b>Answer:</b></label>\n";
print "<input type='text' name='answer'><br>\n";
print "<input type='submit' value='Check Answer\n'>";
print "</form>\n";

print $page->getBottomSection();
