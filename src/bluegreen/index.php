<?php

$myColor = 'grey';

$envColor    = getenv("myCOLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $myColor = $envColor;
}

$output = [ 'HOSTNAME' =>  getenv("HOSTNAME"),
            'myCOLOR'  => $myColor ];

echo json_encode( $output );

echo "\n";
?>
