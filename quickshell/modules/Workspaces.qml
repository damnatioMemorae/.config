import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.services
import qs.modules
import qs.theme as Theme

Item {
        id: root
        property int maxWorkspaces: 9

        // Sizes
        property int sizeSmall:  8
        property int sizeMedium: 8
        property int sizeLarge:  24

        readonly property var occupiedMap: Hyprland.workspaces.values.reduce(
                (acc, ws) => {
                        const winCount = (ws.lastIpcObject && ws.lastIpcObject.windows) || 0
                        acc[ws.id]     = winCount > 0
                        return acc
                },
                {}
        )

        implicitWidth:  bg.implicitWidth
        implicitHeight: bg.implicitHeight

        Rectangle {
                id: bg

                color: "transparent"
                anchors.centerIn: parent

                implicitWidth:  row.implicitWidth
                implicitHeight: row.implicitHeight

                Column {
                        id: row

                        spacing: 8
                        anchors.centerIn: parent

                        Repeater {
                                model: root.maxWorkspaces

                                Rectangle {
                                        id: wsBox
                                        property int wid: index + 1

                                        property bool isFocused:
                                        Hyprland.focusedWorkspace
                                        && Hyprland.focusedWorkspace.id === wid

                                        property bool isOccupied: occupiedMap[wid] === true

                                        // size logic
                                        property int prefWidth: 8
                                        property int prefHeight: isFocused ? root.sizeLarge : isOccupied ? root.sizeMedium : root.sizeSmall

                                        width: prefWidth
                                        height: prefHeight

                                        Behavior on width {
                                                NumberAnimation {
                                                        duration: 400
                                                        easing.type: Easing.OutElastic
                                                }
                                        }

                                        // colors based on state
                                        property color workspaceStateColor: {
                                                if (isFocused)
                                                return Theme.Theme.surface0
                                                if (isOccupied)
                                                return Theme.Theme.surface0
                                                return Theme.Theme.bttnbg
                                        }

                                        color: workspaceStateColor

                                        Behavior on color {
                                                ColorAnimation { duration: 150 }
                                        }

                                        property bool hovered: false

                                        Rectangle {
                                                anchors.fill: parent
                                                color: Theme.Theme.bg
                                                opacity: wsBox.hovered ? 0.18 : 0
                                                Behavior on opacity { NumberAnimation { duration: 150 } }
                                        }

                                        SequentialAnimation {
                                                id: bounceAnim
                                                running: false
                                                loops: 1

                                                // NumberAnimation { target: wsBox; property: "scale"; to: 1.20; duration: 120; easing.type: Easing.OutQuad }
                                                // NumberAnimation { target: wsBox; property: "scale"; to: 0.92; duration: 120; easing.type: Easing.InOutQuad }
                                                NumberAnimation { target: wsBox; property: "scale"; to: 1.0; duration: 130; easing.type: Easing.OutElastic }
                                                NumberAnimation { target: wsBox; property: "scale"; to: 1.0; duration: 130; easing.type: Easing.InElastic }
                                                NumberAnimation { target: wsBox; property: "scale"; to: 1.0; duration: 130; easing.type: Easing.OutInElastic }
                                        }

                                        Connections {
                                                target: Hyprland
                                                onFocusedWorkspaceChanged: {
                                                        if (wsBox.isFocused) {
                                                                wsBox.scale = 1
                                                                bounceAnim.start()
                                                        }
                                                }
                                        }

                                        MouseArea {
                                                anchors.fill: parent
                                                hoverEnabled: true
                                                cursorShape: Qt.PointingHandCursor

                                                onEntered: wsBox.hovered = true
                                                onExited: wsBox.hovered = false
                                                onClicked: Hyprland.dispatch("workspace " + wsBox.wid)
                                        }
                                }
                        }
                }
        }
}
