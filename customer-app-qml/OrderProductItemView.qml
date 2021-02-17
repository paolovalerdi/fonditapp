import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Item {
    id: root
    width: orderListView.width
    height: row.implicitHeight
    property int idProduct: -1
    property string name: ""
    property string description: ""
    property string price: ""
    property string image: ""
    property int quantity: -1
    property bool showControlls: true
    Row{
        id: row
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        clip: true
        spacing: 16
        Image {
            id: orderProductImage
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectCrop
            source: root.image
            width: 100
            height: 100
        }
        Column{
            width: parent.width - (orderProductImage.width)
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: orderProductName
                width: parent.width
                text: root.name
                font.bold: true
                font.pointSize: 12
            }
            Text {
                id: orderProductDescription
                width: parent.width
                text: root.description
                wrapMode: Text.WordWrap
            }
            Text {
                id: orderProductPrice
                text: "$" + (root.quantity * root.price)
            }
            Row {
                id: quantityControlsContainer
                anchors.horizontalCenter: parent.horizontalCenter
                ToolButton {
                    width: 60
                    height: width
                    icon.source: "../icons/ic_remove.svg"
                    visible: root.showControlls
                    enabled: root.quantity >= 1
                    onClicked: {
                        root.quantity--
                        orderViewModelCallback.updateProductQuantity(root.idProduct,root.quantity)
                    }
                }
                Text {
                    text: root.quantity
                    font.pointSize: 14
                    font.bold: true
                    anchors {
                        verticalCenter: parent.verticalCenter
                    }
                }
                ToolButton {
                    width: 60
                    height: width
                    visible: root.showControlls
                    icon.source: "../icons/ic_add.svg"
                    onClicked: {
                        root.quantity++
                        orderViewModelCallback.updateProductQuantity(root.idProduct,root.quantity)
                    }
                }
            }

        }

    }
}
