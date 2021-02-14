import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

Rectangle {
    id: root

    property var order: null
    property string icon: "../icons/ic_receipt.svg"
    readonly property string foregroundColor: {
        if (root.color.hslLightness >= 0.7) {
            "black"
        } else {
            "white"
        }
    }

    height: column.implicitHeight + 32
    radius: 6
    Drag.keys: [ (root.order.idStatus + 1).toString() ]
    Drag.active: rootMouseArea.drag.active
    Drag.hotSpot.x: root.width / 2
    Drag.hotSpot.y: root.height / 2

    states: [
        State {
            when: root.Drag.active
            ParentChange {
                target: root
                parent: windowContent
            }
        }
    ]

    Column {
        id: column

        spacing: 16
        anchors.fill: parent
        anchors.margins: 16

        Image {
            source: root.icon
            sourceSize.width: 24
            sourceSize.height: 24
            layer.enabled: true
            layer.effect: ColorOverlay { color: foregroundColor }
        }
        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            Text {
                width: parent.width
                text: "Orden #" + root.order.idOrder
                color: foregroundColor
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                font.bold: true
                font.pointSize: 13
            }
            Text {
                width: parent.width
                text: "Mesa #" + root.order.idTable
                color: foregroundColor
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
        }

        Text {
            text: "$" + root.order.total
            color: foregroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pointSize: 16
        }
        Rectangle {
            id: button

            width: parent.width
            height: 40
            radius: 18
            anchors.right: parent.right

            Component.onCompleted: {
                button.color = root.color
                button.color.hslLightness -= 0.10
            }

            Text {
                text: "Avanzar"
                color: foregroundColor
                anchors.centerIn: parent
            }
            Ripple {
                color: "#1A000000"
                pressed: mouseArea.pressed
                active: mouseArea.containsMouse
                anchors.fill: parent
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: button.width
                        height: button.height
                        radius: button.radius
                    }
                }
            }

            MouseArea {
                id: mouseArea

                hoverEnabled: true
                anchors.fill: parent
                onClicked: console.log("OrderCard: button clicked")
            }
        }
    }

    MouseArea {
        id: rootMouseArea
        anchors.fill: parent

        drag.target: root
        drag.onActiveChanged: root.Drag.drop();
    }
}
