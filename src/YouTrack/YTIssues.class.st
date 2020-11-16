Class {
	#name : #YTIssues,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssues >> items [
	^ data collect: [ :each |
		| resource |
		resource := YTIssue fromData: each.
		resource query: (self youtrack issue: resource id).
		resource ]
]
