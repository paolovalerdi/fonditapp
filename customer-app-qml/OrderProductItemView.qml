import QtQuick 2.0

Item {
    width: orderListView.width
    height: 200
    property string name: ""
    property string description: ""
    property string price: ""
    property string image: ""
    property int quantity: -1
     Row{
         Text {
             id: orderProductQuantity
             text: quantity
         }
         Image {
             id: orderProductImage
             source: image
         }
         Column{
             Text {
                 id: orderProductName
                 text: name
             }
             Text {
                 id: orderProductDescription
                 text: description
             }
         }
         Text {
             id: orderProductPrice
             text: price
         }
     }
}
