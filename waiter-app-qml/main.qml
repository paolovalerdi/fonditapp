import Order 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Mesero")

    RowLayout{
        anchors.fill: parent
        spacing: 15

        ListView{
            spacing: 9
            id: pendientes
            Layout.fillWidth : true
            Layout.fillHeight: true
            height: parent.height
            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 3
            }
            delegate: OrderCard{
                orderModel: model
                color: "#348AA7"
            }
        }

        ListView{
            id: enProgreso
            Layout.fillWidth : true
            Layout.fillHeight: true
            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 4
            }
            delegate: OrderCard{
                orderModel: model
                color: "#FF8552"
            }
        }

        ListView{
            id: entregadas
            Layout.fillWidth : true
            Layout.fillHeight: true
            model: OrderListModel{
                callback: orderListModelCallback
                id_status: 5
            }
            delegate: OrderCard{
                orderModel: model
                color: "#5FAD56"
            }
        }
    }

}
