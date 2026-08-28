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
        Layout.preferredWidth: 800
        Layout.minimumWidth: 800
        spacing: 6
        Layout.margins: 12

        PlasmaComponents.Label {
            text: "9 distinct icon variants — compare each against red center line"
            font.bold: true
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.topMargin: 2
            Layout.bottomMargin: 2
            height: 1
            color: Kirigami.Theme.textColor
            opacity: 0.2
        }

        // One entry per DISTINCT icon variant. Each entry shows which
        // WMO codes render that icon (covers AnimatedWeatherIcon.qml
        // switch cases).
        readonly property var entries: [
            { code: 0,  isDay: true,  label: "0d",   desc: "Sun [code 0]" },
            { code: 0,  isDay: false, label: "0n",   desc: "Moon [code 0]" },
            { code: 1,  isDay: true,  label: "1d",   desc: "Sun+cloud [codes 1,2]" },
            { code: 1,  isDay: false, label: "1n",   desc: "Moon+cloud [codes 1,2]" },
            { code: 3,  isDay: true,  label: "3",    desc: "Overcast [code 3]" },
            { code: 45, isDay: true,  label: "45",   desc: "Fog [codes 45,48]" },
            { code: 61, isDay: true,  label: "61",   desc: "Rain [codes 51,53,55,61,63,65,80,81,82]" },
            { code: 71, isDay: true,  label: "71",   desc: "Snow [codes 56,57,66,67,71,73,75,77,85,86]" },
            { code: 95, isDay: true,  label: "95",   desc: "Storm [codes 95,96,99]" }
        ]

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 2   // tight — close together so eye catches any height difference

            Repeater {
                model: entries
                delegate: ColumnLayout {
                    Layout.preferredWidth: 84
                    spacing: 0
                    Layout.alignment: Qt.AlignHCenter

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

                    PlasmaComponents.Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData.label
                        font.pointSize: Kirigami.Theme.smallFont.pointSize
                        font.bold: true
                    }

                    PlasmaComponents.Label {
                        Layout.fillWidth: true
                        horizontalAlignment: Text.AlignHCenter
                        text: modelData.desc
                        font.pointSize: Kirigami.Theme.smallFont.pointSize * 0.85
                        opacity: 0.5
                        elide: Text.ElideRight
                    }
                }
            }
        }
    }

    toolTipMainText: "Weather Icons Demo"
    toolTipSubText: "Tight horizontal row, red center line on each"
}
