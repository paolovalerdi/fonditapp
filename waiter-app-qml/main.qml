import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Order 1.0

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Mesero")


    Item {
        id: windowContent
        anchors.fill: parent

        RowLayout {
            spacing: 16
            anchors.fill: parent
            anchors.margins: 16

            WaiterOrderList {
                title: "Pendientes"
                status: 3
                cardIcon: "../icons/ic_receipt.svg"
                cardBackgroundColor: "#804BF2"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            WaiterOrderList {
                title: "En progreso"
                status: 4
                cardIcon: "../icons/ic_cooking.svg"
                cardBackgroundColor: "#FF8552"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
            WaiterOrderList {
                title: "Entregadas"
                status: 5
                cardIcon: "../icons/ic_pay.svg"
                cardBackgroundColor: "#5FAD56"
                Layout.fillWidth: true
                Layout.fillHeight: true
            }
        }
    }


}
