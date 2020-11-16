Class {
	#name : #YTEntityResource,
	#superclass : #YTObjectResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTEntityResource >> id [
	^ data at: 'id'
]
