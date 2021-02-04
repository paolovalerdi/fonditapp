import QtQuick 2.9
import QtQuick.Controls 2.2
import Order 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.4


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
            Material.foreground:"#FFF"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                drawer.open()
            }
        }
        Label {
            id: toolbarTitle
            text: "Menú"
            color: "#FFF"
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
                id: progressPie
                text: qsTr("Seguir orden")
                width: parent.width
                onClicked: {
                    toolbarTitle.text = "Status orden"
                    productViewModelCallback.clearWindow()
                    stackView.push(Qt.createComponent("OrderStatusView.qml"),
                                   {
                                   "orderId":orderViewModelCallback.getIdCurrentId(),
                                    "amount":orderViewModelCallback.getTotal(),
                                    "status":orderViewModelCallback.getStatus()
                                   }
                                   )
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Todo")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(-1)
                    toolbarTitle.text = "Todo"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Entradas")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(2)
                    toolbarTitle.text = "Entradas"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Plato fuerte")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(3)
                    toolbarTitle.text = "PlatoFuerte"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Postres")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(4)
                    toolbarTitle.text = "Postres"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Bebidas")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(1)
                    toolbarTitle.text = "Bebidas"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Otros")
                width: parent.width
                onClicked: {
                    productViewModelCallback.updateCategory(5)
                    toolbarTitle.text = "Otros"
                    stackView.clear()
                    progress1.visible = false
                    drawer.close()
                }
            }
        }
    }

    MenuView {

    }

    StackView {
        id: stackView
        anchors.fill: parent
    }


}
