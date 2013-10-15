import QtQuick 2.0

Rectangle {
    id: root

    Text{
        id: title
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 20
        anchors.leftMargin: 60
        text: qsTr("Adicionar novo blog:")
        font.bold: true
        font.pixelSize: 15
        color: "white"
    }

    Row {
        layoutDirection: Qt.Horizontal
        id: rowName
        spacing: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: title.bottom
        anchors.topMargin: 40

        Text {
            width: 100
            height: 40
            text: qsTr("Nome: ")
            color: "white"
        }

        Rectangle{
            color: "white"
            width: 200
            height: 40
            TextInput {
                id: nameInpute
                anchors.fill: parent
            }
        }

    }

    Image
    {
        id: closeButton
        width: 50
        height: 50
        source: "qrc:/assets/close.png"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20

        MouseArea {
            anchors.fill: parent
            onClicked: root.state = ""
        }

    }

}
