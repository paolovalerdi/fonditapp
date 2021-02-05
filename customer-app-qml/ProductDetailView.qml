import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Rectangle {
    id: productDetailRoot

    property var productModel: ({})
    property int quantity: 1
    property real unitPrice: 0

    signal addProduct()

    width: parent.width * 0.35
    height: parent.height
    color: "white"

    state: "close"
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: productDetailRoot
                x: parent.width - width
            }
            PropertyChanges {
                target: separator
                opacity: 0
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: productDetailRoot
                x: parent.width
            }
            PropertyChanges {
                target: separator
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "close"; to: "open"
            NumberAnimation {
                properties: "x"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        },
        Transition {
            from: "open"; to: "close"
            NumberAnimation {
                properties: "x"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        }
    ]
    onProductModelChanged: {
        if (productModel !== null) {
            quantity = 1
            unitPrice = productModel.price
        }
    }

    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.interactive: false

        Column {
            width: productDetailRoot.width
            topPadding: 24
            bottomPadding: 24
            spacing: 12

            ToolButton {
                icon.source: "../icons/ic_close.svg"
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.03
                }
                onClicked: productDetailRoot.close()
            }
            Image {
                height: width
                source: productModel.picture
                fillMode: Image.PreserveAspectCrop
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
            }
            Text {
                text: productModel.name
                font.pointSize: 14
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
            }
            Text {
                text: productModel.description
                font.pointSize: 10
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
            }
            Rectangle {
                height: quantityControlsContainer.implicitHeight
                color: "transparent"
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }

                Row {
                    id: quantityControlsContainer
                    anchors.horizontalCenter: parent.horizontalCenter

                    ToolButton {
                        width: 60
                        height: width
                        icon.source: "../icons/ic_remove.svg"
                        enabled: productDetailRoot.quantity >= 1
                        onClicked: productDetailRoot.quantity--
                    }
                    Text {
                        text: quantity
                        font.pointSize: 14
                        font.bold: true
                        anchors {
                            verticalCenter: parent.verticalCenter
                        }
                    }
                    ToolButton {
                        width: 60
                        height: width
                        icon.source: "../icons/ic_add.svg"
                        onClicked: productDetailRoot.quantity++
                    }
                }
            }
            Text {
                id: productDetailTotalPrice
                text: "$" + (parseFloat(productDetailRoot.productModel.price) * quantity).toString()
                font.pointSize: 16
                font.bold: true
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
            }
            Button {
                id: addToOrderButton
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }

                background: Rectangle {
                    border.width: 1
                    border.color: "#0FBF5C"
                    radius: 10
                }
                Material.background:  "#FFF"
                Material.foreground:"#0FBF5C"
                text: "Agregar a la orden"


                onClicked: {
                    orderViewModelCallback.addProduct(productDetailRoot.productModel.productId, quantity)
                    productDetailRoot.close()
                    productDetailRoot.addProduct()
                }
            }
        }
    }
    Rectangle {
        id: separator
        width: 1
        color: "#1f000000"
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    function close() {
        state = "close"
    }

    function open(product) {
        productDetailRoot.productModel = product
        state = "open"
    }
}
