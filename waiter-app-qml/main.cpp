#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "OrderListModel.h"
#include "OrderListModelCallback.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    // Registramos las clases de C++ que sirven como modelos para QML
    qmlRegisterType<OrderListModel>("Order", 1, 0, "OrderListModel");
    qmlRegisterUncreatableType<OrderListModelCallback>("Order", 1, 0, "OrderListModelCallback", "Can't create instaces of this class");

    OrderListModelCallback orderListModelCallback;
    engine.rootContext()->setContextProperty("orderListModelCallback", &orderListModelCallback);



    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
