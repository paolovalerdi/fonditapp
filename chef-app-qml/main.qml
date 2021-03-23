import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.15

import Chef 1.0

ApplicationWindow {
    id: window
    width: 900
    height: 600
    visible: true
    title: qsTr("Cocina")

    RowLayout {
        anchors.fill: parent
        spacing: 0
        Item {
            //color: "red"
            Layout.preferredWidth: window.width * 0.33
            Layout.fillHeight: true
            Text {
                id: title
                text: "Cola de pedidos"
                font.bold: true
                font.pointSize: 16
                anchors {
                    left: parent.left
                    leftMargin: 18
                    top: parent.top
                    topMargin: 16
                }
            }
            ListView {
                id: orderQueue
                spacing: 16
                currentIndex: 0
                anchors {
                    top: title.bottom
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins:  16
                }

                model: OrderListModel { id: orderListModel }
                delegate: OrderCard {
                    width: parent.width
                    order: model
                    color: "#FF8552"
                    isCurrent: model.position === 0
                }

                Component.onCompleted: itemAtIndex(0).isCurrent = true
            }
        }
        Rectangle {
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1
            Layout.preferredWidth: 1
            Layout.fillHeight: true
            color: "#1f000000"
        }
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true

            GridView {
                id: menuGridView

                clip: true
                cellWidth: (width / 3)
                cellHeight: (height / 3)
                anchors.fill: parent
                model: ProductListModel { id: productListModel }
                delegate: Product {
                    width: menuGridView.cellWidth
                    height: menuGridView.cellHeight
                    spanCount: 3
                    spacing: 12
                    cardRadius: 6
                    position: index
                    product: model
                    onClicked: {
                        productListModel.updateReady(index, isSelected)
                    }
                }

                Component.onCompleted: {
                   console.log(orderQueue.itemAtIndex(0))
                   productListModel.loadProductsByOrderId(orderQueue.itemAtIndex(0).order.idOrder)
                }
            }
            Rectangle {
                id: confirmButton

                width: parent.width
                height: 48
                color: "#0FBF5C"
                opacity: confirmMouseArea.enabled ? 1 : 0.4
                clip: true
                anchors.bottom: parent.bottom

                Text {
                    text: qsTr("Confirmar orden")
                    color: "white"
                    font.pointSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Ripple {
                    id: confirmRipple

                    color: "#1A000000"
                    pressed: confirmMouseArea.pressed
                    active: confirmMouseArea.containsMouse
                    anchors.fill: confirmMouseArea
                }
                MouseArea {
                    id: confirmMouseArea

                    hoverEnabled: true
                    enabled: false
                    anchors.fill: confirmButton
                    onClicked: orderListModel.markAsReady(orderQueue.itemAtIndex(0).order.idOrder)
                }
            }
            Text {
                id: emptyText
                visible: false
                text: "No hay mas ordernes por ahora"
                anchors.centerIn: parent
                font.pointSize: 24
            }
        }
    }

    Connections {
        target: productListModel

        function onEnabled(value) {
            confirmMouseArea.enabled = value
        }
    }
    Connections {
        target: orderListModel

        function onUpdateProductGrid(idOrder) {
            productListModel.loadProductsByOrderId(idOrder)
            confirmMouseArea.enabled = false
        }
        function onShowEmptyMessage(show) {
            emptyText.visible = show
            menuGridView.visible = !show
            confirmButton.visible = !show
        }
    }
}
