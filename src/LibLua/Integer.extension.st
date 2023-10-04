Extension { #name : 'Integer' }

{ #category : '*LibLua' }
Integer >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushinteger: state value: self
]
