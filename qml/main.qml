import QtQuick
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Effects
import QtQuick.Window
import "2048.js" as MyScript

ApplicationWindow {
    id: mainWindow
    visible: true
    width: 550
    height: 740
    title: qsTr("2048 Game");
//    flags: Qt.Window | Qt.WindowTitleHint  | Qt.WindowMinimizeButtonHint | Qt.WindowCloseButtonHint | Qt.CustomizeWindowHint

    x: (Screen.width - width) / 2
    y: (Screen.height - height) / 2

    ButtonGroup { id: labelSettingsGroup }
    ButtonGroup { id: languageSettingsGroup }
    ButtonGroup { id: themeSettingsGroup }
    ButtonGroup { id: fontSettingsGroup }

    Shortcut {
        sequence: "Ctrl+N"
        onActivated: MyScript.startupFunction()
    }
    Shortcut {
        sequence: "Ctrl+Q"
        onActivated: MyScript.cleanUpAndQuit()
    }

    menuBar: MenuBar {
        Menu {
            title: qsTr("File")
            MenuItem {
                text: qsTr("Restore Demo Mode")
                visible: demoMode
                onTriggered: MyScript.startupDemoFunction();
            }
            MenuItem {
                text: qsTr("New Game")
                onTriggered: MyScript.startupFunction();
            }
            MenuItem {
                text: qsTr("Exit")
                onTriggered: MyScript.cleanUpAndQuit();
            }
        }

        Menu {
            title: qsTr("Settings")
            Menu {
                title: qsTr("Labeling")
                MenuItem {
                    text: qsTr("2048")
                    checkable: true
                    ButtonGroup.group: labelSettingsGroup
                    checked: MyScript.label === MyScript.labelOptions[0] ? true : false
                    onTriggered: {
                        MyScript.label = MyScript.labelOptions[0];
                        MyScript.startupFunction();
                    }
                }
                MenuItem {
                    text: qsTr("Degree")
                    checkable: true
                    ButtonGroup.group: labelSettingsGroup
                    checked: MyScript.label === MyScript.labelOptions[1] ? true : false
                    onTriggered: {
                        MyScript.label = MyScript.labelOptions[1];
                        MyScript.startupFunction();
                    }
                }
                MenuItem {
                    text: qsTr("Military Rank")
                    checkable: true
                    ButtonGroup.group: labelSettingsGroup
                    checked: MyScript.label === MyScript.labelOptions[2] ? true : false
                    onTriggered: {
                        MyScript.label = MyScript.labelOptions[2];
                        MyScript.startupFunction();
                    }
                }
                MenuItem {
                    text: qsTr("PRC")
                    checkable: true
                    ButtonGroup.group: labelSettingsGroup
                    checked: MyScript.label === MyScript.labelOptions[3] ? true : false
                    onTriggered: {
                        MyScript.label = MyScript.labelOptions[3];
                        MyScript.startupFunction();
                    }
                }
            }
            Menu {
                title: qsTr("Language")
                MenuItem {
                    text: "English"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") === "en_US" ? true : false
                    onTriggered: {
                        settings.setValue("language", "en_US");
                        changeLanguageDialog.open();
                    }
                }
                MenuItem {
                    text: "Français"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") === "fr_FR" ? true : false
                    onTriggered: {
                        settings.setValue("language", "fr_FR");
                        changeLanguageDialog.open();
                    }
                }
                MenuItem {
                    text: "简体中文"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") === "zh_CN" ? true : false
                    onTriggered: {
                        settings.setValue("language", "zh_CN");
                        changeLanguageDialog.open();
                    }
                }
                MenuItem {
                    text: "Polski"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") === "pl_PL" ? true : false
                    onTriggered: {
                        settings.setValue("language", "pl_PL");
                        changeLanguageDialog.open();
                    }
                }

                MenuItem {
                    text: "Русский"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") === "ru_RU" ? true : false
                    onTriggered: {
                        settings.setValue("language", "ru_RU");
                        changeLanguageDialog.open();
                    }
                }
                MenuItem {
                    text: "German"
                    checkable: true
                    ButtonGroup.group: languageSettingsGroup
                    checked: settings.value("language") == "de_DE" ?  true : false
                    onTriggered: {
                        settings.setValue("language", "de_DE");
                        changeLanguageDialog.open();
                    }
                }
            }
            Menu {
                title: qsTr("Theme")
                MenuItem {
                    text: qsTr("Light")
                    checkable: true
                    ButtonGroup.group: themeSettingsGroup
                    checked: helper.themeMode === "light"
                    onTriggered: {
                        helper.themeMode = "light";
                        settings.setValue("theme", "light");
                    }
                }
                MenuItem {
                    text: qsTr("Dark")
                    checkable: true
                    ButtonGroup.group: themeSettingsGroup
                    checked: helper.themeMode === "dark"
                    onTriggered: {
                        helper.themeMode = "dark";
                        settings.setValue("theme", "dark");
                    }
                }
            }
            Menu {
                title: qsTr("Font")
                MenuItem {
                    text: qsTr("Use System Font")
                    checkable: true
                    ButtonGroup.group: fontSettingsGroup
                    checked: settings.value("font", "system") == "system" ? true : false
                    onTriggered: {
                        helper.fontFamily = "";
                        settings.setValue("font", "system");
                    }
                }
                MenuItem {
                    text: qsTr("Droid Sans Fallback")
                    checkable: true
                    ButtonGroup.group: fontSettingsGroup
                    checked: settings.value("font") == localFont.name ? true : false
                    onTriggered: {
                        helper.fontFamily = localFont.name;
                        settings.setValue("font", localFont.name);
                    }
                }
            }
        }

        Menu {
            id: helpMenu
            title: qsTr("Help")
            MenuItem {
                text: qsTr("About")
                onTriggered: aboutDialog.open();
            }
            MenuItem {
                text: qsTr("About Qt")
                onTriggered: myClass.aboutQt();
            }
        }
    }


    Item {
        id: helper
        focus: false
        property string fontFamily: settings.value("font", "system") == "system" ? "" : settings.value("font", "system")
        property string themeMode: settings.value("theme", "light")
        onThemeModeChanged: MyScript.refreshTileColors()
        property var lightColors: {
            "bglight":  "#FAF8EF",
            "bggray":   Qt.rgba(238/255, 228/255, 218/255, 0.35),
            "bgdark":   "#BBADA0",
            "fglight":  "#EEE4DA",
            "fgdark":   "#776E62",
            "bgbutton": "#8F7A66",
            "bgbuttonHover": "#9E8B78",
            "bgbuttonPress": "#7A6858",
            "fgbutton": "#F9F6F2"
        }
        property var darkColors: {
            "bglight":  "#1A1714",
            "bggray":   Qt.rgba(255/255, 220/255, 180/255, 0.07),
            "bgdark":   "#252220",
            "fglight":  "#E8D5BC",
            "fgdark":   "#C4B49A",
            "bgbutton": "#7A6555",
            "bgbuttonHover": "#8A7464",
            "bgbuttonPress": "#675244",
            "fgbutton": "#F0E6D6"
        }
        property var myColors: themeMode === "dark" ? darkColors : lightColors
    }
    color: helper.myColors.bglight

    Item {
        width: 500
        height: 670
        anchors.centerIn: parent

        focus: true
        Keys.onPressed: function(event) { MyScript.moveKey(event) }

        MouseArea {
            anchors.fill: parent
            onClicked: parent.forceActiveFocus()
        }

        FontLoader { id: localFont; source: "qrc:///res/fonts/DroidSansFallback.ttf" }

        Text {
            id: gameName
            anchors.verticalCenter: scoreRow.verticalCenter
            font.family: helper.fontFamily
            font.pixelSize: 75
            font.bold: true
            text: "2048"
            color: helper.myColors.fgdark
        }

        Row {
            id: scoreRow
            anchors.right: parent.right
            spacing: 5
            Repeater {
                id: scoreBoard
                model: 2
                Rectangle {
                    width: (index == 0) ? 95 : 125
                    height: 55
                    radius: 8
                    color: helper.myColors.bgdark
                    property string scoreText: (index === 0) ? MyScript.score.toString() : MyScript.bestScore.toString()
                    Text {
                        text: (index == 0) ? qsTr("SCORE") : qsTr("BEST")
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: 6
                        font.family: helper.fontFamily
                        font.pixelSize: 13
                        color: helper.myColors.fglight
                    }
                    Text {
                        text: scoreText
                        anchors.horizontalCenter: parent.horizontalCenter
                        y: 22
                        font.family: helper.fontFamily
                        font.pixelSize: 25
                        font.bold: true
                        color: helper.myColors.fglight
                    }
                }
            }

            Text {
                id: addScoreText
                font.family: helper.fontFamily
                font.pixelSize: 25
                font.bold: true
                color: Qt.rgba(119/255, 110/255, 101/255, 0.9);
//                parent: scoreBoard.itemAt(0)
                anchors.horizontalCenter: parent.horizontalCenter

                property bool runAddScore: false
                property real yfrom: 0
                property real yto: -(parent.y + parent.height)
                property int addScoreAnimTime: 600

                ParallelAnimation {
                    id: addScoreAnim
                    running: false

                    NumberAnimation {
                        target: addScoreText
                        property: "y"
                        from: addScoreText.yfrom
                        to: addScoreText.yto
                        duration: addScoreText.addScoreAnimTime

                    }
                    NumberAnimation {
                        target: addScoreText
                        property: "opacity"
                        from: 1
                        to: 0
                        duration: addScoreText.addScoreAnimTime
                    }
                }
            }
        }

        Text {
            id: banner
            y: 90
            height: 40
            text: qsTr("Join the numbers and get to the <b>2048 tile</b>!")
            color: helper.myColors.fgdark
            font.family: helper.fontFamily
            font.pixelSize: 16
            verticalAlignment: Text.AlignVCenter
        }

        Button {
                id: newGameButton
                width: 129
                height: 40
                y: 90
                anchors.right: parent.right
                text: qsTr("New Game")
                onClicked: MyScript.startupFunction()
                background: Rectangle {
                        color: newGameButton.pressed ? helper.myColors.bgbuttonPress
                             : newGameButton.hovered ? helper.myColors.bgbuttonHover
                             : helper.myColors.bgbutton
                        radius: 8
                        Behavior on color { ColorAnimation { duration: 120 } }
                }
                contentItem: Text {
                        text: parent.text
                        color: helper.myColors.fgbutton
                        font.family: helper.fontFamily
                        font.pixelSize: 18
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                }
        }

        Rectangle {
            id: boardShadowSource
            y: 170
            width: 500
            height: 500
            radius: 20
            color: helper.myColors.bgdark
            visible: false
        }

        MultiEffect {
            source: boardShadowSource
            x: boardShadowSource.x
            y: boardShadowSource.y
            width: boardShadowSource.width
            height: boardShadowSource.height
            autoPaddingEnabled: true
            shadowEnabled: true
            shadowColor: helper.themeMode === "dark" ? Qt.rgba(0, 0, 0, 0.55) : Qt.rgba(0, 0, 0, 0.25)
            shadowVerticalOffset: 4
            shadowBlur: 0.7
        }

        Rectangle {
            y: 170
            width: 500
            height: 500
            color: helper.myColors.bgdark
            radius: 20

            Grid {
                x: 15;
                y: 15;
                rows: 4; columns: 4; spacing: 15

                Repeater {
                    id: cells
                    model: 16
                    Rectangle {
                        width: 425/4; height: 425/4
                        radius: 8
                        color: helper.myColors.bggray
                    }
                }
            }

            Item {
                id: tileGrid
                x: 15
                y: 15
                width: 425
                height: 425
            }

        }


        Dialog {
            id: demoWarningDialog
            title: qsTr("Demo Mode")
            modal: true
            anchors.centerIn: Overlay.overlay
            standardButtons: Dialog.Ok
            Label {
                text: qsTr("Running in demo mode.\nNo settings or scores will be saved.")
            }
        }

        Dialog {
            id: changeLanguageDialog
            title: qsTr("Language Setting Hint")
            modal: true
            anchors.centerIn: Overlay.overlay
            standardButtons: Dialog.Ok
            Label {
                text: qsTr("Please restart the program to make the language setting take effect.")
            }
        }

        Dialog {
            id: aboutDialog
            title: qsTr("About 2048-Qt")
            modal: true
            anchors.centerIn: Overlay.overlay
            standardButtons: Dialog.Ok
            Label {
                text: qsTr("2048-Qt\nVersion " + settings.getVersion() + "\n2015 Qiaoyong Zhong")
            }
        }

        Dialog {
            id: deadMessage
            modal: true
            anchors.centerIn: Overlay.overlay
            standardButtons: Dialog.Retry | Dialog.Abort
            Label {
                text: qsTr("Game Over!")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 24
                font.bold: true
            }
            onAccepted: MyScript.startupFunction()
            onRejected: MyScript.cleanUpAndQuit()
        }

        Dialog {
            id: winMessage
            modal: true
            anchors.centerIn: Overlay.overlay
            standardButtons: Dialog.Yes | Dialog.No
            Label {
                text: qsTr("You win! Continue playing?")
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: 24
                font.bold: true
            }
            onAccepted: { MyScript.checkTargetFlag = false; close() }
            onRejected: MyScript.startupFunction()
        }

    }

    Component.onCompleted: {
        if (demoMode) {
            MyScript.startupDemoFunction();
            demoWarningDialog.open();
        } else {
            MyScript.startupFunction();
        }
    }
}
