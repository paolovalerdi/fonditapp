import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    radius: 9
    width: parent.width
    height: card.implicitHeight
    property var orderModel: null
    property string textColor: "black"

    Column{
        id: card
        spacing: 10
        anchors{
            left: parent.left
            right: parent.right
        }
        Item{
            height: 8
            width: parent.width
        }

        Row{
            spacing: 10
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 10
                rightMargin: 10
            }
            Image {
                id:icon
                Material.background: root.textColor
                Material.foreground: root.textColor
                source: "../icons/ic_receipt.svg"
                ColorOverlay {
                    anchors.fill: icon
                    source: icon
                    color: root.textColor
                }
            }

            Text {
                font.pointSize: 10
                color: root.textColor
                text: "Orden: " + orderModel.idOrder
            }
        }

        Row{
            spacing: 10
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 10
                rightMargin: 10
            }
            Image {
                id: icon2
                Material.foreground: root.textColor
                source: "../icons/ic_table.svg"
                width: 24
                height: 25
                ColorOverlay {
                    anchors.fill: icon2
                    source: icon2
                    color: root.textColor
                }
            }
            Text {
                color: root.textColor
                font.pointSize: 10
                text: "Mesa: " + orderModel.idTable
            }
        }
        Row{
            spacing: 10
            anchors{
                left: parent.left
                right: parent.right
                leftMargin: 10
                rightMargin: 10
            }
            Image {
                id: icon3
                Material.foreground: root.textColor
                source: "../icons/ic_pay.svg"
                ColorOverlay {
                    anchors.fill: icon3
                    source: icon3
                    color: root.textColor
                }
            }
            Text {
                color: root.textColor
                font.pointSize: 10
                text: "Monto: " + orderModel.total
            }
        }

        Button {
            id: btnAvanzar
            anchors.right: parent.right
            anchors.left: parent.left
            text: "Avanzar"
            font.bold: true
            font.pointSize: 12
        }
    }


}
