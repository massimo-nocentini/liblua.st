Extension { #name : 'UndefinedObject' }

{ #category : '*LibLua' }
UndefinedObject >> pushOnLua: state liblua: liblua [

	^ liblua lua_pushnil: state
]
