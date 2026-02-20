//@pragma UseQApplication

import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Io
import qs.theme as Theme

PanelWindow {
        id: bar
        objectName: "bar"

        property string position: "left" // "top" | "bottom" | "left" | "right"
        property int width:  40
        property int height: 40

        property string bg: "#0e0e16"
        // property string bg: "#f38ba8"

        implicitWidth:  horizontal ? parent.width : bar.width
        implicitHeight: horizontal ? height : parent.height

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

                        margins.top    = 10
                        margins.bottom = -10
                        margins.left   = 10
                        margins.right  = 10

                        implicitHeight = bar.height
                }
                if ( pos === "bottom" ) {
                        anchors.top    = false
                        anchors.bottom = true
                        anchors.left   = true
                        anchors.right  = true

                        margins.top    = -10
                        margins.bottom = 10
                        margins.left   = 10
                        margins.right  = 10

                        implicitHeight = bar.height
                }
                if ( pos === "left" ) {
                        anchors.top    = true
                        anchors.bottom = true
                        anchors.left   = true
                        anchors.right  = false

                        margins.top    = 10
                        margins.bottom = 10
                        margins.left   = 10
                        margins.right  = -10

                        implicitWidth  = bar.width
                }
                if ( pos === "right" ) {
                        anchors.top    = true
                        anchors.bottom = true
                        anchors.left   = false
                        anchors.right  = true

                        margins.top    = 10
                        margins.bottom = 10
                        margins.left   = -10
                        margins.right  = 10

                        implicitWidth  = bar.width
                }
        }

        onPositionChanged: applyPosition(position)
        Component.onCompleted: applyPosition(position)

        Rectangle {
                anchors.fill: parent
                color: bar.bg
                radius: 0
        }
        IpcHandler {
                target: "bar"
                function setPosition(position: string): string { bar.position = position }
        }
}
