<?php

//  You set myMode, myColor, myRoute as ENV variables in the OCP deployment config
//
//  This program has 2 modes:
//    myMode = worker 
//      Input: myColor = {red,blue,grean}
//      Output: myMode, myColor, myHostname, myStatus
//
//    myMode = watcher 
//      Input: myRoute = {exposed service (route) to watch}
//      Output: matrix of results calling OCP route
//

// Initialize Variables

$myMode     = getenv("myMode");
$myColor    = getenv("myColor");
$myRoute    = getenv("myRoute");
$myHostname = getenv("HOSTNAME");
$myStatus   = 'ok';

if ( $myMode == "watcher") {
    
    // Set a refresh header
    header("Refresh: 3;");
    
    $used_array = array();

    echo "<HTML><BODY>";
    echo "<TABLE>";
    echo "<TR><TH>Pod Name</TH><TH>Color</TH></TR>";
        
    // Collect route results until we get repetition, then exit

    while ( true )  {
        
        $j_array = json_decode(file_get_contents($myRoute), true);

        if ( $used_array[$j_array['myHostname']] == 'used' ) {
            break;    
        }
              
        printf("<TR><TH>%s</TH><TH>%s</TH></TR>\n",$j_array['myHostname'],$j_array['myColor']);

        $used_array[$j_array['myHostname']] = 'used';
    }

    echo "</TABLE>";
    echo "</BODY></HTML>";
  
} elseif ( $myMode == "worker" ) {

    if (( $myColor != 'blue') && ($myColor != 'green') && ($myColor != 'red' )) {
        $myStatus = "Invalid Color";
    }

    $output = [ 'myMode'     => $myMode,
            'myColor'    => $myColor,
            'myRoute'    => $myRoute,
            'myStatus'   => $myStatus,
            'myHostname' => getenv("HOSTNAME") ];

    // Send output

    echo json_encode( $output );
    echo "\n";
     
} else {

    $myStatus = "Invalid Mode";

}

http_response_code(200);

?>
