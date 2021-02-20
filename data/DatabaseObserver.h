#pragma once

#include <QString>

class DatabaseObserver {
	public:
		virtual void onMessageRecieved(QString message) = 0;
};
