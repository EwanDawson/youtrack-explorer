Class {
	#name : #YTIssue,
	#superclass : #YTEntityResource,
	#instVars : [
		'attachments',
		'comments'
	],
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssue >> attachments [
	^ attachments ifNil: [ attachments := (self youtrack attachments: self id) resource ]
]

{ #category : #accessing }
YTIssue >> comments [
	^ comments ifNil: [ comments := (self youtrack comments: self id) resource ]
]

{ #category : #accessing }
YTIssue >> idReadable [
	^ self data at: 'idReadable' ifAbsent: nil
]

{ #category : #printing }
YTIssue >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: ((self includesField: 'idReadable') ifTrue: [ self idReadable ] ifFalse: [ self id ]);
		nextPut: $)
]
