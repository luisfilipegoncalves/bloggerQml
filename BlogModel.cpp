#include "BlogModel.h"

BlogModel::BlogModel(QObject *parent) :
    QStandardItemModel(parent)
{

}

QHash<int, QByteArray> BlogModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::DisplayRole] = "name";
    roles[Qt::UserRole + 1] = "url";
    roles[Qt::UserRole + 2] = "rating";
    roles[Qt::UserRole + 3] = "lastdate";
    roles[Qt::UserRole + 4] = "nextdate";
    roles[Qt::UserRole + 5] = "note";
    return roles;
}

void BlogModel::addBlog(QString name, QString url, int rating, QString lastDate, QString nextDate, QString note)
{
    QStandardItem *item = new QStandardItem(name);
    item->setData(url, Qt::UserRole +1);
    item->setData(rating, Qt::UserRole +2);
    item->setData(lastDate, Qt::UserRole +3); // TODO: dia mes ano
    item->setData(nextDate, Qt::UserRole +4);
    //item->setData(lastDate.toString("dd/MM/yyyy"), Qt::UserRole +3); // TODO: dia mes ano
    //item->setData(nextDate.toString(), Qt::UserRole +4);
    item->setData(note, Qt::UserRole +5);
    appendRow(item);
}
