import QtQuick 2.15
import QtQuick.Controls 2.15

TextField {
    id: passwordField

    height: inputHeight
    width: parent.width
    focus: true
    padding: 0

    selectByMouse: true
    echoMode: TextInput.Password
    passwordCharacter: "•"
    
    font {
        family: config.fontFamily
        pointSize: 12
        bold: true
    }

    placeholderText: "password"
    placeholderTextColor: "#ccc"
    horizontalAlignment: TextInput.AlignHCenter

    color: "white"
    selectionColor: "white"
    renderType: Text.NativeRendering

    states: [
        State {
            name: "focused"
            when: passwordField.activeFocus

            PropertyChanges {
                target: passFieldBg
                color: Qt.darker("#282828", 1.2)
                border.width: 2
            }
        },
        State {
            name: "hovered"
            when: passwordField.hovered

            PropertyChanges {
                target: passFieldBg
                color: Qt.darker("#282828", 1.2)
            }
        }
    ]

    background: Rectangle {
        id: passFieldBg

        border {
            color: "white"
            width: 0
        }

        color: "#444"
        radius: 5
    }

    transitions: Transition {
        PropertyAnimation {
            properties: "color, border.width"
            duration: 150
        }
    }
}
