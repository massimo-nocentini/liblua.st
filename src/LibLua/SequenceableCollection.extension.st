Extension { #name : #SequenceableCollection }

{ #category : #'*LibLua' }
SequenceableCollection >> pushOnLua: state liblua: liblua [

	liblua lua_newtable: state.

	self withIndexDo: [ :each :index | 
		each pushOnLua: state liblua: liblua.
		liblua lua: state set: -2 i: index ].

	^ 1 "number of results"
]
