#include <QtCore>
#include <QtQml>
#include <QtQuick>
#include <QQuickStyle>
#include "myclass.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    qmlRegisterType<MyClass>("MyApp.MyModule",1,0,"MyClass");

    QQuickStyle::setStyle("material");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
