import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0
import QtQuick.Dialogs 1.2

import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Material 2.0

Page {
    id: editFormRoot

    property int productId: -1
    property string name: ""
    property string description: ""
    property string picture: ""
    property string price: ""

    title: "Editar producto"

    anchors.fill: parent

    MessageDialog {
        id: confirmationDialog
        visible: false
        title: "Confirmación"
        text: "¿Seguro que quieres editar este producto?"
        onAccepted: {
            productFormViewModel.updateProduct(productId,
                                               nameTextField.text,
                                               descriptionTextArea.text,
                                               priceTextField.text);
            stackView.pop();
        }

    }

    Rectangle {
        id: imageContainer
        width: parent.width * 0.3
        height: width
        anchors {
            verticalCenter: parent.verticalCenter
            left: parent.left
            leftMargin: parent.width * 0.1
        }
        Rectangle {
            id: mask
            width: parent.width
            height: parent.width
            radius: parent.width / 2
            visible: false
        }
        Image {
            id: productPicture
            width: parent.width
            height: parent.width
            source: picture
            fillMode: Image.PreserveAspectCrop
            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: mask
            }
        }
    }
    Column {
        spacing: 8
        anchors {
            verticalCenter: parent.verticalCenter
            left: imageContainer.right
            right: parent.right
            leftMargin: parent.width * .1
        }
        Column {
            width: parent.width
            spacing: 4
            Label {
                text: "Nombre"
            }
            TextField {
                id: nameTextField
                text: name
                placeholderText: "Nombre del producto"
            }
            Column {
                width: parent.width
                Label {
                    text: "Descripción"
                }
                TextArea {
                    id: descriptionTextArea
                    width: 220
                    text: description
                    wrapMode: TextEdit.WordWrap
                }
            }
            Column {
                Label { text: "Precio" }
                Row {
                    Label {
                        y: 8
                        text: "$"
                    }
                    TextField {
                        id: priceTextField
                        text: price
                        placeholderText: "Precio"
                        validator: DoubleValidator {
                            bottom: 0
                            decimals: 2
                            top: 1000
                        }
                    }
                }

            }
            Row {
                spacing: 8
                Button {
                    text: "Guardar"
                    onClicked: {
                        confirmationDialog.visible = true
                    }
                }
                Button {
                    text: "Eliminar"
                    Material.background: Material.Red
                    Material.foreground: Material.White
                    onClicked: {
                        confirmationDialog.visible = true
                    }
                }
            }

        }
    }
}

