import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.12

import "./components"

Rectangle{
  property string user: userPanel.text
  property string password: passwordField.text
  property int session: sessionPanel.session
  property double inputHeight: Screen.height * 0.175 * 0.25
  property double inputWidth: Screen.width * 0.175
  
  id: root
  height: Screen.height
  width: Screen.width


  Image {
    anchors { fill: parent }
    source: config.bgSrc
    fillMode: Image.PreserveAspectCrop
    clip: true
  }
  
  Rectangle{
    width: parent.width - 20
    height: parent.height - 20
    anchors.centerIn: parent
    color: "transparent"

    DateTimePanel {
      anchors {
          top: parent.top
          right: parent.right
      }
    }
    
    Row{
        spacing: 10
        anchors{
              bottom: parent.bottom
              right: parent.right
        }

        SessionPanel{
          id: sessionPanel
          anchors.bottom: parent.bottom
        }

        PowerPanel{
          anchors.bottom: parent.bottom
        }
    }

  }

  Item{
    anchors{
      verticalCenter: parent.verticalCenter
      horizontalCenter: parent.horizontalCenter
    }

    width: inputWidth
    height: inputHeight * 3 + fields.padding * 2 + fields.spacing * 2

    Rectangle{
      color: "#282828"
      width: parent.width
      height: parent.height
      radius: 5
      z: -1
    }

    Column{
      id: fields
      padding: 20
      width: parent.width - padding * 2
      height: (parent.height - padding * 2)

      spacing: 10;

      UserFieldPanel{ id: userPanel}
      PasswordFieldPanel{

        id: passwordField
        onAccepted: loginButton.clicked();
      }
      Button {
        id: loginButton

        height: 40
        width: parent.width
        enabled: user !== "" && password !== ""
        hoverEnabled: true

        onClicked: {
            sddm.login(user, password, session);
        }
        states: [
            State {
                name: "pressed"
                when: loginButton.down

                PropertyChanges {
                    target: buttonBackground
                    color: Qt.darker("#444", 1.4)
                    opacity: 1
                }

                PropertyChanges {
                    target: buttonText
                    opacity: 1
                }
            },
            State {
                name: "hovered"
                when: loginButton.hovered

                PropertyChanges {
                    target: buttonBackground
                    color: Qt.darker("#444", 1.2)
                    opacity: 1
                }

                PropertyChanges {
                    target: buttonText
                    opacity: 1
            }
            },
            State {
                name: "enabled"
                when: loginButton.enabled

                PropertyChanges {
                    target: buttonBackground
                    opacity: 1
                }

                PropertyChanges {
                    target: buttonText
                    opacity: 1
                }
            }
        ]
        Rectangle {
            id: loginAnim

            radius: parent.width / 2
            anchors {centerIn: loginButton }
            color: "black"
            opacity: 1

            NumberAnimation {
                id: coverScreen

                target: loginAnim
                properties: "height, width"
                from: 0
                to: root.width * 2
                duration: 1000
                easing.type: Easing.InExpo
            }
        }
        contentItem: Text {
            id: buttonText

            font {
                family: config.fontFamily
                pointSize: 12
                bold: true
            }

            text: "Login"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            opacity: 0.5
            renderType: Text.NativeRendering
            color: "white"
        }

        background: Rectangle {
            id: buttonBackground

            color: "#777"
            opacity: 0.5
            radius: 5
        }

        transitions: Transition {
            PropertyAnimation {
                properties: "color, opacity"
                duration: 150
            }
        }
      }
    }
  }

}
