/****************************************************************************
 *
 *   (c) 2009-2016 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                      2.11
import QtQuick.Controls             2.4
import QtQml.Models                 2.1

import QGroundControl               1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Controls      1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.Vehicle       1.0

Item {
    property var model: listModel
    PreFlightCheckModel {
        id:     listModel
        PreFlightCheckGroup {
            name: qsTr("Multirotor Initial Checks")

            PreFlightCheckButton {
                name:           qsTr("Network")
                manualText:     qsTr("Check coverage for mission")
            }
            PreFlightCheckButton {
                name:           qsTr("Network")
                manualText:     qsTr("Order dynamic 5G slice, confirm network status")
            }            
            PreFlightCheckButton {
                name:           qsTr("No-Fly zones")
                manualText:     qsTr("Mission does not intersect with active no-fly zones")
            }

            PreFlightCheckButton {
                name:           qsTr("Weather")
                manualText:     qsTr("Forecast weather within tollerance")
            }
            
            PreFlightCheckButton {
                name:           qsTr("Hardware")
                manualText:     qsTr("Drone hardware self-check")
            }
                        
            PreFlightBatteryCheck {
                failurePercent:                 40
                allowFailurePercentOverride:    false
            }

            PreFlightSensorsHealthCheck {
            }

            PreFlightGPSCheck {
                failureSatCount:        9
                allowOverrideSatCount:  true
            }

            PreFlightRCCheck {
            }
        }
    }
}

