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
            text: "Icon Alignment — compare visual mass against red line"
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

        readonly property var entries: [
            { code: 0,  isDay: true,  label: "0"   },
            { code: 0,  isDay: false, label: "0n"  },
            { code: 1,  isDay: true,  label: "1"   },
            { code: 1,  isDay: false, label: "1n"  },  // partly cloudy NIGHT (moon + cloud)
            { code: 3,  isDay: true,  label: "3"   },
            { code: 45, isDay: true,  label: "45"  },
            { code: 61, isDay: true,  label: "61"  },
            { code: 71, isDay: true,  label: "71"  },
            { code: 95, isDay: true,  label: "95"  }
        ]

        RowLayout {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter
            spacing: 2   // tight — close together so eye catches any height difference

            Repeater {
                model: entries
                delegate: ColumnLayout {
                    Layout.preferredWidth: 64
                    spacing: 0
                    Layout.alignment: Qt.AlignHCenter

                    // Icon box with center line
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
                        opacity: 0.5
                    }
                }
            }
        }
    }

    toolTipMainText: "Weather Icons Demo"
    toolTipSubText: "Tight horizontal row, red center line on each"
}
