Class {
	#name : #YTIssueComments,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueComments >> items [
	^ data collect: [ :each |
		| resource |
		resource := YTIssueComment fromData: each.
		resource query: (self youtrack comments: resource issueId).
		resource ]	
]
