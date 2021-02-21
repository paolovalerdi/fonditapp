#include "DatabaseSocket.h"

DatabaseSocket* DatabaseSocket::instance = nullptr;

DatabaseSocket* DatabaseSocket::getInstance()
{
	if (!instance) {
		instance = new DatabaseSocket();
	}
	return instance;
}

void DatabaseSocket::addObserver(DatabaseObserver* observer)
{
	observers.append(observer);
}

void DatabaseSocket::sendEvent(QJsonObject event)
{
	if (event.contains("key") && event.contains("target")) {
		QJsonDocument doc(event);
		socket->sendTextMessage(doc.toJson(QJsonDocument::Compact));
	} else {
		qDebug() << "DatabaseSocket: event does not contain either 'key' or 'target'";
	}
}

DatabaseSocket::DatabaseSocket(QObject *parent) : QObject(parent)
{
	socket = new QWebSocket();
	connect(socket, &QWebSocket::connected, this, [=]() {
		qDebug() << "DatabaseSocket: Conneceted to server";
	});
	connect(socket, &QWebSocket::textMessageReceived,this, [=](QString message) {
		recieveMessage(message);
	});
	socket->open(QUrl("ws://localhost:3000"));
}

void DatabaseSocket::recieveMessage(QString message)
{
	auto doc = QJsonDocument::fromJson(message.toUtf8());
	if (!doc.isNull() && doc.isObject()) {
		for (auto &observer : observers) {
			observer->onEventRecieved(doc.object());
		}
	}
}
