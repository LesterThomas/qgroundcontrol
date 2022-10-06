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
 * 5G Flyers Catalyst addition - checking Cellular Feasibility
 *
 ********************************************************************/

import QtQuick 2.3

import QGroundControl           1.0
import QGroundControl.Controls  1.0
import QGroundControl.Vehicle   1.0

PreFlightCheckButton {
    name:               qsTr("Cellular feasibility")           // LT Added
//    cellularFeasibilityGood:   false                           // LT Added
    telemetryFailure:   _unhealthySensors & _allCheckedSensors

    property int    _unhealthySensors:  globals.activeVehicle ? globals.activeVehicle.sensorsUnhealthyBits : 1
    property int    _allCheckedSensors: Vehicle.SysStatusSensor3dMag |
                                        Vehicle.SysStatusSensor3dAccel |
                                        Vehicle.SysStatusSensor3dGyro |
                                        Vehicle.SysStatusSensorAbsolutePressure |
                                        Vehicle.SysStatusSensorDifferentialPressure |
                                        Vehicle.SysStatusSensorGPS |
                                        Vehicle.SysStatusSensorAHRS

    on_UnhealthySensorsChanged: updateNetworkFeasibilityStatus()

    Component.onCompleted: updateNetworkFeasibilityStatus()

    function updateTelemetryTextFailure() {
        console.log('Inside PreFlightCellularFeasibilityCheck:updateTelemetryTextFailure')
        if(_unhealthySensors & _allCheckedSensors) {
            if (_unhealthySensors & Vehicle.SysStatusSensor3dMag)                       telemetryTextFailure = qsTr("Failure. Magnetometer issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensor3dAccel)                 telemetryTextFailure = qsTr("Failure. Accelerometer issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensor3dGyro)                  telemetryTextFailure = qsTr("Failure. Gyroscope issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensorAbsolutePressure)        telemetryTextFailure = qsTr("Failure. Barometer issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensorDifferentialPressure)    telemetryTextFailure = qsTr("Failure. Airspeed sensor issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensorAHRS)                    telemetryTextFailure = qsTr("Failure. AHRS issues. Check console.")
            else if(_unhealthySensors & Vehicle.SysStatusSensorGPS)                     telemetryTextFailure = qsTr("Failure. GPS issues. Check console.")
        }
    }

    function updateNetworkFeasibilityStatus() {
        console.log('Inside PreFlightCellularFeasibilityCheck:updateNetworkFeasibilityStatus')
        // use test REST api https://reqres.in/api/users?page=2
        telemetryTextFailure = 'Getting network status.'
        telemetryFailure = true;

        var http = new XMLHttpRequest()
        var url = "http://localhost:3000/networkFeasibility?geoFenceLon=5.11.12;geoFenceLat=53.11.12;geoFenceDia=145;";
        http.open("GET", url, true);
        http.onload = function() {
          if (http.status !== 200) { // analyze HTTP status of the response
            console.log(`Error ${http.status}: ${http.statusText}`); // e.g. 404: Not Found
            telemetryFailure = true;
          } else { // show the result
            console.log(`Done, got ${http.response.length} bytes`); // response is the server response
            console.log(http.response);
            telemetryTextFailure = 'Network feasibility OK.'
            telemetryFailure = false;
          }
        };
        http.send();

    }
}
