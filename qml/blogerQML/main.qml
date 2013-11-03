import QtQuick 2.0
import QtWebKit 3.0

Rectangle {
    id: root
    width: 1440
    height: 900
    color: "white"

    property int blogsSize: 0




    ListView {
        id: listV
        opacity: 0.6
        width: root.width
        spacing: 10
        model: blogsModel
        anchors.top: menuRect.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom
        clip: true
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 100

        highlight: Rectangle {
            width: listV.width
            height: 100
            color: "lightgray"
        }


        delegate: Rectangle {
            id: del
            smooth: true
            color:  "white"

            width: listV.width
            height: 100
            anchors.horizontalCenter: parent.horizontalCenter

            function selectThis()
            {
                listV.currentIndex = index
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    del.selectThis()
                }
            }

            Rectangle {
                rotation: 90
                transformOrigin: Item.TopLeft
                x: 20
                height: 20
                width: parent.height
                opacity: 0.7
                gradient: Gradient {
                    GradientStop { position: 1.0; color: ratingColor }
                    GradientStop { position: 0.0; color: "white" }
                }
            }


            TextInputBlogDelegate {
                id: blogNameText
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: -20
                text: name
                width: 150
                maximumLength: 80
                onTextChanged: {
                    name = text // change the model data
                }
            }


            Stars {
                id: starRow
                ratingValue: rating
                anchors.left: blogNameText.right
                anchors.leftMargin: 30
                anchors.verticalCenter: blogNameText.verticalCenter
                onRatingChanged: {
                    rating = ratingValue // change the model data
                    del.selectThis()

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
                    lastdate = dateStr // change the model data
                }
            }

            Row {
                id: nextDateItem
                anchors.left: lastDateItem.right
                anchors.leftMargin: 30
                anchors.verticalCenter: lastDateItem.verticalCenter

                Text {
                    id: dateLabel
                    text: qsTr("Próxima: ")
                    font.pixelSize: 14
                    font.bold: true
                    color: "black"
                }

                Text {
                    enabled: false
                    text: nextdate
                    width: 100
                    font.pixelSize: 14
                    font.bold: true
                    color: "black"
                }
            }

            Image {
                id: noteImg
                source: "qrc:/assets/comment_128.png"
                width: 15
                height: 15
                anchors.left: lastDateItem.left
                anchors.top: lastDateItem.bottom
                anchors.verticalCenter: txtNote.verticalCenter

                fillMode: Image.PreserveAspectFit
            }

            Note {
                id: txtNote
                anchors.left: noteImg.left
                anchors.leftMargin: 20
                anchors.top: lastDateItem.bottom
                anchors.topMargin: 10
                noteStr: note
                onNoteStrChanged: note = noteStr
            }

            Image {
                id: urlImg
                source: "qrc:/assets/globe_128.png"
                height: 15
                width: 15
                fillMode: Image.PreserveAspectFit
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: txtUrl.verticalCenter
            }

            TextInputBlogDelegate {
                id: txtUrl
                anchors.left: urlImg.left
                anchors.leftMargin: 20
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                text: url
                color: "black"
                font.pixelSize: 12
                width: 300
                clip: true
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
        color: "lightgray"
        anchors.top: parent.top
        opacity: 0.6

        Row {
            spacing: 40
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 20

            Rectangle
            {
                id: searchRect
                width: 240
                height: 40
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
                source: "qrc:/assets/badge_plus_512.png"
                width: 30
                height: 30
                fillMode: Image.PreserveAspectFit
                opacity: mouseAddNewBlog.pressed ? 0.1 : 1

                MouseArea {
                    id: mouseAddNewBlog
                    anchors.fill: parent
                    onClicked: {
                        newBlogItem.state = "shown"
                    }
                }
            }

            Image {
                id: deleteBlogButton
                source: "qrc:/assets/badge_cancel_512.png"
                fillMode: Image.PreserveAspectFit
                width: 30
                height: 30
                opacity: mouseDeleteBlog.pressed ? 0.1 : 1

                MouseArea {
                    id: mouseDeleteBlog
                    anchors.fill: parent
                    onClicked: {
                        console.log("delete blog button clicked...")
                        console.log("listV.currentIndex: " + listV.currentIndex)
                        blogsModel.deleteBlog(listV.currentIndex)
                    }
                }
            }

            Image {
                id: saveButtonImage
                width: 30
                height: 30
                fillMode: Image.PreserveAspectFit
                source: "qrc:/assets/floppy_disk_128.png"
                opacity: saveButtonMouse.pressed ? 0.1 : 1

                MouseArea {
                    id: saveButtonMouse
                    anchors.fill: parent
                    onClicked: {
                        console.log("Save database...")
                        if(bloggerloader.saveDB())
                            mainStatusBar.showMessage("Base de dados guardada com succeso.", "white")
                        else
                            mainStatusBar.showMessage("Erro a guardar base de dados.", "red")
                    }
                }
            }
        }

        Text {
            id: numBlogsLabel
            text: qsTr("Número de blogs: ") + bloggerloader.numTotalBlogs()
            font.bold: true
            font.pixelSize: 15
            color: "black"
            anchors.right: parent.right
            anchors.rightMargin: 30
            anchors.verticalCenter: parent.verticalCenter

            Connections {
                  target: bloggerloader
                  onUpdateNumRows: {
                     numBlogsLabel.text = qsTr("Número de blogs: ") + bloggerloader.numTotalBlogs()
                  }
              }
        }

    }


    NewBlogItem {
        id: newBlogItem
        width: parent.width
        height: 300
        color: "black"
        opacity: 0.9
        anchors.bottom: parent.top


        states: State {
            name: "shown"
            PropertyChanges {
                target: newBlogItem
                anchors.bottomMargin: -newBlogItem.height
            }
        }

        transitions: [
            Transition {
                NumberAnimation { target: newBlogItem; property: "anchors.bottomMargin"; duration: 500; easing.type: Easing.InCubic }

            }
        ]
    }


    MainStatusBar {
        id: mainStatusBar
        anchors.bottom: parent.bottom
        anchors.bottomMargin: -height
        width: parent.width
        height: 40
    }
}
