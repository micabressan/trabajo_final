// C++

qmlRegisterUncreatableType<MyExampleClass>("MyExample", 1, 0, "MyExampleClass", "my uncreatable type error message");

// QML

import QtQuick 2.4
import QtQuick.Window 2.2
import MyExample 1.0

Window {
    visible: true
    property MyExampleClass asdf: null
}

// error message

qrc:/main.qml:5 my uncreatable type error message