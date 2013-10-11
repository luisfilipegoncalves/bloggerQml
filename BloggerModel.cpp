#ifndef BLOGGERMODEL_H
#define BLOGGERMODEL_H

#include <QSortFilterProxyModel>
#include <QStandardItemModel>
#include <QStandardItem>
#include <QDate>

class BlogModel : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit BlogModel(QObject *parent = 0){}

protected:
    QHash<int, QByteArray> roleNames() const
    {
        QHash<int, QByteArray> roles;
        roles[Qt::DisplayRole] = "name";
        roles[Qt::UserRole + 1] = "url";
        roles[Qt::UserRole + 2] = "rating";
        roles[Qt::UserRole + 3] = "lastdate";
        roles[Qt::UserRole + 4] = "nextdate";
        return roles;
    }
};


class BloggerProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit BloggerProxyModel(QObject *parent = 0);

    Q_INVOKABLE void search(const QString &text);

    void addBlog(QString name, QString url, int rating, QDate lastDate, QDate nextDate);

signals:

public slots:
    void dataChanged(QModelIndex,QModelIndex);

private:
    BlogModel *m_model;
};

#endif // BLOGGERMODEL_H
