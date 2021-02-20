#pragma once

#include <QObject>
#include <QWebSocket>

#include "DatabaseObserver.h"

class DatabaseSocket : public QObject
{
		Q_OBJECT

	public:
		static DatabaseSocket* getInstance();
		void addObserver(DatabaseObserver& observer);

	private:
		static DatabaseSocket* instance;

		QWebSocket *socket;
		QList<DatabaseObserver> observers;

		DatabaseSocket(QObject *parent = nullptr);
		void recieveMessage(QString message);
};

