Class {
	#name : #YTArrayResource,
	#superclass : #YTResource,
	#category : #'YouTrack-Resources'
}

{ #category : #'instance creation' }
YTArrayResource class >> fromData: anObject [
	self assert: anObject isArray.
	^ super fromData: anObject
]

{ #category : #accessing }
YTArrayResource >> items [
	^ self subclassResponsibility
]
