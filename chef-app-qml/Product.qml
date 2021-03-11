import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

Item {
    id: root

    property int cardRadius: 12
    property var product: null
    property int position: 0
    property int spanCount: 1
    property int spacing: 0
    property bool selected: false
    visible: root.product.ready!==true
    signal clicked(bool isSelected)


    state: selected ? "selected" : "unselected"
    states: [
        State {
            name: "selected"
            PropertyChanges {
                target: content
                opacity: 0
            }
            PropertyChanges {
                target: gradientStart
                color: "#8C000000"
            }
            PropertyChanges {
                target: checkIcon
                scale: 1.0
            }
        },
        State {
            name: "unselected"
            PropertyChanges {
                target: content
                opacity: 1
            }
            PropertyChanges {
                target: gradientStart
                color: "#00000000"
            }
            PropertyChanges {
                target: checkIcon
                scale: 0.0
            }
        }
    ]
    transitions: [
        Transition {
            from: "selected"
            to: "unselected"
            NumberAnimation {
                properties: "scale"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity"
                duration: 350
                easing.type: Easing.OutQuart
            }
            ColorAnimation {
                duration: 350
                easing.type: Easing.OutQuart
            }
        },
        Transition {
            from: "unselected"
            to: "selected"
            NumberAnimation {
                properties: "scale"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity"
                duration: 350
                easing.type: Easing.OutQuart
            }
            ColorAnimation {
                duration: 350
                easing.type: Easing.OutQuart
            }
        }
    ]

    Rectangle {
        id: contentContainer

        smooth: true
        radius: cardRadius
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 0
            verticalOffset: 2
            radius: 4
            color: "#33000000"
        }
        anchors {
            fill: parent
            leftMargin: root.spacing - (root.position % root.spanCount) * root.spacing / root.spanCount
            topMargin: root.position < spanCount ? root.spacing : 0
            rightMargin: ((root.position % root.spanCount) + 1) * root.spacing / root.spanCount
            bottomMargin: root.spacing
        }

        Image {
            id: image
            anchors.fill: parent
            source: root.product.picture !== null ? root.product.picture : "../icons/placeholder.png"
            fillMode: Image.PreserveAspectCrop
            smooth: true
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    anchors.centerIn: parent
                    width: image.width
                    height: image.height
                    radius: root.cardRadius
                }
            }
        }
        Item {
            anchors.fill: parent

            LinearGradient {
                anchors.fill: parent
                smooth: true
                gradient: Gradient {
                    GradientStop { id: gradientStart; position: 0.0; color: "#00000000" }
                    GradientStop { position: 1.0; color: "#8C000000" }
                }
                layer {
                    enabled: true
                    effect: OpacityMask {
                        maskSource: Rectangle {
                            width: contentContainer.width
                            height: contentContainer.height
                            radius: root.cardRadius
                        }
                    }
                }
            }
            Image {
                id: checkIcon
                source: "../icons/ic_check_circle.svg"
                sourceSize.width: parent.width / 5
                sourceSize.height: parent.width / 5
                anchors.centerIn: parent
            }
            RowLayout {
                id: content
                anchors {
                    left: parent.left
                    right: parent.right
                    bottom: parent.bottom
                    margins: 16
                }

                Text {
                    text: root.product.name
                    color: "white"
                    font.bold: true
                    font.pointSize: 11
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                }
                Rectangle {
                    radius: 18
                    color: "#5FAD56"
                    Layout.preferredWidth: price.height * 1.8
                    Layout.preferredHeight: price.height * 1.8
                    Layout.alignment: Qt.AlignVCenter

                    Text {
                        id: price
                        text: root.product.quantity
                        color: "white"
                        font.bold: true
                        font.pointSize: 10
                        anchors.centerIn: parent
                    }
                }
            }
        }
        Ripple {
            color: "#1A000000"
            pressed: mouseArea.pressed
            active: mouseArea.containsMouse
            anchors.fill: parent
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: contentContainer.width
                    height: contentContainer.height
                    radius: root.cardRadius
                }
            }
        }

        MouseArea {
            id: mouseArea
            hoverEnabled: true
            anchors.fill: parent
            onClicked: {
                root.selected = !root.selected
                root.clicked(root.selected)
            }
        }
    }
}
