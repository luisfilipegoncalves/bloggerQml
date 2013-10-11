#include <QtGui/QGuiApplication>
#include "qtquick2applicationviewer.h"

#include "BloggerModel.h"
#include <QQmlContext>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    BloggerProxyModel model;

    QtQuick2ApplicationViewer viewer;
    viewer.rootContext()->setContextProperty("blogsModel", &model);

    viewer.setMainQmlFile(QStringLiteral("qml/blogerQML/main.qml"));
    viewer.showExpanded();


    return app.exec();
}
