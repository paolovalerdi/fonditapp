import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.1


import Order 1.0

Rectangle {
    id: root
    property int status: 3
    property string title: "Title"
    property string cardIcon: "../icons/ic_receipt.svg"
    property string cardBackgroundColor: "#000"

    radius: 6
    border.width: 1
    border.color: "#26000000"


    property int value: 0


    Timer{
                 id: timer
                 interval: 1000
                 running: false
                 repeat: true
                 onTriggered: {

                     if(value===waiterBoardMediator.requestBill()){ //revisa el numero de mesas pidiendo cuentas
                       //HakunaMatata
                     }else //si no es igual
                     {
                         value=waiterBoardMediator.requestBill() //value sera igual al numero de mesas que solicitan cuenta
                         //Aqui tenemos que hacer que se recargue
                         waiterBoardMediator.updateBoard()
                     }

                 }
             }

    Text {
        id: title
        text: root.title
        font.bold: true
        font.pointSize: 16
        anchors {
            left: parent.left
            leftMargin: 16
            top: parent.top
            topMargin: 16
        }
    }
    ListView {
        id: listView

        property int draggedItemIndex: -1

        clip: true
        spacing: 16
        anchors {
            top: title.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 16
        }
        model: OrderListModel {
            id: listModel
            status: root.status
            mediator: waiterBoardMediator
        }
        delegate: OrderCard {
            id: cardDelegate
            width: listView.width
            icon: root.cardIcon
            color: root.cardBackgroundColor
            order: model
        }


        DropArea {
            id: dropArea
            anchors.fill: parent
            keys: [ (root.status).toString() ]
            onDropped:  {
                waiterBoardMediator.updateOrderStatus(dropArea.drag
                                                      .source
                                                      .order
                                                      .idOrder);
            }
        }

    }


    Component.onCompleted: {
                timer.start()
            }

    MessageDialog {
                id: messageDialog
                title: "May I have your attention please"
                text: "It's so cool that you are using Qt Quick."
                visible: false
                onAccepted: {
                    console.log("And of course you could only agree.")
                    messageDialog.close()
                }
            }

}
