# 5G Chargers changes and enhancements to QGroundControl

These changes are focused on interacting with Network APIs to plan and execute drone missions using 5G. The planning mission data is used to check Network coverage (including checking coverage at different altitudes). As part of the check-list to execute a mission, the enhanced QGroundControl orders 5G Network slices to configure a slicing route between the ground-station and the Drone, and to create two slices:

1. A high availability and low-latency control slice for the control of the drone.
2. A high bandwidth video slice for transmitting HD video from the drone.

## List of changes

Updating the UI in `src_FlightDisplay_MultiRotorChecklist_qml` to add additional items to the checklist (/Resources/qgroundcontrol.qrc/checklists/MultiRotorChecklist.qml)

Adding CellularCoverage check:

1. Added file (under Resources/qgroundcontrol.qrc/qml/QGroundControl/FlightDisplay/PreFlightCellularCoverageCheck.qml)
2. Added file alias in qgroundcontrol.qrc
3. Updated Resources/qgroundcontrol.qrc/qml/QGroundControl/FlightDisplay/qmldir to incude PreFlightCellularCoverageCheck

under build menu run qmake to rebuild the makefiles

4. run


# Demonstration

There is a video recording of the demonstration for DTW 2022 Copenhagen at: 
