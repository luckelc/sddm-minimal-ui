import QtGraphicalEffects 1.15
import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    implicitHeight: powerButton.height
    implicitWidth: powerButton.width

    Button {
        id: powerButton

        icon {
            source: Qt.resolvedUrl("../icons/power.svg")
            height: height
            width: width
            color: "white"
        }

        height: inputWidth * 0.15
        width: inputWidth * 0.15
        background: Rectangle {
            id: powerButtonBg
            color: "#282828"
            radius: 5
        }
        onClicked: {
            powerStatePopup.visible ? powerStatePopup.close() : powerStatePopup.open();
            powerButton.state = "pressed";
        }
        transitions: Transition {
            PropertyAnimation {
                properties: "color"
                duration: 150
            }
        }
        states: [
            State {
                name: "pressed"
                when: powerButton.down

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker("white", 1.2)
                }
            },
            State {
                name: "hovered"
                when: powerButton.hovered

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker("red", 1.2)
                }
            },
            State {
                name: "selected"
                when: powerStatePopup.visible

                PropertyChanges {
                    target: powerButtonBg
                    color: Qt.darker("red", 1.2)
                }
            }
        ]
    }

    ListModel {
        id: powerModel
        ListElement {
            name: "Sleep"
        }

        ListElement {
            name: "Restart"
        }

        ListElement {
            name: "Shut\nDown"
        }
    }
  
    Popup{
        id: powerStatePopup
        height: config.powerOptionsHeight
        width: config.powerOptionsWidth
        x: 0
        y: - height - 5
        padding: 2

        background: Rectangle {
            radius: 5
            color: "green"
            visible: true
        }

        ListView{
            id: powerList
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width
            height: 3 * (powerStatePopup.width - (powerStatePopup.padding * 2)) + (2 * spacing)
            spacing: 2
            orientation: Qt.Vertical
            clip: true
            model: powerModel

            delegate: ItemDelegate {
                id: powerEntry
                width: powerStatePopup.width - (powerStatePopup.padding * 2)
                height: powerStatePopup.width - (powerStatePopup.padding * 2)
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: powerEntryBg

                    radius: 5
                    anchors { fill: parent }
                    color: "black"
                    visible: true
                }
                Item{
                    anchors.centerIn: parent
                    Image {
                            id: powerIcon

                            anchors.centerIn: parent
                            source: index == 0 ? Qt.resolvedUrl("../icons/sleep.svg") : (index == 1 ? Qt.resolvedUrl("../icons/restart.svg") : Qt.resolvedUrl("../icons/power.svg"))
                            sourceSize: Qt.size(powerEntry.width - 10, powerEntry.width - 10)
                    }

                    ColorOverlay {
                            id: iconOverlay

                            anchors.fill: powerIcon
                            source: powerIcon
                            color: "white"
                    }
                }

                states: [
                    State {
                        name: "hovered"
                        when: powerEntry.hovered

                        PropertyChanges {
                            target: powerEntryBg
                            color: Qt.darker("red", 1.2)
                        }

                        PropertyChanges {
                            target: iconOverlay
                            color: Qt.darker("red", 1.2)
                        }
                    }
                ]

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        powerStatePopup.close();

                        if (index === 0) {
                            sddm.suspend();
                        } else if (index === 1) {
                            sddm.reboot();
                        } else if (index === 2) {
                            sddm.powerOff();
                        }
                    }
                }
            }
        }
    }
}
