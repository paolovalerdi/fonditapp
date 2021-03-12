import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15
import QtGraphicalEffects 1.15

import Table 1.0

Rectangle {
    id: root

    property double progress: 0

    width: parent.width
    height: parent.height
    color: "#FFF"

    state: "open"
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: root
                y: 0
            }
            PropertyChanges {
                target: root
                progress: 0
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                y: -parent.height
            }
            PropertyChanges {
                target: root
                progress: 1
            }
        }
    ]
    transitions: [
        Transition {
            from: "close"; to: "open"
            NumberAnimation {
                properties: "y"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "progress"
                duration: 350
                easing.type: Easing.OutQuart
            }
        },
        Transition {
            from: "open"; to: "close"
            NumberAnimation {
                properties: "y"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "progress"
                duration: 350
                easing.type: Easing.OutQuart
            }
        }
    ]

    Text {
        id: title

        text: "Nos interesa saber tu opinion"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 24
        font.bold: true
        font.pointSize: 18
    }

    Rectangle {
        width: parent.width * 0.5
        color: "white"
        radius: 6
        border.color: "#1f000000"
        border.width: 1
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: title.bottom
            bottom: parent.bottom
            margins: 24
        }

        ScrollView {
            anchors {
                top: parent.top
                bottom: divider.top
                left: parent.left
                right: parent.right
            }

            clip: true
            ScrollBar.vertical.interactive: false
            ScrollBar.vertical.policy: ScrollBar.AlwaysOn

            Column {
                id: columContainer
                width: parent.width
                spacing: 16
                topPadding: 24
                bottomPadding: 24

                Question {
                    id: firstQuestion
                    width: parent.width
                    question: "¿Cómo calificas el sabor de los platillo?"
                }
                Question {
                    id: secondQuestion
                    width: parent.width
                    question: "¿Cómo calificas el servicio del mesero?"
                }
                Question {
                    id: thirdQuestion
                    width: parent.width
                    question: "¿En general como calificas el servicio de nuestro resturante?"
                }
                Question {
                    id: fourthQuestion
                    width: parent.width
                    question: "¿Cómo te enteraste de nosotros?"
                    openAsnwer: true
                }
            }

        }

        Rectangle {
            id: divider
            width: parent.width
            height: 1
            color: "#1f000000"
            anchors {
                left: parent.left
                right: parent.right
                bottom: buttonContainer.top
                bottomMargin: 16
            }
        }

        RowLayout {
            id: buttonContainer
            anchors {
                bottom: parent.bottom
                left: parent.left
                right: parent.right
                margins: 16
            }

            width: parent.width
            height: 40
            spacing: 16

            Rectangle {
                id: omitButton

                clip: true
                color: "transparent"
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 24

                Text {
                    text: "Omitir"
                    color: "#9e9e9e"
                    font.pointSize: 12
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Ripple {
                    id: omitRipple

                    color: "#1A000000"
                    pressed: omitMouseArea.pressed
                    active: omitMouseArea.containsMouse
                    anchors.fill: omitMouseArea
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: omitButton.width
                            height: omitButton.height
                            radius: 24
                        }
                    }
                }
                MouseArea {
                    id: omitMouseArea

                    hoverEnabled: true
                    anchors.fill: omitButton

                    onClicked: {

                    }
                }
            }
            Rectangle {
                id: sendButton

                clip: true
                color: "#5FAD56"
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: 24
                ToolButton {
                    text: "Enviar respuestas"
                    icon.source: "../icons/ic_send.svg"
                    Material.foreground: "white"
                    icon.color: "white"
                    font.pointSize: 12
                    font.capitalization: Font.MixedCase

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter

                }

                Ripple {
                    id: sendRipple

                    color: "#1A000000"
                    pressed: sendMouseArea.pressed
                    active: sendMouseArea.containsMouse
                    anchors.fill: sendMouseArea
                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: sendButton.width
                            height: sendButton.height
                            radius: 24
                        }
                    }
                }
                MouseArea {
                    id: sendMouseArea

                    hoverEnabled: true
                    anchors.fill: sendButton

                    onClicked: {

                    }
                }
            }
        }
    }
}
