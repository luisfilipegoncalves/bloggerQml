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

    TextInputBlogDelegate {
        id: note
        text: noteStr
        font.pixelSize: 12
        font.bold: false
        width: 200
        onTextChanged: noteStr = text;
    }

}
