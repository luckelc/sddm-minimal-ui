import QtGraphicalEffects 1.12
import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: usernameField

    height: inputHeight
    width: parent.width
    padding: 0
    selectByMouse: true

    font {
        family: config.fontFamily
        pointSize: 12
        bold: true
    }

    text: userModel.lastUser
    placeholderText: "username"
    placeholderTextColor: "#ccc"
    horizontalAlignment: Text.AlignHCenter

    color: "white"
    selectionColor: "white"
    renderType: Text.NativeRendering
 
    states: [
        State {
            name: "focused"
            when: usernameField.activeFocus

            PropertyChanges {
                target: userFieldBackground
                color: Qt.darker("#282828", 1.2)
                border.width: 2
            }
        },
        State {
            name: "hovered"
            when: usernameField.hovered

            PropertyChanges {
                target: userFieldBackground
                color: Qt.darker("#282828", 1.2)
            }
        }
    ]

    background: Rectangle {
        id: userFieldBackground

        color: "#444"
        border.color: "white"
        border.width: 0
        radius: 5
    }

    transitions: Transition {
        PropertyAnimation {
            properties: "color, border.width"
            duration: 150
        }
    }
}
