<?php

//
//  This program has 2 modes:
//    myMode = worker myColor = {red,blue,grean}
//      
//      Output => myMode, myColor, HOSTNAME
//
//    myMode = watcher myRoute = {exposed route to watch}
//
//      Output => matrix of results calling OCP route
//
//  You set myMode, myColor, myRoute are ENV variables in the OCP deployment config
//

// Initialize Variables
$myColor  = 'unset';
$myMode   = 'unset';
$myRoute  = 'unset';

$envMode    = getenv("myMode");

if ( $envMode == "watcher") {

    // Set a refresh header
    header("Refresh: 3;");

    $envRoute   = getenv("myRoute");

                 
    // Collect route results until we get repetition, then exit

    // until workerStatus[HOSTNAME] != ''
    //   podStatus = curl myRoute
    //   workStatus[podStatus[myHostname]] = podstatus[myColor]
    //

    $output = [ 'myMode'     => $myMode,
                'myRoute'    => $myRoute, 
                'myHostname' => getenv("HOSTNAME"),
                'myStatus'   => "ok" ];

} elseif ( $envMode == "worker" ) {

    $envColor   = getenv("myColor");

    if (( $envColor == 'blue') || ($envColor == 'green') || ($envColor == 'red' )) {
        $myColor = $envColor;
    }

    $output = [ 'myMode'     => $myMode,
                'myColor'    => $myColor, 
                'myHostname' => getenv("HOSTNAME"),
                'myStatus'   => "ok" ];
                
} else {

    // This is essentially the error mode output

    $output = [ 'myMode'     => $myMode,
                'myColor'    => $myColor,
                'myRoute'    => $myRoute,
                'myStatus'   => "error" ];
}

// Send output

echo json_encode( $output );
echo "\n";

?>
