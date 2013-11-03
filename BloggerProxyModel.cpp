#include "BloggerProxyModel.h"
#include "BlogModel.h"
#include "BloggerLoader.h"

#include <QDate>
#include <QDebug>
#include <QUuid>

BloggerProxyModel::BloggerProxyModel(QObject *parent) :
    QSortFilterProxyModel(parent)
{
}

void BloggerProxyModel::search(const QString &text)
{
    setFilterWildcard(text);
}

bool BloggerProxyModel::tryAddBlog(QString name, QString url, int rating, QString lastDateStr, QString note)
{
    BlogModel *model = qobject_cast<BlogModel*>(sourceModel());
    if(!model)
        return false;

    qDebug() << "try to add new blog...";
    qDebug() << "name: " << name;
    qDebug() << "url: " << url;
    qDebug() << "rating: " << rating;
    qDebug() << "lastDate: " << lastDateStr;
    qDebug() << "note: " << note;

    QDate lastDate = QDate::fromString(lastDateStr, "dd-MM-yyyy");
    QDate nextdate;
    if(!lastDate.isNull())
        nextdate = BloggerLoader::nextDate(lastDate, rating);

    QString id = QUuid::createUuid().toString();

    model->addBlog(name, url, rating, lastDateStr, nextdate.toString("dd-MM-yyyy"), note, id);
    return true;
}

bool BloggerProxyModel::deleteBlog(int row)
{
    qDebug() << "Delete blog wor: " << row;
    QModelIndex sourceIndex = mapToSource(index(row, 0));
    qDebug() << "Delete blog source index: " << sourceIndex;
    bool deleted = sourceModel()->removeRow(sourceIndex.row());
    qDebug() << "Deleted ? " << deleted;
    return deleted;
}

bool BloggerProxyModel::filterAcceptsRow(int source_row, const QModelIndex &source_parent) const
{
    QModelIndex index = sourceModel()->index(source_row, 0, source_parent);
    QString url = index.data(Qt::UserRole+1).toString();
    QString note = index.data(Qt::UserRole+5).toString();
    QRegExp regE = filterRegExp();
    if(url.contains(regE))
        return true;
    else if(note.contains(regE))
        return true;

    return QSortFilterProxyModel::filterAcceptsRow(source_row, source_parent);
}
