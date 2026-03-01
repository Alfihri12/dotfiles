import QtQuick
import Quickshell
import Quickshell.Hyprland

PanelWindow {
    implicitHeight: 30     

    anchors {
        top: true
        left: true
        right: true
    }

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
        
    }

    Text {
        text: Qt.formatDateTime(clock.date, "hh:mm:ss")
        anchors.centerIn: parent
    }

}
