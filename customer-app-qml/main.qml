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

        function updateCategory(id, title) {
            productViewModelCallback.updateCategory(id)
            // TODO: Add toolbar
            drawer.close()
        }
    }

    MenuPage {
        transform: Translate {
            x: drawer.position * drawer.width
        }
    }
}
