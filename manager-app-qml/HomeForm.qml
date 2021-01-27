import QtQuick 2.9
import QtQuick.Controls 2.2

import Product 1.0
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.1

import QtQuick.Controls.Styles 1.4

Page {
    anchors.fill: parent


    title: qsTr("Fonditapp")

    Label {
        text: qsTr("Editar menú")
        anchors.centerIn: parent
    }


    //MENUUUU :C
    /*MessageDialog {
            id: msg
            title: "Title"
            text: "Button pressed"
            onAccepted: visible = false
        }*/




    GridView {
        id: gridView
        anchors {
            fill: parent
            margins: 12
        }
        cellWidth: (width / 3)
        cellHeight: (height / 3)
        model: ProductViewModel { //No sabemos xq es el modelo del costumer :c
            // @disable-check M16
            callback2: productViewModelCallback
        }
        delegate: Item {
            width: gridView.cellWidth
            height: gridView.cellHeight

            Item {
                width: gridView.cellWidth * 0.96
                height: gridView.cellHeight * 0.96
                anchors.centerIn: parent
                Image {
                    id: img
                    anchors.fill: parent
                    source: model.picture
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
                        text: model.name
                    }
                    Text {
                        id: priceText
                        color: "white"
                        font.pointSize: 8
                        text: model.price
                    }
                }

                Button {
                    text: "Editar"
                    onClicked:stackView.push (Qt.resolvedUrl("Page3Form.qml"));//msg.visible = true
                }

            } //ITEM secundario
        } //ITEM principal
    }


}
