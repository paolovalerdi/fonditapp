import QtQuick 2.9
import QtQuick.Controls 2.2

import Product 1.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1
import QtQuick.Controls.Material 2.12

import QtQuick.Controls.Styles 1.4

Page {
    id: root
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
        id: gridView
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductListModel { id: productListModel }
        delegate: ProductItemView{
            width: gridView.cellWidth
            height: gridView.cellHeight
            selected: gridView.currentIndex === index
            spanCount: 3
            spacing: 12
            position: index
            product: model
            onClicked :{
                productEditPanel.open(product)
                gridView.currentIndex = index
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: productEditPanel.left
        }
        Component.onCompleted: productListModel.loadCategory(-1)
    }

    RoundButton{
        width:76
        height: 76
        icon.source: "../icons/ic_add2.svg"
        icon.width: 40
        icon.height: 40
        Material.background: "#F25C05"
        Material.foreground: "#FFF"
        anchors {
            bottom: gridView.bottom
            right: gridView.right
            bottomMargin: 18
            rightMargin: 18
        }
        onClicked: productEditPanel.create()
    }

    ProductEditPanel {
        id: productEditPanel
    }
}
