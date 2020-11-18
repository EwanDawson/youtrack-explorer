Class {
	#name : #YTQuery,
	#superclass : #Object,
	#instVars : [
		'path',
		'resourceClass',
		'youtrack',
		'queryParams',
		'mandatoryFields',
		'fields'
	],
	#category : #'YouTrack-Client'
}

{ #category : #example }
YTQuery class >> deeplyNestedFieldQuery [
	<gtExample>
	| query |
	query := self new fields: {'name'. {'child'. { {'grandchild'. {'name'. 'status'} } } }. 'id'}.
	self assert: query fieldsString = 'name,child(grandchild(name,status)),id'.
	^ query
]

{ #category : #private }
YTQuery class >> fieldsQuery: aCollection [ 
	^ String streamContents: [ :stream |
		| specs |
		specs := Stack newFrom: aCollection.
		[ specs isEmpty ] whileFalse: [
			| spec |
			spec := specs pop.
			spec isArray
				ifTrue: [ stream
					nextPutAll: spec first;
					nextPut: $(;
					nextPutAll: (self fieldsQuery: spec second);
					nextPut: $) ]
				ifFalse: [ stream nextPutAll: spec ].
			specs isEmpty ifFalse: [ stream nextPut: $, ]]]
		
]

{ #category : #private }
YTQuery class >> fieldsValue: aCollection [ 
	^ String streamContents: [ :stream |
		| done |
		done := aCollection isEmpty.
		done whileFalse: [
			| fieldSpec |
			fieldSpec := aCollection pop.
			fieldSpec isCollection
				ifTrue: [ stream nextPutAll: fieldSpec first; nextPut: $(; nextPutAll: (self fieldsValue: fieldSpec second); nextPut: $) ]
				ifFalse: [ fieldSpec printOn: stream ].
			done := aCollection isEmpty.
			done ifFalse: [ stream nextPut: $, ]]]
		
]

{ #category : #'instance creation' }
YTQuery class >> for: youtrack path: aString resource: aYTResourceClass [
	^ self new
		youtrack: youtrack;
		path: aString;
		resourceClass: aYTResourceClass;
		yourself
]

{ #category : #example }
YTQuery class >> mandatoryFields [
	<gtExample>
	| query |
	query := self new mandatoryFields: { 'id' }; fields: { 'name' }; yourself.
	self assert: query fieldsString = 'name,id'.
	^ query
]

{ #category : #example }
YTQuery class >> mandatoryFields2 [
	<gtExample>
	| query |
	query := self new fields: { 'name' }; mandatoryFields: { 'id' }; yourself.
	self assert: query fieldsString = 'name,id'.
	^ query
]

{ #category : #example }
YTQuery class >> mutlipleFieldQuery [
	<gtExample>
	| query |
	query := self new fields: { 'name'. 'status'. 'id'}.
	self assert: query fieldsString = 'name,status,id'.
	^ query
]

{ #category : #example }
YTQuery class >> nestedFieldQuery [
	<gtExample>
	| query |
	query := self new fields: { 'name'. {'child'. {'name'. 'status'} }. 'id'}.
	self assert: query fieldsString = 'name,child(name,status),id'.
	^ query
]

{ #category : #example }
YTQuery class >> noFieldsQuery [
	<gtExample>
	| query |
	query := self new fields: Array empty.
	self assert: query fieldsString = nil.
	^ query
]

{ #category : #example }
YTQuery class >> singleFieldQuery [
	<gtExample>
	| query |
	query := self new fields: { 'name' }.
	self assert: query fieldsString = 'name'.
	^ query
]

{ #category : #private }
YTQuery >> addMandatoryFields [
	mandatoryFields do: [ :each | (fields includes: each) ifFalse: [ fields add: each ] ]
]

{ #category : #operation }
YTQuery >> execute [
	| client |
	client := youtrack clientForPath: path.
	self prepareClient: client.
	 ^ NeoJSONReader fromString: client get
]

{ #category : #accessing }
YTQuery >> fields [
	^ OrderedCollection newFrom: fields
]

{ #category : #accessing }
YTQuery >> fields: aCollection [
	fields := OrderedCollection newFrom: aCollection.
	self addMandatoryFields.
	self updateFieldsQueryParam
]

{ #category : #accessing }
YTQuery >> fieldsString [
	^ queryParams at: 'fields' ifAbsent: nil
]

{ #category : #testing }
YTQuery >> includesField: aString [
	^ fields includes: aString
]

{ #category : #initalize }
YTQuery >> initialize [
	queryParams := Dictionary new.
	fields := OrderedCollection new.
	mandatoryFields := OrderedCollection new.
]

{ #category : #accessing }
YTQuery >> mandatoryFields: aCollection [
	mandatoryFields := OrderedCollection newFrom: aCollection.
	self addMandatoryFields.
	self updateFieldsQueryParam
]

{ #category : #accessing }
YTQuery >> path: aString [
	path := $/ split: aString
]

{ #category : #operation }
YTQuery >> prepareClient: client [
	queryParams keysAndValuesDo: [ :key :value | client queryAt: key put: value ]
]

{ #category : #operation }
YTQuery >> resource [
	^ resourceClass fromQuery: self
]

{ #category : #accessing }
YTQuery >> resourceClass: aYTResourceClass [ 
	resourceClass := aYTResourceClass
]

{ #category : #accessing }
YTQuery >> skip: anInteger [
	self assert: anInteger >= 0.
	queryParams at: '$skip' put: anInteger
]

{ #category : #accessing }
YTQuery >> top: anInteger [
	self assert: anInteger > 0.
	queryParams at: '$top' put: anInteger.
]

{ #category : #private }
YTQuery >> updateFieldsQueryParam [
	fields isNotEmpty ifTrue: [
	queryParams at: 'fields' put: (self class fieldsQuery: fields) ]
]

{ #category : #accessing }
YTQuery >> youtrack [
	^ youtrack
]

{ #category : #accessing }
YTQuery >> youtrack: yt [
	youtrack := yt	
]
