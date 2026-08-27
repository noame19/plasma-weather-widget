// RaindropIcon.qml — precipitation amount indicator.
// Teardrop + 3 small drops below to convey "amount of rain falling".
// Stroke widths mirror BarometerIcon so they read as a matched pair.
import QtQuick
import org.kde.kirigami as Kirigami

Item {
    id: root
    implicitWidth: Kirigami.Units.iconSizes.small
    implicitHeight: Kirigami.Units.iconSizes.small

    property color iconColor: Kirigami.Theme.textColor

    readonly property real strokeBold: Math.max(1.6, width * 0.082)
    readonly property real strokeMed: Math.max(1.3, width * 0.065)

    Canvas {
        id: drop
        anchors.fill: parent
        antialiasing: true
        renderStrategy: Canvas.Cooperative

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            var w = width
            var h = height
            var cx = w * 0.5

            var topY = h * 0.18
            var bottomY = h * 0.72
            var leftX = cx - w * 0.22
            var rightX = cx + w * 0.22

            // Teardrop body: pointed top, rounded bottom
            // Path: apex (top) -> right side curve -> bottom round -> left side curve -> apex
            ctx.beginPath()
            ctx.moveTo(cx, topY)
            ctx.bezierCurveTo(rightX + w * 0.18, h * 0.40,
                              rightX + w * 0.10, h * 0.62,
                              cx, bottomY)
            ctx.bezierCurveTo(leftX - w * 0.10, h * 0.62,
                              leftX - w * 0.18, h * 0.40,
                              cx, topY)
            ctx.closePath()
            ctx.strokeStyle = root.iconColor
            ctx.lineWidth = root.strokeBold
            ctx.lineJoin = "round"
            ctx.stroke()

            // Three small drops below (filled) — convey "amount"
            ctx.fillStyle = root.iconColor
            var dropY = h * 0.86
            var dropR = Math.max(1.2, w * 0.045)
            var offsets = [-0.28, 0, 0.28]
            for (var i = 0; i < 3; i++) {
                ctx.beginPath()
                ctx.arc(cx + offsets[i] * w, dropY, dropR, 0, Math.PI * 2)
                ctx.fill()
            }
        }

        onWidthChanged: requestPaint()
        onHeightChanged: requestPaint()
    }

    onIconColorChanged: drop.requestPaint()
}
