#include "BloggerLoader.h"
#include "BlogModel.h"

#include <QDir>
#include <QCoreApplication>
#include <QApplication>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDateTime>

BloggerLoader::BloggerLoader(QObject *parent) :
    QObject(parent),
    m_model(new BlogModel(this))
{
    connect(m_model, SIGNAL(rowsInserted(QModelIndex,int,int)), this, SLOT(rowsChanged()));
    connect(m_model, SIGNAL(rowsRemoved(QModelIndex,int,int)), this, SLOT(rowsChanged()));

    tempDir.mkdir("Temp");
    tempDir.cd("Temp");
}

int BloggerLoader::numTotalBlogs()
{
    return m_model->rowCount();
}

void BloggerLoader::rowsChanged()
{
    emit updateNumRows();
}

bool BloggerLoader::backupLastDBFile()
{
    qDebug() << "backup lastDBFile";
    QDir appDir = QDir::currentPath();
    QFile blogsFile(appDir.absoluteFilePath("blogs.json"));
    QString tempFileName("blogs%1.json");
    if(blogsFile.exists())
    {
        QString str(tempDir.absoluteFilePath(tempFileName.arg(QDateTime::currentDateTime().toString("yyyyMMdd_hh-mm-ss-zzz"))));
        blogsFile.copy(str);
        blogsFile.remove();
    }
}

bool BloggerLoader::saveDB()
{
    qDebug() << "Save db";
    backupLastDBFile();

    int rowCount = m_model->rowCount();
    if(rowCount==0)
        return false;

    QVariantMap docMap;
    for(int i=0; i<rowCount; ++i)
    {
        QVariantMap currentBlogMap;
        QModelIndex index = m_model->index(i, 0);
        QString name = index.data().toString();
        QString url = index.data(Qt::UserRole +1).toString();
        int rating = index.data(Qt::UserRole +2).toInt();
        QString lastDate = index.data(Qt::UserRole +3).toString();
        QString note = index.data(Qt::UserRole +5).toString();
        QString blogId = index.data(Qt::UserRole +7).toString();

        currentBlogMap.insert("name", name);
        currentBlogMap.insert("url", url);
        currentBlogMap.insert("rating", rating);
        currentBlogMap.insert("lastDate", lastDate);
        currentBlogMap.insert("comments", note);
        currentBlogMap.insert("id", blogId);

        docMap.insert(blogId, currentBlogMap);
    }



    QJsonObject jsonObj = QJsonObject::fromVariantMap(docMap);
    QJsonDocument jsonDoc(jsonObj);

    QDir appDir = QDir::currentPath();
    QFile saveDocFile(appDir.absoluteFilePath("blogs.json"));
    if(!saveDocFile.open(QIODevice::WriteOnly))
    {
        qDebug() << "Error opening file. Error: "<< saveDocFile.errorString();
        return false;
    }

    QTextStream textStream(&saveDocFile);
    textStream << jsonDoc.toJson(QJsonDocument::Indented);
    return true;
}

bool BloggerLoader::loadBlogsFromFile()
{
    qDebug() << "current path: " << QDir::currentPath();
    QDir appDir = QDir::currentPath();
    QFile blogsFile(appDir.absoluteFilePath("blogs.json"));

    if(!blogsFile.exists())
        return false;

    if(!blogsFile.open(QIODevice::ReadOnly))
        return false;

    QByteArray data = blogsFile.readAll();
    blogsFile.close();

    QJsonParseError parserError;
    QJsonDocument doc = QJsonDocument::fromJson(data, &parserError);
    if(parserError.error != QJsonParseError::NoError)
    {
        qDebug() << "Error parsing json doc: " << parserError.errorString();
        return false;
    }
    //qDebug() << "doc: " << doc << doc.isArray() << doc.isObject();

    QJsonObject obj = doc.object();
    foreach(const QString &key, obj.keys())
    {
        QVariantMap blogMap = obj.value(key).toObject().toVariantMap();
        int rating = blogMap.value("rating").toInt();
        QString lastDateStr = blogMap.value("lastDate").toString();

        // maintain compatibility with former settings
        QDate lastDate = QDate::fromString(lastDateStr, "yyyy-MM-dd"); // 1st version of dates
        if(lastDate.isNull())
            lastDate = QDate::fromString(lastDateStr, "dd-MM-yyyy"); // 2nd version of dates

        QDate nextDate = BloggerLoader::nextDate(lastDate, rating);
        m_model->addBlog(blogMap.value("name").toString(),
                         blogMap.value("url").toString(),
                         rating,
                         lastDate.toString("dd-MM-yyyy"),
                         nextDate.toString("dd-MM-yyyy"),
                         blogMap.value("comments").toString(),
                         blogMap.value("id").toString()
                         );
    }
    return true;
}

QStandardItemModel * BloggerLoader::model()
{
    return m_model;
}

QDate BloggerLoader::nextDate(QDate lastDate, int rating)
{
    QDate nextDate;
    switch(rating)
    {
    case 1: // annual
        nextDate = lastDate.addYears(1);
        break;
    case 2: // biannual
        nextDate = lastDate.addMonths(6);
        break;
    case 3: // monthly
        nextDate = lastDate.addMonths(1);
        break;
    case 4: // bimonthly
        nextDate = lastDate.addDays(15);
        break;
    case 5: // weekly
        nextDate = lastDate.addDays(7);
        break;
    default:
        return nextDate;
        break;
    }

    return nextDate;
}

QString BloggerLoader::ratingColor(int rating)
{
    switch(rating)
    {
    case 1: // annual
        return "red";
    case 2: // biannual
        return "yellow";
    case 3: // monthly
        return "green";
    case 4: // bimonthly
        return "cyan";
    case 5: // weekly
        return "blue";
    default:
        return "red";
    }
}
