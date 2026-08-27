import QtQuick
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

PlasmoidItem {
    id: root

    // Force day mode so sun/moon show consistently (matches the daily forecast row)
    readonly property bool forceDay: true

    compactRepresentation: Kirigami.Icon {
        source: "weather-showers"
        Layout.preferredWidth: Kirigami.Units.iconSizes.medium
        Layout.preferredHeight: Kirigami.Units.iconSizes.medium
    }

    fullRepresentation: ColumnLayout {
        Layout.preferredWidth: 360
        Layout.minimumWidth: 320
        spacing: 4
        Layout.margins: 12

        PlasmaComponents.Label {
            text: "Weather Icons — Vertical Alignment"
            font.bold: true
            font.pointSize: Kirigami.Theme.defaultFont.pointSize * 1.1
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }
        PlasmaComponents.Label {
            text: "Animated icons @ 48px. Red line = box vertical center."
            font.pointSize: Kirigami.Theme.smallFont.pointSize
            opacity: 0.6
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.topMargin: 6
            Layout.bottomMargin: 6
            height: 1
            color: Kirigami.Theme.textColor
            opacity: 0.2
        }

        readonly property var entries: [
            { code: 0,  label: "0   Clear (sun)",          isDay: true  },
            { code: 0,  label: "0   Clear night (moon)",   isDay: false },
            { code: 1,  label: "1   Mainly clear",         isDay: true  },
            { code: 2,  label: "2   Partly cloudy",        isDay: true  },
            { code: 3,  label: "3   Overcast",             isDay: true  },
            { code: 45, label: "45  Fog",                  isDay: true  },
            { code: 48, label: "48  Depositing rime fog", isDay: true  },
            { code: 51, label: "51  Light drizzle",        isDay: true  },
            { code: 53, label: "53  Moderate drizzle",     isDay: true  },
            { code: 55, label: "55  Dense drizzle",        isDay: true  },
            { code: 61, label: "61  Light rain",           isDay: true  },
            { code: 63, label: "63  Moderate rain",        isDay: true  },
            { code: 65, label: "65  Heavy rain",           isDay: true  },
            { code: 71, label: "71  Light snow",           isDay: true  },
            { code: 73, label: "73  Moderate snow",        isDay: true  },
            { code: 75, label: "75  Heavy snow",           isDay: true  },
            { code: 80, label: "80  Light showers",        isDay: true  },
            { code: 82, label: "82  Violent showers",      isDay: true  },
            { code: 95, label: "95  Thunderstorm",         isDay: true  },
            { code: 96, label: "96  Thunder + hail",       isDay: true  },
            { code: 99, label: "99  Thunder + heavy hail", isDay: true  }
        ]

        Repeater {
            model: entries
            delegate: RowLayout {
                Layout.fillWidth: true
                spacing: 8

                // Code + label
                PlasmaComponents.Label {
                    Layout.preferredWidth: 180
                    Layout.alignment: Qt.AlignVCenter
                    text: modelData.label
                    elide: Text.ElideRight
                    font.pointSize: Kirigami.Theme.smallFont.pointSize
                }

                // Icon box (48x48) with center reference line
                Item {
                    Layout.preferredWidth: 48
                    Layout.preferredHeight: 48
                    Layout.alignment: Qt.AlignVCenter

                    AnimatedWeatherIcon {
                        anchors.centerIn: parent
                        width: 48
                        height: 48
                        weatherCode: modelData.code
                        isDay: modelData.isDay
                    }

                    // Red centerline reference
                    Rectangle {
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.topMargin: parent.height / 2
                        height: 1
                        color: "#ff5555"
                        opacity: 0.4
                        z: 100
                    }
                }

                // Spacer
                Item { Layout.fillWidth: true }

                // vOffset label
                PlasmaComponents.Label {
                    Layout.alignment: Qt.AlignVCenter
                    font.pointSize: Kirigami.Theme.smallFont.pointSize
                    opacity: 0.6
                    horizontalAlignment: Text.AlignRight
                    text: {
                        var c = modelData.code
                        if (c === 1 || c === 2)  return "↑ -8%"
                        if (c === 3)             return "↑ -6%"
                        if (c === 45 || c === 48)return "↓ +2%"
                        if (c >= 51 && c <= 82)  return "↓ +16%"
                        if (c >= 56 && c <= 86)  return "↓ +16%"
                        if (c >= 95 && c <= 99)  return "↓ +16%"
                        return "— 0%"
                    }
                }
            }
        }
    }

    toolTipMainText: "Weather Icons Demo"
    toolTipSubText: "Vertical alignment test for AnimatedWeatherIcon"
}
