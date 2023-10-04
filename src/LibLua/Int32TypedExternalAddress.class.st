"
I denote a C pointer to `int` memory locations.
"
Class {
	#name : 'Int32TypedExternalAddress',
	#superclass : 'TypedExternalAddress',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'instance creation' }
Int32TypedExternalAddress class >> allocate: size [

	^ (super allocate: size * Int32ByteSize)
		  size: size;
		  yourself
]

{ #category : 'accessing' }
Int32TypedExternalAddress >> at: oneBasedOffset [

	^ externalAddress int32AtOffset: oneBasedOffset - 1 * Int32ByteSize
]

{ #category : 'accessing' }
Int32TypedExternalAddress >> at: oneBasedOffset put: anInt32 [

	^ externalAddress
		  int32AtOffset: oneBasedOffset - 1 * Int32ByteSize
		  put: anInt32
]
