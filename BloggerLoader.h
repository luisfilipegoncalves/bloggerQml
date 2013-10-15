#ifndef BLOGGERLOADER_H
#define BLOGGERLOADER_H

#include <QObject>
#include <QStandardItemModel>

class BlogModel;
class BloggerLoader : public QObject
{
    Q_OBJECT
public:
    explicit BloggerLoader(QObject *parent = 0);

    bool loadBlogsFromFile();
    QStandardItemModel *model();

signals:

public slots:

private:
    BlogModel *m_model;
};

#endif // BLOGGERLOADER_H
