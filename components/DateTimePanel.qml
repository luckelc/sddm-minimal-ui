import QtQuick 2.15
import QtQuick.Controls 2.15

Column {
    spacing: 2

    Component.onCompleted: {
        timeLabel.updateTime();
        dateLabel.updateDate();
    }

    Text {
        id: dateLabel

        function updateDate() {
            text = new Date().toLocaleDateString(Qt.locale(), "dddd, MMMM d");
        }

        font {
            family: config.fontFamily
            pointSize: 36
            bold: false
        }

        anchors { right: parent.right }

        opacity: 1
        renderType: Text.NativeRendering
        color: "#cdd6f4"
    }

    Text {
        id: timeLabel

        function updateTime() {
            text = new Date().toLocaleTimeString(Qt.locale(), "hh:mm AP");
        }

        font {
            family: config.fontFamily
            pointSize: 48
            bold: true
        }

        anchors { right: parent.right }

        opacity: 1
        renderType: Text.NativeRendering
        color: "#cdd6f4"
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        
        onTriggered: {
            timeLabel.updateTime();
            dateLabel.updateDate();
        }
    }
}
