<?php

$myColor = 'grey';

$envColor = getenv("COLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $myColor = $envColor;
}

$output = [ 'COLOR' => $myColor ];

echo json_encode( $output );

phpinfo();

echo "\n";
?>
