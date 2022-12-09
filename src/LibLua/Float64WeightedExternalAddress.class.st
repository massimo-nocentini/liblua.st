Class {
	#name : #Float64WeightedExternalAddress,
	#superclass : #WeightedExternalAddress,
	#category : #LibLua
}

{ #category : #'instance creation' }
Float64WeightedExternalAddress class >> allocate: size [

	^ (super allocate: size * Float64ByteSize)
		  size: size;
		  yourself
]

{ #category : #accessing }
Float64WeightedExternalAddress >> at: oneBasedOffset [

	^ externalAddress float64AtOffset:
		  oneBasedOffset - 1 * Float64ByteSize
]

{ #category : #accessing }
Float64WeightedExternalAddress >> at: oneBasedOffset put: aFloat64 [

	^ externalAddress
		  float64AtOffset: oneBasedOffset - 1 * Float64ByteSize
		  put: aFloat64
]
