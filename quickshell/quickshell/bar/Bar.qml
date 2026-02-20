import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.modules
import qs.theme as Theme

PanelWindow {
        id: bar

        property var targetScreen: null

        Binding {
                target: bar
                property: "screen"
                value: bar.targetScreen
                when: bar.targetScreen !== null
        }

        implicitWidth: 36
        color: Theme.Theme.bg
        anchors { top: true; bottom: true; left: true; right: false }
        margins { top: 10; left: 10; right: -10; bottom: 10 }
        WlrLayershell.layer: WlrLayershell.Bottom

        // LEFT
        // RowLayout {
        //         id: leftCluster
        //         anchors.left: parent.left
        //         anchors.leftMargin: 6
        //         anchors.verticalCenter: parent.verticalCenter
        //         height: parent.height
        //         spacing: 6
        //
        //         DateTime { Layout.alignment: Qt.AlignVCenter }
        //         Battery  { Layout.alignment: Qt.AlignVCenter }
        // }

        // CENTER
        RowLayout {
                id: centerCluster
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                spacing: 6

                readonly property real sideW: Math.max(leftContent.implicitWidth, rightContent.implicitWidth)

                Item {
                        Layout.preferredWidth: centerCluster.sideW
                        Layout.minimumWidth: centerCluster.sideW
                        // Layout.fillHeight: true
                        Layout.alignment: Qt.AlignVCenter

                        Column {
                                Workspaces { Layout.alignment: Qt.AlignVCenter }
                        }
                }

                // Item {
                //         Layout.preferredWidth: centerCluster.sideW
                //         Layout.minimumWidth: centerCluster.sideW
                //         Layout.fillHeight: true
                //         Layout.alignment: Qt.AlignVCenter
                //
                //         Row {
                //                 id: rightContent
                //                 anchors.left: parent.left
                //                 anchors.verticalCenter: parent.verticalCenter
                //                 spacing: 6
                //
                //                 Mediaplayer { id: media }
                //         }
                // }
        }

        // RIGHT
        RowLayout {
                id: leftCluster
                anchors.right: parent.right
                anchors.leftMargin: 2
                anchors.rightMargin: 2
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height

                // RightBtn { Layout.alignment: Qt.AlignVCenter }

                Item {
                        Layout.preferredWidth: centerCluster.sideW
                        Layout.minimumWidth: centerCluster.sideW
                        Layout.fillHeight: false
                        Layout.alignment: Qt.AlignVCenter

                        Column {
                                id: leftContent
                                anchors.right: parent.right
                                anchors.bottom: parent.bottom
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 6

                                Memory {}
                                Temperature {}

                                // Power {
                                //         powerIcon:    Qt.resolvedUrl("../assets/power_icons/power-1.svg")
                                //         lockIcon:     Qt.resolvedUrl("../assets/power_icons/lock.svg")
                                //         sleepIcon:    Qt.resolvedUrl("../assets/power_icons/moon.svg")
                                //         logoutIcon:   Qt.resolvedUrl("../assets/power_icons/log-out.svg")
                                //         rebootIcon:   Qt.resolvedUrl("../assets/power_icons/refresh-cw.svg")
                                //         shutdownIcon: Qt.resolvedUrl("../assets/power_icons/power.svg")
                                // }
                        }
                }
        }
}
