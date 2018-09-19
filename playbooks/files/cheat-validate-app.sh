#!/bin/bash

MYROUTE=`oc get routes --no-headers | awk '{ print $2 }'`

echo "Validating output from ${MYROUTE}"
echo ""

curl ${MYROUTE}
