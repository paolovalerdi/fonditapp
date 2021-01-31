import QtQuick 2.12
import QtQuick.Controls 2.12

import Product 1.0
import Order 1.0
Page {
    id: menuPage
    anchors.fill: parent
    state: "selectMode"

    property int amount: 1
    property real unitPrice: 0
    property int productId: -1

    GridView {
        id: gridView
        anchors {
            left: parent.left
            right: productDetailsPanel.left
            top: parent.top
            bottom: parent.bottom
        }
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductViewModel {
            callback: productViewModelCallback
        }
        delegate: ProductItemView {
            id: productItemView
            width: gridView.cellWidth
            height: gridView.cellHeight
            spanCount: 3
            spacing: 12
            indexOfThis: index
            name: model.name
            price: model.price
            picture: model.picture
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    productDetailsImage.source = model.picture
                    productDetailsName.text = model.name
                    productDetailsDescription.text = model.description
                    productDetailsPrice.text = "$" + model.price
                    menuPage.unitPrice = model.price
                    menuPage.productId = model.productId
                    menuPage.state = "detailsMode"
                }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }

    Rectangle {
        id: separator
        width: 1
        height: parent.height
        anchors.right: productDetailsPanel.left
        color: "#1f000000"
    }

    Rectangle {
        id: productDetailsPanel
        width: parent.width * 0.35
        height: parent.height
        x: parent.width

        ScrollView {
            anchors.fill: parent

            Column {
                width: productDetailsPanel.width
                bottomPadding: 20
                spacing: 10

                Rectangle {
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    height: width
                    Image {
                        id: productDetailsImage
                        width: parent.width * 0.85
                        height: width
                        anchors.centerIn: parent
                        fillMode: Image.PreserveAspectCrop
                    }
                }
                Text {
                    id: productDetailsName
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    text: "Nombre"
                    font.pointSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
                Text {
                    id: productDetailsDescription
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: parent.width * 0.08
                        rightMargin: parent.width * 0.08
                    }
                    text: "Descripcionnnnnnnnnnnnnnnnnnnn"
                    font.pointSize: 10
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
                Text {
                    id: productDetailsPrice
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    text: "20.0"
                    font.pointSize: 14
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }
                Row {
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: parent.width * 0.08
                        rightMargin: parent.width * 0.08
                    }
                    Button {
                        id: minusButton
                        width: parent.width / 3
                        text: "-"
                        enabled: menuPage.amount > 1
                        onClicked: {
                            menuPage.amount--;
                        }
                    }
                    Text {
                        width: parent.width / 3
                        height: parent
                        text: menuPage.amount
                        font.pointSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    Button {
                        id: plusButton
                        width: parent.width / 3
                        text: "+"
                        onClicked: {
                            menuPage.amount++;
                        }
                    }
                }
                Button {
                    anchors {
                        left: parent.left
                        right: parent.right
                        leftMargin: parent.width * 0.08
                        rightMargin: parent.width * 0.08
                    }
                    text: "Agregar a la orden"
                    onClicked: {
                        menuPage.state = "selectMode"
                        orderViewModelCallback.addProduct(menuPage.productId,menuPage.amount)
                        orderListView.visible = true

                    }
                }
            }
        }
    }

    ListView{
        id: orderListView
        visible: false
        anchors.fill: parent
        model: OrderViewModel{callback: orderViewModelCallback}
        delegate: OrderProductItemView{
            name:model.name
            description: model.description
            price: model.price
            quantity: model.quantity
            image: model.picture
        }
    }
    Button{
        width: parent.width*.5
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        onClicked: orderListView.visible=false
    }

    onAmountChanged: {
        productDetailsPrice.text = "$" + (unitPrice * amount)
    }

    onProductIdChanged: {
        amount = 1
    }

    states: [
        State {
            name: "selectMode"
            PropertyChanges {
                target: productDetailsPanel
                x: menuPage.width
            }
            PropertyChanges {
                target: separator
                opacity: 0
            }
        },
        State {
            name: "detailsMode"
            PropertyChanges {
                target: productDetailsPanel
                x: menuPage.width - productDetailsPanel.width
            }
            PropertyChanges {
                target: separator
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            from: "selectMode"
            to: "detailsMode"
            NumberAnimation {
                properties: "x";
                easing.type: Easing.InOutQuad;
                duration: 300;
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.InOutQuad;
                duration: 300;
            }
        },
        Transition {
            from: "detailsMode"
            to: "selectMode"
            NumberAnimation {
                properties: "x";
                easing.type: Easing.InOutQuad;
                duration: 300;
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.InOutQuad;
                duration: 300;
            }
        }
    ]
}
