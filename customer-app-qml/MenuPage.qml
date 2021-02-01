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

    ItemDelegate {
        id: toolbar

        height: menuPageRoot.height * .1
        icon.source: "../icons/ic_drawer.svg"
        text: qsTr(toolbarTitleText)
        font.pointSize: 18
        font.bold: true

        onClicked: {
            drawer.open()
        }
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
                    productDetailsPanel.open(model)
                   /* productDetailsImage.source = model.picture
                    productDetailsName.text = model.name
                    productDetailsDescription.text = model.description
                    productDetailsPrice.text = "$" + model.price
                    menuPageRoot.unitPrice = model.price
                    menuPageRoot.productId = model.productId
                    menuPageRoot.state = "detailsMode"
                    addToOrderButton.text = "Agregar producto"
                    addToOrderButton.enabled = true*/
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


    ProductDetailView {
        id: productDetailsPanel
    }

    /*Rectangle {
        id: productDetailsPanel
        width: parent.width * 0.35
        height: parent.height
        x: parent.width

        ScrollView {
            anchors.fill: parent


        }
    }*/
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

    function closeDetailPanel() {
        productDetailsPanel.close()
    }
}
