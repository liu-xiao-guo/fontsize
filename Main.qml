import QtQuick 2.4
import Ubuntu.Components 1.3

/*!
    \brief MainView with a Label and Button elements.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "fontsize.liu-xiao-guo"

    width: units.gu(60)
    height: units.gu(85)

    property string fontsize: listview.currentItem.fontsize

    Page {
        title: i18n.tr("fontsize")


        Component {
            id: highlightBar
            Rectangle {
                width: 200; height: 50
                color: "#FFFF88"
                y: listview.currentItem.y;
                Behavior on y { SpringAnimation { spring: 2; damping: 0.1 } }
            }
        }

        Column {
            anchors.fill: parent
            spacing: units.gu(2)

            Text {
                id: unitsgu
                text: "1 units.gu = " + units.gu(1) + " pixels"
            }

            Row {
                spacing: units.gu(1)
                Text {
                    id: mytext
                    text: "我爱你！"
                    font.pixelSize: (FontUtils.sizeToPixels(fontsize)).toFixed(2)
                }

                Text {
                    text: mytext.font.pixelSize + " pixels"
                }

                Text {
                    text: (mytext.font.pixelSize/units.gu(1)).toFixed(2) + " units.gu"
                }
            }

            Row {
                spacing: units.gu(1)

                Label {
                    id: mylabel
                    text: "我也爱你！"
                    fontSize: fontsize
                }

                Text {
                    text: mylabel.fontSize
                }

                Text {
                    text: (FontUtils.sizeToPixels(mylabel.fontSize)).toFixed(2) + " pixels"
                }

                Text {
                    text: (mytext.font.pixelSize/units.gu(1)).toFixed(2)+ " units.gu"
                }
            }

            ListView {
                id: listview
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width
                height: parent.height - mytext.height
                highlight: highlightBar
                model: ["xx-small","x-small", "small", "medium", "large", "x-large" ]
                delegate: Text {
                    property string fontsize: modelData

                    text: modelData + " " + (FontUtils.modularScale(modelData)).toFixed(2)
                    font.pixelSize: units.gu(5)

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            listview.currentIndex = index
                        }
                    }
                }
            }
        }

    }
}

