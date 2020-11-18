Class {
	#name : #YTIssues,
	#superclass : #YTArrayResource,
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssues >> items [
	| fields issueQuery |
	^ data collect: [ :each |
		| resource |
		fields := self query fields.
		issueQuery := self youtrack issue: (each at: 'id').
		issueQuery fields: fields.
		resource := YTIssue fromData: each.
		resource query: issueQuery.
		resource ]
]
