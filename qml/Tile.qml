import QtQuick
import QtQuick.Effects

Rectangle {
    id: tileContainer
    width: 425/4
    height: 425/4
    radius: 10
    color: "white"
    layer.enabled: true
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: helper.themeMode === "dark" ? Qt.rgba(0, 0, 0, 0.45) : Qt.rgba(0, 0, 0, 0.18)
        shadowVerticalOffset: 2
        shadowBlur: 0.5
    }

    property string tileText: ""
    property int tileFontSize: 55
    property color tileColor: "black"
    property int moveAnimTime: 100
    property int newTileAnimTime: 200
    property bool runNewTileAnim: false
    property bool destroyFlag: false

    FontLoader { id: localFont; source: "qrc:///res/fonts/DroidSansFallback.ttf" }

    Text {
        id: tileLabel
        text: tileText
        color: tileColor
        font.family: helper.fontFamily
        font.pixelSize: tileFontSize
        font.bold: true
        anchors.centerIn: parent
        Behavior on text {
            PropertyAnimation { target: tileContainer
                property: "opacity"
                from: 0.5
                to: 1
                duration: moveAnimTime
            }
        }
    }

    ParallelAnimation {
        running: runNewTileAnim
        NumberAnimation {
            target: tileContainer
            property: "opacity"
            from: 0.0
            to: 1.0
            duration: newTileAnimTime
        }

        ScaleAnimator {
            target: tileContainer
            from: 0
            to: 1
            duration: newTileAnimTime
            easing.type: Easing.OutQuad
        }
    }

    Behavior on color {
        ColorAnimation {
            duration: moveAnimTime
        }
    }

    Behavior on y {
        NumberAnimation {
            duration: moveAnimTime
            onRunningChanged: {
                if ((!running) && destroyFlag) {
                    tileContainer.destroy();
                }
            }
        }
    }

    Behavior on x {
        NumberAnimation {
            duration: moveAnimTime
            onRunningChanged: {
                if ((!running) && destroyFlag) {
                    tileContainer.destroy();
                }
            }
        }
    }
}
