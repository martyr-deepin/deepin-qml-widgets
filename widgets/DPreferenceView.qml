import QtQuick 2.1

Row {
	id: root
	width: 300
	height: 300

	property int sectionListWidth: 200
	property string currentSectionId

	onCurrentSectionIdChanged: {
		preference_content.scrollTo(currentSectionId)
	}

	DPreferenceSectionList {
		id: section_list
		width: root.sectionListWidth
        height: root.height
		sections: [
					  {
					    "sectionId": "id1",
					    "sectionName": "First",
					    "subSections": [
					    	{
					    	  "sectionId": "id2",
					    	  "sectionName": "Red",
					    	  "subSections": []
					    	},
					    	{
					    	  "sectionId": "id3",
					    	  "sectionName": "Blue",
					    	  "subSections": []
					    	}
					    ]
					  },
					  {
					    "sectionId": "id4",
					    "sectionName": "Yellow",
					    "subSections": []
					  },
					  {
					    "sectionId": "id5",
					    "sectionName": "Green",
					    "subSections": []
					  },
				]
	}

	DPreferenceSectionIndicator { id: section_indicator; height: root.height}

	Flickable {
		id: preference_content
	    width: root.width - section_list.width - section_indicator.width
	    height: root.height
	    contentWidth: col.childrenRect.width
	    contentHeight: col.childrenRect.height
	    flickableDirection: Flickable.VerticalFlick
	    
	    function scrollTo(sectionId) {
	    	var children = col.visibleChildren
	   		for (var i = 0; i < children.length; i++) {
	   			if (children[i].sectionId == sectionId) {
	   				contentY = children[i].y
	   			}
	   		}
	    }

	    onMovementEnded: {
	        root.currentSectionId = col.childAt(contentX, contentY).sectionId
	    }
	    
	    Column {
	        id: col
	        width: preference_content.width
            height: root.height
	        Rectangle {
	            color: "red"
	            width: 300
	            height: 300

	            property string sectionId: "id2"
	        }
	        Rectangle {
	            color: "blue"
	            width: 300
	            height: 300

	            property string sectionId: "id3"
	        }        
	        Rectangle {
	            color: "yellow"
	            width: 300
	            height: 300

	            property string sectionId: "id4"
	        }        
	        Rectangle {
	            color: "green"
	            width: 300
	            height: 300

	            property string sectionId: "id5"
	        }        
	    }
	}		
}