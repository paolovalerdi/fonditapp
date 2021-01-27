import QtQuick 2.9
import QtQuick.Controls 2.2

import QtQuick.Controls.Styles 1.0
import QtQuick.Controls.Styles 1.4

Page {
    anchors.fill: parent

    title: qsTr("Editar Producto")


    Label {
        x: 298
        y: 76
        text: qsTr("Nombre")


    }



    Label{
        x: 300
        y: 133
        text: qsTr("Descripción")

    }
    Label{
        x: 298
        y: 209
        width: 58
        height: 20
        text: qsTr("Precio")
        font.pointSize: 8
        font.family: "Arial"
        //horizontalAlignment: Text.AlignLeft
        //anchors.left: parent
    }


    Image {

        id: img
        x: 68
        y: 76
        width: 202
        height: 182

        source: 'file:///C:/Users/maria/Desktop/610-sopes.jpg'

    }

Label {
    id: label
    x: 73
    y: 48
    width: 107
    height: 16
    text: qsTr("Editar Producto")
    font.pointSize: 10
}

CheckBox {
    x: 350
    y: 262
    text: "Check Box"


   }



Button {
    id: button1
    x: 308
    y: 330
    text: qsTr("Guardar cambios")
    font.capitalization: Font.MixedCase

}

Button {
    id: button2
    x: 457
    y: 326
    width: 76
    height: 54
    //text: qsTr("Eliminar producto")
    icon.name: "Eliminar producto"
    icon.source: 'file:///D:/Descargas/bote_b.png'
}

TextArea {
    id: textArea
    x: 380
    y: 118
    placeholderText: qsTr("Text Area")
}

TextArea {
    id: textArea1
    x: 380
    y: 68
    placeholderText: qsTr("Text Area")
}

TextArea {
    id: textArea2
    x: 380
    y: 199
    placeholderText: qsTr("Text Area")
}
}



/*##^##
Designer {
    D{i:0;autoSize:true;formeditorZoom:1.25;height:480;width:640}
}
##^##*/
