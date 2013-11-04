#include <QApplication>
#include "qtquick2applicationviewer.h"

#include "BloggerProxyModel.h"
#include "BloggerLoader.h"
#include "Helper.h"

#include <QQmlContext>
#include <QQuickItem>
#include <QQmlEngine>
#include <QLocalSocket>
#include <QLocalServer>
#include <QMessageBox>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QLocalSocket localSocket;
    localSocket.connectToServer("bloggerQml", QIODevice::ReadOnly);
    if(localSocket.waitForConnected(5000))
    {
        // there is already an application running
        qDebug() << "Application is already running.";
        QMessageBox::information(0, QObject::tr("Erro"), QObject::tr("A aplicação já está a ser executada."), QMessageBox::Ok);
        return 0;
    }
    QLocalServer localServer;
    localServer.listen("bloggerQml");

    BloggerLoader bloggerloader;
    bloggerloader.loadBlogsFromFile();

    BloggerProxyModel model;
    model.setSourceModel(bloggerloader.model());

    Helper helper;
    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("blogsModel", &model);
    viewer.rootContext()->setContextProperty("helper", &helper);
    viewer.rootContext()->setContextProperty("bloggerloader", &bloggerloader);

    viewer.setMainQmlFile(QStringLiteral("qml/blogerQML/main.qml"));
    viewer.showExpanded();

    int res = app.exec();
    bloggerloader.saveDB();
    return res;
}
