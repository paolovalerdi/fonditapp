import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: root

    property var product: null
    property int indexOfThis: -1
    property int spanCount: -1
    property real spacing: 0

    Item {
        anchors.fill: parent
        anchors {
            leftMargin: spacing - (indexOfThis % spanCount) * spacing / spanCount
            rightMargin: ((indexOfThis % spanCount) + 1) * spacing / spanCount
            topMargin: {
                if (indexOfThis < spanCount) {
                    spacing
                } else {
                    0
                }
            }
            bottomMargin: spacing
        }

        Image {
            id: img
            anchors.fill: parent
            source: root.product.picture
            fillMode: Image.PreserveAspectCrop
            clip: true
        }
        LinearGradient {
            anchors.fill: parent
            start: Qt.point(0, 0)
            end: Qt.point(0, 300)
            gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: "#1A000000"
                }
                GradientStop {
                    position: 1.0
                    color: "black"
                }
            }
        }
        Column {
            anchors {
                leftMargin: 8
                bottomMargin: 8
                left: parent.left
                bottom: parent.bottom
            }
            Text {
                id: nameText
                color: "white"
                font.pointSize: 10
                text: root.product.name
            }
            Text {
                id: priceText
                color: "white"
                font.pointSize: 8
                text: root.product.quantity
            }
        }
    }
}
