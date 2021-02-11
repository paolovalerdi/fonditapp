import QtQuick 2.15
import QtGraphicalEffects 1.15

import Order 1.0

Rectangle {
    id: root

    property int status: 3
    property string title: "Title"
    property string cardIcon: "../icons/ic_receipt.svg"
    property string cardBackgroundColor: "#000"

    radius: 6
    border.width: 1
    border.color: "#26000000"

    Text {
        id: title
        text: root.title
        font.bold: true
        font.pointSize: 16
        anchors {
            left: parent.left
            leftMargin: 16
            top: parent.top
            topMargin: 16
        }
    }
    ListView {
        id: listView

        clip: true
        spacing: 16
        anchors {
            top: title.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: 16
        }
        model: OrderListModel {
            id: listModel
            status: root.status
        }
        delegate: OrderCard {
            width: listView.width
            icon: root.cardIcon
            color: root.cardBackgroundColor
            order: model
        }
    }
}
