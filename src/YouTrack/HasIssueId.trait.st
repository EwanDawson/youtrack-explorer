Trait {
	#name : #HasIssueId,
	#category : #'YouTrack-Resources'
}

{ #category : #trait }
HasIssueId >> issueId [
	^ self data at: 'issue' at: 'id'
]
