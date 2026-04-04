import Quickshell
import Quickshell.Io
import QtQuick
import Qt.labs.folderlistmodel
import Quickshell.Wayland

PanelWindow {
    id: main
    implicitHeight: 280
    implicitWidth: Screen.width
    color: "transparent"
    anchors.bottom: true
    anchors.top: false
    margins.bottom: 10
    margins.top: 50

    aboveWindows: true
    exclusionMode: "Ignore"
    exclusiveZone: 1

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    FileView {
        path: Quickshell.shellPath("config.json")
        watchChanges: true
        onFileChanged: reload()
        JsonAdapter {
            id: configs
            property string wallpaper_path
            property string cache_path
            property int    number_of_pictures: 9
            property string border_color: "#00f2ff"
        }
    }

    FolderListModel {
        id: folderModel
        folder: "file://" + configs.wallpaper_path
        nameFilters: ["*.png","*.jpg"]
    }

    PathView {
        id: pv
        anchors.fill: parent
        focus: true
        model: folderModel

        pathItemCount: configs.number_of_pictures
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        snapMode: PathView.SnapToItem
        highlightMoveDuration: 300

        property real baseWidth: width / configs.number_of_pictures

        path: Path {
            startX: -pv.baseWidth; startY: pv.height / 2

            PathAttribute { name: "zVal"; value: 1 }
            PathAttribute { name: "progress"; value: 0.0 }
            PathAttribute { name: "itemOpacity"; value: 1.0 }

            PathLine { x: main.width / 2; y: pv.height / 2 }

            PathAttribute { name: "zVal"; value: 100 }
            PathAttribute { name: "progress"; value: 1.0 }
            PathAttribute { name: "itemOpacity"; value: 1.0 }

            PathLine { x: main.width + pv.baseWidth; y: pv.height / 2 }

            PathAttribute { name: "zVal"; value: 1 }
            PathAttribute { name: "progress"; value: 0.0 }
        }

        delegate: Item {
            id: delegateRoot

            readonly property real imgAspect: (img.implicitWidth > 0) ? (img.implicitWidth / img.implicitHeight) : (16/9)
            readonly property real targetWidth: (pv.height - 10) * imgAspect

            width: pv.baseWidth + ((targetWidth - pv.baseWidth) * (PathView.progress || 0))
            height: 120 + ((pv.height - 130) * (PathView.progress || 0))

            z: PathView.zVal || 1
            opacity: PathView.itemOpacity || 1.0

            Rectangle {
                anchors.centerIn: parent
                width: parent.width
                height: parent.height
                color: "transparent"
                clip: true

                Image {
                    id: img
                    anchors.fill: parent
                    anchors.topMargin: (1.0 - (PathView.progress || 0)) * 5
                    anchors.bottomMargin: (1.0 - (PathView.progress || 0)) * 5

                    source: "file://" + configs.cache_path + model.fileName
                    fillMode: PathView.isCurrentItem ? Image.PreserveAspectFit : Image.PreserveAspectCrop

                    asynchronous: true
                    smooth: true
                    mipmap: true
                }

                Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    border.width: PathView.isCurrentItem ? 3 : 0
                    border.color: configs.border_color
                    z: 5
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: pv.currentIndex = index
            }
        }

        Keys.onPressed: function(event) {
            if (event.key === Qt.Key_Right || event.key === Qt.Key_L) incrementCurrentIndex()
            else if (event.key === Qt.Key_Left || event.key === Qt.Key_H) decrementCurrentIndex()
            else if (event.key === Qt.Key_Return || event.key === Qt.Key_Space) {
                const path = folderModel.get(currentIndex, "filePath")
                Quickshell.execDetached(["bash", Quickshell.shellPath("commands.sh"), path])
                Qt.quit()
            }
            else if (event.key === Qt.Key_Escape) Qt.quit()
            event.accepted = true
        }
    }
}
