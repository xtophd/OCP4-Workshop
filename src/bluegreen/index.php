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
$myMode     = 'unset';
$myColor    = 'unset';
$myRoute    = getenv("myRoute");
$myStatus   = 'ok';
$myHostname = getenv("HOSTNAME");

$envMode    = getenv("myMode");

if ( $envMode == "watcher") {

    $myMode= "watcher";
    
    // Set a refresh header
    header("Refresh: 3;");
    
    // echo json_decode(file_get_contents($myRoute), true);
    
    // echo file_get_contents($myRoute);
   
    
    // Collect route results until we get repetition, then exit

    // until workerStatus[HOSTNAME] != ''
    //   podStatus = curl myRoute
    //   workStatus[podStatus[myHostname]] = podstatus[myColor]
    //

} elseif ( $envMode == "worker" ) {

    $myMode= "worker";
    
    $envColor   = getenv("myColor");

    if (( $envColor == 'blue') || ($envColor == 'green') || ($envColor == 'red' )) {
        $myColor = $envColor;
    } else {
        $myStatus = "Invalid myColor";
    }

} else {

    // This is essentially the error mode output

    $myStatus = "Invalid myMode";

}

$output = [ 'myMode'     => $myMode,
            'myColor'    => $myColor,
            'myRoute'    => $myRoute,
            'myStatus'   => $myStatus,
            'myHostname' => getenv("HOSTNAME") ];

// Send output

echo json_encode( $output );
echo "\n";

?>
