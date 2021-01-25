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
            margins: 12
        }
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductViewModel {
            callback: productViewModelCallback
        }
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight
            Item {
                width: gridView.cellWidth * 0.96
                height: gridView.cellHeight * 0.96
                anchors.centerIn: parent
                Image {
                    id: img
                    anchors.fill: parent
                    source: model.picture
                    fillMode: Image.PreserveAspectCrop
                    clip: true
                }
                LinearGradient {
                    anchors.fill: parent
                    start: Qt.point(0, 0)
                    end: Qt.point(0, 300)
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#1A000000"
                        }
                        GradientStop {
                            position: 1.0
                            color: "black"
                        }
                    }
                }
                Column {
                    anchors {
                        leftMargin: 8
                        bottomMargin: 8
                        left: parent.left
                        bottom: parent.bottom
                    }
                    Text {
                        id: nameText
                        color: "white"
                        font.pointSize: 10
                        text: model.name
                    }
                    Text {
                        id: priceText
                        color: "white"
                        font.pointSize: 8
                        text: model.price
                    }
                }
            }
        }
    }
}
