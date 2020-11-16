Class {
	#name : #YTIssueComment,
	#superclass : #YTObjectResource,
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
