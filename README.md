# Deepin QML Widgets

**Description**:  This project is an extension of QML, it provides widgets designed for use in apps built for Deepin OS.


## Dependencies

- qt5-qmake
- qt5-default
- qtdeclarative5-dev
- libqt5webkit5-dev
- libqt5x11extras5-dev
- libqt5opengl5-dev
- pkg-config
- libxcomposite-dev
- libxcb-damage0-dev
- libgtk2.0-dev
- deepin-gettext-tools

## Installation

> mkdir build; cd build
> qmake ..
> make; make install 

## Usage

**Example**
~~~QML
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
~~~
To see all the widgets that are provided, please refer to [qmldir](widgets/qmldir) and [examples](examples);

## Getting involved

We encourage you to report issues and contribute changes. Please check out the [Contribution Guidelines](http://wiki.deepin.org/index.php?title=Contribution_Guidelines) about how to proceed.

## License

GNU General Public License, Version 3.0