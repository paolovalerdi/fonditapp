import QtQuick 2.9
import QtQuick.Controls 2.2
import Order 1.0
import QtQuick.Controls.Material 2.12

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Cliente")

    Drawer {
        id: drawer
        width: window.width * 0.25
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                width: parent.width
                text: qsTr("Todo")
                icon.source: "qrc:/../icons/ic_menu_book.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(-1)
                    toolbarTitle.text = "Todo"
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                text: qsTr("Entradas")
                icon.source: "qrc:/../icons/ic_entradas.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(2)
                    toolbarTitle.text = "Entradas"
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                text: qsTr("Plato fuerte")
                icon.source: "qrc:/../icons/ic_plato_fuerte.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(3)
                    toolbarTitle.text = "PlatoFuerte"
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                text: qsTr("Postres")
                icon.source: "qrc:/../icons/ic_postres.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(4)
                    toolbarTitle.text = "Postres"
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                text: qsTr("Bebidas")
                icon.source: "qrc:/../icons/ic_bebidas.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(1)
                    toolbarTitle.text = "Bebidas"
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                text: qsTr("Otros")
                icon.source: "qrc:/../icons/ic_otros.svg"
                onClicked: {
                    productViewModelCallback.updateCategory(5)
                    toolbarTitle.text = "Otros"
                    drawer.close()
                }
            }
        }

        function updateCategoty(id, title) {
            productViewModelCallback.updateCategory(id)
            // TODO: Add toolbar
            drawer.close()
        }
    }

    MenuPage { }
}
