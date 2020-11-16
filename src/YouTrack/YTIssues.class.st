Class {
	#name : #YTIssues,
	#superclass : #YTResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssues >> issues [
	^ data collect: [ :each |
		| issue |
		issue := YTIssue fromData: each.
		issue query: (self youtrack issue: (each at: 'id')).
		issue]
]
