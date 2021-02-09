import QtQuick 2.0
import QtQuick.Controls 2.0

Rectangle {
    radius: 9
    width: parent.width
    height: parent.width*0.3
    property var orderModel: null


    Column{
        anchors{
            left: parent.left
            right: parent.right
            leftMargin: 5
        }
        Text {
            color: "black"
            font.pointSize: 10
            text: "Orden: " + orderModel.idOrder
        }
        Text {
            color: "black"
            font.pointSize: 10
            text: "Mesa: " + orderModel.idTable
        }
        Text {
            color: "black"
            font.pointSize: 10
            text: "Monto: " + orderModel.total
        }
        Button {
            anchors.right: parent.right
            text: "Avanzar"
        }
    }

}
