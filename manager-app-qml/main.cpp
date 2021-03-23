#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "ProductionDatabase.h"
#include "../customer-app-qml/ProductListModel.h"
#include "ProductFormViewModel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QApplication app(argc, argv);
    QQmlApplicationEngine engine;

    qmlRegisterType<ProductListModel>("Product", 1, 0, "ProductListModel");

    ProductFormViewModel productFormViewModel;
    engine.rootContext()->setContextProperty("productFormViewModel", &productFormViewModel);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
