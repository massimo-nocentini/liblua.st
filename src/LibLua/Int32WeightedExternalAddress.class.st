Class {
	#name : #Int32WeightedExternalAddress,
	#superclass : #WeightedExternalAddress,
	#category : #LibLua
}

{ #category : #'instance creation' }
Int32WeightedExternalAddress class >> allocate: size [

	^ (super allocate: size * Int32ByteSize)
		  size: size;
		  yourself
]

{ #category : #accessing }
Int32WeightedExternalAddress >> at: oneBasedOffset [

	^ externalAddress int32AtOffset: oneBasedOffset - 1 * Int32ByteSize
]

{ #category : #accessing }
Int32WeightedExternalAddress >> at: oneBasedOffset put: anInt32 [

	^ externalAddress
		  int32AtOffset: oneBasedOffset - 1 * Int32ByteSize
		  put: anInt32
]
