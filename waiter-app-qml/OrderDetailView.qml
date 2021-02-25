import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Order 1.0
import QtQuick.Layouts 1.12
import QtQuick 2.0

Rectangle {
    id: productDetailRoot

    property var productModel: ({})
    property int idOrder: -1


    width: parent.width * 0.35
    height: parent.height
    color: "#f2f2f2"

    state: "close"
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: productDetailRoot
                x: parent.width - width
            }
            PropertyChanges {
                target: rect
                visible: true
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: productDetailRoot
                x: parent.width
            }
            PropertyChanges {
                target: rect
                visible: false
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

    ToolButton {
        id: toolButton
        height: 50
        icon.source: "../icons/ic_close.svg"
        anchors {
            left: parent.left
            leftMargin: parent.width * 0.03
        }
        onClicked: productDetailRoot.close()
    }
    ListView{
        anchors.top: toolButton.bottom
        spacing: 10
        width: parent.width
        height: parent.height
        model: WaiterOrderProductListModel{id: listModel}
        delegate: OrderProduct{width: parent.width; product: model; editable: false }
    }



    function close() {
        state = "close"
    }

    function open(idOrder) {
        productDetailRoot.idOrder = idOrder
        listModel.loadOrderProducts(productDetailRoot.idOrder)
        state = "open"
    }
}
