Class {
	#name : #WeightedExternalAddress,
	#superclass : #Object,
	#instVars : [
		'externalAddress',
		'size'
	],
	#classVars : [
		'Float64ByteSize',
		'Int32ByteSize'
	],
	#category : #LibLua
}

{ #category : #'instance creation' }
WeightedExternalAddress class >> allocate: size [

	^ self new
		  externalAddress: (ExternalAddress allocate: size);
		  yourself
]

{ #category : #'instance creation' }
WeightedExternalAddress class >> fromSequenceableCollection: anArray [

	| addr |
	addr := self allocate: anArray.

	anArray withIndexDo: [ :each :i | addr at: i put: each ].

	^ addr
]

{ #category : #initialization }
WeightedExternalAddress class >> initialize [

	Int32ByteSize := ExternalType long byteSize.
	Float64ByteSize := ExternalType double byteSize
]

{ #category : #accessing }
WeightedExternalAddress >> at: index [

	self subclassResponsibility
]

{ #category : #accessing }
WeightedExternalAddress >> at: index put: value [

	self subclassResponsibility
]

{ #category : #accessing }
WeightedExternalAddress >> externalAddress: anObject [

	externalAddress := anObject
]

{ #category : #'initialize-release' }
WeightedExternalAddress >> free [

	^ externalAddress free
]

{ #category : #dispatched }
WeightedExternalAddress >> intoSequenceableCollection: anArray [

	self assert: size <= anArray size.

	1 to: size do: [ :i | anArray at: i put: (self at: i) ]
]

{ #category : #dispatched }
WeightedExternalAddress >> pushOnLua: state liblua: liblua [

	^ externalAddress pushOnLua: state liblua: liblua
]

{ #category : #accessing }
WeightedExternalAddress >> size: anObject [

	size := anObject
]
