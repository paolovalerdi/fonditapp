import QtQuick 2.12
import QtQuick.Controls 2.12
import QtCharts 2.12
import QtQuick.Layouts 1.12

Page {
    id: root
    anchors.fill: parent

    SwipeView{
        id: swipeView
        anchors.fill: parent
        interactive: true
        currentIndex: 0

        Item{
            ChartView {
                id: chart
                title: "¿Cómo calificas el sabor de los platillo?"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                theme: ChartView.ChartThemeQt
                PieSeries {
                    PieSlice { label: "Bien"; value: 42.85 }
                    PieSlice { label: "Regular"; value: 14.28 }
                    PieSlice { label: "Malo"; value: 42.85 }
                }
            }
        }
        Item{
            ChartView {
                title: "¿Cómo calificas el servicio del mesero?"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                theme: ChartView.ChartThemeBlueNcs
                PieSeries {
                    PieSlice { label: "Bien"; value: 50 }
                    PieSlice { label: "Regular"; value: 40 }
                    PieSlice { label: "Malo"; value: 10 }
                }
            }
        }
        Item{
            ChartView {
                title: "¿En general como calificas el servicio de nuestro resturante?"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                theme: ChartView.ChartThemeQt
                PieSeries {
                    PieSlice { label: "Bien"; value: 30 }
                    PieSlice { label: "Regular"; value: 20 }
                    PieSlice { label: "Malo"; value: 50 }
                }
            }
        }
        Item{
            ChartView {
                title: "¿Cómo te enteraste de nosotros?"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true
                theme: ChartView.ChartThemeBlueNcs
                PieSeries {
                    PieSlice { label: "Bien"; value: 10 }
                    PieSlice { label: "Regular"; value: 20 }
                    PieSlice { label: "Malo"; value: 70 }
                }
            }
        }
        Item{
            ChartView {
                title: "Top 3 Platillos mas vendidos"
                anchors.fill: parent
                legend.alignment: Qt.AlignBottom
                antialiasing: true

                BarSeries {
                    id: mySeries
                    axisX: BarCategoryAxis { categories: ["Enero", "Febrero", "Marzo"] }
                    BarSet { label: "Sopes"; values: [2, 2, 3] }
                    BarSet { label: "Cafe"; values: [5, 1, 2] }
                    BarSet { label: "Frijoles"; values: [3, 5, 8] }
                }
            }

        }
    }

    PageIndicator {
        count: swipeView.count
        currentIndex: swipeView.currentIndex
        anchors.bottom: swipeView.bottom
        anchors.horizontalCenter: swipeView.horizontalCenter
    }



}
