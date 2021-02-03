import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Gerente")

    Drawer {
        id: drawer
        width: window.width * 0.25
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                width: parent.width
                icon.source: "../icons/ic_menu_book.svg"
                text: qsTr("Editar menu")
                onClicked: {
                    stackView.push("Page1Form.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                width: parent.width
                icon.source: "../icons/ic_menu_book.svg"
                text: qsTr("Estadísticas")
                onClicked: {
                    stackView.push("Page2Form.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "MenuPage.qml"
        anchors.fill: parent
    }
}
