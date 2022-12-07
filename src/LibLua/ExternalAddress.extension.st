Extension { #name : #ExternalAddress }

{ #category : #'*LibLua' }
ExternalAddress class >> allocateFloat64Size: n [

	^ self allocate: n * ExternalType double byteSize
]

{ #category : #'*LibLua' }
ExternalAddress class >> allocateInt32Size: n [

	^ self allocate: n * ExternalType long byteSize
]

{ #category : #'*LibLua' }
ExternalAddress >> float64WeightedAt: oneBasedOffset [

	^ self float64AtOffset:
		  oneBasedOffset - 1 << 3"ExternalType double byteSize"
]

{ #category : #'*LibLua' }
ExternalAddress >> float64WeightedAt: oneBasedOffset put: value [

	^ self
		  float64AtOffset: oneBasedOffset - 1 << 3"ExternalType double byteSize"
		  put: value
]

{ #category : #'*LibLua' }
ExternalAddress >> int32WeightedAt: oneBasedOffset [

	^ self int32AtOffset: oneBasedOffset - 1 << 2"* ExternalType long byteSize"
]

{ #category : #'*LibLua' }
ExternalAddress >> int32WeightedAt: oneBasedOffset put: value [

	^ self
		  int32AtOffset: oneBasedOffset - 1 << 2"* ExternalType long byteSize"
		  put: value
]

{ #category : #'*LibLua' }
ExternalAddress >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushlightuserdata: state externalAddress: self
]
