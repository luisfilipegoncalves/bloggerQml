#include "Helper.h"
#include <QDebug>
#include <QDate>

Helper::Helper(QObject *parent) :
    QObject(parent)
{
}

bool Helper::isDateValid(const QString &dateText)
{
    QDate date = QDate::fromString(dateText, "dd-MM-yyyy");
    qDebug() << "dateText: " << dateText << " valid datE? " << date.isValid() << " date: " << date;
    return date.isValid();
}
