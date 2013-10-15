#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

#include "BloggerProxyModel.h"
#include "BloggerLoader.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BloggerLoader loader;
    loader.loadBlogsFromFile();

    BloggerProxyModel model;
    model.setSourceModel(loader.model());

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("blogsModel", &model);

    viewer.setMainQmlFile(QStringLiteral("qml/blogerQML/main.qml"));
    viewer.showExpanded();


    return app.exec();
}
