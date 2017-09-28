import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0
import MyApp.MyModule 1.0

ApplicationWindow
{
    id:mainWindow
    width: 360
    height: 520
    visible: true

    MyClass{
        id:countryRequester
        onDataRecived:{
            var countries = JSON.parse(data);
            burgerButton.visible= true;

            countryComponent.borderCountries = {};
            for( var i=0; i<countries.length; i++)
                countryComponent.borderCountries[ countries[i].alpha3Code ] = countries[i];
            country_list.model=countries;
        }
    }

    Component.onCompleted: {
        countryRequester.get("https://restcountries.eu/rest/v2/all");
    }


    header: ToolBar{


        RowLayout{
            anchors.fill: parent
            spacing: 20
            layoutDirection: Qt.RightToLeft

            ToolButton{
                id:burgerButton
                visible: false
                contentItem: Image{
                    source: "qrc:/images/drawer.png"
                    fillMode: Image.Pad
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment:  Qt.AlignHCenter
                }
                onClicked: drawer.open()
            }
            Text{
                text:"کشور ها"
                color: "white"
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                font.bold: true
                font.pixelSize: 20
            }
            Item{
                Layout.fillWidth: true
            }

            ToolButton{
                id:backbutton
                visible: false
                contentItem: Image{
                    source: "qrc:/images/arrow_back.png"
                    verticalAlignment: Qt.AlignVCenter
                    horizontalAlignment:  Qt.AlignLeft
                }
                onClicked:{
                    burgerButton.visible=true;
                    backbutton.visible=false;
                    stackview.pop()
                }
            }
        }
    }

    Popup{
        id:aboutPopUp
        x: (parent.width - width) / 2
        y: (parent.height - height) / 2
        modal: true
        focus: true

        ColumnLayout{
            Label{
                text:"امیر علیزاده هستم!\n"+
                     "در این برنامه از \n"+
                     "Qt \n"+
                     "استفاده شده است\n"+
                     "وب سرویس کشورها\n"+
                     "Rest Countries\n"+
                     "صرفا جهت سرگرمی ساخته شده :D"
            }
            Button{
                text: "Qt"
                anchors.right : parent.right
                onClicked: Qt.openUrlExternally("https://www.qt.io/")
            }
            Button{
                text: "Rest Countries"
                anchors.right: parent.right
                onClicked: Qt.openUrlExternally("https://restcountries.eu")
            }
            Button{
                text: "باشه"
                anchors.right: parent.right
                onClicked: aboutPopUp.close()
            }
        }
    }

    Drawer{
        id: drawer
        width: Math.min(mainWindow.width, mainWindow.height) / 3 * 2
        height: mainWindow.height

        edge: Qt.RightEdge

        ListView{
            anchors.fill: parent

            model:ListModel {
                ListElement {
                    name: "بروزرسانی لیست"
                    itemid: 1
                }
                ListElement {
                    name: "درباره ی سازنده"
                    itemid: 2
                }
            }
            delegate: ItemDelegate{
                text: model.name
                width: parent.width
                onClicked: {
                    drawer.close();
                    if( model.itemid == 1)
                    {
                        burgerButton.visible= false;
                        countryRequester.get("https://restcountries.eu/rest/v2/all");
                    }

                    if( model.itemid == 2)
                        aboutPopUp.open();
                }
            }
            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }


    StackView{
        id:stackview
        anchors.fill: parent

        initialItem: ListView{
            id: country_list

            model:ListModel {

            }
            delegate: ItemDelegate{
                text: modelData.name
                width: parent.width
                onClicked: {
                    burgerButton.visible=false;
                    backbutton.visible=true;
                    countryComponent.details = modelData;
                    stackview.push(countryComponent);
                }
            }
            ScrollIndicator.vertical: ScrollIndicator {  }
        }
    }


    Loader{
        id:countryComponent
        property var details: null
        property var borderCountries: null
        source: "qrc:country.qml"
    }



    Rectangle{
        visible: countryRequester.isLoading
        anchors.fill: parent
        color: "white"
        BusyIndicator{
            anchors.centerIn: parent
            width: Math.min(parent.width,parent.width)/4
            height: Math.min(parent.width,parent.width)/4

        }
    }

}
