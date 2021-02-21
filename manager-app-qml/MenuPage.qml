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

    /*GridView {
        id: gridView
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductViewModel { }
        delegate: ProductItemView {
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
                onClicked: { productEditPanel.open(model) }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            right: productEditPanel.left
        }
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
    }*/
}
