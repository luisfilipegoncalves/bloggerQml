import QtQuick 2.0

Row {
    id: row
    property string labelStr
    property string dateStr

    Text {
        id: dateLabel
        text: labelStr
        font.pixelSize: 14
        font.bold: true
        color: "white"
    }

    TextInput {
        id: date
        text: dateStr
        font.pixelSize: 14
        font.bold: true
        color: "white"
        onTextChanged: dateStr = text;
        //onActiveFocusChanged: console.log("focus: " + focus.toString())
    }

}
