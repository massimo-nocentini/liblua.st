Extension { #name : #SequenceableCollection }

{ #category : #'*LibLua' }
SequenceableCollection >> asFloat64ExternalAddress [

	^ Float64WeightedExternalAddress fromSequenceableCollection: self
]

{ #category : #'*LibLua' }
SequenceableCollection >> asInt32ExternalAddress [

	^ Int32WeightedExternalAddress fromSequenceableCollection: self
]

{ #category : #'*LibLua' }
SequenceableCollection >> pushOnLua: state liblua: liblua [

	liblua lua_newtable: state.

	self withIndexDo: [ :each :index | 
		each pushOnLua: state liblua: liblua.
		liblua lua: state set: -2 i: index ].

	^ 1 "number of results"
]

{ #category : #'*LibLua' }
SequenceableCollection >> withExternalAddressClass: aClass do: aBlock [

	| ea |
	ea := aClass fromSequenceableCollection: self.
	aBlock value: ea.
	ea intoSequenceableCollection: self.
	ea free
]
