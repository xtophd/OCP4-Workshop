<?php

$envColor = getenv("COLOR");

if (( $envColor != 'blue') || ($envColor != 'green')) {
  $color = 'grey';
} 

echo "$mycolor" ;

?>
