#include "DatabaseSocket.h"

DatabaseSocket* DatabaseSocket::instance = nullptr;

DatabaseSocket* DatabaseSocket::getInstance()
{
	if (!instance) {
		instance = new DatabaseSocket();
	}
	return instance;
}

void DatabaseSocket::addObserver(DatabaseObserver& observer)
{
	observers.append(observer);
}

DatabaseSocket::DatabaseSocket(QObject *parent) : QObject(parent)
{
	socket = new QWebSocket();
	connect(socket, &QWebSocket::connected, this, [=]() {
		qDebug() << "Conneceted to socket";
	});
	connect(socket, &QWebSocket::textMessageReceived, [=](QString message) {
		recieveMessage(message);
	});
	socket->open(QUrl("ws://localhost:3000"));
}

void DatabaseSocket::recieveMessage(QString message)
{
	for (auto &observer : observers) {
		observer.onMessageRecieved(message);
	}
}
