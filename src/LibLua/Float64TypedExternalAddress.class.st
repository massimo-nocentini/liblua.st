"
I denote a C pointer to `double` memory locations.
"
Class {
	#name : 'Float64TypedExternalAddress',
	#superclass : 'TypedExternalAddress',
	#category : 'LibLua',
	#package : 'LibLua'
}

{ #category : 'instance creation' }
Float64TypedExternalAddress class >> allocate: size [

	^ (super allocate: size * Float64ByteSize)
		  size: size;
		  yourself
]

{ #category : 'accessing' }
Float64TypedExternalAddress >> at: oneBasedOffset [

	^ externalAddress float64AtOffset:
		  oneBasedOffset - 1 * Float64ByteSize
]

{ #category : 'accessing' }
Float64TypedExternalAddress >> at: oneBasedOffset put: aFloat64 [

	^ externalAddress
		  float64AtOffset: oneBasedOffset - 1 * Float64ByteSize
		  put: aFloat64
]
