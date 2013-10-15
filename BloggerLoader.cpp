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
        //qDebug() << blogMap.value("name");
        m_model->addBlog(blogMap.value("name").toString(),
                         blogMap.value("url").toString(),
                         blogMap.value("rating").toInt(),
                         blogMap.value("lastDate").toString(),
                         blogMap.value("nextDate").toString(),
                         blogMap.value("comments").toString()
                         );
    }

    return true;

}

QStandardItemModel *  BloggerLoader::model()
{
    return m_model;
}
