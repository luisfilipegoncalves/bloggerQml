#ifndef BLOGGERLOADER_H
#define BLOGGERLOADER_H

#include <QObject>
#include <QStandardItemModel>
#include <QDir>

class BlogModel;
class BloggerLoader : public QObject
{
    Q_OBJECT
public:
    explicit BloggerLoader(QObject *parent = 0);

    Q_INVOKABLE bool saveDB();
    bool loadBlogsFromFile();
    QStandardItemModel *model();

    static QDate nextDate(QDate lastDate, int rating);
    static QString ratingColor(int rating);

    Q_INVOKABLE int numTotalBlogs();

signals:
    void updateNumRows();

public slots:

private slots:
    void rowsChanged();

protected:
    bool backupLastDBFile();

private:
    BlogModel *m_model;
    QDir tempDir;
};

#endif // BLOGGERLOADER_H
