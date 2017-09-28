import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

Flickable{
    anchors.fill: parent
    ScrollIndicator.vertical: ScrollIndicator { }
    contentHeight: mainText.height+50
    Text{

        id:mainText
        anchors.right: parent.right
        anchors.rightMargin: 10
        visible: (details!=null)
        verticalAlignment: Qt.AlignRight
        font.pointSize: 14
        wrapMode: Text.WordWrap
        text: (details==null)? " " :getDetails()


        function getDetails()
        {
            var out = "\n"+"نام کشور:"+details.name+"\n"+
                    "کد دوحرفی:"+details.alpha2Code+"\n"+
                    "کد شماره تلفن:"+details.callingCodes+"\n"+
                    "پایتخت:"+details.capital+"\n"+
                    "قاره:"+details.region+"\n"+
                    "منطقه قاره:"+details.subregion+"\n"+
                    "جمعیت:"+details.population+" نفر\n"+
                    "مساحت:"+details.area+"\n"+
                    "منطقه زمانی:"+details.timezones+"\n"+
                    "نام محلی:"+details.nativeName+"\n"+
                    "زبان ها:\n";
            for( var l in details.languages)
                out+= "نام زبان:"+details.languages[l].name+"\nنام محلی زبان:"+details.languages[l].nativeName+"\n\n";
            out+="کشورهای همسایه:\n";

            for( var bc in details.borders )
                out+=borderCountries[details.borders[bc]].name+"\n";


            return out;
        }
    }
}
