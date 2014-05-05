// Notice: this file is not intend to be used separately,
// there must be a item called `root' which has a property named `currentSectionId'
// and accessable from this scope to work properly.
import QtQuick 2.1

ListView {
	id: playlist
	width: 300
	height: childrenRect.height

	property var sections

	model: ListModel {
		Component.onCompleted: {
			var sections = playlist.sections || []
			for (var i = 0; i < sections.length; i++) {
				append(sections[i])
			}
		}
	}
	delegate: Component {
		Column {
			id: main_column
			state: "normal"
			width: ListView.view.width

			states: [
				State {
					name: "normal"
					PropertyChanges {
						target: txt
						color: "red"
					}
					PropertyChanges {
						target: sub
						visible: false
					}
				},
				State {
					name: "selected"
					PropertyChanges {
						target: txt
						color: isParent ? "red" : "green"
					}
					PropertyChanges {
						target: sub
						visible: isParent ? true : false
					}
				}
			]

			property bool isParent: subSections.count != 0

			Connections {
				target: root

				onCurrentSectionIdChanged: {
					if (sectionId == root.currentSectionId) {
						main_column.state = "selected"
					} else if (!main_column.isParent) {
						main_column.state = "normal"
					}
				}
			}

			Item {
				width: main_column.width
				height: 24

				Text {
					id: txt
					text: sectionName
					font.pixelSize: 14

					anchors.verticalCenter: parent.verticalCenter
				}

				MouseArea {
					id: main_column_mouse
					anchors.fill: parent

					onClicked: {
						root.currentSectionId = sectionId
					}
				}
			}

			Loader {
				id: sub
				x: 10
				active: main_column.isParent
				source: "DPreferenceSectionList.qml"
				asynchronous: true
				onLoaded: {
					item.model = subSections
				}
			}
		}
	}
}