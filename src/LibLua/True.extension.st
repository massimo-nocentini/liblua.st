Extension { #name : #True }

{ #category : #'*LibLua' }
True >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushboolean: state value: 1
]
