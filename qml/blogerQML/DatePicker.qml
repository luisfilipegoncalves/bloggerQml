import QtQuick 2.0

Rectangle {
    width: 120
    height: 30
    color: "white"
    property bool validDate: false
    property string textValue

    function clear()
    {
        dateTextInput.remove(0, dateTextInput.length)
    }

    TextInput {
        id: dateTextInput
        inputMethodHints: Qt.ImhDigitsOnly
        anchors.fill: parent
        inputMask: "00-00-0000"
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
}
