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
WeightedExternalAddress >> pushOnLua: state liblua: liblua [

	^ liblua
		  lua_pushlightuserdata: state
		  externalAddress: externalAddress
]

{ #category : #accessing }
WeightedExternalAddress >> size: anObject [

	size := anObject
]
