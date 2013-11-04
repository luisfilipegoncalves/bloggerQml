import QtQuick 2.0

Rectangle {
    id: root

    property int labelsWidth: 90

    function clear()
    {
        nameInputRow.clear()
        stars.ratingValue = 0
        urlInputRow.clear()
        noteInputRow.clear()
        lastDatePicker.clear()
    }

    MouseArea {
        anchors.fill: parent
        preventStealing: true
    }

    Text {
        id: title
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 20
        anchors.leftMargin: 60
        text: qsTr("Adicionar novo blog:")
        font.bold: true
        font.pixelSize: 16
        color: "white"
    }

    Rectangle {
        width: parent.width
        height: 2
        color: "gray"
        anchors.top: title.bottom
        anchors.topMargin: 20
    }

    LabelTextInput
    {
        id: nameInputRow
        anchors.left: parent.left
        anchors.leftMargin: 120
        anchors.top: title.bottom
        anchors.topMargin: 40
        labelName: qsTr("Nome: ")
        inputWidth: 300
        labelWidth: labelsWidth
    }

    Row {
        id: ratingRow
        spacing: 20
        anchors.left: nameInputRow.right
        anchors.leftMargin: 40
        anchors.verticalCenter: nameInputRow.verticalCenter
        Text {
            id: labelRating
            text: qsTr("Classificação: ")
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            font.bold: true
        }
        Stars {
            id: stars
            ratingValue: 0

        }
    }

    LabelTextInput
    {
        id: urlInputRow
        anchors.left: nameInputRow.left
        anchors.top: nameInputRow.bottom
        anchors.topMargin: 20
        labelName: qsTr("Url: ")
        inputWidth: 600
        labelWidth: labelsWidth
    }

    LabelTextInput
    {
        id: noteInputRow
        anchors.left: urlInputRow.left
        anchors.top: urlInputRow.bottom
        anchors.topMargin: 20
        labelName: qsTr("Notas: ")
        inputWidth: 600
        labelWidth: labelsWidth
    }


    Row {
        id: lastDateRow
        spacing: 20
        anchors.left: noteInputRow.left
        anchors.top: noteInputRow.bottom
        anchors.topMargin: 20

        Text {
            text: qsTr("Última data: ")
            color: "white"
            anchors.verticalCenter: parent.verticalCenter
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: 14
            font.bold: true
            width: labelsWidth
        }
        DatePicker {
            id: lastDatePicker
        }
    }

    Image
    {
        id: closeButton
        width: 30
        height: 30
        source: "qrc:/assets/badge_close_64.png"
        fillMode: Image.PreserveAspectFit
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.verticalCenter: title.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.state = ""
                clear()
            }
        }

    }

    Rectangle {
        id: addBlogButton
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        width: 100
        height: 30
        color: "transparent"
        border.width: 1
        border.color: "white"

        Text {
            id: name
            text: qsTr("Adicionar")
            color: "white"
            font.pixelSize: 15
            font.bold: true
            anchors.centerIn: parent
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                if(blogsModel.tryAddBlog(nameInputRow.textValue, urlInputRow.textValue, stars.ratingValue,
                                         lastDatePicker.textValue, noteInputRow.textValue))
                {
                    console.log("add blog!")
                    root.state = ""
                    clear()
                }
            }
        }
    }
}
