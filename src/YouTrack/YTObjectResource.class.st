Class {
	#name : #YTObjectResource,
	#superclass : #YTResource,
	#category : #'YouTrack-Resources'
}

{ #category : #'instance creation' }
YTObjectResource class >> fromData: anObject [
	self assert: (anObject at: '$type') = self type.
	^ super fromData: anObject
]

{ #category : #accessing }
YTObjectResource class >> type [
	^ self subclassResponsibility
]
