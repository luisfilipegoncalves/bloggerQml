#ifndef BLOGGERPROXYMODEL_H
#define BLOGGERPROXYMODEL_H

#include <QSortFilterProxyModel>
#include <QStandardItemModel>
#include <QStandardItem>
#include <QDate>



class BloggerProxyModel : public QSortFilterProxyModel
{
    Q_OBJECT
public:
    explicit BloggerProxyModel(QObject *parent = 0);

    Q_INVOKABLE void search(const QString &text);


signals:

public slots:
    void dataChanged(QModelIndex,QModelIndex);

private:
    //BlogModel *m_model;
};

#endif // BLOGGERPROXYMODEL_H
