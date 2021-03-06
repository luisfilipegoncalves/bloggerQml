#ifndef BLOGMODEL_H
#define BLOGMODEL_H

#include <QStandardItemModel>
#include <QDate>

class BlogModel : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit BlogModel(QObject *parent = 0);

    void addBlog(QString name, QString url, int rating, QString lastDate, QString nextDate, QString note, QString blogId);

    virtual bool setData(const QModelIndex &index, const QVariant &value, int role);

private slots:
    void modelDataChanged(QModelIndex,QModelIndex);

protected:
    QHash<int, QByteArray> roleNames() const;

};


#endif // BLOGMODEL_H
