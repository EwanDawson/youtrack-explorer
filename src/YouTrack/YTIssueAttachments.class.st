Class {
	#name : #YTIssueAttachments,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueAttachments >> items [
		^ data collect: [ :each |
		| resource |
		resource := YTIssueAttachment fromData: each.
		resource query: (self youtrack attachment: resource issueId).
		resource ]
]
