<html>
  <body>
<?php

$envColor = getenv("COLOR");

if (( $envColor == 'blue') || ($envColor == 'green')) {
  $myColor = $envColor;
} else {
  $myColor = 'grey';
} 

echo "$myColor\n" ;
?>
  </body>
</html>
