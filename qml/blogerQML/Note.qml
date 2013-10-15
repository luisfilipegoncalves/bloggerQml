import QtQuick 2.0

Row {
    id: row
    property string noteStr

    Text {
        id: noteLabel
        text: "Notas: "
        color: "black"
        font.pixelSize: 12
        font.bold: false
    }

    TextInput {
        id: note
        text: noteStr

        color: "black"
        font.pixelSize: 12
        font.bold: false

        onTextChanged: noteStr = text;
    }

}
