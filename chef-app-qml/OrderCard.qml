import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

Rectangle {
    id: root

    property var order: null
    property var isCurrent: false
    property string icon: "../icons/ic_receipt.svg"
    readonly property string foregroundColor: {
        if (root.color.hslLightness >= 0.7) {
            "black"
        } else {
            "white"
        }
    }
    opacity: isCurrent ? 1 : 0.7

    height: column.implicitHeight + 32
    radius: 6

    Column {
        id: column

        spacing: 16
        anchors.fill: parent
        anchors.margins: 16

        Image {
            source: root.icon
            sourceSize.width: 24
            sourceSize.height: 24
            anchors.horizontalCenter: column.horizontalCenter
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
        Item {
            width: parent.width
            height: 16
        }

       /* Text {
            text: "$" + root.order.total
            color: foregroundColor
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pointSize: 16
        }*/
    }
}
