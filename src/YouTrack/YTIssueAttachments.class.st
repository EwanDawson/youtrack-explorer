Class {
	#name : #YTIssueAttachments,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueAttachments >> items [
	^ data collect: [ :each |
		| resource attachmentQuery |
		resource := YTIssueAttachment fromData: each.
		attachmentQuery := self youtrack attachments: resource issueId.
		attachmentQuery transformation: [ :attachmentData | attachmentData detect: [ :attachmentDatum | (attachmentDatum at: 'id') = resource id ]] .
		resource query: attachmentQuery.
		resource ]
]
