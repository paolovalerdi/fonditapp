#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "OrderListModel.h"
#include "WaiterBoardMediator.h"
#include "DatabaseSocket.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
		DatabaseSocket::getInstance();

    qmlRegisterType<OrderListModel>("Order", 1, 0, "OrderListModel");
    qmlRegisterUncreatableType<WaiterBoardMediator>("Order", 1, 0, "WaiterBoardMediator", "Can't create instaces of this class");

    WaiterBoardMediator waiterBoardMediator;
    engine.rootContext()->setContextProperty("waiterBoardMediator", &waiterBoardMediator);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
