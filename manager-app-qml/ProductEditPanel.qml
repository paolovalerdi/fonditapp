import QtQuick 2.12
import QtQuick.Controls 2.12

import QtQuick.Controls.Material 2.12

Rectangle {
    id: root

    property var model: null
    property bool isBound: false
    property bool isCreateMode: false

    width: parent.width * 0.35
    height: parent.height
    color: "white"

    state: "close"
    states: [
        State {
            name: "open"
            PropertyChanges {
                target: root
                x: parent.width - width
            }
            PropertyChanges {
                target: separator
                opacity: 0
            }
        },
        State {
            name: "close"
            PropertyChanges {
                target: root
                x: parent.width
            }
            PropertyChanges {
                target: separator
                opacity: 0
            }
        }
    ]
    transitions: [
        Transition {
            from: "close"; to: "open"
            NumberAnimation {
                properties: "x"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        },
        Transition {
            from: "open"; to: "close"
            NumberAnimation {
                properties: "x"
                duration: 350
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                properties: "opacity";
                easing.type: Easing.OutQuart;
                duration: 350;
            }
        }
    ]

    onModelChanged: render(model)

    ScrollView {
        anchors.fill: parent
        clip: true
        ScrollBar.vertical.interactive: false

        Column {
            id: columnContainer

            width: root.width
            topPadding: 24
            bottomPadding: 24
            spacing: 12

            ToolButton {
                icon.source: "../icons/ic_close.svg"
                anchors {
                    left: parent.left
                    leftMargin: parent.width * 0.03
                }
                onClicked: root.close()
            }
            Image {
                height: width
                source: model !== null ? model.picture : ""
                fillMode: Image.PreserveAspectCrop
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
            }
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }

                Label { text: "Nombre"; font.bold: true }
                TextField {
                    id: nameTextField

                    width: parent.width
                    text: model !== null ? model.name : ""
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    validator: regex
                    onTextChanged: { columnContainer.toggleButtonState() }
                }
            }
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }

                Label { text: "Descripcion"; font.bold: true }
                TextArea {
                    id: descriptionTextField

                    width: parent.width
                    text: model !== null ? model.description : ""
                    wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                    onTextChanged: { columnContainer.toggleButtonState() }
                }
            }
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }

                Label { text: "Precio"; font.bold: true }
                TextField {
                    id: priceTextField
                    width: parent.width
                    text: model !== null ? model.price : 0
                    validator: DoubleValidator { bottom: 1; top: 1000; decimals: 2 }
                    onTextChanged: { columnContainer.toggleButtonState() }
                }
            }
            Button {
                id: saveButton

                icon.source: "../icons/ic_save.svg"
                text: root.isCreateMode ? "Agregar Producto":"Guardar cambios"
                enabled: false
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
                onClicked:
                {
                    if(root.isCreateMode)
                    {
                        productFormViewModel.createProduct(nameTextField.text,descriptionTextField.text,priceTextField.text)
                    }else
                    {
                        console.log("actualizando")
                        productFormViewModel.updateProduct(root.model.productId,nameTextField.text,descriptionTextField.text,priceTextField.text)
                    }
                }
            }
            Button {
                id: deleteButton

                visible: !root.isCreateMode
                icon.source: "../icons/ic_delete.svg"
                text: "Eliminar producto"
                Material.background: "#c62828"
                Material.foreground: "white"
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: parent.width * 0.08
                    rightMargin: parent.width * 0.08
                }
                onClicked: {
                    productFormViewModel.deleteProduct(root.model.productId)
                    root.close()
                }
            }

            RegExpValidator {
                id: regex
                regExp: /^(?!\s*$).+/
            }

            function toggleButtonState() {
                if (root.isBound && !root.isCreateMode) {
                    var didNameChange = (root.model.name.localeCompare(nameTextField.text) !== 0) && nameTextField.acceptableInput
                    var didDecriptionChange = (root.model.description.localeCompare(descriptionTextField.text) !== 0) && regex.regExp.test(descriptionTextField.text)
                    var didPriceChange = priceTextField.acceptableInput && (root.model.price !== parseFloat(priceTextField.text))
                    saveButton.enabled = didNameChange || didDecriptionChange || didPriceChange
                }else
                {
                    var didNameChange2= nameTextField.acceptableInput
                    var didDecriptionChange2 = regex.regExp.test(descriptionTextField.text)
                    var didPriceChange2 = priceTextField.acceptableInput
                    saveButton.enabled = didNameChange2 || didDecriptionChange2 || didPriceChange2
                }
            }
        }
    }
    Rectangle {
        id: separator
        width: 1
        color: "red"
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
        }
    }

    function close() {
        state = "close"
    }

    function open(product) {
        isCreateMode=false
        root.model = product
        state = "open"
    }

    function render(product) {
        if (product !== null && !root.isCreateMode) {
            nameTextField.text = product.name
            descriptionTextField.text = product.description
            priceTextField.text = product.price
        }else
        {
            nameTextField.clear()
            descriptionTextField.clear()
            priceTextField.clear()
        }

        root.isBound = product !== null
    }

    function create()
    {
        root.isCreateMode=true
        root.isBound=false
        root.model=null
        root.isBound=true
        state="open"
    }
}
