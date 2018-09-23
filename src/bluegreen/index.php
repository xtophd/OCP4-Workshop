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
    
    $i_array = array();
    
    while ( true )  {
        
        $j_array = json_decode(file_get_contents($myRoute), true);

        if ( $i_array[$j_array['myHostname']] == 'used' ) {
            break;    
        }
        
        $output = [ 'myMode'     => $j_array['myMode'],
                    'myColor'    => $j_array['myColor'],
                    'myRoute'    => $j_array['myRoute'],
                    'myStatus'   => $j_array['myStatus'],
                    'myHostname' => $j_array['myHostname'] ];
    
        echo json_encode( $output );        
        
        $i_array[$j_array['myHostname']] = 'used';
    }
        
    // Collect route results until we get repetition, then exit

    // until workerStatus[HOSTNAME] != ''
    //   podStatus = curl myRoute
    //   workStatus[podStatus[myHostname]] = podstatus[myColor]
    //

} elseif ( $myMode == "worker" ) {

    if (( $envColor != 'blue') || ($envColor != 'green') || ($envColor != 'red' )) {
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
