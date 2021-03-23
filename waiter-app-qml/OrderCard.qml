import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

Rectangle {
    id: root

    property var order: null
    property var requested: false
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

    MouseArea {
        id: rootMouseArea
        anchors.fill: parent
        drag.target: root
        enabled: root.order !== null && ((root.order.ready && root.order.idStatus === 4) || root.order.idStatus === 3)
        drag.onActiveChanged: root.Drag.drop();
    }

    Column {
        id: column

        spacing: 16
        anchors.fill: parent
        anchors.margins: 16

        Row {
            id: icon_row
            anchors.left: parent.left
            anchors.right: parent.right
            height: 24
            Image {
                source: root.icon
                sourceSize.width: 24
                sourceSize.height: 24
                layer.enabled: true
                layer.effect: ColorOverlay { color: foregroundColor }
            }
            Image {
                id: notification_icon
                anchors.right: parent.right
                source: "../icons/ic_notification.svg"
                sourceSize.width: 24
                sourceSize.height: 24
                layer.enabled: true
                layer.effect: ColorOverlay { color: foregroundColor }
                visible: root.order.callWaiter && root.order.ready === 1

            }
            Image {
                   id: check
                   anchors.right: parent.right
                   source: "../icons/ic_check_circle.svg"
                   sourceSize.width: 24
                   sourceSize.height: 24
                   layer.enabled: true
                   visible: root.order.callWaiter && root.order.idStatus === 5
               }
        }
        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            Text {
                width: parent.width
                text: "Orden #"  + root.order.idOrder
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
                text: order.idStatus === 5 ? "Cerrar orden" : "Detalles"
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
                onClicked: {
                    if (root.order.idStatus === 5) {
                        dialog.open()
                    } else {
                        panel.open(root.order.idOrder)
                    }
                }
            }
        }
    }

    Dialog {
        id: dialog
        parent:  windowContent
        width: parent.width*.5
        height: parent.height*.3
        anchors.centerIn: parent
        modal:true
        title: "Confirmación"
        clip: true
        Label {
            text: "¿Estas seguro de cerrar esta orden?"
            wrapMode: Label.wrapMode
            clip: true
        }
        Button {
            id: btnaceptar
            anchors.right: parent.right
            Material.background: "#0FBF5C"
            Material.foreground: "#FFF"
            y: Math.round((parent.height - height) / 2)
            text: qsTr("Aceptar")
            onClicked:  waiterBoardMediator.closeOrder(root.order.idOrder)
        }
        Button {
            id: btnrechazar
            anchors.left: parent.left
            Material.background: "#0FBF5C"
            Material.foreground: "#FFF"
            y: Math.round((parent.height - height) / 2)
            text: qsTr("Rechazar")
            onClicked: dialog.close()
        }
    }



}
