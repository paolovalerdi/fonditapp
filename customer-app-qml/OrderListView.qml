import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12
import Order 1.0

Rectangle {
    id: root

    property real progress: 0
    property int amount: value

    onAmountChanged: {
        if (amount === 1) {
            root.state = "collapsed"
        }
    }

    width: parent.width * 0.5
    height: parent.height * 0.9
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
                target: root
                color: "#0FBF5C"
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
                target: orderListView
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
                target: root
                color: "white"
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
                target: orderListView
                opacity: 1
            }
        }
    ]
    transitions: [
        Transition {
            from: "collapsed"
            to: "expanded"

            ColorAnimation {
                easing.type: Easing.OutQuart;
                duration: 350
            }
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

            ColorAnimation {
                easing.type: Easing.OutQuart;
                duration: 350
            }
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

    ItemDelegate {
        id: expandButton
        icon.source: "../icons/ic_receipt.svg"
        icon.color: "white"
        anchors.horizontalCenter: parent.horizontalCenter
        text: "Ver mi orden"
        Material.foreground:"#FFF"
        onClicked: root.state = "expanded"
    }


    ToolButton {
        id: collapseButton
        icon.source: "../icons/ic_close.svg"
        onClicked: root.state = "collapsed"
        anchors.left: root.left
        anchors.top: root.top
    }
    ListView{
        id: orderListView

        clip: true
        anchors {
            left: root.left
            top: collapseButton.bottom
            right: root.right
            bottom: confirmButton.top
        }
        model: OrderViewModel { callback: orderViewModelCallback }
        delegate: OrderProductItemView{
            idProduct: model.idProduct
            name:model.name
            description: model.description
            price: model.price
            quantity: model.quantity
            image: model.picture
        }
    }

    Rectangle {
        id: confirmButton
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
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.state = "collapsed"
              //  root.state = "hidden"

                orderViewModelCallback.createdOrder(window.idTable)
            }
        }
    }

}
