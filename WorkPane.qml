import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

Rectangle {
    id: workPane
    width: firstItem ? firstItem.implicitWidth + columnLayout.anchors.leftMargin + columnLayout.anchors.rightMargin : 0
    height: 220
    color: "#222"
    border.color: "#888"
    anchors.bottom: parent.bottom

    ColonistModel {
        id: colonistModel
    }

    readonly property int priorityButtonWidth: 28
    readonly property int priorityStartX: 240
    readonly property Item firstItem: repeater.count ? repeater.itemAt(0) : null

    RowLayout {
        x: 8
        y: 8

        Text {
            text: "Manual priorities"
            color: "white"
            font.pixelSize: 16
            anchors.verticalCenter: parent.verticalCenter
        }

        CheckBox {
            id: manualCheckBox
            checked: true
            implicitWidth: 32
            implicitHeight: 32
            anchors.verticalCenter: parent.verticalCenter

            onCheckedChanged: indicator.requestPaint()

            indicator: Canvas {
                anchors.fill: parent

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.lineWidth = 4;
                    ctx.lineCap = "round";

                    if (manualCheckBox.checked) {
                        // Draw a tick.
                        ctx.moveTo(width * 0.2, height * 0.6);
                        ctx.lineTo(width * 0.4, height * 0.75);
                        ctx.lineTo(width * 0.75, height * 0.25);
                        ctx.strokeStyle = "green";
                        ctx.stroke();
                    } else {
                        // Draw a cross.
                        ctx.moveTo(width * 0.2, height * 0.2);
                        ctx.lineTo(width * 0.8, height * 0.8);
                        ctx.moveTo(width * 0.2, height * 0.8);
                        ctx.lineTo(width * 0.8, height * 0.2);
                        ctx.strokeStyle = "red";
                        ctx.stroke();
                    }
                }
            }
        }
    }
    
    ColumnLayout {
        id: columnLayout
        spacing: 0
        anchors.fill: parent
        anchors.topMargin: 60
        anchors.leftMargin: 6
        anchors.rightMargin: 20
        
        PriorityHeader {
            priorityButtonWidth: workPane.priorityButtonWidth
            priorityStartX: workPane.priorityStartX

            Layout.fillWidth: true
            Layout.leftMargin: workPane.priorityStartX
        }
        
        Repeater {
            id: repeater
            model: colonistModel
            delegate: ColonistDelegate {
                id: mouseArea
                priorityButtonWidth: workPane.priorityButtonWidth
                priorityStartX: workPane.priorityStartX
                
                Layout.fillWidth: true
            }
        }
        
        Item {
            Layout.fillHeight: true
        }
    }
}
