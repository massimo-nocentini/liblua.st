Extension { #name : #False }

{ #category : #'*LibLua' }
False >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushboolean: state value: 0
]
