import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import Order 1.0

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Mesero")

    OrderListModel {
        id: pendingListModel
        status: 3
    }

    RowLayout {
        spacing: 15
        anchors {
            fill: parent
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
            model: pendingListModel
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

            model: OrderListModel {
                status: 3
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
            model: OrderListModel { status: 3 }

            delegate: OrderCard{
                orderModel: model
                textColor: "#FFF"
                color: "#5FAD56"
            }
        }
    }

}
