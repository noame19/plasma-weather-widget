import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root

    compactRepresentation: Kirigami.Icon {
        source: "weather-showers"
        Layout.preferredWidth: Kirigami.Units.iconSizes.medium
        Layout.preferredHeight: Kirigami.Units.iconSizes.medium
    }

    fullRepresentation: ColumnLayout {
        Layout.preferredWidth: 1500
        Layout.minimumWidth: 1200
        spacing: 6
        Layout.margins: 16

        // Header
        PlasmaComponents.Label {
            text: "Weather Icons — Horizontal Alignment"
            font.bold: true
            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.1
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
        PlasmaComponents.Label {
            text: "All distinct icon types in one row. Red line = box center; your eye compares each icon's visual mass to that line."
            font.pointSize: Kirigami.Theme.smallFont.pointSize
            opacity: 0.6
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            wrapMode: Text.WordWrap
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.topMargin: 4
            Layout.bottomMargin: 4
            height: 1
            color: Kirigami.Theme.textColor
            opacity: 0.2
        }

        // The icons — one cell per distinct WMO code/icon
        readonly property var entries: [
            { code: 0,  isDay: true,  label: "Sun",        vOff: "  0%" },
            { code: 0,  isDay: false, label: "Moon",       vOff: "  0%" },
            { code: 1,  isDay: true,  label: "Partly",     vOff: " -8%" },
            { code: 3,  isDay: true,  label: "Overcast",   vOff: " -6%" },
            { code: 45, isDay: true,  label: "Fog",        vOff: " +2%" },
            { code: 61, isDay: true,  label: "Rain",       vOff: "+16%" },
            { code: 71, isDay: true,  label: "Snow",       vOff: "+16%" },
            { code: 95, isDay: true,  label: "Storm",      vOff: "+16%" }
        ]

        // The single row
        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 14

            Repeater {
                model: entries
                delegate: ColumnLayout {
                    Layout.preferredWidth: 96
                    spacing: 2
                    Layout.alignment: Qt.AlignHCenter

                    // Code number (small, on top)
                    PlasmaComponents.Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "code " + modelData.code + (modelData.isDay ? "" : "·")
                        font.pointSize: Kirigami.Theme.smallFont.pointSize
                        opacity: 0.5
                    }

                    // Icon box with center reference line
                    Item {
                        Layout.preferredWidth: 64
                        Layout.preferredHeight: 64
                        Layout.alignment: Qt.AlignHCenter

                        AnimatedWeatherIcon {
                            anchors.centerIn: parent
                            width: 64
                            height: 64
                            weatherCode: modelData.code
                            isDay: modelData.isDay
                        }

                        // Red centerline reference
                        Rectangle {
                            anchors.left: parent.left
                            anchors.right: parent.right
                            anchors.top: parent.top
                            anchors.topMargin: parent.height / 2 - 1
                            height: 2
                            color: "#ff5555"
                            opacity: 0.5
                            z: 100
                        }
                    }

                    // Label below
                    PlasmaComponents.Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData.label
                        font.bold: true
                        font.pointSize: Kirigami.Theme.smallFont.pointSize
                    }

                    // vOffset value
                    PlasmaComponents.Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: "vOffset" + modelData.vOff
                        font.pointSize: Kirigami.Theme.smallFont.pointSize
                        opacity: 0.5
                    }
                }
            }
        }

        // Bottom note
        PlasmaComponents.Label {
            Layout.topMargin: 8
            text: "↓ Look at the red line: every icon's visual center of mass should sit on it. ↓"
            font.pointSize: Kirigami.Theme.smallFont.pointSize
            opacity: 0.6
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
    }

    toolTipMainText: "Weather Icons Demo (horizontal)"
    toolTipSubText: "Run with: plasmoidviewer -a ."
}
