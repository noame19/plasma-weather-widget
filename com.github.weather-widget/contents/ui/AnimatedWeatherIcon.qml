import QtQuick

Item {
    id: root
    property int weatherCode: 0
    property bool isDay: true

    // Per-weather-code vertical offset to align visual mass centers.
    // Each icon sub-QML draws its content at slightly different Y positions
    // (rain/snow/storm have cloud at top + drops below; partly-cloudy has
    // sun top + cloud bottom; overcast has cloud lower). Without this offset
    // adjacent columns look vertically "crooked". Negative = shift UP,
    // positive = shift DOWN, all relative to current icon height.
    readonly property real vOffset: {
        var c = weatherCode
        // Cloud-bearing icons that are bottom-heavy (cloud sits below 50%)
        if (c === 1 || c === 2) return -height * 0.08   // partly cloudy: cloud y=42-97
        if (c === 3)            return -height * 0.06   // overcast: front cloud y=38-92
        // Single-shape icons centered ~ OK
        if (c === 0)            return 0
        if (c === 45 || c === 48) return height * 0.02   // fog: bars at y=20-73 (slightly high)
        // Rain/snow/storm: cloud at TOP (y=4-54), drops at y=52-90. Visual
        // mass is upper-half; shift DOWN so cloud centerline lands near 50%.
        if (c >= 51 && c <= 82) return height * 0.06    // rain
        if (c >= 56 && c <= 86) return height * 0.06    // snow
        if (c >= 95 && c <= 99) return height * 0.06    // storm
        return 0
    }

    Loader {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: root.vOffset
        width: parent.width
        height: parent.height
        sourceComponent: {
            switch (root.weatherCode) {
                case 0:  return root.isDay ? _clearDay    : _clearNight
                case 1:
                case 2:  return root.isDay ? _partlyDay   : _partlyNight
                case 3:  return _overcast
                case 45:
                case 48: return _fog
                case 51:
                case 53:
                case 55:
                case 61:
                case 63:
                case 65:
                case 80:
                case 81:
                case 82: return _rain
                case 56:
                case 57:
                case 66:
                case 67:
                case 71:
                case 73:
                case 75:
                case 77:
                case 85:
                case 86: return _snow
                case 95:
                case 96:
                case 99: return _storm
                default: return root.isDay ? _clearDay : _clearNight
            }
        }
    }

    Component { id: _clearDay;    ClearDayIcon          {} }
    Component { id: _clearNight;  ClearNightIcon        {} }
    Component { id: _partlyDay;   PartlyCloudyDayIcon   {} }
    Component { id: _partlyNight; PartlyCloudyNightIcon {} }
    Component { id: _overcast;    OvercastIcon          {} }
    Component { id: _fog;         FogIcon               {} }
    Component { id: _rain;        RainIcon              {} }
    Component { id: _snow;        SnowIcon              {} }
    Component { id: _storm;       StormIcon             {} }
}
