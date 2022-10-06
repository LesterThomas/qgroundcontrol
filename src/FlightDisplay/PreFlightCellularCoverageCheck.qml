/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

/*******************************************************************
 *
 * 5G Flyers Catalyst addition - checking Cellular Coverage
 *
 ********************************************************************/

import QtQuick 2.3

import QGroundControl           1.0
import QGroundControl.Controls  1.0
import QGroundControl.Vehicle   1.0

PreFlightCheckButton {
    name:               qsTr("Cellular coverage")           // LT Added
    Component.onCompleted: updateNetworkCoverageStatus()

    function updateNetworkCoverageStatus() {
        console.log('Inside PreFlightCellularCoverageCheck:updateNetworkCoverageStatus')
        telemetryTextFailure = 'Getting network status...'
        telemetryFailure = true;

        var http = new XMLHttpRequest()
        var url = "http://localhost:3000/networkCoverage?geoFenceLon=5.11.12;geoFenceLat=53.11.12;geoFenceDia=145;";
        http.open("GET", url, true);
        http.onload = function() {
          if (http.status !== 200) { // analyze HTTP status of the response
            console.log(`Error ${http.status}: ${http.statusText}`); // e.g. 404: Not Found
            telemetryFailure = true;
          } else { // show the result
            console.log(`Done, got ${http.response.length} bytes`); // response is the server response
            console.log(http.response);
            telemetryTextFailure = 'Network coverage OK.'
            telemetryFailure = false;
          }
        };
        http.send();

    }
}
