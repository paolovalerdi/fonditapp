import QtQuick 2.0
import Tables 1.0
Rectangle {
     anchors.fill: parent
     color: "#161616"
 GridView{
     id: gridView
     anchors.fill: parent
     cellWidth: width/3
     cellHeight: height/3

     model: TablesModel{}

     delegate: Rectangle{
              width: gridView.cellWidth * 0.9
              height: gridView.cellHeight * 0.9
              radius: 6
              color: "#ff5252"
              Text {
                  text: model.idTable
                  anchors.centerIn: parent
                  font.bold: true
                  font.pointSize: 18
              }
     }
 }

}
