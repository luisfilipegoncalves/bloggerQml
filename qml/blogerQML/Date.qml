import QtQuick 2.0

Row {
    id: row
    property string labelStr
    property string dateStr
    property bool editingEnabled: true

    Text {
        id: dateLabel
        text: labelStr
        font.pixelSize: 14
        font.bold: true
        color: "black"
    }

    TextInputBlogDelegate  {
        enabled: editingEnabled
        id: date
        text: dateStr
        onTextChanged: dateStr = text;
        width: 100
    }

}
