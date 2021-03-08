import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    id: root

    height: container.implicitHeight

    property var product: null
    property bool editable: true

    RowLayout {
        id: container

        spacing: 16
        anchors {
            left: parent.left
            leftMargin: 16
            right: parent.right
            rightMargin: 16
        }

        Image {
            id: notification_icon
            anchors.left:  parent.left
            anchors.top:  parent.top*.9
            source: "/../icons/ic_greencheck.png"
            sourceSize.width: 24
            sourceSize.height: 24
            layer.enabled: true
            visible: root.product.ready === true
        }

        Image {
            height: Layout.preferredWidth
            source: root.product.picture
            fillMode: Image.PreserveAspectCrop
            Layout.alignment: Qt.AlignVCenter
            Layout.preferredWidth: parent.width * 0.25
            Layout.preferredHeight: parent.width * 0.25
        }
        Column {
            spacing: 8
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            Text {
                width: parent.width
                text: root.editable ? root.product.name : (root.product.quantity + " x " + root.product.name)
                wrapMode: Text.WordWrap
                font.bold: true
                font.pointSize: 12
            }
            Text {
                width: parent.width
                text: root.product.description
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
            }
            Text {
                width: parent.width
                text: "$" + root.product.price
                wrapMode: Text.WordWrap
                font.bold: true
                font.pointSize: 14
            }
        }
        Column {
            visible: root.editable
            Layout.alignment: Qt.AlignVCenter

            ToolButton {
                icon.source: "../icons/ic_add.svg"

                onClicked: root.updateQuantity(true)
            }
            Text {
                text: root.product.quantity
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                anchors.horizontalCenter: parent.horizontalCenter
                font.bold: true
                font.pointSize: 12
            }
            ToolButton {
                visible: root.editable
                enabled: root.product.quantity > 1
                icon.source: "../icons/ic_remove.svg"

                onClicked: root.updateQuantity(false)
            }
        }
        ToolButton {
            visible: root.editable
            icon.source: "../icons/ic_delete.svg"
            Layout.alignment: Qt.AlignVCenter
            onClicked: console.log("Delete order product")
        }
    }

    function updateQuantity(sum) {
        orderMediator.updateProductQuantity(
                    root.product.idProduct,
                    root.product.quantity + (sum ? 1 : -1))
    }


}
