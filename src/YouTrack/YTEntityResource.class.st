Class {
	#name : #YTEntityResource,
	#superclass : #YTResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTEntityResource >> id [
	^ data at: 'id'
]
