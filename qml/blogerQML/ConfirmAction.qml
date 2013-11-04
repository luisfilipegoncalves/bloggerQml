import QtQuick 2.0

Rectangle {
    id: rootConfirmAction
    color: "black"
    opacity: 0.8
    property string removedName

    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("hide dialog")
            rootConfirmAction.visible = false
        }
    }

    Rectangle {
        id: messageRect
        width: rowButtons.width
        height: 30
        anchors.bottom: rowButtons.top
        anchors.left: rowButtons.left


        Text {
            text: qsTr("Tem a certeza que quer apagar o blog ?")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
        }

        Rectangle {
            height: 1
            width: parent.width
            color: "gray"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
        }
    }

    Row {
        id: rowButtons
        anchors.centerIn: parent

        Rectangle {
            id: yesButton
            width: 150
            height: 30
            Text {
                text: qsTr("Sim")
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked: Yes")
                    removedName = blogsModel.deleteBlog(listV.currentIndex)
                    if(removedName.length>0)
                        mainStatusBar.showMessage("Blogue " + removedName + " apagado!" , "white")
                    else
                        mainStatusBar.showMessage("Erro ao apagar blogue: " + removedName, "red")

                    rootConfirmAction.visible = false
                }
            }
        }

        Rectangle {
            height: 30
            width: 1
            color: "gray"
        }

        Rectangle {
            id: noButton
            width: 150
            height: 30
            Text {
                anchors.fill: parent
                text: qsTr("Não")
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    console.log("clicked: No")
                    rootConfirmAction.visible = false
                }
            }
        }
    }
}
