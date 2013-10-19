#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

#include "BloggerProxyModel.h"
#include "BloggerLoader.h"
#include "Helper.h"

#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BloggerLoader loader;
    loader.loadBlogsFromFile();

    BloggerProxyModel model;
    model.setSourceModel(loader.model());

    Helper helper;
    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("blogsModel", &model);
    viewer.rootContext()->setContextProperty("helper", &helper);

    viewer.setMainQmlFile(QStringLiteral("qml/blogerQML/main.qml"));
    viewer.showExpanded();


    return app.exec();
}
