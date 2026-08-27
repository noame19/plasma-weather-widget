// BarometerIcon.qml — theme-aware dial icon, stroke weights
// tuned to match Breeze system icons (e.g. compass at iconSizes.small).
// Drawn with QML Canvas so no icon-theme dependency.
import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: root
    implicitWidth: Kirigami.Units.iconSizes.small
    implicitHeight: Kirigami.Units.iconSizes.small

    property color iconColor: Kirigami.Theme.textColor

    // Stroke widths — chosen so at 22px width, the outer ring reads at
    // ~1.8px, matching Breeze compass icon weight.
    readonly property real strokeBold: Math.max(1.6, width * 0.082)
    readonly property real strokeMed: Math.max(1.3, width * 0.065)
    readonly property real strokeThin: Math.max(1.0, width * 0.05)

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
            var cx = w * 0.5
            var cy = h * 0.55
            var r = Math.min(w, h * 1.4) * 0.32

            ctx.strokeStyle = root.iconColor
            ctx.lineCap = "round"

            // Outer ring
            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.lineWidth = root.strokeBold
            ctx.stroke()

            // 4 major ticks (N/E/S/W)
            ctx.lineWidth = root.strokeMed
            for (var i = 0; i < 4; i++) {
                var a = i * Math.PI / 2 - Math.PI / 2
                ctx.beginPath()
                ctx.moveTo(cx + Math.cos(a) * r * 0.74, cy + Math.sin(a) * r * 0.74)
                ctx.lineTo(cx + Math.cos(a) * r * 0.93, cy + Math.sin(a) * r * 0.93)
                ctx.stroke()
            }

            // 4 minor ticks (NE/SE/SW/NW)
            ctx.lineWidth = root.strokeThin
            for (var j = 0; j < 4; j++) {
                var ma = j * Math.PI / 2 + Math.PI / 4 - Math.PI / 2
                ctx.beginPath()
                ctx.moveTo(cx + Math.cos(ma) * r * 0.84, cy + Math.sin(ma) * r * 0.84)
                ctx.lineTo(cx + Math.cos(ma) * r * 0.93, cy + Math.sin(ma) * r * 0.93)
                ctx.stroke()
            }

            // Needle — points upper-right (default pressure 1013 hPa)
            ctx.beginPath()
            ctx.moveTo(cx, cy)
            ctx.lineTo(cx + Math.cos(-Math.PI / 4) * r * 0.68,
                       cy + Math.sin(-Math.PI / 4) * r * 0.68)
            ctx.lineWidth = root.strokeBold
            ctx.stroke()

            // Center pivot dot (filled)
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
