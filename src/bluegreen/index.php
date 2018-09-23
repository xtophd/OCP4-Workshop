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
    
    // echo json_decode(file_get_contents($myRoute), true);

    // do {
        
        $j_array = json_decode(file_get_contents($myRoute), true);

        print_r ($j_array);
    
      //  $output = [ 'myMode'     => $j_array['myMode']['value'],
      //             'myColor'    => $j_array['myColor']['value'],
      //              'myRoute'    => $j_array['myRoute']['value'],
      //              'myStatus'   => $j_array['myStatus']['value'],
      //              'myHostname' => getenv("HOSTNAME") ];
    
      //  echo json_encode( $output );        
            
    // } while ();
        
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
