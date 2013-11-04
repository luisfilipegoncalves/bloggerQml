import QtQuick 2.0

Rectangle {
    width: rowButton.width
    height: rowButton.height
    property int ratingValue: 0
    signal ratingChanged

    Row {
        Repeater {
            model: ratingValue
            StarRating {}
        }
    }

    Row {
        id: rowButton
        StarButton {
            starIndex: 1
            onSelected: {
                ratingValue = starIndex
                ratingChanged(ratingValue)
            }
        }
        StarButton {
            starIndex: 2
            onSelected: {
                ratingValue = starIndex
                ratingChanged(ratingValue)
            }
        }
        StarButton {
            starIndex: 3
            onSelected: {
                ratingValue = starIndex
                ratingChanged(ratingValue)
            }
        }
        StarButton {
            starIndex: 4
            onSelected: {
                ratingValue = starIndex
                ratingChanged(ratingValue)
            }
        }
        StarButton {
            starIndex: 5
            onSelected: {
                ratingValue = starIndex
                ratingChanged(ratingValue)
            }
        }

    }
}
