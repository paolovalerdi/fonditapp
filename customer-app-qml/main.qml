import QtQuick 2.9
import QtQuick.Controls 2.2

import Product 1.0
import QtGraphicalEffects 1.0

ApplicationWindow {
    id: window
    width: 860
    height: 540
    visible: true
    title: qsTr("Cliente")
    header: ToolBar {
        contentHeight: toolButton.implicitHeight
        ToolButton {
            id: toolButton
            text: "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }
        Label {
            id: toolbarTitle
            text: "Menú"
            anchors.centerIn: parent
        }
    }
    Drawer {
        id: drawer
        width: window.width * 0.25
        height: window.height
        Column {
            anchors.fill: parent
            ItemDelegate {
                text: qsTr("Entradas")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(2)
                    toolbarTitle.text = "Entradas"
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Entradas")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(2)
                    toolbarTitle.text = "Entradas"
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Plato fuerte")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(3)
                    toolbarTitle.text = "PlatoFuerte"
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Postres")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(4)
                    toolbarTitle.text = "Postres"
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Bebidas")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(1)
                    toolbarTitle.text = "Bebidas"
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Otros")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(5)
                    toolbarTitle.text = "Otros"
                    drawer.close()
                }
            }
        }
    }
    GridView {
        id: gridView
        anchors {
            fill: parent
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
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
