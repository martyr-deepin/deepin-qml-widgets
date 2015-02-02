import QtQuick 2.1
import Deepin.Widgets 1.0

DFileChooseDialog {
	currentFolder:"/home/match/"
	onSelectAction:{
		print ("File name:",fileUrl)
		Qt.quit()
	}
}
