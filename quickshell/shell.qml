import Quickshell
import QtQuick

PanelWindow {
    anchors {
        top: true
        left: true
        right: true
    }

    margins {
        left: 40
        right: 40
        top: 10
        bottom: 10

        height: 36

        Text {
            anchors.centerIn: parent
            text: "hello world"
        }
    }
}
