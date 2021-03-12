import QtQuick 2.9
import Order 1.0
import QtQuick.Controls.Material 2.12
import QtQuick.Window 2.2
import QtQuick.Controls 2.4


import Category 1.0

ApplicationWindow {
    id: window

    width: 900
    height: 600
    visible: true
    title: "Cliente"

    Drawer {
        id: drawer
        width: window.width * 0.25
        height: window.height

        ListView {
            id: drawerMenuList
            anchors.fill: parent

            model: CategoryViewModel { }
            delegate: ItemDelegate {
                id: categoryItem
                width: parent.width
                text: qsTr(model.title)
                highlighted: ListView.isCurrentItem
                icon.source: qsTr(model.iconPath)
                onClicked: {
                    drawer.updateCategory(model.categoryId, model.title)
                    drawerMenuList.currentIndex = index
                }
            }

            Component.onCompleted: {
                currentIndex = 0
            }
        }

        Timer {
            id: closeDetailPanelTimer
            interval: 325
            onTriggered: menuPage.closeDetailPanel()
        }

        function updateCategory(categoryId, categoryTitle) {
            if (categoryId === -2) {
                stackView.push(Qt.createComponent("OrderStatusPage.qml"))
            } else {
                if (stackView.depth > 1) {
                    stackView.pop();
                }
                menuPage.title = categoryTitle
                menuPage.loadCategory(categoryId)
            }
            drawer.close()
        }
    }
    StackView {
        id: stackView
        anchors.fill: parent
        opacity: tableSelection.progress

        initialItem: MenuPage {
            id: menuPage

            transform: Translate {
                x: drawer.position * drawer.width
            }
            onToolbarClicked: drawer.open()
        }
    }
    /*TableSelection { id: tableSelection }
*/
    SurveyPage {

    }

    Connections{
        target: orderMediator
        function onOrderClosed()
        {
            tableSelection.state="open"
        }
    }
}
