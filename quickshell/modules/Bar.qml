import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import QtQuick.Layouts
import qs.theme as Theme

PanelWindow {
        id: bar
        objectName: "bar"

        property string position: "left" // "top" | "bottom" | "left" | "right"
        property int margin: 10
        property int antiMargin: -0
        property int rotation: 180
        property int width:  36
        property int height: 36

        property string bg: Theme.Theme.bg
        property bool horizontal: false

        implicitWidth:  horizontal ? parent.width : bar.width
        implicitHeight: horizontal ? height : bar.height

        function setPosition(pos) {
                if (["top", "bottom", "left", "right"].indexOf(pos) === -1) {
                        console.log("Invalid position:", pos)
                        return
                }

                position = pos
                console.log("Bar moved to", position)
        }

        function applyPosition(pos) {
                anchors.top    = undefined
                anchors.bottom = undefined
                anchors.left   = undefined
                anchors.right  = undefined

                margins.top    = 0
                margins.bottom = 0
                margins.left   = 0
                margins.right  = 0

                if ( pos === "top" ) {
                        anchors.top    = true
                        anchors.bottom = false
                        anchors.left   = true
                        anchors.right  = true

                        margins.top    = margin
                        margins.bottom = antiMargin
                        margins.left   = margin
                        margins.right  = margin

                        rotation       = 90
                        implicitHeight = bar.height
                }
                if ( pos === "bottom" ) {
                        anchors.top    = false
                        anchors.bottom = true
                        anchors.left   = true
                        anchors.right  = true

                        margins.top    = antiMargin
                        margins.bottom = margin
                        margins.left   = margin
                        margins.right  = margin

                        rotation       = 90
                        implicitHeight = bar.height
                }
                if ( pos === "left" ) {
                        anchors.top    = true
                        anchors.bottom = true
                        anchors.left   = true
                        anchors.right  = false

                        margins.top    = margin
                        margins.bottom = margin
                        margins.left   = margin
                        margins.right  = antiMargin

                        rotation       = 180
                        implicitWidth  = bar.width
                }
                if ( pos === "right" ) {
                        anchors.top    = true
                        anchors.bottom = true
                        anchors.left   = false
                        anchors.right  = true

                        margins.top    = margin
                        margins.bottom = margin
                        margins.left   = antiMargin
                        margins.right  = margin

                        rotation       = 180
                        implicitWidth  = bar.width
                }
        }

        onPositionChanged: applyPosition(position)
        Component.onCompleted: applyPosition(position)

        color: bar.bg

        RowLayout {}
        ColumnLayout {
                id: leftPart
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.topMargin: 30
                spacing: 10
        }

        ColumnLayout {
                id: centerPart
                anchors.centerIn: parent
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                spacing: 10
                Workspaces {
                        rotation: bar.rotation
                        Layout.alignment: Qt.AlignVCenter
                }
        }

        ColumnLayout {
                id: rightPart
                anchors.right: parent.right
                height: parent.height
        }

        IpcHandler {
                target: "bar"
                function setPosition(position: string): string { bar.position = position }
        }
}
