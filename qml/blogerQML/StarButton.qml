import QtQuick 2.0

Rectangle {
    width: 40
    height: 40
    color: "transparent"
    opacity: 0.1
    property int starIndex: 0


    Image {
        id: name
        anchors.fill: parent
        source: "qrc:/assets/star.png"
        fillMode: Image.Stretch
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            rating = starIndex
        }
    }

}
