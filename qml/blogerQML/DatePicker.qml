import QtQuick 2.0

Rectangle {
    width: 120
    height: 30
    color: "white"
    property bool validDate: false
    property string textValue: Qt.formatDate(new Date(), "dd-MM-yyyy")

    function clear()
    {
        dateTextInput.remove(0, dateTextInput.length)
    }

    TextInput {
        id: dateTextInput
        inputMethodHints: Qt.ImhDigitsOnly
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        anchors.leftMargin: 10
        text: textValue
        onTextChanged: {
            validDate = helper.isDateValid(text)
            textValue = text
        }
    }

    Rectangle {
        id: validateCircle
        width: 12
        height: 12
        radius: 6
        color: validDate ? "transparent" : "red"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10
    }

    Text {
        id: helpLabel
        anchors.top: dateTextInput.bottom
        anchors.topMargin: 5
        anchors.left: dateTextInput.left
        text: "dd-mm-aaaa"
        color: "white"
        font.pixelSize: 10

    }
}
