import QtQuick 2.0

Item {
    width: orderListView.width
    height: orderProductImage.height+10
    property string name: ""
    property string description: ""
    property string price: ""
    property string image: ""
    property int quantity: -1
    Row{
        width: parent.width
        clip: true
        spacing: 16
        Text {
            id: orderProductQuantity
            anchors.verticalCenter: parent.verticalCenter
            text: quantity
            font.bold: true
            font.pointSize: 12
            wrapMode: Text.WordWrap
        }
        Image {
            id: orderProductImage
            anchors.verticalCenter: parent.verticalCenter
            fillMode: Image.PreserveAspectCrop
            source: image
            width: 100
            height: 100
        }
        Column{
            width: parent.width - (orderProductImage.width+orderProductQuantity.width+32)
            anchors.verticalCenter: parent.verticalCenter
            Text {
                id: orderProductName
                width: parent.width
                text: name
                font.bold: true
                font.pointSize: 12
            }
            Text {
                id: orderProductDescription
                width: parent.width
                text: description
                wrapMode: Text.WordWrap
            }
            Text {
                id: orderProductPrice
                text: price
            }
        }

    }
}
