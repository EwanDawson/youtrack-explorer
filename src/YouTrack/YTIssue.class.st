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
	^ attachments ifNil: [
		| attachmentsQuery |
		attachmentsQuery := self youtrack attachments: self id.
		attachmentsQuery transformation: self queryTransformation.
		attachments := attachmentsQuery resource ]
]

{ #category : #accessing }
YTIssue >> comments [
	^ comments ifNil: [ comments := (self youtrack comments: self id) resource ]
]

{ #category : #accessing }
YTIssue >> idReadable [
	^ self data at: 'idReadable' ifAbsent: nil
]

{ #category : #private }
YTIssue >> isMyAttachment: anObject [
	^ (anObject at: 'issue')
		ifNotNil: [ :issue | (issue at: 'id') = self id]
		ifNil: false
]

{ #category : #printing }
YTIssue >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: ((self includesField: 'idReadable') ifTrue: [ self idReadable ] ifFalse: [ self id ]);
		nextPut: $)
]

{ #category : #private }
YTIssue >> queryTransformation [
	^ [ :attachmentData | attachmentData select: [ :attachmentDatum | self isMyAttachment: attachmentDatum ] ]
]
