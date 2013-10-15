import QtQuick 2.0
import QtWebKit 3.0

Rectangle {
    id: root
    width: 1440
    height: 900
    color: "#235E5A"


    ListView {
        id: listV
        opacity: 0.6
        width: root.width
        height: root.height - menuRect.height
        spacing: 10
        model: blogsModel
        anchors.top: menuRect.bottom
        anchors.topMargin: 10
        clip: true

        delegate: Rectangle {
            id: del
            smooth: true
            color: "#0B8A81"

            width: listV.width
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter

            TextInput {
                id: blogNameText
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: name
                color: "white"
                font.pixelSize: 20
                font.bold: true
                maximumLength: 60
                onTextChanged: {
                    name = text
                }
            }

            Row {
                anchors.left: blogNameText.right
                anchors.leftMargin: 30
                anchors.verticalCenter: blogNameText.verticalCenter
                Repeater {
                    model: rating
                    StarRating {}
                }
            }

            Row {
                id: starRow
                anchors.left: blogNameText.right
                anchors.leftMargin: 30
                anchors.verticalCenter: blogNameText.verticalCenter

                StarButton {
                    starIndex: 1
                }
                StarButton {
                    starIndex: 2
                }
                StarButton {
                    starIndex: 3
                }
                StarButton {
                    starIndex: 4
                }
                StarButton {
                    starIndex: 5
                }

            }

            Date {
                id: lastDateItem
                labelStr: "Última: "
                dateStr: lastdate

                anchors.left: starRow.right
                anchors.leftMargin:  30
                anchors.verticalCenter: blogNameText.verticalCenter

                onDateStrChanged: {
                    //console.log("dateStr: " + dateStr)
                    lastdate = dateStr
                }
            }

            Date {
                id: nextDateItem
                labelStr: "Próxima: "
                dateStr: nextdate

                anchors.left: lastDateItem.right
                anchors.leftMargin: 30
                anchors.verticalCenter: lastDateItem.verticalCenter

                onDateStrChanged: {
                    //console.log("dateStr: " + dateStr)
                    nextdate = dateStr
                }
            }

            Note {
                id: txtNote
                anchors.left: lastDateItem.left
                anchors.top: lastDateItem.bottom
                anchors.topMargin: 10
                noteStr: note

                onNoteStrChanged: note = noteStr
            }

            TextInput {
                id: txtUrl
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                text: url
                color: "black"
                font.pixelSize: 12
                font.bold: false
                onTextChanged: {
                    url = text
                }
            }


        }
    }

    Rectangle {
        id: menuRect
        height: 80
        width: parent.width
        color: "#024D47"
        anchors.top: parent.top
        opacity: 0.6

        Rectangle
        {
            id: searchRect
            width: 240
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20
            color: "black"

            TextInput
            {
                width: parent.width - 40
                height: parent.height
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: 7
                color: "white"
                font.bold: true
                font.pixelSize: 20
                clip: true
                onTextChanged:
                {
                    console.log(text)
                    blogsModel.search(text)
                }
            }

            Image {
                width: 20
                height: 20
                id: magnifierImg
                source: "qrc:/assets/lupa.png"
                fillMode: Image.Stretch
                anchors.right: searchRect.right
                anchors.rightMargin: 10
                anchors.verticalCenter: searchRect.verticalCenter
            }

        }


        Image {
            id: rectAddNewBlog
            source: "qrc:/assets/addNew.png"
            width: 50
            height: 50
            fillMode: Image.PreserveAspectFit
            anchors.left: searchRect.right
            anchors.leftMargin: 40
            anchors.verticalCenter: searchRect.verticalCenter

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    newBlogItem.state = "shown"
                }
            }
        }

    }


    NewBlogItem {
        id: newBlogItem
        width: parent.width
        height: 200
        color: "black"
        opacity: 0.9
        anchors.bottom: parent.top

        states: State {
            name: "shown"
            PropertyChanges {
                target: newBlogItem
                anchors.bottomMargin: -200
            }
        }

        transitions: [
            Transition {
                NumberAnimation { target: newBlogItem; property: "anchors.bottomMargin"; duration: 500; easing.type: Easing.InCubic }

            }
        ]
    }
}
