import QtQuick
import Quickshell
import "components"

PanelWindow {

    implicitHeight: 30
    color: "#221d1d1b"

    anchors {
        top: true
        left: true
        right: true
    }

    Row {
        anchors.fill: parent
        spacing: 15

        Clock {}

        // Battery {}
    }
}