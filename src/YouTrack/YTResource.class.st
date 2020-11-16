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

{ #category : #private }
YTResource >> data: anObject [ 
	data := anObject
]

{ #category : #private }
YTResource >> query: aQuery [ 
	query := aQuery
]

{ #category : #lifecycle }
YTResource >> refresh [
	query ifNotNil: [ self data: query execute ]
]
