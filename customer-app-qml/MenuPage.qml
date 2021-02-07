import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Product 1.0
import Order 1.0

Page {
    id: menuPageRoot

    property string toolbarTitleText: "Inicio"

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
                    productDetailsPanel.open(model)
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
        color: "#80000000"
        opacity: orderListView.progress
        anchors {
            left: parent.left
            top: parent.top
            right: productDetailsPanel.left
            bottom: parent.bottom
        }
    }

    ProductDetailView {
        id: productDetailsPanel
        onAddProduct: {
            orderListView.amount++
        }
    }

    OrderListView {
        id: orderListView
        width: menuGridView.width * 0.6
        anchors.horizontalCenter: menuGridView.horizontalCenter
    }

    function closeDetailPanel() {
        productDetailsPanel.close()
    }
}
