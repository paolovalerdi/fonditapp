import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.0
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Product 1.0
import Order 1.0
import QtQuick 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Window 2.0

Page{
    id: root

    anchors.fill : parent
    font.capitalization: Font.MixedCase
    property int orderId: -1
    property real amount: -1
    property real quantity: -1
    property string status: ""

    ItemDelegate {
        id: toolbar

        height: root.height * .1
        icon.source: "../icons/ic_drawer.svg"
        text: "Seguir orden"
        font.pointSize: 18
        font.bold: true

        onClicked: drawer.open()
    }

    RowLayout {
        anchors {
            left: parent.left
            top: toolbar.bottom
            right: parent.right
            bottom: parent.bottom
        }

        Rectangle {
            id: orderListContainer
            color: "#fff"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: root.width / 2

            ListView{
                id: orderListView
                clip: true
                anchors.fill: parent
                model: OrderProductListModel { mediator: orderMediator }
                delegate: OrderProduct { width: orderListView.width; product: model; editable: false }
            }
        }
        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.maximumWidth: root.width / 2

            Column {
                spacing: 50
                anchors.centerIn: parent

                Text {
                    id: text1
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 12
                    text: "Estado de la orden: Pendiente"
                }
                ProgressPie {
                    id: progress2
                    anchors.horizontalCenter: parent.horizontalCenter
                    lineWidth: 10
                    value: 0
                    size: 150
                    secondaryColor: "#e0e0e0"
                    primaryColor: "#6727F2"

                    Text {
                        text: parseInt(progress2.value * 100) + "%"
                        anchors.centerIn: parent
                        font.pointSize: 20
                        color: progress2.primaryColor
                    }
                    Component.onCompleted: {
                        timer.start()
                    }
                }
                Text {
                    id: totaltext
                    font.bold: true
                    font.pointSize: 14
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Button{
                    id: pago
                    width:parent.width
                    enabled: false
                    Material.background:  "#FFF"
                    Material.foreground:"#0FBF5C"
                    text: "Pedir cuenta"

                    onClicked:
                    {
                        pago.text= "Atendiendo solicitud"
                        orderMediator.insertIntoBill(root.orderId)
                        orderMediator.request()
                        dialog.open()
                    }

                }
            }
        }
    }

    Dialog {
        id: dialog
        width: parent.width*.5
        height: parent.height*.3
        anchors.centerIn: parent
        modal:true
        title: "Solicitud enviada"
        clip: true
        Label {
            text: "Tu solicitud de pago sera antendida por un mesero en seguida"
            wrapMode: Label.wrapMode
            clip: true
        }
        Button {
            id: btnaceptar
            anchors.centerIn: parent
            Material.background: "#0FBF5C"
            Material.foreground: "#FFF"
            y: Math.round((parent.height - height) / 2)
            text: qsTr("Aceptar")
            onClicked: dialog.close()
        }
    }

    Connections{

        target: orderMediator

        function onProgressUpdated(progress) {
            progress2.value = progress
            pago.enabled = progress === 1
        }

        function onTotalUpdated(){

            totaltext.text="$"+orderMediator.total
        }

        function onStatusUpdated(status){
              text1.text = "Estatus de la orden: "+status
        }

    }

    Component.onCompleted: orderMediator.replay()
}
