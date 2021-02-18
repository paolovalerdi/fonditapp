#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ProductListModel.h"
#include "ProductViewModelCallback.h"
#include "OrderProductListModel.h"
#include "OrderViewModelCallback.h"
#include "CategoryListModel.h"
#include "TablesModel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	// Registramos las clases de C++ que sirven como modelos para QML
	qmlRegisterType<ProductListModel>("Product", 1, 0, "ProductViewModel");
	qmlRegisterUncreatableType<ProductViewModelCallback>("Product", 1, 0, "ProductViewModelCallback", "Can't create instaces of this class");
	//
	qmlRegisterType<OrderProductListModel>("Order", 1, 0, "OrderViewModel");
	qmlRegisterUncreatableType<OrderViewModelCallback>("Order", 1, 0, "OrderViewModelCallback", "Can't create instaces of this class");

	qmlRegisterType<CategoryListModel>("Category", 1, 0, "CategoryViewModel");
	qmlRegisterType<TablesModel>("Tables", 1, 0, "TablesModel");

	// Registramos ProductViewModelCallback como una variable dentro del contexto de QML.
	ProductViewModelCallback productViewModelCallback;
	engine.rootContext()->setContextProperty("productViewModelCallback", &productViewModelCallback);

	//
	OrderViewModelCallback orderViewModelCallback;
	engine.rootContext()->setContextProperty("orderViewModelCallback", &orderViewModelCallback);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
									 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);
	return app.exec();
}
