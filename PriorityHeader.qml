import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Window 2.2

RowLayout {
    implicitHeight: 64

    property int priorityButtonWidth
    property int priorityStartX

    Repeater {
        model: ["Firefight", "Patient", "Doctor", "Bed rest", "Flick", "Warden", "Handle",
            "Cook", "Hunt", "Construct", "Repair", "Grow", "Mine", "Plant cut", "Smith",
            "Tailor", "Art", "Craft", "Haul", "Clean", "Research"]
        delegate: Item {
            width: priorityButtonWidth
            height: parent.height / 2

            Text {
                color: "white"
                text: modelData
                anchors.bottom: line.top
                anchors.bottomMargin: 2
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: line
                width: 1
                height: index % 2 == 0 ? parent.height : parent.height / 2
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: "grey"
            }
        }
    }
}
