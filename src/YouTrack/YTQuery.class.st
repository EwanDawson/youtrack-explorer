Class {
	#name : #YTQuery,
	#superclass : #Object,
	#instVars : [
		'path',
		'resourceClass',
		'youtrack',
		'queryParams'
	],
	#category : #'YouTrack-Client'
}

{ #category : #'instance creation' }
YTQuery class >> for: youtrack path: aString resource: aYTResourceClass [
	^ self new
		youtrack: youtrack;
		path: aString;
		resourceClass: aYTResourceClass;
		yourself
]

{ #category : #operation }
YTQuery >> execute [
	| client |
	client := youtrack clientForPath: path.
	self prepareClient: client.
	 ^ NeoJSONReader fromString: client get
]

{ #category : #initalize }
YTQuery >> initialize [
	queryParams := Dictionary new
]

{ #category : #accessing }
YTQuery >> path: aString [
	path := $/ split: aString
]

{ #category : #operation }
YTQuery >> prepareClient: client [
	queryParams keysAndValuesDo: [ :key :value | client queryAt: key put: value ]
]

{ #category : #operation }
YTQuery >> resource [
	^ resourceClass fromQuery: self
]

{ #category : #accessing }
YTQuery >> resourceClass: aYTResourceClass [ 
	resourceClass := aYTResourceClass
]

{ #category : #accessing }
YTQuery >> skip: anInteger [
	self assert: anInteger >= 0.
	queryParams at: '$skip' put: anInteger
]

{ #category : #accessing }
YTQuery >> top: anInteger [
	self assert: anInteger > 0.
	queryParams at: '$top' put: anInteger.
]

{ #category : #accessing }
YTQuery >> youtrack [
	^ youtrack
]

{ #category : #accessing }
YTQuery >> youtrack: yt [
	youtrack := yt	
]
