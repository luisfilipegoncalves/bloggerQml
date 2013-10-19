import QtQuick 2.0

Row {
    id: rowName
    spacing: 20
    property string labelName
    property string textValue
    property int labelWidth: 50
    property int inputWidth: 200
    function clear()
    {
        nameInpute.remove(0, nameInpute.length)
    }

    Text {
        width: labelWidth
        height: 30
        text: labelName
        color: "white"
        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 14
        font.bold: true

    }


    Rectangle {
        color: "white"
        width: inputWidth
        height: 30
        anchors.verticalCenter: parent.verticalCenter
        TextInput {
            id: nameInpute
            anchors.fill: parent
            anchors.leftMargin: 5
            verticalAlignment: Text.AlignVCenter
            text: textValue
            onTextChanged: textValue = text
        }
        clip: true
    }
}
