#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ProductModel.h"
#include "ProductList.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    qmlRegisterType<ProductModel>("Product", 1, 0, "ProductModel");
    qmlRegisterUncreatableType<ProductList>("Product",1,0,"ProductList", "AAA");

    QQmlApplicationEngine engine;
    ProductList productList;
    engine.rootContext()->setContextProperty("productList", &productList);
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
