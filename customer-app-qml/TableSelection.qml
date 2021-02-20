import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15
import QtGraphicalEffects 1.15

import Table 1.0

Rectangle {
    id: root

    property double progress: 0

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
            PropertyChanges {
                target: root
                progress: 0
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                y: -parent.height
            }
            PropertyChanges {
                target: root
                progress: 1
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
            NumberAnimation {
                properties: "progress"
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
            NumberAnimation {
                properties: "progress"
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

        cellWidth: width / 3
        cellHeight: height / 3
        anchors {
            left: parent.left
            leftMargin: 26
            right: parent.right
            top: title.bottom
            topMargin: 24
            bottom: parent.bottom
        }
        model: TableListModel{ id: tableListModel }

        delegate: Rectangle {
            id: table

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
            Ripple {
                id: ripple

                width: table.width
                height: table.height
                color: "#1A000000"
                pressed: mouseArea.pressed
                active: mouseArea.containsMouse
                anchors.fill: table
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: table.width
                        height: table.height
                        radius: 6
                    }
                }
            }

            MouseArea{
                id: mouseArea
                anchors.fill: parent

                onClicked: {
                    orderMediator.linkTable(model.idTable)
                    root.state = "close"
                }
            }
        }
    }

}
