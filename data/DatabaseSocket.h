#pragma once

#include <QObject>
#include <QWebSocket>
#include <QJsonObject>
#include <QJsonDocument>

#include "DatabaseObserver.h"

class DatabaseSocket : public QObject
{
		Q_OBJECT

	public:
		static DatabaseSocket* getInstance();
		void addObserver(DatabaseObserver* observer);
		void sendEvent(QJsonObject event);

	private:
		static DatabaseSocket* instance;

		QWebSocket *socket;
		QList<DatabaseObserver*> observers;

		DatabaseSocket(QObject *parent = nullptr);
		void recieveMessage(QString message);
};

