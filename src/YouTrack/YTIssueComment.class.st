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
	^ attachments ifNil: [
		| attachmentsQuery |
		attachmentsQuery := self youtrack attachments: self issueId.
		attachmentsQuery transformation: self queryTransformation.
		attachments := attachmentsQuery resource ]
]

{ #category : #private }
YTIssueComment >> isMyAttachment: anObject [
	^ (anObject at: 'comment')
		ifNotNil: [ :comment | (comment at: 'id') = self id]
		ifNil: false
]

{ #category : #private }
YTIssueComment >> queryTransformation [
	^ [ :attachmentData | attachmentData select: [ :attachmentDatum | self isMyAttachment: attachmentDatum ] ]
]
