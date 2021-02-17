import QtQuick 2.0
import Tables 1.0
Rectangle {
    id: root
    width: parent.width
    height: parent.height
    color: "#FFF"
    state: "open"
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: root
                y: 0
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                y:-parent.height
            }
        }
    ]
    transitions: [
        Transition {
            from: "close"; to: "open"
            NumberAnimation {
                properties: "y"
                duration: 350
                easing.type: Easing.OutQuart
            }
        },
        Transition {
            from: "open"; to: "close"
            NumberAnimation {
                properties: "y"
                duration: 350
                easing.type: Easing.OutQuart
            }
        }
    ]
    Text {
        id: title
        text: "Selecciona tu mesa"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 24
        font.bold: true
        font.pointSize: 18
    }
    GridView{
        id: gridView
        anchors{
            left: parent.left
            leftMargin: 26
            right: parent.right
            top: title.bottom
            bottom: parent.bottom
            topMargin: 24
        }
        cellWidth: width/3
        cellHeight: height/3

        model: TablesModel{
        id: tablesModel
        }

        delegate: Rectangle{
            width: gridView.cellWidth * 0.9
            height: gridView.cellHeight * 0.9
            radius: 6
            color: "#0FBF5C"
            Text {
                text: model.idTable
                anchors.centerIn: parent
                font.bold: true
                font.pointSize: 18
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    window.idTable = model.idTable
                    tablesModel.updateTable(model.idTable)
                    root.state = "close"
                }
            }
        }
    }

}
