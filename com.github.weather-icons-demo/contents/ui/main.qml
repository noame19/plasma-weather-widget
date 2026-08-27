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
        Layout.preferredWidth: 840
        Layout.minimumWidth: 840
        spacing: 6
        Layout.margins: 12

        PlasmaComponents.Label {
            text: "All WMO codes AnimatedWeatherIcon handles (31 entries)"
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

        // Comprehensive: every code AnimatedWeatherIcon handles
        readonly property var entries: [
            { code: 0, isDay: true,  label: "0",   desc: "Clear day" },
            { code: 0, isDay: false, label: "0",   desc: "Clear night" },
            { code: 1, isDay: true,  label: "1",   desc: "Mainly clear" },
            { code: 1, isDay: false, label: "1",   desc: "Partly cloudy night" },
            { code: 2, isDay: true,  label: "2",   desc: "Partly cloudy" },
            { code: 2, isDay: false, label: "2",   desc: "Partly cloudy night" },
            { code: 3, isDay: true,  label: "3",   desc: "Overcast" },
            { code: 45, isDay: true, label: "45",  desc: "Fog" },
            { code: 48, isDay: true, label: "48",  desc: "Rime fog" },
            { code: 51, isDay: true, label: "51",  desc: "Light drizzle" },
            { code: 53, isDay: true, label: "53",  desc: "Mod drizzle" },
            { code: 55, isDay: true, label: "55",  desc: "Dense drizzle" },
            { code: 56, isDay: true, label: "56",  desc: "Freezing drizzle" },
            { code: 57, isDay: true, label: "57",  desc: "Freezing drizzle" },
            { code: 61, isDay: true, label: "61",  desc: "Light rain" },
            { code: 63, isDay: true, label: "63",  desc: "Moderate rain" },
            { code: 65, isDay: true, label: "65",  desc: "Heavy rain" },
            { code: 66, isDay: true, label: "66",  desc: "Freezing rain" },
            { code: 67, isDay: true, label: "67",  desc: "Freezing rain" },
            { code: 71, isDay: true, label: "71",  desc: "Light snow" },
            { code: 73, isDay: true, label: "73",  desc: "Moderate snow" },
            { code: 75, isDay: true, label: "75",  desc: "Heavy snow" },
            { code: 77, isDay: true, label: "77",  desc: "Snow grains" },
            { code: 80, isDay: true, label: "80",  desc: "Light showers" },
            { code: 81, isDay: true, label: "81",  desc: "Moderate showers" },
            { code: 82, isDay: true, label: "82",  desc: "Violent showers" },
            { code: 85, isDay: true, label: "85",  desc: "Snow showers" },
            { code: 86, isDay: true, label: "86",  desc: "Snow showers" },
            { code: 95, isDay: true, label: "95",  desc: "Thunderstorm" },
            { code: 96, isDay: true, label: "96",  desc: "Thunder + hail" },
            { code: 99, isDay: true, label: "99",  desc: "Thunder + heavy hail" }
        ]

        GridLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            columns: 8
            rowSpacing: 4
            columnSpacing: 2

            Repeater {
                model: entries
                delegate: ColumnLayout {
                    Layout.preferredWidth: 96
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
