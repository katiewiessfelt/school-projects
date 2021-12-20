<?php
//external pages
require_once("includes.php");
require_once("classes/SiteTemplate.php");
require_once("layout.php");
require_once("classes/WebServiceClient.php");

//setting header and footer
$page = new SiteTemplate("Questions");
$page->addHeadElement('<link rel="stylesheet" href=styles/layout.css>');
$page->addHeadElement('<style>#questions {text-decoration: underline;}</style>');
$page->finalizeTopSection();
$page->finalizeBottomSection();

//header
print $page->getTopSection();
$message = "";
//check that user is logged in
if (!isset($_SESSION['name'])) {
    $message = "<h3 id='message'>You are not currently logged in.</h3><br><p>Click <a href='login.php'>here</a> to login.</p>";
    print $message;
} else {
    /****************************form*********************************/
    print "<form class='question-form' action='questions_action.php' method='POST'>";
    if (isset($_SESSION['errors']) && count($_SESSION['errors']) > 0) { //if there are any errors print them
        foreach ($_SESSION['errors'] as $errorIndex => $errorMessage) {
            print $errorMessage . "<br><br>\n";
        }
        unset($_SESSION['errors']); //rest errors
    }
    /*----------------------------------------------------------------------------------------*/
    $client = new WebServiceClient("https://cnmt310.braingia.org/qws/q.php");
    $data = array(
        "apikey" => APIKEY,
        "apiuser" => APIUSER,
        //"password" => "nnETfwcz",
        //"username" => "cwormald"
    );
    $client->setPostFields($data);
    $authenticationRequest = $client->send();
    $authObject = json_decode($authenticationRequest);
    console_log($authObject);
    if (!is_object($authObject)) {
        $_SESSION['errors'][] = "Error: Authentication Issues";
    } else { //if returned data is an object
        if ($authObject->result == "Success") {
            $message = "success";
        } else {
            $_SESSION['errors'][] = $authObject->message;
        }
    }
    /*
    $client = new WebServiceClient("https://cnmt310.braingia.org/qws/q.php");
    $data = array(
        "apikey" => APIKEY,
        "apiuser" => APIUSER
    );
    $question = "";
    $answer = "";
    $client->setPostFields($data);
    $authenticationRequest = $client->send(); //send request
    $authObject = json_decode($authenticationRequest); //return from request
    console_log($authObject);

    //get question and answer
    if (!is_object($authObject)) { //if retuned data is not an object
        $_SESSION['errors'][] = "Error: Authentication Issues";
    } else { //if returned data is an object
        if ($authObject->result == "Success") { //if request returns an object with result as "Success"
            $question = $authObject->question;
            $answer = $authObject->answer;
            //if successful go to questions_action.php
        } else { //if request returns an object with result not "Success"
            $_SESSION['errors'][] = $authObject->message;
        }
        die(header("Location: " . QUESTIONS_PAGE)); //if errors stay on login page
    }*/
    //form content
    print "<h4 id='question' name='question'>" . $question . "</h4>";
    print "<label for='answer'><b>Answer:</b></label>";
    print "<input type='text' name='answer'><br>";
    print "<input type='submit' value='Check Answer'>";
    print "</form>\n";
}

print $page->getBottomSection();
