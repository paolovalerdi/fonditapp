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
    }
}
