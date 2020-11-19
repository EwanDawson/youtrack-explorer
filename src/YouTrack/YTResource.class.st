Class {
	#name : #YTResource,
	#superclass : #Object,
	#instVars : [
		'data',
		'query'
	],
	#category : #'YouTrack-Resources'
}

{ #category : #'instance creation' }
YTResource class >> fromData: anObject [
	^ self new
		data: anObject;
		yourself
]

{ #category : #'instance creation' }
YTResource class >> fromQuery: aQuery [
	^ self new
		query: aQuery;
		refresh;
		yourself
]

{ #category : #accessing }
YTResource >> data [
	^ data
]

{ #category : #private }
YTResource >> data: anObject [ 
	data := anObject
]

{ #category : #accessing }
YTResource >> fields: aFieldSpec [
	| oldFieldSpec |
	oldFieldSpec := self query fields.
	self query fields: aFieldSpec.
	(self query fields flatten sort = oldFieldSpec flatten sort)
		ifFalse: [ self refresh ]
]

{ #category : #accessing }
YTResource >> query [
	^ query
]

{ #category : #private }
YTResource >> query: aQuery [ 
	query := aQuery
]

{ #category : #lifecycle }
YTResource >> refresh [
	query ifNotNil: [ self data: query execute ]
]

{ #category : #accessing }
YTResource >> youtrack [
	^ self query youtrack
]
