import QtQuick
import Quickshell.Hyprland

Item {
    id: root

    property int workspaceID: Hyprland.focusedWorkspace?.id ?? 0
    property bool workspaceChanged: false
    property int gridwidth: 7
    property int gridheight: 7
    property color activeColor: '#28f8ff'
    property color inactiveColor: '#646464'

    onWorkspaceIDChanged: {
        workspaceChanged = true
        workspaceTimer.restart()
    }

    Timer {
        id: workspaceTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: root.workspaceChanged = false

    }

    component WorkspaceCell: Rectangle {
        width: gridwidth
        height: gridheight

        Behavior on color {
            ColorAnimation {
                duration: 500
                easing.type: Easing.InOutQuad
            }
        }
    }

    Grid {
        anchors.centerIn: parent
        columns: 3
        spacing: 4

        // Row 1
        Rectangle    { width: gridwidth; height: gridheight; color: "transparent" }
        WorkspaceCell { color: workspaceID === 3 ? activeColor : inactiveColor }
        Rectangle    { width: gridwidth; height: gridheight; color: "transparent" }

        // Row 2
        WorkspaceCell { color: workspaceID === 1 ? activeColor : inactiveColor }
        WorkspaceCell { color: workspaceID === 5 ? activeColor : inactiveColor }
        WorkspaceCell { color: workspaceID === 7 ? activeColor : inactiveColor }

        // Row 3
        Rectangle    { width: gridwidth; height: gridheight; color: "transparent" }
        WorkspaceCell { color: workspaceID === 8 ? activeColor : inactiveColor }
        Rectangle    { width: gridwidth; height: gridheight; color: "transparent" }
    }
}
