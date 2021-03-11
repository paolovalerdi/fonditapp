#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "DatabaseSocket.h"
#include "OrderListModel.h"
#include "ProductListModel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    DatabaseSocket::getInstance();
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    DatabaseSocket::getInstance();
    qmlRegisterType<OrderListModel>("Chef", 1, 0, "OrderListModel");
    qmlRegisterType<ProductListModel>("Chef", 1, 0, "ProductListModel");

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
