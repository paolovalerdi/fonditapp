import QtQuick 2.9
import QtQuick 2.0
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
        text: qsTr("Seguir orden")
        font.pointSize: 18
        font.bold: true

        onClicked: {
            drawer.open()
        }
    }

    Timer{
        id: timer
        interval: 1000
        running: false
        repeat: true
        onTriggered: {

            if(progress2.value<0.99) {
                progress2.value = progress2.value + 0.10
            }
            else
            {
                timer.stop()
            }

        }
    }

    Rectangle {
        anchors{
            left: orderListContainer.right
            right: parent.right
            top: toolbar.bottom
            bottom: parent.bottom
        }

        Column{
            anchors.centerIn: parent
            spacing: 50
            Text {
                id: text1
                font.bold: true
                font.pointSize: 12
                text: "Estado de la orden: " + root.status
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

            Button{
                id: pago
                width:parent.width
                Material.background:  "#FFF"
                Material.foreground:"#0FBF5C"
                text: "Pedir cuenta"

                onClicked:
                {
                    pago.text= "Atendiendo solicitud"
                    orderViewModelCallback.insertIntoBill(root.orderId)
                    dialog.open()
                }

            }



        }
    }


    Rectangle {
        id: orderListContainer
        color: "white"
        width: parent.width / 2
        anchors{
            left: parent.left
            top: toolbar.bottom
            bottom: parent.bottom
        }

        ListView{
            id: orderListView
            anchors.fill: parent
            clip: true
            model: OrderViewModel {
                callback: orderViewModelCallback
            }

            delegate: OrderProductItemView{
                name:model.name
                description: model.description
                price: model.price
                quantity: model.quantity
                image: model.picture
            }
            Component.onCompleted: {
                console.log(root.orderId)
                if(root.orderId!==-1)
                {
                    orderViewModelCallback.loadOrder(root.orderId)
                    console.log(root.amount)
                }

            }
        }
    }
    Dialog {
        id: dialog
        width: parent.width*.5
        height: parent.height*.3
        x: Math.round((parent.width - width) / 2)
        y: Math.round((parent.height - height) / 2)
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
}



