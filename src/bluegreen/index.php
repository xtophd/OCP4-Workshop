<?php

$myColor = 'grey';

$envColor    = getenv("myCOLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $myColor = $envColor;
}

$output = [ 'HOSTNAME' =>  getenv("HOSTNAME") ];
$output = [ 'myCOLOR' => $myColor ];

echo json_encode( $output );

echo "\n";
?>
