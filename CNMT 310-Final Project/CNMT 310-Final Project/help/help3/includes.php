<?php
session_start();
define("LOGIN_PAGE", "login.php");
define("AUTHENTICATED_HOME", "home.php");
define("QUESTIONS_PAGE", "questions.php");
define("ANSWERS_PAGE", "answers.php");
define("LOGOUT", "logout.php");
define("APIUSER", "user12");
define("APIKEY", "jnchgbxvkc");

function console_log($output, $with_script_tags = true)
{
    $js_code = 'console.log(' . json_encode($output, JSON_HEX_TAG) .
        ');';
    if ($with_script_tags) {
        $js_code = '<script>' . $js_code . '</script>';
    }
    echo $js_code;
}
