import QtQuick 2.0

Rectangle {
    width: 40
    height: 40
    color: "transparent"

    Image {
        id: name
        anchors.fill: parent
        source: "qrc:/assets/star.png"
        fillMode: Image.Stretch
    }
}
