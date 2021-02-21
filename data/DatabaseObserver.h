#pragma once

#include <QString>
#include <QJsonObject>
#include <QJsonDocument>

class DatabaseObserver {
	public:
		virtual void onEventRecieved(QJsonObject event) = 0;
};
