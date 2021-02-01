import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Product 1.0
import Order 1.0

Page {
    id: menuPageRoot

    property string toolbarTitleText: "Inicio"
    property int amount: 1
    property real unitPrice: 0
    property int productId: -1

    font.capitalization: Font.MixedCase
    anchors.fill: parent
    state: "selectMode"

    ItemDelegate {
        id: toolbar

        height: menuPageRoot.height * .1
        icon.source: "../icons/ic_drawer.svg"
        text: qsTr(toolbarTitleText)
        font.pointSize: 18
        font.bold: true

        onClicked: drawer.open()
    }

    GridView {
        id: menuGridView

        clip: true
        anchors {
            left: parent.left
            right: productDetailsPanel.left
            top: toolbar.bottom
            bottom: parent.bottom
        }
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductViewModel { callback: productViewModelCallback }
        delegate: ProductItemView {
            width: menuGridView.cellWidth
            height: menuGridView.cellHeight
            spanCount: 3
            spacing: 12
            indexOfThis: index
            name: model.name
            price: model.price
            picture: model.picture
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log(model)
                    productDetailsImage.source = model.picture
                    productDetailsName.text = model.name
                    productDetailsDescription.text = model.description
                    productDetailsPrice.text = "$" + model.price
                    menuPageRoot.unitPrice = model.price
                    menuPageRoot.productId = model.productId
                    menuPageRoot.state = "detailsMode"
                    addToOrderButton.text = "Agregar producto"
                    addToOrderButton.enabled = true
                    hideOrderList.start()
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
                    ToolButton {
                        id: minusButton
                        width: parent.width / 3
                        icon.source: "qrc:/../icons/ic_remove.svg"
                        enabled: menuPageRoot.amount > 1
                        onClicked: {
                            menuPageRoot.amount--;
                        }
                    }
                    Text {
                        width: parent.width / 3
                        height: parent
                        text: menuPageRoot.amount
                        font.pointSize: 14
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    ToolButton {
                        id: plusButton
                        icon.source: "qrc:/../icons/ic_add.svg"
                        width: parent.width / 3

                        onClicked: {
                            menuPageRoot.amount++;
                        }
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

                        menuPageRoot.state = "selectMode"
                        orderViewModelCallback.addProduct(menuPageRoot.productId,menuPageRoot.amount)
                        addToOrderButton.text = "Producto agregado"
                        addToOrderButton.enabled = false
                        menuPageRoot.state = "selectMode"
                        //revealOrderList.start()
                    }
                }
            }
        }
    }
    Rectangle{
        id: orderListContainer
        y: menuGridView.height
        width: menuGridView.width*.5
        height: menuGridView.height
        anchors.horizontalCenter: menuGridView.horizontalCenter
        property bool isCollapsed: false
        onIsCollapsedChanged: {
            if(isCollapsed)
            {
                revealOrderList.start()
            }
            else
            {
                hideOrderList.start()
            }
        }
        OrderViewModel{
            id: orderViewModel
            callback: orderViewModelCallback
        }
        ListView{
            id: orderListView
            anchors.fill:parent
            clip: true
            model: orderViewModel
            delegate: OrderProductItemView{
                name:model.name
                description: model.description
                price: model.price
                quantity: model.quantity
                image: model.picture
            }
            onCountChanged: {
                orderButton.visible = count>=1
            }
        }
        PropertyAnimation {
            id: revealOrderList
            target: orderListContainer
            easing.type: Easing.InOutExpo
            properties: "y"
            to: 0
            duration: 300
        }
        PropertyAnimation {
            id: hideOrderList
            target: orderListContainer
            easing.type: Easing.InOutExpo
            properties: "y"
            to: menuPageRoot.height
            duration: 300
        }
    }

    Button{
        id: orderButton
        width: menuGridView.width*.5
        anchors.bottom: menuGridView.bottom
        anchors.horizontalCenter: menuGridView.horizontalCenter
        Material.background:  "#0FBF5C"
        text: "Ver mi orden"
         Material.foreground:"#FFF"

        icon.source: "../icons/ic_receipt.svg"
        onClicked: orderListContainer.isCollapsed = !orderListContainer.isCollapsed
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
                x: menuPageRoot.width
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
                x: menuPageRoot.width - productDetailsPanel.width
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
                easing.type: Easing.InOutQuint;
                duration: 300;
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.InOutQuint;
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
