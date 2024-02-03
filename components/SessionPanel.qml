import QtQml.Models 2.15
import QtQuick 2.15
import QtQuick.Controls 2.15

Item{
    property int session: sessionList.currentIndex
    implicitHeight: sessionButton.height
    implicitWidth: sessionButton.width

    Button {
        id: sessionButton 
        height: inputWidth * 0.15
        width: inputWidth * 0.15

        hoverEnabled: true

        background: Rectangle {
            id: sessionButtonBg
            color: "#282828"
            radius: 5
        }

        icon {
            source: Qt.resolvedUrl("../icons/settings.svg")
            height: height * 0.6
            width: width * 0.6
            color: "white"
        }

        onClicked: {
            sessionPopup.visible ? sessionPopup.close() : sessionPopup.open();
            sessionButton.state = "pressed";
        }

        states: [
            State {
                name: "pressed"
                when: sessionButton.down

                PropertyChanges {
                    target: sessionButtonBg
                    color: Qt.darker("#282828", 1.2)
                }
            },
            State {
                name: "hovered"
                when: sessionButton.hovered

                PropertyChanges {
                    target: sessionButtonBg
                    color: Qt.darker("#282828", 1.2)
                }
            },
            State {
                name: "selected"
                when: sessionPopup.visible

                PropertyChanges {
                    target: sessionButtonBg
                    color: Qt.darker("#282828", 1.2)
                }
            }
        ]

        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }
        }
    }
    
    Popup {
        id: sessionPopup

        width: 150 + padding * 2
        x: -width + sessionButton.width 
        y: -height - 5
        padding: 10

        background: Rectangle {
            radius: 5
            color: "#282828"
        }

        contentItem: ListView {
            id: sessionList
            implicitHeight: contentHeight
            spacing: 8
            model: sessionWrapper
            currentIndex: sessionModel.lastIndex
            clip: true
        }
    }
    DelegateModel {
        id: sessionWrapper
        model: sessionModel

        delegate: ItemDelegate {

            id: sessionEntry
            height: 30
            width: parent.width
            highlighted: sessionList.currentIndex === index

            MouseArea {
                anchors { fill: parent }

                onClicked: {
                    sessionList.currentIndex = index;
                }
            }
            contentItem: Text {
                font {
                    family: config.fontFamily
                    pointSize: 10
                    bold: true
                }
                renderType: Text.NativeRendering
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: highlighted ? "#444" : "white"
                text: name
            }
            background: Rectangle {
                id: sessionEntryBg
                color: highlighted ? "white" : "#444"
                radius: 5
            }
        }
    }
}
