"
I am an ""abstract"" and ""typed"" `ExternalAddress`.
"
Class {
	#name : #TypedExternalAddress,
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
TypedExternalAddress class >> allocate: size [

	^ self new
		  externalAddress: (ExternalAddress allocate: size);
		  yourself
]

{ #category : #'instance creation' }
TypedExternalAddress class >> fromSequenceableCollection: anArray [

	| addr |
	addr := self allocate: anArray.

	anArray withIndexDo: [ :each :i | addr at: i put: each ].

	^ addr
]

{ #category : #initialization }
TypedExternalAddress class >> initialize [

	Int32ByteSize := ExternalType long byteSize.
	Float64ByteSize := ExternalType double byteSize
]

{ #category : #accessing }
TypedExternalAddress >> at: index [

	self subclassResponsibility
]

{ #category : #accessing }
TypedExternalAddress >> at: index put: value [

	self subclassResponsibility
]

{ #category : #accessing }
TypedExternalAddress >> externalAddress: anObject [

	externalAddress := anObject
]

{ #category : #'initialize-release' }
TypedExternalAddress >> free [

	^ externalAddress free
]

{ #category : #dispatched }
TypedExternalAddress >> intoSequenceableCollection: anArray [

	self assert: size <= anArray size.

	1 to: size do: [ :i | anArray at: i put: (self at: i) ]
]

{ #category : #dispatched }
TypedExternalAddress >> pushOnLua: state liblua: liblua [

	^ externalAddress pushOnLua: state liblua: liblua
]

{ #category : #accessing }
TypedExternalAddress >> size: anObject [

	size := anObject
]
