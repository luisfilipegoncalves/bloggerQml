#include "BlogModel.h"
#include "BloggerLoader.h"

BlogModel::BlogModel(QObject *parent) :
    QStandardItemModel(parent)
{
    setColumnCount(8);
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
    roles[Qt::UserRole + 6] = "ratingColor";
    roles[Qt::UserRole + 7] = "id";
    return roles;
}

void BlogModel::addBlog(QString name, QString url, int rating, QString lastDate, QString nextDate, QString note, QString blogId)
{
    QStandardItem *item = new QStandardItem(name);
    item->setData(url, Qt::UserRole +1);
    item->setData(rating, Qt::UserRole +2);
    item->setData(lastDate, Qt::UserRole +3);
    item->setData(nextDate, Qt::UserRole +4);
    item->setData(note, Qt::UserRole +5);
    item->setData(BloggerLoader::ratingColor(rating), Qt::UserRole +6);
    item->setData(blogId, Qt::UserRole +7);
    appendRow(item);
}
