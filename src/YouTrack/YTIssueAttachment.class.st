"
TODO: I am only a YTEntityResource because I have an ID. If it turns out that being an Entity means more than that (e.g if all entities should be identified by a URL), then the #id method should be provided by a HasId trait, and I should consume that trait rather than subclass YTEntityResource.
"
Class {
	#name : #YTIssueAttachment,
	#superclass : #YTEntityResource,
	#traits : 'HasIssueId',
	#classTraits : 'HasIssueId classTrait',
	#category : #'YouTrack-Resources'
}

{ #category : #accessing }
YTIssueAttachment >> refresh [
	query ifNotNil: [
		(self data: query execute) detect: [ :attachment |
			attachment at: 'id' = self id] ]
]
