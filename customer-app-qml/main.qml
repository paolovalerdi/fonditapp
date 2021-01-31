import QtQuick 2.9
import QtQuick.Controls 2.2

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
    MenuView { }
}
