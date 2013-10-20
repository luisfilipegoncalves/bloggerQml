import QtQuick 2.0

Rectangle {
    id: mainStatusBarRoot
    color: "black"
    opacity: 0.9

    function showMessage(str, color) {
        msgTextItem.color = color
        msgTextItem.text = Qt.formatTime(new Date(), "[hh:mm:ss] ") + str
        mainStatusBarRoot.state = "statusBarVisible"

    }

    Text {
        id: msgTextItem
        width: parent.width - 10
        height: parent.height
        color: "white"
        anchors.left: parent.left
        anchors.leftMargin: 40
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.pixelSize: 14
    }

    Image {
        width: 20
        height: 20
        id: name
        source: "qrc:/assets/badge_close_64.png"

        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        fillMode: Image.PreserveAspectFit

        MouseArea {
            anchors.fill: parent
            onClicked: {
                msgTextItem.text = " "
                mainStatusBarRoot.state = ""
            }
        }
    }

    states: State {
        name: "statusBarVisible"
        PropertyChanges {
            target: mainStatusBarRoot
            anchors.bottomMargin: 0
        }
    }

    transitions: [
        Transition {
            NumberAnimation { target: mainStatusBarRoot; property: "anchors.bottomMargin"; duration: 400; easing.type: Easing.InExpo}
        }
    ]

}
