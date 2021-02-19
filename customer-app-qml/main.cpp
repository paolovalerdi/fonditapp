#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ProductListModel.h"
#include "OrderProductListModel.h"
#include "OrderMediator.h"
#include "CategoryListModel.h"
#include "TablesModel.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

	QGuiApplication app(argc, argv);
	QQmlApplicationEngine engine;

	qmlRegisterType<ProductListModel>("Product", 1, 0, "ProductListModel");
	qmlRegisterType<OrderProductListModel>("Order", 1, 0, "OrderProductListModel");
	qmlRegisterType<CategoryListModel>("Category", 1, 0, "CategoryViewModel");
	qmlRegisterType<TablesModel>("Tables", 1, 0, "TablesModel");

	qmlRegisterUncreatableType<OrderMediator>("Order", 1, 0, "OrderMediator", "Can't create instaces of this class");

	OrderMediator orderMediator;
	engine.rootContext()->setContextProperty("orderMediator", &orderMediator);

	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
									 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);
	engine.load(url);
	return app.exec();
}
