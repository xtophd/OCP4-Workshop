<?php

$envColor = getenv("COLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $myColor = $envColor;
} else {
  $myColor = 'grey';
} 
    
$output = [ 'COLOR' => $myColor ];

echo json_encode( $output );
echo "\n";
?>
