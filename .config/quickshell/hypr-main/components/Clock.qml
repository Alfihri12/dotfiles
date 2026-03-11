import QtQuick
import Quickshell

Item {
    id: root

    implicitHeight: 30
    implicitWidth: clockText.implicitWidth + 20

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Rectangle {
        anchors.fill: parent
        radius: 6
        color: "#222222"
    }

    Text {
        id: clockText
        anchors.centerIn: parent

        text: Qt.formatDateTime(clock.date, "HH:mm:ss")

        font.pixelSize: 14
        font.bold: true
        color: "#ffffff"
    }
}