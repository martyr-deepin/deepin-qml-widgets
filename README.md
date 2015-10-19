# Deepin QML Widgets

**Description**:  This project extends QML by providing widgets that is used by Deepin applications.


## Dependencies

### Build Dependencies

- Qt5.3 or above
- Qt modules
    - gui
    - widgets
    - qml
    - quick
    - webkit
    - x11extras
- pkgconfig
- xcb
- xcomposite
- xcb-damage
- gtk+-2.0
- deepin-gettext-tools

### Runtime Dependencies

- DBus

## Installation

```
mkdir build; cd build
qmake ..
make; make install
```

## Usage

**Example**
```QML
import QtQuick 2.0
import Deepin.Widgets 1.0

DDialog {
   width: 300
   height: 300
   title: "Deepin QML Widgets"

   DssH2 {
        text: "Hello World!"
        anchors.centerIn: parent
   }
}
```
To see all the widgets that are provided, please refer to [qmldir](widgets/qmldir) and [examples](examples);

## Getting help

Any usage issues can ask for help via

* [Gitter](https://gitter.im/orgs/linuxdeepin/rooms)
* [IRC channel](https://webchat.freenode.net/?channels=deepin)
* [Forum](https://bbs.deepin.org)
* [WiKi](http://wiki.deepin.org/)

## Getting involved

We encourage you to report issues and contribute changes
[Contirubtion guide for users](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Users)
[Contribution guide for developers](http://wiki.deepin.org/index.php?title=Contribution_Guidelines_for_Developers).

## License

Deepin QML Widgets is licensed under [GPLv3](LICENSE).
