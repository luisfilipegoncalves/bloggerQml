#include "BlogModel.h"
#include "BloggerLoader.h"
#include <QDebug>

BlogModel::BlogModel(QObject *parent) :
    QStandardItemModel(parent)
{
    setColumnCount(8);
    connect(this, SIGNAL(dataChanged(QModelIndex,QModelIndex)),
            this, SLOT(modelDataChanged(QModelIndex,QModelIndex)));
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

bool BlogModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    bool res = QStandardItemModel::setData(index, value, role);

    if(role==Qt::UserRole+2) // rating
    {
        int rating = value.toInt();
        QStandardItem *changedItem = item(index.row(), 0);
        if(changedItem)
            changedItem->setData(BloggerLoader::ratingColor(rating), Qt::UserRole +6);
    }
    return res;
}

void BlogModel::modelDataChanged(QModelIndex i1, QModelIndex i2)
{
    QString lastDateStr = i1.data(Qt::UserRole+3).toString();
    QDate lastDate = QDate::fromString(lastDateStr, "dd-MM-yyyy");
    if(lastDate.isValid())
    {
        QStandardItem *changedItem = item(i1.row(), 0);
        if(changedItem)
        {
            int rating = changedItem->data(Qt::UserRole+2).toInt();
            QDate nextDate = BloggerLoader::nextDate(lastDate, rating);
            QString nextDateStr = nextDate.toString("dd-MM-yyyy");
            changedItem->setData(nextDateStr, Qt::UserRole+4);
        }
    }
}
