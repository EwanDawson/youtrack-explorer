Class {
	#name : #YTIssueComment,
	#superclass : #YTEntityResource,
	#traits : 'HasIssueId',
	#classTraits : 'HasIssueId classTrait',
	#instVars : [
		'attachments'
	],
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueComment >> attachments [
	^ attachments ifNil: [ attachments := (self youtrack commentAttachments: self issueId) resource ]
]

{ #category : #accessing }
YTIssueComment >> refresh [
	query ifNotNil: [
		(self data: query execute) detect: [ :comment |
			comment at: 'id' = self id] ]
]
