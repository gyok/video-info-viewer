import QtQuick 2.13
import QtQuick.Window 2.13
import Qt.labs.folderlistmodel 2.13
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.13

Window {
    visible: true
    minimumWidth: 500
    height: 200
    RowLayout {
        anchors.fill: parent
        ListView {
            Layout.fillHeight: true
            Layout.preferredWidth: 300
            id: fileView
            ScrollBar.vertical: ScrollBar {
                policy: ScrollBar.AlwaysOn
            }

            FolderListModel {
                id: folderModel
                showDirsFirst: true
                showDotAndDotDot: true
            }

            Component {
                id: fileDelegate
                Item {
                    id: wrapper
                    width: fileView.width
                    height: fileInfo.height
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        width: parent.width
                        id: fileInfo
                        text: fileName
                        font.bold: fileIsDir
                        leftPadding: 5
                        topPadding: 5
                        bottomPadding: 5
                        wrapMode: Text.WordWrap
                    }
                    Rectangle {
                        width: parent.width
                        height: 1
                        color: "#8ade9b"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: fileView.currentIndex = index
                        onDoubleClicked: {
                            if (fileIsDir) {
                                folderModel.folder = "file://" + filePath
                            }
                        }
                    }
                }
            }

            Component {
                id: highlightDelegate
                Rectangle {
                    color: "#adf7bc"
                }
            }
            model: folderModel
            delegate: fileDelegate
            highlight: highlightDelegate
            focus: true
            onCurrentItemChanged: console.log(folderModel.get(
                                                  fileView.currentIndex,
                                                  "fileName") + ' selected')
        }

        Rectangle {
            width: 100
            Text {
                text: "ololoo"
            }
        }
    }
}
