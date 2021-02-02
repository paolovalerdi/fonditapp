import QtQuick 2.9
import QtQuick.Controls 2.2

import Product 1.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1

import QtQuick.Controls.Styles 1.4

Page {
    anchors.fill: parent


    title: qsTr("Fonditapp")

    Label {
        text: qsTr("Editar menú")
        anchors.centerIn: parent
    }


    //MENUUUU :C
    /*MessageDialog {
            id: msg
            title: "Title"
            text: "Button pressed"
            onAccepted: visible = false
        }*/

    GridView {
        id: gridView
        anchors.fill: parent
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
                onClicked: {
                    stackView.push(Qt.createComponent("Page3Form.qml"),
                                   {
                                       "productId": model.productId,
                                       "name": model.name,
                                       "description": model.description,
                                       "picture": model.picture,
                                       "price": model.price
                                   })
                }
            }
        }
        ScrollIndicator.vertical: ScrollIndicator {}
    }
}
