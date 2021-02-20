import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Product 1.0
import Order 1.0

Page {
    id: root

    signal toolbarClicked()

    title: ""
    font.capitalization: Font.MixedCase
    anchors.fill: parent

    ItemDelegate {
        id: toolbar

        height: root.height * .1
        text: root.title
        icon.source: "../icons/ic_drawer.svg"
        font.pointSize: 18
        font.bold: true

        onClicked: root.toolbarClicked()
    }

    GridView {
        id: menuGridView

        clip: true
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        anchors {
            left: parent.left
            right: productDetailsPanel.left
            top: toolbar.bottom
            bottom: parent.bottom
        }
        model: ProductListModel { id: productListModel }
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
    }

    OrderPanel {
        id: orderListView
        width: menuGridView.width * 0.6
        anchors.horizontalCenter: menuGridView.horizontalCenter
    }

    function loadCategory(categoryId) {
        productListModel.loadCategory(categoryId)
        productDetailsPanel.close()
    }
}
