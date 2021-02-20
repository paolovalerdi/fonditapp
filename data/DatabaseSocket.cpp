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
	if (event.contains("event") && event.contains("target")) {
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
		qDebug() << "######## DatabaseSocket ########";
		qDebug() << "DatabaseSocket: Conneceted to server";
		qDebug() << "####################";
	});
	connect(socket, &QWebSocket::textMessageReceived, [=](QString message) {
		recieveMessage(message);
	});
	socket->open(QUrl("ws://localhost:3000"));
}

void DatabaseSocket::recieveMessage(QString message)
{
	qDebug() << "######## DatabaseSocket ########";
	qDebug() << "DatabaseSocket: Recieved message from server, sending to observers";
	qDebug() << "####################";
	auto doc = QJsonDocument::fromJson(message.toUtf8());
	if (!doc.isNull() && doc.isObject()) {
		for (auto &observer : observers) {
			observer->onEventRecieved(doc.object());
		}
	} else {
		qDebug() << "######## DatabaseSocket ########";
		qDebug() << "DatabaseSocket: Not valid JSON";
		qDebug() << message.toUtf8();
		qDebug() << "####################";
	}

}
