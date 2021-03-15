import QtQuick 2.15
import QtGraphicalEffects 1.15
import QtQuick.Controls 2.12
import QtQuick.Controls.Material 2.12

Column {
    id: root

    property string question: ""
    property string answer: ""
    property var currentSelection: null
    property bool openAsnwer: false

    spacing: 8

    Text {
        text: root.question
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 13
        wrapMode: Text.WrapAtWordBoundaryOrAnywhere
        anchors {
            left: parent.left
            right: parent.right
            margins: 24
        }
    }
    Row {
        visible: !root.openAsnwer
        anchors.horizontalCenter: parent.horizontalCenter
        ToolButton {
            id: sad
            width: 72
            height: 72
            opacity: root.currentSelection === sad ? 1 : 0.4
            down: opacity === 1
            icon.source: "../icons/ic_sad.svg"
            icon.width: 48
            icon.height: 48
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: "#ff1744"
            }
            onClicked: {
                root.answer = "Triste"
                root.currentSelection = sad
            }
        }
        ToolButton{
            id: neutral
            width: 72
            height: 72
            opacity: root.currentSelection === neutral ? 1 : 0.4
            down: opacity === 1
            icon.source: "../icons/ic_neutral.svg"
            icon.width: 48
            icon.height: 48
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: "#804BF2"
            }
            onClicked: {
                root.answer = "Neutral"
                root.currentSelection = neutral
            }
        }
        ToolButton {
            id: happy
            width: 72
            height: 72
            opacity: root.currentSelection === happy ? 1 : 0.4
            down: opacity === 1
            icon.source: "../icons/ic_happy.svg"
            icon.width: 48
            icon.height: 48
            layer.enabled: true
            layer.effect: ColorOverlay {
                color: "#5FAD56"
            }
            onClicked: {
                root.answer = "Feliz"
                root.currentSelection = happy
            }
        }
    }
    ComboBox {
        editable: false
        visible: root.openAsnwer
        anchors{
            horizontalCenter: parent.horizontalCenter
        }

        model: ListModel {
            id: model
            ListElement { text: "Internet" }
            ListElement { text: "Amigos/Familiares" }
            ListElement { text: "Anuncio" }
            ListElement { text: "Otros"}
        }
        onActivated: {
            console.log(textAt(index))
            root.answer = textAt(index)
        }
    }
}
