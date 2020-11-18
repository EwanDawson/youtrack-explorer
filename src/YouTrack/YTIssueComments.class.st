Class {
	#name : #YTIssueComments,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueComments >> items [
	^ data collect: [ :each |
		| resource commentQuery |
		resource := YTIssueComment fromData: each.
		commentQuery := self youtrack comments: resource issueId.
		commentQuery transformation: [ :commentData | commentData detect: [ :commentDatum | (commentDatum at: 'id') = resource id ]] .
		resource query: commentQuery.
		resource ]	
]
