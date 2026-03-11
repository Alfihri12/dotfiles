import QtQuick
import Quickshell
import Quickshell.Services.UPower

Item {
    id: root

    implicitHeight: 30
    implicitWidth: batteryText.implicitWidth + 10

    UPower {
        id: upower
    }

    property var battery: upower.displayDevice

    Text {
        id: batteryText
        anchors.centerIn: parent

        text: {
            if (!battery) {
                return "N/A"
            }

            let percent = Math.round(battery.percentage * 100)

            if (battery.state === UPowerDeviceState.Charging)
                return "⚡ " + percent + "%"

            return "🔋 " + percent + "%"
        }

        color: "white"
        font.pixelSize: 14
    }
}