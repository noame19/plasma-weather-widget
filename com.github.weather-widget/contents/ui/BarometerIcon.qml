// BarometerIcon.qml — a simple theme-aware barometer dial.
// Drawn with QML Canvas so it never depends on the system icon theme
// (barometer was missing in some Breeze themes and rendered as fallback).
import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: root
    implicitWidth: Kirigami.Units.iconSizes.small
    implicitHeight: Kirigami.Units.iconSizes.small

    // External color matches the rest of the plasmoid (theme text color).
    property color iconColor: Kirigami.Theme.textColor

    Canvas {
        id: dial
        anchors.fill: parent
        antialiasing: true
        renderStrategy: Canvas.Cooperative

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            var w = width
            var h = height
            // Center slightly below middle to leave room for "kPa/hPa" feel
            var cx = w * 0.5
            var cy = h * 0.55
            // Keep dial circular
            var r = Math.min(w, h * 1.4) * 0.32

            // Outer ring
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.strokeStyle = root.iconColor
            ctx.lineWidth = Math.max(1, w * 0.06)
            ctx.stroke()

            // 4 major ticks at N/E/S/W
            ctx.strokeStyle = root.iconColor
            ctx.lineCap = "round"
            ctx.lineWidth = Math.max(1, w * 0.045)
            for (var i = 0; i < 4; i++) {
                var a = i * Math.PI / 2 - Math.PI / 2
                ctx.beginPath()
                ctx.moveTo(cx + Math.cos(a) * r * 0.74, cy + Math.sin(a) * r * 0.74)
                ctx.lineTo(cx + Math.cos(a) * r * 0.93, cy + Math.sin(a) * r * 0.93)
                ctx.stroke()
            }
            // 4 minor ticks at NE/SE/SW/NW
            ctx.lineWidth = Math.max(1, w * 0.025)
            for (var j = 0; j < 4; j++) {
                var ma = j * Math.PI / 2 + Math.PI / 4 - Math.PI / 2
                ctx.beginPath()
                ctx.moveTo(cx + Math.cos(ma) * r * 0.84, cy + Math.sin(ma) * r * 0.84)
                ctx.lineTo(cx + Math.cos(ma) * r * 0.93, cy + Math.sin(ma) * r * 0.93)
                ctx.stroke()
            }

            // Needle — points upper-right (default = 1013 hPa)
            ctx.beginPath()
            ctx.moveTo(cx, cy)
            ctx.lineTo(cx + Math.cos(-Math.PI / 4) * r * 0.68,
                       cy + Math.sin(-Math.PI / 4) * r * 0.68)
            ctx.lineWidth = Math.max(1.5, w * 0.04)
            ctx.lineCap = "round"
            ctx.stroke()

            // Center pivot dot
            ctx.beginPath()
            ctx.arc(cx, cy, Math.max(1.5, w * 0.06), 0, Math.PI * 2)
            ctx.fillStyle = root.iconColor
            ctx.fill()
        }

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }

    onIconColorChanged: dial.requestPaint()
}
