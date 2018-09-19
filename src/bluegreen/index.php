<?php

$envColor = getenv("COLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $color = $envColor;
} else {
  $color = 'grey';
} 

echo "$mycolor" ;

?>
