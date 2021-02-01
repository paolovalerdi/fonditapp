import QtQuick 2.9
import QtQuick.Controls 2.2

import Category 1.0

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
            productViewModelCallback.updateCategory(categoryId)
            menuPage.toolbarTitleText = categoryTitle
            drawer.close()
            closeDetailPanelTimer.start()
        }
    }

    MenuPage {
        id: menuPage
        transform: Translate {
            x: drawer.position * drawer.width
        }
    }
}
