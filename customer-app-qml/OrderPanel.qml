import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Controls.Material.impl 2.15
import Order 1.0

Rectangle {
    id: root

    property real progress: 0
    property bool editable: true

    width: parent.width * 0.45
    height: parent.height * 0.9
    color: "#fff"
    anchors.horizontalCenter: parent.horizontalCenter

    state: "hidden"
    states: [
        State {
            name: "hidden"
            PropertyChanges {
                target: root
                y: parent.height
            }
        },
        State {
            name: "collapsed"
            PropertyChanges {
                target: root
                y: parent.height - expandButton.height
            }
            PropertyChanges {
                target: expandButton
                opacity: 1
            }
            PropertyChanges {
                target: collapseButton
                opacity: 0
            }
            PropertyChanges {
                target: root
                progress: 0
            }
            PropertyChanges {
                target: list
                opacity: 0
            }
        },
        State {
            name: "expanded"
            PropertyChanges {
                target: root
                y: parent.height * 0.1
            }
            PropertyChanges {
                target: expandButton
                opacity: 0
            }
            PropertyChanges {
                target: collapseButton
                opacity: 1
            }
            PropertyChanges {
                target: root
                progress: 1
            }
            PropertyChanges {
                target: list
                opacity: 1
            }
        }
    ]
    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"

            NumberAnimation {
                properties: "y";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
            NumberAnimation {
                properties: "progress";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        },
        Transition {
            from: "expanded"
            to: "collapsed"

            NumberAnimation {
                properties: "y";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
            NumberAnimation {
                properties: "progress";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        },
        Transition {
            from: "hidden"
            to: "collapsed"

            NumberAnimation {
                properties: "y";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        },
        Transition {
            from: "collapsed"
            to: "hidden"

            NumberAnimation {
                properties: "y";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        }
    ]

    Rectangle {
        id: expandButton

        width: root.width
        height: 48
        clip: true
        color: "#0FBF5C"

        IconLabel {
            text: "Ver mi orden"
            color: "#fff"
            spacing: 16
            font.pointSize: 12
            icon.color: "#fff"
            icon.source: "../icons/ic_receipt.svg"
            anchors.centerIn: expandButton
        }
        Ripple {
            id: expandRipple

            color: "#1A000000"
            pressed: expandMouseArea.pressed
            active: expandMouseArea.containsMouse
            anchors.fill: expandButton
        }

        MouseArea {
            id: expandMouseArea

            hoverEnabled: true
            anchors.fill: expandButton

            onClicked: root.expand()
        }
    }
    ToolButton {
        id: collapseButton

        icon.source: "../icons/ic_close.svg"
        anchors.left: root.left
        anchors.top: root.top

        onClicked: root.collapse()
    }
    ListView{
        id: list

        clip: true
        spacing: 16
        model: OrderProductListModel { mediator: orderMediator }
        delegate: OrderProduct { width: list.width; product: model }
        anchors {
            left: root.left
            top: collapseButton.bottom
            right: root.right
            bottom: confirmButton.top
        }
    }
    Rectangle {
        id: confirmButton

        clip: true
        width: parent.width
        height: expandButton.height
        color: "#0FBF5C"
        anchors.bottom: root.bottom

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
            anchors.fill: confirmButton

            onClicked: {
                orderMediator.createOrder()
                root.collapse()
            }
        }
    }

    Connections {
        target: orderMediator
        onProductsUpdated: {
            collapse();
        }

        function onOrderCreated() {
            collapse();
        }
    }

    function expand() {
        if (root.state === "collapsed") {
            root.state = "expanded"
        }
    }

    function collapse() {
        root.state = "collapsed"
    }
}
