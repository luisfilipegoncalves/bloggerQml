import QtQuick 2.0

TextInput {
    id: rootTextInput
    font.pixelSize: 14
    font.bold: true
    color: "black"
    width: 100
    selectByMouse: true
    onActiveFocusChanged: {
        if(focus)
            del.selectThis()
    }
}
