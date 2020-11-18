Class {
	#name : #YouTrack,
	#superclass : #Object,
	#instVars : [
		'client',
		'host',
		'token'
	],
	#category : #'YouTrack-Client'
}

{ #category : #'instance creation' }
YouTrack class >> host: aHostString token: aTokenString [
	^ self new
		host: aHostString;
		token: aTokenString;
		yourself 
]

{ #category : #accessing }
YouTrack >> attachments: anIssueId [
	| query |
	query := YTQuery for: self path: 'issues/', anIssueId, '/attachments' resource: YTIssueAttachments.
	query mandatoryFields: { 'id'. {'issue'. {'id'} } }.
	^ query
]

{ #category : #accessing }
YouTrack >> clientForPath: pathSegments [
	self resetClient.
	client addPath: pathSegments.
	^ client
]

{ #category : #accessing }
YouTrack >> comments: anIssueId [
	| query |
	query := YTQuery for: self path: 'issues/', anIssueId, '/comments' resource: YTIssueComments.
	query mandatoryFields: { 'id'. {'issue'. {'id'} } }.
	^ query
]

{ #category : #accessing }
YouTrack >> host: aHostString [ 
	host := aHostString
]

{ #category : #initialization }
YouTrack >> initialize [
	client := ZnClient new.
	self resetClient
]

{ #category : #accessing }
YouTrack >> issue: anId [
	^ YTQuery for: self path: 'issues/', anId resource: YTIssue
]

{ #category : #accessing }
YouTrack >> issues [
	| query |
	query := YTQuery for: self path: 'issues' resource: YTIssues.
	query mandatoryFields: { 'id' }.
	^ query
]

{ #category : #accessing }
YouTrack >> printOn: aStream [
	super printOn: aStream.
	aStream nextPutAll: ' client for '.
	host ifNotNil: [ :it | it printOn: aStream ] ifNil: [ aStream nextPutAll: '<uninitialized>']
]

{ #category : #accessing }
YouTrack >> resetClient [
	client
		systemPolicy;
		accept: ZnMimeType applicationJson;
		https;
		path: 'youtrack/api'.
	host ifNotNil: [ :it | client host: it ].
	token ifNotNil: [ :it | client request setAuthorization: 'Bearer ', it ]
]

{ #category : #accessing }
YouTrack >> token: aTokenString [ 
	token := aTokenString
]

{ #category : #accessing }
YouTrack >> users [
	self resetClient.
	client addPath: { 'admin'. 'users' }. 
	^ YTUsers fromData: (NeoJSONReader fromString: client get)
]
