import Order 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15
import QtQuick.Controls.Material 2.0
ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Mesero")

    RowLayout{
        anchors.fill: parent
        spacing: 15
        anchors{
            margins: 14
        }

        ListView{
            id: pendientes
            spacing: 9
            Layout.fillWidth : true
            Layout.fillHeight: true
         // snapMode: ListView.SnapPosition
            header: Text {
                text: qsTr("Pendientes")
                font.bold: true
                font.pointSize: 20
                height: 50
            }
            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 3
            }
            delegate: OrderCard{
                orderModel: model
                textColor: "#FFF"
                color: "#804BF2"
            }
        }

        ListView{
            id: enProgreso
            spacing: 9
            Layout.fillWidth : true
            Layout.fillHeight: true
            header: Text {
                font.bold: true
                font.pointSize: 20
                height: 50
                text: qsTr("En progreso")
            }

            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 4
            }
            delegate: OrderCard{
                orderModel: model
                textColor: "black"
                color: "#FF8552"
            }
        }
        ListView{
            id: entregadas
            spacing: 9
            Layout.fillWidth : true
            Layout.fillHeight: true
            header: Text {
                font.bold: true
                font.pointSize: 20
                height: 50
                text: qsTr("Entregadas")
            }
            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 5
            }
            delegate: OrderCard{
                orderModel: model
                textColor: "#FFF"
                color: "#5FAD56"
            }
        }
    }

}
