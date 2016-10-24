import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2
import QtQuick.Controls 2.0
//import QtQuick.Templates 2.0

MouseArea {
    id: mouseArea
    hoverEnabled: true
    implicitWidth: rowLayout.x + rowLayout.implicitWidth
    implicitHeight: rowLayout.implicitHeight + 8

    property int priorityButtonWidth
    property int priorityStartX
    readonly property var priorityColours: ["lawngreen", "beige", "#aaa", "#ddd"]

    Rectangle {
        anchors.fill: parent
        color: mouseArea.containsMouse ? "#22ffffff" : "transparent"
    }
    
    Rectangle {
        width: parent.width
        height: 1
        color: "#777"
    }
    
    Text {
        text: name
        font.pixelSize: 14
        color: "#eee"
        x: 4
        anchors.verticalCenter: parent.verticalCenter
    }

    RowLayout {
        x: priorityStartX - width - 12
        anchors.verticalCenter: parent.verticalCenter

        Button {
            text: "C"
            hoverEnabled: true

            onClicked: pasteButton.enabled = true

            background: Rectangle {
                color: parent.hovered ? "cyan" : "white"
            }
        }

        Button {
            id: pasteButton
            text: "P"
            hoverEnabled: true
            enabled: false

            background: Rectangle {
                color: enabled ? (parent.hovered ? "cyan" : "white") : "grey"
            }
        }
    }

    RowLayout {
        id: rowLayout
        x: priorityStartX
        anchors.verticalCenter: parent.verticalCenter

        Repeater {
            model: priorities
            delegate: Rectangle {
                color: Qt.rgba(c, c, c, 1)
                border.color: Qt.rgba(b, b, b, 1)
                anchors.verticalCenter: parent.verticalCenter

                readonly property real c: Math.min(0.65, 0.15 + (skill / 20))
                readonly property real b: 0.3 + (skill / 20)
                
                Layout.preferredWidth: 28
                Layout.preferredHeight: 28

                MouseArea {
                    acceptedButtons: Qt.LeftButton | Qt.RightButton
                    anchors.fill: parent
                    onClicked: {
                        if (mouse.button === Qt.LeftButton) {
                            priority = (priority == 1 ? -1 : (priority == -1 ? 4 : priority - 1))
                        } else if (mouse.button === Qt.RightButton) {
                            priority = (priority == 4 ? -1 : Math.max(1, priority + 1))
                        }
                    }
                }
                
                Text {
                    text: priority != -1 ? priority : ""
                    font.pixelSize: 16
                    color: priority != -1 ? priorityColours[priority - 1] : "transparent"
                    anchors.centerIn: parent
                }
            }
        }
    }
}
