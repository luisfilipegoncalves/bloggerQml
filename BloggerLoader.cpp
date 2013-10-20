#include "BloggerLoader.h"
#include "BlogModel.h"

#include <QDir>
#include <QCoreApplication>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

BloggerLoader::BloggerLoader(QObject *parent) :
    QObject(parent)
{
    m_model = new BlogModel(this);

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
        QDate lastDate = QDate::fromString(lastDateStr, "yyyy-MM-dd");
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

QStandardItemModel *  BloggerLoader::model()
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
        return "orange";
    case 5: // weekly
        return "blue";
    default:
        return "red";
    }
}
