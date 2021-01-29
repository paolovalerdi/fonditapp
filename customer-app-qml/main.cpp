#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ProductViewModel.h"
#include "ProductViewModelCallback.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Registramos las clases de C++ que sirven como modelos para QML
    qmlRegisterType<ProductViewModel>("Product", 1, 0, "ProductViewModel");
    qmlRegisterUncreatableType<ProductViewModelCallback>("Product", 1, 0, "ProductViewModelCallback", "Can't create instaces of this class");

    // Registramos ProductViewModelCallback como una variable dentro del contexto de QML.
    ProductViewModelCallback productViewModelCallback;
    engine.rootContext()->setContextProperty("productViewModelCallback", &productViewModelCallback);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);
    return app.exec();
}
