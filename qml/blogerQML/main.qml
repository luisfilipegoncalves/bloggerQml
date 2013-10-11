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
                id: txed
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
                anchors.left: txed.right
                anchors.leftMargin: 30
                anchors.verticalCenter: txed.verticalCenter
                Repeater {
                    model: rating
                    StarRating {}
                }
            }

            Row {
                id: starRow
                anchors.left: txed.right
                anchors.leftMargin: 30
                anchors.verticalCenter: txed.verticalCenter

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

            Text {
                id: date
                anchors.left: starRow.right
                anchors.leftMargin:  30
                anchors.verticalCenter: txed.verticalCenter

                text: "Última: " + lastdate
                font.pixelSize: 14
                font.bold: true
                color: "white"
            }

            Text {
                id: textNextDate
                anchors.left: date.right
                anchors.leftMargin: 30
                anchors.verticalCenter: txed.verticalCenter

                text: "Próxima: " + nextdate
                font.pixelSize: 14
                font.bold: true
                color: "white"
            }

            TextInput {
                id: txtNote
                anchors.left: date.left
                anchors.leftMargin: 20
                anchors.top: date.bottom
                anchors.topMargin: 20
                text: "Notas: Este blog é marado!"
                color: "black"
                font.pixelSize: 12
                font.bold: false
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

    }
}
